Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544127D34A4
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjJWLlm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjJWLlm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:41:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C1110CE
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:41:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B9FC433C9;
        Mon, 23 Oct 2023 11:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061289;
        bh=1xATAcLbuFJbirVoy6rLLFKeo1X+/7XOL/dg+KhDeZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EMwZRBLTXKrPlgdi6NRh9lmzpk6vS1xy76jtwlRv6QGJwEMTfG9lErI/khjv9mgFn
         c6BxoDwJ75ID4pUEomzGbSpJa3LzFyiNJXPYV+RzSJERAZ7Qzz0JlEgtfyP3mjfZxc
         luGWV7qPS+72l1fxNgT5klNWpa8A4SXO36K1R6fY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Sun <pablo.sun@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioachino.delregno@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.15 108/137] mmc: mtk-sd: Use readl_poll_timeout_atomic in msdc_reset_hw
Date:   Mon, 23 Oct 2023 12:57:45 +0200
Message-ID: <20231023104824.456582159@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Sun <pablo.sun@mediatek.com>

commit c7bb120c1c66672b657e95d0942c989b8275aeb3 upstream.

Use atomic readl_poll_timeout_atomic, because msdc_reset_hw
may be invoked in IRQ handler in the following context:

  msdc_irq() -> msdc_cmd_done() -> msdc_reset_hw()

The following kernel BUG stack trace can be observed on
Genio 1200 EVK after initializing MSDC1 hardware during kernel boot:

[    1.187441] BUG: scheduling while atomic: swapper/0/0/0x00010002
[    1.189157] Modules linked in:
[    1.204633] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.15.42-mtk+modified #1
[    1.205713] Hardware name: MediaTek Genio 1200 EVK-P1V2-EMMC (DT)
[    1.206484] Call trace:
[    1.206796]  dump_backtrace+0x0/0x1ac
[    1.207266]  show_stack+0x24/0x30
[    1.207692]  dump_stack_lvl+0x68/0x84
[    1.208162]  dump_stack+0x1c/0x38
[    1.208587]  __schedule_bug+0x68/0x80
[    1.209056]  __schedule+0x6ec/0x7c0
[    1.209502]  schedule+0x7c/0x110
[    1.209915]  schedule_hrtimeout_range_clock+0xc4/0x1f0
[    1.210569]  schedule_hrtimeout_range+0x20/0x30
[    1.211148]  usleep_range_state+0x84/0xc0
[    1.211661]  msdc_reset_hw+0xc8/0x1b0
[    1.212134]  msdc_cmd_done.isra.0+0x4ac/0x5f0
[    1.212693]  msdc_irq+0x104/0x2d4
[    1.213121]  __handle_irq_event_percpu+0x68/0x280
[    1.213725]  handle_irq_event+0x70/0x15c
[    1.214230]  handle_fasteoi_irq+0xb0/0x1a4
[    1.214755]  handle_domain_irq+0x6c/0x9c
[    1.215260]  gic_handle_irq+0xc4/0x180
[    1.215741]  call_on_irq_stack+0x2c/0x54
[    1.216245]  do_interrupt_handler+0x5c/0x70
[    1.216782]  el1_interrupt+0x30/0x80
[    1.217242]  el1h_64_irq_handler+0x1c/0x2c
[    1.217769]  el1h_64_irq+0x78/0x7c
[    1.218206]  cpuidle_enter_state+0xc8/0x600
[    1.218744]  cpuidle_enter+0x44/0x5c
[    1.219205]  do_idle+0x224/0x2d0
[    1.219624]  cpu_startup_entry+0x30/0x80
[    1.220129]  rest_init+0x108/0x134
[    1.220568]  arch_call_rest_init+0x1c/0x28
[    1.221094]  start_kernel+0x6c0/0x700
[    1.221564]  __primary_switched+0xc0/0xc8

Fixes: ffaea6ebfe9c ("mmc: mtk-sd: Use readl_poll_timeout instead of open-coded polling")
Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioachino.delregno@collabora.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230922095348.22182-1-pablo.sun@mediatek.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/mtk-sd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -628,11 +628,11 @@ static void msdc_reset_hw(struct msdc_ho
 	u32 val;
 
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_RST);
-	readl_poll_timeout(host->base + MSDC_CFG, val, !(val & MSDC_CFG_RST), 0, 0);
+	readl_poll_timeout_atomic(host->base + MSDC_CFG, val, !(val & MSDC_CFG_RST), 0, 0);
 
 	sdr_set_bits(host->base + MSDC_FIFOCS, MSDC_FIFOCS_CLR);
-	readl_poll_timeout(host->base + MSDC_FIFOCS, val,
-			   !(val & MSDC_FIFOCS_CLR), 0, 0);
+	readl_poll_timeout_atomic(host->base + MSDC_FIFOCS, val,
+				  !(val & MSDC_FIFOCS_CLR), 0, 0);
 
 	val = readl(host->base + MSDC_INT);
 	writel(val, host->base + MSDC_INT);


