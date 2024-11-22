Return-Path: <stable+bounces-94640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5517B9D651A
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0B7282DA3
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CFC18C002;
	Fri, 22 Nov 2024 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRaex214"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26734185936
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309664; cv=none; b=FF4/Sul0e1z32gk5Tl3P+NmyK90FCsF3tSksBNxstRE3dbZq9Td5Jq5iRnO1ggpOxyuhLiPpE1vUYREvTxpEcTUPj5SCWf49ml3/StvrMeSLc6zUHkQRGPvytU7ciJnSsKSIKCEpb3gTkSLVKPusByuh8D/UQKrU504nRcszvi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309664; c=relaxed/simple;
	bh=Ihy2TmmbW3MChJzzC5/YU3DsZLZoAtuJ9WQ7TbNiQdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieunC0PWf4v+epAGLrNvzYJWGnaGsU02QT4zVH6CpP5gYlBvyFUkpr/1KK40BgsyF4E354WJhDYj5K0mBPBz+dX4cIvDDPznToiomVQ0eeFeFCmj02kixqGCY9sfHJPirjiCDIwiETy1wM2aMjez9A3Ipfr1iU0TfWTxq48P1+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRaex214; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309662; x=1763845662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ihy2TmmbW3MChJzzC5/YU3DsZLZoAtuJ9WQ7TbNiQdI=;
  b=PRaex214TXgdLPvUvD5IWpMI/qanzLbeVnUMryQCQBREDGaupwQEtyKu
   nss9b6NiNuh4qn44jkSfCtX4RxL0svGixTL+vCPn0idSbzHlAR+tmYVbp
   RCPz3bVXIcomZ1hEoHGrQ1FTUtUzj8phIQZmEkbAeMBYidGQTu0m+Mydv
   qtcP1FcYMknCZPwx4w10aGimGYnz8ybIt87aSXijpKWkQUuSn6hDrVFWn
   GETKDRfa0tgIQ4uJcop1UTVh/G78Mzn4mhjGln0oPjAHf0h40mE3hYIOT
   HzBzkhTgRo1UF8DiZXK77s2RJw/j3jc9YSwCkHW47b71HtYIMqdgtDcu9
   g==;
X-CSE-ConnectionGUID: 5yZE9QM2T4muR2qNr6RVjQ==
X-CSE-MsgGUID: fwZdeOgCQSaI0ay1Lgjb6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878257"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878257"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:39 -0800
X-CSE-ConnectionGUID: SOLJp5+QQHuLAiClV7ddbA==
X-CSE-MsgGUID: Hfl+iP+YSuC2B3KCh/Xmrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457189"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:39 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 03/31] drm/xe/kunit: Kill xe_cur_kunit()
Date: Fri, 22 Nov 2024 13:06:51 -0800
Message-ID: <20241122210719.213373-4-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

commit bd85e00fa489f5374c2bad0eac15842d2ec68045 upstream.

We shouldn't use custom helper if there is a official one.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240705191057.1110-2-michal.wajdeczko@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/tests/xe_bo.c       | 4 ++--
 drivers/gpu/drm/xe/tests/xe_dma_buf.c  | 4 ++--
 drivers/gpu/drm/xe/tests/xe_migrate.c  | 2 +-
 drivers/gpu/drm/xe/tests/xe_mocs.c     | 8 ++++----
 drivers/gpu/drm/xe/tests/xe_pci_test.c | 4 ++--
 drivers/gpu/drm/xe/tests/xe_test.h     | 8 +++-----
 6 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_bo.c b/drivers/gpu/drm/xe/tests/xe_bo.c
index 9f3c028264649..263e0afa8de0c 100644
--- a/drivers/gpu/drm/xe/tests/xe_bo.c
+++ b/drivers/gpu/drm/xe/tests/xe_bo.c
@@ -154,7 +154,7 @@ static void ccs_test_run_tile(struct xe_device *xe, struct xe_tile *tile,
 
 static int ccs_test_run_device(struct xe_device *xe)
 {
-	struct kunit *test = xe_cur_kunit();
+	struct kunit *test = kunit_get_current_test();
 	struct xe_tile *tile;
 	int id;
 
@@ -325,7 +325,7 @@ static int evict_test_run_tile(struct xe_device *xe, struct xe_tile *tile, struc
 
 static int evict_test_run_device(struct xe_device *xe)
 {
-	struct kunit *test = xe_cur_kunit();
+	struct kunit *test = kunit_get_current_test();
 	struct xe_tile *tile;
 	int id;
 
diff --git a/drivers/gpu/drm/xe/tests/xe_dma_buf.c b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
index e7f9b531c4654..b56013963911e 100644
--- a/drivers/gpu/drm/xe/tests/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
@@ -107,7 +107,7 @@ static void check_residency(struct kunit *test, struct xe_bo *exported,
 
 static void xe_test_dmabuf_import_same_driver(struct xe_device *xe)
 {
-	struct kunit *test = xe_cur_kunit();
+	struct kunit *test = kunit_get_current_test();
 	struct dma_buf_test_params *params = to_dma_buf_test_params(test->priv);
 	struct drm_gem_object *import;
 	struct dma_buf *dmabuf;
@@ -258,7 +258,7 @@ static const struct dma_buf_test_params test_params[] = {
 static int dma_buf_run_device(struct xe_device *xe)
 {
 	const struct dma_buf_test_params *params;
-	struct kunit *test = xe_cur_kunit();
+	struct kunit *test = kunit_get_current_test();
 
 	xe_pm_runtime_get(xe);
 	for (params = test_params; params->mem_mask; ++params) {
diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
index 962f6438e2192..d277a21ccf910 100644
--- a/drivers/gpu/drm/xe/tests/xe_migrate.c
+++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
@@ -334,7 +334,7 @@ static void xe_migrate_sanity_test(struct xe_migrate *m, struct kunit *test)
 
 static int migrate_test_run_device(struct xe_device *xe)
 {
-	struct kunit *test = xe_cur_kunit();
+	struct kunit *test = kunit_get_current_test();
 	struct xe_tile *tile;
 	int id;
 
diff --git a/drivers/gpu/drm/xe/tests/xe_mocs.c b/drivers/gpu/drm/xe/tests/xe_mocs.c
index 67c65e88c3845..4fff5de92dea1 100644
--- a/drivers/gpu/drm/xe/tests/xe_mocs.c
+++ b/drivers/gpu/drm/xe/tests/xe_mocs.c
@@ -23,7 +23,7 @@ struct live_mocs {
 static int live_mocs_init(struct live_mocs *arg, struct xe_gt *gt)
 {
 	unsigned int flags;
-	struct kunit *test = xe_cur_kunit();
+	struct kunit *test = kunit_get_current_test();
 
 	memset(arg, 0, sizeof(*arg));
 
@@ -41,7 +41,7 @@ static int live_mocs_init(struct live_mocs *arg, struct xe_gt *gt)
 static void read_l3cc_table(struct xe_gt *gt,
 			    const struct xe_mocs_info *info)
 {
-	struct kunit *test = xe_cur_kunit();
+	struct kunit *test = kunit_get_current_test();
 	u32 l3cc, l3cc_expected;
 	unsigned int i;
 	u32 reg_val;
@@ -78,7 +78,7 @@ static void read_l3cc_table(struct xe_gt *gt,
 static void read_mocs_table(struct xe_gt *gt,
 			    const struct xe_mocs_info *info)
 {
-	struct kunit *test = xe_cur_kunit();
+	struct kunit *test = kunit_get_current_test();
 	u32 mocs, mocs_expected;
 	unsigned int i;
 	u32 reg_val;
@@ -148,7 +148,7 @@ static int mocs_reset_test_run_device(struct xe_device *xe)
 	struct xe_gt *gt;
 	unsigned int flags;
 	int id;
-	struct kunit *test = xe_cur_kunit();
+	struct kunit *test = kunit_get_current_test();
 
 	xe_pm_runtime_get(xe);
 
diff --git a/drivers/gpu/drm/xe/tests/xe_pci_test.c b/drivers/gpu/drm/xe/tests/xe_pci_test.c
index a6705a536391d..744a37583d2d7 100644
--- a/drivers/gpu/drm/xe/tests/xe_pci_test.c
+++ b/drivers/gpu/drm/xe/tests/xe_pci_test.c
@@ -16,7 +16,7 @@
 
 static void check_graphics_ip(const struct xe_graphics_desc *graphics)
 {
-	struct kunit *test = xe_cur_kunit();
+	struct kunit *test = kunit_get_current_test();
 	u64 mask = graphics->hw_engine_mask;
 
 	/* RCS, CCS, and BCS engines are allowed on the graphics IP */
@@ -30,7 +30,7 @@ static void check_graphics_ip(const struct xe_graphics_desc *graphics)
 
 static void check_media_ip(const struct xe_media_desc *media)
 {
-	struct kunit *test = xe_cur_kunit();
+	struct kunit *test = kunit_get_current_test();
 	u64 mask = media->hw_engine_mask;
 
 	/* VCS, VECS and GSCCS engines are allowed on the media IP */
diff --git a/drivers/gpu/drm/xe/tests/xe_test.h b/drivers/gpu/drm/xe/tests/xe_test.h
index 7a1ae213e750a..55e5b5bedccc6 100644
--- a/drivers/gpu/drm/xe/tests/xe_test.h
+++ b/drivers/gpu/drm/xe/tests/xe_test.h
@@ -9,8 +9,8 @@
 #include <linux/types.h>
 
 #if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
-#include <linux/sched.h>
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 
 /*
  * Each test that provides a kunit private test structure, place a test id
@@ -32,7 +32,6 @@ struct xe_test_priv {
 #define XE_TEST_DECLARE(x) x
 #define XE_TEST_ONLY(x) unlikely(x)
 #define XE_TEST_EXPORT
-#define xe_cur_kunit() current->kunit_test
 
 /**
  * xe_cur_kunit_priv - Obtain the struct xe_test_priv pointed to by
@@ -48,10 +47,10 @@ xe_cur_kunit_priv(enum xe_test_priv_id id)
 {
 	struct xe_test_priv *priv;
 
-	if (!xe_cur_kunit())
+	if (!kunit_get_current_test())
 		return NULL;
 
-	priv = xe_cur_kunit()->priv;
+	priv = kunit_get_current_test()->priv;
 	return priv->id == id ? priv : NULL;
 }
 
@@ -60,7 +59,6 @@ xe_cur_kunit_priv(enum xe_test_priv_id id)
 #define XE_TEST_DECLARE(x)
 #define XE_TEST_ONLY(x) 0
 #define XE_TEST_EXPORT static
-#define xe_cur_kunit() NULL
 #define xe_cur_kunit_priv(_id) NULL
 
 #endif
-- 
2.47.0


