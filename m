Return-Path: <stable+bounces-203673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47766CE74B1
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23E26301C937
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B9A32A3CF;
	Mon, 29 Dec 2025 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yPNNgUja"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3994932E748
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767024310; cv=none; b=XMNJkczeKCIPp/Xc3KVDpz7ENHijiiVNKPkH3O5k+4S3e+6rU0y7sIKhqmlfGqympoQD8flFzr+68GxQxRh8heCXb/VwJgNVEIrbPowkYGNFjnxJ9GKsVhdg1e30YJCkWpKg19/ryNHegSz1DGllJekdcdTGwQEAeGSgG+JqkuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767024310; c=relaxed/simple;
	bh=hrS/Dq40MXaV0T4hZ5oaRVbDv1kIGsTRVofuIODfRY4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FNj5GnNt/rqSN+FD9Qj8UrjAMS4817C6j2+mLBp8tYiB1M15JBsUMDRzSLbL4iwTnDNf9qAyQbeSHqg8FZLrdv6jKj9McBWUMtY/KQ9zKyiw1m5Xsyh77yG+iFfGmS15ChfOnw3TcYlx6erNMr1yoCNs2G/AXNZbtf/SGK8yGZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yPNNgUja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B376AC19423;
	Mon, 29 Dec 2025 16:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767024310;
	bh=hrS/Dq40MXaV0T4hZ5oaRVbDv1kIGsTRVofuIODfRY4=;
	h=Subject:To:Cc:From:Date:From;
	b=yPNNgUjaXRrCXv13My4lt4iDM1P1nqtycOYrxYFaQPfxcxOs+hUv1vc5mz/EQiRG6
	 S30GP3kCfaMX7DpviHZNsKQ1DvNpRVghIo0qf8jO+s1Jiqqqkv6ZFu7swaUu+1SRMq
	 C08m42K3Khy4rR5F5YyWFMUXDMA52Hd5y7JzZZs4=
Subject: FAILED: patch "[PATCH] iommu/mediatek: fix use-after-free on probe deferral" failed to apply to 6.1-stable tree
To: johan@kernel.org,angelogioacchino.delregno@collabora.com,joerg.roedel@amd.com,robin.murphy@arm.com,yong.wu@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 17:01:42 +0100
Message-ID: <2025122941-reluctant-exhale-a49f@gregkh>
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
git cherry-pick -x de83d4617f9fe059623e97acf7e1e10d209625b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122941-reluctant-exhale-a49f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From de83d4617f9fe059623e97acf7e1e10d209625b5 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 20 Oct 2025 06:53:10 +0200
Subject: [PATCH] iommu/mediatek: fix use-after-free on probe deferral

The driver is dropping the references taken to the larb devices during
probe after successful lookup as well as on errors. This can
potentially lead to a use-after-free in case a larb device has not yet
been bound to its driver so that the iommu driver probe defers.

Fix this by keeping the references as expected while the iommu driver is
bound.

Fixes: 26593928564c ("iommu/mediatek: Add error path for loop of mm_dts_parse")
Cc: stable@vger.kernel.org
Cc: Yong Wu <yong.wu@mediatek.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 82a55fe19a62..54d8936d9d11 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1213,16 +1213,19 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 		}
 
 		component_match_add(dev, match, component_compare_dev, &plarbdev->dev);
-		platform_device_put(plarbdev);
 	}
 
-	if (!frst_avail_smicomm_node)
-		return -EINVAL;
+	if (!frst_avail_smicomm_node) {
+		ret = -EINVAL;
+		goto err_larbdev_put;
+	}
 
 	pcommdev = of_find_device_by_node(frst_avail_smicomm_node);
 	of_node_put(frst_avail_smicomm_node);
-	if (!pcommdev)
-		return -ENODEV;
+	if (!pcommdev) {
+		ret = -ENODEV;
+		goto err_larbdev_put;
+	}
 	data->smicomm_dev = &pcommdev->dev;
 
 	link = device_link_add(data->smicomm_dev, dev,
@@ -1230,7 +1233,8 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 	platform_device_put(pcommdev);
 	if (!link) {
 		dev_err(dev, "Unable to link %s.\n", dev_name(data->smicomm_dev));
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_larbdev_put;
 	}
 	return 0;
 
@@ -1402,8 +1406,12 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&data->iommu);
 out_list_del:
 	list_del(&data->list);
-	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
+	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		device_link_remove(data->smicomm_dev, dev);
+
+		for (i = 0; i < MTK_LARB_NR_MAX; i++)
+			put_device(data->larb_imu[i].dev);
+	}
 out_runtime_disable:
 	pm_runtime_disable(dev);
 	return ret;
@@ -1423,6 +1431,9 @@ static void mtk_iommu_remove(struct platform_device *pdev)
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		device_link_remove(data->smicomm_dev, &pdev->dev);
 		component_master_del(&pdev->dev, &mtk_iommu_com_ops);
+
+		for (i = 0; i < MTK_LARB_NR_MAX; i++)
+			put_device(data->larb_imu[i].dev);
 	}
 	pm_runtime_disable(&pdev->dev);
 	for (i = 0; i < data->plat_data->banks_num; i++) {


