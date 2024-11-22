Return-Path: <stable+bounces-94643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564EB9D651D
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8989B1613F3
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A1E1DF97E;
	Fri, 22 Nov 2024 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QaAyIRKf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A5C1531C8
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309666; cv=none; b=N+BIzw8ZUSbfLMDBslVMfO7BrHxm2dcdwCwNcrhoaokUfIzlc0M+7OSJoroUa86qVIE2cj9uPGwsBgwNP9KiAeHtijTwMqxQEdS8GBESUCmzf1lF6g8JLnQJMeIfhodmqoGRXKw8t+vz5444Q/iIcjDnK8yre0lAjAEQHm33l2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309666; c=relaxed/simple;
	bh=toYmkcLfAlA85irEbMkMuppz6Mfje2/xm11NIiwSglA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGkYKPRsUeRrl4Qz6/i7+aSJA4NXaEOjB5QkOu3Fp6Vt6BlNmtxNnjWYOamBHtVSbOfHG8skbj/KCRqw0OSmutDzgp3KZLrLOAM9x0gb+eSVlH9xL4YdwKs2QJQuy1prEgt46o50HY0knNXtQwAFV8Yp+K/gQTsqRuCuRTuWdMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QaAyIRKf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309663; x=1763845663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=toYmkcLfAlA85irEbMkMuppz6Mfje2/xm11NIiwSglA=;
  b=QaAyIRKf/VAdLDsekAGScwLGLW5lB81+XBujNK1R84ADRFQX8DRQ393A
   R4eW18YjanOIk/3qJT/V4/Hr+oAv+p8T3tcynaPuu5l8Dnw5T5uflcDdG
   gzzZTn0plPMMNftMnb9AB/arIM6nLH1SZg+FjMlmbfyF96EOlPtvH5bQz
   g2mf5sCU+o8wfzxbBBld9ld/KOsG1QObsACJYBAfjmXp8MYNvW03Z8A3n
   twuyh+rQbZi4n9aXBDiUYM5Ed6J8IKZCbCgnGCYzLdhMshgYL2N73SbsO
   MfvmsvRnS92DRoXqpSE8Af4BMgESDgreMSO5UUQlD2RMC3tlppJte4grR
   w==;
X-CSE-ConnectionGUID: 8cAIi7hLSNCuif9f/gHc3g==
X-CSE-MsgGUID: Cqn5vuvjQ2aQhRBaq4BkEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878259"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878259"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:40 -0800
X-CSE-ConnectionGUID: kM/kE+xUScOCHsw3n4lpTg==
X-CSE-MsgGUID: Jkt2gcMuRbudbM0AhFSrCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457195"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:40 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 05/31] drm/xe/kunit: Simplify xe_dma_buf live tests code layout
Date: Fri, 22 Nov 2024 13:06:53 -0800
Message-ID: <20241122210719.213373-6-lucas.demarchi@intel.com>
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

commit ff10c99ab1e644fed578dce13e94e372d2c688c3 upstream.

The test case logic is implemented by the functions compiled as
part of the core Xe driver module and then exported to build and
register the test suite in the live test module.

But we don't need to export individual test case functions, we may
just export the entire test suite. And we don't need to register
this test suite in a separate file, it can be done in the main
file of the live test module.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240708111210.1154-3-michal.wajdeczko@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/tests/Makefile           |  1 -
 drivers/gpu/drm/xe/tests/xe_dma_buf.c       | 16 +++++++++++++---
 drivers/gpu/drm/xe/tests/xe_dma_buf_test.c  | 20 --------------------
 drivers/gpu/drm/xe/tests/xe_dma_buf_test.h  | 13 -------------
 drivers/gpu/drm/xe/tests/xe_live_test_mod.c |  2 ++
 5 files changed, 15 insertions(+), 37 deletions(-)
 delete mode 100644 drivers/gpu/drm/xe/tests/xe_dma_buf_test.c
 delete mode 100644 drivers/gpu/drm/xe/tests/xe_dma_buf_test.h

diff --git a/drivers/gpu/drm/xe/tests/Makefile b/drivers/gpu/drm/xe/tests/Makefile
index 77331b0a04ad2..c77a5882d094e 100644
--- a/drivers/gpu/drm/xe/tests/Makefile
+++ b/drivers/gpu/drm/xe/tests/Makefile
@@ -3,7 +3,6 @@
 # "live" kunit tests
 obj-$(CONFIG_DRM_XE_KUNIT_TEST) += xe_live_test.o
 xe_live_test-y = xe_live_test_mod.o \
-	xe_dma_buf_test.o \
 	xe_migrate_test.o \
 	xe_mocs_test.o
 
diff --git a/drivers/gpu/drm/xe/tests/xe_dma_buf.c b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
index b56013963911e..4f9dc41e13de9 100644
--- a/drivers/gpu/drm/xe/tests/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
@@ -8,7 +8,6 @@
 #include <kunit/test.h>
 #include <kunit/visibility.h>
 
-#include "tests/xe_dma_buf_test.h"
 #include "tests/xe_pci_test.h"
 
 #include "xe_pci.h"
@@ -274,8 +273,19 @@ static int dma_buf_run_device(struct xe_device *xe)
 	return 0;
 }
 
-void xe_dma_buf_kunit(struct kunit *test)
+static void xe_dma_buf_kunit(struct kunit *test)
 {
 	xe_call_for_each_device(dma_buf_run_device);
 }
-EXPORT_SYMBOL_IF_KUNIT(xe_dma_buf_kunit);
+
+static struct kunit_case xe_dma_buf_tests[] = {
+	KUNIT_CASE(xe_dma_buf_kunit),
+	{}
+};
+
+VISIBLE_IF_KUNIT
+struct kunit_suite xe_dma_buf_test_suite = {
+	.name = "xe_dma_buf",
+	.test_cases = xe_dma_buf_tests,
+};
+EXPORT_SYMBOL_IF_KUNIT(xe_dma_buf_test_suite);
diff --git a/drivers/gpu/drm/xe/tests/xe_dma_buf_test.c b/drivers/gpu/drm/xe/tests/xe_dma_buf_test.c
deleted file mode 100644
index 99cdb718b6c61..0000000000000
--- a/drivers/gpu/drm/xe/tests/xe_dma_buf_test.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright © 2022 Intel Corporation
- */
-
-#include "xe_dma_buf_test.h"
-
-#include <kunit/test.h>
-
-static struct kunit_case xe_dma_buf_tests[] = {
-	KUNIT_CASE(xe_dma_buf_kunit),
-	{}
-};
-
-static struct kunit_suite xe_dma_buf_test_suite = {
-	.name = "xe_dma_buf",
-	.test_cases = xe_dma_buf_tests,
-};
-
-kunit_test_suite(xe_dma_buf_test_suite);
diff --git a/drivers/gpu/drm/xe/tests/xe_dma_buf_test.h b/drivers/gpu/drm/xe/tests/xe_dma_buf_test.h
deleted file mode 100644
index e6b464ddd5260..0000000000000
--- a/drivers/gpu/drm/xe/tests/xe_dma_buf_test.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 AND MIT */
-/*
- * Copyright © 2023 Intel Corporation
- */
-
-#ifndef _XE_DMA_BUF_TEST_H_
-#define _XE_DMA_BUF_TEST_H_
-
-struct kunit;
-
-void xe_dma_buf_kunit(struct kunit *test);
-
-#endif
diff --git a/drivers/gpu/drm/xe/tests/xe_live_test_mod.c b/drivers/gpu/drm/xe/tests/xe_live_test_mod.c
index 3bffcbd233b29..d9da15d9fe3fd 100644
--- a/drivers/gpu/drm/xe/tests/xe_live_test_mod.c
+++ b/drivers/gpu/drm/xe/tests/xe_live_test_mod.c
@@ -6,8 +6,10 @@
 #include <kunit/test.h>
 
 extern struct kunit_suite xe_bo_test_suite;
+extern struct kunit_suite xe_dma_buf_test_suite;
 
 kunit_test_suite(xe_bo_test_suite);
+kunit_test_suite(xe_dma_buf_test_suite);
 
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL");
-- 
2.47.0


