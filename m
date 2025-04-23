Return-Path: <stable+bounces-135857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE4A990BB
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC291B86489
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80A728C5D2;
	Wed, 23 Apr 2025 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rcPvcTnu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52F727F4D9;
	Wed, 23 Apr 2025 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421025; cv=none; b=Cy7wSJzQPkB/8GqL+x7dWdz37alT3q8aPJV2WINCzS25V3QwezjaJUItJhgH4bBjeyyTf4HdCXfwjuP/DB84JupVgz8PUNPdOSPduuNR0Kf3AwTU+YHW3ExbiiL1Lur1vIehKft9j9csnrIyIT/TuuZYGmwdvAcjyq5wIrRo9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421025; c=relaxed/simple;
	bh=emPccGpPVsm/CLpDuhnlKJ7jH5Jf0vZzfgkxKFUocBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COxWgdz+zuFophRGM6n1zWJz6cKx6RvfBFP69FrAlhnzquvTeOJwZ0vM8hIXijRYuGNqhSF/iZueie0PWr0i7GujzdUt4hJHZxaslv9nJW8GlWc9fj7o6iouRUgJzoFEVizP1ATvxdhFbGDU4D4encxNihoOA3SooVrH0aDh9UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rcPvcTnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AE0C4CEE2;
	Wed, 23 Apr 2025 15:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421025;
	bh=emPccGpPVsm/CLpDuhnlKJ7jH5Jf0vZzfgkxKFUocBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rcPvcTnupo0uYZdqwN9Pa9IY1Q8aPRp6MGHWQ/yoqfjQ3Wz7VhrLZnbaQfQdKLBf7
	 t4sdQsDvD3NPxVigeODSjOuI4IjK600zeTyiSl6F2HlwSiD1jhbI65Mw2fgnGTUerX
	 h+ZuOBFSxNv95aVpV0/mv7e+wqZVF4lSuajXw3rY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chee Yin Wong <chee.yin.wong@intel.com>,
	John Harrison <john.c.harrison@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.12 183/223] drm/xe: Set LRC addresses before guc load
Date: Wed, 23 Apr 2025 16:44:15 +0200
Message-ID: <20250423142624.625475813@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas De Marchi <lucas.demarchi@intel.com>

commit 6405f5b70b1c240ffddef01c7a140498f47d4fe7 upstream.

The metadata saved in the ADS is read by GuC when it's initialized.
Saving the addresses to the LRCs when they are populated is too late as
GuC will keep using the old ones.

This was causing GuC to use the RCS LRC for any engine class. It's not a
big problem on a Linux-only scenario since the they are used by GuC only
on media engines when the watchdog is triggered. However, in a
virtualization scenario with Windows as the VF, it causes the wrong LRCs
to be loaded as the watchdog is used for all engines.

Fix it by letting guc_golden_lrc_init() initialize the metadata, like
other *_init() functions, and later guc_golden_lrc_populate() to copy
the LRCs to the right places. The former is called before the second GuC
load, while the latter is called after LRCs have been recorded.

Cc: Chee Yin Wong <chee.yin.wong@intel.com>
Cc: John Harrison <john.c.harrison@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: <stable@vger.kernel.org> # v6.11+
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Tested-by: Chee Yin Wong <chee.yin.wong@intel.com>
Link: https://lore.kernel.org/r/20250409-fix-guc-ads-v1-1-494135f7a5d0@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit c31a0b6402d15b530514eee9925adfcb8cfbb1c9)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_guc_ads.c |   75 ++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 30 deletions(-)

--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -483,24 +483,52 @@ static void fill_engine_enable_masks(str
 		       engine_enable_mask(gt, XE_ENGINE_CLASS_OTHER));
 }
 
-static void guc_prep_golden_lrc_null(struct xe_guc_ads *ads)
+/*
+ * Write the offsets corresponding to the golden LRCs. The actual data is
+ * populated later by guc_golden_lrc_populate()
+ */
+static void guc_golden_lrc_init(struct xe_guc_ads *ads)
 {
 	struct xe_device *xe = ads_to_xe(ads);
+	struct xe_gt *gt = ads_to_gt(ads);
 	struct iosys_map info_map = IOSYS_MAP_INIT_OFFSET(ads_to_map(ads),
 			offsetof(struct __guc_ads_blob, system_info));
-	u8 guc_class;
+	size_t alloc_size, real_size;
+	u32 addr_ggtt, offset;
+	int class;
+
+	offset = guc_ads_golden_lrc_offset(ads);
+	addr_ggtt = xe_bo_ggtt_addr(ads->bo) + offset;
+
+	for (class = 0; class < XE_ENGINE_CLASS_MAX; ++class) {
+		u8 guc_class;
+
+		guc_class = xe_engine_class_to_guc_class(class);
 
-	for (guc_class = 0; guc_class <= GUC_MAX_ENGINE_CLASSES; ++guc_class) {
 		if (!info_map_read(xe, &info_map,
 				   engine_enabled_masks[guc_class]))
 			continue;
 
+		real_size = xe_gt_lrc_size(gt, class);
+		alloc_size = PAGE_ALIGN(real_size);
+
+		/*
+		 * This interface is slightly confusing. We need to pass the
+		 * base address of the full golden context and the size of just
+		 * the engine state, which is the section of the context image
+		 * that starts after the execlists LRC registers. This is
+		 * required to allow the GuC to restore just the engine state
+		 * when a watchdog reset occurs.
+		 * We calculate the engine state size by removing the size of
+		 * what comes before it in the context image (which is identical
+		 * on all engines).
+		 */
 		ads_blob_write(ads, ads.eng_state_size[guc_class],
-			       guc_ads_golden_lrc_size(ads) -
-			       xe_lrc_skip_size(xe));
+			       real_size - xe_lrc_skip_size(xe));
 		ads_blob_write(ads, ads.golden_context_lrca[guc_class],
-			       xe_bo_ggtt_addr(ads->bo) +
-			       guc_ads_golden_lrc_offset(ads));
+			       addr_ggtt);
+
+		addr_ggtt += alloc_size;
 	}
 }
 
@@ -710,7 +738,7 @@ void xe_guc_ads_populate_minimal(struct
 
 	xe_map_memset(ads_to_xe(ads), ads_to_map(ads), 0, 0, ads->bo->size);
 	guc_policies_init(ads);
-	guc_prep_golden_lrc_null(ads);
+	guc_golden_lrc_init(ads);
 	guc_mapping_table_init_invalid(gt, &info_map);
 	guc_doorbell_init(ads);
 
@@ -736,7 +764,7 @@ void xe_guc_ads_populate(struct xe_guc_a
 	guc_policies_init(ads);
 	fill_engine_enable_masks(gt, &info_map);
 	guc_mmio_reg_state_init(ads);
-	guc_prep_golden_lrc_null(ads);
+	guc_golden_lrc_init(ads);
 	guc_mapping_table_init(gt, &info_map);
 	guc_capture_list_init(ads);
 	guc_doorbell_init(ads);
@@ -756,18 +784,22 @@ void xe_guc_ads_populate(struct xe_guc_a
 		       guc_ads_private_data_offset(ads));
 }
 
-static void guc_populate_golden_lrc(struct xe_guc_ads *ads)
+/*
+ * After the golden LRC's are recorded for each engine class by the first
+ * submission, copy them to the ADS, as initialized earlier by
+ * guc_golden_lrc_init().
+ */
+static void guc_golden_lrc_populate(struct xe_guc_ads *ads)
 {
 	struct xe_device *xe = ads_to_xe(ads);
 	struct xe_gt *gt = ads_to_gt(ads);
 	struct iosys_map info_map = IOSYS_MAP_INIT_OFFSET(ads_to_map(ads),
 			offsetof(struct __guc_ads_blob, system_info));
 	size_t total_size = 0, alloc_size, real_size;
-	u32 addr_ggtt, offset;
+	u32 offset;
 	int class;
 
 	offset = guc_ads_golden_lrc_offset(ads);
-	addr_ggtt = xe_bo_ggtt_addr(ads->bo) + offset;
 
 	for (class = 0; class < XE_ENGINE_CLASS_MAX; ++class) {
 		u8 guc_class;
@@ -784,26 +816,9 @@ static void guc_populate_golden_lrc(stru
 		alloc_size = PAGE_ALIGN(real_size);
 		total_size += alloc_size;
 
-		/*
-		 * This interface is slightly confusing. We need to pass the
-		 * base address of the full golden context and the size of just
-		 * the engine state, which is the section of the context image
-		 * that starts after the execlists LRC registers. This is
-		 * required to allow the GuC to restore just the engine state
-		 * when a watchdog reset occurs.
-		 * We calculate the engine state size by removing the size of
-		 * what comes before it in the context image (which is identical
-		 * on all engines).
-		 */
-		ads_blob_write(ads, ads.eng_state_size[guc_class],
-			       real_size - xe_lrc_skip_size(xe));
-		ads_blob_write(ads, ads.golden_context_lrca[guc_class],
-			       addr_ggtt);
-
 		xe_map_memcpy_to(xe, ads_to_map(ads), offset,
 				 gt->default_lrc[class], real_size);
 
-		addr_ggtt += alloc_size;
 		offset += alloc_size;
 	}
 
@@ -812,7 +827,7 @@ static void guc_populate_golden_lrc(stru
 
 void xe_guc_ads_populate_post_load(struct xe_guc_ads *ads)
 {
-	guc_populate_golden_lrc(ads);
+	guc_golden_lrc_populate(ads);
 }
 
 static int guc_ads_action_update_policies(struct xe_guc_ads *ads, u32 policy_offset)



