Return-Path: <stable+bounces-213195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEVCKQ3ngWl0LwMAu9opvQ
	(envelope-from <stable+bounces-213195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:16:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1657BD8E0C
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1CFC30692C6
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC7F33F8A2;
	Tue,  3 Feb 2026 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmXap9PL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D003346B9
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120971; cv=none; b=e+o81f/EioYfSfBpl+1DL713f61/a1NAYWqXwq9AGVVSfmjKtzhrkF+BmOR4i5FcVDK8gqIfgwa1IoUlJ5zOz84SULd3JZ/RtO21TWecIy+bkcSOMxDFLUEfqAIVRYZx4+8vAOvZ6zJSCCzzHQYRV3bxZ6otKJ82lJlhgCYNJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120971; c=relaxed/simple;
	bh=oBNlv8tpYIAfycUufaW2kqcNJPt0+IY20m9BXQcCGbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKLWWn/on8DfwfAykx5rbi9Rao1h0c//pM4onEZbMMPPfZ6U1oLrKLDLI6ZElzVPm4VDHff80MRZZxS340Yi3/KXR1Uvc7zsNToTTXOM9ac+QXlLnKxCKODz4fvt0/wRhbC8X9qsG/R3Uk06VV436HImsOq39Uh5hRjvLJCqdyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmXap9PL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81dab89f286so2760019b3a.2
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 04:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770120969; x=1770725769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ibRrXpgw1lU51ODUe8Kbvxi0SMmu3MLTIurVFgESCMQ=;
        b=QmXap9PLs4e9k2Ck8cvMq/l+QVIdgig/sfrpTF05+SKiJq0/kOCfLjp0yFnV5NO2jn
         2T0O0C3wrQVYKah+5qLf5JkbAdWWVWlUepvhxW2lIcN7N7NkVjC3BtFbMUrmaX7A+YBt
         T3GrlnVWscAtFnUS3nfkEPD43doQ4kxcEeP6kpBWp/n7TVG9SLL8JYRik8sujwRKYi++
         YQx/DinXD4AUOTq13LMYQVx4UIShP6uO5VS5TVFZwU3u/jfNZd0w0gmNETK6gPi4/Ulm
         4P8ooZLcyk3WuY0hdAdeJHodROOUSjP/6Ti2nCnWLEDH/eYz1qWm1VuRKtB5vbAqLsu/
         u8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770120969; x=1770725769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibRrXpgw1lU51ODUe8Kbvxi0SMmu3MLTIurVFgESCMQ=;
        b=YuKz0eOM2B+mFIk+ps5VKJOnnuR8WE3JQn3QBnz5KvvGMd+Op6vxBNZMqEV/tfUq4m
         tZfpqh1xexHjKZTXAmQ5ypsCczyFQAk7WiaDke7fu1vP1DItpveHVxCh28IK62aB5Jnv
         h/KROcuJeoJBwfTwVRJGslEMJ7SVSIKxk/7HKW4gjfqfA0g41Qs6f/gnLSY6z2eSeZTz
         82OgOSTkCLSgTe47ChUACcux/QONt35j9uXJ4mBV9FprRYwfSP7PkYyFCUxirNjuSwni
         A8s2JIESoDqrQgBd57iRSKLnfFgiQGoSImyVEFGfbYzv41fy9pPzPJ768jdl/Z4NXA5A
         qUyA==
X-Forwarded-Encrypted: i=1; AJvYcCV0nuEYng9zP/TUXG3dfldZ2cegoJlkvQ5YVTZbu3ALDSFzhb5lkXFPKbT8CQRDVxTo1SEcXZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMzswE+Vl9Tef9OaWwHwlzMEyT6o0vfcKG8szxu5t3rE0+lVL3
	T9JR0IH3GXRvzFzsfcmAlqnzG9DYaAxnGHnUNN440ajmaPEk2ym63nSN
X-Gm-Gg: AZuq6aJZogBGJMPPC6BgjN06Z4aDhvAn1BXG7jijugeERvZnFkT15J8CFJl+7ltJW/f
	LsICuaW5bO1ylGzlNOQJy5SkPqHkAf3dyPW6f/O6ClMYdNrE94FIw+didB9ngjkAmaFrDrWHnPp
	RpbFKeobIK+K+1cFCQSwSdCM9Q3YQ0aiQPNtDp2QogwG+qM0VGCMJypatmCieRGwMas8KV0nR/W
	jwYkRHtILmjzl/qZMkPS3Bcz0mR2Dh3Fq8s94IJ3os4JZZaljzNPuOmFWN+oZTfQnqe790ydPBj
	ECQy2Il/kFz9a04YCttbrAZGMpvn6hU1wEQrB61ltLRW5mqi3llRfggb+hEcrais+L5ADtsbCC7
	/qlufNd8aYK07szULeGQW6uwJbh//q42878AcchzInVT/eRemUhLYJ8G2b6O+4TQi4ALvGPRoRe
	GxpKqOdVNG6r5kLI9SUsO15VjUnyDOGaDWRVmj1btA813IFwEo1mZ6MIw/JDSXGYVRPxqzwCfe5
	nFMv/cbZVIcyhb/cxbteADJ9XcrXLkgB+iJmctE0bWUAe85Vw/5tmjYFtoCRtrrzwag
X-Received: by 2002:aa7:9064:0:b0:81f:50b1:51f2 with SMTP id d2e1a72fcca58-823aa71118cmr12594872b3a.41.1770120968901;
        Tue, 03 Feb 2026 04:16:08 -0800 (PST)
Received: from 2045D.localdomain (120.sub-75-226-39.myvzw.com. [75.226.39.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfb924sm19339481b3a.34.2026.02.03.04.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 04:16:08 -0800 (PST)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (max16065) Use READ/WRITE_ONCE to avoid compiler optimization induced race
Date: Tue,  3 Feb 2026 20:14:43 +0800
Message-ID: <20260203121443.5482-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,decadent.org.uk];
	TAGGED_FROM(0.00)[bounces-213195-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,decadent.org.uk:email]
X-Rspamd-Queue-Id: 1657BD8E0C
X-Rspamd-Action: no action

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
---
 drivers/hwmon/max16065.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
index 4c9e7892a73c..43fbb9b26b10 100644
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
2.43.0


