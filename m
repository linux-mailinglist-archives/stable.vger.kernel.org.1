Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14CD70C42E
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 19:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjEVRXu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 13:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjEVRXs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 13:23:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB474E9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 10:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40C8961D48
        for <stable@vger.kernel.org>; Mon, 22 May 2023 17:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C822C433D2;
        Mon, 22 May 2023 17:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684776225;
        bh=GOiUjyjp2dvHCBOG+wmmNyw789lHV1VuAe3dVAilVUA=;
        h=Subject:To:Cc:From:Date:From;
        b=URCs6WeABHEKr77mez3LQYDXwL54M+pIDgOTI9Y4UUErJcf3VQxcopRy/JmaNzstj
         sdmK4PrheytzrONgyxar4lk9SGBV1TEC0mdQqF+NZtRYl3w/tRa/ouAXoEHdL7zeE6
         gZrxcrW/TMdxU0vslzqc1kWsU4ZPPB8gh5E63rQQ=
Subject: FAILED: patch "[PATCH] usb: dwc3: debugfs: Resume dwc3 before accessing registers" failed to apply to 4.14-stable tree
To:     quic_ugoswami@quicinc.com, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org, johan+linaro@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 18:23:35 +0100
Message-ID: <2023052235-overcome-frostlike-a068@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 614ce6a2ea50068b45339257891e51e639ac9001
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052235-overcome-frostlike-a068@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

614ce6a2ea50 ("usb: dwc3: debugfs: Resume dwc3 before accessing registers")
d102444cac15 ("usb: dwc3: debugfs: Print/set link state for peripheral mode")
0d36dede4578 ("usb: dwc3: debugfs: Properly print/set link state for HS")
62ba09d6bb63 ("usb: dwc3: debugfs: Dump internal LSP and ep registers")
2c85a1817e4b ("usb: dwc3: debugfs: Properly name Tx/RxFIFO")
d635db5508b0 ("usb: dwc3: add global soc bus configuration reg0")
80b776340c78 ("usb: dwc3: Dump LSP and BMU debug info")
4cff75c7fe3d ("usb: dwc3: core.h: add some register definitions")
6d5b53c1fd5c ("usb: dwc3: debugfs: Re-use DEFINE_SHOW_ATTRIBUTE() macro")
b16ea8b9492e ("usb: dwc3: Fix GDBGFIFOSPACE_TYPE values")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 614ce6a2ea50068b45339257891e51e639ac9001 Mon Sep 17 00:00:00 2001
From: Udipto Goswami <quic_ugoswami@quicinc.com>
Date: Tue, 9 May 2023 20:18:36 +0530
Subject: [PATCH] usb: dwc3: debugfs: Resume dwc3 before accessing registers

When the dwc3 device is runtime suspended, various required clocks are in
disabled state and it is not guaranteed that access to any registers would
work. Depending on the SoC glue, a register read could be as benign as
returning 0 or be fatal enough to hang the system.

In order to prevent such scenarios of fatal errors, make sure to resume
dwc3 then allow the function to proceed.

Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Cc: stable@vger.kernel.org #3.2: 30332eeefec8: debugfs: regset32: Add Runtime PM support
Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20230509144836.6803-1-quic_ugoswami@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
index e4a2560b9dc0..ebf03468fac4 100644
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -332,6 +332,11 @@ static int dwc3_lsp_show(struct seq_file *s, void *unused)
 	unsigned int		current_mode;
 	unsigned long		flags;
 	u32			reg;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	reg = dwc3_readl(dwc->regs, DWC3_GSTS);
@@ -350,6 +355,8 @@ static int dwc3_lsp_show(struct seq_file *s, void *unused)
 	}
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -395,6 +402,11 @@ static int dwc3_mode_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = s->private;
 	unsigned long		flags;
 	u32			reg;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
@@ -414,6 +426,8 @@ static int dwc3_mode_show(struct seq_file *s, void *unused)
 		seq_printf(s, "UNKNOWN %08x\n", DWC3_GCTL_PRTCAP(reg));
 	}
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -463,6 +477,11 @@ static int dwc3_testmode_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = s->private;
 	unsigned long		flags;
 	u32			reg;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -493,6 +512,8 @@ static int dwc3_testmode_show(struct seq_file *s, void *unused)
 		seq_printf(s, "UNKNOWN %d\n", reg);
 	}
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -509,6 +530,7 @@ static ssize_t dwc3_testmode_write(struct file *file,
 	unsigned long		flags;
 	u32			testmode = 0;
 	char			buf[32];
+	int			ret;
 
 	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
@@ -526,10 +548,16 @@ static ssize_t dwc3_testmode_write(struct file *file,
 	else
 		testmode = 0;
 
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_gadget_set_test_mode(dwc, testmode);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return count;
 }
 
@@ -548,12 +576,18 @@ static int dwc3_link_state_show(struct seq_file *s, void *unused)
 	enum dwc3_link_state	state;
 	u32			reg;
 	u8			speed;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	reg = dwc3_readl(dwc->regs, DWC3_GSTS);
 	if (DWC3_GSTS_CURMOD(reg) != DWC3_GSTS_CURMOD_DEVICE) {
 		seq_puts(s, "Not available\n");
 		spin_unlock_irqrestore(&dwc->lock, flags);
+		pm_runtime_put_sync(dwc->dev);
 		return 0;
 	}
 
@@ -566,6 +600,8 @@ static int dwc3_link_state_show(struct seq_file *s, void *unused)
 		   dwc3_gadget_hs_link_string(state));
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -584,6 +620,7 @@ static ssize_t dwc3_link_state_write(struct file *file,
 	char			buf[32];
 	u32			reg;
 	u8			speed;
+	int			ret;
 
 	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
@@ -603,10 +640,15 @@ static ssize_t dwc3_link_state_write(struct file *file,
 	else
 		return -EINVAL;
 
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	reg = dwc3_readl(dwc->regs, DWC3_GSTS);
 	if (DWC3_GSTS_CURMOD(reg) != DWC3_GSTS_CURMOD_DEVICE) {
 		spin_unlock_irqrestore(&dwc->lock, flags);
+		pm_runtime_put_sync(dwc->dev);
 		return -EINVAL;
 	}
 
@@ -616,12 +658,15 @@ static ssize_t dwc3_link_state_write(struct file *file,
 	if (speed < DWC3_DSTS_SUPERSPEED &&
 	    state != DWC3_LINK_STATE_RECOV) {
 		spin_unlock_irqrestore(&dwc->lock, flags);
+		pm_runtime_put_sync(dwc->dev);
 		return -EINVAL;
 	}
 
 	dwc3_gadget_set_link_state(dwc, state);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return count;
 }
 
@@ -645,6 +690,11 @@ static int dwc3_tx_fifo_size_show(struct seq_file *s, void *unused)
 	unsigned long		flags;
 	u32			mdwidth;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_TXFIFO);
@@ -657,6 +707,8 @@ static int dwc3_tx_fifo_size_show(struct seq_file *s, void *unused)
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -667,6 +719,11 @@ static int dwc3_rx_fifo_size_show(struct seq_file *s, void *unused)
 	unsigned long		flags;
 	u32			mdwidth;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_RXFIFO);
@@ -679,6 +736,8 @@ static int dwc3_rx_fifo_size_show(struct seq_file *s, void *unused)
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -688,12 +747,19 @@ static int dwc3_tx_request_queue_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = dep->dwc;
 	unsigned long		flags;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_TXREQQ);
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -703,12 +769,19 @@ static int dwc3_rx_request_queue_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = dep->dwc;
 	unsigned long		flags;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_RXREQQ);
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -718,12 +791,19 @@ static int dwc3_rx_info_queue_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = dep->dwc;
 	unsigned long		flags;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_RXINFOQ);
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -733,12 +813,19 @@ static int dwc3_descriptor_fetch_queue_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = dep->dwc;
 	unsigned long		flags;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_DESCFETCHQ);
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -748,12 +835,19 @@ static int dwc3_event_queue_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = dep->dwc;
 	unsigned long		flags;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_EVENTQ);
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -798,6 +892,11 @@ static int dwc3_trb_ring_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = dep->dwc;
 	unsigned long		flags;
 	int			i;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	if (dep->number <= 1) {
@@ -827,6 +926,8 @@ static int dwc3_trb_ring_show(struct seq_file *s, void *unused)
 out:
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -839,6 +940,11 @@ static int dwc3_ep_info_register_show(struct seq_file *s, void *unused)
 	u32			lower_32_bits;
 	u32			upper_32_bits;
 	u32			reg;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	reg = DWC3_GDBGLSPMUX_EPSELECT(dep->number);
@@ -851,6 +957,8 @@ static int dwc3_ep_info_register_show(struct seq_file *s, void *unused)
 	seq_printf(s, "0x%016llx\n", ep_info);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -910,6 +1018,7 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
 	dwc->regset->regs = dwc3_regs;
 	dwc->regset->nregs = ARRAY_SIZE(dwc3_regs);
 	dwc->regset->base = dwc->regs - DWC3_GLOBALS_REGS_START;
+	dwc->regset->dev = dwc->dev;
 
 	root = debugfs_create_dir(dev_name(dwc->dev), usb_debug_root);
 	dwc->debug_root = root;

