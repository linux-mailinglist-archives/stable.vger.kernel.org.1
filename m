Return-Path: <stable+bounces-204399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D86ECECACA
	for <lists+stable@lfdr.de>; Thu, 01 Jan 2026 00:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C696530124C6
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 23:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF2730F925;
	Wed, 31 Dec 2025 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHp69jhj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF943064A9
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767224342; cv=none; b=Q921hCZpaRIRwBYwGPKfXBSmrzdClB0TY8HBW94sX1jUzR3bGh9m1x0YGkvr1RS2wyKnCQ8OZfwd7B1df9rsct3BlPW9Kd34hgZ590N5M07Qhf04SL52ugn+YE80MeIUrwQlXOpwK4Y+iqVowWpUvHgR0wI7SJb7638IA1WC72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767224342; c=relaxed/simple;
	bh=dQ92F5m0cvYQ0BIrNzodFYLQ9eaMQPsnd9ZIArx1ccY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtlxR9cu1pLS+0VkCE6vsN3sp6j2XK20CGmVcB/h9xd+4Lkj+i5aSS3Ai8v3HPI1fk1pmTiuU4C9h8pXRmW305F9VHOU2ETTpXnT8v6nhoosOIa0eQQf7BzWjG1qmh+7C+sdLxcGRBm2luQ15X0r68GQqtcQejZqHUBxyIONWPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHp69jhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920FAC113D0;
	Wed, 31 Dec 2025 23:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767224341;
	bh=dQ92F5m0cvYQ0BIrNzodFYLQ9eaMQPsnd9ZIArx1ccY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mHp69jhjFimVfaDp1n5o+COGaGo7mfEgRWsmIlJqmvcnmFoAGcqeX0di9WpS0trDc
	 M3ynu3zYx+gPjFWVP9bHhClBAQA0wLiSuguT1nf+Rk5795ITXM3AyvBsKMeMV1PjsR
	 rXuMhsNYYO8Ve8PwAo3TtmQlArev9lIPNWADneDWpsxwfX86j12USxqRoC/P2yI6RE
	 SQjq3MOYlAzdj17YjLodiKfkTYpx3oTccx9OAExzaZpC9OML5MFaUTA5i6Qw0TD/ei
	 VoNBZ39eHPHwwie72xiD7GEZ83MtwnJGHAyFVxZvMuK01od8I0Px5kf2oaEb9TxYJ3
	 +oun2fxIPLPrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yong Wu <yong.wu@mediatek.com>,
	Guenter Roeck <groeck@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] iommu/mediatek: Improve safety for mediatek,smi property in larb nodes
Date: Wed, 31 Dec 2025 18:38:57 -0500
Message-ID: <20251231233858.3696664-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122941-reluctant-exhale-a49f@gregkh>
References: <2025122941-reluctant-exhale-a49f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yong Wu <yong.wu@mediatek.com>

[ Upstream commit 6cde583d5352818a51985b32a960cdde85ab3821 ]

No functional change. Just improve safety from dts.

All the larbs that connect to one IOMMU must connect with the same
smi-common. This patch checks all the mediatek,smi property for each
larb, If their mediatek,smi are different, it will return fails.
Also avoid there is no available smi-larb nodes.

Suggested-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Link: https://lore.kernel.org/r/20221018024258.19073-6-yong.wu@mediatek.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Stable-dep-of: de83d4617f9f ("iommu/mediatek: fix use-after-free on probe deferral")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/mtk_iommu.c | 53 +++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d4cb09b2e267..773cbd63ed5c 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1046,7 +1046,7 @@ static const struct component_master_ops mtk_iommu_com_ops = {
 static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **match,
 				  struct mtk_iommu_data *data)
 {
-	struct device_node *larbnode, *smicomm_node, *smi_subcomm_node;
+	struct device_node *larbnode, *frst_avail_smicomm_node = NULL;
 	struct platform_device *plarbdev, *pcommdev;
 	struct device_link *link;
 	int i, larb_nr, ret;
@@ -1058,6 +1058,7 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 		return -EINVAL;
 
 	for (i = 0; i < larb_nr; i++) {
+		struct device_node *smicomm_node, *smi_subcomm_node;
 		u32 id;
 
 		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
@@ -1098,27 +1099,47 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 			goto err_larbdev_put;
 		}
 
+		/* Get smi-(sub)-common dev from the last larb. */
+		smi_subcomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
+		if (!smi_subcomm_node) {
+			ret = -EINVAL;
+			goto err_larbdev_put;
+		}
+
+		/*
+		 * It may have two level smi-common. the node is smi-sub-common if it
+		 * has a new mediatek,smi property. otherwise it is smi-commmon.
+		 */
+		smicomm_node = of_parse_phandle(smi_subcomm_node, "mediatek,smi", 0);
+		if (smicomm_node)
+			of_node_put(smi_subcomm_node);
+		else
+			smicomm_node = smi_subcomm_node;
+
+		/*
+		 * All the larbs that connect to one IOMMU must connect with the same
+		 * smi-common.
+		 */
+		if (!frst_avail_smicomm_node) {
+			frst_avail_smicomm_node = smicomm_node;
+		} else if (frst_avail_smicomm_node != smicomm_node) {
+			dev_err(dev, "mediatek,smi property is not right @larb%d.", id);
+			of_node_put(smicomm_node);
+			ret = -EINVAL;
+			goto err_larbdev_put;
+		} else {
+			of_node_put(smicomm_node);
+		}
+
 		component_match_add(dev, match, component_compare_dev, &plarbdev->dev);
 		platform_device_put(plarbdev);
 	}
 
-	/* Get smi-(sub)-common dev from the last larb. */
-	smi_subcomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
-	if (!smi_subcomm_node)
+	if (!frst_avail_smicomm_node)
 		return -EINVAL;
 
-	/*
-	 * It may have two level smi-common. the node is smi-sub-common if it
-	 * has a new mediatek,smi property. otherwise it is smi-commmon.
-	 */
-	smicomm_node = of_parse_phandle(smi_subcomm_node, "mediatek,smi", 0);
-	if (smicomm_node)
-		of_node_put(smi_subcomm_node);
-	else
-		smicomm_node = smi_subcomm_node;
-
-	pcommdev = of_find_device_by_node(smicomm_node);
-	of_node_put(smicomm_node);
+	pcommdev = of_find_device_by_node(frst_avail_smicomm_node);
+	of_node_put(frst_avail_smicomm_node);
 	if (!pcommdev)
 		return -ENODEV;
 	data->smicomm_dev = &pcommdev->dev;
-- 
2.51.0


