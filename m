Return-Path: <stable+bounces-211046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHcuKUcgcWmodQAAu9opvQ
	(envelope-from <stable+bounces-211046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:51:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD625B8B9
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF04270CE04
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8B23AA1AF;
	Wed, 21 Jan 2026 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VkNhF5mX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185535FF77;
	Wed, 21 Jan 2026 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020256; cv=none; b=D6vlZDWtwwLUgMpMU6kqpa65yXDeCl4wzHsO6HW+5ZV/175avrf++PFoUa+F3zw3Xn3uEnvNU1UgIYC28E36558UvgeXVCcHjJ3+Vgk4+R647S4qRNAmWBrMmNz9mpV/g1USymjFIGKZ7Op0W4fdPU1TH19vS+0G8tOXJkjV7aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020256; c=relaxed/simple;
	bh=R+k+LzttcZRCGrnAp5i0UmakYZJms+U/JMW/szBYFto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNe6yYOhcOPrrXt0XZ5bYUkHtPDDuD1UOjGQbVhLaWJKslX8NEdyNEID1L9Els26+BmxMAPc03kyw/esAKb2QmMr/QEkxkjiqb20f58TXMAcvtpxyQSpU37/25oyQ4PY0xAzX81iWoMgeE4FZZmck6qqivxoXFVN3ZR5zYZK3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VkNhF5mX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00652C16AAE;
	Wed, 21 Jan 2026 18:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020255;
	bh=R+k+LzttcZRCGrnAp5i0UmakYZJms+U/JMW/szBYFto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkNhF5mXiLVXYqOszbBONzGaKmgmE1/dJHgOfjKNkHBf7gKqypgbaeNCNFgAuH7eP
	 svAVnoOoTQ5CRkiiA3uZLcJbkBgUdj5junk9yQqsC1spq+nSLBEfR09X+6tFEoXdUO
	 LCHnQkVvcTHYEWNT8nZ2qnof3bxgIvWctVq6ucDg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Suraj Gupta <suraj.gupta2@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Folker Schwesinger <dev@folker-schwesinger.de>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 072/198] dmaengine: xilinx_dma: Fix uninitialized addr_width when "xlnx,addrwidth" property is missing
Date: Wed, 21 Jan 2026 19:15:00 +0100
Message-ID: <20260121181421.149855570@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211046-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,amd.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 4DD625B8B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index fabff602065f6..89a8254d9cdc6 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -131,6 +131,7 @@
 #define XILINX_MCDMA_MAX_CHANS_PER_DEVICE	0x20
 #define XILINX_DMA_MAX_CHANS_PER_DEVICE		0x2
 #define XILINX_CDMA_MAX_CHANS_PER_DEVICE	0x1
+#define XILINX_DMA_DFAULT_ADDRWIDTH		0x20
 
 #define XILINX_DMA_DMAXR_ALL_IRQ_MASK	\
 		(XILINX_DMA_DMASR_FRM_CNT_IRQ | \
@@ -3159,7 +3160,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct xilinx_dma_device *xdev;
 	struct device_node *child, *np = pdev->dev.of_node;
-	u32 num_frames, addr_width, len_width;
+	u32 num_frames, addr_width = XILINX_DMA_DFAULT_ADDRWIDTH, len_width;
 	int i, err;
 
 	/* Allocate and initialize the DMA engine structure */
@@ -3235,7 +3236,9 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
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




