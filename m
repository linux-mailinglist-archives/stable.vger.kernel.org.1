Return-Path: <stable+bounces-95071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A9A9D72E3
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE228165200
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0939120C466;
	Sun, 24 Nov 2024 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcMEha30"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B702020C038;
	Sun, 24 Nov 2024 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455893; cv=none; b=LRZOpm1nxzULy/19PT6aWZzsov7k8YGB/ntPtWlwm6F/y12ftxNkvYyG9VRA9xmjzBniKdWixh4gCI0zgqY27nJkYJpNWJg9ud6Brw+2sjYJc/EkSKgPssX9OtW3hw2hoENMrlxRSsHkKcztIaNVXnXCjj9sja36Kq1QzussyLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455893; c=relaxed/simple;
	bh=ibpwPP4UhA3eiLkkl6Gz5szL7IqxJiPQLi+COia3Hn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mToruqvCEOQghzfeuI81UH4WMvGGoFGO+8fBFGovWV9v9J8eotdD/DC7Pg4kE9rBua6OUy18rz7YXFmHFcbtMH2jkHxr96FlACGkHemeqzh3gm2VyL5qdXhdtskyKeORvFPKBuJ7Rb7uWmQ/KT5A1Nn6g1TiIcHT6K93gLxEi6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcMEha30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16348C4CED3;
	Sun, 24 Nov 2024 13:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455893;
	bh=ibpwPP4UhA3eiLkkl6Gz5szL7IqxJiPQLi+COia3Hn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gcMEha30F5fNQWzAYdQnuR6tsmSOVUOqWJ09xFEOpkgqDLIp8tJkaSnWaXwURCa8B
	 0ZFJxV2KDHJR2/XP3iPo1930+v3Id3aemkAPRhh5pYAicY6qBEFKTs/NklY8TbgZhN
	 ApkOpa8tfMxrWBAwT8L89Tv8DgtkKG6op4Xaj/SCgVzJS8HTJIoGbr/aYCVwoEgRZH
	 75yZrG2rxKN2yKE9y9JNrLMevM5NQIQsNt6LS79B3QwRgUNmyTygNg2z3e2ndQkkq0
	 OPmnzfjuqvWKoQd2p0q8xd/+89jTkKGuGYC++Dla5P3vdkJzSPYBNpZKqVcu1se1UY
	 l/mjbEO9v/mqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kl@kl.wtf,
	k.kosik@outlook.com,
	zhujun2@cmss.chinamobile.com,
	wangdicheng@kylinos.cn,
	mbarriolinares@gmail.com,
	hulianqin@vivo.com,
	knuesel@gmail.com,
	cyan.vtb@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 68/87] ALSA: usb-audio: Make mic volume workarounds globally applicable
Date: Sun, 24 Nov 2024 08:38:46 -0500
Message-ID: <20241124134102.3344326-68-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit d6e6b9218ced5249b9136833ef5ec3f554ec7fde ]

It seems that many webcams have buggy firmware and don't expose the
mic capture volume with the proper resolution.  We have workarounds in
mixer.c, but judging from the numbers, those can be better managed as
global quirk flags.

Link: https://patch.msgid.link/20241105120220.5740-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c    | 58 ++++++++++++--------------------------------
 sound/usb/quirks.c   | 31 +++++++++++++++++++----
 sound/usb/usbaudio.h |  4 +++
 3 files changed, 45 insertions(+), 48 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 25b3c04584732..f8fb8c9e2c381 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1084,6 +1084,21 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 				  struct snd_kcontrol *kctl)
 {
 	struct snd_usb_audio *chip = cval->head.mixer->chip;
+
+	if (chip->quirk_flags & QUIRK_FLAG_MIC_RES_384) {
+		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
+			usb_audio_info(chip,
+				"set resolution quirk: cval->res = 384\n");
+			cval->res = 384;
+		}
+	} else if (chip->quirk_flags & QUIRK_FLAG_MIC_RES_16) {
+		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
+			usb_audio_info(chip,
+				"set resolution quirk: cval->res = 16\n");
+			cval->res = 16;
+		}
+	}
+
 	switch (chip->usb_id) {
 	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
 	case USB_ID(0x0763, 0x2031): /* M-Audio Fast Track C600 */
@@ -1168,27 +1183,6 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 		}
 		break;
 
-	case USB_ID(0x046d, 0x0807): /* Logitech Webcam C500 */
-	case USB_ID(0x046d, 0x0808):
-	case USB_ID(0x046d, 0x0809):
-	case USB_ID(0x046d, 0x0819): /* Logitech Webcam C210 */
-	case USB_ID(0x046d, 0x081b): /* HD Webcam c310 */
-	case USB_ID(0x046d, 0x081d): /* HD Webcam c510 */
-	case USB_ID(0x046d, 0x0825): /* HD Webcam c270 */
-	case USB_ID(0x046d, 0x0826): /* HD Webcam c525 */
-	case USB_ID(0x046d, 0x08ca): /* Logitech Quickcam Fusion */
-	case USB_ID(0x046d, 0x0991):
-	case USB_ID(0x046d, 0x09a2): /* QuickCam Communicate Deluxe/S7500 */
-	/* Most audio usb devices lie about volume resolution.
-	 * Most Logitech webcams have res = 384.
-	 * Probably there is some logitech magic behind this number --fishor
-	 */
-		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
-			usb_audio_info(chip,
-				"set resolution quirk: cval->res = 384\n");
-			cval->res = 384;
-		}
-		break;
 	case USB_ID(0x0495, 0x3042): /* ESS Technology Asus USB DAC */
 		if ((strstr(kctl->id.name, "Playback Volume") != NULL) ||
 			strstr(kctl->id.name, "Capture Volume") != NULL) {
@@ -1197,28 +1191,6 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 			cval->res = 1;
 		}
 		break;
-	case USB_ID(0x1224, 0x2a25): /* Jieli Technology USB PHY 2.0 */
-		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
-			usb_audio_info(chip,
-				"set resolution quirk: cval->res = 16\n");
-			cval->res = 16;
-		}
-		break;
-	case USB_ID(0x1bcf, 0x2283): /* NexiGo N930AF FHD Webcam */
-	case USB_ID(0x03f0, 0x654a): /* HP 320 FHD Webcam */
-		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
-			usb_audio_info(chip,
-				"set resolution quirk: cval->res = 16\n");
-			cval->res = 16;
-		}
-		break;
-	case USB_ID(0x1bcf, 0x2281): /* HD Webcam */
-		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
-			usb_audio_info(chip,
-				"set resolution quirk: cval->res = 16\n");
-			cval->res = 16;
-		}
-		break;
 	}
 }
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index cee49341dabc1..29c981cc20110 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2115,7 +2115,7 @@ struct usb_audio_quirk_flags_table {
 static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	/* Device matches */
 	DEVICE_FLG(0x03f0, 0x654a, /* HP 320 FHD Webcam */
-		   QUIRK_FLAG_GET_SAMPLE_RATE),
+		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x041e, 0x3000, /* Creative SB Extigy */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x041e, 0x4080, /* Creative Live Cam VF0610 */
@@ -2123,10 +2123,31 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x045e, 0x083c, /* MS USB Link headset */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_CTL_MSG_DELAY |
 		   QUIRK_FLAG_DISABLE_AUTOSUSPEND),
+	DEVICE_FLG(0x046d, 0x0807, /* Logitech Webcam C500 */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
+	DEVICE_FLG(0x046d, 0x0808, /* Logitech Webcam C600 */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
+	DEVICE_FLG(0x046d, 0x0809,
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
+	DEVICE_FLG(0x046d, 0x0819, /* Logitech Webcam C210 */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
+	DEVICE_FLG(0x046d, 0x081b, /* HD Webcam c310 */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
+	DEVICE_FLG(0x046d, 0x081d, /* HD Webcam c510 */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
+	DEVICE_FLG(0x046d, 0x0825, /* HD Webcam c270 */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
+	DEVICE_FLG(0x046d, 0x0826, /* HD Webcam c525 */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
 	DEVICE_FLG(0x046d, 0x084c, /* Logitech ConferenceCam Connect */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x046d, 0x08ca, /* Logitech Quickcam Fusion */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
 	DEVICE_FLG(0x046d, 0x0991, /* Logitech QuickCam Pro */
-		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_IGNORE_CTL_ERROR),
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_IGNORE_CTL_ERROR |
+		   QUIRK_FLAG_MIC_RES_384),
+	DEVICE_FLG(0x046d, 0x09a2, /* QuickCam Communicate Deluxe/S7500 */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
 	DEVICE_FLG(0x046d, 0x09a4, /* Logitech QuickCam E 3500 */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x0499, 0x1509, /* Steinberg UR22 */
@@ -2194,7 +2215,7 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x0fd9, 0x0008, /* Hauppauge HVR-950Q */
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
-		   QUIRK_FLAG_GET_SAMPLE_RATE),
+		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1397, 0x0507, /* Behringer UMC202HD */
@@ -2232,9 +2253,9 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x19f7, 0x0035, /* RODE NT-USB+ */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1bcf, 0x2281, /* HD Webcam */
-		   QUIRK_FLAG_GET_SAMPLE_RATE),
+		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x1bcf, 0x2283, /* NexiGo N930AF FHD Webcam */
-		   QUIRK_FLAG_GET_SAMPLE_RATE),
+		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x2040, 0x7200, /* Hauppauge HVR-950Q */
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x2040, 0x7201, /* Hauppauge HVR-950Q-MXL */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 43d4029edab46..ddfbe045e7a94 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -182,6 +182,8 @@ extern bool snd_usb_skip_validation;
  * QUIRK_FLAG_FIXED_RATE
  *  Do not set PCM rate (frequency) when only one rate is available
  *  for the given endpoint.
+ * QUIRK_FLAG_MIC_RES_16 and QUIRK_FLAG_MIC_RES_384
+ *  Set the fixed resolution for Mic Capture Volume (mostly for webcams)
  */
 
 #define QUIRK_FLAG_GET_SAMPLE_RATE	(1U << 0)
@@ -206,5 +208,7 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_IFACE_SKIP_CLOSE	(1U << 19)
 #define QUIRK_FLAG_FORCE_IFACE_RESET	(1U << 20)
 #define QUIRK_FLAG_FIXED_RATE		(1U << 21)
+#define QUIRK_FLAG_MIC_RES_16		(1U << 22)
+#define QUIRK_FLAG_MIC_RES_384		(1U << 23)
 
 #endif /* __USBAUDIO_H */
-- 
2.43.0


