Return-Path: <stable+bounces-105443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C48C99F97C4
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BF1189C4BE
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B456221457;
	Fri, 20 Dec 2024 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXTM3OA8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80E522145B;
	Fri, 20 Dec 2024 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714716; cv=none; b=azbd1gKoIDdOK31dvYKbWCXXh8xPX5casp/01c4t+iBYxK+WZQUsjJZvqyuWMBtA2imTzcN8MHVD8vji+uXO8f0eFnvHSnpi2xiEDTtIUDSVB7gkrUtRFZJdzKvAGF8ypFpO/78iOTYCkXzW3uo5iAZPPXIQA33bHFcDcSoLvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714716; c=relaxed/simple;
	bh=fhP3o7FirhT+h8ynBuF6DzEo3Kw8TqEaV0LDPBoSIv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rbetk03M7x7nDR9UEjf+YxgAHaFkz4uVYO0RtDXV0sYPxE0pudYwY8nxkCHSS4rDQRuR2dxcPA2XtJTti3B374CYjmHUwU8PWjacTj5zjrnJLiBM3zDyNn2dCtPDUKHnItRYR7JLoKfXcRsO3yNbkdwaT6ud57Bf3dYOIKdI1fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXTM3OA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A37C4CED7;
	Fri, 20 Dec 2024 17:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714716;
	bh=fhP3o7FirhT+h8ynBuF6DzEo3Kw8TqEaV0LDPBoSIv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qXTM3OA8gjuT5MNnbTJIGffbXnILn5qjxnEJ63n1Jw/DXz7mDG7d2mwQBKm8hzdPE
	 pjTWj+68hktVT4jsYmniE/eV1WaFDjq4lmRwVnfsoaiG+7nmcBZb2w6En9CDa+moqS
	 0wblkZw0AwC1mn/YOlGf5egNIzdYLT6fZ5lx5LYQEmSGoh5SOCiO/Mu8slpN290oTI
	 Fk5ZBKZPeD5+XB+mNG7XmdaXBrRFDHtAkEuQnIBmpdDv8Qt6nszBYtDlrVxmI4hY0I
	 0Dwdkn5Z9XGYiw6I/wXFGJZbHqnery6PKAcT8+sJs/8RAYkyPAdtykKgxl9r4eUiVA
	 +qsIWmg8eSUwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 11/29] ALSA: hda/ca0132: Use standard HD-audio quirk matching helpers
Date: Fri, 20 Dec 2024 12:11:12 -0500
Message-Id: <20241220171130.511389-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 7c005292e20ac53dfa601bf2a7375fd4815511ad ]

CA0132 used the PCI SSID lookup helper that doesn't support the model
string matching or quirk aliasing.

Replace it with the standard HD-audio quirk helpers for supporting
those, and add the definition of the model strings for supported
quirks, too.  There should be no visible change to the outside for the
working system, but the driver will parse the model option and apply
the quirk based on it from now on.

Link: https://patch.msgid.link/20241207133754.3658-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_ca0132.c | 37 ++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index e4673a71551a..d40197fb5fbd 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1134,7 +1134,6 @@ struct ca0132_spec {
 
 	struct hda_codec *codec;
 	struct delayed_work unsol_hp_work;
-	int quirk;
 
 #ifdef ENABLE_TUNING_CONTROLS
 	long cur_ctl_vals[TUNING_CTLS_COUNT];
@@ -1166,7 +1165,6 @@ struct ca0132_spec {
  * CA0132 quirks table
  */
 enum {
-	QUIRK_NONE,
 	QUIRK_ALIENWARE,
 	QUIRK_ALIENWARE_M17XR4,
 	QUIRK_SBZ,
@@ -1176,10 +1174,11 @@ enum {
 	QUIRK_R3D,
 	QUIRK_AE5,
 	QUIRK_AE7,
+	QUIRK_NONE = HDA_FIXUP_ID_NOT_SET,
 };
 
 #ifdef CONFIG_PCI
-#define ca0132_quirk(spec)		((spec)->quirk)
+#define ca0132_quirk(spec)		((spec)->codec->fixup_id)
 #define ca0132_use_pci_mmio(spec)	((spec)->use_pci_mmio)
 #define ca0132_use_alt_functions(spec)	((spec)->use_alt_functions)
 #define ca0132_use_alt_controls(spec)	((spec)->use_alt_controls)
@@ -1293,7 +1292,7 @@ static const struct hda_pintbl ae7_pincfgs[] = {
 	{}
 };
 
-static const struct snd_pci_quirk ca0132_quirks[] = {
+static const struct hda_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1028, 0x057b, "Alienware M17x R4", QUIRK_ALIENWARE_M17XR4),
 	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15 2015", QUIRK_ALIENWARE),
 	SND_PCI_QUIRK(0x1028, 0x0688, "Alienware 17 2015", QUIRK_ALIENWARE),
@@ -1316,6 +1315,19 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	{}
 };
 
+static const struct hda_model_fixup ca0132_quirk_models[] = {
+	{ .id = QUIRK_ALIENWARE, .name = "alienware" },
+	{ .id = QUIRK_ALIENWARE_M17XR4, .name = "alienware-m17xr4" },
+	{ .id = QUIRK_SBZ, .name = "sbz" },
+	{ .id = QUIRK_ZXR, .name = "zxr" },
+	{ .id = QUIRK_ZXR_DBPRO, .name = "zxr-dbpro" },
+	{ .id = QUIRK_R3DI, .name = "r3di" },
+	{ .id = QUIRK_R3D, .name = "r3d" },
+	{ .id = QUIRK_AE5, .name = "ae5" },
+	{ .id = QUIRK_AE7, .name = "ae7" },
+	{}
+};
+
 /* Output selection quirk info structures. */
 #define MAX_QUIRK_MMIO_GPIO_SET_VALS 3
 #define MAX_QUIRK_SCP_SET_VALS 2
@@ -9957,17 +9969,15 @@ static int ca0132_prepare_verbs(struct hda_codec *codec)
  */
 static void sbz_detect_quirk(struct hda_codec *codec)
 {
-	struct ca0132_spec *spec = codec->spec;
-
 	switch (codec->core.subsystem_id) {
 	case 0x11020033:
-		spec->quirk = QUIRK_ZXR;
+		codec->fixup_id = QUIRK_ZXR;
 		break;
 	case 0x1102003f:
-		spec->quirk = QUIRK_ZXR_DBPRO;
+		codec->fixup_id = QUIRK_ZXR_DBPRO;
 		break;
 	default:
-		spec->quirk = QUIRK_SBZ;
+		codec->fixup_id = QUIRK_SBZ;
 		break;
 	}
 }
@@ -9976,7 +9986,6 @@ static int patch_ca0132(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec;
 	int err;
-	const struct snd_pci_quirk *quirk;
 
 	codec_dbg(codec, "patch_ca0132\n");
 
@@ -9987,11 +9996,7 @@ static int patch_ca0132(struct hda_codec *codec)
 	spec->codec = codec;
 
 	/* Detect codec quirk */
-	quirk = snd_pci_quirk_lookup(codec->bus->pci, ca0132_quirks);
-	if (quirk)
-		spec->quirk = quirk->value;
-	else
-		spec->quirk = QUIRK_NONE;
+	snd_hda_pick_fixup(codec, ca0132_quirk_models, ca0132_quirks, NULL);
 	if (ca0132_quirk(spec) == QUIRK_SBZ)
 		sbz_detect_quirk(codec);
 
@@ -10068,7 +10073,7 @@ static int patch_ca0132(struct hda_codec *codec)
 		spec->mem_base = pci_iomap(codec->bus->pci, 2, 0xC20);
 		if (spec->mem_base == NULL) {
 			codec_warn(codec, "pci_iomap failed! Setting quirk to QUIRK_NONE.");
-			spec->quirk = QUIRK_NONE;
+			codec->fixup_id = QUIRK_NONE;
 		}
 	}
 #endif
-- 
2.39.5


