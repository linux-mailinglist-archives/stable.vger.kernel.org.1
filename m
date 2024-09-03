Return-Path: <stable+bounces-72882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DE696A8E6
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67FF1C24071
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B7B1E0B62;
	Tue,  3 Sep 2024 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyUtrpks"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26091E0B61;
	Tue,  3 Sep 2024 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396240; cv=none; b=Nq8WjA7JGTSk83D9xQQgwmDlqmrcXPoArYi7h+AlYVRPkN37Obed6o0jJ23stNtqcPIHJO1sHFcNcWfey30FZJwa1Vnzg/ngvmN9VymxDE3UQ7k+sp3pOOos+VSl671G3k8bjloP1AX7X2aKsCP+YG76CT3FUUMsbajpyxS2rBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396240; c=relaxed/simple;
	bh=53h7Ydrybidj/IDRGtNo7okdkjV5nuXQxpqgA4RKxgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpzjHNY5UgvBcV3l74RDXh4hC+LNaUk77GcTS3myoTY+DPFp8+/qULqMP5scSwfBop7yKiOinbSAKmtdnxRHdfZfO8/ScOn7h/WCwbZbdVNldh2H5DIhGEr2WWaSwfb9Qda26c7nLIB5WtAudLV7mtpFyxF+bDzXWs+gQtCF8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyUtrpks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2A8C4CEC4;
	Tue,  3 Sep 2024 20:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396240;
	bh=53h7Ydrybidj/IDRGtNo7okdkjV5nuXQxpqgA4RKxgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GyUtrpksw2UOqHa6fdsWt2iLzspb+8qQm6BAztMcOWGQkBstH9ESvZr2yIyLMe0L6
	 ctEo75ee9WTfmAJShFR1k0bAAGO2+z92qvfsuAXX2hA3i6vCOhq9N4UJwP/JD2aJtP
	 ZazG/sc600utXj+Enn88awc0E3KFETLMNUqmRYVySCQZ6k1k6lvyFrssb3s8RYtSg2
	 Wi38HR5L4xCbIQd/AqJ1W1j2dFF/Ft+3TrvjmmYcUsHSl9zYwDZpYJWAZMOB0t+aUY
	 oNtPD0l1t+Jtp8uwnBWjna7/zp11HrzJGudu087CUYII59716sBP8qx0Z+wRyEWtsD
	 RiySVDsXV3DJg==
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
Subject: [PATCH AUTOSEL 6.6 06/20] ALSA: hda/realtek - FIxed ALC285 headphone no sound
Date: Tue,  3 Sep 2024 15:23:38 -0400
Message-ID: <20240903192425.1107562-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192425.1107562-1-sashal@kernel.org>
References: <20240903192425.1107562-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.48
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
index e74cd110b64bb..b12aafa5f0fe9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5091,6 +5091,7 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 	case 0x10ec0295:
 	case 0x10ec0289:
 	case 0x10ec0299:
+		alc_hp_mute_disable(codec, 75);
 		alc_process_coef_fw(codec, alc225_pre_hsmode);
 		alc_process_coef_fw(codec, coef0225);
 		break;
@@ -5316,6 +5317,7 @@ static void alc_headset_mode_default(struct hda_codec *codec)
 	case 0x10ec0299:
 		alc_process_coef_fw(codec, alc225_pre_hsmode);
 		alc_process_coef_fw(codec, coef0225);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0255:
 		alc_process_coef_fw(codec, coef0255);
@@ -5475,6 +5477,7 @@ static void alc_headset_mode_ctia(struct hda_codec *codec)
 			alc_process_coef_fw(codec, coef0225_2);
 		else
 			alc_process_coef_fw(codec, coef0225_1);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0867:
 		alc_update_coefex_idx(codec, 0x57, 0x5, 1<<14, 0);
@@ -5580,6 +5583,7 @@ static void alc_headset_mode_omtp(struct hda_codec *codec)
 	case 0x10ec0289:
 	case 0x10ec0299:
 		alc_process_coef_fw(codec, coef0225);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	}
 	codec_dbg(codec, "Headset jack set to Nokia-style headset mode.\n");
@@ -5739,12 +5743,6 @@ static void alc_determine_headset_type(struct hda_codec *codec)
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
@@ -5761,15 +5759,19 @@ static void alc_determine_headset_type(struct hda_codec *codec)
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


