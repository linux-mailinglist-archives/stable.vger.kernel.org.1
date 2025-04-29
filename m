Return-Path: <stable+bounces-138441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D60AA182A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAA6170805
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB238253348;
	Tue, 29 Apr 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SeIXA9dZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995642550B8;
	Tue, 29 Apr 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949265; cv=none; b=ocwlX/VScl/zqcB24J85fvElmUooYyT3u1VD0VkTVl9S4v4u26ca083YEj6xP/+CCjfpySqtqWH/sT7WOsF2awkvH6Y1IS+p0vEZC53PjDUVDNug3+jxRl3D/QIALfUhYxpxGtrwPBfvCb9BRvCOwY+RhPrmCKHcHAJ2AfvDJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949265; c=relaxed/simple;
	bh=zm1SGPGBas4ZmixD/8vPdF4p/Y/ap4hWDC4MTPN5+zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ii9s2tBnVZBxOz4V3e3sWcILko05ImchcaOzkigIn2NbGUG0YDLCUdDaWJzjHXZYM8/Wvy30ZnEZUEi6lPhXP8n/QJFObNFhN+hFLeK+G51IWFuQAXzUt4AXu2t+1Fq1uN4QIdWY8YSjOAe3+Hr5JvQf9H56/SdtiufkZNn89OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SeIXA9dZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB45C4CEE3;
	Tue, 29 Apr 2025 17:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949265;
	bh=zm1SGPGBas4ZmixD/8vPdF4p/Y/ap4hWDC4MTPN5+zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SeIXA9dZDZcbd2I0MJpIhXnNo5cWMWw6WXgSN3JJ+6vZUbE+tXQV98F5MCZBcSWw0
	 wGnjT4iefAuuyw44edicuyMlC1VSl9QtpkVd3pVg/YApKF0C7fbKC6kSRJWEHE92OZ
	 1pbwGAnqDvufK1t841GUByA+3bgiYOzBzMI8qZio=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Henrik Grimler <henrik@grimler.se>,
	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 264/373] soc: samsung: exynos-chipid: Pass revision reg offsets
Date: Tue, 29 Apr 2025 18:42:21 +0200
Message-ID: <20250429161133.979135174@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sam Protsenko <semen.protsenko@linaro.org>

[ Upstream commit c072c4ef7ef09e1d6470c48cf52570487589b76a ]

Old Exynos SoCs have both Product ID and Revision ID in one single
register, while new SoCs tend to have two separate registers for those
IDs. Implement handling of both cases by passing Revision ID register
offsets in driver data.

Previously existing macros for Exynos4210 (removed in this patch) were
incorrect:

    #define EXYNOS_SUBREV_MASK         (0xf << 4)
    #define EXYNOS_MAINREV_MASK        (0xf << 0)

Actual format of PRO_ID register in Exynos4210 (offset 0x0):

    [31:12] Product ID
      [9:8] Package information
      [7:4] Main Revision Number
      [3:0] Sub Revision Number

This patch doesn't change the behavior on existing platforms, so
'/sys/devices/soc0/revision' will show the same string as before.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Tested-by: Henrik Grimler <henrik@grimler.se>
Link: https://lore.kernel.org/r/20211014133508.1210-1-semen.protsenko@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Stable-dep-of: c8222ef6cf29 ("soc: samsung: exynos-chipid: Add NULL pointer check in exynos_chipid_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/samsung/exynos-chipid.c       | 69 +++++++++++++++++++----
 include/linux/soc/samsung/exynos-chipid.h |  6 +-
 2 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index dcd9a08ce7065..133654f21251f 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -24,6 +25,17 @@
 
 #include "exynos-asv.h"
 
+struct exynos_chipid_variant {
+	unsigned int rev_reg;		/* revision register offset */
+	unsigned int main_rev_shift;	/* main revision offset in rev_reg */
+	unsigned int sub_rev_shift;	/* sub revision offset in rev_reg */
+};
+
+struct exynos_chipid_info {
+	u32 product_id;
+	u32 revision;
+};
+
 static const struct exynos_soc_id {
 	const char *name;
 	unsigned int id;
@@ -49,31 +61,57 @@ static const char *product_id_to_soc_id(unsigned int product_id)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(soc_ids); i++)
-		if ((product_id & EXYNOS_MASK) == soc_ids[i].id)
+		if (product_id == soc_ids[i].id)
 			return soc_ids[i].name;
 	return NULL;
 }
 
+static int exynos_chipid_get_chipid_info(struct regmap *regmap,
+		const struct exynos_chipid_variant *data,
+		struct exynos_chipid_info *soc_info)
+{
+	int ret;
+	unsigned int val, main_rev, sub_rev;
+
+	ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &val);
+	if (ret < 0)
+		return ret;
+	soc_info->product_id = val & EXYNOS_MASK;
+
+	if (data->rev_reg != EXYNOS_CHIPID_REG_PRO_ID) {
+		ret = regmap_read(regmap, data->rev_reg, &val);
+		if (ret < 0)
+			return ret;
+	}
+	main_rev = (val >> data->main_rev_shift) & EXYNOS_REV_PART_MASK;
+	sub_rev = (val >> data->sub_rev_shift) & EXYNOS_REV_PART_MASK;
+	soc_info->revision = (main_rev << EXYNOS_REV_PART_SHIFT) | sub_rev;
+
+	return 0;
+}
+
 static int exynos_chipid_probe(struct platform_device *pdev)
 {
+	const struct exynos_chipid_variant *drv_data;
+	struct exynos_chipid_info soc_info;
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
 	struct device_node *root;
 	struct regmap *regmap;
-	u32 product_id;
-	u32 revision;
 	int ret;
 
+	drv_data = of_device_get_match_data(&pdev->dev);
+	if (!drv_data)
+		return -EINVAL;
+
 	regmap = device_node_to_regmap(pdev->dev.of_node);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &product_id);
+	ret = exynos_chipid_get_chipid_info(regmap, drv_data, &soc_info);
 	if (ret < 0)
 		return ret;
 
-	revision = product_id & EXYNOS_REV_MASK;
-
 	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
 				    GFP_KERNEL);
 	if (!soc_dev_attr)
@@ -86,8 +124,8 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	of_node_put(root);
 
 	soc_dev_attr->revision = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-						"%x", revision);
-	soc_dev_attr->soc_id = product_id_to_soc_id(product_id);
+						"%x", soc_info.revision);
+	soc_dev_attr->soc_id = product_id_to_soc_id(soc_info.product_id);
 	if (!soc_dev_attr->soc_id) {
 		pr_err("Unknown SoC\n");
 		return -ENODEV;
@@ -105,7 +143,7 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, soc_dev);
 
 	dev_info(&pdev->dev, "Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
-		 soc_dev_attr->soc_id, product_id, revision);
+		 soc_dev_attr->soc_id, soc_info.product_id, soc_info.revision);
 
 	return 0;
 
@@ -124,9 +162,18 @@ static int exynos_chipid_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct exynos_chipid_variant exynos4210_chipid_drv_data = {
+	.rev_reg	= 0x0,
+	.main_rev_shift	= 4,
+	.sub_rev_shift	= 0,
+};
+
 static const struct of_device_id exynos_chipid_of_device_ids[] = {
-	{ .compatible = "samsung,exynos4210-chipid" },
-	{}
+	{
+		.compatible	= "samsung,exynos4210-chipid",
+		.data		= &exynos4210_chipid_drv_data,
+	},
+	{ }
 };
 
 static struct platform_driver exynos_chipid_driver = {
diff --git a/include/linux/soc/samsung/exynos-chipid.h b/include/linux/soc/samsung/exynos-chipid.h
index 8bca6763f99c1..62f0e25310687 100644
--- a/include/linux/soc/samsung/exynos-chipid.h
+++ b/include/linux/soc/samsung/exynos-chipid.h
@@ -9,10 +9,8 @@
 #define __LINUX_SOC_EXYNOS_CHIPID_H
 
 #define EXYNOS_CHIPID_REG_PRO_ID	0x00
-#define EXYNOS_SUBREV_MASK		(0xf << 4)
-#define EXYNOS_MAINREV_MASK		(0xf << 0)
-#define EXYNOS_REV_MASK			(EXYNOS_SUBREV_MASK | \
-					 EXYNOS_MAINREV_MASK)
+#define EXYNOS_REV_PART_MASK		0xf
+#define EXYNOS_REV_PART_SHIFT		4
 #define EXYNOS_MASK			0xfffff000
 
 #define EXYNOS_CHIPID_REG_PKG_ID	0x04
-- 
2.39.5




