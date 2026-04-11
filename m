Return-Path: <stable+bounces-235745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMoOLUd22mn82ggAu9opvQ
	(envelope-from <stable+bounces-235745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:26:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 272383E0D38
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B173B3076A35
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 16:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D51E3BBA1D;
	Sat, 11 Apr 2026 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5kHNkmS"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A94C3B9D8F
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775924625; cv=none; b=sRjAX4nxoJs4Lwkfo5bKOtd1OgSTCgS/ozLr/cqRKHVVT+X22IaO+YC+2GXDwAM11zCdsEwqSaYYjt0yY98YRGJhcIrRMy0Ymu2pOETO+Dwxj5j9hlKi+jHnDqCVW9JsQNCYB7QCIE33iu8rKgjyBJw4OhoANXqZ3N2jD44b6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775924625; c=relaxed/simple;
	bh=pN1yjE2cBEYcybWdzxunrFmw3Cw0pusN0YscySUs36g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IF+tlb8zZyNVJfaDnY1uQMlo801FSRoINEde4IyIT7+O/0ajZLH8fQKvn4BWFqOv+veUOjxlriKyL9FbTZBf4gaaIpTcBp7orXLcp/z+54RHdvlfiUsemupg89ytwx+/7qv9MBPyCTSZzJMpxlyy3OXEZYnysViKJwYyCn2D7k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5kHNkmS; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c156c4a9efso4348218eec.1
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775924622; x=1776529422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfQOCoKB5lYfrfkkF4VJeatKmJP+97QjiuQLqo/O5Tg=;
        b=W5kHNkmSCRdiNC1LshvXdYtXanDI1omc7TQCPN+eDUq4lqR+0JU/5rYKxhvk1B1f1x
         y+jaiNsO6hhfG6n4TQsS0Ug6ybVcILHeIFNlnNioGWR0Ymm3Gk7hO0mYcBq3Bjz4QcgL
         9R5eI1YGa/Om860sjW4aFzv+vxzGTMm81yy0JzXJ8JJXt2PRJjNoXiJsGV3AfhoGvu84
         uy2kuZjZsFxFqcn/xnUp+uYgs1qEMnDoC/Fptd+xy1g9PnnBhIFIxSwk+4+23+5gYBYG
         Dmdx7X1Y8bWu/QYWyZ7BaIQOGz2CU1D/5lP/GEO/QI0z+KbA9LVUxhaj+8NWhJUq2MXP
         6Bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775924622; x=1776529422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UfQOCoKB5lYfrfkkF4VJeatKmJP+97QjiuQLqo/O5Tg=;
        b=KnP8xJhYEFuTCFYgqhCCfi7r1w9dOm96k5Mv5YLE/OB5UVpXz3NGJjGVW/j+fCGekQ
         k3I2VvOpNs8Ia2kxDZSCo7Zh60qct0heBwbW5ErDqjGZ93OJ0ifLVLHjDmEHGyOEtsQv
         moadB9SsOagtffWFilp+RhZ7MVtOYH89G7he9Zp+6BCd83X8uVxQIui+JfWI/TVL+zIJ
         ff4nqY9tqoYzSCTxuf8nE90K/QKz7xXERRKjmw5F+fwJPigRHKyrvKp+OK/LlKHta8pF
         gloi6hZhK8c/ZqGb39nQWJTiwLQOuoG45G5RQOm+4PcmHQ9OYaJRN0F1d9yD6sqx4BGy
         sV2A==
X-Forwarded-Encrypted: i=1; AJvYcCXBnUt968EMSB2hIV1xCnDOtm6/0oS05ZdDrSnJfrOoOiPNaZeuN+5p2tIhp04KBcRuUSsmenQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtrCvyU9UY/DGJ6ZRqCE9zVW9IQ1ETeIunUd29RN7nWq/aZ6j3
	n9quVXAG10B3p/chFeK8npVUYwaSWSXOYUbmUFAPpBMucvpT3lNn/9EN
X-Gm-Gg: AeBDiesBmeSxB5PMEfxJZmEW4NdCD2G1xrbTIfzWj9QSKZlYB5f+wu5HKkiEmVtYuJX
	2U+xKcFu7ICtACGYsU5TPXIf+Byzi7y3iFGfKxr3rp4H12kBT/AuNY08Sov/xBtVkwTSJkt2/9U
	noh142W8QMEidJ+5/xSQ3ejK9dRlzDA+VksPSlYlM7gEW+P+ImR4GIZbATmDTEc0KBHLd6bRmeC
	iVKVWKOSteYKphA+6KGWTeJ+mvbyRv3EkcmVFfxobq70vyMjtdbknEGgirpU5+bPeRPo0Q7e31X
	w/u2ueHPLK72OLn8UNvnSkJM23qfgoy+C6WvkSGxRSb/ZFXWx6Xxi1U2irEcdqjuMSE6+5Sa3xU
	1C3SWaz9P5ikpqtjKKhWxM57fqyT4ep4cr9DUT7jAidQJRcV4SKNstizA9rqWb8INqyr6RuM+Fc
	sc1WVd76t3iskKGie+dcfDmpfPlzm1S+D6vplHbmxDECzhq/Jai1zzyRLT+Nd/lSz0APrC80srg
	vFA
X-Received: by 2002:a05:7301:1f14:b0:2c6:2bac:8a8 with SMTP id 5a478bee46e88-2d589cb572dmr3858365eec.30.1775924622242;
        Sat, 11 Apr 2026 09:23:42 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55ce46a65sm9358907eec.0.2026.04.11.09.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 09:23:42 -0700 (PDT)
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
Subject: [PATCH v9 06/16] platform/x86: lenovo-wmi-other: Limit adding attributes to supported devices
Date: Sat, 11 Apr 2026 16:23:24 +0000
Message-ID: <20260411162334.25682-7-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411162334.25682-1-derekjohn.clark@gmail.com>
References: <20260411162334.25682-1-derekjohn.clark@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-235745-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,squebb.ca:email,rong.moe:email]
X-Rspamd-Queue-Id: 272383E0D38
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


