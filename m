Return-Path: <stable+bounces-72916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD4D96A946
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446191F25419
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E7C1DCB12;
	Tue,  3 Sep 2024 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IE0F7Ghq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFFC1DCB07;
	Tue,  3 Sep 2024 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396402; cv=none; b=XKo89eqC7T+PzHuVj2Pk5jSVL9Hh65t+PIHrCv4A+XFj2nPwY8n83jYSiI4gGggzZ7wdCg91Ob0rJQrcU4t+vJf2QnpyWalnHqdyhJaa4cjrZvgRgm/9OXqIVbkEPyD2478ghKk7QRslD6fcr9iAt0pDr1Agydncar306El13Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396402; c=relaxed/simple;
	bh=isvfGKmY5cC485PePP+xpjvCY+6MbdM4gY2GRFWMhMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpELWUKD7SaH8qyvpBJb+a9kuX8+dsg8wgYIOix8WVFlwskXDtSr8QzRwA3Y70/GsBsPVie2Ob3yGkMm+CLE0HjypdVh0J2pDL6NloZ4D66mstXMtFkS8/0FdiN3g1wvr3L1RXKz9uxmbV6mMEMR3ESMTnokVhIaOrOf8kipLxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IE0F7Ghq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AA0C4CEC4;
	Tue,  3 Sep 2024 20:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396402;
	bh=isvfGKmY5cC485PePP+xpjvCY+6MbdM4gY2GRFWMhMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IE0F7GhqLGLXhe956QoknJHu7WHG8yoktHotO7p2O4w6YaStk2CbDUYbrurpg4P8k
	 /UAsfa8zHAw45egqzNr9B0NoD+7vN0yAIgXdtkIPC3ud1MHSjzig4UAzuQ5srU7K/g
	 Snt2LVSeXOWz5bTr69mHZ0Lzzcv8ACXy/d8Xz739cGLq0APrPGzZy1Zl9eiCNuMHjj
	 kQ53JP53NtweNRp91MkoayUZArPD1aDSl4Yku4hlIl9MY5yeE/FB9B1m5olYfZEFiT
	 9gJkpLlkCY07iqOoCqujLkSdibRDGo7B6wbJ4upVsvPr/NtlDzdLaUmUqIOwU9itQp
	 eKN6o56GMcvtg==
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
Subject: [PATCH AUTOSEL 5.15 03/12] ALSA: hda/realtek - FIxed ALC285 headphone no sound
Date: Tue,  3 Sep 2024 15:26:47 -0400
Message-ID: <20240903192718.1108456-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192718.1108456-1-sashal@kernel.org>
References: <20240903192718.1108456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.165
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
index 477ba33d991ab..018649100248b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5066,6 +5066,7 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 	case 0x10ec0295:
 	case 0x10ec0289:
 	case 0x10ec0299:
+		alc_hp_mute_disable(codec, 75);
 		alc_process_coef_fw(codec, alc225_pre_hsmode);
 		alc_process_coef_fw(codec, coef0225);
 		break;
@@ -5291,6 +5292,7 @@ static void alc_headset_mode_default(struct hda_codec *codec)
 	case 0x10ec0299:
 		alc_process_coef_fw(codec, alc225_pre_hsmode);
 		alc_process_coef_fw(codec, coef0225);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0255:
 		alc_process_coef_fw(codec, coef0255);
@@ -5450,6 +5452,7 @@ static void alc_headset_mode_ctia(struct hda_codec *codec)
 			alc_process_coef_fw(codec, coef0225_2);
 		else
 			alc_process_coef_fw(codec, coef0225_1);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0867:
 		alc_update_coefex_idx(codec, 0x57, 0x5, 1<<14, 0);
@@ -5555,6 +5558,7 @@ static void alc_headset_mode_omtp(struct hda_codec *codec)
 	case 0x10ec0289:
 	case 0x10ec0299:
 		alc_process_coef_fw(codec, coef0225);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	}
 	codec_dbg(codec, "Headset jack set to Nokia-style headset mode.\n");
@@ -5714,12 +5718,6 @@ static void alc_determine_headset_type(struct hda_codec *codec)
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
@@ -5736,15 +5734,19 @@ static void alc_determine_headset_type(struct hda_codec *codec)
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


