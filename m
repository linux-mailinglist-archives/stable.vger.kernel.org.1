Return-Path: <stable+bounces-96272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E209E1A4A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 12:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164DEB258AC
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394851E1C1A;
	Tue,  3 Dec 2024 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ssofPRZX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1CF1E0B6C
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221747; cv=none; b=rwHpz67X05SdWX5kw36nFhcTujLLja7fU3fgXP7HuhmmE/FbQfnh8RLrS/qjaehp+SufGNd4D7+QwZTPLv5knPAdi1QqroOXXT63oJ3JOYgPlqAJB8QwXn8I4os2A6Oh4rNV3zZPEAn5Op8FX8+gc6NFnf8NHmz5lmLn4Eq7I60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221747; c=relaxed/simple;
	bh=uH9WwDmchR6ewqvgzVy71zcFF5AtOJCjhyX1ToI1wns=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NlINGgU+I8KZ5YQoo5aoyIRilGdF153frdUEVDWrkxUXfNr/LWKYyGzCz3NzlMSi93WN9NHfa3pb/eoLjO5mzvuoEHV1ApXYeR3YskQlZts9VmQLdcCvlE4riZRuMXrX8ftbRA/2m8rBmxuLe2PCyCxBePTZyznOjw8QOn7jd00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ssofPRZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11493C4CECF;
	Tue,  3 Dec 2024 10:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733221746;
	bh=uH9WwDmchR6ewqvgzVy71zcFF5AtOJCjhyX1ToI1wns=;
	h=Subject:To:Cc:From:Date:From;
	b=ssofPRZXYLCr4h4v/sDe6l3HPJePfea/NTgeA1Ynttcuyh+0VWcGS9ZDAZBuf/Rwz
	 eXFkxtEV87YtPVkZLsU6UxJfQ7umS54SAP2KwduWJostgC+gqI5Sh137gTXHs5u62x
	 SCX1Ar8Asdh1IZa8HmVFwg1o6k+4AgnLoRH7zEZ4=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Update ALC225 depop procedure" failed to apply to 4.19-stable tree
To: kailang@realtek.com,stable@vger.kernel.org,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 11:29:03 +0100
Message-ID: <2024120303-talcum-editor-4060@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 1fd50509fe14a9adc9329e0454b986157a4c155a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120303-talcum-editor-4060@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1fd50509fe14a9adc9329e0454b986157a4c155a Mon Sep 17 00:00:00 2001
From: Kailang Yang <kailang@realtek.com>
Date: Thu, 14 Nov 2024 15:08:07 +0800
Subject: [PATCH] ALSA: hda/realtek: Update ALC225 depop procedure

Old procedure has a chance to meet Headphone no output.

Fixes: da911b1f5e98 ("ALSA: hda/realtek - update ALC225 depop optimize")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/5a27b016ba9d42b4a4e6dadce50a3ba4@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 290c0710f24d..c53a5f8d1559 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3768,33 +3768,28 @@ static void alc225_init(struct hda_codec *codec)
 	hp1_pin_sense = snd_hda_jack_detect(codec, hp_pin);
 	hp2_pin_sense = snd_hda_jack_detect(codec, 0x16);
 
-	if (hp1_pin_sense || hp2_pin_sense)
+	if (hp1_pin_sense || hp2_pin_sense) {
 		msleep(2);
+		alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x1); /* Low power */
 
-	alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x1); /* Low power */
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x16, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		msleep(75);
 
-	if (hp1_pin_sense || spec->ultra_low_power)
-		snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-	if (hp2_pin_sense)
-		snd_hda_codec_write(codec, 0x16, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x16, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
 
-	if (hp1_pin_sense || hp2_pin_sense || spec->ultra_low_power)
-		msleep(85);
-
-	if (hp1_pin_sense || spec->ultra_low_power)
-		snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
-	if (hp2_pin_sense)
-		snd_hda_codec_write(codec, 0x16, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
-
-	if (hp1_pin_sense || hp2_pin_sense || spec->ultra_low_power)
-		msleep(100);
-
-	alc_update_coef_idx(codec, 0x4a, 3 << 10, 0);
-	alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x4); /* Hight power */
+		msleep(75);
+		alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x4); /* Hight power */
+	}
 }
 
 static void alc225_shutup(struct hda_codec *codec)
@@ -3806,36 +3801,35 @@ static void alc225_shutup(struct hda_codec *codec)
 	if (!hp_pin)
 		hp_pin = 0x21;
 
-	alc_disable_headset_jack_key(codec);
-	/* 3k pull low control for Headset jack. */
-	alc_update_coef_idx(codec, 0x4a, 0, 3 << 10);
-
 	hp1_pin_sense = snd_hda_jack_detect(codec, hp_pin);
 	hp2_pin_sense = snd_hda_jack_detect(codec, 0x16);
 
-	if (hp1_pin_sense || hp2_pin_sense)
+	if (hp1_pin_sense || hp2_pin_sense) {
+		alc_disable_headset_jack_key(codec);
+		/* 3k pull low control for Headset jack. */
+		alc_update_coef_idx(codec, 0x4a, 0, 3 << 10);
 		msleep(2);
 
-	if (hp1_pin_sense || spec->ultra_low_power)
-		snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-	if (hp2_pin_sense)
-		snd_hda_codec_write(codec, 0x16, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x16, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 
-	if (hp1_pin_sense || hp2_pin_sense || spec->ultra_low_power)
-		msleep(85);
+		msleep(75);
 
-	if (hp1_pin_sense || spec->ultra_low_power)
-		snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
-	if (hp2_pin_sense)
-		snd_hda_codec_write(codec, 0x16, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
-
-	if (hp1_pin_sense || hp2_pin_sense || spec->ultra_low_power)
-		msleep(100);
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x16, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
 
+		msleep(75);
+		alc_update_coef_idx(codec, 0x4a, 3 << 10, 0);
+		alc_enable_headset_jack_key(codec);
+	}
 	alc_auto_setup_eapd(codec, false);
 	alc_shutup_pins(codec);
 	if (spec->ultra_low_power) {
@@ -3846,9 +3840,6 @@ static void alc225_shutup(struct hda_codec *codec)
 		alc_update_coef_idx(codec, 0x4a, 3<<4, 2<<4);
 		msleep(30);
 	}
-
-	alc_update_coef_idx(codec, 0x4a, 3 << 10, 0);
-	alc_enable_headset_jack_key(codec);
 }
 
 static void alc_default_init(struct hda_codec *codec)


