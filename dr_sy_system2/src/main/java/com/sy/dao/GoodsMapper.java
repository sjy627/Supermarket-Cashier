package com.sy.dao;

        import com.sy.pojo.Goods;
        import org.apache.ibatis.annotations.Param;

        import java.util.List;

public interface GoodsMapper {

    /**
     * 所有的商品
     * @return
     */
    List<Goods> selAllGoods();

    /**
     * 保存员工的方法
     * @param goods
     * @return
     */
    Integer addGoods(@Param("goods") Goods goods);


    /**
     * 获取最大的id号
     * @param gtNo
     * @return
     */
    Goods getlastgNo(@Param("gtNo")String gtNo);

    /**
     * 多条删除员工
     * @param g_nos
     * @return
     */
    Integer delete(@Param("g_nos") String[] g_nos);

    /**
     * 查询库存预警商品（库存低于预警阈值的商品）
     * @return
     */
    List<Goods> selLowStockGoods();

    /**
     * 查询需要补货的商品（库存低于补货点的商品）
     * @return
     */
    List<Goods> selReorderGoods();

    /**
     * 更新商品库存和预警阈值
     * @param goods
     * @return
     */
    Integer updateGoodsStock(@Param("goods") Goods goods);
}
