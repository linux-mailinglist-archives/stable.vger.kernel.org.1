Return-Path: <stable+bounces-134833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10F4A95258
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 16:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE80E1732E4
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 14:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAB2BA42;
	Mon, 21 Apr 2025 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vMq6yIBp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D348800
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244122; cv=none; b=EllU0mhppZDqXyyjzbTiphEpCg4SnMHHtvB2VNuVCK4IEzXeb8S3THUOejw+KsRt4euUOgg6HY0oUIGSe2fTuD/btGNfQ1pPeTppYRnwubmIDGKYihm7/SWwn3qVN6S7OdElML+aZPMee+OD6xLLIGuGrQV7Bm12LtMpdyc45O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244122; c=relaxed/simple;
	bh=iEaa34+WUjRvyCVC2FV+TjR5GVoGqJxF8BtczKIjJ+I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ph2jtMDrb5qU11vNM1jbkqAJufHk+oHB9IFrFuVPincyYxNiFM71uleuglWCHvTiE2jFW1HbYS034wuX1NwbHYQ4QTWupjFqcNKH6BHdd+h9pg9+Kh18v6lHxrWI6AZsPkZiIFOPLXm+qXUrypfkuP7JAQKN/YkO2hyon/ZZW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vMq6yIBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36611C4CEE4;
	Mon, 21 Apr 2025 14:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745244121;
	bh=iEaa34+WUjRvyCVC2FV+TjR5GVoGqJxF8BtczKIjJ+I=;
	h=Subject:To:Cc:From:Date:From;
	b=vMq6yIBprh/l45qhDgpmKPxdbU6+ToP0PYxgdztqNfhFAvcf7KJ+xoGoOhl+aKdUJ
	 1bdr+MarvcKWSMwFse/9Q2IZioGIQU9+YqI4NPr97BtUhsSd/dr6Kdmledx1TK8QnP
	 P0G/lPKqHFcrn/wpSFYNZmLIaPe+3lDljNCw2DPw=
Subject: FAILED: patch "[PATCH] scsi: ufs: exynos: Disable iocc if dma-coherent property" failed to apply to 6.1-stable tree
To: peter.griffin@linaro.org,bvanassche@acm.org,chanho61.park@samsung.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 16:01:51 +0200
Message-ID: <2025042151-backdrop-broadside-667d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f92bb7436802f8eb7ee72dc911a33c8897fde366
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042151-backdrop-broadside-667d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f92bb7436802f8eb7ee72dc911a33c8897fde366 Mon Sep 17 00:00:00 2001
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 19 Mar 2025 15:30:20 +0000
Subject: [PATCH] scsi: ufs: exynos: Disable iocc if dma-coherent property
 isn't set

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

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 1d4603f7622d..533904a4c1a7 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -214,8 +214,8 @@ static int exynos_ufs_shareability(struct exynos_ufs *ufs)
 	/* IO Coherency setting */
 	if (ufs->sysreg) {
 		return regmap_update_bits(ufs->sysreg,
-					  ufs->shareability_reg_offset,
-					  ufs->iocc_mask, ufs->iocc_mask);
+					  ufs->iocc_offset,
+					  ufs->iocc_mask, ufs->iocc_val);
 	}
 
 	return 0;
@@ -1173,13 +1173,22 @@ static int exynos_ufs_parse_dt(struct device *dev, struct exynos_ufs *ufs)
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
 
diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index ad49d9cdd5c1..d0b3df221503 100644
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


