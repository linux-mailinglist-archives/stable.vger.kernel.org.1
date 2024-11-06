Return-Path: <stable+bounces-91453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EE79BEE0A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D7E1F24E4B
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566CF1EC01A;
	Wed,  6 Nov 2024 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nyQS9uwp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1407C1E0DC4;
	Wed,  6 Nov 2024 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898775; cv=none; b=CN+tcCEDvX+Xsl6p7YsPbJ7q4Z/den7vrDndexTJx7k6yzm3h1ebllPvXzdmyvFLuoMXhjm/+QMSQMaBRC4sC4fgj5LP7pZo7X99ehiLcUCunWEqgdBqTryAsLf4Fo33dxKd71DcnPtOccyEC353J8SF7tLf/5T8MZC5DQctx84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898775; c=relaxed/simple;
	bh=CgLwHjSnHPIVAxLcUHNy+1vIUfiDtL9rQ5VMcO18eCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fx1iN4pQM6q2Zbkq2HoBHY2ZGdqmwK0H8TOwc2tpDVb0W3ImhgiOVS6RjnlyEZ6NGaB6fGYYvnf9rs7nox9bIf6/R7OxzrW4y089RPvsxHmCvJMwnF9CyVeJ8jWy6DD9liOIRXv50AOr3EKFKAYp26J5N2miiMDVegVgy4MWgzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nyQS9uwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF4BC4CECD;
	Wed,  6 Nov 2024 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898774;
	bh=CgLwHjSnHPIVAxLcUHNy+1vIUfiDtL9rQ5VMcO18eCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nyQS9uwpbUhwPWsIwrRJnWo7tc6hA6A7T/EpOVbE35Dy4m1BXH0+yvxm/201bq725
	 uaI7vN7OSrCQ6Ann2brPduOCUMbYRNBXDCokJSsHRN+Jqa54U42VrViuWgiBEDzktW
	 fpJqndM5/4Ewu6KALVC8f8N/PpLPKnbxgoaj7wlU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wade Wang <wade.wang@hp.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 5.4 344/462] HID: plantronics: Workaround for an unexcepted opposite volume key
Date: Wed,  6 Nov 2024 13:03:57 +0100
Message-ID: <20241106120340.021545526@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wade Wang <wade.wang@hp.com>

commit 87b696209007b7c4ef7bdfe39ea0253404a43770 upstream.

Some Plantronics headset as the below send an unexcept opposite
volume key's HID report for each volume key press after 200ms, like
unecepted Volume Up Key following Volume Down key pressed by user.
This patch adds a quirk to hid-plantronics for these devices, which
will ignore the second unexcepted opposite volume key if it happens
within 220ms from the last one that was handled.
    Plantronics EncorePro 500 Series  (047f:431e)
    Plantronics Blackwire_3325 Series (047f:430c)

The patch was tested on the mentioned model, it shouldn't affect
other models, however, this quirk might be needed for them too.
Auto-repeat (when a key is held pressed) is not affected per test
result.

Cc: stable@vger.kernel.org
Signed-off-by: Wade Wang <wade.wang@hp.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-ids.h         |    2 ++
 drivers/hid/hid-plantronics.c |   23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -954,6 +954,8 @@
 #define USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3220_SERIES	0xc056
 #define USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3215_SERIES	0xc057
 #define USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3225_SERIES	0xc058
+#define USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3325_SERIES	0x430c
+#define USB_DEVICE_ID_PLANTRONICS_ENCOREPRO_500_SERIES		0x431e
 
 #define USB_VENDOR_ID_PANASONIC		0x04da
 #define USB_DEVICE_ID_PANABOARD_UBT780	0x1044
--- a/drivers/hid/hid-plantronics.c
+++ b/drivers/hid/hid-plantronics.c
@@ -38,8 +38,10 @@
 			    (usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER)
 
 #define PLT_QUIRK_DOUBLE_VOLUME_KEYS BIT(0)
+#define PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS BIT(1)
 
 #define PLT_DOUBLE_KEY_TIMEOUT 5 /* ms */
+#define PLT_FOLLOWED_OPPOSITE_KEY_TIMEOUT 220 /* ms */
 
 struct plt_drv_data {
 	unsigned long device_type;
@@ -137,6 +139,21 @@ static int plantronics_event(struct hid_
 
 		drv_data->last_volume_key_ts = cur_ts;
 	}
+	if (drv_data->quirks & PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS) {
+		unsigned long prev_ts, cur_ts;
+
+		/* Usages are filtered in plantronics_usages. */
+
+		if (!value) /* Handle key presses only. */
+			return 0;
+
+		prev_ts = drv_data->last_volume_key_ts;
+		cur_ts = jiffies;
+		if (jiffies_to_msecs(cur_ts - prev_ts) <= PLT_FOLLOWED_OPPOSITE_KEY_TIMEOUT)
+			return 1; /* Ignore the followed opposite volume key. */
+
+		drv_data->last_volume_key_ts = cur_ts;
+	}
 
 	return 0;
 }
@@ -210,6 +227,12 @@ static const struct hid_device_id plantr
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
 					 USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3225_SERIES),
 		.driver_data = PLT_QUIRK_DOUBLE_VOLUME_KEYS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
+					 USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3325_SERIES),
+		.driver_data = PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
+					 USB_DEVICE_ID_PLANTRONICS_ENCOREPRO_500_SERIES),
+		.driver_data = PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS, HID_ANY_ID) },
 	{ }
 };



