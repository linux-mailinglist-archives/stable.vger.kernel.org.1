Return-Path: <stable+bounces-273937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZNqzHzcpVWrDkgAAu9opvQ
	(envelope-from <stable+bounces-273937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:06:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1EA74E4D3
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:06:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YS1Gji9o;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273937-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273937-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E5B9313B856
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 18:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E88635200C;
	Mon, 13 Jul 2026 18:03:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0C350A35
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:03:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965810; cv=none; b=qRS2bPlF60nPT7KJMkT04ALRkAEo46Ez7Ru2z/2RzEUS7SS/QbVtjyNAZUJwV550Mjr5Te/U1ePtQsNHpETVwpwnVYboW0wvQgVHAgIES9Gv0JMm2pubyZ9bRAPETWu+vOsShWwaFncdAsySUGtoAgADHYcYv78B7JAut50CTok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965810; c=relaxed/simple;
	bh=MKvwxZFnxB3DRWV5rIhtljphUx2EughJzTLU+Uowxks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdUF/M9ouWgarcDjZoGLIXU2LqCKTJX5sFgT4Y03M/LcU5zPA9+mEpDC97kDhLaw30SkEf3K1/6eH/Fhtyzin4VMo/NKRa2jkILZGcSOV63zx2slJuP/vEjIzfSOxUdwhCX58jD3lfkeHGnJ5pyokCLocG3WHvJnzMYbGnlgh6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YS1Gji9o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACDD1F000E9;
	Mon, 13 Jul 2026 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783965809;
	bh=E4s1hjzCgT7C2tJN8Mh59fVzQUjPV3m/GzKlocyj0xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YS1Gji9oFtnT23Pv5VtnVEgokTXpkDeMN00XNH5x6XdOzwkc2JsSQYd7rBirHjsSh
	 2LqGiUvZCsudaK5fjvhrxUuft9cK8GLSOMjMpzO3SM19wfJloscEQosbCs3t29KbEs
	 8JzOKX0YTxlYwq7/1ltGoqrYl0VZ1HFT7ZHqis1Gk5w6NJ6GA++aTHDH2NDZVrjZmw
	 UYoJ0O5lAWOGpqun3ESSjhyrOMi95eEbluMbpeOGnJI4oaq5knFF7cM0beEXgrE6V8
	 944/QWJD1O8oKzFbjQPJc/a5Fb7DxbrbjzKVgkGDDLVo5rMQC/c45evSwGYf1hhm2b
	 riu71uMTRwFeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Lixu <lixu.zhang@intel.com>,
	Jiri Kosina <jkosina@suse.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] HID: sensor-hub: Add sensor_hub_input_attr_read_values() for multi-byte reads
Date: Mon, 13 Jul 2026 14:03:25 -0400
Message-ID: <20260713180326.1923554-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071306-treachery-glare-d08d@gregkh>
References: <2026071306-treachery-glare-d08d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:srinivas.pandruvada@linux.intel.com,m:lixu.zhang@intel.com,m:jkosina@suse.com,m:andriy.shevchenko@intel.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273937-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,vger.kernel.org:from_smtp,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA1EA74E4D3

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit f784fcea450617055d2d12eec5b2f6e0e38bf878 ]

sensor_hub_input_attr_get_raw_value() is limited to returning a single
32-bit value, which is insufficient for sensors that report data larger
than 32 bits, such as a quaternion with four s16 elements.

Add sensor_hub_input_attr_read_values() that accepts a caller-provided
buffer and accumulates incoming data until the buffer is full. The two
paths are distinguished in sensor_hub_raw_event() by pending.max_raw_size
being non-zero, preserving backward compatibility.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Co-developed-by: Zhang Lixu <lixu.zhang@intel.com>
Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Jiri Kosina <jkosina@suse.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Stable-dep-of: 3ce8d099e0af ("iio: hid-sensor-rotation: Fix stale or zero output when reading raw values")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sensor-hub.c   | 77 +++++++++++++++++++++++++++++++---
 include/linux/hid-sensor-hub.h | 25 +++++++++++
 2 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 4c94c03cb57396..1b725c87965061 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -286,6 +286,54 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 }
 EXPORT_SYMBOL_GPL(sensor_hub_get_feature);
 
+int sensor_hub_input_attr_read_values(struct hid_sensor_hub_device *hsdev,
+				      u32 usage_id, u32 attr_usage_id,
+				      u32 report_id,
+				      enum sensor_hub_read_flags flag,
+				      u32 buffer_size, u8 *buffer)
+{
+	struct sensor_hub_data *data = hid_get_drvdata(hsdev->hdev);
+	struct hid_report *report;
+	unsigned long flags;
+	long cycles;
+	int ret;
+
+	report = sensor_hub_report(report_id, hsdev->hdev, HID_INPUT_REPORT);
+	if (!report)
+		return -EINVAL;
+
+	mutex_lock(hsdev->mutex_ptr);
+	if (flag == SENSOR_HUB_SYNC) {
+		memset(&hsdev->pending, 0, sizeof(hsdev->pending));
+		init_completion(&hsdev->pending.ready);
+		hsdev->pending.usage_id = usage_id;
+		hsdev->pending.attr_usage_id = attr_usage_id;
+		hsdev->pending.max_raw_size = buffer_size;
+		hsdev->pending.raw_data = buffer;
+
+		spin_lock_irqsave(&data->lock, flags);
+		hsdev->pending.status = true;
+		spin_unlock_irqrestore(&data->lock, flags);
+	}
+	mutex_lock(&data->mutex);
+	hid_hw_request(hsdev->hdev, report, HID_REQ_GET_REPORT);
+	mutex_unlock(&data->mutex);
+	ret = 0;
+	if (flag == SENSOR_HUB_SYNC) {
+		cycles = wait_for_completion_interruptible_timeout(&hsdev->pending.ready,
+								   HZ * 5);
+		if (cycles == 0)
+			ret = -ETIMEDOUT;
+		else if (cycles < 0)
+			ret = cycles;
+
+		hsdev->pending.status = false;
+	}
+	mutex_unlock(hsdev->mutex_ptr);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sensor_hub_input_attr_read_values);
 
 int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 					u32 usage_id,
@@ -480,6 +528,8 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 	struct hid_collection *collection = NULL;
 	void *priv = NULL;
 	struct hid_sensor_hub_device *hsdev = NULL;
+	u32 copy_size;
+	u32 avail;
 
 	hid_dbg(hdev, "sensor_hub_raw_event report id:0x%x size:%d type:%d\n",
 			 report->id, size, report->type);
@@ -520,12 +570,27 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 					      hsdev->pending.attr_usage_id ==
 					      report->field[i]->logical)) {
 			hid_dbg(hdev, "data was pending ...\n");
-			hsdev->pending.raw_data = kmemdup(ptr, sz, GFP_ATOMIC);
-			if (hsdev->pending.raw_data)
-				hsdev->pending.raw_size = sz;
-			else
-				hsdev->pending.raw_size = 0;
-			complete(&hsdev->pending.ready);
+			if (hsdev->pending.max_raw_size) {
+				if (hsdev->pending.index < hsdev->pending.max_raw_size) {
+					avail = hsdev->pending.max_raw_size - hsdev->pending.index;
+					copy_size = clamp(sz, 0U, avail);
+
+					memcpy(hsdev->pending.raw_data + hsdev->pending.index,
+					       ptr, copy_size);
+					hsdev->pending.index += copy_size;
+					if (hsdev->pending.index >= hsdev->pending.max_raw_size) {
+						hsdev->pending.raw_size = hsdev->pending.index;
+						complete(&hsdev->pending.ready);
+					}
+				}
+			} else {
+				hsdev->pending.raw_data = kmemdup(ptr, sz, GFP_ATOMIC);
+				if (hsdev->pending.raw_data)
+					hsdev->pending.raw_size = sz;
+				else
+					hsdev->pending.raw_size = 0;
+				complete(&hsdev->pending.ready);
+			}
 		}
 		if (callback->capture_sample) {
 			if (report->field[i]->logical)
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index c27329e2a5ad57..f034d1dbbee9e2 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -43,6 +43,8 @@ struct hid_sensor_hub_attribute_info {
  * @attr_usage_id:	Usage Id of a field, E.g. X-AXIS for a gyro.
  * @raw_size:		Response size for a read request.
  * @raw_data:		Place holder for received response.
+ * @index:		Current write index into raw_data for multi-byte reads.
+ * @max_raw_size:	Total buffer size for multi-byte reads; 0 for single-value reads.
  */
 struct sensor_hub_pending {
 	bool status;
@@ -51,6 +53,8 @@ struct sensor_hub_pending {
 	u32 attr_usage_id;
 	int raw_size;
 	u8  *raw_data;
+	u32 index;
+	u32 max_raw_size;
 };
 
 /**
@@ -182,6 +186,27 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 					bool is_signed
 );
 
+/**
+ * sensor_hub_input_attr_read_values() - Synchronous multi-byte read request
+ * @hsdev:		Hub device instance.
+ * @usage_id:		Attribute usage id of parent physical device as per spec
+ * @attr_usage_id:	Attribute usage id as per spec
+ * @report_id:		Report id to look for
+ * @flag:		Synchronous or asynchronous read
+ * @buffer_size:	Size of the buffer in bytes
+ * @buffer:		Buffer to store the read data
+ *
+ * Issues a synchronous or asynchronous read request for an input attribute,
+ * accumulating data into the provided buffer until it is full.
+ * Return: 0 on success, -ETIMEDOUT if the device did not respond, or a
+ * negative error code.
+ */
+int sensor_hub_input_attr_read_values(struct hid_sensor_hub_device *hsdev,
+				      u32 usage_id, u32 attr_usage_id,
+				      u32 report_id,
+				      enum sensor_hub_read_flags flag,
+				      u32 buffer_size, u8 *buffer);
+
 /**
 * sensor_hub_set_feature() - Feature set request
 * @hsdev:	Hub device instance.
-- 
2.53.0


