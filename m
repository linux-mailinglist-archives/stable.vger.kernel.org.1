Return-Path: <stable+bounces-94642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D7B9D651B
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC53282B6C
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91561DEFFD;
	Fri, 22 Nov 2024 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jh2B+WF7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052C188CD0
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309665; cv=none; b=LVY10R/mPvi7fbn3UkMm03N2eW6e0WVImRjIQ5R+fObI60ZplzhYfRvCBgXIKKGyxcoJpziSqB5iIiezrhOK/L6TWD/3JAna+ECjS8dpbaqW6Ff+zAutsZrXudeEwuBRpxCd60t8fDZNCd4AzXmrz+JhmBXaWPd2ZCOdOwixUPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309665; c=relaxed/simple;
	bh=hCBmFvjBl5mamtj0B4fxeAVn919j5jQXSpQllgjO8WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbtpEQt2A/r7iGtKbOVH2BeNGQKtX+vn/xlzlGO1T7IBymTfQOipMiuHKayrJ1kWmnuyUPP7ttD6/h1kel0DYs0vm2qCuKWis7zoEXLRUmVU/uH+8VA8veIUY7JK2/xreSTObxBCcqLNU1a+k6x/mAEyoMsoMgud/V6Zl+jpalo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jh2B+WF7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309664; x=1763845664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hCBmFvjBl5mamtj0B4fxeAVn919j5jQXSpQllgjO8WI=;
  b=jh2B+WF7vtIkVwu2TAuZK/UrYmUEg7eyLOgnMMuJS0j4eaqeceyITjj5
   abrjHBkETEqiH6wOwiIeJkmp52ISuDtthab5z0YeuXIsRN2nwYENyU69d
   aaPUav8o5cECLP3F3yDWc17ueIuK8ytK7wpnLdajmQP8e0XIlCVqmsuAu
   JSFcRrBqd0SejXQpLauBuZyvCZslSgdyAXh/MjH9XjLMfTnnIOIKTMm8I
   dnj0KzXbim0woNiuvT5OlpM5cKXej42wRci67uO7aOCb5UwvD24O2jWTG
   d3TDB0fyeahWfuL6+BZydIEDpWuFEgLI/1oDigNSY26rtA3B1PQxOcaWX
   g==;
X-CSE-ConnectionGUID: w2kOz1M0QIau4SxMbAd6zw==
X-CSE-MsgGUID: 0T4F7LZqS4aooaHwa7C5HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878260"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878260"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:40 -0800
X-CSE-ConnectionGUID: ZjQ4d5jgSG+a49rbsCC4lA==
X-CSE-MsgGUID: xTsWKvQ2QZWT3skjHnA+cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457198"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:40 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 06/31] drm/xe/kunit: Simplify xe_migrate live tests code layout
Date: Fri, 22 Nov 2024 13:06:54 -0800
Message-ID: <20241122210719.213373-7-lucas.demarchi@intel.com>
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

commit 0237368193e897aadeea9801126c101e33047354 upstream.

The test case logic is implemented by the functions compiled as
part of the core Xe driver module and then exported to build and
register the test suite in the live test module.

But we don't need to export individual test case functions, we may
just export the entire test suite. And we don't need to register
this test suite in a separate file, it can be done in the main
file of the live test module.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240708111210.1154-4-michal.wajdeczko@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/tests/Makefile           |  1 -
 drivers/gpu/drm/xe/tests/xe_live_test_mod.c |  2 ++
 drivers/gpu/drm/xe/tests/xe_migrate.c       | 16 +++++++++++++---
 drivers/gpu/drm/xe/tests/xe_migrate_test.c  | 20 --------------------
 drivers/gpu/drm/xe/tests/xe_migrate_test.h  | 13 -------------
 5 files changed, 15 insertions(+), 37 deletions(-)
 delete mode 100644 drivers/gpu/drm/xe/tests/xe_migrate_test.c
 delete mode 100644 drivers/gpu/drm/xe/tests/xe_migrate_test.h

diff --git a/drivers/gpu/drm/xe/tests/Makefile b/drivers/gpu/drm/xe/tests/Makefile
index c77a5882d094e..32ce1d6df0fa0 100644
--- a/drivers/gpu/drm/xe/tests/Makefile
+++ b/drivers/gpu/drm/xe/tests/Makefile
@@ -3,7 +3,6 @@
 # "live" kunit tests
 obj-$(CONFIG_DRM_XE_KUNIT_TEST) += xe_live_test.o
 xe_live_test-y = xe_live_test_mod.o \
-	xe_migrate_test.o \
 	xe_mocs_test.o
 
 # Normal kunit tests
diff --git a/drivers/gpu/drm/xe/tests/xe_live_test_mod.c b/drivers/gpu/drm/xe/tests/xe_live_test_mod.c
index d9da15d9fe3fd..4c1e07a0d4778 100644
--- a/drivers/gpu/drm/xe/tests/xe_live_test_mod.c
+++ b/drivers/gpu/drm/xe/tests/xe_live_test_mod.c
@@ -7,9 +7,11 @@
 
 extern struct kunit_suite xe_bo_test_suite;
 extern struct kunit_suite xe_dma_buf_test_suite;
+extern struct kunit_suite xe_migrate_test_suite;
 
 kunit_test_suite(xe_bo_test_suite);
 kunit_test_suite(xe_dma_buf_test_suite);
+kunit_test_suite(xe_migrate_test_suite);
 
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
index d277a21ccf910..0de0e0c666230 100644
--- a/drivers/gpu/drm/xe/tests/xe_migrate.c
+++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
@@ -6,7 +6,6 @@
 #include <kunit/test.h>
 #include <kunit/visibility.h>
 
-#include "tests/xe_migrate_test.h"
 #include "tests/xe_pci_test.h"
 
 #include "xe_pci.h"
@@ -354,8 +353,19 @@ static int migrate_test_run_device(struct xe_device *xe)
 	return 0;
 }
 
-void xe_migrate_sanity_kunit(struct kunit *test)
+static void xe_migrate_sanity_kunit(struct kunit *test)
 {
 	xe_call_for_each_device(migrate_test_run_device);
 }
-EXPORT_SYMBOL_IF_KUNIT(xe_migrate_sanity_kunit);
+
+static struct kunit_case xe_migrate_tests[] = {
+	KUNIT_CASE(xe_migrate_sanity_kunit),
+	{}
+};
+
+VISIBLE_IF_KUNIT
+struct kunit_suite xe_migrate_test_suite = {
+	.name = "xe_migrate",
+	.test_cases = xe_migrate_tests,
+};
+EXPORT_SYMBOL_IF_KUNIT(xe_migrate_test_suite);
diff --git a/drivers/gpu/drm/xe/tests/xe_migrate_test.c b/drivers/gpu/drm/xe/tests/xe_migrate_test.c
deleted file mode 100644
index eb0d8963419cb..0000000000000
--- a/drivers/gpu/drm/xe/tests/xe_migrate_test.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright © 2022 Intel Corporation
- */
-
-#include "xe_migrate_test.h"
-
-#include <kunit/test.h>
-
-static struct kunit_case xe_migrate_tests[] = {
-	KUNIT_CASE(xe_migrate_sanity_kunit),
-	{}
-};
-
-static struct kunit_suite xe_migrate_test_suite = {
-	.name = "xe_migrate",
-	.test_cases = xe_migrate_tests,
-};
-
-kunit_test_suite(xe_migrate_test_suite);
diff --git a/drivers/gpu/drm/xe/tests/xe_migrate_test.h b/drivers/gpu/drm/xe/tests/xe_migrate_test.h
deleted file mode 100644
index 7c645c66824f8..0000000000000
--- a/drivers/gpu/drm/xe/tests/xe_migrate_test.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 AND MIT */
-/*
- * Copyright © 2023 Intel Corporation
- */
-
-#ifndef _XE_MIGRATE_TEST_H_
-#define _XE_MIGRATE_TEST_H_
-
-struct kunit;
-
-void xe_migrate_sanity_kunit(struct kunit *test);
-
-#endif
-- 
2.47.0


