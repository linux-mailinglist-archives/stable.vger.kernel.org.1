Return-Path: <stable+bounces-61981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4F793E19D
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 02:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943B01F21708
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 00:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F89184D;
	Sun, 28 Jul 2024 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ9eu14+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EFCA32;
	Sun, 28 Jul 2024 00:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127662; cv=none; b=q38kHAUyo4x84IZfkw2uznzfja6Y9gZJ7G1R4nwv4D6FLbFRzZZqN60cZKKKnPTUg14bWQP+k7vQ9qwx0yVNEaYIHf3cNgHYe+uxnv9osCUEXkqAISUhKKCfydb2xwetK72/mbBitlPJL1bnaNzKuipsFYcvzs4HCL/TJKX0HYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127662; c=relaxed/simple;
	bh=6GVrstaQLaIQb6kxuJeSsZibR8Kd7ku9m1ZJHzAaFt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSFBE/4QelDzzN/7sFGYTpAn6UH6MjdkmSMOc3qfOpk3elzcjDanZ6p9Xt/6RcyIhHeM/jbm9/7kkpsngJ2RAnHM9CcSsj1xrZMlkZM07QJom2ET838iLayIpXfzptH6diKH+pH7cpDhLq4q79qurQaFy/37U9dbpTVgHmsTIoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ9eu14+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D24C32781;
	Sun, 28 Jul 2024 00:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127662;
	bh=6GVrstaQLaIQb6kxuJeSsZibR8Kd7ku9m1ZJHzAaFt4=;
	h=From:To:Cc:Subject:Date:From;
	b=ZQ9eu14+vRIBf808ytWLhTISFwV4zmmaIzt+3XUQfyH5HW6QrpqFY6eT7p0tbEL7B
	 zHrR67Y8aGGniVJSp8TuSiVJ9f539A2vr4nkSgwrc0L+FuF/8jUSEOZdn02S8Y99ap
	 qy3JXgBVH1rmSZpdYYWTHe+/iVxle/yTKydxPBQjDiLI1eC1+G5R+iCrijiVTU5Gya
	 7UEYSIC3F9769yZV/SuWc8jDwWELyY3D7zGqy/DbLxTR+D/fYjPZ+fLZlwSIVvVu++
	 UVX3NEJ9wgXii3Navp9D2C91K1ii1+2t95/IIwnNtJZwaqkSdsyZahfGI0UbhZeYRZ
	 +HRjMoaGhTo4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 6.10 01/16] regmap: kunit: Fix memory leaks in gen_regmap() and gen_raw_regmap()
Date: Sat, 27 Jul 2024 20:47:18 -0400
Message-ID: <20240728004739.1698541-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit c3820641da87442251e0c00b6874ef1022da8f58 ]

- Use kunit_kcalloc() to allocate the defaults table so that it will be
  freed when the test case ends.
- kfree() the buf and *data buffers on the error paths.
- Use kunit_add_action_or_reset() instead of kunit_add_action() so that
  if it fails it will call regmap_exit().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://msgid.link/r/20240411103724.54063-1-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap-kunit.c | 72 +++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index be32cd4e84da4..292e86f601978 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -145,9 +145,9 @@ static struct regmap *gen_regmap(struct kunit *test,
 	const struct regmap_test_param *param = test->param_value;
 	struct regmap_test_priv *priv = test->priv;
 	unsigned int *buf;
-	struct regmap *ret;
+	struct regmap *ret = ERR_PTR(-ENOMEM);
 	size_t size;
-	int i;
+	int i, error;
 	struct reg_default *defaults;
 
 	config->cache_type = param->cache;
@@ -172,15 +172,17 @@ static struct regmap *gen_regmap(struct kunit *test,
 
 	*data = kzalloc(sizeof(**data), GFP_KERNEL);
 	if (!(*data))
-		return ERR_PTR(-ENOMEM);
+		goto out_free;
 	(*data)->vals = buf;
 
 	if (config->num_reg_defaults) {
-		defaults = kcalloc(config->num_reg_defaults,
-				   sizeof(struct reg_default),
-				   GFP_KERNEL);
+		defaults = kunit_kcalloc(test,
+					 config->num_reg_defaults,
+					 sizeof(struct reg_default),
+					 GFP_KERNEL);
 		if (!defaults)
-			return ERR_PTR(-ENOMEM);
+			goto out_free;
+
 		config->reg_defaults = defaults;
 
 		for (i = 0; i < config->num_reg_defaults; i++) {
@@ -190,12 +192,19 @@ static struct regmap *gen_regmap(struct kunit *test,
 	}
 
 	ret = regmap_init_ram(priv->dev, config, *data);
-	if (IS_ERR(ret)) {
-		kfree(buf);
-		kfree(*data);
-	} else {
-		kunit_add_action(test, regmap_exit_action, ret);
-	}
+	if (IS_ERR(ret))
+		goto out_free;
+
+	/* This calls regmap_exit() on failure, which frees buf and *data */
+	error = kunit_add_action_or_reset(test, regmap_exit_action, ret);
+	if (error)
+		ret = ERR_PTR(error);
+
+	return ret;
+
+out_free:
+	kfree(buf);
+	kfree(*data);
 
 	return ret;
 }
@@ -1497,9 +1506,9 @@ static struct regmap *gen_raw_regmap(struct kunit *test,
 	struct regmap_test_priv *priv = test->priv;
 	const struct regmap_test_param *param = test->param_value;
 	u16 *buf;
-	struct regmap *ret;
+	struct regmap *ret = ERR_PTR(-ENOMEM);
 	size_t size = (config->max_register + 1) * config->reg_bits / 8;
-	int i;
+	int i, error;
 	struct reg_default *defaults;
 
 	config->cache_type = param->cache;
@@ -1515,15 +1524,16 @@ static struct regmap *gen_raw_regmap(struct kunit *test,
 
 	*data = kzalloc(sizeof(**data), GFP_KERNEL);
 	if (!(*data))
-		return ERR_PTR(-ENOMEM);
+		goto out_free;
 	(*data)->vals = (void *)buf;
 
 	config->num_reg_defaults = config->max_register + 1;
-	defaults = kcalloc(config->num_reg_defaults,
-			   sizeof(struct reg_default),
-			   GFP_KERNEL);
+	defaults = kunit_kcalloc(test,
+				 config->num_reg_defaults,
+				 sizeof(struct reg_default),
+				 GFP_KERNEL);
 	if (!defaults)
-		return ERR_PTR(-ENOMEM);
+		goto out_free;
 	config->reg_defaults = defaults;
 
 	for (i = 0; i < config->num_reg_defaults; i++) {
@@ -1536,7 +1546,8 @@ static struct regmap *gen_raw_regmap(struct kunit *test,
 			defaults[i].def = be16_to_cpu(buf[i]);
 			break;
 		default:
-			return ERR_PTR(-EINVAL);
+			ret = ERR_PTR(-EINVAL);
+			goto out_free;
 		}
 	}
 
@@ -1548,12 +1559,19 @@ static struct regmap *gen_raw_regmap(struct kunit *test,
 		config->num_reg_defaults = 0;
 
 	ret = regmap_init_raw_ram(priv->dev, config, *data);
-	if (IS_ERR(ret)) {
-		kfree(buf);
-		kfree(*data);
-	} else {
-		kunit_add_action(test, regmap_exit_action, ret);
-	}
+	if (IS_ERR(ret))
+		goto out_free;
+
+	/* This calls regmap_exit() on failure, which frees buf and *data */
+	error = kunit_add_action_or_reset(test, regmap_exit_action, ret);
+	if (error)
+		ret = ERR_PTR(error);
+
+	return ret;
+
+out_free:
+	kfree(buf);
+	kfree(*data);
 
 	return ret;
 }
-- 
2.43.0


