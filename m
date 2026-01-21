Return-Path: <stable+bounces-211043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBMfIqIscWl1fAAAu9opvQ
	(envelope-from <stable+bounces-211043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:44:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA585C6FB
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0814D7AD63D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067E93A4F5D;
	Wed, 21 Jan 2026 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RkMe6AtD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5953E36A020;
	Wed, 21 Jan 2026 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020245; cv=none; b=YpYzGI9f4HR0OWdGtWvpiFeEeOz66o4qZccbD3n1D7Mqdy/ezRiWXQoQXP5cdwOv6ezcZyZfnwaZVk6W5bkNEOugz/Otqp5sDFDrLpQGmCQQA3NUnH2fl9ETSfHE+2qUQQ13n3bkoGzDRzFKxNLidXHbk103ugry5Wap9RDX9Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020245; c=relaxed/simple;
	bh=LCeDyh2gzMOPLfLBxep+i+MQICqkYjvX3ZPr7OM8CL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqyItBPAtYkXNPVaUdVljW3litVniwwpw/N7Cm9r/GRkVsPl6SdutBdPz3AvtCEkBYetQNIn+y0QUSDz1hSDoBBjuz7Cvs+H6plNSMLG3Sif7zjyL43K9khv7NzoEZWdFnHom+emg/17QG+SArhvJaVd4bU/u/d1yvHSPsx17wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RkMe6AtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2594C4CEF1;
	Wed, 21 Jan 2026 18:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020245;
	bh=LCeDyh2gzMOPLfLBxep+i+MQICqkYjvX3ZPr7OM8CL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkMe6AtDd1V55LuLN6dyQzJX+/s9I7sROUMBHlnz+372wkVbom7W0Lo4+kXVtMkhW
	 5z5llfCRIiXj3PAzIZ0YhNRU1MfCg7l+oSfhluUT8u/6E5TmAWax5J09bJ+NRypjqV
	 Dy07i/wcpgG/57H7DDMg6bSEwuvXrbR8kKOyZjyI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Guodong Xu <guodong@riscstar.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 6.18 069/198] dmaengine: mmp_pdma: fix DMA mask handling
Date: Wed, 21 Jan 2026 19:14:57 +0100
Message-ID: <20260121181421.041889903@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-211043-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linaro.org:email]
X-Rspamd-Queue-Id: 4EA585C6FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guodong Xu <guodong@riscstar.com>

[ Upstream commit 49400b701eca849c1b53717b1f5d779a8d066ec0 ]

The driver's existing logic for setting the DMA mask for "marvell,pdma-1.0"
was flawed. It incorrectly relied on pdev->dev->coherent_dma_mask instead
of declaring the hardware's fixed addressing capability. A cleaner and
more correct approach is to define the mask directly based on the hardware
limitations.

The MMP/PXA PDMA controller is a 32-bit DMA engine. This is supported by
datasheets and various dtsi files for PXA25x, PXA27x, PXA3xx, and MMP2,
all of which are 32-bit systems.

This patch simplifies the driver's logic by replacing the 'u64 dma_mask'
field with a simpler 'u32 dma_width' to store the addressing capability
in bits. The complex if/else block in probe() is then replaced with a
single, clear call to dma_set_mask_and_coherent(). This sets a fixed
32-bit DMA mask for "marvell,pdma-1.0" and a 64-bit mask for
"spacemit,k1-pdma," matching each device's hardware capabilities.

Finally, this change also works around a specific build error encountered
with clang-20 on x86_64 allyesconfig. The shift-count-overflow error is
caused by a known clang compiler issue where the DMA_BIT_MASK(n) macro's
ternary operator is not correctly evaluated in static initializers. By
moving the macro's evaluation into the probe() function, the driver avoids
this compiler bug.

Fixes: 5cfe585d8624 ("dmaengine: mmp_pdma: Add SpacemiT K1 PDMA support with 64-bit addressing")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://lore.kernel.org/lkml/CA+G9fYsPcMfW-e_0_TRqu4cnwqOqYF3aJOeKUYk6Z4qRStdFvg@mail.gmail.com
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Nathan Chancellor <nathan@kernel.org> # build
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/mmp_pdma.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index d07229a748868..86661eb3cde1f 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -152,8 +152,8 @@ struct mmp_pdma_phy {
  *
  * Controller Configuration:
  * @run_bits:   Control bits in DCSR register for channel start/stop
- * @dma_mask:   DMA addressing capability of controller. 0 to use OF/platform
- *              settings, or explicit mask like DMA_BIT_MASK(32/64)
+ * @dma_width:  DMA addressing width in bits (32 or 64). Determines the
+ *              DMA mask capability of the controller hardware.
  */
 struct mmp_pdma_ops {
 	/* Hardware Register Operations */
@@ -173,7 +173,7 @@ struct mmp_pdma_ops {
 
 	/* Controller Configuration */
 	u32 run_bits;
-	u64 dma_mask;
+	u32 dma_width;
 };
 
 struct mmp_pdma_device {
@@ -1172,7 +1172,7 @@ static const struct mmp_pdma_ops marvell_pdma_v1_ops = {
 	.get_desc_src_addr = get_desc_src_addr_32,
 	.get_desc_dst_addr = get_desc_dst_addr_32,
 	.run_bits = (DCSR_RUN),
-	.dma_mask = 0,			/* let OF/platform set DMA mask */
+	.dma_width = 32,
 };
 
 static const struct mmp_pdma_ops spacemit_k1_pdma_ops = {
@@ -1185,7 +1185,7 @@ static const struct mmp_pdma_ops spacemit_k1_pdma_ops = {
 	.get_desc_src_addr = get_desc_src_addr_64,
 	.get_desc_dst_addr = get_desc_dst_addr_64,
 	.run_bits = (DCSR_RUN | DCSR_LPAEEN),
-	.dma_mask = DMA_BIT_MASK(64),	/* force 64-bit DMA addr capability */
+	.dma_width = 64,
 };
 
 static const struct of_device_id mmp_pdma_dt_ids[] = {
@@ -1314,13 +1314,9 @@ static int mmp_pdma_probe(struct platform_device *op)
 	pdev->device.directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
 	pdev->device.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 
-	/* Set DMA mask based on ops->dma_mask, or OF/platform */
-	if (pdev->ops->dma_mask)
-		dma_set_mask(pdev->dev, pdev->ops->dma_mask);
-	else if (pdev->dev->coherent_dma_mask)
-		dma_set_mask(pdev->dev, pdev->dev->coherent_dma_mask);
-	else
-		dma_set_mask(pdev->dev, DMA_BIT_MASK(64));
+	/* Set DMA mask based on controller hardware capabilities */
+	dma_set_mask_and_coherent(pdev->dev,
+				  DMA_BIT_MASK(pdev->ops->dma_width));
 
 	ret = dma_async_device_register(&pdev->device);
 	if (ret) {
-- 
2.51.0




