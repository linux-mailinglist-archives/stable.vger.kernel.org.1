Return-Path: <stable+bounces-110099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C347A18A5B
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 04:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1DD3AAF48
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 03:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC2114A614;
	Wed, 22 Jan 2025 03:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLQyJYu/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0789145B0B
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 03:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737515316; cv=none; b=cHdN5KpnyBS93T/hnjo7BfhPlBVGvpBYoiOf4ZWSN1z2UVGAOTzlDVJlscLeaSEbwNOkUvh/GtkpZ2rvR//Qyj/MBkGacVuPmQ0c7qLPbM1OWi8sXG++qURMVXua1r7AQBEEQj7w7wNa3IPKCVqLh74VokhwUM5AQIUDSFtE5j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737515316; c=relaxed/simple;
	bh=VZIyMamhD0oIz9TM98CR2ZhTsCq1Z47HfDRhhNyD7bU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cn3xTDj1fdQ8etME8eCxSkFm8MaD1ozoawCuIvyC9xsU5fcHeISs3E0NfNV2lyeZtffEBQeOeeHj7dz3PFi85bwJvTUAJilVXWq5eTkppPHs3hdgHH4cJXvFc3TYgy28ZNiNzat+SEQRj+X/CrX5evaOguegNMO2k+zFtgCi3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLQyJYu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A03C4CEDF;
	Wed, 22 Jan 2025 03:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737515315;
	bh=VZIyMamhD0oIz9TM98CR2ZhTsCq1Z47HfDRhhNyD7bU=;
	h=From:To:Cc:Subject:Date:From;
	b=bLQyJYu/YFc2bWuuBV5B8DsBq9WHKTF4FyBEO4MRKkpIMKLuEaYSLDPWzlWQ2RFcH
	 BaWlEdABKFihc6TQtJWUAWICMb5Zl5gmp57ffB0novhjW8qoMf2Uzq0bKRat66enZi
	 uvCeMH05am/UjfyYBxGXBAPr6cQhGm+IimiY29hnkh12ZWcesLnS/3A6Yz3l9QhfvW
	 NVxa5PD4jgm+H0C2a1sGANYLxrRQSZ/NTebJQjhtKxcPTJ7TGxH/xL7NDYEO8qr1gc
	 vMDzLrx1Hcu+VQhVoe9EVyq43YhFr1A+ZjT+55jph5q90mpzVmXFMshUaimoDBj7v1
	 rJIvqtROEeOVw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: broonie@kernel.org,
	rafael@kernel.org,
	demonsingur@gmail.com,
	tzungbi@kernel.org
Subject: [PATCH 5.15.y] regmap: detach regmap from dev on regmap_exit
Date: Wed, 22 Jan 2025 03:08:27 +0000
Message-ID: <20250122030827.1484879-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cosmin Tanislav <demonsingur@gmail.com>

commit 3061e170381af96d1e66799d34264e6414d428a7 upstream.

This is a reland commit:
- f373a189817584d0af5f922e91cad40e45f12314 backported it incorrectly.
- 7aee9bcc5c56086af6c063b4aaef59d4e42e0a69 reverted the wrong commit.
- This re-backports it.

At the end of __regmap_init(), if dev is not NULL, regmap_attach_dev()
is called, which adds a devres reference to the regmap, to be able to
retrieve a dev's regmap by name using dev_get_regmap().

When calling regmap_exit, the opposite does not happen, and the
reference is kept until the dev is detached.

Add a regmap_detach_dev() function and call it in regmap_exit() to make
sure that the devres reference is not kept.

Cc: stable@vger.kernel.org
Fixes: 72b39f6f2b5a ("regmap: Implement dev_get_regmap()")
Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
Rule: add
Link: https://lore.kernel.org/stable/20241128130554.362486-1-demonsingur%40gmail.com
Link: https://patch.msgid.link/20241128131625.363835-1-demonsingur@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20250115033314.2540588-1-tzungbi@kernel.org
Link: https://lore.kernel.org/r/20250115033244.2540522-1-tzungbi@kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/base/regmap/regmap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 85d324fd6a87..6d94ad8bf1eb 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -663,6 +663,17 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 }
 EXPORT_SYMBOL_GPL(regmap_attach_dev);
 
+static int dev_get_regmap_match(struct device *dev, void *res, void *data);
+
+static int regmap_detach_dev(struct device *dev, struct regmap *map)
+{
+	if (!dev)
+		return 0;
+
+	return devres_release(dev, dev_get_regmap_release,
+			      dev_get_regmap_match, (void *)map->name);
+}
+
 static enum regmap_endian regmap_get_reg_endian(const struct regmap_bus *bus,
 					const struct regmap_config *config)
 {
@@ -1531,6 +1542,7 @@ void regmap_exit(struct regmap *map)
 {
 	struct regmap_async *async;
 
+	regmap_detach_dev(map->dev, map);
 	regcache_exit(map);
 	regmap_debugfs_exit(map);
 	regmap_range_exit(map);
-- 
2.48.0.rc2.279.g1de40edade-goog


