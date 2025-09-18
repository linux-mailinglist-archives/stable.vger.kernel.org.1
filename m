Return-Path: <stable+bounces-178459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91738B47EC0
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4A61B20553
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B9426E6FF;
	Sun,  7 Sep 2025 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lrtx1ZXh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B926FA77;
	Sun,  7 Sep 2025 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276902; cv=none; b=suV/mZaWEFcwPUH5j2YQ0rz5Lv9k4NNRVFCEhOnuui7Kvb3aL690nCkbVtwhmK9N6lAGr3c+mEq3OUNrrag3uEo8id7QLLKZkEhJYUw8sMYIPAUsQT9KnF7cBAKfg5jiPN7Ks2afXeWQKTNWRJNBLYB1lWvKSmqjmUgY+n1AzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276902; c=relaxed/simple;
	bh=HRSEC3rWjsf5D0ZJL2b9jyuwEQx5dgX8HkmcINB8Plc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiIAkuLnczIFvAwUXXFo9QaaZHmcaY9hwQSlM9A1ijp/7ctNjdWpdY4Mz3cDLcJpkqWJDiyjghkOWH0w7fMI7uMRkxR3rSaLh8Ee1RxUtnGgLZKTOf7n/ztHltL8XMkdljEqINcJT+3U9Rjr/11TSq0tO7tqp5r5ky/8wSl+OU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lrtx1ZXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27166C4CEF8;
	Sun,  7 Sep 2025 20:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276902;
	bh=HRSEC3rWjsf5D0ZJL2b9jyuwEQx5dgX8HkmcINB8Plc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lrtx1ZXh88mpRjl5j964CMkKnBwa+WFTnbPwM3HW0jhmp5hwI6vzrnt/L8VczCBox
	 PeF6F3jw/bbvNDXlRqo8UsOJOZh5k/oN45rX3Y7bT05g70AYa/gouRdU/AuznEI7DA
	 9+OaNtjOelYfW2pEKtUgcqV1ZOgwSdNz4Y1a+QPs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 024/175] HID: stop exporting hid_snto32()
Date: Sun,  7 Sep 2025 21:56:59 +0200
Message-ID: <20250907195615.449597440@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
References: <20250907195614.892725141@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit c653ffc283404a6c1c0e65143a833180c7ff799b ]

The only user of hid_snto32() is Logitech HID++ driver, which always
calls hid_snto32() with valid size (constant, either 12 or 8) and
therefore can simply use sign_extend32().

Make the switch and remove hid_snto32(). Move snto32() and s32ton() to
avoid introducing forward declaration.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://patch.msgid.link/20241003144656.3786064-2-dmitry.torokhov@gmail.com
[bentiss: fix checkpatch warning]
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Stable-dep-of: a6b87bfc2ab5 ("HID: core: Harden s32ton() against conversion to 0 bits")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-core.c           | 63 +++++++++++++++-----------------
 drivers/hid/hid-logitech-hidpp.c |  6 +--
 include/linux/hid.h              |  1 -
 3 files changed, 32 insertions(+), 38 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 1a8e88624acfb..5169d8d56c889 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -45,6 +45,34 @@ static int hid_ignore_special_drivers = 0;
 module_param_named(ignore_special_drivers, hid_ignore_special_drivers, int, 0600);
 MODULE_PARM_DESC(ignore_special_drivers, "Ignore any special drivers and handle all devices by generic driver");
 
+/*
+ * Convert a signed n-bit integer to signed 32-bit integer.
+ */
+
+static s32 snto32(__u32 value, unsigned int n)
+{
+	if (!value || !n)
+		return 0;
+
+	if (n > 32)
+		n = 32;
+
+	return sign_extend32(value, n - 1);
+}
+
+/*
+ * Convert a signed 32-bit integer to a signed n-bit integer.
+ */
+
+static u32 s32ton(__s32 value, unsigned int n)
+{
+	s32 a = value >> (n - 1);
+
+	if (a && a != -1)
+		return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
+	return value & ((1 << n) - 1);
+}
+
 /*
  * Register a new report for a device.
  */
@@ -425,7 +453,7 @@ static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
 		 * both this and the standard encoding. */
 		raw_value = item_sdata(item);
 		if (!(raw_value & 0xfffffff0))
-			parser->global.unit_exponent = hid_snto32(raw_value, 4);
+			parser->global.unit_exponent = snto32(raw_value, 4);
 		else
 			parser->global.unit_exponent = raw_value;
 		return 0;
@@ -1317,39 +1345,6 @@ int hid_open_report(struct hid_device *device)
 }
 EXPORT_SYMBOL_GPL(hid_open_report);
 
-/*
- * Convert a signed n-bit integer to signed 32-bit integer.
- */
-
-static s32 snto32(__u32 value, unsigned n)
-{
-	if (!value || !n)
-		return 0;
-
-	if (n > 32)
-		n = 32;
-
-	return sign_extend32(value, n - 1);
-}
-
-s32 hid_snto32(__u32 value, unsigned n)
-{
-	return snto32(value, n);
-}
-EXPORT_SYMBOL_GPL(hid_snto32);
-
-/*
- * Convert a signed 32-bit integer to a signed n-bit integer.
- */
-
-static u32 s32ton(__s32 value, unsigned n)
-{
-	s32 a = value >> (n - 1);
-	if (a && a != -1)
-		return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
-	return value & ((1 << n) - 1);
-}
-
 /*
  * Extract/implement a data field from/to a little endian report (bit array).
  *
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 234ddd4422d90..59f630962338d 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3296,13 +3296,13 @@ static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
 					 120);
 		}
 
-		v = hid_snto32(hid_field_extract(hdev, data+3, 0, 12), 12);
+		v = sign_extend32(hid_field_extract(hdev, data + 3, 0, 12), 11);
 		input_report_rel(hidpp->input, REL_X, v);
 
-		v = hid_snto32(hid_field_extract(hdev, data+3, 12, 12), 12);
+		v = sign_extend32(hid_field_extract(hdev, data + 3, 12, 12), 11);
 		input_report_rel(hidpp->input, REL_Y, v);
 
-		v = hid_snto32(data[6], 8);
+		v = sign_extend32(data[6], 7);
 		if (v != 0)
 			hidpp_scroll_counter_handle_scroll(hidpp->input,
 					&hidpp->vertical_wheel_counter, v);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 017d31f1d27b8..7d8d09318fa91 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -978,7 +978,6 @@ const struct hid_device_id *hid_match_device(struct hid_device *hdev,
 					     struct hid_driver *hdrv);
 bool hid_compare_device_paths(struct hid_device *hdev_a,
 			      struct hid_device *hdev_b, char separator);
-s32 hid_snto32(__u32 value, unsigned n);
 __u32 hid_field_extract(const struct hid_device *hid, __u8 *report,
 		     unsigned offset, unsigned n);
 
-- 
2.50.1




