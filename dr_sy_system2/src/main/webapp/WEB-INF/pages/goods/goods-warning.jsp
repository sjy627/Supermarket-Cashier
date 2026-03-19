<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
  
  <head>
    <meta charset="UTF-8">
    <title>库存预警与补货提醒</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="/static/css/font.css">
    <link rel="stylesheet" href="/static/css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="/static/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="/static/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  
  <body>
    <div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">商品管理</a>
        <a>
          <cite>库存预警与补货提醒</cite></a>
      </span>
      <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
    </div>
    <div class="x-body">
      <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
          <div class="layui-card">
            <div class="layui-card-header">库存统计</div>
            <div class="layui-card-body">
              <div class="layui-row layui-col-space10 layui-col-md12">
                <div class="layui-col-md3">
                  <div class="grid-demo grid-bg-green">
                    <h3 style="text-align:center;margin-top:20px;">商品总数</h3>
                    <p style="text-align:center;font-size:36px;color:#009688;" id="totalGoods">-</p>
                  </div>
                </div>
                <div class="layui-col-md3">
                  <div class="grid-demo grid-bg-blue">
                    <h3 style="text-align:center;margin-top:20px;">正常库存</h3>
                    <p style="text-align:center;font-size:36px;color:#1E9FFF;" id="normalCount">-</p>
                  </div>
                </div>
                <div class="layui-col-md3">
                  <div class="grid-demo grid-bg-orange">
                    <h3 style="text-align:center;margin-top:20px;">库存预警</h3>
                    <p style="text-align:center;font-size:36px;color:#FF5722;" id="lowStockCount">-</p>
                  </div>
                </div>
                <div class="layui-col-md3">
                  <div class="grid-demo grid-bg-red">
                    <h3 style="text-align:center;margin-top:20px;">需要补货</h3>
                    <p style="text-align:center;font-size:36px;color:#FFB800;" id="reorderCount">-</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <xblock>
        <button class="layui-btn layui-btn-normal" onclick="loadData()"><i class="layui-icon">&#xe666;</i>刷新数据</button>
        <span class="x-right" style="line-height:40px">库存预警与补货提醒</span>
      </xblock>

      <div class="layui-card">
        <div class="layui-card-header">
          <i class="layui-icon">&#xe6b9;</i>库存预警商品（库存低于预警阈值）
        </div>
        <div class="layui-card-body">
          <table class="layui-table" lay-skin="line">
            <thead>
              <tr>
                <th>商品编号</th>
                <th>商品名称</th>
                <th>当前库存</th>
                <th>预警阈值</th>
                <th>补货点</th>
                <th>状态</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody id="lowStockTable">
              <tr>
                <td colspan="7" style="text-align:center;">加载中...</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <div class="layui-card" style="margin-top:15px;">
        <div class="layui-card-header">
          <i class="layui-icon">&#xe657;</i>需要补货的商品（库存低于补货点）
        </div>
        <div class="layui-card-body">
          <table class="layui-table" lay-skin="line">
            <thead>
              <tr>
                <th>商品编号</th>
                <th>商品名称</th>
                <th>当前库存</th>
                <th>预警阈值</th>
                <th>补货点</th>
                <th>缺少数量</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody id="reorderTable">
              <tr>
                <td colspan="7" style="text-align:center;">加载中...</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <div class="layui-card" style="margin-top:15px;">
        <div class="layui-card-header">
          <i class="layui-icon">&#xe620;</i>设置商品预警阈值
        </div>
        <div class="layui-card-body">
          <form class="layui-form layui-form-pane" lay-filter="stockForm">
            <div class="layui-form-item">
              <div class="layui-inline">
                <label class="layui-form-label">商品编号</label>
                <div class="layui-input-inline">
                  <input type="text" name="gNo" id="goodsNo" placeholder="请输入商品编号" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-inline">
                <label class="layui-form-label">预警阈值</label>
                <div class="layui-input-inline">
                  <input type="number" name="stockWarningThreshold" placeholder="低于此数量预警" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-inline">
                <label class="layui-form-label">补货点</label>
                <div class="layui-input-inline">
                  <input type="number" name="stockReorderPoint" placeholder="需要补货的数量" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-inline">
                <label class="layui-form-label">库存数量</label>
                <div class="layui-input-inline">
                  <input type="number" name="gCount" placeholder="当前库存" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-inline">
                <button class="layui-btn" lay-submit lay-filter="updateStock">保存设置</button>
              </div>
            </div>
          </form>
        </div>
      </div>

    </div>
    <script>
      layui.use(['form', 'layer'], function(){
        var form = layui.form;
        var layer = layui.layer;

        loadData();

        form.on('submit(updateStock)', function(data){
          var goods = data.field;
          if(!goods.gNo) {
            layer.msg('请输入商品编号', {icon: 2});
            return false;
          }
          
          $.ajax({
            type: "post",
            url: "${pageContext.request.contextPath}/goods/updateStock",
            data: goods,
            dataType: "json",
            success: function(res) {
              if(res.code === 200) {
                layer.msg('保存成功', {icon: 1});
                loadData();
                document.getElementById('goodsNo').value = '';
                document.querySelector('input[name="stockWarningThreshold"]').value = '';
                document.querySelector('input[name="stockReorderPoint"]').value = '';
                document.querySelector('input[name="gCount"]').value = '';
              } else {
                layer.msg(res.msg || '保存失败', {icon: 2});
              }
            }
          });
          return false;
        });
      });

      function loadData() {
        loadStats();
        loadLowStock();
        loadReorder();
      }

      function loadStats() {
        $.ajax({
          type: "get",
          url: "${pageContext.request.contextPath}/goods/stockWarningStats",
          dataType: "json",
          success: function(res) {
            if(res.code === 200) {
              var data = res.data;
              document.getElementById('totalGoods').innerText = data.totalGoods || 0;
              document.getElementById('normalCount').innerText = data.normalCount || 0;
              document.getElementById('lowStockCount').innerText = data.lowStockCount || 0;
              document.getElementById('reorderCount').innerText = data.reorderCount || 0;
            }
          }
        });
      }

      function loadLowStock() {
        $.ajax({
          type: "get",
          url: "${pageContext.request.contextPath}/goods/lowStock",
          dataType: "json",
          success: function(res) {
            var tbody = document.getElementById('lowStockTable');
            if(res.code === 200 && res.data && res.data.length > 0) {
              var html = '';
              res.data.forEach(function(item) {
                html += '<tr>';
                html += '<td>' + item.gNo + '</td>';
                html += '<td>' + item.gName + '</td>';
                html += '<td style="color:#FF5722;font-weight:bold;">' + item.gCount + '</td>';
                html += '<td>' + (item.stockWarningThreshold || '未设置') + '</td>';
                html += '<td>' + (item.stockReorderPoint || '未设置') + '</td>';
                html += '<td><span class="layui-badge layui-bg-orange">库存预警</span></td>';
                html += '<td><button class="layui-btn layui-btn-xs" onclick="fillForm(\'' + item.gNo + '\',' + item.gCount + ',' + (item.stockWarningThreshold||0) + ',' + (item.stockReorderPoint||0) + ')">设置</button></td>';
                html += '</tr>';
              });
              tbody.innerHTML = html;
            } else {
              tbody.innerHTML = '<tr><td colspan="7" style="text-align:center;color:#999;">暂无库存预警商品</td></tr>';
            }
          }
        });
      }

      function loadReorder() {
        $.ajax({
          type: "get",
          url: "${pageContext.request.contextPath}/goods/reorder",
          dataType: "json",
          success: function(res) {
            var tbody = document.getElementById('reorderTable');
            if(res.code === 200 && res.data && res.data.length > 0) {
              var html = '';
              res.data.forEach(function(item) {
                var needCount = item.stockReorderPoint - item.gCount;
                html += '<tr>';
                html += '<td>' + item.gNo + '</td>';
                html += '<td>' + item.gName + '</td>';
                html += '<td style="color:#FF5722;font-weight:bold;">' + item.gCount + '</td>';
                html += '<td>' + (item.stockWarningThreshold || '未设置') + '</td>';
                html += '<td>' + (item.stockReorderPoint || '未设置') + '</td>';
                html += '<td style="color:#FF0000;font-weight:bold;">' + needCount + '</td>';
                html += '<td><button class="layui-btn layui-btn-xs" onclick="fillForm(\'' + item.gNo + '\',' + item.gCount + ',' + (item.stockWarningThreshold||0) + ',' + (item.stockReorderPoint||0) + ')">设置</button></td>';
                html += '</tr>';
              });
              tbody.innerHTML = html;
            } else {
              tbody.innerHTML = '<tr><td colspan="7" style="text-align:center;color:#999;">暂无需要补货的商品</td></tr>';
            }
          }
        });
      }

      function fillForm(gNo, gCount, warningThreshold, reorderPoint) {
        document.getElementById('goodsNo').value = gNo;
        document.querySelector('input[name="gCount"]').value = gCount;
        document.querySelector('input[name="stockWarningThreshold"]').value = warningThreshold;
        document.querySelector('input[name="stockReorderPoint"]').value = reorderPoint;
      }
    </script>
  </body>
</html>
