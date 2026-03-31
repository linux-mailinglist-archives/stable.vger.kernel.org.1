Return-Path: <stable+bounces-232110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGtoCIT9y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-232110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:59:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6921836D9F6
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2875931F6F21
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28D7423A9D;
	Tue, 31 Mar 2026 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FQg03svt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A243E95A9;
	Tue, 31 Mar 2026 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975901; cv=none; b=N0zI1HbVBVKtH5rhIpQifWcDK2NXTfAfxPPX/aD68gGAe09q3UK3V9wX3cdgRvXscuKKo4TS1irgbz9dA4AGrcA/W1H86ioZ+rHgHwrrP6SXeDOfm0tc4RusIb52bZ6UJ9shgkJFEEAyxNDINAGYiajYioG9N/1h8bn+icJL6oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975901; c=relaxed/simple;
	bh=ritlnYmAVfKny1KmnQQTmttXc4G2lzSGggqRisrD3Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=He7mITFxYbtao7iFHjftCtof5l3BzOn10V3BOsCXXZMS+mdKJcDkwZxed6mwboCFjkzOIIC0jlrvF5NaCX+oVcAGvPZSRL8zU3zCvyYav3VN3luZiV09MmAfBkqnPP6E7g8nZlpkWA9MY6axhpZsCLTHxgbWA2ooiKBKjxVRfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FQg03svt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388D7C19423;
	Tue, 31 Mar 2026 16:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975901;
	bh=ritlnYmAVfKny1KmnQQTmttXc4G2lzSGggqRisrD3Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQg03svttJ01BtsAYHPAN2wPst0itjO+RWHuZKuKhC5fKo8j4vOg1S+ztOA0EHbMd
	 nYyjwmjrux6U7nMohmTogJe28bJlQjGMMPcX/EhCPdSZtprOxbzYVepcd3cuFEoFt3
	 14Mmq7cZRSl0h6cWhujPzSw98VN39gW3s39IHg30=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 130/244] hwmon: (pmbus) Introduce the concept of "write-only" attributes
Date: Tue, 31 Mar 2026 18:21:20 +0200
Message-ID: <20260331161746.456228037@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232110-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,juniper.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 6921836D9F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit cd658475e7694d58e1c40dabc1dacf8431ccedb2 ]

Attributes intended to clear sensor history are intended to be writeable
only. Reading those attributes today results in reporting more or less
random values. To avoid ABI surprises, have those attributes explicitly
return 0 when reading.

Fixes: 787c095edaa9d ("hwmon: (pmbus/core) Add support for rated attributes")
Reviewed-by: Sanman Pradhan <psanman@juniper.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/pmbus_core.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index f452876287556..41c66ece5177e 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1205,6 +1205,12 @@ static ssize_t pmbus_show_boolean(struct device *dev,
 	return sysfs_emit(buf, "%d\n", val);
 }
 
+static ssize_t pmbus_show_zero(struct device *dev,
+			       struct device_attribute *devattr, char *buf)
+{
+	return sysfs_emit(buf, "0\n");
+}
+
 static ssize_t pmbus_show_sensor(struct device *dev,
 				 struct device_attribute *devattr, char *buf)
 {
@@ -1403,7 +1409,7 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 					     int reg,
 					     enum pmbus_sensor_classes class,
 					     bool update, bool readonly,
-					     bool convert)
+					     bool writeonly, bool convert)
 {
 	struct pmbus_sensor *sensor;
 	struct device_attribute *a;
@@ -1432,7 +1438,8 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 	sensor->data = -ENODATA;
 	pmbus_dev_attr_init(a, sensor->name,
 			    readonly ? 0444 : 0644,
-			    pmbus_show_sensor, pmbus_set_sensor);
+			    writeonly ? pmbus_show_zero : pmbus_show_sensor,
+			    pmbus_set_sensor);
 
 	if (pmbus_add_attribute(data, &a->attr))
 		return NULL;
@@ -1493,6 +1500,7 @@ struct pmbus_limit_attr {
 	u16 reg;		/* Limit register */
 	u16 sbit;		/* Alarm attribute status bit */
 	bool readonly:1;	/* True if the attribute is read-only */
+	bool writeonly:1;	/* True if the attribute is write-only */
 	bool update:1;		/* True if register needs updates */
 	bool low:1;		/* True if low limit; for limits with compare functions only */
 	const char *attr;	/* Attribute name */
@@ -1542,7 +1550,7 @@ static int pmbus_add_limit_attrs(struct i2c_client *client,
 			curr = pmbus_add_sensor(data, name, l->attr, index,
 						page, 0xff, l->reg, attr->class,
 						attr->update || l->update,
-						l->readonly, true);
+						l->readonly, l->writeonly, true);
 			if (!curr)
 				return -ENOMEM;
 			if (l->sbit && (info->func[page] & attr->sfunc)) {
@@ -1582,7 +1590,7 @@ static int pmbus_add_sensor_attrs_one(struct i2c_client *client,
 			return ret;
 	}
 	base = pmbus_add_sensor(data, name, "input", index, page, phase,
-				attr->reg, attr->class, true, true, true);
+				attr->reg, attr->class, true, true, false, true);
 	if (!base)
 		return -ENOMEM;
 	/* No limit and alarm attributes for phase specific sensors */
@@ -1719,6 +1727,7 @@ static const struct pmbus_limit_attr vin_limit_attrs[] = {
 		.attr = "highest",
 	}, {
 		.reg = PMBUS_VIRT_RESET_VIN_HISTORY,
+		.writeonly = true,
 		.attr = "reset_history",
 	}, {
 		.reg = PMBUS_MFR_VIN_MIN,
@@ -1793,6 +1802,7 @@ static const struct pmbus_limit_attr vout_limit_attrs[] = {
 		.attr = "highest",
 	}, {
 		.reg = PMBUS_VIRT_RESET_VOUT_HISTORY,
+		.writeonly = true,
 		.attr = "reset_history",
 	}, {
 		.reg = PMBUS_MFR_VOUT_MIN,
@@ -1874,6 +1884,7 @@ static const struct pmbus_limit_attr iin_limit_attrs[] = {
 		.attr = "highest",
 	}, {
 		.reg = PMBUS_VIRT_RESET_IIN_HISTORY,
+		.writeonly = true,
 		.attr = "reset_history",
 	}, {
 		.reg = PMBUS_MFR_IIN_MAX,
@@ -1915,6 +1926,7 @@ static const struct pmbus_limit_attr iout_limit_attrs[] = {
 		.attr = "highest",
 	}, {
 		.reg = PMBUS_VIRT_RESET_IOUT_HISTORY,
+		.writeonly = true,
 		.attr = "reset_history",
 	}, {
 		.reg = PMBUS_MFR_IOUT_MAX,
@@ -1973,6 +1985,7 @@ static const struct pmbus_limit_attr pin_limit_attrs[] = {
 		.attr = "input_highest",
 	}, {
 		.reg = PMBUS_VIRT_RESET_PIN_HISTORY,
+		.writeonly = true,
 		.attr = "reset_history",
 	}, {
 		.reg = PMBUS_MFR_PIN_MAX,
@@ -2014,6 +2027,7 @@ static const struct pmbus_limit_attr pout_limit_attrs[] = {
 		.attr = "input_highest",
 	}, {
 		.reg = PMBUS_VIRT_RESET_POUT_HISTORY,
+		.writeonly = true,
 		.attr = "reset_history",
 	}, {
 		.reg = PMBUS_MFR_POUT_MAX,
@@ -2085,6 +2099,7 @@ static const struct pmbus_limit_attr temp_limit_attrs[] = {
 		.attr = "highest",
 	}, {
 		.reg = PMBUS_VIRT_RESET_TEMP_HISTORY,
+		.writeonly = true,
 		.attr = "reset_history",
 	}, {
 		.reg = PMBUS_MFR_MAX_TEMP_1,
@@ -2130,6 +2145,7 @@ static const struct pmbus_limit_attr temp_limit_attrs2[] = {
 		.attr = "highest",
 	}, {
 		.reg = PMBUS_VIRT_RESET_TEMP2_HISTORY,
+		.writeonly = true,
 		.attr = "reset_history",
 	}, {
 		.reg = PMBUS_MFR_MAX_TEMP_2,
@@ -2247,7 +2263,7 @@ static int pmbus_add_fan_ctrl(struct i2c_client *client,
 
 	sensor = pmbus_add_sensor(data, "fan", "target", index, page,
 				  0xff, PMBUS_VIRT_FAN_TARGET_1 + id, PSC_FAN,
-				  false, false, true);
+				  false, false, false, true);
 
 	if (!sensor)
 		return -ENOMEM;
@@ -2258,14 +2274,14 @@ static int pmbus_add_fan_ctrl(struct i2c_client *client,
 
 	sensor = pmbus_add_sensor(data, "pwm", NULL, index, page,
 				  0xff, PMBUS_VIRT_PWM_1 + id, PSC_PWM,
-				  false, false, true);
+				  false, false, false, true);
 
 	if (!sensor)
 		return -ENOMEM;
 
 	sensor = pmbus_add_sensor(data, "pwm", "enable", index, page,
 				  0xff, PMBUS_VIRT_PWM_ENABLE_1 + id, PSC_PWM,
-				  true, false, false);
+				  true, false, false, false);
 
 	if (!sensor)
 		return -ENOMEM;
@@ -2307,7 +2323,7 @@ static int pmbus_add_fan_attributes(struct i2c_client *client,
 
 			if (pmbus_add_sensor(data, "fan", "input", index,
 					     page, 0xff, pmbus_fan_registers[f],
-					     PSC_FAN, true, true, true) == NULL)
+					     PSC_FAN, true, true, false, true) == NULL)
 				return -ENOMEM;
 
 			/* Fan control */
-- 
2.53.0




