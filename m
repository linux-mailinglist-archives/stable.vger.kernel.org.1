Return-Path: <stable+bounces-105466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A789C9F97F7
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB577189B754
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8280522C37D;
	Fri, 20 Dec 2024 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeNiFyjd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C08B22C376;
	Fri, 20 Dec 2024 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714771; cv=none; b=KU25KG4eknl31DasfrIDeapITYKgd7UnlUZi2OQ9htqbecR25w+twByaq1zCPg//97QxBBvLlvL/OVT5vu1fmmj63LWcv44Y5BzfvX94T+yEi7BcNnCLbbMAuroV5zuoyezv6xTvPVNFbmyMSbAeJvLnP1E+GBdK2kXZTZy9c1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714771; c=relaxed/simple;
	bh=aGCXVi18iJz1OM5WIQHFpVr24HvsbxELPq6AT5NsiLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PBVIx16+wF6hjKN7RiACRVAXZjUAqf1IhnGtyIOms9ep8JMFHGmYak/HrvEJrTpLsrkVTBriko5jXnwZ+wfOPP/5GzyeiRX982devCeIZUjfkHWptw5iiysufQ1vvO0K2i6LOp5el4NHukyHScCGS/0W9qSSsz9lbLVSjQeibBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeNiFyjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451DBC4CED3;
	Fri, 20 Dec 2024 17:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714771;
	bh=aGCXVi18iJz1OM5WIQHFpVr24HvsbxELPq6AT5NsiLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UeNiFyjdoshNSL9PM600AzR0HhmjrNNWD7RSJLl/HTyT44K+46AlAunMKR0HtbcfB
	 LGM4hQqoYcRZWn2rblsGKUIUTrW71gYke7ztuz/ykfg7HueCx8t5eeRtOKPN487lhD
	 FHaKK2lPUR/4PLHhnEiFqdYxMswwam4Ia8UBuDCtMIK9ATbN94qiu9FpOcD/t/E6O4
	 JmP1ggcvrYhZts0v2jDBfrXAjjgeQvsZO/SFNb0LO1RJEyR8cppsZhV2bBN/vt0sDp
	 vDr5vomvhpZekDsbzBL9OIHKwmdijNgr67/u6FNaWBGMMWGTgMfay7Qo/pnWZ9Ulrm
	 32wSf7zUx5jAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/16] ALSA: hda/ca0132: Use standard HD-audio quirk matching helpers
Date: Fri, 20 Dec 2024 12:12:29 -0500
Message-Id: <20241220171240.511904-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171240.511904-1-sashal@kernel.org>
References: <20241220171240.511904-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.67
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
index 748a3c40966e..27e48fdbbf3a 100644
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
@@ -9962,17 +9974,15 @@ static int ca0132_prepare_verbs(struct hda_codec *codec)
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
@@ -9981,7 +9991,6 @@ static int patch_ca0132(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec;
 	int err;
-	const struct snd_pci_quirk *quirk;
 
 	codec_dbg(codec, "patch_ca0132\n");
 
@@ -9992,11 +10001,7 @@ static int patch_ca0132(struct hda_codec *codec)
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
 
@@ -10073,7 +10078,7 @@ static int patch_ca0132(struct hda_codec *codec)
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


