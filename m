Return-Path: <stable+bounces-261959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MR7AKz1fJmpBVgIAu9opvQ
	(envelope-from <stable+bounces-261959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 08:20:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD3365314E
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 08:20:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=tFknSs47;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261959-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261959-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 985063004F34
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 06:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F3A386573;
	Mon,  8 Jun 2026 06:20:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4153D2FC01B;
	Mon,  8 Jun 2026 06:20:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780899640; cv=none; b=gGp5Hs+MmuJIapn5VJuAT/tN8VkWo9SYRCuK7nku2FhdWkhpWNtlsYI7YpLDX0uWPXy1J//CDKFu2OyyFtz69IWsHgS7lAVnxYU83WIGVg5QE+2kU6lEwF7w1yvhXMi6KHUJZNHC+8MHNP8QkVui/yyHTJS5lBTcDG+R0j52ZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780899640; c=relaxed/simple;
	bh=7YhjvNgxS3flergW+n/2oP4NYiAbIg7ZOduVIJwydnE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Q/EoCois/wZ5/O8f/P/uqJ+00RfwT9Qh3DU+uz7tU8G3OhLMQCX0PN3GN6shfpo+0UIY8h7yznR5FsBurdxJZ1pucR90aVpUPnr++fMnUJucONbyUpcVkAJgzOE/rrYnKn48nt/xxTvG3q5LMSHoDUDoIpsf0veJZmT+URIhWBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tFknSs47; arc=none smtp.client-ip=203.205.221.221
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780899628; bh=+bozLRv1G18r0cA43VR1uBBsViRSEUk0zMCfOuQKsTM=;
	h=From:To:Cc:Subject:Date;
	b=tFknSs47ftHa62xZD8IBxSbEiLi5hdQdtb8GtHw3YTuYdnyXk95bHMo6N+HvgpO1A
	 TrbEOq1fcronFyDgHemikTW8GOgfh1V6aORn+MZXmFonvTckhv5IIqQ4PlOSk2lGEO
	 M4AHrjHPB1t4Swy+vYwR/nv9ffE+WEaTMOMVswcs=
Received: from NTT-kernel-dev ([60.247.85.88])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 517BE8CA; Mon, 08 Jun 2026 14:20:23 +0800
X-QQ-mid: xmsmtpt1780899623tqjcyimc8
Message-ID: <tencent_53D6CAB7A20BCE168EA9DF22F0E78EF14509@qq.com>
X-QQ-XMAILINFO: OeJ9zRfntlNPK35NgtXDxWQkmsYLqUjrWSdAAkqXII8ejL7M8g6OFZZFAGR1TG
	 Bmx/taKijvvMzPalQykCmCOVFI4R7+d63Z3Pb/mjVeZQBoNBAMyv+w2PlkTuFMq4QU6gUvIYVpnF
	 4kNsSsfRkcZiqGlLpDxOtujR+Nvff1PzaEJ/ckG5Dge5mzSOmySYDWrptYHrxdhZBjFYsY52ajOp
	 jLCjnw1JXX74IaP2pMRThgVd//CNhTLnZQiV2nEC+hRVG3gElGrjMUYZxie/jJCvMr2+GVKUFpzQ
	 Ku6C/1WWUZiTB0cahlKIkpPjAuNT92ZIkFMJv3Acc1tF3fQmQmOfIH3iXpA9ECyDpGkio+9N2BiS
	 HTumek5arHKN/C2uwGFA3wabGCOj7zmolP4mQTBflxr0mhomwfILmdlyD+Fy6ZQEKY2MC+Lzf+cb
	 itu6rakpMo5MncoAfrZOzUfRB2EICc8sSTUUUmx1S73rlSNMtBvwLIEJpS9zdkJspw7a3K7aRdnQ
	 zIXi/JmEsOr1ytlG2XB9GQT9Li5wK9e8I4nzrighv964Pj1nF3ZBi8zBnsn4l3Om6x8a6Fb8+szN
	 497gU/a7mm19F4vSbmrVgcDjXl7W4+sp4ndMR+mfaJEjznQKA6Kv2dXPgHNMG4dt2OZ6l/SgX73X
	 cVZQL2tsOnBQKLb45hmo8610/1VhUp2xW4iwfc0uMC/rsN8rDHmy19H8qWKTcRzW4/YSXZkobf1y
	 /S4nbKhgFo4gqlq+NEp5LKGUs8ed0A4A0mplWlkw4aWo35u9f7Ck5E0TJKL3YlyZMmISxbrv/5Q3
	 YkwRDvhQsLwFwuIs7wcWa9wrlwO4gQ6j60QiBHl2GIStMVXlYUK3pnUptlivcUIhZ6RUpu7ZDqRy
	 XaaSqLKO166R35scvOSuzkULENhHudNJTA8CMTblQnf5lmkS3Z+Q2Uwq1Nhte+HppwwqVOJR2Oto
	 wVlsiNaUP+Mi8Jg5OynVQd4au8d6DNDVUgzX9+wpMMalnQ34kNriE29TfhK/by7T6+esRbueSyY6
	 Awp3uVTXvJwaxVo1UYo/NggjemlfM=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Fang Wang <32840572@qq.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	linux@roeck-us.net
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jdelvare@suse.com,
	atull@opensource.altera.com,
	broonie@kernel.org,
	linux-hwmon@vger.kernel.org,
	psanman@juniper.net
Subject: [PATCH 6.6.y] hwmon: (pmbus/core) Protect regulator operations with mutex
Date: Mon,  8 Jun 2026 14:20:22 +0800
X-OQ-MSGID: <20260608062022.2822031-1-32840572@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261959-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:linux@roeck-us.net,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:jdelvare@suse.com,m:atull@opensource.altera.com,m:broonie@kernel.org,m:linux-hwmon@vger.kernel.org,m:psanman@juniper.net,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qq.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[32840572@qq.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[qq.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[32840572@qq.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[s.page:url,s.data:url,juniper.net:email,roeck-us.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qq.com:mid,qq.com:dkim,qq.com:from_mime,qq.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CD3365314E

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 754bd2b4a084b90b5e7b630e1f423061a9b9b761 ]

The regulator operations pmbus_regulator_get_voltage(),
pmbus_regulator_set_voltage(), and pmbus_regulator_list_voltage()
access PMBus registers and shared data but were not protected by
the update_lock mutex. This could lead to race conditions.

However, adding mutex protection directly to these functions causes
a deadlock because pmbus_regulator_notify() (which calls
regulator_notifier_call_chain()) is often called with the mutex
already held (e.g., from pmbus_fault_handler()). If a regulator
callback then calls one of the now-protected voltage functions,
it will attempt to acquire the same mutex.

Rework pmbus_regulator_notify() to utilize a worker function to
send notifications outside of the mutex protection. Events are
stored as atomics in a per-page bitmask and processed by the worker.

Initialize the worker and its associated data during regulator
registration, and ensure it is cancelled on device removal using
devm_add_action_or_reset().

While at it, remove the unnecessary include of linux/of.h.

Cc: Sanman Pradhan <psanman@juniper.net>
Fixes: ddbb4db4ced1b ("hwmon: (pmbus) Add regulator support")
Reviewed-by: Sanman Pradhan <psanman@juniper.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Fang Wang <32840572@qq.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 117 ++++++++++++++++++++++++-------
 1 file changed, 91 insertions(+), 26 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 019c5982ba56..a61e2fb176da 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2012 Guenter Roeck
  */
 
+#include <linux/atomic.h>
 #include <linux/debugfs.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
@@ -19,8 +20,8 @@
 #include <linux/pmbus.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-#include <linux/of.h>
 #include <linux/thermal.h>
+#include <linux/workqueue.h>
 #include "pmbus.h"
 
 /*
@@ -102,6 +103,11 @@ struct pmbus_data {
 
 	struct mutex update_lock;
 
+#if IS_ENABLED(CONFIG_REGULATOR)
+	atomic_t regulator_events[PMBUS_PAGES];
+	struct work_struct regulator_notify_work;
+#endif
+
 	bool has_status_word;		/* device uses STATUS_WORD register */
 	int (*read_status)(struct i2c_client *client, int page);
 
@@ -3056,12 +3062,19 @@ static int pmbus_regulator_get_voltage(struct regulator_dev *rdev)
 		.class = PSC_VOLTAGE_OUT,
 		.convert = true,
 	};
+	int ret;
 
+	mutex_lock(&data->update_lock);
 	s.data = _pmbus_read_word_data(client, s.page, 0xff, PMBUS_READ_VOUT);
-	if (s.data < 0)
-		return s.data;
+	if (s.data < 0) {
+		ret = s.data;
+		goto unlock;
+	}
 
-	return (int)pmbus_reg2data(data, &s) * 1000; /* unit is uV */
+	ret = (int)pmbus_reg2data(data, &s) * 1000; /* unit is uV */
+unlock:
+	mutex_unlock(&data->update_lock);
+	return ret;
 }
 
 static int pmbus_regulator_set_voltage(struct regulator_dev *rdev, int min_uv,
@@ -3078,16 +3091,22 @@ static int pmbus_regulator_set_voltage(struct regulator_dev *rdev, int min_uv,
 	};
 	int val = DIV_ROUND_CLOSEST(min_uv, 1000); /* convert to mV */
 	int low, high;
+	int ret;
 
 	*selector = 0;
 
+	mutex_lock(&data->update_lock);
 	low = pmbus_regulator_get_low_margin(client, s.page);
-	if (low < 0)
-		return low;
+	if (low < 0) {
+		ret = low;
+		goto unlock;
+	}
 
 	high = pmbus_regulator_get_high_margin(client, s.page);
-	if (high < 0)
-		return high;
+	if (high < 0) {
+		ret = high;
+		goto unlock;
+	}
 
 	/* Make sure we are within margins */
 	if (low > val)
@@ -3097,7 +3116,10 @@ static int pmbus_regulator_set_voltage(struct regulator_dev *rdev, int min_uv,
 
 	val = pmbus_data2reg(data, &s, val);
 
-	return _pmbus_write_word_data(client, s.page, PMBUS_VOUT_COMMAND, (u16)val);
+	ret = _pmbus_write_word_data(client, s.page, PMBUS_VOUT_COMMAND, (u16)val);
+unlock:
+	mutex_unlock(&data->update_lock);
+	return ret;
 }
 
 static int pmbus_regulator_list_voltage(struct regulator_dev *rdev,
@@ -3105,7 +3127,9 @@ static int pmbus_regulator_list_voltage(struct regulator_dev *rdev,
 {
 	struct device *dev = rdev_get_dev(rdev);
 	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct pmbus_data *data = i2c_get_clientdata(client);
 	int val, low, high;
+	int ret;
 
 	if (selector >= rdev->desc->n_voltages ||
 	    selector < rdev->desc->linear_min_sel)
@@ -3115,18 +3139,29 @@ static int pmbus_regulator_list_voltage(struct regulator_dev *rdev,
 	val = DIV_ROUND_CLOSEST(rdev->desc->min_uV +
 				(rdev->desc->uV_step * selector), 1000); /* convert to mV */
 
+	mutex_lock(&data->update_lock);
+
 	low = pmbus_regulator_get_low_margin(client, rdev_get_id(rdev));
-	if (low < 0)
-		return low;
+	if (low < 0) {
+		ret = low;
+		goto unlock;
+	}
 
 	high = pmbus_regulator_get_high_margin(client, rdev_get_id(rdev));
-	if (high < 0)
-		return high;
+	if (high < 0) {
+		ret = high;
+		goto unlock;
+	}
 
-	if (val >= low && val <= high)
-		return val * 1000; /* unit is uV */
+	if (val >= low && val <= high) {
+		ret = val * 1000; /* unit is uV */
+		goto unlock;
+	}
 
-	return 0;
+	ret = 0;
+unlock:
+	mutex_unlock(&data->update_lock);
+	return ret;
 }
 
 const struct regulator_ops pmbus_regulator_ops = {
@@ -3141,12 +3176,42 @@ const struct regulator_ops pmbus_regulator_ops = {
 };
 EXPORT_SYMBOL_NS_GPL(pmbus_regulator_ops, PMBUS);
 
+static void pmbus_regulator_notify_work_cancel(void *data)
+{
+	struct pmbus_data *pdata = data;
+
+	cancel_work_sync(&pdata->regulator_notify_work);
+}
+
+static void pmbus_regulator_notify_worker(struct work_struct *work)
+{
+	struct pmbus_data *data =
+		container_of(work, struct pmbus_data, regulator_notify_work);
+	int i, j;
+
+	for (i = 0; i < data->info->pages; i++) {
+		int event;
+
+		event = atomic_xchg(&data->regulator_events[i], 0);
+		if (!event)
+			continue;
+
+		for (j = 0; j < data->info->num_regulators; j++) {
+			if (i == rdev_get_id(data->rdevs[j])) {
+				regulator_notifier_call_chain(data->rdevs[j],
+							      event, NULL);
+				break;
+			}
+		}
+	}
+}
+
 static int pmbus_regulator_register(struct pmbus_data *data)
 {
 	struct device *dev = data->dev;
 	const struct pmbus_driver_info *info = data->info;
 	const struct pmbus_platform_data *pdata = dev_get_platdata(dev);
-	int i;
+	int i, ret;
 
 	data->rdevs = devm_kzalloc(dev, sizeof(struct regulator_dev *) * info->num_regulators,
 				   GFP_KERNEL);
@@ -3170,20 +3235,20 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 					     info->reg_desc[i].name);
 	}
 
+	INIT_WORK(&data->regulator_notify_work, pmbus_regulator_notify_worker);
+
+	ret = devm_add_action_or_reset(dev, pmbus_regulator_notify_work_cancel, data);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
 static int pmbus_regulator_notify(struct pmbus_data *data, int page, int event)
 {
-		int j;
-
-		for (j = 0; j < data->info->num_regulators; j++) {
-			if (page == rdev_get_id(data->rdevs[j])) {
-				regulator_notifier_call_chain(data->rdevs[j], event, NULL);
-				break;
-			}
-		}
-		return 0;
+	atomic_or(event, &data->regulator_events[page]);
+	schedule_work(&data->regulator_notify_work);
+	return 0;
 }
 #else
 static int pmbus_regulator_register(struct pmbus_data *data)
-- 
2.34.1


