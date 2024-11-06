Return-Path: <stable+bounces-90038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D095A9BDCCE
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901DD289323
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2033218929;
	Wed,  6 Nov 2024 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcyBhtF3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87491D6DDA;
	Wed,  6 Nov 2024 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859269; cv=none; b=hUa5aRSdHWyRr+MeLKryTfqXkiK0F0iMVMZUZT2eVaVUuFmXLDzbvofDDQr57KU3A4+cbQrCLma3AKkJh7hD0uTpKPZ2b0QJqhBf/auEW71hzRi8mXwlqEtbwlJ0nmvCXuDQUJpntWQvcSHtGJdTSdaukHqL90aDrrHe1pm+9tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859269; c=relaxed/simple;
	bh=6d0MtxPG6DkV1p6lLqPpnXiaRpUGvVjVZdS3RY1vEr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GELhbXf0bwkCAy4IV46HWMaWD7nmP6mOkk+3KzXl1KOdW9j6pp91G6eQ6IrpM4rzbAi+2OngUJavLrn1S+8ddep8Z+cKhSFa/bqoC0ubZvCki7gQSDMHEi6H4fJcV4pMbRM7RUWKIj6u10fbQO82KYuuTvANKQMvbImvhAPPCL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcyBhtF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97B1C4CECF;
	Wed,  6 Nov 2024 02:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859269;
	bh=6d0MtxPG6DkV1p6lLqPpnXiaRpUGvVjVZdS3RY1vEr4=;
	h=From:To:Cc:Subject:Date:From;
	b=BcyBhtF3wEqVhhV46dnalRbrY9GQTDUtDR9yOof0OTFx9CIS7vUZDBzOphkVVFlBj
	 gnPWZzqHiiTIe/gMfKF1ihUVhs69cvyzK/f0dEthPyXqDB0n9lWyjsk9h2ACkALEiC
	 AynAWU0A8M1ceCJSlsHp0TstEEc4t7EUTzHbp44mludov47VxzrQXDaB3Hw5ZxmRSU
	 xxt6CGeH0m/vhfsurIT9wjzO+T5B/NGatfU2GfIwMWaSCeQ0c6euD18rNypLSms2a9
	 OHl4HNgtRyBQ4s8is3X/by9yrOg4w+4Ri+sYVaUpRFNmeSkte0Yy+z1gVJ2DyWn1A3
	 6HHa7andNeAyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kailang@realtek.com
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek: Limit internal Mic boost on Dell platform" failed to apply to v4.19-stable tree
Date: Tue,  5 Nov 2024 21:14:26 -0500
Message-ID: <20241106021426.184279-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 78e7be018784934081afec77f96d49a2483f9188 Mon Sep 17 00:00:00 2001
From: Kailang Yang <kailang@realtek.com>
Date: Fri, 18 Oct 2024 13:53:24 +0800
Subject: [PATCH] ALSA: hda/realtek: Limit internal Mic boost on Dell platform

Dell want to limit internal Mic boost on all Dell platform.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/561fc5f5eff04b6cbd79ed173cd1c1db@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3567b14b52b7c..784ac058418fc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7521,6 +7521,7 @@ enum {
 	ALC286_FIXUP_SONY_MIC_NO_PRESENCE,
 	ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT,
 	ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+	ALC269_FIXUP_DELL1_LIMIT_INT_MIC_BOOST,
 	ALC269_FIXUP_DELL2_MIC_NO_PRESENCE,
 	ALC269_FIXUP_DELL3_MIC_NO_PRESENCE,
 	ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
@@ -7555,6 +7556,7 @@ enum {
 	ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
 	ALC255_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+	ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST,
 	ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,
 	ALC255_FIXUP_HEADSET_MODE,
 	ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC,
@@ -8114,6 +8116,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE
 	},
+	[ALC269_FIXUP_DELL1_LIMIT_INT_MIC_BOOST] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_limit_int_mic_boost,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE
+	},
 	[ALC269_FIXUP_DELL2_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -8394,6 +8402,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC255_FIXUP_HEADSET_MODE
 	},
+	[ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_limit_int_mic_boost,
+		.chained = true,
+		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE
+	},
 	[ALC255_FIXUP_DELL2_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -11076,6 +11090,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC269_FIXUP_DELL2_MIC_NO_PRESENCE, .name = "dell-headset-dock"},
 	{.id = ALC269_FIXUP_DELL3_MIC_NO_PRESENCE, .name = "dell-headset3"},
 	{.id = ALC269_FIXUP_DELL4_MIC_NO_PRESENCE, .name = "dell-headset4"},
+	{.id = ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_QUIET, .name = "dell-headset4-quiet"},
 	{.id = ALC283_FIXUP_CHROME_BOOK, .name = "alc283-dac-wcaps"},
 	{.id = ALC283_FIXUP_SENSE_COMBO_JACK, .name = "alc283-sense-combo"},
 	{.id = ALC292_FIXUP_TPT440_DOCK, .name = "tpt440-dock"},
@@ -11630,16 +11645,16 @@ static const struct snd_hda_pin_quirk alc269_fallback_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1b, 0x40000000}),
-	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_QUIET,
 		{0x19, 0x40000000},
 		{0x1b, 0x40000000}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1a, 0x40000000}),
-	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST,
 		{0x19, 0x40000000},
 		{0x1a, 0x40000000}),
-	SND_HDA_PIN_QUIRK(0x10ec0274, 0x1028, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB,
+	SND_HDA_PIN_QUIRK(0x10ec0274, 0x1028, "Dell", ALC269_FIXUP_DELL1_LIMIT_INT_MIC_BOOST,
 		{0x19, 0x40000000},
 		{0x1a, 0x40000000}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC2XX_FIXUP_HEADSET_MIC,
-- 
2.43.0





