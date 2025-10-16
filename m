Return-Path: <stable+bounces-186113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AACD1BE3967
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A945505434
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684C30507F;
	Thu, 16 Oct 2025 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mFngzCWQ"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3946019E7F9;
	Thu, 16 Oct 2025 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619856; cv=none; b=tu2vs7FUB/57becCV5rpn+urn6dOzacHSiHpQtWnz3kMJT7xAYB7N40hxP8e6Snn0offN9WbZcYuYCFYB90l3leNtb6wV4ppWjjxGqPRZqL5ZDOm+KDWv98EhHgxQ8ey8L2RBeu3EulHXAndjbMhPHb9LsnKBkSkNFk87a3VLX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619856; c=relaxed/simple;
	bh=QReg2vp97BUkr6fGoaX3HVTBKM4wAz/0LebQasrMhpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldrJJjX6VxCfNYmpfdIlKgstLuYyWnJHfyRkbgl8Rrz39/rbfXPoGI24mjhheSBH+Xp77MaBwxOtZUFWpm1jG92qiud4rZp0rW1OznogpyPMmAjfzRAQ2/mJyY/MOAxw6kDpIiHmH9ucpg/u0Ma5T0e9SzdGWfUQPMd9qveOabM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mFngzCWQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 64C991A1429;
	Thu, 16 Oct 2025 13:04:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 39C4B6062C;
	Thu, 16 Oct 2025 13:04:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BDD77102F22EF;
	Thu, 16 Oct 2025 15:04:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760619851; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=xjCaRMRjVPxm5y+Ak8E+acuNrbc32ytUH8e92tM/4FA=;
	b=mFngzCWQYfGixlbS21zV34AGh8gfnhdomnXyf160lglJWjQXIQtRjcsCVB2RaAW5gt5SMU
	kZca+FEXkN5PzDeH+0T9MO8d7CKHHEKIIYT1Tgo+JmR3qgBugv5K2bZOrnk97rm73y3qsq
	LQQU7oyqzZD3GrBcWNM3+qHwmyOduKRZ6H/OsVzpFBOsqFJmZIwr+FokdYwrE7ErKy8nBk
	1e9iekLQ3IMC/28Qxpt3dlDMPD7LgJOjHeTz6Lynvt4DMEJyA4Sz0hyCMBfX5Dh8LrZSD1
	eshHBrzqZ8q0+SggSYnYURVONhDgK8/bWAdDtSO/RVSAmGY0GkgdgFLtlutxZA==
From: Herve Codina <herve.codina@bootlin.com>
To: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Axel Lin <axel.lin@ingics.com>,
	Brian Austin <brian.austin@cirrus.com>
Cc: linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] ASoC: cs4271: Fix cs4271 I2C and SPI drivers automatic module loading
Date: Thu, 16 Oct 2025 15:03:37 +0200
Message-ID: <20251016130340.1442090-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016130340.1442090-1-herve.codina@bootlin.com>
References: <20251016130340.1442090-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

In commit c973b8a7dc50 ("ASoC: cs4271: Split SPI and I2C code into
different modules") the driver was slit into a core, an SPI and an I2C
part.

However, the MODULE_DEVICE_TABLE(of, cs4271_dt_ids) was in the core part
and so, module loading based on module.alias (based on DT compatible
string matching) loads the core part but not the SPI or I2C parts.

In order to have the I2C or the SPI module loaded automatically, move
the MODULE_DEVICE_TABLE(of, ...) the core to I2C and SPI parts.
Also move cs4271_dt_ids itself from the core part to I2C and SPI parts
as both the call to MODULE_DEVICE_TABLE(of, ...) and the cs4271_dt_ids
table itself need to be in the same file.

Fixes: c973b8a7dc50 ("ASoC: cs4271: Split SPI and I2C code into different modules")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/codecs/cs4271-i2c.c | 6 ++++++
 sound/soc/codecs/cs4271-spi.c | 6 ++++++
 sound/soc/codecs/cs4271.c     | 9 ---------
 sound/soc/codecs/cs4271.h     | 1 -
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/cs4271-i2c.c b/sound/soc/codecs/cs4271-i2c.c
index 1d210b969173..cefb8733fc61 100644
--- a/sound/soc/codecs/cs4271-i2c.c
+++ b/sound/soc/codecs/cs4271-i2c.c
@@ -28,6 +28,12 @@ static const struct i2c_device_id cs4271_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cs4271_i2c_id);
 
+static const struct of_device_id cs4271_dt_ids[] = {
+	{ .compatible = "cirrus,cs4271", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cs4271_dt_ids);
+
 static struct i2c_driver cs4271_i2c_driver = {
 	.driver = {
 		.name = "cs4271",
diff --git a/sound/soc/codecs/cs4271-spi.c b/sound/soc/codecs/cs4271-spi.c
index 4feb80436bd9..82abc654293c 100644
--- a/sound/soc/codecs/cs4271-spi.c
+++ b/sound/soc/codecs/cs4271-spi.c
@@ -23,6 +23,12 @@ static int cs4271_spi_probe(struct spi_device *spi)
 	return cs4271_probe(&spi->dev, devm_regmap_init_spi(spi, &config));
 }
 
+static const struct of_device_id cs4271_dt_ids[] = {
+	{ .compatible = "cirrus,cs4271", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cs4271_dt_ids);
+
 static struct spi_driver cs4271_spi_driver = {
 	.driver = {
 		.name	= "cs4271",
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 6a3cca3d26c7..ff9c6628224c 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -543,15 +543,6 @@ static int cs4271_soc_resume(struct snd_soc_component *component)
 #define cs4271_soc_resume	NULL
 #endif /* CONFIG_PM */
 
-#ifdef CONFIG_OF
-const struct of_device_id cs4271_dt_ids[] = {
-	{ .compatible = "cirrus,cs4271", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, cs4271_dt_ids);
-EXPORT_SYMBOL_GPL(cs4271_dt_ids);
-#endif
-
 static int cs4271_component_probe(struct snd_soc_component *component)
 {
 	struct cs4271_private *cs4271 = snd_soc_component_get_drvdata(component);
diff --git a/sound/soc/codecs/cs4271.h b/sound/soc/codecs/cs4271.h
index 290283a9149e..4965ce085875 100644
--- a/sound/soc/codecs/cs4271.h
+++ b/sound/soc/codecs/cs4271.h
@@ -4,7 +4,6 @@
 
 #include <linux/regmap.h>
 
-extern const struct of_device_id cs4271_dt_ids[];
 extern const struct regmap_config cs4271_regmap_config;
 
 int cs4271_probe(struct device *dev, struct regmap *regmap);
-- 
2.51.0


