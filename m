Return-Path: <stable+bounces-245003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBgfKu8JAGqaCAEAu9opvQ
	(envelope-from <stable+bounces-245003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 06:30:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A75028F0
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 06:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 521BE30827BA
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 04:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D432FD69E;
	Sun, 10 May 2026 04:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJMFxTz2"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5AF2BDC0F
	for <stable@vger.kernel.org>; Sun, 10 May 2026 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778387164; cv=none; b=rQX9C0KyzYS3upLqr1mxSGFeb8gSi+zKAbC0A7aLTAdxP+c7qtTVRcjeM+rxW1501bBR5f8LskUQfV5sy+y9t7765nYIRQ+GpehKcbtaD4bspaxaJIKDL1n+7NwKzwlJel8sig1zA2HT+zoTfPiSwXZCYWoSKTE5A3CV7RtE0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778387164; c=relaxed/simple;
	bh=wrZCEpxGJ1HrG+ZmPhbTEh8zz+vUelD8MO2uqSqDolI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSKmaxYDor0fewMiHmCnTOMg1zNT86HaFAZL0wIOlDRMtI99voTfXqMVc/tz/KHMwxFKxoUoFfScurgxsVl2nTVvHNd2RE0/uuc33/8qTWqq917xzNMMmVe9yLZFfc7SMowfUWsquZLOFPPeMX4RszyfGTd1KLutwS6TQZSF2X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJMFxTz2; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so8709200eec.1
        for <stable@vger.kernel.org>; Sat, 09 May 2026 21:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778387157; x=1778991957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMjJCm7j0mrZhLPBJddnmVOHTjp+7AQzabv6smV3XbA=;
        b=DJMFxTz2QGIAI/qxnYg1VdzC93EXAhC9Q+3oEVguYL6z/qe/QxL51h0L/5wNTUauvL
         FWlciqObmPDdj/SlOQvrMet41vyTg/+15l+VHUb3Aq0oH0gpkQ4ogw3wOXrhvJeTvTI8
         KoJRlNo87eTiwOa83hu9hA1rHs3VVbe8PSQEm88QvfKIxgG4DHt2Z+tSfFCRmYfj/nAe
         8ZWJj9vwJFftQ5TVKszdphNUB9ZjjfnYmHrhvJSbPNrLJaU2Gryd+fS1Bm9WzNmXlgrv
         wH//+2NZ54OUX2akOOewm+eHeCNT33bQ0uJKsuhXAj1J3zt1xJtZYYATXKDeqlxXx5tb
         aPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778387157; x=1778991957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iMjJCm7j0mrZhLPBJddnmVOHTjp+7AQzabv6smV3XbA=;
        b=JEAPPEwJBDKjnbvu3M//R59vk7LC9ZWpNmWCg2mF9Ixl3039tdYkh4y0AT9vCKodic
         VdNuRTR0s/eZd+TMUfz5c0DwEMKw4U3lORoUiotYuLdsZSjjYzTU1Nb7ng183lfT6Efo
         l7l0lRMN0v9CNvWzy+0TLrwqh/KGuxxsyAiHPA2MEjPxCcknlw8Tnl+zy3lRHhY5xp0m
         FHwRZ20ZjKOU8yZdS+UaweEAbGtAz0rKXcG03kTLri+114MlEAhpMMzJSpyvH5LBW0v6
         4Rws0q7UuqCgsCgaqZktT4Wm/L/slYAyMOPLm5hxKiAxGFvQGcLh0+RDy3gw/bp74LHi
         z9Kw==
X-Forwarded-Encrypted: i=1; AFNElJ8HUnGhAKd15P4yHrof7ycGc8iYRPCFgPj6u0uUWpXyC0PtSCivixD5yCe+lDt6oIp+Y/BH0Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznTeys7IU5oRQO6ii4qHZmb101Iz9M3XMuKDUaH6nDr7+qV5dw
	vrF1Eh2ah0+mUAL4wmi+OBFAUzYonGmlI109Jh63R/VlpP1lFyL2GMi3
X-Gm-Gg: Acq92OGq2/QHS39+EQzCA0wtsC0RwmFdYlOYKYClx8cEa6DSxKVE4wqHasBoCZ+aP4a
	q/BazluFoYkMPbjfXfsjXCg2v6oaFl7avQECipAXZ7Mw9SXVPh1cpYByX7SbOeWk+YBwCFJigrp
	C7+MbswcuVbblZ2AzW/3+gUBxriG6jG/GNUNbOk+4/Euqf7kREoYq78LTj/gBx3vhGq9i+QcBfX
	QIMu19RG5bIZpoEeaJdKAvly6iTBL5PCyRSX9PW4BTN00/oGjk4pqAmxZAkDXTzdXhflKZru4eh
	PITpRQmhN+JbFt4Ork4spoPbPo1FC6y6JvEQ85dtWOs7joAFTp6nKQUMIxUO8OtTJHlhcbrevMp
	INFUN4MuvvZqFmDStFegM1ztUrgez8z9Kk6p/fqCMQ8jxscCGPi3S6tlb53c2x8WigSUJ7kE0EW
	FNurOCSw/2c54dP3zg0sEDx/2msnT1riO3iZZtjt3B4n+Tu05jYX4CN7uYYIuVpEXHeIxWrcWrz
	AnwdTzvVZwlEVU=
X-Received: by 2002:a05:7301:6790:b0:2de:c5ca:c1f3 with SMTP id 5a478bee46e88-2f54ad72101mr8973026eec.4.1778387156999;
        Sat, 09 May 2026 21:25:56 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d3047sm10069960eec.10.2026.05.09.21.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 21:25:56 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Rong Zhang <i@rong.moe>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	marshall@shzj.cc,
	hyacinth@shzj.cc,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v12 09/16] platform/x86: lenovo-wmi-other: Limit adding attributes to supported devices
Date: Sun, 10 May 2026 04:25:39 +0000
Message-ID: <20260510042546.436874-10-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510042546.436874-1-derekjohn.clark@gmail.com>
References: <20260510042546.436874-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C2A75028F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,valvesoftware.com,collabora.com,shzj.cc,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245003-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,squebb.ca:email,rong.moe:email]
X-Rspamd-Action: no action

Adds lwmi_is_attr_01_supported, and only creates the attribute subfolder
if the attribute is supported by the hardware. Due to some poorly
implemented BIOS this is a multi-step sequence of events. This is
because:
- Some BIOS support getting the capability data from custom mode (0xff),
  while others only support it in no-mode (0x00).
- Some BIOS support get/set for the current value from custom mode (0xff),
  while others only support it in no-mode (0x00).
- Some BIOS report capability data for a method that is not fully
  implemented.
- Some BIOS have methods fully implemented, but no complimentary
  capability data.

To ensure we only expose fully implemented methods with corresponding
capability data, we check each outcome before reporting that an
attribute can be supported.

Checking for lwmi_is_attr_01_supported during remove is not done to
ensure that we don't attempt to call cd01 or send WMI events if one of
the interfaces being removed was the cause of the driver unloading.

Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
Reported-by: Kurt Borja <kuurtb@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/DG60P3SHXR8H.3NSEHMZ6J7XRC@gmail.com/
Cc: stable@vger.kernel.org
Reviewed-by: Rong Zhang <i@rong.moe>
Tested-by: Rong Zhang <i@rong.moe>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v12:
  - Reword lwmi_is_attr_01_supported kerneldoc text block.
  - Fix formatting in lwmi_is_attr_01_supported.
  - Use correct type cast when passing args in new funciton.
v11:
  - Also use cd_mode_id in attr_capdata_show.
v7:
  - Move earlier in the series. This required dropping the use of
    lwmi_attr_id as it will be added later.
  - Add missing switch between cd_mode_id and cv_mode_id in
    current_value_store.
v6:
  - Zero initialize args in lwmi_is_attr_01_supported.
  - Fix formatting.
v5:
  - Move cv/cd_mode_id refrences from path 3/4.
  - Add missing import for ARRAY_SIZE.
  - Make lwmi_is_attr_01_supported return bool instead of u32.
  - Various formatting fixes.
v4:
  - Use for loop instead of backtrace gotos for checking if an attribute
    is supported.
  - Add include for dev_printk.
  - Wrap dev_dbg in lwmi_is_attr_01_supported earlier.
  - Don't use symmetric cleanup of attributes in error states.
---
 drivers/platform/x86/lenovo/wmi-other.c | 92 +++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index 4da0da8459c7..e6834dec2381 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -542,6 +542,8 @@ struct tunable_attr_01 {
 	u8 feature_id;
 	u8 device_id;
 	u8 type_id;
+	u8 cd_mode_id; /* mode arg for searching capdata */
+	u8 cv_mode_id; /* mode arg for set/get current_value */
 };
 
 /**
@@ -623,7 +625,7 @@ static ssize_t attr_capdata01_show(struct kobject *kobj,
 	u32 attribute_id;
 	int value, ret;
 
-	attribute_id = tunable_attr_01_id(tunable_attr, LWMI_GZ_THERMAL_MODE_CUSTOM);
+	attribute_id = tunable_attr_01_id(tunable_attr, tunable_attr->cd_mode_id);
 
 	ret = lwmi_cd01_get_data(priv->cd01_list, attribute_id, &capdata);
 	if (ret)
@@ -688,7 +690,7 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
 	if (mode != LWMI_GZ_THERMAL_MODE_CUSTOM)
 		return -EBUSY;
 
-	args.arg0 = tunable_attr_01_id(tunable_attr, mode);
+	args.arg0 = tunable_attr_01_id(tunable_attr, tunable_attr->cd_mode_id);
 
 	ret = lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capdata);
 	if (ret)
@@ -701,6 +703,7 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
 	if (value < capdata.min_value || value > capdata.max_value)
 		return -EINVAL;
 
+	args.arg0 = tunable_attr_01_id(tunable_attr, tunable_attr->cv_mode_id);
 	args.arg1 = value;
 
 	ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_SET,
@@ -741,6 +744,10 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
 	if (ret)
 		return ret;
 
+	/* If "no-mode" is the supported mode, ensure we never send current mode */
+	if (tunable_attr->cv_mode_id == LWMI_GZ_THERMAL_MODE_NONE)
+		mode = tunable_attr->cv_mode_id;
+
 	args.arg0 = tunable_attr_01_id(tunable_attr, mode);
 
 	ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_GET,
@@ -752,6 +759,81 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%d\n", retval);
 }
 
+/**
+ * lwmi_attr_01_is_supported() - Determine if the given attribute is supported.
+ * @tunable_attr: The attribute to verify.
+ *
+ * For an attribute to be supported it must have a functional get/set method,
+ * as well as associated capability data stored in the capdata01 table.
+ *
+ * First check if the attribute has a corresponding data table under custom mode
+ * (0xff), then under no mode (0x00). If either of those passes, check if the
+ * supported field of the capdata struct is > 0. If it is supported, store the
+ * successful mode in the cd_mode_id field of tunable_attr.
+ *
+ * If the attribute capdata shows it is supported, attempt to determine the mode
+ * for the current value property get/set methods using a similar pattern to the
+ * capdata table check. If the value returned by either mode is 0 or an error,
+ * assume that mode is not supported. Otherwise, store the successful mode in the
+ * cv_mode_id field of tunable_attr.
+ *
+ * If any of the above checks fail then the attribute is not fully supported.
+ *
+ * Return: true if capdata and set/get modes are found, otherwise false.
+ */
+static bool lwmi_attr_01_is_supported(struct tunable_attr_01 *tunable_attr)
+{
+	u8 modes[2] = { LWMI_GZ_THERMAL_MODE_CUSTOM, LWMI_GZ_THERMAL_MODE_NONE };
+	struct lwmi_om_priv *priv = dev_get_drvdata(tunable_attr->dev);
+	struct wmi_method_args_32 args = {};
+	bool cd_mode_found = false;
+	bool cv_mode_found = false;
+	struct capdata01 capdata;
+	int retval, ret, i;
+
+	/* Determine tunable_attr->cd_mode_id */
+	for (i = 0; i < ARRAY_SIZE(modes); i++) {
+		args.arg0 = tunable_attr_01_id(tunable_attr, modes[i]);
+
+		ret = lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capdata);
+		if (ret || !capdata.supported)
+			continue;
+
+		tunable_attr->cd_mode_id = modes[i];
+		cd_mode_found = true;
+		break;
+	}
+
+	if (!cd_mode_found)
+		return cd_mode_found;
+
+	dev_dbg(tunable_attr->dev,
+		"cd_mode_id: %#010x\n", args.arg0);
+
+	/* Determine tunable_attr->cv_mode_id, returns 1 if supported */
+	for (i = 0; i < ARRAY_SIZE(modes); i++) {
+		args.arg0 = tunable_attr_01_id(tunable_attr, modes[i]);
+
+		ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_GET,
+					    (u8 *)&args, sizeof(args),
+					    &retval);
+		if (ret || !retval)
+			continue;
+
+		tunable_attr->cv_mode_id = modes[i];
+		cv_mode_found = true;
+		break;
+	}
+
+	if (!cv_mode_found)
+		return cv_mode_found;
+
+	dev_dbg(tunable_attr->dev, "cv_mode_id: %#010x, attribute support level: %#010x\n",
+		args.arg0, capdata.supported);
+
+	return capdata.supported > 0;
+}
+
 /* Lenovo WMI Other Mode Attribute macros */
 #define __LWMI_ATTR_RO(_func, _name)                                  \
 	{                                                             \
@@ -875,12 +957,14 @@ static void lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(cd01_attr_groups) - 1; i++) {
+		cd01_attr_groups[i].tunable_attr->dev = &priv->wdev->dev;
+		if (!lwmi_attr_01_is_supported(cd01_attr_groups[i].tunable_attr))
+			continue;
+
 		err = sysfs_create_group(&priv->fw_attr_kset->kobj,
 					 cd01_attr_groups[i].attr_group);
 		if (err)
 			goto err_remove_groups;
-
-		cd01_attr_groups[i].tunable_attr->dev = &priv->wdev->dev;
 	}
 	return;
 
-- 
2.53.0


