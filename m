Return-Path: <stable+bounces-200001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F00DFCA3630
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 12:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C2C93014594
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 11:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AD62EA732;
	Thu,  4 Dec 2025 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OA0zEY7/"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFE73112B4;
	Thu,  4 Dec 2025 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764846325; cv=none; b=XDJtB4SJ3zzo3eL1eAqjffJow1f7W3DMGdeF1OFz6+608nTKAbEJ8yFXb42FAZLg9sya8HI6jQY/FNW4tMUivW8h+SHwWIan5fyNxrh3f8kKSaimoAIqB91z5kFDWyckPH7nfXkB2YoewmrGl7w9YnLhZYNshOARQE6G9rlrXzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764846325; c=relaxed/simple;
	bh=0mvOBvBEL09+28z69xNunFxEsCaASNIcOrfjZHbD7CA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B7jFN7R2yPupYqNdmzxZLF8bieO4PO2VPpzZthXef9E1AUhnBf+1xidpflBsqtaSp2i/wYumeTivwOwTl/RYFkK0nR61zcVf7fb9BmyXTGnBaFKtXQxeXorAgrl9hj3DHFbQOwHs1O7GBKL+g6qr1iYsrl56sWyELWogt7fXGeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OA0zEY7/; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1f
	JcygxJ8ktEMFPvVfhD1h7orWfXdouaakmxwB4pUxs=; b=OA0zEY7/4TPdJ25Cut
	alV6aIG2a/7/USN59kLCRmdrNByPTLnLhF6VG18YOXU1pQTY/wMCdh4QhLgo6h3F
	VQWYF1UWixF6LJmkMQI2v+Db0/TSZRDiLiKjnwXX54n6xxnqdajmGoGJm8oeZXLi
	AIrzjpJ1/iJXJc2/FX8DnMYrs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wB36w7WajFpT_14EQ--.41851S4;
	Thu, 04 Dec 2025 19:04:55 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	khilman@baylibre.com,
	roger.lu@mediatek.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] soc: mediatek: SVS: Fix a reference leak bug in svs_add_device_link()
Date: Thu,  4 Dec 2025 19:04:52 +0800
Message-Id: <20251204110452.93867-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB36w7WajFpT_14EQ--.41851S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW3GryUuFW8Wr43ur4DJwb_yoWkCrX_Gr
	9FvFy7Xrn8Jr1fKF4xtF13AryS9Fs7t3ykGFy5t3WSqrW5WFyjqF90vrZ0qFZru3y8CFyU
	XF1UWF4xKF4rGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRM4E_DUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxhd25GkxatfZEgAA3t

svs_get_subsys_device() increases the reference count of the returned
device, if error happens, put_device() is required to drop the device
reference.

Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/soc/mediatek/mtk-svs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index f45537546553..c8f15bb139c6 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2155,12 +2155,15 @@ static struct device *svs_add_device_link(struct svs_platform *svsp,
 	sup_link = device_link_add(svsp->dev, dev,
 				   DL_FLAG_AUTOREMOVE_CONSUMER);
 	if (!sup_link) {
+		put_device(dev);
 		dev_err(svsp->dev, "sup_link is NULL\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (sup_link->supplier->links.status != DL_DEV_DRIVER_BOUND)
+	if (sup_link->supplier->links.status != DL_DEV_DRIVER_BOUND) {
+		put_device(dev);
 		return ERR_PTR(-EPROBE_DEFER);
+	}
 
 	return dev;
 }
-- 
2.25.1


