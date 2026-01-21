Return-Path: <stable+bounces-210845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLzAKQUfcWmodQAAu9opvQ
	(envelope-from <stable+bounces-210845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:46:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 160265B7A0
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7FE1B20D85
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E25330B12;
	Wed, 21 Jan 2026 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GWcMZFtp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6345E322740;
	Wed, 21 Jan 2026 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019578; cv=none; b=E3M3X3qRHbbMxI5WWcglKwflkDvOwxFq3HImycJw8E7tN6KiG5bns7vnIb51LSXAYqiE89Q0J3ap6J3KUvu+9W7okIjF4xRarMxr2pClhC3alooETlvq/jTSESxfRVXeX5e0vEr6SkVZF6LTKQvINty9+AMtpwCrf/JdCKfUjpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019578; c=relaxed/simple;
	bh=UPNnDTwAIV3v1RaFjEHmqDm46xBGeP3XJLGX5sC4ng8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcOLWv//yEat6wbezdk3A1SrH+J/uyT52pamNFjT8gecgMMzdG4AnF/Qf54/T4Ac80ApjHwHlObVUiKTODLbLfFVf+WhA2RvaojSbAwvOK8JPBy9jjMA+Y3OlxecP+94+tpF/OEr2sYvuW8fh7bVq4d7GhCbMacl0kC/wEV8fYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GWcMZFtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02530C4CEF1;
	Wed, 21 Jan 2026 18:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019577;
	bh=UPNnDTwAIV3v1RaFjEHmqDm46xBGeP3XJLGX5sC4ng8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWcMZFtpMpVmXAblHXWST4YF2wO9cekrVNm+FjXO1O/d/0hdT0FR/GGkzqO7Nnl+i
	 Oz4qBV4MCeUCIms+qBAGZWUYMWquEMve8QFgM226a/g1mf5SzIfDa/cDjNEbKJ7kX/
	 KRMoobBalxMY40o+yKos7cDYW7qiZ6w3A7qiR4ao=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Suraj Gupta <suraj.gupta2@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Folker Schwesinger <dev@folker-schwesinger.de>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 046/139] dmaengine: xilinx_dma: Fix uninitialized addr_width when "xlnx,addrwidth" property is missing
Date: Wed, 21 Jan 2026 19:14:54 +0100
Message-ID: <20260121181413.111686821@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-210845-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 160265B7A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suraj Gupta <suraj.gupta2@amd.com>

[ Upstream commit c0732fe78728718c853ef8e7af5bbb05262acbd1 ]

When device tree lacks optional "xlnx,addrwidth" property, the addr_width
variable remained uninitialized with garbage values, causing incorrect
DMA mask configuration and subsequent probe failure. The fix ensures a
fallback to the default 32-bit address width when this property is missing.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Fixes: b72db4005fe4 ("dmaengine: vdma: Add 64 bit addressing support to the driver")
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Reviewed-by: Folker Schwesinger <dev@folker-schwesinger.de>
Link: https://patch.msgid.link/20251021183006.3434495-1-suraj.gupta2@amd.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/xilinx/xilinx_dma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index aa59b62cd83fb..3ad37e9b924a7 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -130,6 +130,7 @@
 #define XILINX_MCDMA_MAX_CHANS_PER_DEVICE	0x20
 #define XILINX_DMA_MAX_CHANS_PER_DEVICE		0x2
 #define XILINX_CDMA_MAX_CHANS_PER_DEVICE	0x1
+#define XILINX_DMA_DFAULT_ADDRWIDTH		0x20
 
 #define XILINX_DMA_DMAXR_ALL_IRQ_MASK	\
 		(XILINX_DMA_DMASR_FRM_CNT_IRQ | \
@@ -3063,7 +3064,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct xilinx_dma_device *xdev;
 	struct device_node *child, *np = pdev->dev.of_node;
-	u32 num_frames, addr_width, len_width;
+	u32 num_frames, addr_width = XILINX_DMA_DFAULT_ADDRWIDTH, len_width;
 	int i, err;
 
 	/* Allocate and initialize the DMA engine structure */
@@ -3137,7 +3138,9 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	err = of_property_read_u32(node, "xlnx,addrwidth", &addr_width);
 	if (err < 0)
-		dev_warn(xdev->dev, "missing xlnx,addrwidth property\n");
+		dev_warn(xdev->dev,
+			 "missing xlnx,addrwidth property, using default value %d\n",
+			 XILINX_DMA_DFAULT_ADDRWIDTH);
 
 	if (addr_width > 32)
 		xdev->ext_addr = true;
-- 
2.51.0




