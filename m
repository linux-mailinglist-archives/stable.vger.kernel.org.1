Return-Path: <stable+bounces-221274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGD3G+qTo2khHQUAu9opvQ
	(envelope-from <stable+bounces-221274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:18:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 001561CA228
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7714301916E
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A1DC8F0;
	Sun,  1 Mar 2026 01:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjSXws4U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C0223C4F2;
	Sun,  1 Mar 2026 01:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327861; cv=none; b=Z+XZbiTOlBvvh+xB6taEEzFO9PAdI2gNbP72CqDKs4jvPxPZWYUT+xPIPD5tQDh+IcChgN7Itd5YIiCAOZlIkht4/UNFudb45d6PMeTOygp4SmlvgOWmsRvDkFvOvPYfjrNexQMZORzv6TKfIQiS9eat1HorjaUNcEcav05FT4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327861; c=relaxed/simple;
	bh=HXGcoAijH4/4ohVsu57ubguTxoppGZjmfdYLM0hPuDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=koJoRyNcO0G/Oh+ElOiO9hoAPXZM5OHBpvOe+z96GJeABrZKtf4/j+4//zEPOwHMa886EyFVw+e8GhxdeljnT/SJo9kYEPecF9KxFHkcBwgzk5I03Wn0ACmrM+Yrgpt2hwzz0WS45MvyC/q88Lop0WSylAsbNyrY7QSi4t1tQZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjSXws4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C58C19421;
	Sun,  1 Mar 2026 01:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327861;
	bh=HXGcoAijH4/4ohVsu57ubguTxoppGZjmfdYLM0hPuDM=;
	h=From:To:Cc:Subject:Date:From;
	b=RjSXws4UGJ/CSHS2su0cZCmS2T45tnIlTeQsJI/qocgmVBgZ9ZwVA6tl962NdSE/S
	 sVjUYVbDT+JvIguL6EOD801EqggYPeow/YabHsLCF6bFK4u4D+valUlxHP6yPBT0mi
	 p5ByIavt0Tjf08Vv7RIwivEny4na2w1iaLP9+2sOh6vr9HMFWKke4a/nTIYMimpI5T
	 wnxu0j4Jo9qGI9rkr5tjWdfF7EPDtUxMM46V1xTPrNwz/3DySDMZ5yYN0onOyN9m66
	 HL9dpZ7k/EawVjmye2SNR0PZwpluOJYOmWUMBMWl4gV6d7dmh+jLmEkmf2NJ5VDno0
	 pShELnIDhdmVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hanguidong02@gmail.com
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org
Subject: FAILED: Patch "hwmon: (max16065) Use READ/WRITE_ONCE to avoid compiler optimization induced race" failed to apply to 6.18-stable tree
Date: Sat, 28 Feb 2026 20:17:39 -0500
Message-ID: <20260301011739.1671643-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221274-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,decadent.org.uk:email]
X-Rspamd-Queue-Id: 001561CA228
X-Rspamd-Action: no action

The patch below does not apply to the 6.18-stable tree.
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





