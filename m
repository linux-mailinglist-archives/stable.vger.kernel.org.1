Return-Path: <stable+bounces-65877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7757194AC53
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6FE1F23CB7
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9990F824BB;
	Wed,  7 Aug 2024 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="At1q9EP1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CEC374CC;
	Wed,  7 Aug 2024 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043645; cv=none; b=d5ULSWYW25aL+tl+NcNVdX5xc4RTwax4aSngqNRXc3nDMHrIdbqiMKVoUq/rnrDCn76AWLyy5aZmlM2QByM2b4oCq++FP73K0gyb05F9LghLRXFiudSlFq05QeSfvuqWmIFJ/vaYRWM1Jqvq2RObjxRv1z4C1EYq3a99CTMbtVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043645; c=relaxed/simple;
	bh=RncT3SKwKqBRvGcx84b0/k76linahqHb4el4LPPbwb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DntHHvRA+Ifczp3+XruJ6v4meqPcHSeuaT+P+jdJfEswTpvCkpaQZkZoJ/b+sb64j5DXgO4SRh0o4FxrDTK8bIMUTJ6BiwMUT6bYASgj2S7rwvGhAiA2ytoBuc+QOZt+Klf1inWFOjn/C737GmB8hKaubMQNBeT3qSdYM6i/dvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=At1q9EP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DB6C4AF0D;
	Wed,  7 Aug 2024 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723043645;
	bh=RncT3SKwKqBRvGcx84b0/k76linahqHb4el4LPPbwb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=At1q9EP1Tw7XpTtNM9hi9Rqopoi8BzJHy0RGQgryCXT17QhkzpvYpJ5hBS4hYSI0V
	 46lOcSntuws+aVU/djkW8BdyXCho8Mwy5OX12Z/ISp0XQtxK2pav+ttWpRmAeM4Yx2
	 O7YIn2waQ7XEkAwb39MuxJJytRX4EISMWgDO9mRo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	bo liu <bo.liu@senarytech.com>,
	songxiebing <songxiebing@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 46/86] ALSA: hda: conexant: Fix headset auto detect fail in the polling mode
Date: Wed,  7 Aug 2024 17:00:25 +0200
Message-ID: <20240807150040.760718460@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150039.247123516@linuxfoundation.org>
References: <20240807150039.247123516@linuxfoundation.org>
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

From: songxiebing <songxiebing@kylinos.cn>

[ Upstream commit e60dc98122110594d0290845160f12916192fc6d ]

The previous fix (7aeb25908648) only handles the unsol_event reporting
during interrupts and does not include the polling mode used to set
jackroll_ms, so now we are replacing it with
snd_hda_jack_detect_enable_callback.

Fixes: 7aeb25908648 ("ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140")
Co-developed-by: bo liu <bo.liu@senarytech.com>
Signed-off-by: bo liu <bo.liu@senarytech.com>
Signed-off-by: songxiebing <songxiebing@kylinos.cn>
Link: https://patch.msgid.link/20240726100726.50824-1-soxiebing@163.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_conexant.c | 54 ++++++----------------------------
 1 file changed, 9 insertions(+), 45 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 17389a3801bd1..4472923ba694b 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -21,12 +21,6 @@
 #include "hda_jack.h"
 #include "hda_generic.h"
 
-enum {
-	CX_HEADSET_NOPRESENT = 0,
-	CX_HEADSET_PARTPRESENT,
-	CX_HEADSET_ALLPRESENT,
-};
-
 struct conexant_spec {
 	struct hda_gen_spec gen;
 
@@ -48,7 +42,6 @@ struct conexant_spec {
 	unsigned int gpio_led;
 	unsigned int gpio_mute_led_mask;
 	unsigned int gpio_mic_led_mask;
-	unsigned int headset_present_flag;
 	bool is_cx8070_sn6140;
 };
 
@@ -250,48 +243,19 @@ static void cx_process_headset_plugin(struct hda_codec *codec)
 	}
 }
 
-static void cx_update_headset_mic_vref(struct hda_codec *codec, unsigned int res)
+static void cx_update_headset_mic_vref(struct hda_codec *codec, struct hda_jack_callback *event)
 {
-	unsigned int phone_present, mic_persent, phone_tag, mic_tag;
-	struct conexant_spec *spec = codec->spec;
+	unsigned int mic_present;
 
 	/* In cx8070 and sn6140, the node 16 can only be config to headphone or disabled,
 	 * the node 19 can only be config to microphone or disabled.
 	 * Check hp&mic tag to process headset pulgin&plugout.
 	 */
-	phone_tag = snd_hda_codec_read(codec, 0x16, 0, AC_VERB_GET_UNSOLICITED_RESPONSE, 0x0);
-	mic_tag = snd_hda_codec_read(codec, 0x19, 0, AC_VERB_GET_UNSOLICITED_RESPONSE, 0x0);
-	if ((phone_tag & (res >> AC_UNSOL_RES_TAG_SHIFT)) ||
-	    (mic_tag & (res >> AC_UNSOL_RES_TAG_SHIFT))) {
-		phone_present = snd_hda_codec_read(codec, 0x16, 0, AC_VERB_GET_PIN_SENSE, 0x0);
-		if (!(phone_present & AC_PINSENSE_PRESENCE)) {/* headphone plugout */
-			spec->headset_present_flag = CX_HEADSET_NOPRESENT;
-			snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20);
-			return;
-		}
-		if (spec->headset_present_flag == CX_HEADSET_NOPRESENT) {
-			spec->headset_present_flag = CX_HEADSET_PARTPRESENT;
-		} else if (spec->headset_present_flag == CX_HEADSET_PARTPRESENT) {
-			mic_persent = snd_hda_codec_read(codec, 0x19, 0,
-							 AC_VERB_GET_PIN_SENSE, 0x0);
-			/* headset is present */
-			if ((phone_present & AC_PINSENSE_PRESENCE) &&
-			    (mic_persent & AC_PINSENSE_PRESENCE)) {
-				cx_process_headset_plugin(codec);
-				spec->headset_present_flag = CX_HEADSET_ALLPRESENT;
-			}
-		}
-	}
-}
-
-static void cx_jack_unsol_event(struct hda_codec *codec, unsigned int res)
-{
-	struct conexant_spec *spec = codec->spec;
-
-	if (spec->is_cx8070_sn6140)
-		cx_update_headset_mic_vref(codec, res);
-
-	snd_hda_jack_unsol_event(codec, res);
+	mic_present = snd_hda_codec_read(codec, 0x19, 0, AC_VERB_GET_PIN_SENSE, 0x0);
+	if (!(mic_present & AC_PINSENSE_PRESENCE)) /* mic plugout */
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20);
+	else
+		cx_process_headset_plugin(codec);
 }
 
 static int cx_auto_suspend(struct hda_codec *codec)
@@ -305,7 +269,7 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
 	.build_pcms = snd_hda_gen_build_pcms,
 	.init = cx_auto_init,
 	.free = cx_auto_free,
-	.unsol_event = cx_jack_unsol_event,
+	.unsol_event = snd_hda_jack_unsol_event,
 	.suspend = cx_auto_suspend,
 	.check_power_status = snd_hda_gen_check_power_status,
 };
@@ -1163,7 +1127,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	case 0x14f11f86:
 	case 0x14f11f87:
 		spec->is_cx8070_sn6140 = true;
-		spec->headset_present_flag = CX_HEADSET_NOPRESENT;
+		snd_hda_jack_detect_enable_callback(codec, 0x19, cx_update_headset_mic_vref);
 		break;
 	}
 
-- 
2.43.0




