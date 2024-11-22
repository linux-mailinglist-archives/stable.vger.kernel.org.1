Return-Path: <stable+bounces-94641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5628F9D651C
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 774BFB23026
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8DD1DE4E4;
	Fri, 22 Nov 2024 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFK63Zeg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80EF188583
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309665; cv=none; b=W5J1L6TpRRGAHmTFWrZzC7qFmuSms8jtSeOwWP3FfqchdjSNUumbMHq5lMEz13jdYUQonQ9+GRjFClvB96v3xyQMBGK2s/9f5D4udSmNZ+XtiBP3mn/t8a/uslc5vVquD8rvZkzeA3amo5pjFrmMFjx4f/o7+amqYQlLIPN2rBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309665; c=relaxed/simple;
	bh=M5UNH8pA/4BWNJvlY5JHC6arAzBM5brcsU6VOzzhncE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZC0SUzYu7Dfq3TErQP0QjMa2wUm8iWGMeBZa4M0yFPCmzzLquEg6uWX0IyGKpbF1FvUjsvf57bF8NqaTH74+7i108qfVQepv+ziii4/5qz6RS+QffihxG+8KMXl5cK7DIEq2JUS+CdZJ7f2XXl4nBYbRHMr4JO/aJfCTlntdcQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFK63Zeg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309663; x=1763845663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M5UNH8pA/4BWNJvlY5JHC6arAzBM5brcsU6VOzzhncE=;
  b=nFK63ZegjnRwCtG5BcJLgtdrOKvm5eHEd7C3JSVoZWaDXRuwwqtdBicH
   dXTRG3HBpzNPbEejGOz5udCE8YeYgWzAn5v0ImDcoyGZQV4whagLnItvw
   QFQXym4dVTbp4S9uusL7iYAmXTL1hHT3u1sB34ROLpGB12w0u8yMKDcd3
   JnyEa8v/a8d5WMTFwWl0M58hy93VywT5+uzQ+anOwDr8u89rPbcZQ21Hk
   YETWfER+usFvRTH1CJxb7amISVxMxXXBIkCV+PgOxM6+DK1VD87o92zWq
   JdIz6ewn5/EbYN8w1ztO6j0VMP4qBFRgzSz7soF30ps8saXgKeelsllB1
   w==;
X-CSE-ConnectionGUID: A71fyAvcQ8GYJ5+3x8KYSw==
X-CSE-MsgGUID: /F5h/0zDS7KhTiu7qhGeSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878258"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878258"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:40 -0800
X-CSE-ConnectionGUID: qcQC/W3oQHOj54O4wy31iw==
X-CSE-MsgGUID: AtBPU+QHR9uld3lyDXaNug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457192"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:39 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 04/31] drm/xe/kunit: Simplify xe_bo live tests code layout
Date: Fri, 22 Nov 2024 13:06:52 -0800
Message-ID: <20241122210719.213373-5-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

commit d6e850acc716d0fad756f09488d198db2077141e upstream.

The test case logic is implemented by the functions compiled as
part of the core Xe driver module and then exported to build and
register the test suite in the live test module.

But we don't need to export individual test case functions, we may
just export the entire test suite. And we don't need to register
this test suite in a separate file, it can be done in the main
file of the live test module.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240708111210.1154-2-michal.wajdeczko@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/tests/Makefile           |  1 -
 drivers/gpu/drm/xe/tests/xe_bo.c            | 20 +++++++++++++++-----
 drivers/gpu/drm/xe/tests/xe_bo_test.c       | 21 ---------------------
 drivers/gpu/drm/xe/tests/xe_bo_test.h       | 14 --------------
 drivers/gpu/drm/xe/tests/xe_live_test_mod.c |  5 +++++
 5 files changed, 20 insertions(+), 41 deletions(-)
 delete mode 100644 drivers/gpu/drm/xe/tests/xe_bo_test.c
 delete mode 100644 drivers/gpu/drm/xe/tests/xe_bo_test.h

diff --git a/drivers/gpu/drm/xe/tests/Makefile b/drivers/gpu/drm/xe/tests/Makefile
index 6e58931fddd44..77331b0a04ad2 100644
--- a/drivers/gpu/drm/xe/tests/Makefile
+++ b/drivers/gpu/drm/xe/tests/Makefile
@@ -3,7 +3,6 @@
 # "live" kunit tests
 obj-$(CONFIG_DRM_XE_KUNIT_TEST) += xe_live_test.o
 xe_live_test-y = xe_live_test_mod.o \
-	xe_bo_test.o \
 	xe_dma_buf_test.o \
 	xe_migrate_test.o \
 	xe_mocs_test.o
diff --git a/drivers/gpu/drm/xe/tests/xe_bo.c b/drivers/gpu/drm/xe/tests/xe_bo.c
index 263e0afa8de0c..692e1b46b9cf9 100644
--- a/drivers/gpu/drm/xe/tests/xe_bo.c
+++ b/drivers/gpu/drm/xe/tests/xe_bo.c
@@ -6,7 +6,6 @@
 #include <kunit/test.h>
 #include <kunit/visibility.h>
 
-#include "tests/xe_bo_test.h"
 #include "tests/xe_pci_test.h"
 #include "tests/xe_test.h"
 
@@ -177,11 +176,10 @@ static int ccs_test_run_device(struct xe_device *xe)
 	return 0;
 }
 
-void xe_ccs_migrate_kunit(struct kunit *test)
+static void xe_ccs_migrate_kunit(struct kunit *test)
 {
 	xe_call_for_each_device(ccs_test_run_device);
 }
-EXPORT_SYMBOL_IF_KUNIT(xe_ccs_migrate_kunit);
 
 static int evict_test_run_tile(struct xe_device *xe, struct xe_tile *tile, struct kunit *test)
 {
@@ -345,8 +343,20 @@ static int evict_test_run_device(struct xe_device *xe)
 	return 0;
 }
 
-void xe_bo_evict_kunit(struct kunit *test)
+static void xe_bo_evict_kunit(struct kunit *test)
 {
 	xe_call_for_each_device(evict_test_run_device);
 }
-EXPORT_SYMBOL_IF_KUNIT(xe_bo_evict_kunit);
+
+static struct kunit_case xe_bo_tests[] = {
+	KUNIT_CASE(xe_ccs_migrate_kunit),
+	KUNIT_CASE(xe_bo_evict_kunit),
+	{}
+};
+
+VISIBLE_IF_KUNIT
+struct kunit_suite xe_bo_test_suite = {
+	.name = "xe_bo",
+	.test_cases = xe_bo_tests,
+};
+EXPORT_SYMBOL_IF_KUNIT(xe_bo_test_suite);
diff --git a/drivers/gpu/drm/xe/tests/xe_bo_test.c b/drivers/gpu/drm/xe/tests/xe_bo_test.c
deleted file mode 100644
index a324cde77db82..0000000000000
--- a/drivers/gpu/drm/xe/tests/xe_bo_test.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright © 2022 Intel Corporation
- */
-
-#include "xe_bo_test.h"
-
-#include <kunit/test.h>
-
-static struct kunit_case xe_bo_tests[] = {
-	KUNIT_CASE(xe_ccs_migrate_kunit),
-	KUNIT_CASE(xe_bo_evict_kunit),
-	{}
-};
-
-static struct kunit_suite xe_bo_test_suite = {
-	.name = "xe_bo",
-	.test_cases = xe_bo_tests,
-};
-
-kunit_test_suite(xe_bo_test_suite);
diff --git a/drivers/gpu/drm/xe/tests/xe_bo_test.h b/drivers/gpu/drm/xe/tests/xe_bo_test.h
deleted file mode 100644
index 0113ab45066a4..0000000000000
--- a/drivers/gpu/drm/xe/tests/xe_bo_test.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 AND MIT */
-/*
- * Copyright © 2023 Intel Corporation
- */
-
-#ifndef _XE_BO_TEST_H_
-#define _XE_BO_TEST_H_
-
-struct kunit;
-
-void xe_ccs_migrate_kunit(struct kunit *test);
-void xe_bo_evict_kunit(struct kunit *test);
-
-#endif
diff --git a/drivers/gpu/drm/xe/tests/xe_live_test_mod.c b/drivers/gpu/drm/xe/tests/xe_live_test_mod.c
index eb1ea99a5a8b1..3bffcbd233b29 100644
--- a/drivers/gpu/drm/xe/tests/xe_live_test_mod.c
+++ b/drivers/gpu/drm/xe/tests/xe_live_test_mod.c
@@ -3,6 +3,11 @@
  * Copyright © 2023 Intel Corporation
  */
 #include <linux/module.h>
+#include <kunit/test.h>
+
+extern struct kunit_suite xe_bo_test_suite;
+
+kunit_test_suite(xe_bo_test_suite);
 
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL");
-- 
2.47.0


