Return-Path: <stable+bounces-206287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C1CD03013
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 14:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4A0C3015AC2
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 13:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7AF3EC561;
	Thu,  8 Jan 2026 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ajsAjMzq"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA506451059
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865100; cv=none; b=LCwvKnM/if2nosDrGpsA6HIw7wKASPGdTWvLJbv5KBNyr/8Laki87m+XKNUZuM3jC/VlX468b8gmO93KqwnWstdOFpB1vGTonDIAerfYy5Y0VYlDAGu3VmCh7qSdKl94x4axpPFnqwbyAwH4u937geO259cBrzaFCsMNizE+Euw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865100; c=relaxed/simple;
	bh=HX04hRgY5dPP4tcUYLt5iDhQs2uyNrZOdgvMUCZNlTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAFeTwemsV4p+TkQOg1iZQqC1Ta7/8Gown4RLKnCEdQQMMrtf2UgWZ5ahi/zC8DJ44oUAHRPEQkJVDpRZAN1nRkqYGVZgC5fIslB+92nbS4mo4sYfuhCIibnewmXwAwsu3nlImKkYPkkWjdfjBm66iB7Kk16hKsTL8MEf5U1e0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ajsAjMzq; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767865086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=STlfevbMbQor4NiPveZvT1ORT1Sj+wqlqeXBGtUeNNA=;
	b=ajsAjMzqb3m3ALRiJpDvlBKs3dSaSw+Khp0M/8Xu7MtwgO2Gqj+YhNQNZkgkiNM4Km8+3Y
	ogYDsxtSoRnJ1gLcHt8D7Dr9gNlpEc167/KW8vMjmjveEMAuDJ9caS04N7mdwcnclRoGqH
	99cZvG70LtmPaZb4StlJgNNxwUBBleE=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/tas2781: Skip UEFI calibration on ASUS ROG Xbox Ally X
Date: Thu,  8 Jan 2026 01:36:50 -0800
Message-ID: <20260108093650.1142176-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There is currently an issue with UEFI calibration data parsing for some
TAS devices, like the ASUS ROG Xbox Ally X (RC73XA), that causes audio
quality issues such as gaps in playback. Until the issue is root caused
and fixed, add a quirk to skip using the UEFI calibration data and fall
back to using the calibration data provided by the DSP firmware, which
restores full speaker functionality on affected devices.

Cc: stable@vger.kernel.org # 6.18
Link: https://lore.kernel.org/all/160aef32646c4d5498cbfd624fd683cc@ti.com/
Closes: https://lore.kernel.org/all/0ba100d0-9b6f-4a3b-bffa-61abe1b46cd5@linux.dev/
Suggested-by: Baojun Xu <baojun.xu@ti.com>
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
v1->v2: drop wrong Fixes tag, amend commit to clarify suspected root cause
and workaround being used.
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index c8619995b1d7..ec3761050cab 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -60,6 +60,7 @@ struct tas2781_hda_i2c_priv {
 	int (*save_calibration)(struct tas2781_hda *h);
 
 	int hda_chip_id;
+	bool skip_calibration;
 };
 
 static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)
@@ -489,7 +490,8 @@ static void tasdevice_dspfw_init(void *context)
 	/* If calibrated data occurs error, dsp will still works with default
 	 * calibrated data inside algo.
 	 */
-	hda_priv->save_calibration(tas_hda);
+	if (!hda_priv->skip_calibration)
+		hda_priv->save_calibration(tas_hda);
 }
 
 static void tasdev_fw_ready(const struct firmware *fmw, void *context)
@@ -546,6 +548,7 @@ static int tas2781_hda_bind(struct device *dev, struct device *master,
 	void *master_data)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+	struct tas2781_hda_i2c_priv *hda_priv = tas_hda->hda_priv;
 	struct hda_component_parent *parent = master_data;
 	struct hda_component *comp;
 	struct hda_codec *codec;
@@ -571,6 +574,14 @@ static int tas2781_hda_bind(struct device *dev, struct device *master,
 		break;
 	}
 
+	/*
+	 * Using ASUS ROG Xbox Ally X (RC73XA) UEFI calibration data
+	 * causes audio dropouts during playback, use fallback data
+	 * from DSP firmware as a workaround.
+	 */
+	if (codec->core.subsystem_id == 0x10431384)
+		hda_priv->skip_calibration = true;
+
 	pm_runtime_get_sync(dev);
 
 	comp->dev = dev;
-- 
2.52.0


