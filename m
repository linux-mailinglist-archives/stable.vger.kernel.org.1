Return-Path: <stable+bounces-44-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C457F5E77
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 12:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D77F281C9C
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 11:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B191241E1;
	Thu, 23 Nov 2023 11:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y2XiH74a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0E723767
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 11:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD552C433C9;
	Thu, 23 Nov 2023 11:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700740654;
	bh=YLg4+lxiPlSGHp5MzCH+b/8f3IHfY/LrkZPiWSKoIT0=;
	h=Subject:To:Cc:From:Date:From;
	b=y2XiH74a2LhG8msVYEJo9/aOdNpawsO0OY8tfjUADt7/80qUozsYzT4DEJl9HMlRH
	 V20qzApBi0LWE7X9YWcAjFwF+3w7TSAiidHX7zkfWSahxChXvotRCmggFHhOeu1WrK
	 JTH4gBj9fmwKkx0xfWAhkhETvwyqhjbmC4MRJzT0=
Subject: FAILED: patch "[PATCH] hid: lenovo: Resend all settings on reset_resume for compact" failed to apply to 5.10-stable tree
To: jm@lentin.co.uk,bentiss@kernel.org,martink@posteo.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Nov 2023 11:57:25 +0000
Message-ID: <2023112325-paycheck-recovery-4d99@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2f2bd7cbd1d1548137b351040dc4e037d18cdfdc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112325-paycheck-recovery-4d99@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

2f2bd7cbd1d1 ("hid: lenovo: Resend all settings on reset_resume for compact keyboards")
24401f291dcc ("HID: lenovo: Add support for ThinkPad TrackPoint Keyboard II")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2f2bd7cbd1d1548137b351040dc4e037d18cdfdc Mon Sep 17 00:00:00 2001
From: Jamie Lentin <jm@lentin.co.uk>
Date: Mon, 2 Oct 2023 15:09:14 +0000
Subject: [PATCH] hid: lenovo: Resend all settings on reset_resume for compact
 keyboards

The USB Compact Keyboard variant requires a reset_resume function to
restore keyboard configuration after a suspend in some situations. Move
configuration normally done on probe to lenovo_features_set_cptkbd(), then
recycle this for use on reset_resume.

Without, the keyboard and driver would end up in an inconsistent state,
breaking middle-button scrolling amongst other problems, and twiddling
sysfs values wouldn't help as the middle-button mode won't be set until
the driver is reloaded.

Tested on a USB and Bluetooth Thinkpad Compact Keyboard.

CC: stable@vger.kernel.org
Fixes: 94eefa271323 ("HID: lenovo: Use native middle-button mode for compact keyboards")
Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
Signed-off-by: Martin Kepplinger <martink@posteo.de>
Link: https://lore.kernel.org/r/20231002150914.22101-1-martink@posteo.de
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 9c1181313e44..7c1b33be9d13 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -526,6 +526,19 @@ static void lenovo_features_set_cptkbd(struct hid_device *hdev)
 	int ret;
 	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
 
+	/*
+	 * Tell the keyboard a driver understands it, and turn F7, F9, F11 into
+	 * regular keys
+	 */
+	ret = lenovo_send_cmd_cptkbd(hdev, 0x01, 0x03);
+	if (ret)
+		hid_warn(hdev, "Failed to switch F7/9/11 mode: %d\n", ret);
+
+	/* Switch middle button to native mode */
+	ret = lenovo_send_cmd_cptkbd(hdev, 0x09, 0x01);
+	if (ret)
+		hid_warn(hdev, "Failed to switch middle button: %d\n", ret);
+
 	ret = lenovo_send_cmd_cptkbd(hdev, 0x05, cptkbd_data->fn_lock);
 	if (ret)
 		hid_err(hdev, "Fn-lock setting failed: %d\n", ret);
@@ -1148,22 +1161,6 @@ static int lenovo_probe_cptkbd(struct hid_device *hdev)
 	}
 	hid_set_drvdata(hdev, cptkbd_data);
 
-	/*
-	 * Tell the keyboard a driver understands it, and turn F7, F9, F11 into
-	 * regular keys (Compact only)
-	 */
-	if (hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD ||
-	    hdev->product == USB_DEVICE_ID_LENOVO_CBTKBD) {
-		ret = lenovo_send_cmd_cptkbd(hdev, 0x01, 0x03);
-		if (ret)
-			hid_warn(hdev, "Failed to switch F7/9/11 mode: %d\n", ret);
-	}
-
-	/* Switch middle button to native mode */
-	ret = lenovo_send_cmd_cptkbd(hdev, 0x09, 0x01);
-	if (ret)
-		hid_warn(hdev, "Failed to switch middle button: %d\n", ret);
-
 	/* Set keyboard settings to known state */
 	cptkbd_data->middlebutton_state = 0;
 	cptkbd_data->fn_lock = true;
@@ -1286,6 +1283,24 @@ static int lenovo_probe(struct hid_device *hdev,
 	return ret;
 }
 
+#ifdef CONFIG_PM
+static int lenovo_reset_resume(struct hid_device *hdev)
+{
+	switch (hdev->product) {
+	case USB_DEVICE_ID_LENOVO_CUSBKBD:
+	case USB_DEVICE_ID_LENOVO_TPIIUSBKBD:
+		if (hdev->type == HID_TYPE_USBMOUSE)
+			lenovo_features_set_cptkbd(hdev);
+
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+#endif
+
 static void lenovo_remove_tpkbd(struct hid_device *hdev)
 {
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
@@ -1402,6 +1417,9 @@ static struct hid_driver lenovo_driver = {
 	.raw_event = lenovo_raw_event,
 	.event = lenovo_event,
 	.report_fixup = lenovo_report_fixup,
+#ifdef CONFIG_PM
+	.reset_resume = lenovo_reset_resume,
+#endif
 };
 module_hid_driver(lenovo_driver);
 


