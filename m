Return-Path: <stable+bounces-72915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4A296A944
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5252C1C241FD
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92841126C1F;
	Tue,  3 Sep 2024 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UC06O4Is"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2EC1E6326;
	Tue,  3 Sep 2024 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396399; cv=none; b=EWrGblTTsPS02BqjyzEzHd6y0vznLNjWFiSm7QsRviPWhO0uvbUDtmwgSJpOdYAtcb/8l8BEmQ1DsmwO/hDV2Jdmvkg7qP3IhAl79WezawxEgJ7qd6CfNnpn7GqL+fS8Gfpvza0bsIOfnmxZMm/Z0jIBWtYAB96MbNltAYrFkjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396399; c=relaxed/simple;
	bh=XWIib460lo5a5CYAnIVOwgX0UcyU+WCcWbJzrEbvjPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfwgXIhIw22ziI2Ir33JGDpc1ugj8xGhE44hYbB2ERMwhNcDvqw3R/p1kdGfyD2HJjHWUZ5CDtZlGeBlk1RyQIM6r0Qex1xa8kvuzM6EyxBL8nUntSF5HUVdlorDtbpkvq6wW8/yBhKG5rs8peARr/hL/vRSWHnVyd3rKZq/qpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UC06O4Is; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D5DC4CEC4;
	Tue,  3 Sep 2024 20:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396397;
	bh=XWIib460lo5a5CYAnIVOwgX0UcyU+WCcWbJzrEbvjPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UC06O4Is+BjqNLumhQgAffXM4VB8WoZvTrae7F4/SwYD3VXz1RrFrvY62QTGx0a44
	 lOi+Y2HSvgJ/oBHyweavEn3RVA9dsKh5qlnMFw1wqKCIZAqdTs2tsUSJ4peNBpTxgl
	 DqUfaguP0Snlf0twPV7Jrj/ljaAtjJ0A/BdSC6P9ra6HA8L5Ub9nGeJ95uInZaAyBQ
	 QEO6SYztSrY8lPKfz0Q06+THajnqxckFirOz/OTIByfO/7q+Ff++5Mjv3j6zKADmbh
	 7M1tnRm6XfypQVBY4JJpaKgsCaCnDgDTtO/U/HlBWSx7EOzhv71vDliuiFeGYZAXrM
	 Q9jubOzjI6Lgg==
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
Subject: [PATCH AUTOSEL 5.15 02/12] ALSA: hda/realtek - Fixed ALC256 headphone no sound
Date: Tue,  3 Sep 2024 15:26:46 -0400
Message-ID: <20240903192718.1108456-2-sashal@kernel.org>
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

[ Upstream commit 9b82ff1362f50914c8292902e07be98a9f59d33d ]

Dell platform, plug headphone or headset, it had a chance to get no
sound from headphone.
Replace depop procedure will solve this issue.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://lore.kernel.org/bb8e2de30d294dc287944efa0667685a@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 50 ++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8729896c7f9cd..477ba33d991ab 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4906,6 +4906,30 @@ static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 	}
 }
 
+static void alc_hp_mute_disable(struct hda_codec *codec, unsigned int delay)
+{
+	if (delay <= 0)
+		delay = 75;
+	snd_hda_codec_write(codec, 0x21, 0,
+		    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+	msleep(delay);
+	snd_hda_codec_write(codec, 0x21, 0,
+		    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+	msleep(delay);
+}
+
+static void alc_hp_enable_unmute(struct hda_codec *codec, unsigned int delay)
+{
+	if (delay <= 0)
+		delay = 75;
+	snd_hda_codec_write(codec, 0x21, 0,
+		    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+	msleep(delay);
+	snd_hda_codec_write(codec, 0x21, 0,
+		    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+	msleep(delay);
+}
+
 static const struct coef_fw alc225_pre_hsmode[] = {
 	UPDATE_COEF(0x4a, 1<<8, 0),
 	UPDATE_COEFEX(0x57, 0x05, 1<<14, 0),
@@ -5007,6 +5031,7 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 	case 0x10ec0236:
 	case 0x10ec0256:
 	case 0x19e58326:
+		alc_hp_mute_disable(codec, 75);
 		alc_process_coef_fw(codec, coef0256);
 		break;
 	case 0x10ec0234:
@@ -5278,6 +5303,7 @@ static void alc_headset_mode_default(struct hda_codec *codec)
 		alc_write_coef_idx(codec, 0x45, 0xc089);
 		msleep(50);
 		alc_process_coef_fw(codec, coef0256);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
@@ -5375,6 +5401,7 @@ static void alc_headset_mode_ctia(struct hda_codec *codec)
 	case 0x10ec0256:
 	case 0x19e58326:
 		alc_process_coef_fw(codec, coef0256);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
@@ -5490,6 +5517,7 @@ static void alc_headset_mode_omtp(struct hda_codec *codec)
 	case 0x10ec0256:
 	case 0x19e58326:
 		alc_process_coef_fw(codec, coef0256);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
@@ -5595,25 +5623,21 @@ static void alc_determine_headset_type(struct hda_codec *codec)
 		alc_write_coef_idx(codec, 0x06, 0x6104);
 		alc_write_coefex_idx(codec, 0x57, 0x3, 0x09a3);
 
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-		msleep(80);
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
-
 		alc_process_coef_fw(codec, coef0255);
 		msleep(300);
 		val = alc_read_coef_idx(codec, 0x46);
 		is_ctia = (val & 0x0070) == 0x0070;
-
+		if (!is_ctia) {
+			alc_write_coef_idx(codec, 0x45, 0xe089);
+			msleep(100);
+			val = alc_read_coef_idx(codec, 0x46);
+			if ((val & 0x0070) == 0x0070)
+				is_ctia = false;
+			else
+				is_ctia = true;
+		}
 		alc_write_coefex_idx(codec, 0x57, 0x3, 0x0da3);
 		alc_update_coefex_idx(codec, 0x57, 0x5, 1<<14, 0);
-
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
-		msleep(80);
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
-- 
2.43.0


