Return-Path: <stable+bounces-78180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 636FC989033
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 17:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A0ECB21544
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B23358222;
	Sat, 28 Sep 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JsmpkHGZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702A5381A
	for <stable@vger.kernel.org>; Sat, 28 Sep 2024 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727539180; cv=none; b=qfQVG510fPAyApkme8JADPcc8kPNDQ6JoAtrxnLqzqf32drKraCTh2p8BFKaMQT6CJuqUjD4m1uITAL9f87Ki/Z8D3CtAqAL5+mUxbDjP8HYTbZIdzdIy1JphZQ4U+Amv+m629hGk+v96mlz9K9oFAvSkRTTE5tYVMqVfVgdVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727539180; c=relaxed/simple;
	bh=XIdXM0ix8YvTybVTM3ctL3Xc17TrsXi5GL03F2l6ea8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=F9DIyaBP5gsfvuMvS3CXVORlrpEGmmPH2sroVdGF8YesC7ZDpSTZFJ5j9xi0rySZeD8E19cpQGJdpDsJ7SlFxcjkCG0Y7b125Ag+a2IKtoFLS+TPKULp94KvN6uORF25o34bbkPjITcjd/V2xqYYKogLKhv39OsFHyzKuKY/w7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JsmpkHGZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727539179; x=1759075179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=XIdXM0ix8YvTybVTM3ctL3Xc17TrsXi5GL03F2l6ea8=;
  b=JsmpkHGZ+ZLl8p7EpjnI0mrHz0LSKIjlWggP0FUTDNnIdX2sa9AcD7i2
   PNf8HHmg1/MpGzldSc6CzB591DHKhIuMlL9rByp3rN1H46evHp8IaTrEt
   UEhHUaGKUV1CFkPn8wXCbW00QUvS7H69i24xkCBim3CMB2V6LHCBEIvyn
   8dKMAlcK+kog6mcBf37Ph/BtJFJouEq1SkBYidvBUC0O7V4Wt/aSadLy/
   fQN7hvecvyVVY/iadF8xt/8R9iPw56Y0FrJOPeBjAgSI/ubuB8N5ag5QY
   LOoAKpWWPOt0q9LHuIHwA8b171sbmRSe7Zsl2g/JEMgvukCSop/2nqzJW
   A==;
X-CSE-ConnectionGUID: XrhVV7ntTX6otqXGs2hE1Q==
X-CSE-MsgGUID: sKwm+/4qRMKh8AqBHs52+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26470458"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="26470458"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 08:59:36 -0700
X-CSE-ConnectionGUID: EBtIOy24SE2Y1DZE+RgCdg==
X-CSE-MsgGUID: rp5CBwI/RTiFwNMQxSPTnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="72994559"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa008.fm.intel.com with ESMTP; 28 Sep 2024 08:59:35 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: stable@vger.kernel.org
Cc: x86@kernel.org,
	Tony Luck <tony.luck@intel.com>,
	"Pawan Kumar Gupta" <pawan.kumar.gupta@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
	Thomas Lindroth <thomas.lindroth@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Bastien Nocera <hadess@hadess.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH 5.15.y 1/3] Input: goodix - use the new soc_intel_is_byt() helper
Date: Sat, 28 Sep 2024 09:05:10 -0700
Message-Id: <20240928160512.21889-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240928160512.21889-1-ricardo.neri-calderon@linux.intel.com>
References: <20240928160512.21889-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit: d176708ffc20332d1c730098d2b111e0b77ece82 ]

Use the new soc_intel_is_byt() helper from linux/platform_data/x86/soc.h.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20220131143539.109142-5-hdegoede@redhat.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
I could not test this patch as I do not have access to Bay Trail
hardware. I think there is low risk of new bugs as the patch is rather
trivial.
---
 drivers/input/touchscreen/goodix.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 1492f051331a..2a58be797276 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/platform_data/x86/soc.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
@@ -684,21 +685,6 @@ static int goodix_reset(struct goodix_ts_data *ts)
 }
 
 #ifdef ACPI_GPIO_SUPPORT
-#include <asm/cpu_device_id.h>
-#include <asm/intel-family.h>
-
-static const struct x86_cpu_id baytrail_cpu_ids[] = {
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_SILVERMONT, X86_FEATURE_ANY, },
-	{}
-};
-
-static inline bool is_byt(void)
-{
-	const struct x86_cpu_id *id = x86_match_cpu(baytrail_cpu_ids);
-
-	return !!id;
-}
-
 static const struct acpi_gpio_params first_gpio = { 0, 0, false };
 static const struct acpi_gpio_params second_gpio = { 1, 0, false };
 
@@ -782,7 +768,7 @@ static int goodix_add_acpi_gpio_mappings(struct goodix_ts_data *ts)
 		dev_info(dev, "Using ACPI INTI and INTO methods for IRQ pin access\n");
 		ts->irq_pin_access_method = IRQ_PIN_ACCESS_ACPI_METHOD;
 		gpio_mapping = acpi_goodix_reset_only_gpios;
-	} else if (is_byt() && ts->gpio_count == 2 && ts->gpio_int_idx == -1) {
+	} else if (soc_intel_is_byt() && ts->gpio_count == 2 && ts->gpio_int_idx == -1) {
 		dev_info(dev, "No ACPI GpioInt resource, assuming that the GPIO order is reset, int\n");
 		ts->irq_pin_access_method = IRQ_PIN_ACCESS_ACPI_GPIO;
 		gpio_mapping = acpi_goodix_int_last_gpios;
-- 
2.34.1


