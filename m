Return-Path: <stable+bounces-102476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6393B9EF216
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CC728BAE8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6920623ED7B;
	Thu, 12 Dec 2024 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vTX0bAPg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278B623ED73;
	Thu, 12 Dec 2024 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021368; cv=none; b=a3gL1F5aO8mqFAUGGeIuzRZ/GZNvhokaGUQKHpP8A/UsOk6oy0KjP1o6+1jjeUzkvgNRMuSwZUg5ts02DCa3GV8/BXwZoIJkyTymWdz54QCdTuXBR3q7hS6F6NR4Cn64UFRE15bIQdNbQi4TxLm5/Yh9zTI+fUdkLXs4y3JhiW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021368; c=relaxed/simple;
	bh=3Szz3lDF1QzysZUtXSj4SMOU4AoC6nkrhmewP0K3adc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqHiEk9htl/FpKlKS/xRBcm0fZrOFTjq7xYuPKnuBLRlJnEbMW6++ESpiSDJG9XY+Wicxy1Z/8qwHNpLVESDqaWmBTiTQ78PPA4mY6G9UvBaaxPOiCAeiwQAnPqNH91DXLG0Gj+nFVtu0HTok8Hbt7XdqgmpcguvmH220j2cvJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vTX0bAPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39970C4CED0;
	Thu, 12 Dec 2024 16:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021367;
	bh=3Szz3lDF1QzysZUtXSj4SMOU4AoC6nkrhmewP0K3adc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vTX0bAPgbodALfv8kiyFI/3huUFgWKHXPkN7FnxQ1NGQP9gRQoQs99YSGPa0JNuAb
	 lR2BqI2IVeYleujc8EP5qILwCO10mFNDjwML2TLfDl1leaPpgjgJMBLkfrRYkApTUO
	 /8OXm7l3MkIwWhApPcG9k7Z1eW4pvrLMgQgL4bPg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 688/772] ALSA: usb-audio: Make mic volume workarounds globally applicable
Date: Thu, 12 Dec 2024 16:00:33 +0100
Message-ID: <20241212144418.344125913@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 102a9b3ba3bef..4cded91d22a8d 100644
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
index 795c8aa6564bc..ecb49ba8432c2 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2030,7 +2030,7 @@ struct usb_audio_quirk_flags_table {
 static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	/* Device matches */
 	DEVICE_FLG(0x03f0, 0x654a, /* HP 320 FHD Webcam */
-		   QUIRK_FLAG_GET_SAMPLE_RATE),
+		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x041e, 0x3000, /* Creative SB Extigy */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x041e, 0x4080, /* Creative Live Cam VF0610 */
@@ -2038,10 +2038,31 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
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
@@ -2109,7 +2130,7 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x0fd9, 0x0008, /* Hauppauge HVR-950Q */
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
-		   QUIRK_FLAG_GET_SAMPLE_RATE),
+		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1397, 0x0507, /* Behringer UMC202HD */
@@ -2147,9 +2168,9 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
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
index f5a8dca66457f..65dcb1a02e976 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -178,6 +178,8 @@ extern bool snd_usb_skip_validation;
  * QUIRK_FLAG_FIXED_RATE
  *  Do not set PCM rate (frequency) when only one rate is available
  *  for the given endpoint.
+ * QUIRK_FLAG_MIC_RES_16 and QUIRK_FLAG_MIC_RES_384
+ *  Set the fixed resolution for Mic Capture Volume (mostly for webcams)
  */
 
 #define QUIRK_FLAG_GET_SAMPLE_RATE	(1U << 0)
@@ -202,5 +204,7 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_IFACE_SKIP_CLOSE	(1U << 19)
 #define QUIRK_FLAG_FORCE_IFACE_RESET	(1U << 20)
 #define QUIRK_FLAG_FIXED_RATE		(1U << 21)
+#define QUIRK_FLAG_MIC_RES_16		(1U << 22)
+#define QUIRK_FLAG_MIC_RES_384		(1U << 23)
 
 #endif /* __USBAUDIO_H */
-- 
2.43.0




