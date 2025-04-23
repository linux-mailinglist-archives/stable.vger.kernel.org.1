Return-Path: <stable+bounces-135496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4A8A98EA0
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D211B66963
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AE627CCC7;
	Wed, 23 Apr 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YEDKF18T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2E175BF;
	Wed, 23 Apr 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420076; cv=none; b=UnX7d+Cio12iFRl84xw65gZJYvWLjZmmlOXNf2lXBOF7pLXPL2KPMB3JRSMfdcYXKoLAmundxAQwqcfwfhW4IDvVkPscoNuHEuBeKo3QL/Hs6iGlMUN0gOtllgza2QnlUXsWYyFpIUqwWkg+SXi12h1X9A99HjX5WyVEJCar66M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420076; c=relaxed/simple;
	bh=HkK9F02ZSU2e2MfaqlbpJJ3BGpv92mF0EvJeMXjuAXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrPp4jdqaF1NUY7mgYkHsHv2z4NPa1pP3TsBcT+9OzHgjJpCtvxAk+k8i/ZllbqK6OmKVdAcEno6biLGvFfFIBF+I4WupecVJam6B0G6Kb51q4BeHFAmlWgCBgI9CNKaNquTrAYjcpD5MnGuColK+ID+52b+jHjEeq0G+PxKNsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YEDKF18T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E390AC4CEE2;
	Wed, 23 Apr 2025 14:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420076;
	bh=HkK9F02ZSU2e2MfaqlbpJJ3BGpv92mF0EvJeMXjuAXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YEDKF18TuMWYa/XYenqBOlUkotBmvuCK4UksPRtUb23wXKMVninv5PmdLAty9Yfh2
	 tixw07KIVXWsGmqmC/wwSmT/Kz3wqTV0hQENrZhcoEXixhv382d9HzXlI0ovT+3qux
	 jn8ovDAFpv/zEb9pDcSjG0nhDIDedAvI0i+X4468=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yong Wu <yong.wu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH 6.6 036/393] iommu/mediatek: Fix NULL pointer deference in mtk_iommu_device_group
Date: Wed, 23 Apr 2025 16:38:52 +0200
Message-ID: <20250423142644.781164196@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

[ Upstream commit 38e8844005e6068f336a3ad45451a562a0040ca1 ]

Currently, mtk_iommu calls during probe iommu_device_register before
the hw_list from driver data is initialized. Since iommu probing issue
fix, it leads to NULL pointer dereference in mtk_iommu_device_group when
hw_list is accessed with list_first_entry (not null safe).

So, change the call order to ensure iommu_device_register is called
after the driver data are initialized.

Fixes: 9e3a2a643653 ("iommu/mediatek: Adapt sharing and non-sharing pgtable case")
Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org> # MT8183 Juniper, MT8186 Tentacruel
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Link: https://lore.kernel.org/r/20250403-fix-mtk-iommu-error-v2-1-fe8b18f8b0a8@collabora.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/mtk_iommu.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index de698463e94ad..06c0770ff894e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1354,15 +1354,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 	mutex_init(&data->mutex);
 
-	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
-				     "mtk-iommu.%pa", &ioaddr);
-	if (ret)
-		goto out_link_remove;
-
-	ret = iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
-	if (ret)
-		goto out_sysfs_remove;
-
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, SHARE_PGTABLE)) {
 		list_add_tail(&data->list, data->plat_data->hw_list);
 		data->hw_list = data->plat_data->hw_list;
@@ -1372,19 +1363,28 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		data->hw_list = &data->hw_list_head;
 	}
 
+	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
+				     "mtk-iommu.%pa", &ioaddr);
+	if (ret)
+		goto out_list_del;
+
+	ret = iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
+	if (ret)
+		goto out_sysfs_remove;
+
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 		if (ret)
-			goto out_list_del;
+			goto out_device_unregister;
 	}
 	return ret;
 
-out_list_del:
-	list_del(&data->list);
+out_device_unregister:
 	iommu_device_unregister(&data->iommu);
 out_sysfs_remove:
 	iommu_device_sysfs_remove(&data->iommu);
-out_link_remove:
+out_list_del:
+	list_del(&data->list);
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
 		device_link_remove(data->smicomm_dev, dev);
 out_runtime_disable:
-- 
2.39.5




