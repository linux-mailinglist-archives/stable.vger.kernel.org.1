Return-Path: <stable+bounces-93194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBDE9CD7D9
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96B4B2588A
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDE414EC77;
	Fri, 15 Nov 2024 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zhIH6s9V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B8C18871E;
	Fri, 15 Nov 2024 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653104; cv=none; b=pjMDPEB6izQS7Rg4zKRELYTifR5HwQpvc1jhUWARXAKxPvcmXHD0VepNaN1NH6578dOBKRfWelm8niiqF8R39zTZ8YrZexnaI5zG2xCoM79b5w21Ya5GcgE16gWD09ZHII04/VSlDCQxEOMbIDYXy+3cMPaPZVt1Y/hucX8iWG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653104; c=relaxed/simple;
	bh=HbPKaa48FRGcYLAgB51i6Uuq3MfYUkw5+y/OALUf9Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndSHEnmo6cnILBAnhO1yAgteeu2z7F2ebZ9YQvT9kIG91F5zzStsFLEPdSXYmFNNZ1Szv/JVTBNVUDZJXK0RyZUQCzjZ+v0OwmEV1GB9ONVE3DaP1U8Oq9CrChWfo1Ppo9K3TvCBrJRtcaByJl3e0uO/LfVSAklePWOWGnVZ+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zhIH6s9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316A9C4CECF;
	Fri, 15 Nov 2024 06:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653103;
	bh=HbPKaa48FRGcYLAgB51i6Uuq3MfYUkw5+y/OALUf9Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zhIH6s9VOVDdhKfJfYZeDLlmi27qINSTO4PcE/25wIZdU4X5pwZYa7+hP5hm4TCrI
	 e8KdoXxdtgYoHDssH2kTWo8HQDvrkrRg4K0mQnhlBt3ZhANYppa8CeG1cRc86rOzY8
	 s2OvT48sKVi/U9Pk44qPC9nEu8aE3MjapHnh67jQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Jan=20Sch=C3=A4r?= <jan@jschaer.ch>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 47/66] ALSA: usb-audio: Support jack detection on Dell dock
Date: Fri, 15 Nov 2024 07:37:56 +0100
Message-ID: <20241115063724.541189377@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.834793938@linuxfoundation.org>
References: <20241115063722.834793938@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Schär <jan@jschaer.ch>

[ Upstream commit 4b8ea38fabab45ad911a32a336416062553dfe9c ]

The Dell WD15 dock has a headset and a line out port. Add support for
detecting if a jack is inserted into one of these ports.
For the headset jack, additionally determine if a mic is present.

The WD15 contains an ALC4020 USB audio controller and ALC3263 audio codec
from Realtek. It is a UAC 1 device, and UAC 1 does not support jack
detection. Instead, jack detection works by sending HD Audio commands over
vendor-type USB messages.

I found out how it works by looking at USB captures on Windows.
The audio codec is very similar to the one supported by
sound/soc/codecs/rt298.c / rt298.h, some constant names and the mic
detection are adapted from there. The realtek_add_jack function is adapted
from build_connector_control in sound/usb/mixer.c.

I tested this on a WD15 dock with the latest firmware.

Signed-off-by: Jan Schär <jan@jschaer.ch>
Link: https://lore.kernel.org/r/20220627171855.42338-1-jan@jschaer.ch
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 4413665dd6c5 ("ALSA: usb-audio: Add quirks for Dell WD19 dock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_quirks.c | 167 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 167 insertions(+)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 1f7c80541d03b..08cbcd69b3251 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -24,6 +24,7 @@
 #include <sound/asoundef.h>
 #include <sound/core.h>
 #include <sound/control.h>
+#include <sound/hda_verbs.h>
 #include <sound/hwdep.h>
 #include <sound/info.h>
 #include <sound/tlv.h>
@@ -1792,6 +1793,169 @@ static int snd_soundblaster_e1_switch_create(struct usb_mixer_interface *mixer)
 					  NULL);
 }
 
+/*
+ * Dell WD15 dock jack detection
+ *
+ * The WD15 contains an ALC4020 USB audio controller and ALC3263 audio codec
+ * from Realtek. It is a UAC 1 device, and UAC 1 does not support jack
+ * detection. Instead, jack detection works by sending HD Audio commands over
+ * vendor-type USB messages.
+ */
+
+#define HDA_VERB_CMD(V, N, D) (((N) << 20) | ((V) << 8) | (D))
+
+#define REALTEK_HDA_VALUE 0x0038
+
+#define REALTEK_HDA_SET		62
+#define REALTEK_HDA_GET_OUT	88
+#define REALTEK_HDA_GET_IN	89
+
+#define REALTEK_LINE1			0x1a
+#define REALTEK_VENDOR_REGISTERS	0x20
+#define REALTEK_HP_OUT			0x21
+
+#define REALTEK_CBJ_CTRL2 0x50
+
+#define REALTEK_JACK_INTERRUPT_NODE 5
+
+#define REALTEK_MIC_FLAG 0x100
+
+static int realtek_hda_set(struct snd_usb_audio *chip, u32 cmd)
+{
+	struct usb_device *dev = chip->dev;
+	u32 buf = cpu_to_be32(cmd);
+
+	return snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), REALTEK_HDA_SET,
+			       USB_RECIP_DEVICE | USB_TYPE_VENDOR | USB_DIR_OUT,
+			       REALTEK_HDA_VALUE, 0, &buf, sizeof(buf));
+}
+
+static int realtek_hda_get(struct snd_usb_audio *chip, u32 cmd, u32 *value)
+{
+	struct usb_device *dev = chip->dev;
+	int err;
+	u32 buf = cpu_to_be32(cmd);
+
+	err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), REALTEK_HDA_GET_OUT,
+			      USB_RECIP_DEVICE | USB_TYPE_VENDOR | USB_DIR_OUT,
+			      REALTEK_HDA_VALUE, 0, &buf, sizeof(buf));
+	if (err < 0)
+		return err;
+	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), REALTEK_HDA_GET_IN,
+			      USB_RECIP_DEVICE | USB_TYPE_VENDOR | USB_DIR_IN,
+			      REALTEK_HDA_VALUE, 0, &buf, sizeof(buf));
+	if (err < 0)
+		return err;
+
+	*value = be32_to_cpu(buf);
+	return 0;
+}
+
+static int realtek_ctl_connector_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	struct snd_usb_audio *chip = cval->head.mixer->chip;
+	u32 pv = kcontrol->private_value;
+	u32 node_id = pv & 0xff;
+	u32 sense;
+	u32 cbj_ctrl2;
+	bool presence;
+	int err;
+
+	err = snd_usb_lock_shutdown(chip);
+	if (err < 0)
+		return err;
+	err = realtek_hda_get(chip,
+			      HDA_VERB_CMD(AC_VERB_GET_PIN_SENSE, node_id, 0),
+			      &sense);
+	if (err < 0)
+		goto err;
+	if (pv & REALTEK_MIC_FLAG) {
+		err = realtek_hda_set(chip,
+				      HDA_VERB_CMD(AC_VERB_SET_COEF_INDEX,
+						   REALTEK_VENDOR_REGISTERS,
+						   REALTEK_CBJ_CTRL2));
+		if (err < 0)
+			goto err;
+		err = realtek_hda_get(chip,
+				      HDA_VERB_CMD(AC_VERB_GET_PROC_COEF,
+						   REALTEK_VENDOR_REGISTERS, 0),
+				      &cbj_ctrl2);
+		if (err < 0)
+			goto err;
+	}
+err:
+	snd_usb_unlock_shutdown(chip);
+	if (err < 0)
+		return err;
+
+	presence = sense & AC_PINSENSE_PRESENCE;
+	if (pv & REALTEK_MIC_FLAG)
+		presence = presence && (cbj_ctrl2 & 0x0070) == 0x0070;
+	ucontrol->value.integer.value[0] = presence;
+	return 0;
+}
+
+static const struct snd_kcontrol_new realtek_connector_ctl_ro = {
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.name = "", /* will be filled later manually */
+	.access = SNDRV_CTL_ELEM_ACCESS_READ,
+	.info = snd_ctl_boolean_mono_info,
+	.get = realtek_ctl_connector_get,
+};
+
+static int realtek_resume_jack(struct usb_mixer_elem_list *list)
+{
+	snd_ctl_notify(list->mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+		       &list->kctl->id);
+	return 0;
+}
+
+static int realtek_add_jack(struct usb_mixer_interface *mixer,
+			    char *name, u32 val)
+{
+	struct usb_mixer_elem_info *cval;
+	struct snd_kcontrol *kctl;
+
+	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
+	if (!cval)
+		return -ENOMEM;
+	snd_usb_mixer_elem_init_std(&cval->head, mixer,
+				    REALTEK_JACK_INTERRUPT_NODE);
+	cval->head.resume = realtek_resume_jack;
+	cval->val_type = USB_MIXER_BOOLEAN;
+	cval->channels = 1;
+	cval->min = 0;
+	cval->max = 1;
+	kctl = snd_ctl_new1(&realtek_connector_ctl_ro, cval);
+	if (!kctl) {
+		kfree(cval);
+		return -ENOMEM;
+	}
+	kctl->private_value = val;
+	strscpy(kctl->id.name, name, sizeof(kctl->id.name));
+	kctl->private_free = snd_usb_mixer_elem_free;
+	return snd_usb_mixer_add_control(&cval->head, kctl);
+}
+
+static int dell_dock_mixer_create(struct usb_mixer_interface *mixer)
+{
+	int err;
+
+	err = realtek_add_jack(mixer, "Line Out Jack", REALTEK_LINE1);
+	if (err < 0)
+		return err;
+	err = realtek_add_jack(mixer, "Headphone Jack", REALTEK_HP_OUT);
+	if (err < 0)
+		return err;
+	err = realtek_add_jack(mixer, "Headset Mic Jack",
+			       REALTEK_HP_OUT | REALTEK_MIC_FLAG);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
 static void dell_dock_init_vol(struct snd_usb_audio *chip, int ch, int id)
 {
 	u16 buf = 0;
@@ -2275,6 +2439,9 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_soundblaster_e1_switch_create(mixer);
 		break;
 	case USB_ID(0x0bda, 0x4014): /* Dell WD15 dock */
+		err = dell_dock_mixer_create(mixer);
+		if (err < 0)
+			break;
 		err = dell_dock_mixer_init(mixer);
 		break;
 
-- 
2.43.0




