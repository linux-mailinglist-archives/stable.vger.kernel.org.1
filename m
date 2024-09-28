Return-Path: <stable+bounces-78185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5856D989056
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 18:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9E0282334
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06771384B3;
	Sat, 28 Sep 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4eb1f7/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B820502BE
	for <stable@vger.kernel.org>; Sat, 28 Sep 2024 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727540338; cv=none; b=CiK2geuzzfYVJRS7iLxSZPYnKnJyGYRrr3twzPEj467NCkHdxQiyQsvgOdl2FbmzPbcE4R4NEbBjDxZbVhKDyMdCCQiOokVvnXSJItAuf9yjvE/e6tthGnGKloAcDQl+gqNqT0LOZC5v7QqDr5AZb2RqpCnSBr6cl1R/JdUEMdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727540338; c=relaxed/simple;
	bh=S0ZBAYhm7ztFb2pkhC4Xl7/HAUz2f/+PhE5XclH0wPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=k0LlEumCyhs/LcSIZoy2owhkE2TjT32o4TmIAdgoXCMOQGVonGV/3UgpMVYaUDie9XJ0BQrPWRK371Lr0q4WAayXFeTYqM9hnGdyu//+WOaNRspxUkFGNt6l3rdTKV8W2i8SZQo+JQY4jH8DKkoS6FHn2D21GKqicqW6rzkINN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4eb1f7/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727540337; x=1759076337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=S0ZBAYhm7ztFb2pkhC4Xl7/HAUz2f/+PhE5XclH0wPU=;
  b=M4eb1f7/LIZ7f6XnxWX2LW/fMm8genhYnJVSyum7/vLB2xjFfuWSPL83
   AZyVUqmNcSHWt496G6PPndA4Qf6rkaVZb8XIn/tuF9V5AJidwta45Ctfk
   mFwYQhgfy4SCgLsLY6UzXw6sfYGXaARm1frYENakrC5zoEJ34mngQpP7D
   tke1WzS08nkNgpGYKo67nRJR+ffqVyDFjpWj+IkAyNczjypBBS9zg3F9n
   ZCN3yoVidMn42PUAwqTTb5i8hIsRasdiq8J3Rw/SOe7aciLqwCySDUhpn
   g8jVBys7TCKQ8ykKlS3SjEjDEEAmACvpo+fir8CO93COIl5gpqa9hfKAF
   Q==;
X-CSE-ConnectionGUID: ZghkMlH6TiKOp7MERUgy4A==
X-CSE-MsgGUID: yaBly+NjTK6egKdb+Lc7Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26834080"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="26834080"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 09:18:55 -0700
X-CSE-ConnectionGUID: a37TMab1SCin4GLjSWnS4A==
X-CSE-MsgGUID: dbx/BaZwQRCERVAbwaUJ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="73260284"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa007.jf.intel.com with ESMTP; 28 Sep 2024 09:18:55 -0700
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
Subject: [PATCH 5.10.y 1/3] Input: goodix - use the new soc_intel_is_byt() helper
Date: Sat, 28 Sep 2024 09:24:29 -0700
Message-Id: <20240928162431.22129-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240928162431.22129-1-ricardo.neri-calderon@linux.intel.com>
References: <20240928162431.22129-1-ricardo.neri-calderon@linux.intel.com>
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
[Ricardo: Resolved minor cherry-pick conflict. The file linux/regulator/
 consumer.h is not #included in the upstream version but it is in
 v5.10.y. ]
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
I could not test this patch because I do not have access to Bay Trail
hardware. I think there is low risk of new bugs as the patch is rather
trivial.
---
 drivers/input/touchscreen/goodix.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 53792a1b6ac3..440091064803 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/platform_data/x86/soc.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
@@ -718,21 +719,6 @@ static int goodix_reset(struct goodix_ts_data *ts)
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
 
@@ -816,7 +802,7 @@ static int goodix_add_acpi_gpio_mappings(struct goodix_ts_data *ts)
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


