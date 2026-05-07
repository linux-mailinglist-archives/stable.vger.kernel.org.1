Return-Path: <stable+bounces-244624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DUoFgfV/GlvUQAAu9opvQ
	(envelope-from <stable+bounces-244624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:08:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E7A4ED34A
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FAAC3086BF6
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925C847CC82;
	Thu,  7 May 2026 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfkSCGxd"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D90B47799B
	for <stable@vger.kernel.org>; Thu,  7 May 2026 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177132; cv=none; b=DcZVkhZHJkc6H4icBZGCAq/I2kAaUBEau96w+sJzzqwAp7wWZxNsXgtvQl9mzZl0asOIfPjoMSHyGBnxdWo3YVME21gIo0MbZuQ4Sw8c0uZPQBeChsPQJXXBz4TeRuKjMJM1juP5RcGozjoeEEu6tdHPxyTa1txE3QQ4dF588BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177132; c=relaxed/simple;
	bh=mL0lfOE4yxLtgQ2PyR8gJywj7w+29I6o0b2ySuB469Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDAzCEtlI3Ee4Bgf+Ge/tdwCaR6TQUWbn+lmyv1VzRAYEUoPRZg18xqrEZHN0V4BprM+k9VBFFOqvAdjpkDYM6djk2bJPvcP97Q9ox3dMBKRi9FLkGz5hrednSV+7chfAAlcLZsx4oigF8cO/YlzZ4NkUUfq2n1LNc1oZBGND2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfkSCGxd; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1309f4ee973so1473072c88.1
        for <stable@vger.kernel.org>; Thu, 07 May 2026 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778177129; x=1778781929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Od3MhystolTIKvbXiIb2J0gYt1F0SGwMJxdYrNhmx3E=;
        b=UfkSCGxdcLhWnqMTiH6xI+i+RAihOVEAJbLFfZngbTqQGKUPLLvbjRrSszCsvTpEPl
         1tSJkAwl3UzW1FOJLt/HDHodFW6n+69t+B/iuBwiCThI/N/Rsa9ySDDPavP1rCMoYwee
         WRtHUtIjlpQDSec/ZyBr5JhA5g2qQ/jR7KdNq2Kd2qYanUrNCVkSW4JcA2cm9U47hYg4
         ZZu3wn/3yOXr42ktrJw7pPBW9Rds6sJsGTb8TPk5SJ2oxsrDZ15Lo8ulccdgVcbQuChX
         +4dgfW1MgXUbPoifjC8qbQpAT7hssiohcyb09qEbE6t4aHnEg9LWcelfyRotmdQSP4N7
         Cs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778177129; x=1778781929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Od3MhystolTIKvbXiIb2J0gYt1F0SGwMJxdYrNhmx3E=;
        b=A7F9G7GbZRfzJjskjY4Q1rhnHStIkoa9nRQ7AclKSOKOUhohPWjeeBunjjDI8voDLW
         LFBaReLTKFEftptg1eSiGRsJEh5t+vhuJUrJOH3vuVhfThVrCJh9dc72g+q61zlJPMFf
         ztFWBXgRDE7o/WNRxZlG4bE62JNdnGcBXZkCP+xVZxpBF/DTk6V+MIz9r7LXlffcnJ6h
         ggIpeZRNwWslZPqBKuOy2GqB80XRKaYHsUVnnCUxTSwOsXvRHTA+WH6Xd2HoO3L8cvCe
         uGBiEnQPZgzjKott/LZ1rlD5L+fY5Im+OnHiNkz5f40VDo8Ly5T1Es+YayzzvV0H1vxH
         0+oQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CJgx2YehQigE2NoKJkpVA0l6bILSRJXMaHTf2nFxHGHpxdnE2OW1ZjzIYwlN8dd7E118K/Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXIvk7WNVgPmj0A2htUyWT45CLqXvMXOfuhlapDtQZDdguX8HB
	fEeVBzATV6OihDe6MGx8jASXxeSiNHVer4jPPaO8Bo/gautocNQLnlnT
X-Gm-Gg: AeBDietCL7NTd4RyzIqI46764/cwwsYXviy19RvhGBR8yGvSwhIvfKJj4Pfpy1cf472
	qSDV1a5kiIRVA0VYMOggwstVypr+5TK4VfdF/+ddlgOCCfH0OVV9i9kh1lJw0HKbbuNls56oh+S
	6lRFtWjtROjDGU8rd9bhj4dBh+IlK1yme8253bFq3KpeuAFlOshIVXsJW0H48mmvIkM9cJH1rrR
	+rboaX84PYSNrfTOchBYbZ52x6qrGTOW5skTIPYIBKDRXgg3mR1HjpmkAlMKnvCFuoH1H/83QEl
	dNa9n7CGGXc84Z24dGyv/jykRHwwFWLFJokCQvhgFTc5r/iE3b9o6MGNAwqamlEd6LQQkQ1bV/U
	2qT5WCOCS8tOAHymIDumPgqxrlQieOEy2vvlTOcWsaibP7bKLm+JUSz2bTgBLChAz9hQ1khqEq2
	1Dd6iGiU2m78n2aAUifBXsNhfH5ET+ZnFTLPStN24ZvfVCX1fqD18tnZioWCDBG9KMdtsLp7Mca
	VJW
X-Received: by 2002:a05:7022:6609:b0:128:d24a:a5ba with SMTP id a92af1059eb24-1318e7f76f2mr4281285c88.20.1778177127896;
        Thu, 07 May 2026 11:05:27 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f82bd73a64sm44332eec.12.2026.05.07.11.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:05:27 -0700 (PDT)
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
Subject: [PATCH v11 08/15] platform/x86: lenovo-wmi-other: Add lwmi_attr_id() function
Date: Thu,  7 May 2026 18:05:00 +0000
Message-ID: <20260507180507.912966-9-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507180507.912966-1-derekjohn.clark@gmail.com>
References: <20260507180507.912966-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 17E7A4ED34A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,valvesoftware.com,collabora.com,shzj.cc,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244624-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[squebb.ca:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rong.moe:email]
X-Rspamd-Action: no action

Adds lwmi_attr_id() function. In the same vein as LWMI_ATTR_ID_FAN_RPM(),
but as a generic, to de-duplicate attribute_id assignment biolerplate.

Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
Cc: stable@vger.kernel.org
Reviewed-by: Rong Zhang <i@rong.moe>
Tested-by: Rong Zhang <i@rong.moe>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v11:
  - Move to earlier in the series to clean up later patches that can
    use it.
  - Add helper function that takes a tunable_attr_01 instead of breaking
    out all struct members manually each time the macro is used.
v9:
  - Fix dropped use of mode variable in current_value_show.
v7:
  - Incorporate additional replacements in lwmi_attr_01_is_supported
    after moving the patch that adds it to earlier in the series.
v6:
  - Move lwmi_attr_id to wmi-capdata.h as static inline.
v5:
  - Move references to cv/cd_mode_id to patch 4/8.
  - Move lwmi_attr_id to wmi-capdata.c and export with namespace.
v4:
  - Switch from macro to static inline to preserve types.
---
 drivers/platform/x86/lenovo/wmi-capdata.c |  8 ++--
 drivers/platform/x86/lenovo/wmi-capdata.h | 20 +++++++++
 drivers/platform/x86/lenovo/wmi-other.c   | 49 +++++++++--------------
 3 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-capdata.c b/drivers/platform/x86/lenovo/wmi-capdata.c
index ee1fb02d8e31..169665be4dcf 100644
--- a/drivers/platform/x86/lenovo/wmi-capdata.c
+++ b/drivers/platform/x86/lenovo/wmi-capdata.c
@@ -27,7 +27,6 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/acpi.h>
-#include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/cleanup.h>
 #include <linux/component.h>
@@ -48,6 +47,7 @@
 #include <linux/wmi.h>
 
 #include "wmi-capdata.h"
+#include "wmi-helpers.h"
 
 #define LENOVO_CAPABILITY_DATA_00_GUID "362A3AFE-3D96-4665-8530-96DAD5BB300E"
 #define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE018154"
@@ -58,9 +58,9 @@
 
 #define LWMI_FEATURE_ID_FAN_TEST 0x05
 
-#define LWMI_ATTR_ID_FAN_TEST							\
-	(FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, LWMI_DEVICE_ID_FAN) |		\
-	 FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, LWMI_FEATURE_ID_FAN_TEST))
+#define LWMI_ATTR_ID_FAN_TEST                                      \
+	lwmi_attr_id(LWMI_DEVICE_ID_FAN, LWMI_FEATURE_ID_FAN_TEST, \
+		     LWMI_GZ_THERMAL_MODE_NONE, LWMI_TYPE_ID_NONE)
 
 enum lwmi_cd_type {
 	LENOVO_CAPABILITY_DATA_00,
diff --git a/drivers/platform/x86/lenovo/wmi-capdata.h b/drivers/platform/x86/lenovo/wmi-capdata.h
index 8c1df3efcc55..1388eaf4ab4a 100644
--- a/drivers/platform/x86/lenovo/wmi-capdata.h
+++ b/drivers/platform/x86/lenovo/wmi-capdata.h
@@ -6,6 +6,7 @@
 #define _LENOVO_WMI_CAPDATA_H_
 
 #include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <linux/types.h>
 
 #define LWMI_SUPP_VALID		BIT(0)
@@ -19,6 +20,8 @@
 
 #define LWMI_DEVICE_ID_FAN	0x04
 
+#define LWMI_TYPE_ID_NONE 0x00
+
 struct component_match;
 struct device;
 struct cd_list;
@@ -57,6 +60,23 @@ struct lwmi_cd_binder {
 	cd_list_cb_t cd_fan_list_cb;
 };
 
+/**
+ * lwmi_attr_id() - Formats a capability data attribute ID
+ * @dev_id: The u8 corresponding to the device ID.
+ * @feat_id: The u8 corresponding to the feature ID on the device.
+ * @mode_id: The u8 corresponding to the wmi-gamezone mode for set/get.
+ * @type_id: The u8 corresponding to the sub-device.
+ *
+ * Return: u32.
+ */
+static inline u32 lwmi_attr_id(u8 dev_id, u8 feat_id, u8 mode_id, u8 type_id)
+{
+	return (FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, dev_id)   |
+		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, feat_id) |
+		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode_id) |
+		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, type_id));
+}
+
 void lwmi_cd_match_add_all(struct device *master, struct component_match **matchptr);
 int lwmi_cd00_get_data(struct cd_list *list, u32 attribute_id, struct capdata00 *output);
 int lwmi_cd01_get_data(struct cd_list *list, u32 attribute_id, struct capdata01 *output);
diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index b4ed7af50a24..e69bea72e6d3 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -59,8 +59,6 @@
 
 #define LWMI_FEATURE_ID_FAN_RPM 0x03
 
-#define LWMI_TYPE_ID_NONE 0x00
-
 #define LWMI_FEATURE_VALUE_GET 17
 #define LWMI_FEATURE_VALUE_SET 18
 
@@ -68,13 +66,12 @@
 #define LWMI_FAN_NR 4
 #define LWMI_FAN_ID(x) ((x) + LWMI_FAN_ID_BASE)
 
-#define LWMI_ATTR_ID_FAN_RPM(x)						\
-	(FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, LWMI_DEVICE_ID_FAN) |	\
-	 FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, LWMI_FEATURE_ID_FAN_RPM) |	\
-	 FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, LWMI_FAN_ID(x)))
-
 #define LWMI_FAN_DIV 100
 
+#define LWMI_ATTR_ID_FAN_RPM(x)                                   \
+	lwmi_attr_id(LWMI_DEVICE_ID_FAN, LWMI_FEATURE_ID_FAN_RPM, \
+		     LWMI_GZ_THERMAL_MODE_NONE, LWMI_FAN_ID(x))
+
 #define LWMI_OM_FW_ATTR_BASE_PATH "lenovo-wmi-other"
 #define LWMI_OM_HWMON_NAME "lenovo_wmi_other"
 
@@ -547,6 +544,18 @@ struct tunable_attr_01 {
 	u8 type_id;
 };
 
+/**
+ * tunable_attr_01_id() - Formats a tunable_attr_01 to a capdata attribute ID
+ * @attr: The tunable_attr_01 to format.
+ * @mode: The u8 corresponding to the wmi-gamezone mode for set/get.
+ *
+ * Return: u32.
+ */
+static u32 tunable_attr_01_id(struct tunable_attr_01 *attr, u8 mode)
+{
+	return lwmi_attr_id(attr->device_id, attr->feature_id, mode, attr->type_id);
+}
+
 static struct tunable_attr_01 ppt_pl1_spl = {
 	.device_id = LWMI_DEVICE_ID_CPU,
 	.feature_id = LWMI_FEATURE_ID_CPU_SPL,
@@ -614,12 +623,7 @@ static ssize_t attr_capdata01_show(struct kobject *kobj,
 	u32 attribute_id;
 	int value, ret;
 
-	attribute_id =
-		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
-		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
-		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK,
-			   LWMI_GZ_THERMAL_MODE_CUSTOM) |
-		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
+	attribute_id = tunable_attr_01_id(tunable_attr, LWMI_GZ_THERMAL_MODE_CUSTOM);
 
 	ret = lwmi_cd01_get_data(priv->cd01_list, attribute_id, &capdata);
 	if (ret)
@@ -674,7 +678,6 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
 	struct wmi_method_args_32 args = {};
 	struct capdata01 capdata;
 	enum thermal_mode mode;
-	u32 attribute_id;
 	u32 value;
 	int ret;
 
@@ -685,13 +688,9 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
 	if (mode != LWMI_GZ_THERMAL_MODE_CUSTOM)
 		return -EBUSY;
 
-	attribute_id =
-		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
-		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
-		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
-		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
+	args.arg0 = tunable_attr_01_id(tunable_attr, mode);
 
-	ret = lwmi_cd01_get_data(priv->cd01_list, attribute_id, &capdata);
+	ret = lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capdata);
 	if (ret)
 		return ret;
 
@@ -702,7 +701,6 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
 	if (value < capdata.min_value || value > capdata.max_value)
 		return -EINVAL;
 
-	args.arg0 = attribute_id;
 	args.arg1 = value;
 
 	ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_SET,
@@ -736,7 +734,6 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
 	struct lwmi_om_priv *priv = dev_get_drvdata(tunable_attr->dev);
 	struct wmi_method_args_32 args = {};
 	enum thermal_mode mode;
-	u32 attribute_id;
 	int retval;
 	int ret;
 
@@ -744,13 +741,7 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
 	if (ret)
 		return ret;
 
-	attribute_id =
-		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
-		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
-		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
-		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
-
-	args.arg0 = attribute_id;
+	args.arg0 = tunable_attr_01_id(tunable_attr, mode);
 
 	ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_GET,
 				    (unsigned char *)&args, sizeof(args),
-- 
2.53.0


