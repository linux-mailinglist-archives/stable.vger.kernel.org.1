Return-Path: <stable+bounces-90010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EA79BDC86
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475BC1C20C3C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860341E8834;
	Wed,  6 Nov 2024 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7bYYATp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4091B1E5720;
	Wed,  6 Nov 2024 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859171; cv=none; b=FbfNnYkRG77ID8VDSbczPB6Vd7/WWuh7jACzi1SAkOI/SGNEfNFO9fhJy4mRENkKCK/8tmZy6xXEEL385fGu5bgWPoi3A+x02s24rY+A9Rwxkr+U2p3t7g5b7uwXVfea4rVwE1gyVA4ejCuXtaPuzRFHXDCiMH7akOL5+sUK4ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859171; c=relaxed/simple;
	bh=sdDTDmtfYv0ZgjfO1EpTrNsK25E4bCS634UVlpEesl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvirp78Y9cZRNmlLJEKnYEVVgh0FC9XcL40dZmZmmNKfFRpXkF5Oc2sLiKPCmecYhaK90CrgRC2Y39W14ow4tYQy+J06PdOhaFj1Jlu2/sI15GCgqIYsXOdPfG47RCKnUa5EM0A4fRiIyhp21L9Nqs4BJBBEXEDqqzBg5n71XAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7bYYATp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E25C4CECF;
	Wed,  6 Nov 2024 02:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859171;
	bh=sdDTDmtfYv0ZgjfO1EpTrNsK25E4bCS634UVlpEesl4=;
	h=From:To:Cc:Subject:Date:From;
	b=c7bYYATpac+K+p0Lg39gl7VmwC/F/Mufvx2gatZbs/vOuF0kGNfNorncA1jhLKtrH
	 W4KKV4FK3QQ+byl9oMkrWSPnmL7u/bUD/ey+QwJGbpAf+iY2raQIkdfbv7DSi1HrZf
	 YMfnP1VFYHNIB4eByw2EJ/61vx6fJ2VLkPDi5yertQAZbJIf9QwnmSgl9V7Snf1U9s
	 vFVbQOHWbhHu+pzxqNx5/cBJNlKDNOdkCtZXOIaAZfnHQN+0dHQ3QaIsRcN9ZLjR0+
	 iUucg91Qg149cAoUogPfDDBbKvGMgFHDZMF+OzogXB7r9p0lYDJ7JssQ2bZcUi8xVp
	 3y9gbJG5qF8YA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kailang@realtek.com
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek: Limit internal Mic boost on Dell platform" failed to apply to v5.10-stable tree
Date: Tue,  5 Nov 2024 21:12:48 -0500
Message-ID: <20241106021248.183174-1-sashal@kernel.org>
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

The patch below does not apply to the v5.10-stable tree.
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





