Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B97713F4B
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjE1Tn5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjE1Tn4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7E6A8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:43:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D44CE61F1D
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B92C433A0;
        Sun, 28 May 2023 19:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303033;
        bh=fhxwMiLnH++HgvXL966s7oveq5fEYyxTmJAaO1YJfLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ri9OXSdqj/G8wAlXSRxaBkGujmKxzyd3xhrUSBGCOHYjPeqY2ey2cIjJzQ78QIVC
         K9zh2Th8TuhwAKgKmxMywq2ykD7u1nSz7AijocAhEqXHkAyh1nrVG0yEx2v3eAmRt7
         dNMz7AnR86SDsMFyah5yp951WVf6wRQkEqg/q+5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Udipto Goswami <quic_ugoswami@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 5.10 127/211] usb: dwc3: debugfs: Resume dwc3 before accessing registers
Date:   Sun, 28 May 2023 20:10:48 +0100
Message-Id: <20230528190846.699653292@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Udipto Goswami <quic_ugoswami@quicinc.com>

commit 614ce6a2ea50068b45339257891e51e639ac9001 upstream.

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
---
 drivers/usb/dwc3/debugfs.c |  109 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -327,6 +327,11 @@ static int dwc3_lsp_show(struct seq_file
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
@@ -345,6 +350,8 @@ static int dwc3_lsp_show(struct seq_file
 	}
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -390,6 +397,11 @@ static int dwc3_mode_show(struct seq_fil
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
@@ -409,6 +421,8 @@ static int dwc3_mode_show(struct seq_fil
 		seq_printf(s, "UNKNOWN %08x\n", DWC3_GCTL_PRTCAP(reg));
 	}
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -458,6 +472,11 @@ static int dwc3_testmode_show(struct seq
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
@@ -488,6 +507,8 @@ static int dwc3_testmode_show(struct seq
 		seq_printf(s, "UNKNOWN %d\n", reg);
 	}
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -504,6 +525,7 @@ static ssize_t dwc3_testmode_write(struc
 	unsigned long		flags;
 	u32			testmode = 0;
 	char			buf[32];
+	int			ret;
 
 	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
@@ -521,10 +543,16 @@ static ssize_t dwc3_testmode_write(struc
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
 
@@ -543,12 +571,18 @@ static int dwc3_link_state_show(struct s
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
 
@@ -561,6 +595,8 @@ static int dwc3_link_state_show(struct s
 		   dwc3_gadget_hs_link_string(state));
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -579,6 +615,7 @@ static ssize_t dwc3_link_state_write(str
 	char			buf[32];
 	u32			reg;
 	u8			speed;
+	int			ret;
 
 	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
@@ -598,10 +635,15 @@ static ssize_t dwc3_link_state_write(str
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
 
@@ -611,12 +653,15 @@ static ssize_t dwc3_link_state_write(str
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
 
@@ -640,6 +685,11 @@ static int dwc3_tx_fifo_size_show(struct
 	unsigned long		flags;
 	int			mdwidth;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_TXFIFO);
@@ -654,6 +704,8 @@ static int dwc3_tx_fifo_size_show(struct
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -664,6 +716,11 @@ static int dwc3_rx_fifo_size_show(struct
 	unsigned long		flags;
 	int			mdwidth;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_RXFIFO);
@@ -678,6 +735,8 @@ static int dwc3_rx_fifo_size_show(struct
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -687,12 +746,19 @@ static int dwc3_tx_request_queue_show(st
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
 
@@ -702,12 +768,19 @@ static int dwc3_rx_request_queue_show(st
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
 
@@ -717,12 +790,19 @@ static int dwc3_rx_info_queue_show(struc
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
 
@@ -732,12 +812,19 @@ static int dwc3_descriptor_fetch_queue_s
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
 
@@ -747,12 +834,19 @@ static int dwc3_event_queue_show(struct
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
 
@@ -797,6 +891,11 @@ static int dwc3_trb_ring_show(struct seq
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
@@ -826,6 +925,8 @@ static int dwc3_trb_ring_show(struct seq
 out:
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -838,6 +939,11 @@ static int dwc3_ep_info_register_show(st
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
@@ -850,6 +956,8 @@ static int dwc3_ep_info_register_show(st
 	seq_printf(s, "0x%016llx\n", ep_info);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -911,6 +1019,7 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
 	dwc->regset->regs = dwc3_regs;
 	dwc->regset->nregs = ARRAY_SIZE(dwc3_regs);
 	dwc->regset->base = dwc->regs - DWC3_GLOBALS_REGS_START;
+	dwc->regset->dev = dwc->dev;
 
 	root = debugfs_create_dir(dev_name(dwc->dev), usb_debug_root);
 	dwc->root = root;


