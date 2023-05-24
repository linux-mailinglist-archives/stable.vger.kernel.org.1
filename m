Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA8A70EB03
	for <lists+stable@lfdr.de>; Wed, 24 May 2023 03:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbjEXBtl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 21:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238919AbjEXBtc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 21:49:32 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 174EF13E;
        Tue, 23 May 2023 18:49:29 -0700 (PDT)
Received: from loongson.cn (unknown [223.106.25.146])
        by gateway (Coremail) with SMTP id _____8BxGvIobW1kr0QAAA--.909S3;
        Wed, 24 May 2023 09:49:28 +0800 (CST)
Received: from localhost.localdomain (unknown [223.106.25.146])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxsOQnbW1kJ3tyAA--.60436S2;
        Wed, 24 May 2023 09:49:27 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn,
        Binbin Zhou <zhoubinbin@loongson.cn>, stable@vger.kernel.org,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH] clk: clk-loongson2: Zero init clk_init_data
Date:   Wed, 24 May 2023 09:49:24 +0800
Message-Id: <20230524014924.2869051-1-zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxsOQnbW1kJ3tyAA--.60436S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZw15XFy7Cw4rAF43ury7Awb_yoW7JryrpF
        y7JrW8Gr48Jr1DAF48AF1UJr45Ja47AF48Gr1UJr1UZr1UWr1DXFyjyrWUJr17Ar45Jry7
        Jr1vqr15Kr1DG3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
        4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

As clk_core_populate_parent_map() checks clk_init_data.num_parents
first, and checks clk_init_data.parent_names[] before
clk_init_data.parent_data[] and clk_init_data.parent_hws[].

Therefore the clk_init_data structure needs to be explicitly initialised
to prevent an unexpected crash if clk_init_data.parent_names[] is a
random value.

[    1.374074] CPU 0 Unable to handle kernel paging request at virtual address 0000000000000dc0, era == 9000000002986290, ra == 900000000298624c
[    1.386856] Oops[#1]:
[    1.389151] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.4.0-rc2+ #4582
[    1.395717] pc 9000000002986290 ra 900000000298624c tp 9000000100094000 sp 9000000100097a60
[    1.404126] a0 9000000104541e00 a1 0000000000000000 a2 0000000000000dc0 a3 0000000000000001
[    1.412533] a4 90000001000979f0 a5 90000001800977d7 a6 0000000000000000 a7 900000000362a000
[    1.420939] t0 90000000034f3548 t1 6f8c2a9cb5ab5f64 t2 0000000000011340 t3 90000000031cf5b0
[    1.429346] t4 0000000000000dc0 t5 0000000000000004 t6 0000000000011300 t7 9000000104541e40
[    1.437753] t8 000000000005a4f8 u0 9000000104541e00 s9 9000000104541e00 s0 9000000104bc4700
[    1.446159] s1 9000000104541da8 s2 0000000000000001 s3 900000000356f9d8 s4 ffffffffffffffff
[    1.454565] s5 0000000000000000 s6 0000000000000dc0 s7 90000000030d0a88 s8 0000000000000000
[    1.462972]    ra: 900000000298624c __clk_register+0x228/0x84c
[    1.468854]   ERA: 9000000002986290 __clk_register+0x26c/0x84c
[    1.474724]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
[    1.480975]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[    1.485373]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
[    1.490209]  ECFG: 00071c1c (LIE=2-4,10-12 VS=7)
[    1.494865] ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
[    1.500390]  BADV: 0000000000000dc0
[    1.503899]  PRID: 0014a000 (Loongson-64bit, )
[    1.508369] Modules linked in:
[    1.511447] Process swapper/0 (pid: 1, threadinfo=(____ptrval____), task=(____ptrval____))
[    1.519768] Stack : 90000000031c1810 90000000030d0a88 900000000325bac0 90000000034f3548
[    1.527848]         90000001002ab410 9000000104541e00 0000000000000dc0 9000000003150098
[    1.535923]         90000000031c1810 90000000031a0460 900000000362a000 90000001002ab410
[    1.543998]         900000000362a000 9000000104541da8 9000000104541de8 90000001002ab410
[    1.552073]         900000000362a000 9000000002986a68 90000000034f3ed8 90000000030d0aa8
[    1.560148]         9000000104541da8 900000000298d3b8 90000000031c1810 0000000000000000
[    1.568223]         90000000034f3ed8 90000000030d0aa8 0000000000000dc0 90000000030d0a88
[    1.576298]         90000001002ab410 900000000298d401 0000000000000000 6f8c2a9cb5ab5f64
[    1.584373]         90000000034f4000 90000000030d0a88 9000000003a48a58 90000001002ab410
[    1.592448]         9000000104bd81a8 900000000298d484 9000000100020260 0000000000000000
[    1.600523]         ...
[    1.602993] Call Trace:
[    1.603000] [<9000000002986290>] __clk_register+0x26c/0x84c
[    1.611072] [<9000000002986a68>] devm_clk_hw_register+0x5c/0xe0
[    1.617031] [<900000000298d3b8>] loongson2_clk_register.constprop.0+0xdc/0x10c
[    1.624314] [<900000000298d484>] loongson2_clk_probe+0x9c/0x4ac
[    1.630270] [<9000000002a4eba4>] platform_probe+0x68/0xc8
[    1.635703] [<9000000002a4bf80>] really_probe+0xbc/0x2f0
[    1.641054] [<9000000002a4c23c>] __driver_probe_device+0x88/0x128
[    1.647185] [<9000000002a4c318>] driver_probe_device+0x3c/0x11c
[    1.653142] [<9000000002a4c5dc>] __driver_attach+0x98/0x18c
[    1.658749] [<9000000002a49ca0>] bus_for_each_dev+0x80/0xe0
[    1.664357] [<9000000002a4b0dc>] bus_add_driver+0xfc/0x1ec
[    1.669878] [<9000000002a4d4a8>] driver_register+0x68/0x134
[    1.675486] [<90000000020f0110>] do_one_initcall+0x50/0x188
[    1.681094] [<9000000003150f00>] kernel_init_freeable+0x224/0x294
[    1.687226] [<90000000030240fc>] kernel_init+0x20/0x110
[    1.692493] [<90000000020f1568>] ret_from_kernel_thread+0xc/0xa4

Fixes: acc0ccffec50 ("clk: clk-loongson2: add clock controller driver support")
Cc: stable@vger.kernel.org
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/clk/clk-loongson2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
index 70ae1dd2e474..b839edd7271b 100644
--- a/drivers/clk/clk-loongson2.c
+++ b/drivers/clk/clk-loongson2.c
@@ -40,7 +40,7 @@ static struct clk_hw *loongson2_clk_register(struct device *dev,
 {
 	int ret;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = { NULL };
 
 	hw = devm_kzalloc(dev, sizeof(*hw), GFP_KERNEL);
 	if (!hw)
-- 
2.39.1

