Return-Path: <stable+bounces-80019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEE598DB65
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32B41F21D67
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BFD1974F4;
	Wed,  2 Oct 2024 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z0chLq2a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F326E1D0B99;
	Wed,  2 Oct 2024 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879148; cv=none; b=aldr32e4KPLEjFvqu1M6o2A3fm7N4gaL82CR7FAT3RjUZDthRN2jFanqoVNw8rYmHnkvCWWmf+69/pPsUkJuXUpMPvjxZhdpsEBIweyaWCNLX+R+iOMJFAw6085MQTwAtijiSn/x8dkVoMt1Yb7DGezPVY++EQBMfnnaNpEocRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879148; c=relaxed/simple;
	bh=KMuZsSc5vyZT07+iYVyRFDeADnRq8qs7JsW3/KZ7TM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpYvkD3yDRPEbHit+uj/9uksTdn7qWNas16UvnO8xVIcVE1lT3tV+t+E7+meKMBhi9j/9xfZbCir0z56vtypBQn6BQB7R+7rLzWy0LRsBPyC+ok9dJ1cZRWcmt1YM+YYVXMhxUwa0QF66yt2zCnk8UHvnuYRLHG0C/fOC3jyhi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z0chLq2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DDEC4CEC2;
	Wed,  2 Oct 2024 14:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879147;
	bh=KMuZsSc5vyZT07+iYVyRFDeADnRq8qs7JsW3/KZ7TM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z0chLq2aBzKAuQ1GPLPrF1DZnd/FHsE9Lfc0jPw7gskETie0rSM2vlu6UN89kykwp
	 7+w7u8jE1nJlXjSIe0BqjmhIo66sU9J9M4azkygxUBfHhCtQRitvXmDkV7Tqeef5nz
	 YMZtuMb3VhmFUA3W/dJPPIRoomkkQ6D6gGwpl1zA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 002/538] EDAC/synopsys: Fix error injection on Zynq UltraScale+
Date: Wed,  2 Oct 2024 14:54:01 +0200
Message-ID: <20241002125752.071134272@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

[ Upstream commit 35e6dbfe1846caeafabb49b7575adb36b0aa2269 ]

The Zynq UltraScale+ MPSoC DDR has a disjoint memory from 2GB to 32GB.
The DDR host interface has a contiguous memory so while injecting
errors, the driver should remove the hole else the injection fails as
the address translation is incorrect.

Introduce a get_mem_info() function pointer and set it for Zynq
UltraScale+ platform to return host address.

Fixes: 1a81361f75d8 ("EDAC, synopsys: Add Error Injection support for ZynqMP DDR controller")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240711100656.31376-1-shubhrajyoti.datta@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/synopsys_edac.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 1ab2f737e4f16..6ddc90d7ba7c2 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
+#include <linux/sizes.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
 
@@ -337,6 +338,7 @@ struct synps_edac_priv {
  * @get_mtype:		Get mtype.
  * @get_dtype:		Get dtype.
  * @get_ecc_state:	Get ECC state.
+ * @get_mem_info:	Get EDAC memory info
  * @quirks:		To differentiate IPs.
  */
 struct synps_platform_data {
@@ -344,6 +346,9 @@ struct synps_platform_data {
 	enum mem_type (*get_mtype)(const void __iomem *base);
 	enum dev_type (*get_dtype)(const void __iomem *base);
 	bool (*get_ecc_state)(void __iomem *base);
+#ifdef CONFIG_EDAC_DEBUG
+	u64 (*get_mem_info)(struct synps_edac_priv *priv);
+#endif
 	int quirks;
 };
 
@@ -402,6 +407,25 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
 	return 0;
 }
 
+#ifdef CONFIG_EDAC_DEBUG
+/**
+ * zynqmp_get_mem_info - Get the current memory info.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Return: host interface address.
+ */
+static u64 zynqmp_get_mem_info(struct synps_edac_priv *priv)
+{
+	u64 hif_addr = 0, linear_addr;
+
+	linear_addr = priv->poison_addr;
+	if (linear_addr >= SZ_32G)
+		linear_addr = linear_addr - SZ_32G + SZ_2G;
+	hif_addr = linear_addr >> 3;
+	return hif_addr;
+}
+#endif
+
 /**
  * zynqmp_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
@@ -922,6 +946,9 @@ static const struct synps_platform_data zynqmp_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_ecc_state	= zynqmp_get_ecc_state,
+#ifdef CONFIG_EDAC_DEBUG
+	.get_mem_info	= zynqmp_get_mem_info,
+#endif
 	.quirks         = (DDR_ECC_INTR_SUPPORT
 #ifdef CONFIG_EDAC_DEBUG
 			  | DDR_ECC_DATA_POISON_SUPPORT
@@ -975,10 +1002,16 @@ MODULE_DEVICE_TABLE(of, synps_edac_match);
 static void ddr_poison_setup(struct synps_edac_priv *priv)
 {
 	int col = 0, row = 0, bank = 0, bankgrp = 0, rank = 0, regval;
+	const struct synps_platform_data *p_data;
 	int index;
 	ulong hif_addr = 0;
 
-	hif_addr = priv->poison_addr >> 3;
+	p_data = priv->p_data;
+
+	if (p_data->get_mem_info)
+		hif_addr = p_data->get_mem_info(priv);
+	else
+		hif_addr = priv->poison_addr >> 3;
 
 	for (index = 0; index < DDR_MAX_ROW_SHIFT; index++) {
 		if (priv->row_shift[index])
-- 
2.43.0




