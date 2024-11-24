Return-Path: <stable+bounces-95137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6C29D7396
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B2228326B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283A422CFFC;
	Sun, 24 Nov 2024 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoODnS8H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CB322CFEC;
	Sun, 24 Nov 2024 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456117; cv=none; b=r85ylVVLPgAIdnIQ3LQjLtO3WDPRFB8NHZ8bSnSKaDjHghtboYn+204vLSkyvoe7UBL3TDUpJ7vSG3JRC9E9bZ9XkVpzciqz7GLSezUjbpBmfeO6upAtjq09XZcrUTgyO76UhlWk9b9SZCryf1iXSMSTVLBep2cMYVDhsSCInSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456117; c=relaxed/simple;
	bh=LHYGawaan1qKgqF4szL9SFKsB3xZX8f8HVIK3lqLhPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGatkrWG/rRTzjmEPIFnUTLT4BlRMeFGhq1KQ54+AUU2oYoUK1UGRs2XPHJqjLkXbDkYor/F4rXx5VIfaG50EgX+HsMHqkN+RKkVVX3LhwnOp65hYmxdkp8+oWvjmT7tr/NuKQlNOnYoiuHat/+5tk6srcvkueYnIQX6DseDujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoODnS8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213BBC4CECC;
	Sun, 24 Nov 2024 13:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456117;
	bh=LHYGawaan1qKgqF4szL9SFKsB3xZX8f8HVIK3lqLhPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WoODnS8HJ9diq6vIhYXb5/Fm1I0kEZTaXONbUiO2fVVfO+woexHx8jzEiDZ+BzZcE
	 jzi/rKtRygbKmy97kYJR7HIuTqP+hr2pdnOZxGjBqu0Gcv1aUprkMD2AnVsYp3+nGH
	 Go+ctqmGKUIHoNAWFjfSgv0+vDKx31f7A2t0p1UWLai4AECqEJlSFQeF68G2a+iDWs
	 kkTITs5nMRXsykhFYjE/UTfKFXFe+Es7/x5FfmIqGisu5oelu2HMCcxQRxetH6XmFp
	 59Cgdt1zZji0RG2ywtTUwKqrrH6NSNm6RNRv65zO8Ial7UJQih6TYrgOj0bwBN06ve
	 0UDC48KjRjLRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kl@kl.wtf,
	wangdicheng@kylinos.cn,
	k.kosik@outlook.com,
	zhujun2@cmss.chinamobile.com,
	mbarriolinares@gmail.com,
	hulianqin@vivo.com,
	lalinsky@c4.cz,
	cyan.vtb@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 47/61] ALSA: usb-audio: Make mic volume workarounds globally applicable
Date: Sun, 24 Nov 2024 08:45:22 -0500
Message-ID: <20241124134637.3346391-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 22b206595a4f1..b8fa0a866153b 100644
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
index 37211ad31ec89..9f45968ad6942 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2017,7 +2017,7 @@ struct usb_audio_quirk_flags_table {
 static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	/* Device matches */
 	DEVICE_FLG(0x03f0, 0x654a, /* HP 320 FHD Webcam */
-		   QUIRK_FLAG_GET_SAMPLE_RATE),
+		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x041e, 0x3000, /* Creative SB Extigy */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x041e, 0x4080, /* Creative Live Cam VF0610 */
@@ -2025,10 +2025,31 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
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
@@ -2096,7 +2117,7 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x0fd9, 0x0008, /* Hauppauge HVR-950Q */
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
-		   QUIRK_FLAG_GET_SAMPLE_RATE),
+		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1397, 0x0507, /* Behringer UMC202HD */
@@ -2134,9 +2155,9 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
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


