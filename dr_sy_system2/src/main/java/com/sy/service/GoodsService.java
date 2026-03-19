package com.sy.service;

import com.sy.dto.ResultDto;
import com.sy.pojo.Goods;

import java.util.List;

public interface GoodsService {

    /**
     * 查询所有商品
     * @param page 当前的页码
     * @param pageSize 当前的页容量
     * @return
     */
    List<Goods> getAllGoods(Integer page,Integer pageSize);

    ResultDto<Object> addGoods(Goods goods);

    /**
     * 删除多个员工
     * @param gNos
     * @return
     */
    ResultDto<String>deleteGoods(String gNos);

    /**\
     * 获取所有商品总数
     * @return
     */
    ResultDto<Object> selTotalGd();

    /**
     * 获取库存预警商品列表
     * @return
     */
    ResultDto<Object> getLowStockGoods();

    /**
     * 获取需要补货的商品列表
     * @return
     */
    ResultDto<Object> getReorderGoods();

    /**
     * 更新商品库存和预警阈值
     * @param goods
     * @return
     */
    ResultDto<Object> updateGoodsStock(Goods goods);

    /**
     * 获取库存预警统计信息
     * @return
     */
    ResultDto<Object> getStockWarningStats();
}

