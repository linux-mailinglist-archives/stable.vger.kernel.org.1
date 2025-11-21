Return-Path: <stable+bounces-195445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 234FDC76F3E
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 03:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3772D4E6A68
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 02:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ED61E8826;
	Fri, 21 Nov 2025 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQIGPigW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5671B1B4F2C
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690651; cv=none; b=De8mWbHpwbbpBGgDjOtVAWgrbJlBFpe0Hpr/qfDdkEeqwaD9QjL9FNW+kemFWNrUDqzl8mYsfmu+cz9iDZ9Z1whkN9Rs8IrETflnfFNwxgyVGiJKj6cOiPfViuFeW993tS4RJW/JbpU0RxR9Ke0v1Ki8DLABzaq/T/sci0RrpTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690651; c=relaxed/simple;
	bh=jRGQkTxiG1sD17/CBFOVmTMrBdCXFjFgy7JbJf6aUvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZeZbjDhrodeHxwpylZZCSj/5JVk4ED5NpJY2eVayI5P6dE7yniJC2frsNpTxUPVDTJUGECp1P9cB/0jowS31FrT7r0tlhq7a8ymfVq3+CPHQ81Gr3P31bM3eBY7cbrKJ1fv8YuaplajBSujX1R6FNfIUA64rw+c8hj9D+hfUIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQIGPigW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A35DC116B1;
	Fri, 21 Nov 2025 02:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763690650;
	bh=jRGQkTxiG1sD17/CBFOVmTMrBdCXFjFgy7JbJf6aUvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQIGPigW9QGPTmGV+GRAV+ASi3FQqt/bi6qxoNkKQwrK0DGJLkOobLC7BM+R+nWev
	 M0NqmBtTh+VsDtTaKOaMUiDus7FpPn3KukluCjZa7/ojR9oRBGMt9Xo4EoE6+TcV8S
	 NgxVR7tSCXdPOIKwf3qnTWqxEZYVCMUs173SeDG1k3zn+7g0ULj6SzOBEBYtNUvK08
	 nJaD7OCpsIzdwrkZaQGVphmMeHKVqg1wAx73LJdGvqZBSFhsE1VI21jUWOdv4fjtjK
	 r4TLV+VSlBBWcIhJnzdC4gCjGarsDns4wWPP0IhKgILCcUMCh8Cu7LRM3oI0w64x2n
	 yQv30/WNLCOlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/2] ASoC: da7213: Use component driver suspend/resume
Date: Thu, 20 Nov 2025 21:04:06 -0500
Message-ID: <20251121020406.2340125-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121020406.2340125-1-sashal@kernel.org>
References: <2025112057-rubble-coleslaw-6ad1@gregkh>
 <20251121020406.2340125-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit 249d96b492efb7a773296ab2c62179918301c146 ]

Since snd_soc_suspend() is invoked through snd_soc_pm_ops->suspend(),
and snd_soc_pm_ops is associated with the soc_driver (defined in
sound/soc/soc-core.c), and there is no parent-child relationship between
the soc_driver and the DA7213 codec driver, the power management subsystem
does not enforce a specific suspend/resume order between the DA7213 driver
and the soc_driver.

Because of this, the different codec component functionalities, called from
snd_soc_resume() to reconfigure various functions, can race with the
DA7213 struct dev_pm_ops::resume function, leading to misapplied
configuration. This occasionally results in clipped sound.

Fix this by dropping the struct dev_pm_ops::{suspend, resume} and use
instead struct snd_soc_component_driver::{suspend, resume}. This ensures
the proper configuration sequence is handled by the ASoC subsystem.

Cc: stable@vger.kernel.org
Fixes: 431e040065c8 ("ASoC: da7213: Add suspend to RAM support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20251104114914.2060603-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/da7213.c | 69 +++++++++++++++++++++++++--------------
 sound/soc/codecs/da7213.h |  1 +
 2 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index ae89260ca215f..3420011da444c 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2124,11 +2124,50 @@ static int da7213_probe(struct snd_soc_component *component)
 	return 0;
 }
 
+static int da7213_runtime_suspend(struct device *dev)
+{
+	struct da7213_priv *da7213 = dev_get_drvdata(dev);
+
+	regcache_cache_only(da7213->regmap, true);
+	regcache_mark_dirty(da7213->regmap);
+	regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);
+
+	return 0;
+}
+
+static int da7213_runtime_resume(struct device *dev)
+{
+	struct da7213_priv *da7213 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213->supplies);
+	if (ret < 0)
+		return ret;
+	regcache_cache_only(da7213->regmap, false);
+	return regcache_sync(da7213->regmap);
+}
+
+static int da7213_suspend(struct snd_soc_component *component)
+{
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+
+	return da7213_runtime_suspend(da7213->dev);
+}
+
+static int da7213_resume(struct snd_soc_component *component)
+{
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+
+	return da7213_runtime_resume(da7213->dev);
+}
+
 static const struct snd_soc_component_driver soc_component_dev_da7213 = {
 	.probe			= da7213_probe,
 	.set_bias_level		= da7213_set_bias_level,
 	.controls		= da7213_snd_controls,
 	.num_controls		= ARRAY_SIZE(da7213_snd_controls),
+	.suspend		= da7213_suspend,
+	.resume			= da7213_resume,
 	.dapm_widgets		= da7213_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(da7213_dapm_widgets),
 	.dapm_routes		= da7213_audio_map,
@@ -2175,6 +2214,8 @@ static int da7213_i2c_probe(struct i2c_client *i2c)
 	if (!da7213->fin_min_rate)
 		return -EINVAL;
 
+	da7213->dev = &i2c->dev;
+
 	i2c_set_clientdata(i2c, da7213);
 
 	/* Get required supplies */
@@ -2224,31 +2265,9 @@ static void da7213_i2c_remove(struct i2c_client *i2c)
 	pm_runtime_disable(&i2c->dev);
 }
 
-static int da7213_runtime_suspend(struct device *dev)
-{
-	struct da7213_priv *da7213 = dev_get_drvdata(dev);
-
-	regcache_cache_only(da7213->regmap, true);
-	regcache_mark_dirty(da7213->regmap);
-	regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);
-
-	return 0;
-}
-
-static int da7213_runtime_resume(struct device *dev)
-{
-	struct da7213_priv *da7213 = dev_get_drvdata(dev);
-	int ret;
-
-	ret = regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213->supplies);
-	if (ret < 0)
-		return ret;
-	regcache_cache_only(da7213->regmap, false);
-	return regcache_sync(da7213->regmap);
-}
-
-static DEFINE_RUNTIME_DEV_PM_OPS(da7213_pm, da7213_runtime_suspend,
-				 da7213_runtime_resume, NULL);
+static const struct dev_pm_ops da7213_pm = {
+	RUNTIME_PM_OPS(da7213_runtime_suspend, da7213_runtime_resume, NULL)
+};
 
 static const struct i2c_device_id da7213_i2c_id[] = {
 	{ "da7213" },
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index b9ab791d6b883..29cbf0eb61243 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -595,6 +595,7 @@ enum da7213_supplies {
 /* Codec private data */
 struct da7213_priv {
 	struct regmap *regmap;
+	struct device *dev;
 	struct mutex ctrl_lock;
 	struct regulator_bulk_data supplies[DA7213_NUM_SUPPLIES];
 	struct clk *mclk;
-- 
2.51.0


