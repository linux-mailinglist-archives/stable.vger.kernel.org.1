Return-Path: <stable+bounces-222162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFHAFM6do2l2IQUAu9opvQ
	(envelope-from <stable+bounces-222162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:00:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0337E1CC978
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A70530930C0
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3C030C354;
	Sun,  1 Mar 2026 01:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4MQ7EKn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823151DF271;
	Sun,  1 Mar 2026 01:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330054; cv=none; b=qzXB/Ak6f9/tcKhz5o/H7rhw1U6YGYmwOeWIIjk15L4RZGUgQINxJvpFxkLKfkGOp72KIRDF3FwxVXWpxBJLYol8gTB6FswI/X96TWVN9zO7fnyPWKAiomPl8uQJoJEyql/rbDNcZYRXigSEG6uAP2TqIaE7iUWH//ZBes7UPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330054; c=relaxed/simple;
	bh=iObxE+O0WGH08E9ThUVOzRAODclGMmtshIzKWWb3qh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwN8Kr1EAVA7byKCROJ4LiQmz/L6prgq195aZlPPvVMNbNxAw71OjLy77TDG1Lz3xOT9r8mL+AC8sjx1FeKplL+ynyTuNwwXNCI0LaJQzYi+qbAP4j9SmCWqi+pIb4QCG/dOofk8gl6723rAmBkpN7tKbNHYCZXqiaIEIYw8jzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4MQ7EKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB63FC2BC86;
	Sun,  1 Mar 2026 01:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330054;
	bh=iObxE+O0WGH08E9ThUVOzRAODclGMmtshIzKWWb3qh4=;
	h=From:To:Cc:Subject:Date:From;
	b=W4MQ7EKnRWj/bPWgvui6HR91qBg08Rqi2bYZMLahc5ihS+StyYCNZIz1ajVVNTOrp
	 gv2H7E2dyATL3N+gnxdpBgwI9Gv/CRFRKgPLTKVwX8oVk0y9JBYW6VzUZYGDLRndv0
	 9jNFOCEt/glCB496dXaQltufe7+FppgRMkgf32TnNT8DsBS4Povpe0Lb5HtDvg3DlQ
	 L+3qWxrWstNWyG0gwXGMOGl/VwJvZPixRJ0k2k3PF3/E5hyZkC7H45ZYC5IXG/whdy
	 5B0cobVhJUevklb7vkwmb3v4rhEzB9y72u067OLvVdcge2hxJ35pZ8h7N1feiGwDVy
	 tx4pJVBMObQUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hanguidong02@gmail.com
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org
Subject: FAILED: Patch "hwmon: (max16065) Use READ/WRITE_ONCE to avoid compiler optimization induced race" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:54:12 -0500
Message-ID: <20260301015412.1721158-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222162-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,roeck-us.net:email,decadent.org.uk:email]
X-Rspamd-Queue-Id: 0337E1CC978
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 007be4327e443d79c9dd9e56dc16c36f6395d208 Mon Sep 17 00:00:00 2001
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Tue, 3 Feb 2026 20:14:43 +0800
Subject: [PATCH] hwmon: (max16065) Use READ/WRITE_ONCE to avoid compiler
 optimization induced race

Simply copying shared data to a local variable cannot prevent data
races. The compiler is allowed to optimize away the local copy and
re-read the shared memory, causing a Time-of-Check Time-of-Use (TOCTOU)
issue if the data changes between the check and the usage.

To enforce the use of the local variable, use READ_ONCE() when reading
the shared data and WRITE_ONCE() when updating it. Apply these macros to
the three identified locations (curr_sense, adc, and fault) where local
variables are used for error validation, ensuring the value remains
consistent.

Reported-by: Ben Hutchings <ben@decadent.org.uk>
Closes: https://lore.kernel.org/all/6fe17868327207e8b850cf9f88b7dc58b2021f73.camel@decadent.org.uk/
Fixes: f5bae2642e3d ("hwmon: Driver for MAX16065 System Manager and compatibles")
Fixes: b8d5acdcf525 ("hwmon: (max16065) Use local variable to avoid TOCTOU")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Link: https://lore.kernel.org/r/20260203121443.5482-1-hanguidong02@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max16065.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
index 4c9e7892a73c1..43fbb9b26b102 100644
--- a/drivers/hwmon/max16065.c
+++ b/drivers/hwmon/max16065.c
@@ -151,27 +151,27 @@ static struct max16065_data *max16065_update_device(struct device *dev)
 		int i;
 
 		for (i = 0; i < data->num_adc; i++)
-			data->adc[i]
-			  = max16065_read_adc(client, MAX16065_ADC(i));
+			WRITE_ONCE(data->adc[i],
+				   max16065_read_adc(client, MAX16065_ADC(i)));
 
 		if (data->have_current) {
-			data->adc[MAX16065_NUM_ADC]
-			  = max16065_read_adc(client, MAX16065_CSP_ADC);
-			data->curr_sense
-			  = i2c_smbus_read_byte_data(client,
-						     MAX16065_CURR_SENSE);
+			WRITE_ONCE(data->adc[MAX16065_NUM_ADC],
+				   max16065_read_adc(client, MAX16065_CSP_ADC));
+			WRITE_ONCE(data->curr_sense,
+				   i2c_smbus_read_byte_data(client, MAX16065_CURR_SENSE));
 		}
 
 		for (i = 0; i < 2; i++)
-			data->fault[i]
-			  = i2c_smbus_read_byte_data(client, MAX16065_FAULT(i));
+			WRITE_ONCE(data->fault[i],
+				   i2c_smbus_read_byte_data(client, MAX16065_FAULT(i)));
 
 		/*
 		 * MAX16067 and MAX16068 have separate undervoltage and
 		 * overvoltage alarm bits. Squash them together.
 		 */
 		if (data->chip == max16067 || data->chip == max16068)
-			data->fault[0] |= data->fault[1];
+			WRITE_ONCE(data->fault[0],
+				   data->fault[0] | data->fault[1]);
 
 		data->last_updated = jiffies;
 		data->valid = true;
@@ -185,7 +185,7 @@ static ssize_t max16065_alarm_show(struct device *dev,
 {
 	struct sensor_device_attribute_2 *attr2 = to_sensor_dev_attr_2(da);
 	struct max16065_data *data = max16065_update_device(dev);
-	int val = data->fault[attr2->nr];
+	int val = READ_ONCE(data->fault[attr2->nr]);
 
 	if (val < 0)
 		return val;
@@ -203,7 +203,7 @@ static ssize_t max16065_input_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct max16065_data *data = max16065_update_device(dev);
-	int adc = data->adc[attr->index];
+	int adc = READ_ONCE(data->adc[attr->index]);
 
 	if (unlikely(adc < 0))
 		return adc;
@@ -216,7 +216,7 @@ static ssize_t max16065_current_show(struct device *dev,
 				     struct device_attribute *da, char *buf)
 {
 	struct max16065_data *data = max16065_update_device(dev);
-	int curr_sense = data->curr_sense;
+	int curr_sense = READ_ONCE(data->curr_sense);
 
 	if (unlikely(curr_sense < 0))
 		return curr_sense;
-- 
2.51.0





