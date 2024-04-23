Return-Path: <stable+bounces-41156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 917628AFB2C
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0301DB2C6D3
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060E4149E06;
	Tue, 23 Apr 2024 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hOOZsnQL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8336143C58;
	Tue, 23 Apr 2024 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908715; cv=none; b=gwsK/pWpEVoZ2zxS/agsIwf883NmEZbn/y8Xy+zl1og+QJKiEVUQJbOgetvGKNNckdTBdKpoRLl+rEw75pzEX/ZrbJpD2rZZZJxfsmtTlQzwtKZpQlxlNg7sOzSCF1ecdRGHkeNOWJZV7bDQkQRUXEzN3dNHvllntvXVpONJgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908715; c=relaxed/simple;
	bh=MDQU6U5ddPJE8YDMckvxrDl1zUM8O9LZbI6qz3ouumY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avhPAlEuBtgGAdErsG1gcLIICk3Pj/6e0Y52JfUeu3+e2cLw8SN5L/NKKWzOm26F4L38/temkRyn2q7iN9kIqg/NitU+lsBazPBd9cCpwcpuYHq8ttatIJX+LBxOlOlTFh52e7olnpCHw5+i1Suhm6fvWNS3HKic3lBylIQ71AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hOOZsnQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E7DC32781;
	Tue, 23 Apr 2024 21:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908715;
	bh=MDQU6U5ddPJE8YDMckvxrDl1zUM8O9LZbI6qz3ouumY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOOZsnQLYlVni9YcbUuj9cpJmVoDXxBHXHxUZE9Zy4Y+mgl5IAbngUGaCJZixiiae
	 hZl7rtLfjBJSGIgBXPRxqykoaMQsNO8Imilpi34Mhg5hjRkQVZ7mqfiJzd5+0iGrZT
	 wvybV/TBcSqOSieS2WtaWJQR6dOhpRLFiFYNyEvk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 074/141] ALSA: scarlett2: Add correct product series name to messages
Date: Tue, 23 Apr 2024 14:39:02 -0700
Message-ID: <20240423213855.608224687@linuxfoundation.org>
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

[ Upstream commit 6e743781d62e28f5fa095e5f31f878819622c143 ]

This driver was originally developed for the Focusrite Scarlett Gen 2
series, but now also supports the Scarlett Gen 3 series, the
Clarett 8Pre USB, and the Clarett+ 8Pre. The messages output by the
driver on initialisation and error include the identifying text
"Scarlett Gen 2/3", but this is no longer accurate, and writing
"Scarlett Gen 2/3/Clarett USB/Clarett+" would be unwieldy.

Add series_name field to the scarlett2_device_entry struct so that
concise and accurate messages can be output.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Link: https://lore.kernel.org/r/3774b9d35bf1fbdd6fdad9f3f4f97e9b82ac76bf.1694705811.git.g@b4.vu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: b61a3acada00 ("ALSA: scarlett2: Add Focusrite Clarett+ 2Pre and 4Pre support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett_gen2.c | 81 ++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 27 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 2bd46fe91394d..328a593aceaa9 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -391,6 +391,7 @@ struct scarlett2_data {
 	struct mutex data_mutex; /* lock access to this data */
 	struct delayed_work work;
 	const struct scarlett2_device_info *info;
+	const char *series_name;
 	__u8 bInterfaceNumber;
 	__u8 bEndpointAddress;
 	__u16 wMaxPacketSize;
@@ -887,25 +888,26 @@ static const struct scarlett2_device_info clarett_8pre_info = {
 struct scarlett2_device_entry {
 	const u32 usb_id; /* USB device identifier */
 	const struct scarlett2_device_info *info;
+	const char *series_name;
 };
 
 static const struct scarlett2_device_entry scarlett2_devices[] = {
 	/* Supported Gen 2 devices */
-	{ USB_ID(0x1235, 0x8203), &s6i6_gen2_info },
-	{ USB_ID(0x1235, 0x8204), &s18i8_gen2_info },
-	{ USB_ID(0x1235, 0x8201), &s18i20_gen2_info },
+	{ USB_ID(0x1235, 0x8203), &s6i6_gen2_info, "Scarlett Gen 2" },
+	{ USB_ID(0x1235, 0x8204), &s18i8_gen2_info, "Scarlett Gen 2" },
+	{ USB_ID(0x1235, 0x8201), &s18i20_gen2_info, "Scarlett Gen 2" },
 
 	/* Supported Gen 3 devices */
-	{ USB_ID(0x1235, 0x8211), &solo_gen3_info },
-	{ USB_ID(0x1235, 0x8210), &s2i2_gen3_info },
-	{ USB_ID(0x1235, 0x8212), &s4i4_gen3_info },
-	{ USB_ID(0x1235, 0x8213), &s8i6_gen3_info },
-	{ USB_ID(0x1235, 0x8214), &s18i8_gen3_info },
-	{ USB_ID(0x1235, 0x8215), &s18i20_gen3_info },
+	{ USB_ID(0x1235, 0x8211), &solo_gen3_info, "Scarlett Gen 3" },
+	{ USB_ID(0x1235, 0x8210), &s2i2_gen3_info, "Scarlett Gen 3" },
+	{ USB_ID(0x1235, 0x8212), &s4i4_gen3_info, "Scarlett Gen 3" },
+	{ USB_ID(0x1235, 0x8213), &s8i6_gen3_info, "Scarlett Gen 3" },
+	{ USB_ID(0x1235, 0x8214), &s18i8_gen3_info, "Scarlett Gen 3" },
+	{ USB_ID(0x1235, 0x8215), &s18i20_gen3_info, "Scarlett Gen 3" },
 
 	/* Supported Clarett USB/Clarett+ devices */
-	{ USB_ID(0x1235, 0x8208), &clarett_8pre_info },
-	{ USB_ID(0x1235, 0x820c), &clarett_8pre_info },
+	{ USB_ID(0x1235, 0x8208), &clarett_8pre_info, "Clarett USB" },
+	{ USB_ID(0x1235, 0x820c), &clarett_8pre_info, "Clarett+" },
 
 	/* End of list */
 	{ 0, NULL },
@@ -1205,8 +1207,8 @@ static int scarlett2_usb(
 	if (err != req_buf_size) {
 		usb_audio_err(
 			mixer->chip,
-			"Scarlett Gen 2/3 USB request result cmd %x was %d\n",
-			cmd, err);
+			"%s USB request result cmd %x was %d\n",
+			private->series_name, cmd, err);
 		err = -EINVAL;
 		goto unlock;
 	}
@@ -1222,9 +1224,8 @@ static int scarlett2_usb(
 	if (err != resp_buf_size) {
 		usb_audio_err(
 			mixer->chip,
-			"Scarlett Gen 2/3 USB response result cmd %x was %d "
-			"expected %zu\n",
-			cmd, err, resp_buf_size);
+			"%s USB response result cmd %x was %d expected %zu\n",
+			private->series_name, cmd, err, resp_buf_size);
 		err = -EINVAL;
 		goto unlock;
 	}
@@ -1240,9 +1241,10 @@ static int scarlett2_usb(
 	    resp->pad) {
 		usb_audio_err(
 			mixer->chip,
-			"Scarlett Gen 2/3 USB invalid response; "
+			"%s USB invalid response; "
 			   "cmd tx/rx %d/%d seq %d/%d size %d/%d "
 			   "error %d pad %d\n",
+			private->series_name,
 			le32_to_cpu(req->cmd), le32_to_cpu(resp->cmd),
 			le16_to_cpu(req->seq), le16_to_cpu(resp->seq),
 			resp_size, le16_to_cpu(resp->size),
@@ -3798,7 +3800,7 @@ static int scarlett2_find_fc_interface(struct usb_device *dev,
 
 /* Initialise private data */
 static int scarlett2_init_private(struct usb_mixer_interface *mixer,
-				  const struct scarlett2_device_info *info)
+				  const struct scarlett2_device_entry *entry)
 {
 	struct scarlett2_data *private =
 		kzalloc(sizeof(struct scarlett2_data), GFP_KERNEL);
@@ -3814,7 +3816,8 @@ static int scarlett2_init_private(struct usb_mixer_interface *mixer,
 	mixer->private_free = scarlett2_private_free;
 	mixer->private_suspend = scarlett2_private_suspend;
 
-	private->info = info;
+	private->info = entry->info;
+	private->series_name = entry->series_name;
 	scarlett2_count_mux_io(private);
 	private->scarlett2_seq = 0;
 	private->mixer = mixer;
@@ -4135,19 +4138,28 @@ static int scarlett2_init_notify(struct usb_mixer_interface *mixer)
 	return usb_submit_urb(mixer->urb, GFP_KERNEL);
 }
 
-static int snd_scarlett_gen2_controls_create(struct usb_mixer_interface *mixer)
+static const struct scarlett2_device_entry *get_scarlett2_device_entry(
+	struct usb_mixer_interface *mixer)
 {
 	const struct scarlett2_device_entry *entry = scarlett2_devices;
-	int err;
 
 	/* Find entry in scarlett2_devices */
 	while (entry->usb_id && entry->usb_id != mixer->chip->usb_id)
 		entry++;
 	if (!entry->usb_id)
-		return -EINVAL;
+		return NULL;
+
+	return entry;
+}
+
+static int snd_scarlett_gen2_controls_create(
+	struct usb_mixer_interface *mixer,
+	const struct scarlett2_device_entry *entry)
+{
+	int err;
 
 	/* Initialise private data */
-	err = scarlett2_init_private(mixer, entry->info);
+	err = scarlett2_init_private(mixer, entry);
 	if (err < 0)
 		return err;
 
@@ -4231,17 +4243,30 @@ static int snd_scarlett_gen2_controls_create(struct usb_mixer_interface *mixer)
 int snd_scarlett_gen2_init(struct usb_mixer_interface *mixer)
 {
 	struct snd_usb_audio *chip = mixer->chip;
+	const struct scarlett2_device_entry *entry;
 	int err;
 
 	/* only use UAC_VERSION_2 */
 	if (!mixer->protocol)
 		return 0;
 
+	/* find entry in scarlett2_devices */
+	entry = get_scarlett2_device_entry(mixer);
+	if (!entry) {
+		usb_audio_err(mixer->chip,
+			      "%s: missing device entry for %04x:%04x\n",
+			      __func__,
+			      USB_ID_VENDOR(chip->usb_id),
+			      USB_ID_PRODUCT(chip->usb_id));
+		return 0;
+	}
+
 	if (chip->setup & SCARLETT2_DISABLE) {
 		usb_audio_info(chip,
-			"Focusrite Scarlett Gen 2/3 Mixer Driver disabled "
+			"Focusrite %s Mixer Driver disabled "
 			"by modprobe options (snd_usb_audio "
 			"vid=0x%04x pid=0x%04x device_setup=%d)\n",
+			entry->series_name,
 			USB_ID_VENDOR(chip->usb_id),
 			USB_ID_PRODUCT(chip->usb_id),
 			SCARLETT2_DISABLE);
@@ -4249,14 +4274,16 @@ int snd_scarlett_gen2_init(struct usb_mixer_interface *mixer)
 	}
 
 	usb_audio_info(chip,
-		"Focusrite Scarlett Gen 2/3 Mixer Driver enabled (pid=0x%04x); "
+		"Focusrite %s Mixer Driver enabled (pid=0x%04x); "
 		"report any issues to g@b4.vu",
+		entry->series_name,
 		USB_ID_PRODUCT(chip->usb_id));
 
-	err = snd_scarlett_gen2_controls_create(mixer);
+	err = snd_scarlett_gen2_controls_create(mixer, entry);
 	if (err < 0)
 		usb_audio_err(mixer->chip,
-			      "Error initialising Scarlett Mixer Driver: %d",
+			      "Error initialising %s Mixer Driver: %d",
+			      entry->series_name,
 			      err);
 
 	return err;
-- 
2.43.0




