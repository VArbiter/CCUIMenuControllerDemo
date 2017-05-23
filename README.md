# CCUIMenuControllerDemo
Auto Generate MenuItems For UIMenuController . 动态生成 menuController 的 Items

为什么写这个 Demo 呢 ...

因为 , 媳妇儿的的公司 , 有个很奇怪的需求 , 要 `UIMenuController` 动态生成 MenuItem ... , 还要回调点击的 title 值给 RN , WTF ?

没有办法 , 秉着不为媳妇儿写代码 , 就要被打死的情况下 ... 我写 = =

这个是与 RN 对接使用的 . 当然 , 我去掉了所有和 RN 有关的部分 ... 就仅仅留下了 Demo .

媳妇儿找了很多第三方 , 她说 , 所找到所有的要么写死 , 要么自己实现了新的 view , 但是都不好 , 就是有 BUG = = ... 

我看了一下 , 确实没有 . 所以就写了一份 .

	核心思想 : 通过 Runtime 动态为当前类添加方法 , 然后替换掉方法实现 , 用 Block 带出值 .
	
2017年05月13日00:38:59

Contact me : elwinfrederick@163.com

2017年05月23日11:45:59 更新 - 数组包字典 . 论, 有一个好的架构 / 项目经理的重要性 .