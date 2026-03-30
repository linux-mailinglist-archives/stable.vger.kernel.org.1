Return-Path: <stable+bounces-231296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNWdBlsLy2lwDQYAu9opvQ
	(envelope-from <stable+bounces-231296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 01:46:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0E036267D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 01:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A965930166EB
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 23:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1442726E706;
	Mon, 30 Mar 2026 23:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKBeHjIr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF7A3BB48
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774914390; cv=none; b=AvBfAHVhCwwUnR1jvd5KZgQe0PsO83EQMQ+iXVQEySZq26Cp8dAGJm5PuwS6mNM8SvwC4j1XK1keQR9VyahYJJ4U2VRXmpcReQrJBtheG1PIGSxQWwIgJtAXNnv+wNlGteo4JM28Z3DTu4DdqfcXzkCme7pxTNxDrdfKvSg3MmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774914390; c=relaxed/simple;
	bh=pIHUmCfKcay6qQSUYHOFY7TIDyA9I7Z3NeTp/aLVGNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6tF2KYAxGruzRYfJN7X7jcoDjJ3qgjODG98w+0IIZdSw6ARIDXDMAE0gS5jdPS46FTPL5ad9f1QpDp1qx5u2qOnmCvT3Guq6AgsQElGlB2pc2njQ+XZwHL43Alk2a4SuV7oOaP9IneF8VDKM+rOmaa1OrWnQ9W17cTrjlKcWAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKBeHjIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B77C4CEF7;
	Mon, 30 Mar 2026 23:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774914390;
	bh=pIHUmCfKcay6qQSUYHOFY7TIDyA9I7Z3NeTp/aLVGNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKBeHjIrsfjpT6mHigqBK5yAQ/s1U1LCDNt5IDrPAnXPNiiJsxZjYx2Ut+b4j/hyv
	 HYonSCwbFuhJGlYoBrTercq/UEPHeJxq0ykWJQ6HW6/Aqe7uoCROuvjvCSDcd204JC
	 FBVL9w8dhyIlshKX5vclvhTbrKA2kGM0e66iO92nLBe7CPVqFNNtiBVKn3qsDjWg39
	 Aj8Ez2SnqV1qtLjrKhOTMeR868XveJwz885J49AFiYYDFArrqHnnPty8j77cnolKbD
	 uK04ANIkZE9GVzHgvkhYo3wZxezztEP7Mdm72k35NCJEGRmYU6uOhH4Zbde5EOlTtT
	 Acx8WGKkbaMOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eddie James <eajames@linux.ibm.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] hwmon: (pmbus/core) Add lock and unlock functions
Date: Mon, 30 Mar 2026 19:46:27 -0400
Message-ID: <20260330234628.1398011-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026032920-species-uncrushed-8b38@gregkh>
References: <2026032920-species-uncrushed-8b38@gregkh>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231296-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:email]
X-Rspamd-Queue-Id: 6E0E036267D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eddie James <eajames@linux.ibm.com>

[ Upstream commit a7ac37183ac2a0cc46d857997b2dd24997ca2754 ]

Debugfs operations may set the page number, which must be done
atomically with the subsequent i2c operation. Lock the update_lock
in the debugfs functions and provide a function for pmbus drivers
to lock and unlock the update_lock.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Link: https://lore.kernel.org/r/20230412161526.252294-2-eajames@linux.ibm.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: 3075a3951f77 ("hwmon: (pmbus/isl68137) Add mutex protection for AVS enable sysfs attributes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/pmbus.h      |  2 ++
 drivers/hwmon/pmbus/pmbus_core.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 0bbb8ae9341c3..19181e6e5efda 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -510,6 +510,8 @@ int pmbus_get_fan_rate_device(struct i2c_client *client, int page, int id,
 			      enum pmbus_fan_mode mode);
 int pmbus_get_fan_rate_cached(struct i2c_client *client, int page, int id,
 			      enum pmbus_fan_mode mode);
+int pmbus_lock_interruptible(struct i2c_client *client);
+void pmbus_unlock(struct i2c_client *client);
 int pmbus_update_fan(struct i2c_client *client, int page, int id,
 		     u8 config, u8 mask, u16 command);
 struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client);
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 4b73c7b27e9aa..1715fafc4152f 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -3049,8 +3049,13 @@ static int pmbus_debugfs_get(void *data, u64 *val)
 {
 	int rc;
 	struct pmbus_debugfs_entry *entry = data;
+	struct pmbus_data *pdata = i2c_get_clientdata(entry->client);
 
+	rc = mutex_lock_interruptible(&pdata->update_lock);
+	if (rc)
+		return rc;
 	rc = _pmbus_read_byte_data(entry->client, entry->page, entry->reg);
+	mutex_unlock(&pdata->update_lock);
 	if (rc < 0)
 		return rc;
 
@@ -3067,7 +3072,11 @@ static int pmbus_debugfs_get_status(void *data, u64 *val)
 	struct pmbus_debugfs_entry *entry = data;
 	struct pmbus_data *pdata = i2c_get_clientdata(entry->client);
 
+	rc = mutex_lock_interruptible(&pdata->update_lock);
+	if (rc)
+		return rc;
 	rc = pdata->read_status(entry->client, entry->page);
+	mutex_unlock(&pdata->update_lock);
 	if (rc < 0)
 		return rc;
 
@@ -3083,10 +3092,15 @@ static ssize_t pmbus_debugfs_mfr_read(struct file *file, char __user *buf,
 {
 	int rc;
 	struct pmbus_debugfs_entry *entry = file->private_data;
+	struct pmbus_data *pdata = i2c_get_clientdata(entry->client);
 	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
 
+	rc = mutex_lock_interruptible(&pdata->update_lock);
+	if (rc)
+		return rc;
 	rc = pmbus_read_block_data(entry->client, entry->page, entry->reg,
 				   data);
+	mutex_unlock(&pdata->update_lock);
 	if (rc < 0)
 		return rc;
 
@@ -3420,6 +3434,22 @@ struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client)
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_get_debugfs_dir, PMBUS);
 
+int pmbus_lock_interruptible(struct i2c_client *client)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+
+	return mutex_lock_interruptible(&data->update_lock);
+}
+EXPORT_SYMBOL_NS_GPL(pmbus_lock_interruptible, PMBUS);
+
+void pmbus_unlock(struct i2c_client *client)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+
+	mutex_unlock(&data->update_lock);
+}
+EXPORT_SYMBOL_NS_GPL(pmbus_unlock, PMBUS);
+
 static int __init pmbus_core_init(void)
 {
 	pmbus_debugfs_dir = debugfs_create_dir("pmbus", NULL);
-- 
2.53.0


