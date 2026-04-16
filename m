Return-Path: <stable+bounces-238324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJdGES/44GnZnwAAu9opvQ
	(envelope-from <stable+bounces-238324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:54:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E21D440FE47
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F2543138C37
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 14:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B1F3E122C;
	Thu, 16 Apr 2026 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpaal9Sx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08AC3BAD89;
	Thu, 16 Apr 2026 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350920; cv=none; b=bgtRhLsRk38E0F427X4t4AN+nA4x7I/YM0qGKZ6fp709XV/3Vqi3KWut6kXjcw5dZWCGQECEXsD6BM7GrhrVhBP92glR242hHxCm/l+hxjRI1tEz6QBcNpA5zEDNTkMbAATT8wwEkD3kEMq9rcVv9nuBXg+JtmK0wXluplbKTCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350920; c=relaxed/simple;
	bh=Kc4r47z9n+zjmMEPqGyk0o/W3mTuClIW5kSwTG9i0F8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iprc59bIWk7Xmd6vDY9dFOiS/f3hiSgcwtIMrUstJxii6nD+RtrS2NdTdKYjGvTX3r6u++YY/UG7fEoEtfM+8sylY2+EsDC/1+tnlKSFPy7mgN93Pj4jTmv+EDO7OY54lxGMbv106n83JcBebs58bNWTK1i25VMbE67VG76jKn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpaal9Sx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77968C2BCB7;
	Thu, 16 Apr 2026 14:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776350920;
	bh=Kc4r47z9n+zjmMEPqGyk0o/W3mTuClIW5kSwTG9i0F8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fpaal9SxJ5Gjr3OQEvRPmzjkdqKSbq5pvk6RFnmMm8TRIHbFDjvXmZENSMj7gc4P3
	 2I+JNzlzV/RH1XW/8kclsMp5/x9wfHuMImleDRIont9ojtrYePEOjFYIBUPQl9IyXj
	 N3jZLN2g6iTGSuTFsa9xcxF1L7jW3rEiDIRQ4CrbDfUf8gu3PiX3UtO7ZU8rjw2kfR
	 x0L6HeYfIEl4VsbwmGwVaPIMYRfxKSYEWwZi9k6/Gin+sIuM8iz/KO1CWzhcPwGhd+
	 9HFCh8l8X87+eya/77IXj88okdbvF+6yANpsebzRFt5c/MdBVbH0mspgnnRqkpX/91
	 sVgEGVhvIMQSg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 16 Apr 2026 16:48:28 +0200
Subject: [PATCH v2 2/4] HID: core: introduce hid_safe_input_report()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-wip-fix-core-v2-2-be92570e5627@kernel.org>
References: <20260416-wip-fix-core-v2-0-be92570e5627@kernel.org>
In-Reply-To: <20260416-wip-fix-core-v2-0-be92570e5627@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Ping Cheng <ping.cheng@wacom.com>, 
 Jason Gerecke <jason.gerecke@wacom.com>, Viresh Kumar <vireshk@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, 
 linux-usb@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776350910; l=5200;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Kc4r47z9n+zjmMEPqGyk0o/W3mTuClIW5kSwTG9i0F8=;
 b=tPUUdwOHgdZiKmaZgpbRJ6kPu0gA2WFQyQ5Uph9qVp1t/Xg7LHWrZqDv9ErRke6iH/MzZYnZ5
 Vv3q7nkzF/UDuDeCQZ34cwqkeRgfDTA9vxAy+DrEBxxaoLj9pbZ+dY/
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238324-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bentiss@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E21D440FE47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.53.0


