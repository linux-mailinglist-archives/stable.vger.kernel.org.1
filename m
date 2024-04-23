Return-Path: <stable+bounces-41151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A78AFA81
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DD11F294D0
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8061474CD;
	Tue, 23 Apr 2024 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mGhpjUEN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0229143C5A;
	Tue, 23 Apr 2024 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908712; cv=none; b=ognYoExTFjdBKJ7vuWDI056EGWqUuKY3COjiSj7xLd+a0dC+gD1OhA6Q3LB64S4kLm9/5czWEFqmFnLnJsfmILg3PR8xhe/oGhF7i+4AIjijAgFceJ6LzO0L6hoClYaIL6E9CEtJj4mm7nsk6B38YgyB56k6VbUi4aZeUJPSGrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908712; c=relaxed/simple;
	bh=4+CI1jmc4Jrn4HgnR3HBOMOXIfn8bpTcX2KBpG5Wk40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGQYGzITAjYpBcs32LSSLD+wWTmWEtFNX57IlWny/2x2BbDj3WECc9jMyEUpTZvqI6N6cpTHnhETGo5ruqc5dzsUPD1CHRBO9UnBSFJE8l6PcjXyuDd1HekVs5YvWS9J2Nx0zM8+z2ea40lnVK4OLGT4pYH7486MQVziAVUWmdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mGhpjUEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DCDC3277B;
	Tue, 23 Apr 2024 21:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908712;
	bh=4+CI1jmc4Jrn4HgnR3HBOMOXIfn8bpTcX2KBpG5Wk40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mGhpjUENYWVjdO8obaVw4OCdYB4FhfSIbUqAHJ4cOXtQqxzic0umYpzJ/YNH19tYD
	 mF6QUlX8jth8+DQKUfpGs2++stEKVTsxhnh7CULkErFdLNkRL0qgmMRRTPyLpNMhob
	 BmMia6+j0i7F3UAOCy70zMLzNjptoISKCKp3Jpmk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philippe Perrot <philippe@perrot-net.fr>,
	"Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 069/141] ALSA: scarlett2: Move USB IDs out from device_info struct
Date: Tue, 23 Apr 2024 14:38:57 -0700
Message-ID: <20240423213855.465830028@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
References: <20240423213853.356988651@linuxfoundation.org>
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

From: Geoffrey D. Bennett <g@b4.vu>

[ Upstream commit d98cc489029dba4d99714c2e8ec4f5ba249f6851 ]

By moving the USB IDs from the device_info struct into
scarlett2_devices[], that will allow for devices with different
USB IDs to share the same device_info.

Tested-by: Philippe Perrot <philippe@perrot-net.fr>
Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Link: https://lore.kernel.org/r/8263368e8d49e6fcebc709817bd82ab79b404468.1694705811.git.g@b4.vu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: b9a98cdd3ac7 ("ALSA: scarlett2: Add support for Clarett 8Pre USB")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett_gen2.c | 63 ++++++++++++---------------------
 1 file changed, 23 insertions(+), 40 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 1bcb05c73e0ad..2668bc1b918ba 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -317,8 +317,6 @@ struct scarlett2_mux_entry {
 };
 
 struct scarlett2_device_info {
-	u32 usb_id; /* USB device identifier */
-
 	/* Gen 3 devices have an internal MSD mode switch that needs
 	 * to be disabled in order to access the full functionality of
 	 * the device.
@@ -440,8 +438,6 @@ struct scarlett2_data {
 /*** Model-specific data ***/
 
 static const struct scarlett2_device_info s6i6_gen2_info = {
-	.usb_id = USB_ID(0x1235, 0x8203),
-
 	.config_set = SCARLETT2_CONFIG_SET_GEN_2,
 	.level_input_count = 2,
 	.pad_input_count = 2,
@@ -486,8 +482,6 @@ static const struct scarlett2_device_info s6i6_gen2_info = {
 };
 
 static const struct scarlett2_device_info s18i8_gen2_info = {
-	.usb_id = USB_ID(0x1235, 0x8204),
-
 	.config_set = SCARLETT2_CONFIG_SET_GEN_2,
 	.level_input_count = 2,
 	.pad_input_count = 4,
@@ -535,8 +529,6 @@ static const struct scarlett2_device_info s18i8_gen2_info = {
 };
 
 static const struct scarlett2_device_info s18i20_gen2_info = {
-	.usb_id = USB_ID(0x1235, 0x8201),
-
 	.config_set = SCARLETT2_CONFIG_SET_GEN_2,
 	.line_out_hw_vol = 1,
 
@@ -589,8 +581,6 @@ static const struct scarlett2_device_info s18i20_gen2_info = {
 };
 
 static const struct scarlett2_device_info solo_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8211),
-
 	.has_msd_mode = 1,
 	.config_set = SCARLETT2_CONFIG_SET_NO_MIXER,
 	.level_input_count = 1,
@@ -602,8 +592,6 @@ static const struct scarlett2_device_info solo_gen3_info = {
 };
 
 static const struct scarlett2_device_info s2i2_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8210),
-
 	.has_msd_mode = 1,
 	.config_set = SCARLETT2_CONFIG_SET_NO_MIXER,
 	.level_input_count = 2,
@@ -614,8 +602,6 @@ static const struct scarlett2_device_info s2i2_gen3_info = {
 };
 
 static const struct scarlett2_device_info s4i4_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8212),
-
 	.has_msd_mode = 1,
 	.config_set = SCARLETT2_CONFIG_SET_GEN_3,
 	.level_input_count = 2,
@@ -660,8 +646,6 @@ static const struct scarlett2_device_info s4i4_gen3_info = {
 };
 
 static const struct scarlett2_device_info s8i6_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8213),
-
 	.has_msd_mode = 1,
 	.config_set = SCARLETT2_CONFIG_SET_GEN_3,
 	.level_input_count = 2,
@@ -713,8 +697,6 @@ static const struct scarlett2_device_info s8i6_gen3_info = {
 };
 
 static const struct scarlett2_device_info s18i8_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8214),
-
 	.has_msd_mode = 1,
 	.config_set = SCARLETT2_CONFIG_SET_GEN_3,
 	.line_out_hw_vol = 1,
@@ -783,8 +765,6 @@ static const struct scarlett2_device_info s18i8_gen3_info = {
 };
 
 static const struct scarlett2_device_info s18i20_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8215),
-
 	.has_msd_mode = 1,
 	.config_set = SCARLETT2_CONFIG_SET_GEN_3,
 	.line_out_hw_vol = 1,
@@ -848,8 +828,6 @@ static const struct scarlett2_device_info s18i20_gen3_info = {
 };
 
 static const struct scarlett2_device_info clarett_8pre_info = {
-	.usb_id = USB_ID(0x1235, 0x820c),
-
 	.config_set = SCARLETT2_CONFIG_SET_CLARETT,
 	.line_out_hw_vol = 1,
 	.level_input_count = 2,
@@ -902,25 +880,30 @@ static const struct scarlett2_device_info clarett_8pre_info = {
 	} },
 };
 
-static const struct scarlett2_device_info *scarlett2_devices[] = {
+struct scarlett2_device_entry {
+	const u32 usb_id; /* USB device identifier */
+	const struct scarlett2_device_info *info;
+};
+
+static const struct scarlett2_device_entry scarlett2_devices[] = {
 	/* Supported Gen 2 devices */
-	&s6i6_gen2_info,
-	&s18i8_gen2_info,
-	&s18i20_gen2_info,
+	{ USB_ID(0x1235, 0x8203), &s6i6_gen2_info },
+	{ USB_ID(0x1235, 0x8204), &s18i8_gen2_info },
+	{ USB_ID(0x1235, 0x8201), &s18i20_gen2_info },
 
 	/* Supported Gen 3 devices */
-	&solo_gen3_info,
-	&s2i2_gen3_info,
-	&s4i4_gen3_info,
-	&s8i6_gen3_info,
-	&s18i8_gen3_info,
-	&s18i20_gen3_info,
+	{ USB_ID(0x1235, 0x8211), &solo_gen3_info },
+	{ USB_ID(0x1235, 0x8210), &s2i2_gen3_info },
+	{ USB_ID(0x1235, 0x8212), &s4i4_gen3_info },
+	{ USB_ID(0x1235, 0x8213), &s8i6_gen3_info },
+	{ USB_ID(0x1235, 0x8214), &s18i8_gen3_info },
+	{ USB_ID(0x1235, 0x8215), &s18i20_gen3_info },
 
 	/* Supported Clarett+ devices */
-	&clarett_8pre_info,
+	{ USB_ID(0x1235, 0x820c), &clarett_8pre_info },
 
 	/* End of list */
-	NULL
+	{ 0, NULL },
 };
 
 /* get the starting port index number for a given port type/direction */
@@ -4149,17 +4132,17 @@ static int scarlett2_init_notify(struct usb_mixer_interface *mixer)
 
 static int snd_scarlett_gen2_controls_create(struct usb_mixer_interface *mixer)
 {
-	const struct scarlett2_device_info **info = scarlett2_devices;
+	const struct scarlett2_device_entry *entry = scarlett2_devices;
 	int err;
 
-	/* Find device in scarlett2_devices */
-	while (*info && (*info)->usb_id != mixer->chip->usb_id)
-		info++;
-	if (!*info)
+	/* Find entry in scarlett2_devices */
+	while (entry->usb_id && entry->usb_id != mixer->chip->usb_id)
+		entry++;
+	if (!entry->usb_id)
 		return -EINVAL;
 
 	/* Initialise private data */
-	err = scarlett2_init_private(mixer, *info);
+	err = scarlett2_init_private(mixer, entry->info);
 	if (err < 0)
 		return err;
 
-- 
2.43.0




