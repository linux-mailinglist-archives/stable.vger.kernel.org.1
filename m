Return-Path: <stable+bounces-110098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA27A18A5A
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 04:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D417A3374
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 03:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158B71494A9;
	Wed, 22 Jan 2025 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF5151R6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53691DFF0
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 03:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737515304; cv=none; b=Nitokk9bLucpHzz/6XB7zDWZSo4zrnkOOM18nDB+NKZ1qC0zKFJU4RIt8aUczfgHOVKWpW8S0Enl14xQKEpP3SB38h/eCq+RVfgbzplmZ8Ba60es9e12hYidzkVzt8iURWWKhDZ8KNklGFM+NxmvF45D5FeOdFA6qs0hWeAxhm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737515304; c=relaxed/simple;
	bh=mraXNu2t/S4MHu2NkG57rmLSMxeuSH1yg3RheRkRpY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tC5+9WPYTNQvLN7MwvNWUxFYp9cacciuQjQutPXeeyNqX7X+Be8a8kVPecWsxKDuLwoNLnnlpDcg3G25+iIiviACCA/WmfjM2wSWTk5I7NOshfy5O6/qtx4DQBHTw13F43OzublBs/9adY1O/YjQUB5Xjebf3DUTv4Y8f9Gp1tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF5151R6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA3FC4CEDF;
	Wed, 22 Jan 2025 03:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737515304;
	bh=mraXNu2t/S4MHu2NkG57rmLSMxeuSH1yg3RheRkRpY4=;
	h=From:To:Cc:Subject:Date:From;
	b=DF5151R65Vbm8nKL+vKOQ5zZOfKbygjf21whvcNZLMAgOjBd+Hx/1ihsOUzQyKaYq
	 QeemAmx1fCLWV4DKnXg6UUZaU1kjft5As4hMq595JY25veZlNUnGoxyGAc+2CmUfoa
	 oTKSPdvhVUaAJXYm01m9dgnnTKeq49Uk6XM2Lhbye9uO49QoLlxx1wQGmoEgD/sbBt
	 bYCNiWR241DIbLjzaGANRyXGtPWnQpOHQ3r+eZXz2Tg+XklU5cG9iNsHRiANNUpuRH
	 kL7F8Tgj/kCXjJLfwCi/k/hqamrTOyH+16Kj4S+HeVLVvj1dsCMSBiY+Fo/GcGkYib
	 AhhPS7eZrRNyw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: broonie@kernel.org,
	rafael@kernel.org,
	demonsingur@gmail.com,
	tzungbi@kernel.org
Subject: [PATCH 6.1.y] regmap: detach regmap from dev on regmap_exit
Date: Wed, 22 Jan 2025 03:08:10 +0000
Message-ID: <20250122030810.1484801-1-tzungbi@kernel.org>
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
- 48dc44f3c1afa29390cb2fbc8badad1b1111cea4 backported it incorrectly.
- 276185236bd8281dca88863b751b481e027cada7 reverted the wrong commit.
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
Link: https://lore.kernel.org/r/20250115033244.2540522-1-tzungbi@kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/base/regmap/regmap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 15b37a4163d3..f0e314abcafc 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -652,6 +652,17 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
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
@@ -1536,6 +1547,7 @@ void regmap_exit(struct regmap *map)
 {
 	struct regmap_async *async;
 
+	regmap_detach_dev(map->dev, map);
 	regcache_exit(map);
 	regmap_debugfs_exit(map);
 	regmap_range_exit(map);
-- 
2.48.0.rc2.279.g1de40edade-goog


