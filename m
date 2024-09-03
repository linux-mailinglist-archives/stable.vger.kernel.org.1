Return-Path: <stable+bounces-72860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2721E96A8A7
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B611F25285
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8651D5CDF;
	Tue,  3 Sep 2024 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjUEwXTi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0D1DB549;
	Tue,  3 Sep 2024 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396138; cv=none; b=eA4vzkCd5YvYvmfBu2fr3/RGW4bZCIrKbzaeGA7AIkuuhLxLOqfrtog8zIqAARTOGPOTvGJVvSaX0zVdnrNDkv/a8dIwjGYRXxYj8ka25aPK3nATBG9PZwG7cSEOfWouqeKgxqf312tpsCuA/L+IVDqb2k+IbdL+Zi+JeNhSQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396138; c=relaxed/simple;
	bh=d2NDO9S63ULNwCRm56vVXRiWWEZ7AgHmeDrOgQ2WFj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHrO+iSdMrsiWTh4FUaXHOxn90o5vwHYLRe8zGF5VMvrIMCWkzaoHfQOicMeu7/GVKF2a+Lfo6FHRYiGR8qJCzW57M5MnpS6heH1i6IacbQ+oNibfGfWvMTgQREtu8wtrAZyJhA4zI7SmvSNmX/ehMq4MHY8m1yZPcgNOlcGk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjUEwXTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB7EC4CEC4;
	Tue,  3 Sep 2024 20:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396138;
	bh=d2NDO9S63ULNwCRm56vVXRiWWEZ7AgHmeDrOgQ2WFj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjUEwXTiYqXRJENzCmAaAJvobzOmKTzirv9VQ5mzUOXPhgelgipBvXWTzxpcmC3iP
	 oF5qCgcUWiQlVdkWxtGZAqTMqvyijNlLKxvC2oDoB1OjuNGlDt1rmMh0QicnhzgSRQ
	 Jq2ieOEiBRP7x2nYSEUeBewPGh55pz9zFtAg1XRabUq7T0dTmaqBL/a/CU9h7RXRy9
	 GdMRlJxXIL0U4th5FoCDODDkQGiLAjVOlr5PMw9BfiqtQEqGRBlNCXkIz4N0chd/JT
	 LziHW3vemuJGs3DMfH8xTaQhf4qj1adHFHIqoGTG3ZObUFWo7MeTFKjsK1fBBn++O2
	 oWE/mxrz7H9Gw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 06/22] ALSA: hda/realtek - FIxed ALC285 headphone no sound
Date: Tue,  3 Sep 2024 15:21:53 -0400
Message-ID: <20240903192243.1107016-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192243.1107016-1-sashal@kernel.org>
References: <20240903192243.1107016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.7
Content-Transfer-Encoding: 8bit

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit 1fa7b099d60ad64f559bd3b8e3f0d94b2e015514 ]

Dell platform with ALC215 ALC285 ALC289 ALC225 ALC295 ALC299, plug
headphone or headset.
It had a chance to get no sound from headphone.
Replace depop procedure will solve this issue.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://lore.kernel.org/d0de1b03fd174520945dde216d765223@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 95fa65f398360..bb1f5cdf51895 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5085,6 +5085,7 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 	case 0x10ec0295:
 	case 0x10ec0289:
 	case 0x10ec0299:
+		alc_hp_mute_disable(codec, 75);
 		alc_process_coef_fw(codec, alc225_pre_hsmode);
 		alc_process_coef_fw(codec, coef0225);
 		break;
@@ -5310,6 +5311,7 @@ static void alc_headset_mode_default(struct hda_codec *codec)
 	case 0x10ec0299:
 		alc_process_coef_fw(codec, alc225_pre_hsmode);
 		alc_process_coef_fw(codec, coef0225);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0255:
 		alc_process_coef_fw(codec, coef0255);
@@ -5469,6 +5471,7 @@ static void alc_headset_mode_ctia(struct hda_codec *codec)
 			alc_process_coef_fw(codec, coef0225_2);
 		else
 			alc_process_coef_fw(codec, coef0225_1);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0867:
 		alc_update_coefex_idx(codec, 0x57, 0x5, 1<<14, 0);
@@ -5574,6 +5577,7 @@ static void alc_headset_mode_omtp(struct hda_codec *codec)
 	case 0x10ec0289:
 	case 0x10ec0299:
 		alc_process_coef_fw(codec, coef0225);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	}
 	codec_dbg(codec, "Headset jack set to Nokia-style headset mode.\n");
@@ -5733,12 +5737,6 @@ static void alc_determine_headset_type(struct hda_codec *codec)
 	case 0x10ec0295:
 	case 0x10ec0289:
 	case 0x10ec0299:
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-		msleep(80);
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
-
 		alc_process_coef_fw(codec, alc225_pre_hsmode);
 		alc_update_coef_idx(codec, 0x67, 0xf000, 0x1000);
 		val = alc_read_coef_idx(codec, 0x45);
@@ -5755,15 +5753,19 @@ static void alc_determine_headset_type(struct hda_codec *codec)
 			val = alc_read_coef_idx(codec, 0x46);
 			is_ctia = (val & 0x00f0) == 0x00f0;
 		}
+		if (!is_ctia) {
+			alc_update_coef_idx(codec, 0x45, 0x3f<<10, 0x38<<10);
+			alc_update_coef_idx(codec, 0x49, 3<<8, 1<<8);
+			msleep(100);
+			val = alc_read_coef_idx(codec, 0x46);
+			if ((val & 0x00f0) == 0x00f0)
+				is_ctia = false;
+			else
+				is_ctia = true;
+		}
 		alc_update_coef_idx(codec, 0x4a, 7<<6, 7<<6);
 		alc_update_coef_idx(codec, 0x4a, 3<<4, 3<<4);
 		alc_update_coef_idx(codec, 0x67, 0xf000, 0x3000);
-
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
-		msleep(80);
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
 		break;
 	case 0x10ec0867:
 		is_ctia = true;
-- 
2.43.0


