Return-Path: <stable+bounces-136004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C80BA99155
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5479817E418
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB27029009C;
	Wed, 23 Apr 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qfXzAnwq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A7F27F4D9;
	Wed, 23 Apr 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421402; cv=none; b=lgjIS2vo3i07FDIcvXruRCVhdfZImJm7vCTSOMFAcHXDcvfho9Dc1NghFz4jIs9FHoF4c0Uq80Hr1Yavdfg/P6MhaYz324ezyBSwYMnEBSCYGo3kM+DuZVG8mqGP/5Vp+6AXB3OwLNdJjWCYZN+n9P7wrmdNb1oMbVO1IiWu1m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421402; c=relaxed/simple;
	bh=tCJf6gMl/6vR1YTVgzhX0JzoQorK55+6q5NgNXnr+Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELD6ZvBovkLrgeDG/sqMYO5Llk6sO/tp1zQtn2Y9vE1+eJJTPnXr90DufMG915GxxGg10MWCZ+U3+jHsmF+ydLXgVKlTt7xHKRvUmKmK6naS+o8o7h3keG88+6t9nnHpQms1cDMyNwxOUfp0ul3u/UIZIP8h52F1cutXDcHrRBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qfXzAnwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB68C4CEE2;
	Wed, 23 Apr 2025 15:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421402;
	bh=tCJf6gMl/6vR1YTVgzhX0JzoQorK55+6q5NgNXnr+Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfXzAnwqsrv8714p+smEW0xmiy3biog6pvf04flKH7yXlJatg1VNrIAgEXVKxszAN
	 Adi5qH8Ua9gdBan3hW9cQKUZr9Irl5Vuf7Cs0NsdF+Zy3BfRieSs8zRIWx3EEI7i89
	 NB5nf+UH+HBLH79LNh8QGolxICW5KvksYNZkISLI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Chanho Park <chanho61.park@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.14 162/241] scsi: ufs: exynos: Disable iocc if dma-coherent property isnt set
Date: Wed, 23 Apr 2025 16:43:46 +0200
Message-ID: <20250423142627.154733524@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Griffin <peter.griffin@linaro.org>

commit f92bb7436802f8eb7ee72dc911a33c8897fde366 upstream.

If dma-coherent property isn't set then descriptors are non-cacheable
and the iocc shareability bits should be disabled. Without this UFS can
end up in an incompatible configuration and suffer from random cache
related stability issues.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Fixes: cc52e15397cc ("scsi: ufs: ufs-exynos: Support ExynosAuto v9 UFS")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Link: https://lore.kernel.org/r/20250319-exynos-ufs-stability-fixes-v2-3-96722cc2ba1b@linaro.org
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: stable@vger.kernel.org
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ufs/host/ufs-exynos.c |   17 +++++++++++++----
 drivers/ufs/host/ufs-exynos.h |    3 ++-
 2 files changed, 15 insertions(+), 5 deletions(-)

--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -214,8 +214,8 @@ static int exynos_ufs_shareability(struc
 	/* IO Coherency setting */
 	if (ufs->sysreg) {
 		return regmap_update_bits(ufs->sysreg,
-					  ufs->shareability_reg_offset,
-					  ufs->iocc_mask, ufs->iocc_mask);
+					  ufs->iocc_offset,
+					  ufs->iocc_mask, ufs->iocc_val);
 	}
 
 	return 0;
@@ -1173,13 +1173,22 @@ static int exynos_ufs_parse_dt(struct de
 		ufs->sysreg = NULL;
 	else {
 		if (of_property_read_u32_index(np, "samsung,sysreg", 1,
-					       &ufs->shareability_reg_offset)) {
+					       &ufs->iocc_offset)) {
 			dev_warn(dev, "can't get an offset from sysreg. Set to default value\n");
-			ufs->shareability_reg_offset = UFS_SHAREABILITY_OFFSET;
+			ufs->iocc_offset = UFS_SHAREABILITY_OFFSET;
 		}
 	}
 
 	ufs->iocc_mask = ufs->drv_data->iocc_mask;
+	/*
+	 * no 'dma-coherent' property means the descriptors are
+	 * non-cacheable so iocc shareability should be disabled.
+	 */
+	if (of_dma_is_coherent(dev->of_node))
+		ufs->iocc_val = ufs->iocc_mask;
+	else
+		ufs->iocc_val = 0;
+
 	ufs->pclk_avail_min = PCLK_AVAIL_MIN;
 	ufs->pclk_avail_max = PCLK_AVAIL_MAX;
 
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -231,8 +231,9 @@ struct exynos_ufs {
 	ktime_t entry_hibern8_t;
 	const struct exynos_ufs_drv_data *drv_data;
 	struct regmap *sysreg;
-	u32 shareability_reg_offset;
+	u32 iocc_offset;
 	u32 iocc_mask;
+	u32 iocc_val;
 
 	u32 opts;
 #define EXYNOS_UFS_OPT_HAS_APB_CLK_CTRL		BIT(0)



