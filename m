Return-Path: <stable+bounces-191588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FC8C1974E
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 10:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADA2C4FFFF2
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 09:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5EE3314C1;
	Wed, 29 Oct 2025 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1ae/lHSH"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2086E32861E;
	Wed, 29 Oct 2025 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730776; cv=none; b=OFkGuNv+AjUGcNWF8+IYko36mk030VN3xC4G64wwf73zUZUWPUBC+2hIomMZf31cr2DBOqcRW/ylSWGOejg2RZrxd3B3wcOBMcNRZaCeoNZIIN9NbboVbubNwfVeQSLi0vo6jblKCD6UWJWm37JTaVxo7tJ2B6bUsWkQvzTMVio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730776; c=relaxed/simple;
	bh=HC7FJu5v0H5FaRqZVdMzzPzRo31MQLnxN2xyoGqCc1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tj4AV7kZQ+Ap/P3CGR7Ci/0x3uQnJm2nHb9OQVzg6MfjC8fCqpLLHD9Xh9Q7gCQGA4DveMM0UTGBHAZPRWajZCE3WDk+6W41ZYj6XEaxeyKpbo8fobrqZaKp+bMLgZJBHLQY4/gspKODfNtn/pSeSdzNM1u4sB55IWBXFkEqTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1ae/lHSH; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1128EC0BEBD;
	Wed, 29 Oct 2025 09:39:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6132E606E8;
	Wed, 29 Oct 2025 09:39:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26FEE117F19DA;
	Wed, 29 Oct 2025 10:39:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761730771; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=cZfT+IVpVyyQl4hsGYvK1o0ggPzXojdpk+sM7Eh4XqU=;
	b=1ae/lHSHEXTTRI2/tUAd2klf50buGAdShgp9X2ukdZ4Qwi09jvTHALvm/yczHVYC7VFeTU
	ZZEXNKCvGZanyMZFQlHA76V8rlAHPYDHEAORNVH3aQR5f0w8PmcWhWJ6xj3SDuf8C7klXZ
	jvzTI47Ys/QZZA3hS/3AeUukktqfBZg2HrHOfzL5drV8YCDCeREl1EEPOpG2H8nx21FrUu
	JGuwWyJM+HevhcK169Giw/zujcA5K+Js9IGVm121dsZ3gxW+k2m5PFJkh7Yw8MX3MNNkeu
	9gF2ApWgazg+00sIuQlecnp2VibVeFC9QRaix10Cpd5PtZ186IVDtw6uzXR1Ew==
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
Subject: [PATCH v2 1/4] ASoC: cs4271: Fix cs4271 I2C and SPI drivers automatic module loading
Date: Wed, 29 Oct 2025 10:39:17 +0100
Message-ID: <20251029093921.624088-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029093921.624088-1-herve.codina@bootlin.com>
References: <20251029093921.624088-1-herve.codina@bootlin.com>
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
 sound/soc/codecs/cs4271-i2c.c |  6 ++++++
 sound/soc/codecs/cs4271-spi.c | 13 +++++++++++++
 sound/soc/codecs/cs4271.c     |  9 ---------
 sound/soc/codecs/cs4271.h     |  1 -
 4 files changed, 19 insertions(+), 10 deletions(-)

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
index 4feb80436bd9..28dd7b8f3507 100644
--- a/sound/soc/codecs/cs4271-spi.c
+++ b/sound/soc/codecs/cs4271-spi.c
@@ -23,11 +23,24 @@ static int cs4271_spi_probe(struct spi_device *spi)
 	return cs4271_probe(&spi->dev, devm_regmap_init_spi(spi, &config));
 }
 
+static const struct spi_device_id cs4271_id_spi[] = {
+	{ "cs4271", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, cs4271_id_spi);
+
+static const struct of_device_id cs4271_dt_ids[] = {
+	{ .compatible = "cirrus,cs4271", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cs4271_dt_ids);
+
 static struct spi_driver cs4271_spi_driver = {
 	.driver = {
 		.name	= "cs4271",
 		.of_match_table = of_match_ptr(cs4271_dt_ids),
 	},
+	.id_table	= cs4271_id_spi,
 	.probe		= cs4271_spi_probe,
 };
 module_spi_driver(cs4271_spi_driver);
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


