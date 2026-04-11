Return-Path: <stable+bounces-235746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O+AJXV22mn82ggAu9opvQ
	(envelope-from <stable+bounces-235746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:27:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE883E0D6B
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 672E73086699
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35643BE175;
	Sat, 11 Apr 2026 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/r4K5TT"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B513BA22C
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775924626; cv=none; b=qOcH883upOAhdFDg/qTwMMhcehg1N04oJolNMe0JX5fz7VfAJYS8JeYlt1vIeV3dpU0aO/wUsPaIPqwyHv+b1EJWwWOGT0UrsOLFajcpxVpXV860SJcUbIqIEaLUh6wacQJZqxIvTK++DlC7jG1AQB/1ygpVNPUIcQFWc+3cOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775924626; c=relaxed/simple;
	bh=epNgEAbOTwBUpTsXkpBr5phpz7PYDoqt1DNdf166hR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4+ooxHy5UYkj3Zes8oo8uemqbavO6bJcHfcsqFe05itEpawgEWFaTP7xdIwNrW39pbPIO3LCChZTChlg8Uh4wL5oL4W8JqrCEg6XQSc6yKIrfEEVLYVXm7mIqsCibWm8SAXWADg8rSvuO+0iWsG736kRNc9VZmCbKtp48FesZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/r4K5TT; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c156c4a9efso4348230eec.1
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775924623; x=1776529423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAm4Rg/AfX4n6gnjxAUnQ2wLvvjZ9qBHkok/vFSlFKY=;
        b=T/r4K5TTz3g4EQvZEtsLKqf14niltGQHeHfZO0JL/wJOK/YdtDVkA56gTHMtA6AtZB
         5e/tXUvE74+B/GVBFIfsmRM1Tv8n5lUPoWo4X6G9wLiOvleA7cdkSgaZOID1h2QHHXcG
         tmnTpWcJuwChL/CnwDMRVr/Zt/+zPuDX3NYPohLb2eba0EjL37TPYL8ao4dj68eStx68
         XSE2hLR3qv6gNutYi0wk3rH2wRrVqWnKTEL35AMh/SxIY1f6X59toNVVxRaNiNu+DrKJ
         K89swm4j2dbajcwIEQKgFMSvQ3kvqCYJr6k/Wqcz/gd81j0+rY7yDZlsb0ZoO1QWdHZa
         uICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775924623; x=1776529423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EAm4Rg/AfX4n6gnjxAUnQ2wLvvjZ9qBHkok/vFSlFKY=;
        b=Rklpd2q5b+RBuW0fsGtTtPdKmhuBwIyVnUHFpHSzws355NJ18w4XcnsTFmzBulvGWr
         uB0vSbOEkiTYNMigTj6sG0jyk7pGA70JU64kmWn9Nxo7WHt1MAxveksXkfls9Poi9WKq
         bWliHsYCVS4aiRzYgMslUe1v+csUQJmf41oHDMe1+PoEwCoNC3U7pyknBW+GW5O+9Rk5
         zvpZFAzqvqrp4DSH61OPTa3Ec+1W5spbbs8dkNMLt5aGhd2qA8vKOCB8ejDC9/N6iAyQ
         PXupI/WN9I2Thz2N5ipKskXiCPzQ/5yLTCrzjNTYCg07YyvBHjwaJuboBEsNK7Rf6hU9
         U/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXbtBH/c4Be6LxtT4mHuQRkcxy1Ht0tuZtTdRPdA2lshWIAIHGh99nnApOaJytkNEM3L7/t+pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGJUKx1BA92hSb0Sa/6m/sERNndiTYheeGnsiHR9pjlrfAt7x
	5qDcsLSXhRraQOJ8aXxzQi939+CaAO3e4JpYLbRLR+c1MlAhfI1mP5zA
X-Gm-Gg: AeBDiesvcq2Bi58H18P7Xs4RxHHsbVz0SfhegFdGSqlqNQ0FThCKlzPUEx95452O9XE
	wVeZQLKb+epljleSeLXMLYd7EnUVDBzDG9+EWqv+x7rEIh1/GrRR0ddiOa60aT0DbOrF7P/LCIS
	rUqQlfcpGvLmwDb5FPdu6rcAQ0fXwtBPh3rFRaIvF3MTiZUZz2L6NXOTDc1h1O7kmDug9H9G9oA
	v3q05EisQjxw7ibX81GelrndnsgeVRN6/Ih4lqDvYHYYpmKt/qyx4Ca+OprABA3goevsLd2MYRs
	t2FMD1s13yKDZMCYB15o9SpxwxRQGLQswuJymJMBnOHJ1EFnmj3ePbrhL0wjq/fV7gstlqICpZe
	SvYT3TPdZA9ibIL+VA8ioPe4Gbni46QM5Uey6mp/a5e0fF+szsAjYwwxgpxGqzRXEFsHEDMiOnA
	QruzvBwApmyn5a+mSFcI4MbV/gQP0mlYN2+Uw1K/JuKsRPSrWkfTkvn3wAdB/0Qqf45X+cleMfd
	PUrAo5nDgJ1xEg=
X-Received: by 2002:a05:7301:6086:b0:2c3:9406:d574 with SMTP id 5a478bee46e88-2d5870bb7eamr4393011eec.4.1775924622938;
        Sat, 11 Apr 2026 09:23:42 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55ce46a65sm9358907eec.0.2026.04.11.09.23.42
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
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v9 07/16] platform/x86: lenovo: Decouple lenovo-wmi-gamezone and lenovo-wmi-other
Date: Sat, 11 Apr 2026 16:23:25 +0000
Message-ID: <20260411162334.25682-8-derekjohn.clark@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org,intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235746-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,squebb.ca:email,rong.moe:email,intel.com:email]
X-Rspamd-Queue-Id: 3EE883E0D6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rong Zhang <i@rong.moe>

Currently, lenovo-wmi-gamezone depends on lenovo-wmi-other as the former
imports symbols from the latter. The imported symbols are just used to
register a notifier block. However, there is no runtime dependency
between both drivers, and either of them can run without the other,
which is the major purpose of using the notifier framework.

Such a link-time dependency is non-optimal. A previous attempt to "fix"
it made LENOVO_WMI_GAMEZONE select LENOVO_WMI_TUNING, which was
fundamentally broken and resulted in undefined Kconfig behavior, as
`select' cannot be used on a symbol with potentially unmet dependencies.

Decouple both drivers by moving the thermal mode notifier chain to
lenovo-wmi-helpers. Methods for notifier block (un)registration are
exported for lenovo-wmi-gamezone, while a method for querying the
current thermal mode are exported for lenovo-wmi-other.

This turns the dependency graph from

            +------------ lenovo-wmi-gamezone
            |                     |
            v                     |
    lenovo-wmi-helpers            |
            ^                     |
            |                     V
            +------------ lenovo-wmi-other

into

            +------------ lenovo-wmi-gamezone
            |
            v
    lenovo-wmi-helpers
            ^
            |
            +------------ lenovo-wmi-other

To make it clear, the name of the notifier chain is also renamed from
`om_chain_head' to `tm_chain_head', indicating that it's used to query
the current thermal mode.

No functional change intended.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Fixes: 6e38b9fcbfa3 ("platform/x86: lenovo: gamezone needs "other mode"")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603252259.gHvJDyh3-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202603260302.X0NjQOda-lkp@intel.com/
Signed-off-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/platform/x86/lenovo/Kconfig        |   1 -
 drivers/platform/x86/lenovo/wmi-gamezone.c |   4 +-
 drivers/platform/x86/lenovo/wmi-helpers.c  | 101 ++++++++++++++++++++
 drivers/platform/x86/lenovo/wmi-helpers.h  |   8 ++
 drivers/platform/x86/lenovo/wmi-other.c    | 104 +--------------------
 drivers/platform/x86/lenovo/wmi-other.h    |  16 ----
 6 files changed, 112 insertions(+), 122 deletions(-)
 delete mode 100644 drivers/platform/x86/lenovo/wmi-other.h

diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x86/lenovo/Kconfig
index f885127b007f..09b1b055d2e0 100644
--- a/drivers/platform/x86/lenovo/Kconfig
+++ b/drivers/platform/x86/lenovo/Kconfig
@@ -252,7 +252,6 @@ config LENOVO_WMI_GAMEZONE
 	select ACPI_PLATFORM_PROFILE
 	select LENOVO_WMI_EVENTS
 	select LENOVO_WMI_HELPERS
-	select LENOVO_WMI_TUNING
 	help
 	  Say Y here if you have a WMI aware Lenovo Legion device and would like to use the
 	  platform-profile firmware interface to manage power usage.
diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platform/x86/lenovo/wmi-gamezone.c
index ca559e6c031d..a91089694727 100644
--- a/drivers/platform/x86/lenovo/wmi-gamezone.c
+++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
@@ -23,7 +23,6 @@
 #include "wmi-events.h"
 #include "wmi-gamezone.h"
 #include "wmi-helpers.h"
-#include "wmi-other.h"
 
 #define LENOVO_GAMEZONE_GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
 
@@ -385,7 +384,7 @@ static int lwmi_gz_probe(struct wmi_device *wdev, const void *context)
 		return ret;
 
 	priv->mode_nb.notifier_call = lwmi_gz_mode_call;
-	return devm_lwmi_om_register_notifier(&wdev->dev, &priv->mode_nb);
+	return devm_lwmi_tm_register_notifier(&wdev->dev, &priv->mode_nb);
 }
 
 static const struct wmi_device_id lwmi_gz_id_table[] = {
@@ -407,7 +406,6 @@ module_wmi_driver(lwmi_gz_driver);
 
 MODULE_IMPORT_NS("LENOVO_WMI_EVENTS");
 MODULE_IMPORT_NS("LENOVO_WMI_HELPERS");
-MODULE_IMPORT_NS("LENOVO_WMI_OTHER");
 MODULE_DEVICE_TABLE(wmi, lwmi_gz_id_table);
 MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
 MODULE_DESCRIPTION("Lenovo GameZone WMI Driver");
diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/platform/x86/lenovo/wmi-helpers.c
index 018d7642e2bd..7a198259e393 100644
--- a/drivers/platform/x86/lenovo/wmi-helpers.c
+++ b/drivers/platform/x86/lenovo/wmi-helpers.c
@@ -21,11 +21,15 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/unaligned.h>
 #include <linux/wmi.h>
 
 #include "wmi-helpers.h"
 
+/* Thermal mode notifier chain. */
+static BLOCKING_NOTIFIER_HEAD(tm_chain_head);
+
 /**
  * lwmi_dev_evaluate_int() - Helper function for calling WMI methods that
  * return an integer.
@@ -84,6 +88,103 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
 };
 EXPORT_SYMBOL_NS_GPL(lwmi_dev_evaluate_int, "LENOVO_WMI_HELPERS");
 
+/**
+ * lwmi_tm_register_notifier() - Add a notifier to the blocking notifier chain
+ * @nb: The notifier_block struct to register
+ *
+ * Call blocking_notifier_chain_register to register the notifier block to the
+ * thermal mode notifier chain.
+ *
+ * Return: 0 on success, %-EEXIST on error.
+ */
+int lwmi_tm_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&tm_chain_head, nb);
+}
+EXPORT_SYMBOL_NS_GPL(lwmi_tm_register_notifier, "LENOVO_WMI_HELPERS");
+
+/**
+ * lwmi_tm_unregister_notifier() - Remove a notifier from the blocking notifier
+ * chain.
+ * @nb: The notifier_block struct to register
+ *
+ * Call blocking_notifier_chain_unregister to unregister the notifier block from the
+ * thermal mode notifier chain.
+ *
+ * Return: 0 on success, %-ENOENT on error.
+ */
+int lwmi_tm_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&tm_chain_head, nb);
+}
+EXPORT_SYMBOL_NS_GPL(lwmi_tm_unregister_notifier, "LENOVO_WMI_HELPERS");
+
+/**
+ * devm_lwmi_tm_unregister_notifier() - Remove a notifier from the blocking
+ * notifier chain.
+ * @data: Void pointer to the notifier_block struct to register.
+ *
+ * Call lwmi_tm_unregister_notifier to unregister the notifier block from the
+ * thermal mode notifier chain.
+ *
+ * Return: 0 on success, %-ENOENT on error.
+ */
+static void devm_lwmi_tm_unregister_notifier(void *data)
+{
+	struct notifier_block *nb = data;
+
+	lwmi_tm_unregister_notifier(nb);
+}
+
+/**
+ * devm_lwmi_tm_register_notifier() - Add a notifier to the blocking notifier
+ * chain.
+ * @dev: The parent device of the notifier_block struct.
+ * @nb: The notifier_block struct to register
+ *
+ * Call lwmi_tm_register_notifier to register the notifier block to the
+ * thermal mode notifier chain. Then add devm_lwmi_tm_unregister_notifier
+ * as a device managed action to automatically unregister the notifier block
+ * upon parent device removal.
+ *
+ * Return: 0 on success, or an error code.
+ */
+int devm_lwmi_tm_register_notifier(struct device *dev,
+				   struct notifier_block *nb)
+{
+	int ret;
+
+	ret = lwmi_tm_register_notifier(nb);
+	if (ret < 0)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_lwmi_tm_unregister_notifier,
+					nb);
+}
+EXPORT_SYMBOL_NS_GPL(devm_lwmi_tm_register_notifier, "LENOVO_WMI_HELPERS");
+
+/**
+ * lwmi_tm_notifier_call() - Call functions for the notifier call chain.
+ * @mode: Pointer to a thermal mode enum to retrieve the data from.
+ *
+ * Call blocking_notifier_call_chain to retrieve the thermal mode from the
+ * lenovo-wmi-gamezone driver.
+ *
+ * Return: 0 on success, or an error code.
+ */
+int lwmi_tm_notifier_call(enum thermal_mode *mode)
+{
+	int ret;
+
+	ret = blocking_notifier_call_chain(&tm_chain_head,
+					   LWMI_GZ_GET_THERMAL_MODE, &mode);
+	if ((ret & ~NOTIFY_STOP_MASK) != NOTIFY_OK)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(lwmi_tm_notifier_call, "LENOVO_WMI_HELPERS");
+
 MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
 MODULE_DESCRIPTION("Lenovo WMI Helpers Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/lenovo/wmi-helpers.h b/drivers/platform/x86/lenovo/wmi-helpers.h
index 20fd21749803..651a039228ed 100644
--- a/drivers/platform/x86/lenovo/wmi-helpers.h
+++ b/drivers/platform/x86/lenovo/wmi-helpers.h
@@ -7,6 +7,8 @@
 
 #include <linux/types.h>
 
+struct device;
+struct notifier_block;
 struct wmi_device;
 
 struct wmi_method_args_32 {
@@ -17,4 +19,10 @@ struct wmi_method_args_32 {
 int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
 			  unsigned char *buf, size_t size, u32 *retval);
 
+int lwmi_tm_register_notifier(struct notifier_block *nb);
+int lwmi_tm_unregister_notifier(struct notifier_block *nb);
+int devm_lwmi_tm_register_notifier(struct device *dev,
+				   struct notifier_block *nb);
+int lwmi_tm_notifier_call(enum thermal_mode *mode);
+
 #endif /* !_LENOVO_WMI_HELPERS_H_ */
diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index 29d062a1c6dc..4e88d6bee00c 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -40,7 +40,6 @@
 #include <linux/kobject.h>
 #include <linux/limits.h>
 #include <linux/module.h>
-#include <linux/notifier.h>
 #include <linux/platform_profile.h>
 #include <linux/types.h>
 #include <linux/wmi.h>
@@ -49,7 +48,6 @@
 #include "wmi-events.h"
 #include "wmi-gamezone.h"
 #include "wmi-helpers.h"
-#include "wmi-other.h"
 #include "../firmware_attributes_class.h"
 
 #define LENOVO_OTHER_MODE_GUID "DC2A8805-3A8C-41BA-A6F7-092E0089CD3B"
@@ -81,7 +79,6 @@
 #define LWMI_OM_FW_ATTR_BASE_PATH "lenovo-wmi-other"
 #define LWMI_OM_HWMON_NAME "lenovo_wmi_other"
 
-static BLOCKING_NOTIFIER_HEAD(om_chain_head);
 static DEFINE_IDA(lwmi_om_ida);
 
 enum attribute_property {
@@ -109,7 +106,6 @@ struct lwmi_om_priv {
 	struct device *hwmon_dev;
 	struct device *fw_attr_dev;
 	struct kset *fw_attr_kset;
-	struct notifier_block nb;
 	struct wmi_device *wdev;
 	int ida_id;
 
@@ -577,102 +573,6 @@ struct capdata01_attr_group {
 	struct tunable_attr_01 *tunable_attr;
 };
 
-/**
- * lwmi_om_register_notifier() - Add a notifier to the blocking notifier chain
- * @nb: The notifier_block struct to register
- *
- * Call blocking_notifier_chain_register to register the notifier block to the
- * lenovo-wmi-other driver notifier chain.
- *
- * Return: 0 on success, %-EEXIST on error.
- */
-int lwmi_om_register_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&om_chain_head, nb);
-}
-EXPORT_SYMBOL_NS_GPL(lwmi_om_register_notifier, "LENOVO_WMI_OTHER");
-
-/**
- * lwmi_om_unregister_notifier() - Remove a notifier from the blocking notifier
- * chain.
- * @nb: The notifier_block struct to register
- *
- * Call blocking_notifier_chain_unregister to unregister the notifier block from the
- * lenovo-wmi-other driver notifier chain.
- *
- * Return: 0 on success, %-ENOENT on error.
- */
-int lwmi_om_unregister_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&om_chain_head, nb);
-}
-EXPORT_SYMBOL_NS_GPL(lwmi_om_unregister_notifier, "LENOVO_WMI_OTHER");
-
-/**
- * devm_lwmi_om_unregister_notifier() - Remove a notifier from the blocking
- * notifier chain.
- * @data: Void pointer to the notifier_block struct to register.
- *
- * Call lwmi_om_unregister_notifier to unregister the notifier block from the
- * lenovo-wmi-other driver notifier chain.
- *
- * Return: 0 on success, %-ENOENT on error.
- */
-static void devm_lwmi_om_unregister_notifier(void *data)
-{
-	struct notifier_block *nb = data;
-
-	lwmi_om_unregister_notifier(nb);
-}
-
-/**
- * devm_lwmi_om_register_notifier() - Add a notifier to the blocking notifier
- * chain.
- * @dev: The parent device of the notifier_block struct.
- * @nb: The notifier_block struct to register
- *
- * Call lwmi_om_register_notifier to register the notifier block to the
- * lenovo-wmi-other driver notifier chain. Then add devm_lwmi_om_unregister_notifier
- * as a device managed action to automatically unregister the notifier block
- * upon parent device removal.
- *
- * Return: 0 on success, or an error code.
- */
-int devm_lwmi_om_register_notifier(struct device *dev,
-				   struct notifier_block *nb)
-{
-	int ret;
-
-	ret = lwmi_om_register_notifier(nb);
-	if (ret < 0)
-		return ret;
-
-	return devm_add_action_or_reset(dev, devm_lwmi_om_unregister_notifier,
-					nb);
-}
-EXPORT_SYMBOL_NS_GPL(devm_lwmi_om_register_notifier, "LENOVO_WMI_OTHER");
-
-/**
- * lwmi_om_notifier_call() - Call functions for the notifier call chain.
- * @mode: Pointer to a thermal mode enum to retrieve the data from.
- *
- * Call blocking_notifier_call_chain to retrieve the thermal mode from the
- * lenovo-wmi-gamezone driver.
- *
- * Return: 0 on success, or an error code.
- */
-static int lwmi_om_notifier_call(enum thermal_mode *mode)
-{
-	int ret;
-
-	ret = blocking_notifier_call_chain(&om_chain_head,
-					   LWMI_GZ_GET_THERMAL_MODE, &mode);
-	if ((ret & ~NOTIFY_STOP_MASK) != NOTIFY_OK)
-		return -EINVAL;
-
-	return 0;
-}
-
 /* Attribute Methods */
 
 /**
@@ -780,7 +680,7 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
 	u32 value;
 	int ret;
 
-	ret = lwmi_om_notifier_call(&mode);
+	ret = lwmi_tm_notifier_call(&mode);
 	if (ret)
 		return ret;
 
@@ -843,7 +743,7 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
 	int retval;
 	int ret;
 
-	ret = lwmi_om_notifier_call(&mode);
+	ret = lwmi_tm_notifier_call(&mode);
 	if (ret)
 		return ret;
 
diff --git a/drivers/platform/x86/lenovo/wmi-other.h b/drivers/platform/x86/lenovo/wmi-other.h
deleted file mode 100644
index 8ebf5602bb99..000000000000
--- a/drivers/platform/x86/lenovo/wmi-other.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-/* Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com> */
-
-#ifndef _LENOVO_WMI_OTHER_H_
-#define _LENOVO_WMI_OTHER_H_
-
-struct device;
-struct notifier_block;
-
-int lwmi_om_register_notifier(struct notifier_block *nb);
-int lwmi_om_unregister_notifier(struct notifier_block *nb);
-int devm_lwmi_om_register_notifier(struct device *dev,
-				   struct notifier_block *nb);
-
-#endif /* !_LENOVO_WMI_OTHER_H_ */
-- 
2.53.0


