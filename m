Return-Path: <stable+bounces-235862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGswHw0L3GlaLgkAu9opvQ
	(envelope-from <stable+bounces-235862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 23:13:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D50323E6133
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 23:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74F7E302D5EA
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 21:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867CD382F2F;
	Sun, 12 Apr 2026 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdbutbZf"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4C8382388
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028291; cv=none; b=YV4S0zE2k1NgLhHRYbfe6ZkNFGIT2MqBaWEoNcIfR6J7HpTPSU5eUHRICfc3XdgGH2P+sr4gpLykIwFpd7F4DI4/AnniEzpiT0id8OnUMckYH+J7P0ejLW10hE9WgDMaSrgCCdDyTudGYN0t/+o/Feo+NiFdEVlxOa8L4ME/lkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028291; c=relaxed/simple;
	bh=pN1yjE2cBEYcybWdzxunrFmw3Cw0pusN0YscySUs36g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTFlIFr3iSSUgv9hBa717Aw8Ne/TpAWVdhZP5Q0pON53JR2JFPoKDfsXrxR7QxciyxlC/zKQF71u7s/TgUojYObX01QF3ik0yO48zAQ6PZFK1Bvgi6sTB2JNh9XFAqU/tEELcKnBVQwrr+tTj7xRSuoOyEqPt7FolOSV7Q2e58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdbutbZf; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1271257ae53so11097385c88.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776028288; x=1776633088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfQOCoKB5lYfrfkkF4VJeatKmJP+97QjiuQLqo/O5Tg=;
        b=sdbutbZfRt6wBvvEx0/JmQ5ovk+7ZVU9G7pHBaCR30Cxj+DgzBZmdaqkOOo6XEoYJj
         9A94J++ClrtQzyuZpfqTT4Yi/ZDS7wm+KiGuDgHoGyK87iZf/wKv/8lpASMyQnqzG7FI
         spjYzn+W+ytbvZp4tpkc1cnJuVAgkiyIXbQ0dC0YLaftjog89IBIfWwXeI0E9QlZryua
         QrihDRjxJ+22ho8IIn0wQwmJlJROXb2tQtoWhegnG0p3InaX0Eq3kBvuLC4X3I5Tbjrm
         IUv69TaUN7W1f7YV4JZdQIGm+zHkSrmqryAlMURre27aezqXRpUSmiqXJfNOiIiAIcM2
         QITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776028288; x=1776633088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UfQOCoKB5lYfrfkkF4VJeatKmJP+97QjiuQLqo/O5Tg=;
        b=ocnoamvZ9qywPNvK7xXaFGK+GKGP3ZssPQ4o8p5BXGXBgP5mvnkklZsVrys8fWgZPi
         JZXSZU0lsRZ/1VYd0hS6+E8KFXpVfLk+/lCcg/qDzTHP8UrrzTkpBHYTgzU2IcnXtqLK
         Xhjc06qT3IQjndsaBjTQgV9e54YNLUgzt3izOx24uNBE+bN3WZleVZK6FyJ4Ql49+U+q
         LeegV96bLMXNj1yQ7VOwKPCURz7cmIeIstcLwImV/7lGgXL3s3VrsP1GdJbGIrypjzsx
         bzfhMQTGWkvaWCkKQmXyoyt4PWDlOJmvImaHK9ZOHjcXNPng8Y7WcNjKdu0oykd0i/j6
         JTmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXINvuJSc3hiuzUmLWKkMitJKTd+jIqzsuO9MZTdd9gDa79Qx6ybKeLc+SJx91X9JYXNjE7Ks4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2N1HHzvseYvFxMiav7tyG3MyaRanO6lvDuImHzgtRw1tirQzG
	+x6fbMtzYzmboWYysxjOmslyE6JZBfbERMUqmCTP8rBYBMypmEu3c5Ry
X-Gm-Gg: AeBDietHanmxq4WopBOzoCCNS10DZFobLvpmMA7VDKF/cGDPeDKK3YOUG0+k7e4tG4h
	DGeUphu9wK5RfZcfJ/+qD58ikO3JW3CJwOIfYj9FQRAnDXSh1rkbDD0/Vmfxlt4phov3/VdGaXm
	+BmkgZyZxHjXYNImb1NxN/KtawpZKG8KNuWoNUvEyoI7xC13zuoRFAVbYulx2nl+X39Thyly2Rf
	zI+QJM4ZyNgCcsCCoJvA7O1/Xs5Sn+P8CpeVADj9diSyEarG1ovfx4av66GcnQMngLnppbTlDfX
	9wxmInwUmjCM8latjWHh1eDX2+UBeX286og0MeOanhdqTPGzZqcztwdu52LyOcLFRRIk0MILWqT
	R1y/7tE/nyIHxfUahoExTKivs3GWDgPBvHnpDcy8w4Xw8YJSVe/dL4KzTqOZNCpCti+MvSHiHMd
	R0u8TFLxUxXTfnBl5K/NY3nzXJysVA4EoU4FuRkOaAKsdI6yujCp+xD1oaGG4LZbTUEesRlf6Mp
	l/b
X-Received: by 2002:a05:7022:618:b0:12a:85ef:1e50 with SMTP id a92af1059eb24-12c34e899e2mr6462352c88.12.1776028287857;
        Sun, 12 Apr 2026 14:11:27 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346fb141sm11520856c88.12.2026.04.12.14.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 14:11:27 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Rong Zhang <i@rong.moe>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v10 06/16] platform/x86: lenovo-wmi-other: Limit adding attributes to supported devices
Date: Sun, 12 Apr 2026 14:11:11 -0700
Message-ID: <20260412211121.2220556-7-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412211121.2220556-1-derekjohn.clark@gmail.com>
References: <20260412211121.2220556-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235862-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D50323E6133
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/platform/x86/lenovo/wmi-gamezone.h |   1 +
 drivers/platform/x86/lenovo/wmi-other.c    | 114 ++++++++++++++++++---
 2 files changed, 98 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.h b/drivers/platform/x86/lenovo/wmi-gamezone.h
index 6b163a5eeb95..ddb919cf6c36 100644
--- a/drivers/platform/x86/lenovo/wmi-gamezone.h
+++ b/drivers/platform/x86/lenovo/wmi-gamezone.h
@@ -10,6 +10,7 @@ enum gamezone_events_type {
 };
 
 enum thermal_mode {
+	LWMI_GZ_THERMAL_MODE_NONE =	   0x00,
 	LWMI_GZ_THERMAL_MODE_QUIET =	   0x01,
 	LWMI_GZ_THERMAL_MODE_BALANCED =	   0x02,
 	LWMI_GZ_THERMAL_MODE_PERFORMANCE = 0x03,
diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index 50a03f5fd6ab..29d062a1c6dc 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -550,6 +550,8 @@ struct tunable_attr_01 {
 	u8 feature_id;
 	u8 device_id;
 	u8 type_id;
+	u8 cd_mode_id; /* mode arg for searching capdata */
+	u8 cv_mode_id; /* mode arg for set/get current_value */
 };
 
 static struct tunable_attr_01 ppt_pl1_spl = {
@@ -775,7 +777,6 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
 	struct wmi_method_args_32 args = {};
 	struct capdata01 capdata;
 	enum thermal_mode mode;
-	u32 attribute_id;
 	u32 value;
 	int ret;
 
@@ -786,13 +787,12 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
 	if (mode != LWMI_GZ_THERMAL_MODE_CUSTOM)
 		return -EBUSY;
 
-	attribute_id =
-		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
-		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
-		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
-		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
+	args.arg0 = FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
+		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
+		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cd_mode_id) |
+		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
 
-	ret = lwmi_cd01_get_data(priv->cd01_list, attribute_id, &capdata);
+	ret = lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capdata);
 	if (ret)
 		return ret;
 
@@ -803,7 +803,10 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
 	if (value < capdata.min_value || value > capdata.max_value)
 		return -EINVAL;
 
-	args.arg0 = attribute_id;
+	args.arg0 = FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
+		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
+		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cv_mode_id) |
+		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
 	args.arg1 = value;
 
 	ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_SET,
@@ -837,7 +840,6 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
 	struct lwmi_om_priv *priv = dev_get_drvdata(tunable_attr->dev);
 	struct wmi_method_args_32 args = {};
 	enum thermal_mode mode;
-	u32 attribute_id;
 	int retval;
 	int ret;
 
@@ -845,13 +847,14 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
 	if (ret)
 		return ret;
 
-	attribute_id =
-		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
-		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
-		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
-		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
+	/* If "no-mode" is the supported mode, ensure we never send current mode */
+	if (tunable_attr->cv_mode_id == LWMI_GZ_THERMAL_MODE_NONE)
+		mode = tunable_attr->cv_mode_id;
 
-	args.arg0 = attribute_id;
+	args.arg0 = FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
+		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
+		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
+		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
 
 	ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_GET,
 				    (unsigned char *)&args, sizeof(args),
@@ -862,6 +865,81 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%d\n", retval);
 }
 
+/**
+ * lwmi_attr_01_is_supported() - Determine if the given attribute is supported.
+ * @tunable_attr: The attribute to verify.
+ *
+ * First check if the attribute has a corresponding capdata01 table in the cd01
+ * module under the "custom" mode (0xff). If that is not present then check if
+ * there is a corresponding "no-mode" (0x00) entry. If either of those passes,
+ * check capdata->supported for values > 0. If capdata is available, attempt to
+ * determine the set/get mode for the current value property using a similar
+ * pattern. If the value returned by either custom or no-mode is 0, or we get
+ * an error, we assume that mode is not supported. If any of the above checks
+ * fail then the attribute is not fully supported.
+ *
+ * The probed cd_mode_id/cv_mode_id are stored on the tunable_attr for later
+ * reference.
+ *
+ * Return: bool.
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
+	/* Determine tunable_attr->cd_mode_id*/
+	for (i = 0; i < ARRAY_SIZE(modes); i++) {
+		args.arg0 = FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
+			    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
+			    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, modes[i]) |
+			    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
+
+		ret = lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capdata);
+		if (ret || !capdata.supported)
+			continue;
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
+	/* Determine tunable_attr->cv_mode_id, returns 1 if supported*/
+	for (i = 0; i < ARRAY_SIZE(modes); i++) {
+		args.arg0 = FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
+			    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
+			    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, modes[i]) |
+			    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
+
+		ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_GET,
+					    (unsigned char *)&args, sizeof(args),
+					    &retval);
+		if (ret || !retval)
+			continue;
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
+	return capdata.supported > 0 ? true : false;
+}
+
 /* Lenovo WMI Other Mode Attribute macros */
 #define __LWMI_ATTR_RO(_func, _name)                                  \
 	{                                                             \
@@ -985,12 +1063,14 @@ static void lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
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


