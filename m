Return-Path: <stable+bounces-81733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2584599490C
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34DB1F25C07
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE511DD867;
	Tue,  8 Oct 2024 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nVjO9ZAq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC4EEC8;
	Tue,  8 Oct 2024 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389951; cv=none; b=f6ZPY/UmmmJbPzNqWHpayBpL6mXf7w2OeE1ascYbxRA5cAPaU+Hfc8lSw/+r4Qwzovl03QCXG4spx+Q87AV2vCNw3hE0iVHXtddgQpr6Xm/tN1I/Rg1/Q2Cw9h+mk0xvPCuPudYEAeIHIGvtYjw1uKEll4CBUKjpUsVmwrlDiCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389951; c=relaxed/simple;
	bh=4AmegWmWP6F4tXaFhoOOfHbjs+02/oV4DoOf751TtLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLXnEybzD9UdGELhmgLygM5C2c00O4sYo8PM45tuZBq5C/GHBgCpL9fflYCTjXR9Tqa8B4oOQTD9BiGMBCmRNN7wheQ6wpwITRWg0o8sc4u+l2J+RMaixSOvSwhOy241J9Y06FSJnCQRjXg0vY9udQqrc+1OIZLyVW08gFjKup8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nVjO9ZAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1140C4CEC7;
	Tue,  8 Oct 2024 12:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728389951;
	bh=4AmegWmWP6F4tXaFhoOOfHbjs+02/oV4DoOf751TtLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVjO9ZAqW0XhpXNfIWWTsgLlwZEdGJxENVt6eR+PNqtNGD13Ps41ildeSkZX2kLlI
	 y6kvbFb+YTQA+Cnp66F9dUCEqD6/smxJhfUKiCzjv6mLbT8fYb0cLT9tfPq8SYcBFW
	 pqdU5KAlg8nifiUU0pB8g3QJfPKqi+IP15BXLD+Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Asahi Lina <lina@asahilina.net>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 145/482] ALSA: usb-audio: Add mixer quirk for RME Digiface USB
Date: Tue,  8 Oct 2024 14:03:28 +0200
Message-ID: <20241008115654.013924494@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Asahi Lina <lina@asahilina.net>

[ Upstream commit 611a96f6acf2e74fe28cb90908a9c183862348ce ]

Implement sync, output format, and input status mixer controls, to allow
the interface to be used as a straight ADAT/SPDIF (+ Headphones) I/O
interface.

This does not implement the matrix mixer, output gain controls, or input
level meter feedback. The full mixer interface is only really usable
using a dedicated userspace control app (there are too many mixer nodes
for alsamixer to be usable), so for now we leave it up to userspace to
directly control these features using raw USB control messages. This is
similar to how it's done with some FireWire interfaces (ffado-mixer).

Signed-off-by: Asahi Lina <lina@asahilina.net>
Link: https://patch.msgid.link/20240903-rme-digiface-v2-2-71b06c912e97@asahilina.net
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_quirks.c | 413 +++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks-table.h |   1 +
 2 files changed, 414 insertions(+)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 1d8bf1ecfed44..3727dbd123597 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -14,6 +14,7 @@
  *	    Przemek Rudy (prudy1@o2.pl)
  */
 
+#include <linux/bitfield.h>
 #include <linux/hid.h>
 #include <linux/init.h>
 #include <linux/math64.h>
@@ -2926,6 +2927,415 @@ static int snd_bbfpro_controls_create(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
+/*
+ * RME Digiface USB
+ */
+
+#define RME_DIGIFACE_READ_STATUS 17
+#define RME_DIGIFACE_STATUS_REG0L 0
+#define RME_DIGIFACE_STATUS_REG0H 1
+#define RME_DIGIFACE_STATUS_REG1L 2
+#define RME_DIGIFACE_STATUS_REG1H 3
+#define RME_DIGIFACE_STATUS_REG2L 4
+#define RME_DIGIFACE_STATUS_REG2H 5
+#define RME_DIGIFACE_STATUS_REG3L 6
+#define RME_DIGIFACE_STATUS_REG3H 7
+
+#define RME_DIGIFACE_CTL_REG1 16
+#define RME_DIGIFACE_CTL_REG2 18
+
+/* Reg is overloaded, 0-7 for status halfwords or 16 or 18 for control registers */
+#define RME_DIGIFACE_REGISTER(reg, mask) (((reg) << 16) | (mask))
+#define RME_DIGIFACE_INVERT BIT(31)
+
+/* Nonconst helpers */
+#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
+
+static int snd_rme_digiface_write_reg(struct snd_kcontrol *kcontrol, int item, u16 mask, u16 val)
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_audio *chip = list->mixer->chip;
+	struct usb_device *dev = chip->dev;
+	int err;
+
+	err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+			      item,
+			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			      val, mask, NULL, 0);
+	if (err < 0)
+		dev_err(&dev->dev,
+			"unable to issue control set request %d (ret = %d)",
+			item, err);
+	return err;
+}
+
+static int snd_rme_digiface_read_status(struct snd_kcontrol *kcontrol, u32 status[4])
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_audio *chip = list->mixer->chip;
+	struct usb_device *dev = chip->dev;
+	__le32 buf[4];
+	int err;
+
+	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
+			      RME_DIGIFACE_READ_STATUS,
+			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			      0, 0,
+			      buf, sizeof(buf));
+	if (err < 0) {
+		dev_err(&dev->dev,
+			"unable to issue status read request (ret = %d)",
+			err);
+	} else {
+		for (int i = 0; i < ARRAY_SIZE(buf); i++)
+			status[i] = le32_to_cpu(buf[i]);
+	}
+	return err;
+}
+
+static int snd_rme_digiface_get_status_val(struct snd_kcontrol *kcontrol)
+{
+	int err;
+	u32 status[4];
+	bool invert = kcontrol->private_value & RME_DIGIFACE_INVERT;
+	u8 reg = (kcontrol->private_value >> 16) & 0xff;
+	u16 mask = kcontrol->private_value & 0xffff;
+	u16 val;
+
+	err = snd_rme_digiface_read_status(kcontrol, status);
+	if (err < 0)
+		return err;
+
+	switch (reg) {
+	/* Status register halfwords */
+	case RME_DIGIFACE_STATUS_REG0L ... RME_DIGIFACE_STATUS_REG3H:
+		break;
+	case RME_DIGIFACE_CTL_REG1: /* Control register 1, present in halfword 3L */
+		reg = RME_DIGIFACE_STATUS_REG3L;
+		break;
+	case RME_DIGIFACE_CTL_REG2: /* Control register 2, present in halfword 3H */
+		reg = RME_DIGIFACE_STATUS_REG3H;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (reg & 1)
+		val = status[reg >> 1] >> 16;
+	else
+		val = status[reg >> 1] & 0xffff;
+
+	if (invert)
+		val ^= mask;
+
+	return field_get(mask, val);
+}
+
+static int snd_rme_digiface_rate_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	int freq = snd_rme_digiface_get_status_val(kcontrol);
+
+	if (freq < 0)
+		return freq;
+	if (freq >= ARRAY_SIZE(snd_rme_rate_table))
+		return -EIO;
+
+	ucontrol->value.integer.value[0] = snd_rme_rate_table[freq];
+	return 0;
+}
+
+static int snd_rme_digiface_enum_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	int val = snd_rme_digiface_get_status_val(kcontrol);
+
+	if (val < 0)
+		return val;
+
+	ucontrol->value.enumerated.item[0] = val;
+	return 0;
+}
+
+static int snd_rme_digiface_enum_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	bool invert = kcontrol->private_value & RME_DIGIFACE_INVERT;
+	u8 reg = (kcontrol->private_value >> 16) & 0xff;
+	u16 mask = kcontrol->private_value & 0xffff;
+	u16 val = field_prep(mask, ucontrol->value.enumerated.item[0]);
+
+	if (invert)
+		val ^= mask;
+
+	return snd_rme_digiface_write_reg(kcontrol, reg, mask, val);
+}
+
+static int snd_rme_digiface_current_sync_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	int ret = snd_rme_digiface_enum_get(kcontrol, ucontrol);
+
+	/* 7 means internal for current sync */
+	if (ucontrol->value.enumerated.item[0] == 7)
+		ucontrol->value.enumerated.item[0] = 0;
+
+	return ret;
+}
+
+static int snd_rme_digiface_sync_state_get(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	u32 status[4];
+	int err;
+	bool valid, sync;
+
+	err = snd_rme_digiface_read_status(kcontrol, status);
+	if (err < 0)
+		return err;
+
+	valid = status[0] & BIT(kcontrol->private_value);
+	sync = status[0] & BIT(5 + kcontrol->private_value);
+
+	if (!valid)
+		ucontrol->value.enumerated.item[0] = SND_RME_CLOCK_NOLOCK;
+	else if (!sync)
+		ucontrol->value.enumerated.item[0] = SND_RME_CLOCK_LOCK;
+	else
+		ucontrol->value.enumerated.item[0] = SND_RME_CLOCK_SYNC;
+	return 0;
+}
+
+
+static int snd_rme_digiface_format_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const format[] = {
+		"ADAT", "S/PDIF"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1,
+				 ARRAY_SIZE(format), format);
+}
+
+
+static int snd_rme_digiface_sync_source_info(struct snd_kcontrol *kcontrol,
+					     struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const sync_sources[] = {
+		"Internal", "Input 1", "Input 2", "Input 3", "Input 4"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1,
+				 ARRAY_SIZE(sync_sources), sync_sources);
+}
+
+static int snd_rme_digiface_rate_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 200000;
+	uinfo->value.integer.step = 0;
+	return 0;
+}
+
+static const struct snd_kcontrol_new snd_rme_digiface_controls[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 1 Sync",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_state_info,
+		.get = snd_rme_digiface_sync_state_get,
+		.private_value = 0,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 1 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG0H, BIT(0)) |
+			RME_DIGIFACE_INVERT,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 1 Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG1L, GENMASK(3, 0)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 2 Sync",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_state_info,
+		.get = snd_rme_digiface_sync_state_get,
+		.private_value = 1,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 2 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG0L, BIT(13)) |
+			RME_DIGIFACE_INVERT,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 2 Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG1L, GENMASK(7, 4)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 3 Sync",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_state_info,
+		.get = snd_rme_digiface_sync_state_get,
+		.private_value = 2,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 3 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG0L, BIT(14)) |
+			RME_DIGIFACE_INVERT,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 3 Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG1L, GENMASK(11, 8)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 4 Sync",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_state_info,
+		.get = snd_rme_digiface_sync_state_get,
+		.private_value = 3,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 4 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG0L, GENMASK(15, 12)) |
+			RME_DIGIFACE_INVERT,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 4 Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG1L, GENMASK(3, 0)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 1 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.put = snd_rme_digiface_enum_put,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG2, BIT(0)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 2 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.put = snd_rme_digiface_enum_put,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG2, BIT(1)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 3 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.put = snd_rme_digiface_enum_put,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG2, BIT(3)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 4 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.put = snd_rme_digiface_enum_put,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG2, BIT(4)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Sync Source",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_rme_digiface_sync_source_info,
+		.get = snd_rme_digiface_enum_get,
+		.put = snd_rme_digiface_enum_put,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG1, GENMASK(2, 0)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Current Sync Source",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_sync_source_info,
+		.get = snd_rme_digiface_current_sync_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG0L, GENMASK(12, 10)),
+	},
+	{
+		/*
+		 * This is writeable, but it is only set by the PCM rate.
+		 * Mixer apps currently need to drive the mixer using raw USB requests,
+		 * so they can also change this that way to configure the rate for
+		 * stand-alone operation when the PCM is closed.
+		 */
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "System Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG1, GENMASK(6, 3)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Current Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG1H, GENMASK(7, 4)),
+	}
+};
+
+static int snd_rme_digiface_controls_create(struct usb_mixer_interface *mixer)
+{
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(snd_rme_digiface_controls); ++i) {
+		err = add_single_ctl_with_resume(mixer, 0,
+						 NULL,
+						 &snd_rme_digiface_controls[i],
+						 NULL);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 /*
  * Pioneer DJ DJM Mixers
  *
@@ -3484,6 +3894,9 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 	case USB_ID(0x2a39, 0x3fb0): /* RME Babyface Pro FS */
 		err = snd_bbfpro_controls_create(mixer);
 		break;
+	case USB_ID(0x2a39, 0x3f8c): /* RME Digiface USB */
+		err = snd_rme_digiface_controls_create(mixer);
+		break;
 	case USB_ID(0x2b73, 0x0017): /* Pioneer DJ DJM-250MK2 */
 		err = snd_djm_controls_create(mixer, SND_DJM_250MK2_IDX);
 		break;
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 631b9ab80f6cd..24c981c9b2405 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3620,6 +3620,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			 * Three modes depending on sample rate band,
 			 * with different channel counts for in/out
 			 */
+			{ QUIRK_DATA_STANDARD_MIXER(0) },
 			{
 				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
-- 
2.43.0




