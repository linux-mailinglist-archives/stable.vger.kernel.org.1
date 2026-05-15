Return-Path: <stable+bounces-248644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAfFJ1tQB2qayAIAu9opvQ
	(envelope-from <stable+bounces-248644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:56:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 233B75543F7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40E6C33B179B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C523E7BCC;
	Fri, 15 May 2026 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LtoxeJ/y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F513F44CC;
	Fri, 15 May 2026 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862261; cv=none; b=A8g7Z97Cmgp71raPdFQUVbtj092ZsRsopgEufeySQRlNmrh+ul95XFOX8X3a5dPK2KcmMSe8TwoBhYCkPrqUkRfRb5Z2iPsDedMMfsiV+SMClEylzsNXKurMlzYgNXfN19+8kQ2QLXKlqlD7ayF1UxN8cFXjPJjGWlBVW/ccooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862261; c=relaxed/simple;
	bh=UqyZtXGtCQRyQNypt+9xXvRwTfUMcVgqFb+E0BQv90E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ie/c6Mmt459B7SeMylqxjeAltu2CJNjnPuFM2VcjKeWvFKlQM4hVljBWTKV4EC9fcUc0fsfCZrC5InvcuMqHHm/+x4Z9D07svYRsAmsZa/SiH9/5D91NpLpWIsS/pBY1htYq/8FJnnNgdLFMdj//vuhOfpfi0xiN/XxT0vUdT+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LtoxeJ/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237F8C2BCB0;
	Fri, 15 May 2026 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862261;
	bh=UqyZtXGtCQRyQNypt+9xXvRwTfUMcVgqFb+E0BQv90E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LtoxeJ/y7LbaSABj4WQS0asmxpec6Urj5pXR/nkcHBnz3U76r2qm51OGTbbzasCMd
	 A35lFWeP7QIPWZkpSGg6CsHQjZajYiPbylNLOtarrNy/YrcKxFzz+5/v6RMI6doEtv
	 x6TiF+Wpgh2pXoRx0ullzES7JakBKzJGuN0vrwAk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prashanth K <prashanth.k@oss.qualcomm.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 171/188] usb: dwc3: Remove of dep->regs
Date: Fri, 15 May 2026 17:49:48 +0200
Message-ID: <20260515154701.046499566@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 233B75543F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248644-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,qualcomm.com:email,synopsys.com:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prashanth K <prashanth.k@oss.qualcomm.com>

[ Upstream commit abdd1eef04f0cb3b1707cd1fa243d574d5e07024 ]

Remove dep->regs from struct dwc3_ep and reuse dwc->regs instead.
Thus eliminating redundant iomem addresses and making register
access more consistent across the driver.

Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20260114100748.2950103-2-prashanth.k@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: aad35f9c926e ("usb: dwc3: Move GUID programming after PHY initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.h    |   10 ++++------
 drivers/usb/dwc3/debugfs.c |   12 ++++--------
 drivers/usb/dwc3/gadget.c  |   12 ++++++------
 drivers/usb/dwc3/gadget.h  |    2 +-
 4 files changed, 15 insertions(+), 21 deletions(-)

--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -165,10 +165,10 @@
 #define DWC3_DCFG1		0xc740 /* DWC_usb32 only */
 
 #define DWC3_DEP_BASE(n)	(0xc800 + ((n) * 0x10))
-#define DWC3_DEPCMDPAR2		0x00
-#define DWC3_DEPCMDPAR1		0x04
-#define DWC3_DEPCMDPAR0		0x08
-#define DWC3_DEPCMD		0x0c
+#define DWC3_DEPCMDPAR2(n)	(DWC3_DEP_BASE(n) + 0x00)
+#define DWC3_DEPCMDPAR1(n)	(DWC3_DEP_BASE(n) + 0x04)
+#define DWC3_DEPCMDPAR0(n)	(DWC3_DEP_BASE(n) + 0x08)
+#define DWC3_DEPCMD(n)		(DWC3_DEP_BASE(n) + 0x0c)
 
 #define DWC3_DEV_IMOD(n)	(0xca00 + ((n) * 0x4))
 
@@ -749,8 +749,6 @@ struct dwc3_ep {
 	struct list_head	pending_list;
 	struct list_head	started_list;
 
-	void __iomem		*regs;
-
 	struct dwc3_trb		*trb_pool;
 	dma_addr_t		trb_pool_dma;
 	struct dwc3		*dwc;
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -36,23 +36,19 @@
 #define dump_ep_register_set(n)			\
 	{					\
 		.name = "DEPCMDPAR2("__stringify(n)")",	\
-		.offset = DWC3_DEP_BASE(n) +	\
-			DWC3_DEPCMDPAR2,	\
+		.offset = DWC3_DEPCMDPAR2(n),	\
 	},					\
 	{					\
 		.name = "DEPCMDPAR1("__stringify(n)")",	\
-		.offset = DWC3_DEP_BASE(n) +	\
-			DWC3_DEPCMDPAR1,	\
+		.offset = DWC3_DEPCMDPAR1(n),	\
 	},					\
 	{					\
 		.name = "DEPCMDPAR0("__stringify(n)")",	\
-		.offset = DWC3_DEP_BASE(n) +	\
-			DWC3_DEPCMDPAR0,	\
+		.offset = DWC3_DEPCMDPAR0(n),	\
 	},					\
 	{					\
 		.name = "DEPCMD("__stringify(n)")",	\
-		.offset = DWC3_DEP_BASE(n) +	\
-			DWC3_DEPCMD,		\
+		.offset = DWC3_DEPCMD(n),		\
 	}
 
 
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -320,6 +320,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_
 
 	int			cmd_status = 0;
 	int			ret = -EINVAL;
+	u8			epnum = dep->number;
 
 	/*
 	 * When operating in USB 2.0 speeds (HS/FS), if GUSB2PHYCFG.ENBLSLPM or
@@ -355,9 +356,9 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_
 	 * improve performance.
 	 */
 	if (DWC3_DEPCMD_CMD(cmd) != DWC3_DEPCMD_UPDATETRANSFER) {
-		dwc3_writel(dep->regs, DWC3_DEPCMDPAR0, params->param0);
-		dwc3_writel(dep->regs, DWC3_DEPCMDPAR1, params->param1);
-		dwc3_writel(dep->regs, DWC3_DEPCMDPAR2, params->param2);
+		dwc3_writel(dwc->regs, DWC3_DEPCMDPAR0(epnum), params->param0);
+		dwc3_writel(dwc->regs, DWC3_DEPCMDPAR1(epnum), params->param1);
+		dwc3_writel(dwc->regs, DWC3_DEPCMDPAR2(epnum), params->param2);
 	}
 
 	/*
@@ -381,7 +382,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_
 	else
 		cmd |= DWC3_DEPCMD_CMDACT;
 
-	dwc3_writel(dep->regs, DWC3_DEPCMD, cmd);
+	dwc3_writel(dwc->regs, DWC3_DEPCMD(epnum), cmd);
 
 	if (!(cmd & DWC3_DEPCMD_CMDACT) ||
 		(DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER &&
@@ -391,7 +392,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_
 	}
 
 	do {
-		reg = dwc3_readl(dep->regs, DWC3_DEPCMD);
+		reg = dwc3_readl(dwc->regs, DWC3_DEPCMD(epnum));
 		if (!(reg & DWC3_DEPCMD_CMDACT)) {
 			cmd_status = DWC3_DEPCMD_STATUS(reg);
 
@@ -3379,7 +3380,6 @@ static int dwc3_gadget_init_endpoint(str
 	dep->dwc = dwc;
 	dep->number = epnum;
 	dep->direction = direction;
-	dep->regs = dwc->regs + DWC3_DEP_BASE(epnum);
 	dwc->eps[epnum] = dep;
 	dep->combo_num = 0;
 	dep->start_cmd_status = 0;
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -132,7 +132,7 @@ static inline void dwc3_gadget_ep_get_tr
 {
 	u32			res_id;
 
-	res_id = dwc3_readl(dep->regs, DWC3_DEPCMD);
+	res_id = dwc3_readl(dep->dwc->regs, DWC3_DEPCMD(dep->number));
 	dep->resource_index = DWC3_DEPCMD_GET_RSC_IDX(res_id);
 }
 



