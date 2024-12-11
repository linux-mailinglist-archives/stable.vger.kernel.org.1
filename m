Return-Path: <stable+bounces-100753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9899ED5A6
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7841657F5
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DC324BFB5;
	Wed, 11 Dec 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hdb86YLb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BCA24BFAF;
	Wed, 11 Dec 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943206; cv=none; b=JZLpsL4hQFloZhM7NrDGbDP7K6d/xVY9gikbAgiRbRw6cLui0zt5nuNSWtwyl+NUlU3jm0lN6ORgqNBvOOjacfNUWLoB2L+KVpI4rSb7yAyWRat/0ANd4JvLVybACa2f9o3WGUVXvErO2hqzRdOKnErJn9gI7psJEey+51Wl+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943206; c=relaxed/simple;
	bh=EgoCqeABvBYx4WAtiE1pFmAsUG6fptY0af98AbMpEws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTjxFL6fvO4xCh1sxnZpr/LDKxRk9U4C4+JHaor0KuxRO7aJwriTC7M4NF1NulgimjiN6Slv1BbZ1W9BVteaL6VZwTklMHZjefS1nQw23BLABURJ067belt1lzLYBUR/sUh7ETUsYC4k3XHn6B+jV6bz4fI7S/vFmwHTz4M0es4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hdb86YLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A156C4CED2;
	Wed, 11 Dec 2024 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943205;
	bh=EgoCqeABvBYx4WAtiE1pFmAsUG6fptY0af98AbMpEws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hdb86YLb84gGeO/Bm+wEvBEiwUoenws80cxV4Wz5FN2EmqPRyx3M6fOWKcbU+uB0/
	 Wn9547embS5kbZACkymWF8u6IAyImBzRocZOA88Sz1NnkPbpagZcOMULEh0AdbbOak
	 TJ4qN61lGJtx6vsVUQ1EU1e1VXLaF8W0oydvuMw0ehW7XCf4cOM7PpxLyUziiQOTpO
	 jFqtXOp2g/9k4odUCDin4a0ap/cbum3tjofWS5k0UEbFqAn+wMJ2BBKpdxXa41GFa5
	 tnxeMzET+f9Uv3BszIlmGWxQB9CKUIvDRWeqOuKvcVZnUJ5CJQnCpdRkwbwdZvJ1kK
	 OZYCR0t/3AOmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: bo liu <bo.liu@senarytech.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kovalev@altlinux.org,
	cs@tuxedo.de,
	wse@tuxedocomputers.com,
	me@oldherl.one,
	jaroslaw.janik@gmail.com,
	songxiebing@kylinos.cn,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/15] ALSA: hda/conexant: fix Z60MR100 startup pop issue
Date: Wed, 11 Dec 2024 13:52:56 -0500
Message-ID: <20241211185316.3842543-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185316.3842543-1-sashal@kernel.org>
References: <20241211185316.3842543-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: bo liu <bo.liu@senarytech.com>

[ Upstream commit 947c4012f8f03a8bb946beb6e5294d5e32817d67 ]

When Z60MR100 startup, speaker will output a pop. To fix this issue,
we mute codec by init verbs in bios when system startup, and set GPIO
to low to unmute codec in codec driver when it loaded .

[ white space fixes and compile warning fix by tiwai ]

Signed-off-by: bo liu <bo.liu@senarytech.com>
Link: https://patch.msgid.link/20241129014441.437205-1-bo.liu@senarytech.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_conexant.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index a14b9cb48f69a..7edb029f08a36 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -311,6 +311,7 @@ enum {
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
 	CXT_PINCFG_SWS_JS201D,
 	CXT_PINCFG_TOP_SPEAKER,
+	CXT_FIXUP_HP_A_U,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -778,6 +779,18 @@ static void cxt_setup_mute_led(struct hda_codec *codec,
 	}
 }
 
+static void cxt_setup_gpio_unmute(struct hda_codec *codec,
+				  unsigned int gpio_mute_mask)
+{
+	if (gpio_mute_mask) {
+		// set gpio data to 0.
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA, 0);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK, gpio_mute_mask);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DIRECTION, gpio_mute_mask);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_STICKY_MASK, 0);
+	}
+}
+
 static void cxt_fixup_mute_led_gpio(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -792,6 +805,15 @@ static void cxt_fixup_hp_zbook_mute_led(struct hda_codec *codec,
 		cxt_setup_mute_led(codec, 0x10, 0x20);
 }
 
+static void cxt_fixup_hp_a_u(struct hda_codec *codec,
+			     const struct hda_fixup *fix, int action)
+{
+	// Init vers in BIOS mute the spk/hp by set gpio high to avoid pop noise,
+	// so need to unmute once by clearing the gpio data when runs into the system.
+	if (action == HDA_FIXUP_ACT_INIT)
+		cxt_setup_gpio_unmute(codec, 0x2);
+}
+
 /* ThinkPad X200 & co with cxt5051 */
 static const struct hda_pintbl cxt_pincfg_lenovo_x200[] = {
 	{ 0x16, 0x042140ff }, /* HP (seq# overridden) */
@@ -1016,6 +1038,10 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_sirius_top_speaker,
 	},
+	[CXT_FIXUP_HP_A_U] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_hp_a_u,
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -1090,6 +1116,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x8457, "HP Z2 G4 mini", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x8458, "HP Z2 G4 mini premium", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
+	SND_PCI_QUIRK(0x14f1, 0x0252, "MBX-Z60MR100", CXT_FIXUP_HP_A_U),
 	SND_PCI_QUIRK(0x14f1, 0x0265, "SWS JS201D", CXT_PINCFG_SWS_JS201D),
 	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT_FIXUP_OLPC_XO),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400", CXT_PINCFG_LENOVO_TP410),
@@ -1135,6 +1162,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_PINCFG_LENOVO_NOTEBOOK, .name = "lenovo-20149" },
 	{ .id = CXT_PINCFG_SWS_JS201D, .name = "sws-js201d" },
 	{ .id = CXT_PINCFG_TOP_SPEAKER, .name = "sirius-top-speaker" },
+	{ .id = CXT_FIXUP_HP_A_U, .name = "HP-U-support" },
 	{}
 };
 
-- 
2.43.0


