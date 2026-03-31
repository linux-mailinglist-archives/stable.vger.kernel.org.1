Return-Path: <stable+bounces-232426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDiiEZUAzGkoNQYAu9opvQ
	(envelope-from <stable+bounces-232426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:12:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E34F036E2E6
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 296B9306A32B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6922FE042;
	Tue, 31 Mar 2026 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TEEuaWXQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E343019D6;
	Tue, 31 Mar 2026 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976717; cv=none; b=Cm/UYxx+uvhQW4ZZvEJSJrK4Xy1bSAU7hD9DxqGDCPrL+Nfu35eTRrESBwDLm98AW5dSAN8gfOSoncrePsSfbIva5Lpu/u1wS/dxWurPSObM18LG1aL/YDhQI1zwULvTl4YJGVdIf62gW+c+Qb0bBobWmy9Rtm2UwqcBJaNEshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976717; c=relaxed/simple;
	bh=XHECGfPKS+XYCVk4a8npHEz7Wrk0OWiSEFG9eXMBUpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvuyX+rpHzwCnWQftBneP2rRuKZY3bRhxw/ViL/q0T8r47lZHjgSOPCD79z/15HY2mUl1EernNXcEkFdur6XA2ZcAYwHFlgeLVPLd6fzCFTLBZMaLuWQOVZaSJPF3MKhQY43kJgmuAei3rv5Mk5rhd4R9M4/J1/55JnjgAMCkxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TEEuaWXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B932C19423;
	Tue, 31 Mar 2026 17:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976716;
	bh=XHECGfPKS+XYCVk4a8npHEz7Wrk0OWiSEFG9eXMBUpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TEEuaWXQfrKLQaXOMTxtFEjjE2uvrqi4nXUpenCB3fteMTqTzcJPGULYGDz9fCc4v
	 i+K1VrKJVz2lZGr5tq0ScpTP9BInJ4pnkynRLnyLvNnkpZGIw2XvjsBlDPXPpW5QFs
	 Wbt0p6N/sk6H1yHLu+8Rx7a0jf9iTLxlIOy21FFw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 167/309] hwmon: (pmbus) Mark lowest/average/highest/rated attributes as read-only
Date: Tue, 31 Mar 2026 18:21:10 +0200
Message-ID: <20260331161759.612147254@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232426-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,roeck-us.net:email,juniper.net:email]
X-Rspamd-Queue-Id: E34F036E2E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 805a5bd1c3f307d45ae4e9cf8915ef16d585a54a ]

Writing those attributes is not supported, so mark them as read-only.

Prior to this change, attempts to write into these attributes returned
an error.

Mark boolean fields in struct pmbus_limit_attr and in struct
pmbus_sensor_attr as bit fields to reduce configuration data size.
The data is scanned only while probing, so performance is not a concern.

Fixes: 6f183d33a02e6 ("hwmon: (pmbus) Add support for peak attributes")
Reviewed-by: Sanman Pradhan <psanman@juniper.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/pmbus_core.c | 48 ++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index be6d05def1152..ecd1dddcbe0ff 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1495,8 +1495,9 @@ static int pmbus_add_label(struct pmbus_data *data,
 struct pmbus_limit_attr {
 	u16 reg;		/* Limit register */
 	u16 sbit;		/* Alarm attribute status bit */
-	bool update;		/* True if register needs updates */
-	bool low;		/* True if low limit; for limits with compare functions only */
+	bool readonly:1;	/* True if the attribute is read-only */
+	bool update:1;		/* True if register needs updates */
+	bool low:1;		/* True if low limit; for limits with compare functions only */
 	const char *attr;	/* Attribute name */
 	const char *alarm;	/* Alarm attribute name */
 };
@@ -1511,9 +1512,9 @@ struct pmbus_sensor_attr {
 	u8 nlimit;			/* # of limit registers */
 	enum pmbus_sensor_classes class;/* sensor class */
 	const char *label;		/* sensor label */
-	bool paged;			/* true if paged sensor */
-	bool update;			/* true if update needed */
-	bool compare;			/* true if compare function needed */
+	bool paged:1;			/* true if paged sensor */
+	bool update:1;			/* true if update needed */
+	bool compare:1;			/* true if compare function needed */
 	u32 func;			/* sensor mask */
 	u32 sfunc;			/* sensor status mask */
 	int sreg;			/* status register */
@@ -1544,7 +1545,7 @@ static int pmbus_add_limit_attrs(struct i2c_client *client,
 			curr = pmbus_add_sensor(data, name, l->attr, index,
 						page, 0xff, l->reg, attr->class,
 						attr->update || l->update,
-						false, true);
+						l->readonly, true);
 			if (!curr)
 				return -ENOMEM;
 			if (l->sbit && (info->func[page] & attr->sfunc)) {
@@ -1707,23 +1708,28 @@ static const struct pmbus_limit_attr vin_limit_attrs[] = {
 	}, {
 		.reg = PMBUS_VIRT_READ_VIN_AVG,
 		.update = true,
+		.readonly = true,
 		.attr = "average",
 	}, {
 		.reg = PMBUS_VIRT_READ_VIN_MIN,
 		.update = true,
+		.readonly = true,
 		.attr = "lowest",
 	}, {
 		.reg = PMBUS_VIRT_READ_VIN_MAX,
 		.update = true,
+		.readonly = true,
 		.attr = "highest",
 	}, {
 		.reg = PMBUS_VIRT_RESET_VIN_HISTORY,
 		.attr = "reset_history",
 	}, {
 		.reg = PMBUS_MFR_VIN_MIN,
+		.readonly = true,
 		.attr = "rated_min",
 	}, {
 		.reg = PMBUS_MFR_VIN_MAX,
+		.readonly = true,
 		.attr = "rated_max",
 	},
 };
@@ -1776,23 +1782,28 @@ static const struct pmbus_limit_attr vout_limit_attrs[] = {
 	}, {
 		.reg = PMBUS_VIRT_READ_VOUT_AVG,
 		.update = true,
+		.readonly = true,
 		.attr = "average",
 	}, {
 		.reg = PMBUS_VIRT_READ_VOUT_MIN,
 		.update = true,
+		.readonly = true,
 		.attr = "lowest",
 	}, {
 		.reg = PMBUS_VIRT_READ_VOUT_MAX,
 		.update = true,
+		.readonly = true,
 		.attr = "highest",
 	}, {
 		.reg = PMBUS_VIRT_RESET_VOUT_HISTORY,
 		.attr = "reset_history",
 	}, {
 		.reg = PMBUS_MFR_VOUT_MIN,
+		.readonly = true,
 		.attr = "rated_min",
 	}, {
 		.reg = PMBUS_MFR_VOUT_MAX,
+		.readonly = true,
 		.attr = "rated_max",
 	},
 };
@@ -1852,20 +1863,24 @@ static const struct pmbus_limit_attr iin_limit_attrs[] = {
 	}, {
 		.reg = PMBUS_VIRT_READ_IIN_AVG,
 		.update = true,
+		.readonly = true,
 		.attr = "average",
 	}, {
 		.reg = PMBUS_VIRT_READ_IIN_MIN,
 		.update = true,
+		.readonly = true,
 		.attr = "lowest",
 	}, {
 		.reg = PMBUS_VIRT_READ_IIN_MAX,
 		.update = true,
+		.readonly = true,
 		.attr = "highest",
 	}, {
 		.reg = PMBUS_VIRT_RESET_IIN_HISTORY,
 		.attr = "reset_history",
 	}, {
 		.reg = PMBUS_MFR_IIN_MAX,
+		.readonly = true,
 		.attr = "rated_max",
 	},
 };
@@ -1889,20 +1904,24 @@ static const struct pmbus_limit_attr iout_limit_attrs[] = {
 	}, {
 		.reg = PMBUS_VIRT_READ_IOUT_AVG,
 		.update = true,
+		.readonly = true,
 		.attr = "average",
 	}, {
 		.reg = PMBUS_VIRT_READ_IOUT_MIN,
 		.update = true,
+		.readonly = true,
 		.attr = "lowest",
 	}, {
 		.reg = PMBUS_VIRT_READ_IOUT_MAX,
 		.update = true,
+		.readonly = true,
 		.attr = "highest",
 	}, {
 		.reg = PMBUS_VIRT_RESET_IOUT_HISTORY,
 		.attr = "reset_history",
 	}, {
 		.reg = PMBUS_MFR_IOUT_MAX,
+		.readonly = true,
 		.attr = "rated_max",
 	},
 };
@@ -1943,20 +1962,24 @@ static const struct pmbus_limit_attr pin_limit_attrs[] = {
 	}, {
 		.reg = PMBUS_VIRT_READ_PIN_AVG,
 		.update = true,
+		.readonly = true,
 		.attr = "average",
 	}, {
 		.reg = PMBUS_VIRT_READ_PIN_MIN,
 		.update = true,
+		.readonly = true,
 		.attr = "input_lowest",
 	}, {
 		.reg = PMBUS_VIRT_READ_PIN_MAX,
 		.update = true,
+		.readonly = true,
 		.attr = "input_highest",
 	}, {
 		.reg = PMBUS_VIRT_RESET_PIN_HISTORY,
 		.attr = "reset_history",
 	}, {
 		.reg = PMBUS_MFR_PIN_MAX,
+		.readonly = true,
 		.attr = "rated_max",
 	},
 };
@@ -1980,20 +2003,24 @@ static const struct pmbus_limit_attr pout_limit_attrs[] = {
 	}, {
 		.reg = PMBUS_VIRT_READ_POUT_AVG,
 		.update = true,
+		.readonly = true,
 		.attr = "average",
 	}, {
 		.reg = PMBUS_VIRT_READ_POUT_MIN,
 		.update = true,
+		.readonly = true,
 		.attr = "input_lowest",
 	}, {
 		.reg = PMBUS_VIRT_READ_POUT_MAX,
 		.update = true,
+		.readonly = true,
 		.attr = "input_highest",
 	}, {
 		.reg = PMBUS_VIRT_RESET_POUT_HISTORY,
 		.attr = "reset_history",
 	}, {
 		.reg = PMBUS_MFR_POUT_MAX,
+		.readonly = true,
 		.attr = "rated_max",
 	},
 };
@@ -2049,18 +2076,22 @@ static const struct pmbus_limit_attr temp_limit_attrs[] = {
 		.sbit = PB_TEMP_OT_FAULT,
 	}, {
 		.reg = PMBUS_VIRT_READ_TEMP_MIN,
+		.readonly = true,
 		.attr = "lowest",
 	}, {
 		.reg = PMBUS_VIRT_READ_TEMP_AVG,
+		.readonly = true,
 		.attr = "average",
 	}, {
 		.reg = PMBUS_VIRT_READ_TEMP_MAX,
+		.readonly = true,
 		.attr = "highest",
 	}, {
 		.reg = PMBUS_VIRT_RESET_TEMP_HISTORY,
 		.attr = "reset_history",
 	}, {
 		.reg = PMBUS_MFR_MAX_TEMP_1,
+		.readonly = true,
 		.attr = "rated_max",
 	},
 };
@@ -2090,18 +2121,22 @@ static const struct pmbus_limit_attr temp_limit_attrs2[] = {
 		.sbit = PB_TEMP_OT_FAULT,
 	}, {
 		.reg = PMBUS_VIRT_READ_TEMP2_MIN,
+		.readonly = true,
 		.attr = "lowest",
 	}, {
 		.reg = PMBUS_VIRT_READ_TEMP2_AVG,
+		.readonly = true,
 		.attr = "average",
 	}, {
 		.reg = PMBUS_VIRT_READ_TEMP2_MAX,
+		.readonly = true,
 		.attr = "highest",
 	}, {
 		.reg = PMBUS_VIRT_RESET_TEMP2_HISTORY,
 		.attr = "reset_history",
 	}, {
 		.reg = PMBUS_MFR_MAX_TEMP_2,
+		.readonly = true,
 		.attr = "rated_max",
 	},
 };
@@ -2131,6 +2166,7 @@ static const struct pmbus_limit_attr temp_limit_attrs3[] = {
 		.sbit = PB_TEMP_OT_FAULT,
 	}, {
 		.reg = PMBUS_MFR_MAX_TEMP_3,
+		.readonly = true,
 		.attr = "rated_max",
 	},
 };
-- 
2.53.0




