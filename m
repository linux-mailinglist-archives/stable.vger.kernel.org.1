Return-Path: <stable+bounces-82748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC94994E47
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3732D1F2341F
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0291DF25E;
	Tue,  8 Oct 2024 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PqAO6Z63"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14521DE89A;
	Tue,  8 Oct 2024 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393295; cv=none; b=rddzCWhaJvq3W7llsPWBvz9ex1jjhBQlDpbf88QlEw5024w5tGWdo2Xubpn3L6vj8GJCPuFu1mqfsz61NOh8kpte5vxwYvYphLsLf5s09c1Lt3YoeDgaLjz7J0Aw1DT3jEU5lI9C7fiaVFsAV2OrIFB83hwpZ2eFy9cAe2s5DRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393295; c=relaxed/simple;
	bh=rLZGay+xMuUXDA+90FKcg+L0GWb7/T1ATzpNhpq+yUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3Z05AQA6l+ZnaHShlaPq4IqOY+qEx9EezIX1xuUN3O73l983T998BHlY18YXBQH+W3R9/yjXHN++gLEpAUkO1SWvs60OyeTwAnrV8BA+gxWBcgCJyzNGF1qaUDKLQcLdAxCcLz1UjNlDA9HlgnbA+eWGrEVmevdNu4KnPdUz0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PqAO6Z63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCA5C4CEC7;
	Tue,  8 Oct 2024 13:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728393294;
	bh=rLZGay+xMuUXDA+90FKcg+L0GWb7/T1ATzpNhpq+yUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PqAO6Z63RjnMRIC2V1xZmSrRsIIkoFfuNin1etamjcelZTDMlum0m/m1BrGqznzzK
	 wavPDLSXUKQV4frYRtfxCa2mYbJcso0+IwNCfC7UbJ7T6Z5+PztB/qLKmmkJJNEP/N
	 m2MNOibIVgz5f+KXGfttmjcJHvAGHqcl34czLLPk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Karol Kosik <k.kosik@outlook.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 109/386] ALSA: usb-audio: Support multiple control interfaces
Date: Tue,  8 Oct 2024 14:05:54 +0200
Message-ID: <20241008115633.732179368@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karol Kosik <k.kosik@outlook.com>

[ Upstream commit 6aa8700150f7dc62f60b4cf5b1624e2e3d9ed78e ]

Registering Numark Party Mix II fails with error 'bogus bTerminalLink 1'.
The problem stems from the driver not being able to find input/output
terminals required to configure audio streaming. The information about
those terminals is stored in AudioControl Interface. Numark device
contains 2 AudioControl Interfaces and the driver checks only one of them.

According to the USB standard, a device can have multiple audio functions,
each represented by Audio Interface Collection. Every audio function is
considered to be closed box and will contain unique AudioControl Interface
and zero or more AudioStreaming and MIDIStreaming Interfaces.

The Numark device adheres to the standard and defines two audio functions:
- MIDIStreaming function
- AudioStreaming function
It starts with MIDI function, followed by the audio function. The driver
saves the first AudioControl Interface in `snd_usb_audio` structure
associated with the entire device. It then attempts to use this interface
to query for terminals and clocks. However, this fails because the correct
information is stored in the second AudioControl Interface, defined in the
second Audio Interface Collection.

This patch introduces a structure holding association between each
MIDI/Audio Interface and its corresponding AudioControl Interface,
instead of relying on AudioControl Interface defined for the entire
device. This structure is populated during usb probing phase and leveraged
later when querying for terminals and when sending USB requests.

Alternative solutions considered include:
- defining a quirk for Numark where the order of interface is manually
changed, or terminals are hardcoded in the driver. This solution would
have fixed only this model, though it seems that device is USB compliant,
and it also seems that other devices from this company may be affected.
What's more, it looks like products from other manufacturers have similar
problems, i.e. Rane One DJ console
- keeping a list of all AudioControl Interfaces and querying all of them
to find required information. That would have solved my problem and have
low probability of breaking other devices, as we would always start with
the same logic of querying first AudioControl Interface. This solution
would not have followed the standard though.

This patch preserves the `snd_usb_audio.ctrl_intf` variable, which holds
the first AudioControl Interface, and uses it as a fallback when some
interfaces are not parsed correctly and lack an associated AudioControl
Interface, i.e., when configured via quirks.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217865
Signed-off-by: Karol Kosik <k.kosik@outlook.com>
Link: https://patch.msgid.link/AS8P190MB1285893F4735C8B32AD3886BEC852@AS8P190MB1285.EURP190.PROD.OUTLOOK.COM
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/card.c           |  2 ++
 sound/usb/clock.c          | 62 ++++++++++++++++++++++++--------------
 sound/usb/format.c         |  6 ++--
 sound/usb/helper.c         | 34 +++++++++++++++++++++
 sound/usb/helper.h         | 10 ++++--
 sound/usb/mixer.c          |  2 +-
 sound/usb/mixer_quirks.c   | 17 ++++++-----
 sound/usb/mixer_scarlett.c |  4 +--
 sound/usb/power.c          |  3 +-
 sound/usb/power.h          |  1 +
 sound/usb/stream.c         | 21 ++++++++-----
 sound/usb/usbaudio.h       | 12 ++++++++
 12 files changed, 127 insertions(+), 47 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 1b2edc0fd2e99..7c98cc831b8d9 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -206,6 +206,8 @@ static int snd_usb_create_stream(struct snd_usb_audio *chip, int ctrlif, int int
 		return -EINVAL;
 	}
 
+	snd_usb_add_ctrl_interface_link(chip, interface, ctrlif);
+
 	if (! snd_usb_parse_audio_interface(chip, interface)) {
 		usb_set_interface(dev, interface, 0); /* reset the current interface */
 		return usb_driver_claim_interface(&usb_audio_driver, iface,
diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index a676ad093d189..6f0693c428b0b 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -76,11 +76,14 @@ static bool validate_clock_multiplier(void *p, int id, int proto)
 }
 
 #define DEFINE_FIND_HELPER(name, obj, validator, type2, type3)		\
-static obj *name(struct snd_usb_audio *chip, int id, int proto)	\
+static obj *name(struct snd_usb_audio *chip, int id,	\
+				const struct audioformat *fmt)	\
 {									\
-	return find_uac_clock_desc(chip->ctrl_intf, id, validator,	\
-				   proto == UAC_VERSION_3 ? (type3) : (type2), \
-				   proto);				\
+	struct usb_host_interface *ctrl_intf =	\
+		snd_usb_find_ctrl_interface(chip, fmt->iface); \
+	return find_uac_clock_desc(ctrl_intf, id, validator,	\
+				   fmt->protocol == UAC_VERSION_3 ? (type3) : (type2), \
+				   fmt->protocol);				\
 }
 
 DEFINE_FIND_HELPER(snd_usb_find_clock_source,
@@ -93,16 +96,19 @@ DEFINE_FIND_HELPER(snd_usb_find_clock_multiplier,
 		   union uac23_clock_multiplier_desc, validate_clock_multiplier,
 		   UAC2_CLOCK_MULTIPLIER, UAC3_CLOCK_MULTIPLIER);
 
-static int uac_clock_selector_get_val(struct snd_usb_audio *chip, int selector_id)
+static int uac_clock_selector_get_val(struct snd_usb_audio *chip,
+				int selector_id, int iface_no)
 {
+	struct usb_host_interface *ctrl_intf;
 	unsigned char buf;
 	int ret;
 
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, iface_no);
 	ret = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0),
 			      UAC2_CS_CUR,
 			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			      UAC2_CX_CLOCK_SELECTOR << 8,
-			      snd_usb_ctrl_intf(chip) | (selector_id << 8),
+			      snd_usb_ctrl_intf(ctrl_intf) | (selector_id << 8),
 			      &buf, sizeof(buf));
 
 	if (ret < 0)
@@ -111,16 +117,18 @@ static int uac_clock_selector_get_val(struct snd_usb_audio *chip, int selector_i
 	return buf;
 }
 
-static int uac_clock_selector_set_val(struct snd_usb_audio *chip, int selector_id,
-					unsigned char pin)
+static int uac_clock_selector_set_val(struct snd_usb_audio *chip,
+					int selector_id, unsigned char pin, int iface_no)
 {
+	struct usb_host_interface *ctrl_intf;
 	int ret;
 
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, iface_no);
 	ret = snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
 			      UAC2_CS_CUR,
 			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
 			      UAC2_CX_CLOCK_SELECTOR << 8,
-			      snd_usb_ctrl_intf(chip) | (selector_id << 8),
+			      snd_usb_ctrl_intf(ctrl_intf) | (selector_id << 8),
 			      &pin, sizeof(pin));
 	if (ret < 0)
 		return ret;
@@ -132,7 +140,7 @@ static int uac_clock_selector_set_val(struct snd_usb_audio *chip, int selector_i
 		return -EINVAL;
 	}
 
-	ret = uac_clock_selector_get_val(chip, selector_id);
+	ret = uac_clock_selector_get_val(chip, selector_id, iface_no);
 	if (ret < 0)
 		return ret;
 
@@ -155,8 +163,10 @@ static bool uac_clock_source_is_valid_quirk(struct snd_usb_audio *chip,
 	unsigned char data;
 	struct usb_device *dev = chip->dev;
 	union uac23_clock_source_desc *cs_desc;
+	struct usb_host_interface *ctrl_intf;
 
-	cs_desc = snd_usb_find_clock_source(chip, source_id, fmt->protocol);
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, fmt->iface);
+	cs_desc = snd_usb_find_clock_source(chip, source_id, fmt);
 	if (!cs_desc)
 		return false;
 
@@ -191,7 +201,7 @@ static bool uac_clock_source_is_valid_quirk(struct snd_usb_audio *chip,
 			err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 					      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 					      UAC2_CS_CONTROL_CLOCK_VALID << 8,
-					      snd_usb_ctrl_intf(chip) | (source_id << 8),
+					      snd_usb_ctrl_intf(ctrl_intf) | (source_id << 8),
 					      &data, sizeof(data));
 			if (err < 0) {
 				dev_warn(&dev->dev,
@@ -217,8 +227,10 @@ static bool uac_clock_source_is_valid(struct snd_usb_audio *chip,
 	struct usb_device *dev = chip->dev;
 	u32 bmControls;
 	union uac23_clock_source_desc *cs_desc;
+	struct usb_host_interface *ctrl_intf;
 
-	cs_desc = snd_usb_find_clock_source(chip, source_id, fmt->protocol);
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, fmt->iface);
+	cs_desc = snd_usb_find_clock_source(chip, source_id, fmt);
 	if (!cs_desc)
 		return false;
 
@@ -235,7 +247,7 @@ static bool uac_clock_source_is_valid(struct snd_usb_audio *chip,
 	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 			      UAC2_CS_CONTROL_CLOCK_VALID << 8,
-			      snd_usb_ctrl_intf(chip) | (source_id << 8),
+			      snd_usb_ctrl_intf(ctrl_intf) | (source_id << 8),
 			      &data, sizeof(data));
 
 	if (err < 0) {
@@ -272,7 +284,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 	}
 
 	/* first, see if the ID we're looking at is a clock source already */
-	source = snd_usb_find_clock_source(chip, entity_id, proto);
+	source = snd_usb_find_clock_source(chip, entity_id, fmt);
 	if (source) {
 		entity_id = GET_VAL(source, proto, bClockID);
 		if (validate && !uac_clock_source_is_valid(chip, fmt,
@@ -285,7 +297,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 		return entity_id;
 	}
 
-	selector = snd_usb_find_clock_selector(chip, entity_id, proto);
+	selector = snd_usb_find_clock_selector(chip, entity_id, fmt);
 	if (selector) {
 		pins = GET_VAL(selector, proto, bNrInPins);
 		clock_id = GET_VAL(selector, proto, bClockID);
@@ -299,7 +311,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 
 		/* the entity ID we are looking at is a selector.
 		 * find out what it currently selects */
-		ret = uac_clock_selector_get_val(chip, clock_id);
+		ret = uac_clock_selector_get_val(chip, clock_id, fmt->iface);
 		if (ret < 0) {
 			if (!chip->autoclock)
 				return ret;
@@ -327,7 +339,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 			/* Skip setting clock selector again for some devices */
 			if (chip->quirk_flags & QUIRK_FLAG_SKIP_CLOCK_SELECTOR)
 				return ret;
-			err = uac_clock_selector_set_val(chip, entity_id, cur);
+			err = uac_clock_selector_set_val(chip, entity_id, cur, fmt->iface);
 			if (err < 0) {
 				if (pins == 1) {
 					usb_audio_dbg(chip,
@@ -355,7 +367,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 			if (ret < 0)
 				continue;
 
-			err = uac_clock_selector_set_val(chip, entity_id, i);
+			err = uac_clock_selector_set_val(chip, entity_id, i, fmt->iface);
 			if (err < 0)
 				continue;
 
@@ -369,7 +381,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 	}
 
 	/* FIXME: multipliers only act as pass-thru element for now */
-	multiplier = snd_usb_find_clock_multiplier(chip, entity_id, proto);
+	multiplier = snd_usb_find_clock_multiplier(chip, entity_id, fmt);
 	if (multiplier)
 		return __uac_clock_find_source(chip, fmt,
 					       GET_VAL(multiplier, proto, bCSourceID),
@@ -469,11 +481,13 @@ static int get_sample_rate_v2v3(struct snd_usb_audio *chip, int iface,
 	struct usb_device *dev = chip->dev;
 	__le32 data;
 	int err;
+	struct usb_host_interface *ctrl_intf;
 
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, iface);
 	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 			      UAC2_CS_CONTROL_SAM_FREQ << 8,
-			      snd_usb_ctrl_intf(chip) | (clock << 8),
+			      snd_usb_ctrl_intf(ctrl_intf) | (clock << 8),
 			      &data, sizeof(data));
 	if (err < 0) {
 		dev_warn(&dev->dev, "%d:%d: cannot get freq (v2/v3): err %d\n",
@@ -502,8 +516,10 @@ int snd_usb_set_sample_rate_v2v3(struct snd_usb_audio *chip,
 	__le32 data;
 	int err;
 	union uac23_clock_source_desc *cs_desc;
+	struct usb_host_interface *ctrl_intf;
 
-	cs_desc = snd_usb_find_clock_source(chip, clock, fmt->protocol);
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, fmt->iface);
+	cs_desc = snd_usb_find_clock_source(chip, clock, fmt);
 
 	if (!cs_desc)
 		return 0;
@@ -522,7 +538,7 @@ int snd_usb_set_sample_rate_v2v3(struct snd_usb_audio *chip,
 	err = snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0), UAC2_CS_CUR,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
 			      UAC2_CS_CONTROL_SAM_FREQ << 8,
-			      snd_usb_ctrl_intf(chip) | (clock << 8),
+			      snd_usb_ctrl_intf(ctrl_intf) | (clock << 8),
 			      &data, sizeof(data));
 	if (err < 0)
 		return err;
diff --git a/sound/usb/format.c b/sound/usb/format.c
index 3b45d0ee76938..61c4aca8be09e 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -548,7 +548,9 @@ static int parse_audio_format_rates_v2v3(struct snd_usb_audio *chip,
 	unsigned char tmp[2], *data;
 	int nr_triplets, data_size, ret = 0, ret_l6;
 	int clock = snd_usb_clock_find_source(chip, fp, false);
+	struct usb_host_interface *ctrl_intf;
 
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, fp->iface);
 	if (clock < 0) {
 		dev_err(&dev->dev,
 			"%s(): unable to find clock source (clock %d)\n",
@@ -560,7 +562,7 @@ static int parse_audio_format_rates_v2v3(struct snd_usb_audio *chip,
 	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_RANGE,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 			      UAC2_CS_CONTROL_SAM_FREQ << 8,
-			      snd_usb_ctrl_intf(chip) | (clock << 8),
+			      snd_usb_ctrl_intf(ctrl_intf) | (clock << 8),
 			      tmp, sizeof(tmp));
 
 	if (ret < 0) {
@@ -595,7 +597,7 @@ static int parse_audio_format_rates_v2v3(struct snd_usb_audio *chip,
 	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_RANGE,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 			      UAC2_CS_CONTROL_SAM_FREQ << 8,
-			      snd_usb_ctrl_intf(chip) | (clock << 8),
+			      snd_usb_ctrl_intf(ctrl_intf) | (clock << 8),
 			      data, data_size);
 
 	if (ret < 0) {
diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index bf80e55d013a8..72b671fb2c84c 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -130,3 +130,37 @@ snd_usb_get_host_interface(struct snd_usb_audio *chip, int ifnum, int altsetting
 		return NULL;
 	return usb_altnum_to_altsetting(iface, altsetting);
 }
+
+int snd_usb_add_ctrl_interface_link(struct snd_usb_audio *chip, int ifnum,
+		int ctrlif)
+{
+	struct usb_device *dev = chip->dev;
+	struct usb_host_interface *host_iface;
+
+	if (chip->num_intf_to_ctrl >= MAX_CARD_INTERFACES) {
+		dev_info(&dev->dev, "Too many interfaces assigned to the single USB-audio card\n");
+		return -EINVAL;
+	}
+
+	/* find audiocontrol interface */
+	host_iface = &usb_ifnum_to_if(dev, ctrlif)->altsetting[0];
+
+	chip->intf_to_ctrl[chip->num_intf_to_ctrl].interface = ifnum;
+	chip->intf_to_ctrl[chip->num_intf_to_ctrl].ctrl_intf = host_iface;
+	chip->num_intf_to_ctrl++;
+
+	return 0;
+}
+
+struct usb_host_interface *snd_usb_find_ctrl_interface(struct snd_usb_audio *chip,
+							int ifnum)
+{
+	int i;
+
+	for (i = 0; i < chip->num_intf_to_ctrl; ++i)
+		if (chip->intf_to_ctrl[i].interface == ifnum)
+			return chip->intf_to_ctrl[i].ctrl_intf;
+
+	/* Fallback to first audiocontrol interface */
+	return chip->ctrl_intf;
+}
diff --git a/sound/usb/helper.h b/sound/usb/helper.h
index e2b51ec96ec62..0372e050b3dc4 100644
--- a/sound/usb/helper.h
+++ b/sound/usb/helper.h
@@ -17,6 +17,12 @@ unsigned char snd_usb_parse_datainterval(struct snd_usb_audio *chip,
 struct usb_host_interface *
 snd_usb_get_host_interface(struct snd_usb_audio *chip, int ifnum, int altsetting);
 
+int snd_usb_add_ctrl_interface_link(struct snd_usb_audio *chip, int ifnum,
+		int ctrlif);
+
+struct usb_host_interface *snd_usb_find_ctrl_interface(struct snd_usb_audio *chip,
+								int ifnum);
+
 /*
  * retrieve usb_interface descriptor from the host interface
  * (conditional for compatibility with the older API)
@@ -28,9 +34,9 @@ snd_usb_get_host_interface(struct snd_usb_audio *chip, int ifnum, int altsetting
 
 #define snd_usb_get_speed(dev) ((dev)->speed)
 
-static inline int snd_usb_ctrl_intf(struct snd_usb_audio *chip)
+static inline int snd_usb_ctrl_intf(struct usb_host_interface *ctrl_intf)
 {
-	return get_iface_desc(chip->ctrl_intf)->bInterfaceNumber;
+	return get_iface_desc(ctrl_intf)->bInterfaceNumber;
 }
 
 /* in validate.c */
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 197fd07e69edd..017b50322d88f 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -728,7 +728,7 @@ static int get_cluster_channels_v3(struct mixer_build *state, unsigned int clust
 			UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
 			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			cluster_id,
-			snd_usb_ctrl_intf(state->chip),
+			snd_usb_ctrl_intf(state->mixer->hostif),
 			&c_header, sizeof(c_header));
 	if (err < 0)
 		goto error;
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index c8d48566e1759..2323504339328 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1043,7 +1043,7 @@ static int snd_ftu_eff_switch_init(struct usb_mixer_interface *mixer,
 	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC_GET_CUR,
 			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			      pval & 0xff00,
-			      snd_usb_ctrl_intf(mixer->chip) | ((pval & 0xff) << 8),
+			      snd_usb_ctrl_intf(mixer->hostif) | ((pval & 0xff) << 8),
 			      value, 2);
 	if (err < 0)
 		return err;
@@ -1077,7 +1077,7 @@ static int snd_ftu_eff_switch_update(struct usb_mixer_elem_list *list)
 			      UAC_SET_CUR,
 			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
 			      pval & 0xff00,
-			      snd_usb_ctrl_intf(chip) | ((pval & 0xff) << 8),
+			      snd_usb_ctrl_intf(list->mixer->hostif) | ((pval & 0xff) << 8),
 			      value, 2);
 	snd_usb_unlock_shutdown(chip);
 	return err;
@@ -2115,24 +2115,25 @@ static int dell_dock_mixer_create(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
-static void dell_dock_init_vol(struct snd_usb_audio *chip, int ch, int id)
+static void dell_dock_init_vol(struct usb_mixer_interface *mixer, int ch, int id)
 {
+	struct snd_usb_audio *chip = mixer->chip;
 	u16 buf = 0;
 
 	snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0), UAC_SET_CUR,
 			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
 			(UAC_FU_VOLUME << 8) | ch,
-			snd_usb_ctrl_intf(chip) | (id << 8),
+			snd_usb_ctrl_intf(mixer->hostif) | (id << 8),
 			&buf, 2);
 }
 
 static int dell_dock_mixer_init(struct usb_mixer_interface *mixer)
 {
 	/* fix to 0dB playback volumes */
-	dell_dock_init_vol(mixer->chip, 1, 16);
-	dell_dock_init_vol(mixer->chip, 2, 16);
-	dell_dock_init_vol(mixer->chip, 1, 19);
-	dell_dock_init_vol(mixer->chip, 2, 19);
+	dell_dock_init_vol(mixer, 1, 16);
+	dell_dock_init_vol(mixer, 2, 16);
+	dell_dock_init_vol(mixer, 1, 19);
+	dell_dock_init_vol(mixer, 2, 19);
 	return 0;
 }
 
diff --git a/sound/usb/mixer_scarlett.c b/sound/usb/mixer_scarlett.c
index 0d6e4f15bf77c..ff548041679bb 100644
--- a/sound/usb/mixer_scarlett.c
+++ b/sound/usb/mixer_scarlett.c
@@ -460,7 +460,7 @@ static int scarlett_ctl_meter_get(struct snd_kcontrol *kctl,
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	unsigned char buf[2 * MAX_CHANNELS] = {0, };
 	int wValue = (elem->control << 8) | elem->idx_off;
-	int idx = snd_usb_ctrl_intf(chip) | (elem->head.id << 8);
+	int idx = snd_usb_ctrl_intf(elem->head.mixer->hostif) | (elem->head.id << 8);
 	int err;
 
 	err = snd_usb_ctl_msg(chip->dev,
@@ -1002,7 +1002,7 @@ int snd_scarlett_controls_create(struct usb_mixer_interface *mixer)
 	err = snd_usb_ctl_msg(mixer->chip->dev,
 		usb_sndctrlpipe(mixer->chip->dev, 0), UAC2_CS_CUR,
 		USB_RECIP_INTERFACE | USB_TYPE_CLASS |
-		USB_DIR_OUT, 0x0100, snd_usb_ctrl_intf(mixer->chip) |
+		USB_DIR_OUT, 0x0100, snd_usb_ctrl_intf(mixer->hostif) |
 		(0x29 << 8), sample_rate_buffer, 4);
 	if (err < 0)
 		return err;
diff --git a/sound/usb/power.c b/sound/usb/power.c
index 606a2cb23eab6..66bd4daa68fd5 100644
--- a/sound/usb/power.c
+++ b/sound/usb/power.c
@@ -40,6 +40,7 @@ snd_usb_find_power_domain(struct usb_host_interface *ctrl_iface,
 					le16_to_cpu(pd_desc->waRecoveryTime1);
 				pd->pd_d2d0_rec =
 					le16_to_cpu(pd_desc->waRecoveryTime2);
+				pd->ctrl_iface = ctrl_iface;
 				return pd;
 			}
 		}
@@ -57,7 +58,7 @@ int snd_usb_power_domain_set(struct snd_usb_audio *chip,
 	unsigned char current_state;
 	int err, idx;
 
-	idx = snd_usb_ctrl_intf(chip) | (pd->pd_id << 8);
+	idx = snd_usb_ctrl_intf(pd->ctrl_iface) | (pd->pd_id << 8);
 
 	err = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0),
 			      UAC2_CS_CUR,
diff --git a/sound/usb/power.h b/sound/usb/power.h
index 396e3e51440a7..1fa92ad0ca925 100644
--- a/sound/usb/power.h
+++ b/sound/usb/power.h
@@ -6,6 +6,7 @@ struct snd_usb_power_domain {
 	int pd_id;              /* UAC3 Power Domain ID */
 	int pd_d1d0_rec;        /* D1 to D0 recovery time */
 	int pd_d2d0_rec;        /* D2 to D0 recovery time */
+	struct usb_host_interface *ctrl_iface; /* Control interface */
 };
 
 enum {
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index e14c725acebf2..d70c140813d68 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -713,10 +713,13 @@ snd_usb_get_audioformat_uac12(struct snd_usb_audio *chip,
 	struct usb_device *dev = chip->dev;
 	struct uac_format_type_i_continuous_descriptor *fmt;
 	unsigned int num_channels = 0, chconfig = 0;
+	struct usb_host_interface *ctrl_intf;
 	struct audioformat *fp;
 	int clock = 0;
 	u64 format;
 
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, iface_no);
+
 	/* get audio formats */
 	if (protocol == UAC_VERSION_1) {
 		struct uac1_as_header_descriptor *as =
@@ -740,7 +743,7 @@ snd_usb_get_audioformat_uac12(struct snd_usb_audio *chip,
 
 		format = le16_to_cpu(as->wFormatTag); /* remember the format value */
 
-		iterm = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
+		iterm = snd_usb_find_input_terminal_descriptor(ctrl_intf,
 							       as->bTerminalLink,
 							       protocol);
 		if (iterm) {
@@ -776,7 +779,7 @@ snd_usb_get_audioformat_uac12(struct snd_usb_audio *chip,
 		 * lookup the terminal associated to this interface
 		 * to extract the clock
 		 */
-		input_term = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
+		input_term = snd_usb_find_input_terminal_descriptor(ctrl_intf,
 								    as->bTerminalLink,
 								    protocol);
 		if (input_term) {
@@ -786,7 +789,7 @@ snd_usb_get_audioformat_uac12(struct snd_usb_audio *chip,
 			goto found_clock;
 		}
 
-		output_term = snd_usb_find_output_terminal_descriptor(chip->ctrl_intf,
+		output_term = snd_usb_find_output_terminal_descriptor(ctrl_intf,
 								      as->bTerminalLink,
 								      protocol);
 		if (output_term) {
@@ -870,6 +873,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 	struct uac3_cluster_header_descriptor *cluster;
 	struct uac3_as_header_descriptor *as = NULL;
 	struct uac3_hc_descriptor_header hc_header;
+	struct usb_host_interface *ctrl_intf;
 	struct snd_pcm_chmap_elem *chmap;
 	struct snd_usb_power_domain *pd;
 	unsigned char badd_profile;
@@ -881,6 +885,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 	int err;
 
 	badd_profile = chip->badd_profile;
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, iface_no);
 
 	if (badd_profile >= UAC3_FUNCTION_SUBCLASS_GENERIC_IO) {
 		unsigned int maxpacksize =
@@ -966,7 +971,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 			UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
 			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			cluster_id,
-			snd_usb_ctrl_intf(chip),
+			snd_usb_ctrl_intf(ctrl_intf),
 			&hc_header, sizeof(hc_header));
 	if (err < 0)
 		return ERR_PTR(err);
@@ -990,7 +995,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 			UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
 			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			cluster_id,
-			snd_usb_ctrl_intf(chip),
+			snd_usb_ctrl_intf(ctrl_intf),
 			cluster, wLength);
 	if (err < 0) {
 		kfree(cluster);
@@ -1011,7 +1016,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 	 * lookup the terminal associated to this interface
 	 * to extract the clock
 	 */
-	input_term = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
+	input_term = snd_usb_find_input_terminal_descriptor(ctrl_intf,
 							    as->bTerminalLink,
 							    UAC_VERSION_3);
 	if (input_term) {
@@ -1019,7 +1024,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 		goto found_clock;
 	}
 
-	output_term = snd_usb_find_output_terminal_descriptor(chip->ctrl_intf,
+	output_term = snd_usb_find_output_terminal_descriptor(ctrl_intf,
 							      as->bTerminalLink,
 							      UAC_VERSION_3);
 	if (output_term) {
@@ -1068,7 +1073,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 							       UAC_VERSION_3,
 							       iface_no);
 
-		pd = snd_usb_find_power_domain(chip->ctrl_intf,
+		pd = snd_usb_find_power_domain(ctrl_intf,
 					       as->bTerminalLink);
 
 		/* ok, let's parse further... */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 43d4029edab46..b0f042c996087 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -21,6 +21,15 @@ struct media_intf_devnode;
 
 #define MAX_CARD_INTERFACES	16
 
+/*
+ * Structure holding assosiation between Audio Control Interface
+ * and given Streaming or Midi Interface.
+ */
+struct snd_intf_to_ctrl {
+	u8 interface;
+	struct usb_host_interface *ctrl_intf;
+};
+
 struct snd_usb_audio {
 	int index;
 	struct usb_device *dev;
@@ -63,6 +72,9 @@ struct snd_usb_audio {
 	struct usb_host_interface *ctrl_intf;	/* the audio control interface */
 	struct media_device *media_dev;
 	struct media_intf_devnode *ctl_intf_media_devnode;
+
+	unsigned int num_intf_to_ctrl;
+	struct snd_intf_to_ctrl intf_to_ctrl[MAX_CARD_INTERFACES];
 };
 
 #define USB_AUDIO_IFACE_UNUSED	((void *)-1L)
-- 
2.43.0




