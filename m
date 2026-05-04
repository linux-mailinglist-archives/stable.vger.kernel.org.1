Return-Path: <stable+bounces-242922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FbrMnBd+GnatQIAu9opvQ
	(envelope-from <stable+bounces-242922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:48:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9B54BA80A
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F0C83016245
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FB634BA28;
	Mon,  4 May 2026 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaKa/PGR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146D34AAF7;
	Mon,  4 May 2026 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884471; cv=none; b=X6NaADTvozM/cX5bZ6Hg94CETTcf/h3Ovm4KhUCHdWNST6B/TMZ5ZXLkB6Hv5aBNjLLVb1VK8ojkR6Nf/oSSa98ysf4dE+9ViZytCwQFzCCzfO6y+OLNRfBlkcv/aWIcaWUu5DABfEA0ccWS1rg7TmNmw8bZ9Gpv/4cVWX/kDJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884471; c=relaxed/simple;
	bh=+JYc9gtAs3/A+XLQSsrhmAQALfOGYbOvejMYH4rLPkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p5ZMWbY5VY56XDhXAQNmDlSz1E1rYv838rBjXM5h+NlhqyPS3u9M5ppW2perwzc3ntWvYVWctPl8VKQmn5/8f+J8RwO8N1cwMN8zR/TSLGzmhsxkdfS46O7fY4DL9tyt4Tjza9Oh5KsyqresthEK8RbnKmlqYeujkqn4mY6WpNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaKa/PGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF56C2BCB9;
	Mon,  4 May 2026 08:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777884470;
	bh=+JYc9gtAs3/A+XLQSsrhmAQALfOGYbOvejMYH4rLPkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eaKa/PGR2ST0V9W04mZAyPPx4gM0d91LQZrqTTD7wNgRtXxwUgCxRKGQlvI5GgUAk
	 gOocPiMAZWhOfff/Etdh4RG+MG7zi2XyOQbKxMUiLDRPI5bv81/AjaWhfaFG7mAetu
	 lvV6lcsg9GY1etmIv9LmjZalmzOj79J5ta+awToZaBV1zLw8WuDaetpG34VnWnHFKT
	 OU7NZWyHvvN7mjbbCbFWeCi90yCT9oxhTUEPikXGlSp8YHkeIG0HG6UeDK6J+9u1dR
	 e3+v4E3cwV8j4RG1IId2RPwSD7V1abkMHJkDIltdg09CpluiV/lOrHkptRWbdr/b7s
	 Oy+CoYGjnkFFw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 04 May 2026 10:47:23 +0200
Subject: [PATCH v3 2/4] HID: core: introduce hid_safe_input_report()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-wip-fix-core-v3-2-ce1f11f4968f@kernel.org>
References: <20260504-wip-fix-core-v3-0-ce1f11f4968f@kernel.org>
In-Reply-To: <20260504-wip-fix-core-v3-0-ce1f11f4968f@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Ping Cheng <ping.cheng@wacom.com>, 
 Jason Gerecke <jason.gerecke@wacom.com>, Viresh Kumar <vireshk@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>
Cc: Icenowy Zheng <uwu@icenowy.me>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org, 
 linux-staging@lists.linux.dev, linux-usb@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777884459; l=5200;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=+JYc9gtAs3/A+XLQSsrhmAQALfOGYbOvejMYH4rLPkg=;
 b=LqXDLiYmsBrKX0Nt0Tc5aXHsFnZmC4CXJdjvunlrKg2EumO3TqFc+pcN4XgTKY448rJkuFhrR
 L/HtUZwnSQwClNpbllsVjExZ9A3B4OV6LIOBSXuJkh/sXaRbMTeYHRo
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Rspamd-Queue-Id: 5B9B54BA80A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242922-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bentiss@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

hid_input_report() is used in too many places to have a commit that
doesn't cross subsystem borders. Instead of changing the API, introduce
a new one when things matters in the transport layers:
- usbhid
- i2chid

This effectively revert to the old behavior for those two transport
layers.

Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-core.c             | 25 +++++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-core.c |  7 ++++---
 drivers/hid/usbhid/hid-core.c      | 11 ++++++-----
 include/linux/hid.h                |  2 ++
 4 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a806820df7e5..b3596851c719 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2181,6 +2181,7 @@ static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
  * @interrupt: distinguish between interrupt and control transfers
  *
  * This is data entry for lower layers.
+ * Legacy, please use hid_safe_input_report() instead.
  */
 int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data, u32 size,
 		     int interrupt)
@@ -2191,6 +2192,30 @@ int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data
 }
 EXPORT_SYMBOL_GPL(hid_input_report);
 
+/**
+ * hid_safe_input_report - report data from lower layer (usb, bt...)
+ *
+ * @hid: hid device
+ * @type: HID report type (HID_*_REPORT)
+ * @data: report contents
+ * @bufsize: allocated size of the data buffer
+ * @size: useful size of data parameter
+ * @interrupt: distinguish between interrupt and control transfers
+ *
+ * This is data entry for lower layers.
+ * Please use this function instead of the non safe version because we provide
+ * here the size of the buffer, allowing hid-core to make smarter decisions
+ * regarding the incoming buffer.
+ */
+int hid_safe_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data,
+			  size_t bufsize, u32 size, int interrupt)
+{
+	return __hid_input_report(hid, type, data, bufsize, size, interrupt, 0,
+				  false, /* from_bpf */
+				  false /* lock_already_taken */);
+}
+EXPORT_SYMBOL_GPL(hid_safe_input_report);
+
 bool hid_match_one_id(const struct hid_device *hdev,
 		      const struct hid_device_id *id)
 {
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 5a183af3d5c6..e0a302544cef 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -574,9 +574,10 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 		if (ihid->hid->group != HID_GROUP_RMI)
 			pm_wakeup_event(&ihid->client->dev, 0);
 
-		hid_input_report(ihid->hid, HID_INPUT_REPORT,
-				ihid->inbuf + sizeof(__le16),
-				ret_size - sizeof(__le16), 1);
+		hid_safe_input_report(ihid->hid, HID_INPUT_REPORT,
+				      ihid->inbuf + sizeof(__le16),
+				      ihid->bufsize - sizeof(__le16),
+				      ret_size - sizeof(__le16), 1);
 	}
 
 	return;
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index fbbfc0f60829..5af93b9b1fb5 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -283,9 +283,9 @@ static void hid_irq_in(struct urb *urb)
 			break;
 		usbhid_mark_busy(usbhid);
 		if (!test_bit(HID_RESUME_RUNNING, &usbhid->iofl)) {
-			hid_input_report(urb->context, HID_INPUT_REPORT,
-					 urb->transfer_buffer,
-					 urb->actual_length, 1);
+			hid_safe_input_report(urb->context, HID_INPUT_REPORT,
+					      urb->transfer_buffer, urb->transfer_buffer_length,
+					      urb->actual_length, 1);
 			/*
 			 * autosuspend refused while keys are pressed
 			 * because most keyboards don't wake up when
@@ -482,9 +482,10 @@ static void hid_ctrl(struct urb *urb)
 	switch (status) {
 	case 0:			/* success */
 		if (usbhid->ctrl[usbhid->ctrltail].dir == USB_DIR_IN)
-			hid_input_report(urb->context,
+			hid_safe_input_report(urb->context,
 				usbhid->ctrl[usbhid->ctrltail].report->type,
-				urb->transfer_buffer, urb->actual_length, 0);
+				urb->transfer_buffer, urb->transfer_buffer_length,
+				urb->actual_length, 0);
 		break;
 	case -ESHUTDOWN:	/* unplug */
 		unplug = 1;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index ac432a2ef415..bfb9859f391e 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1030,6 +1030,8 @@ struct hid_field *hid_find_field(struct hid_device *hdev, unsigned int report_ty
 int hid_set_field(struct hid_field *, unsigned, __s32);
 int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data, u32 size,
 		     int interrupt);
+int hid_safe_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data,
+			  size_t bufsize, u32 size, int interrupt);
 struct hid_field *hidinput_get_led_field(struct hid_device *hid);
 unsigned int hidinput_count_leds(struct hid_device *hid);
 __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code);

-- 
2.54.0


