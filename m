Return-Path: <stable+bounces-220839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gATrEoNGo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:48:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5DD1C75F7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 673363085EDD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913D04170DD;
	Sat, 28 Feb 2026 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5aD8a2c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BCC41791F;
	Sat, 28 Feb 2026 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300724; cv=none; b=CgP9hgAThVpFQlgHqbWRg/L0QFPhrlulKYZPfIwxmICwX1EJPieyXgoyfPO2Ifxp+LyDlxmafcN2ZcRdPqHYvd/L/XSUgm7PgkybJuV4ReYYNiDPQlE3YG6+Bw2It6tPo3VpfNTYxEwL4FgOaq32UinK3ObsTDzXIYgU63kj1Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300724; c=relaxed/simple;
	bh=qoKGMMA8c2XybmlNisuifTOpQXuhT19rXE7/Qukienc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqQy9Q9H7UhKFA8XU7aye912qes7hVJ6KybVCho2KFMpRU+626EeThli/CjngkXBn3wmx6UHPfSsRXT7PxpKBE8Lo9HX65wIysZTUCAQvKXNEo+wd74TJlFvR+X/xFrxV8F9/1/1gNBgbbEBlWo6ghUQqUPJNoAYshLyoLdMuJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5aD8a2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D95C116D0;
	Sat, 28 Feb 2026 17:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300724;
	bh=qoKGMMA8c2XybmlNisuifTOpQXuhT19rXE7/Qukienc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5aD8a2c3MfdrB2AdnWXGys4z2b0NG6xOY7BtP6FzsBu7sAJkMDl7+3/wdl1crnOc
	 2kbLjOALTqsWiFLhkHFHiRTcr33NdQ21o0I7/Hwtb/CKeEMH18esLsfv1LQMLDv5KL
	 /5cI/oW7P940ma8pIEqO0tOKBcv190B9+he/b3Jogeu5G4HX2jUSawzPFwnvTT8cbR
	 Xk/ciM8Imv8EIpmkdYs2/LIo/OC+J1IzF0MlKjeVH+Dc04b4dxFz8Q+l4SsPwzOIer
	 YPCIdQwG4jPK2/YPkR8tQo+w6k0PzlB5sAV52Gq3/b3NMqT3w8syasAy4OfgPnZDqj
	 PFNbW/h3plKEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gui-Dong Han <hanguidong02@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 760/844] hwmon: (max16065) Use READ/WRITE_ONCE to avoid compiler optimization induced race
Date: Sat, 28 Feb 2026 12:31:13 -0500
Message-ID: <20260228173244.1509663-761-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,decadent.org.uk,roeck-us.net,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220839-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,decadent.org.uk:email]
X-Rspamd-Queue-Id: CC5DD1C75F7
X-Rspamd-Action: no action

From: Gui-Dong Han <hanguidong02@gmail.com>

[ Upstream commit 007be4327e443d79c9dd9e56dc16c36f6395d208 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


