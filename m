Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EEC713D6B
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjE1TZK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjE1TZJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:25:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C463B1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB10B61BF8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0088CC433EF;
        Sun, 28 May 2023 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301907;
        bh=H5j809lpuaksRj9LHOrAYqVs7Xnh09O8W/qaGjcD42M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bmC5k6I+AeQBpxPX1S0JX3c0Dvldhr/VS4delbbfg9VmnYR8dE2me98bGVanNDqjL
         3lQaoyWQfcKTHrZcLSzc6BqkeMavSF+0p2fgfgr5sqkNA5Sr8tRXGD7j++ph/6vR4d
         Hvyj6IZje1uNG1qLg2g9uW6V8pIhiL6Ih8FND9Ok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Udipto Goswami <quic_ugoswami@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 5.4 084/161] usb: dwc3: debugfs: Resume dwc3 before accessing registers
Date:   Sun, 28 May 2023 20:10:08 +0100
Message-Id: <20230528190839.811908941@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
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
 
@@ -455,6 +469,11 @@ static int dwc3_testmode_show(struct seq
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
@@ -485,6 +504,8 @@ static int dwc3_testmode_show(struct seq
 		seq_printf(s, "UNKNOWN %d\n", reg);
 	}
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -501,6 +522,7 @@ static ssize_t dwc3_testmode_write(struc
 	unsigned long		flags;
 	u32			testmode = 0;
 	char			buf[32];
+	int			ret;
 
 	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
@@ -518,10 +540,16 @@ static ssize_t dwc3_testmode_write(struc
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
 
@@ -540,12 +568,18 @@ static int dwc3_link_state_show(struct s
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
 
@@ -558,6 +592,8 @@ static int dwc3_link_state_show(struct s
 		   dwc3_gadget_hs_link_string(state));
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -576,6 +612,7 @@ static ssize_t dwc3_link_state_write(str
 	char			buf[32];
 	u32			reg;
 	u8			speed;
+	int			ret;
 
 	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
@@ -595,10 +632,15 @@ static ssize_t dwc3_link_state_write(str
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
 
@@ -608,12 +650,15 @@ static ssize_t dwc3_link_state_write(str
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
 
@@ -636,6 +681,11 @@ static int dwc3_tx_fifo_size_show(struct
 	struct dwc3		*dwc = dep->dwc;
 	unsigned long		flags;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_TXFIFO);
@@ -646,6 +696,8 @@ static int dwc3_tx_fifo_size_show(struct
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -655,6 +707,11 @@ static int dwc3_rx_fifo_size_show(struct
 	struct dwc3		*dwc = dep->dwc;
 	unsigned long		flags;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_RXFIFO);
@@ -665,6 +722,8 @@ static int dwc3_rx_fifo_size_show(struct
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -674,12 +733,19 @@ static int dwc3_tx_request_queue_show(st
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
 
@@ -689,12 +755,19 @@ static int dwc3_rx_request_queue_show(st
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
 
@@ -704,12 +777,19 @@ static int dwc3_rx_info_queue_show(struc
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
 
@@ -719,12 +799,19 @@ static int dwc3_descriptor_fetch_queue_s
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
 
@@ -734,12 +821,19 @@ static int dwc3_event_queue_show(struct
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
 
@@ -785,6 +879,11 @@ static int dwc3_trb_ring_show(struct seq
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
@@ -814,6 +913,8 @@ static int dwc3_trb_ring_show(struct seq
 out:
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -826,6 +927,11 @@ static int dwc3_ep_info_register_show(st
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
@@ -838,6 +944,8 @@ static int dwc3_ep_info_register_show(st
 	seq_printf(s, "0x%016llx\n", ep_info);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -899,6 +1007,7 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
 	dwc->regset->regs = dwc3_regs;
 	dwc->regset->nregs = ARRAY_SIZE(dwc3_regs);
 	dwc->regset->base = dwc->regs - DWC3_GLOBALS_REGS_START;
+	dwc->regset->dev = dwc->dev;
 
 	root = debugfs_create_dir(dev_name(dwc->dev), NULL);
 	dwc->root = root;


