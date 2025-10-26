Return-Path: <stable+bounces-189883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5123C0B0F8
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 20:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B617189DF37
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 19:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AF92FE06C;
	Sun, 26 Oct 2025 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="eG+Z7gUX"
X-Original-To: stable@vger.kernel.org
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450FC1D555;
	Sun, 26 Oct 2025 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506223; cv=none; b=fju65w7VHa0/4MhFRRiINgMLmMn6HToHvJ5XcZZxFunZnOWs6Nyf8a04avkAPgmpgL7sUvsqujSB8qQ8lEA0INHeZ1CX9ICK/liRRlwYHsjsm0OfJQejGDFAyTVi44oLUJEC31xfGGuKjns8ES7W9OVNyrkJv1EY0o3W8GlYXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506223; c=relaxed/simple;
	bh=RaiiO4xtnb+GLaaftbFLwL0mhc0omSBgeOw6idGwmWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j7flWnUo8QWBs6XEXfrJKXno9AZxpob9Am9nh0jeED5ANIlkJ6UA71kvc+LBTDIte5rH3awJ5NMBNPVpP26QrZM6Chdfl13JNijYX9KgljKPGhyLtZtXETLENDL7BoNOMdXdjJIxCAzreatVgQi99Bn4/k389Os1AMZ4wVHl9Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=eG+Z7gUX; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id F1E04BDA3A;
	Sun, 26 Oct 2025 21:16:48 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 27108BCF37;
	Sun, 26 Oct 2025 21:16:48 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id D78511FE299;
	Sun, 26 Oct 2025 21:16:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761506207;
	bh=oo9GdbmpYGmFvjm3c+TcDMXwSdE3JK8Vz3sVXfMHMPQ=; h=From:To:Subject;
	b=eG+Z7gUX6b9p32O6IVcs4A8/JPmSs8L/lgYGBVKTw9Ew6IiEXOF9NFKOmvgW2CKt7
	 2CNg1kxMBc7QcW6Y0ZS21vZiiKnit2amA4+1gzELyQETQf8ZFZiBlYfT27AnQirNue
	 ZCiMQrJZDC4ZtbqHVkXv76uAHR4Hc3eHDXTuSm+XuZT8ujKU1U9wLXasPBAjDriG5c
	 WCF61SmSzNjstkMOLOADd9vdA9jijEWWVJOqjMvg+d00OMgw5WuWpk7owNyg57vzlq
	 QOtYbQ2j4h35+81kru3SAJKQ/xBJ914aOTHQTsfnPnLtXz5UB4kGLAtQpeezqw7qdN
	 KX+5hCMLA2VNg==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Baojun Xu <baojun.xu@ti.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antheas Kapenekakis <lkml@antheas.dev>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] ALSA: hda/tas2781: fix speaker id retrieval for
 multiple probes
Date: Sun, 26 Oct 2025 20:16:34 +0100
Message-ID: <20251026191635.2447593-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176150620775.1168854.1883345673300046889@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Currently, on ASUS projects, the TAS2781 codec attaches the speaker GPIO
to the first tasdevice_priv instance using devm. This causes
tas2781_read_acpi to fail on subsequent probes since the GPIO is already
managed by the first device. This causes a failure on Xbox Ally X,
because it has two amplifiers, and prevents us from quirking both the
Xbox Ally and Xbox Ally X in the realtek codec driver.

It is unnecessary to attach the GPIO to a device as it is static.
Therefore, instead of attaching it and then reading it when loading the
firmware, read its value directly in tas2781_read_acpi and store it in
the private data structure. Then, make reading the value non-fatal so
that ASUS projects that miss a speaker pin can still work, perhaps using
fallback firmware.

Fixes: 4e7035a75da9 ("ALSA: hda/tas2781: Add speaker id check for ASUS projects")
Cc: stable@vger.kernel.org # 6.17
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 include/sound/tas2781.h                       |  2 +-
 .../hda/codecs/side-codecs/tas2781_hda_i2c.c  | 44 +++++++++++--------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index 0fbcdb15c74b..29d15ba65f04 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -197,7 +197,6 @@ struct tasdevice_priv {
 	struct acoustic_data acou_data;
 #endif
 	struct tasdevice_fw *fmw;
-	struct gpio_desc *speaker_id;
 	struct gpio_desc *reset;
 	struct mutex codec_lock;
 	struct regmap *regmap;
@@ -215,6 +214,7 @@ struct tasdevice_priv {
 	unsigned int magic_num;
 	unsigned int chip_id;
 	unsigned int sysclk;
+	int speaker_id;
 
 	int irq;
 	int cur_prog;
diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 0357401a6023..c8619995b1d7 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -87,6 +87,7 @@ static const struct acpi_gpio_mapping tas2781_speaker_id_gpios[] = {
 
 static int tas2781_read_acpi(struct tasdevice_priv *p, const char *hid)
 {
+	struct gpio_desc *speaker_id;
 	struct acpi_device *adev;
 	struct device *physdev;
 	LIST_HEAD(resources);
@@ -119,19 +120,31 @@ static int tas2781_read_acpi(struct tasdevice_priv *p, const char *hid)
 	/* Speaker id was needed for ASUS projects. */
 	ret = kstrtou32(sub, 16, &subid);
 	if (!ret && upper_16_bits(subid) == PCI_VENDOR_ID_ASUSTEK) {
-		ret = devm_acpi_dev_add_driver_gpios(p->dev,
-			tas2781_speaker_id_gpios);
-		if (ret < 0)
+		ret = acpi_dev_add_driver_gpios(adev, tas2781_speaker_id_gpios);
+		if (ret < 0) {
 			dev_err(p->dev, "Failed to add driver gpio %d.\n",
 				ret);
-		p->speaker_id = devm_gpiod_get(p->dev, "speakerid", GPIOD_IN);
-		if (IS_ERR(p->speaker_id)) {
-			dev_err(p->dev, "Failed to get Speaker id.\n");
-			ret = PTR_ERR(p->speaker_id);
-			goto err;
+			p->speaker_id = -1;
+			goto end_2563;
+		}
+
+		speaker_id = fwnode_gpiod_get_index(acpi_fwnode_handle(adev),
+			"speakerid", 0, GPIOD_IN, NULL);
+		if (!IS_ERR(speaker_id)) {
+			p->speaker_id = gpiod_get_value_cansleep(speaker_id);
+			dev_dbg(p->dev, "Got speaker id gpio from ACPI: %d.\n",
+				p->speaker_id);
+			gpiod_put(speaker_id);
+		} else {
+			p->speaker_id = -1;
+			ret = PTR_ERR(speaker_id);
+			dev_err(p->dev, "Get speaker id gpio failed %d.\n",
+				ret);
 		}
+
+		acpi_dev_remove_driver_gpios(adev);
 	} else {
-		p->speaker_id = NULL;
+		p->speaker_id = -1;
 	}
 
 end_2563:
@@ -432,23 +445,16 @@ static void tasdevice_dspfw_init(void *context)
 	struct tas2781_hda *tas_hda = dev_get_drvdata(tas_priv->dev);
 	struct tas2781_hda_i2c_priv *hda_priv = tas_hda->hda_priv;
 	struct hda_codec *codec = tas_priv->codec;
-	int ret, spk_id;
+	int ret;
 
 	tasdevice_dsp_remove(tas_priv);
 	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
-	if (tas_priv->speaker_id != NULL) {
-		// Speaker id need to be checked for ASUS only.
-		spk_id = gpiod_get_value(tas_priv->speaker_id);
-		if (spk_id < 0) {
-			// Speaker id is not valid, use default.
-			dev_dbg(tas_priv->dev, "Wrong spk_id = %d\n", spk_id);
-			spk_id = 0;
-		}
+	if (tas_priv->speaker_id >= 0) {
 		snprintf(tas_priv->coef_binaryname,
 			  sizeof(tas_priv->coef_binaryname),
 			  "TAS2XXX%04X%d.bin",
 			  lower_16_bits(codec->core.subsystem_id),
-			  spk_id);
+			  tas_priv->speaker_id);
 	} else {
 		snprintf(tas_priv->coef_binaryname,
 			  sizeof(tas_priv->coef_binaryname),

base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.51.1



