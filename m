Return-Path: <stable+bounces-259560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGZOLgiMHWqKbwkAu9opvQ
	(envelope-from <stable+bounces-259560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 15:41:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E9620323
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 15:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49DE63003606
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 13:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99DB3A4F5F;
	Mon,  1 Jun 2026 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXbEbXwB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59733A4F2F
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320974; cv=none; b=as3fT4jNXtPRH81CDroqi8hyIDj0vhxHh8C7LBTvk/OihQzWJrqEoLkBiidh6vVJ7iLOALO/Gg6HgSP3qa5y/sKeiWqOfQSjYlaY5IQNLgJ4Anwl81nmYe30G7Sh5yw90jRWhAoawPO3uobMEphnW7LyhBtZ4dupFoX9NQZ6jzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320974; c=relaxed/simple;
	bh=QlmJWxL1Jm9pKGUIjgONOuieZ4Y7BJhgM91SgyAsccM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hz4cid9R3DMZjEQ4HA8SjrmVx8jCczLQxWYe5B3IMaoVp5n8QZaN4XdgmZ7MVF3tlpVyvojgrDrc1XG6OcCMDGS1cVsgPvGPrRt/EvEQzvFDf58g+l+usG17KDjayKwwSAkiMXeHN1n4EOgdmSYzzC5ZngPPbE9b7gngPiXf1KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXbEbXwB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD341F00893;
	Mon,  1 Jun 2026 13:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780320973;
	bh=8M1n566b0xLrwcP5VjKaUoqyQDbA/JKxkRSbNY9qWLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JXbEbXwBI6eNSJhwt8uOzRBYWNqV8H2DeE4vbxVnVD9dg8V5asdTRqCxhq3odGrqV
	 WmDvIbUVV+V7wySC3YefQ73G/Fq0RA9PdTCBZYrhkSBbwBNgr5rMpyv/Gv8I4egI/E
	 vf+K/qpQCRkyqWv12ZvMoKe5Xw27ut7gCQ/QNKhO/EU5fweLJ/jCbRLrYmxHfc52f8
	 mJSDLct0UpkwQ2tkhtu6lFpstvHe4TfCkNZSUMbM//xt3xBu4XKkrhd3m6wyGPDohs
	 bihi8shH4/dV9aSYIjHbWPEAoU34yHj6iABV1i1o1OJ1mJQgAzbxtr94Ur2ntNCgMq
	 /CabYr+BmOaxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sanman Pradhan <psanman@juniper.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/2] hwmon: (pmbus) Add support for guarded PMBus lock
Date: Mon,  1 Jun 2026 09:36:10 -0400
Message-ID: <20260601133611.789541-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052840-vigorous-cosponsor-eb81@gregkh>
References: <2026052840-vigorous-cosponsor-eb81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259560-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,roeck-us.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 106E9620323
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 1814f4d3ff358277a5b6957e7f133c2812dc80ec ]

Add support for guard(pmbus_lock)() and scoped_guard(pmbus_lock)()
to be able to simplify the PMBus code.

Also introduce pmbus_lock() as pre-requisite for supporting
guard().

Reviewed-by: Sanman Pradhan <psanman@juniper.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: bab8c6fb5af8 ("hwmon: (pmbus/adm1266) serialize GPIO PMBus accesses with pmbus_lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/pmbus.h      | 5 +++++
 drivers/hwmon/pmbus/pmbus_core.c | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index d2e9bfb5320fc..e499cdae9442c 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -10,6 +10,7 @@
 #define PMBUS_H
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/regulator/driver.h>
 
 /*
@@ -563,7 +564,11 @@ int pmbus_get_fan_rate_device(struct i2c_client *client, int page, int id,
 int pmbus_get_fan_rate_cached(struct i2c_client *client, int page, int id,
 			      enum pmbus_fan_mode mode);
 int pmbus_lock_interruptible(struct i2c_client *client);
+void pmbus_lock(struct i2c_client *client);
 void pmbus_unlock(struct i2c_client *client);
+
+DEFINE_GUARD(pmbus_lock, struct i2c_client *, pmbus_lock(_T), pmbus_unlock(_T))
+
 int pmbus_update_fan(struct i2c_client *client, int page, int id,
 		     u8 config, u8 mask, u16 command);
 struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client);
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 572be3ebc03df..7150f12d26300 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -3871,6 +3871,14 @@ struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client)
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_get_debugfs_dir, "PMBUS");
 
+void pmbus_lock(struct i2c_client *client)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+}
+EXPORT_SYMBOL_NS_GPL(pmbus_lock, "PMBUS");
+
 int pmbus_lock_interruptible(struct i2c_client *client)
 {
 	struct pmbus_data *data = i2c_get_clientdata(client);
-- 
2.53.0


