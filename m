Return-Path: <stable+bounces-137324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF300AA12CF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F514C0EBC
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3779F2528F1;
	Tue, 29 Apr 2025 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UzOBF9Jj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90A9221719;
	Tue, 29 Apr 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945729; cv=none; b=g4skaslpamGT0SwaRM4bqJlrx1t3pMvrR5AVoTdpJF9NJb9M194PoFZ+Mb2Lxp8NLnkGBbjlWzGxYnVUjpGiNp9jFqK0jq/c/dkt0U6cmWP6JMfuOlySZkDyjHvIZG3mMvO7nFL0Q4yZG2oNfMa5HcJ4BAipfh+htaEDRlp1KJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945729; c=relaxed/simple;
	bh=EQu2VgYQNm5GKQmhjBpEimNwX4YP2ABdfcR8JKanaWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQrlDTeAX8ELCtX+5aF/TK+VpPMs9QgAL9bzCJbaNoDNb/bu2UntiT9ZLpxLsh/6S/fGmQvJjctGVTrVsQdMVWILHOS5eldYkRtUPBOQECqXbf6OYeLP8FOx8wp1mRkiZ1kFIxJPTVwWaf/0POsHnMYg1y/+QnizHwJAG31bQbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UzOBF9Jj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717EAC4CEE3;
	Tue, 29 Apr 2025 16:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945728;
	bh=EQu2VgYQNm5GKQmhjBpEimNwX4YP2ABdfcR8JKanaWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UzOBF9JjOQFvWV2uPsGlsaYA7CN2PgxBrXzuHsw9mfFJKd5ZrUHXBpL5pjeWtI7j1
	 SEIJP0C90oKeWIjdSRf+bPQNCvyI3aCf76FyVuN1jzs+q8DZ4wqgpti+Pcl9MrbbO3
	 dFoybCMDmWsmeIdd5UvmBTz3AAJBhTa+OjztjLNI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 030/311] drm/xe/rtp: Drop sentinels from arg to xe_rtp_process_to_sr()
Date: Tue, 29 Apr 2025 18:37:47 +0200
Message-ID: <20250429161122.271767314@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas De Marchi <lucas.demarchi@intel.com>

[ Upstream commit cedf23842d7433eb32cb782a637bb870fb096a3b ]

There's a mismatch on API: while xe_rtp_process_to_sr() processes
entries until an entry without name, the active tracking with
xe_rtp_process_ctx_enable_active_tracking() needs to use the number of
elements. The number of elements is taken everywhere using ARRAY_SIZE(),
but that will have one entry too many. This leads to the following
warning, as reported by lkp:

   drivers/gpu/drm/xe/xe_tuning.c: In function 'xe_tuning_dump':
>> include/drm/drm_print.h:228:31: warning: '%s' directive argument is null [-Wformat-overflow=]
     228 |         drm_printf((printer), "%.*s" fmt, (indent), "\t\t\t\t\tX", ##__VA_ARGS__)
         |                               ^~~~~~
   drivers/gpu/drm/xe/xe_tuning.c:226:17: note: in expansion of macro 'drm_printf_indent'
     226 |                 drm_printf_indent(p, 1, "%s\n", engine_tunings[idx].name);
         |                 ^~~~~~~~~~~~~~~~~

That's because it will still process the last entry when tracking the
active tunings. The same issue exists in the WAs. Change
xe_rtp_process_to_sr() to also take the number of elements so the empty
entry can be removed and the warning should go away. Fixing on the
active-tracking side would more fragile as the it would need a `- 1`
everywhere and continue to use a different approach for number of
elements.

Aside from the warning, it's a non-issue as there would always be enough
bits allocated and the last entry would never be active since
xe_rtp_process_to_sr() stops on the sentinel.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503021906.P2MwAvyK-lkp@intel.com/
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250306-fix-print-warning-v1-1-979c3dc03c0d@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 8aa8c2d4214e1771c32101d70740002662d31bb7)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Stable-dep-of: 262de94a3a7e ("drm/xe: Ensure fixed_slice_mode gets set after ccs_mode change")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/tests/xe_rtp_test.c |  2 +-
 drivers/gpu/drm/xe/xe_hw_engine.c      |  6 ++----
 drivers/gpu/drm/xe/xe_reg_whitelist.c  |  4 ++--
 drivers/gpu/drm/xe/xe_rtp.c            |  6 +++++-
 drivers/gpu/drm/xe/xe_rtp.h            |  2 +-
 drivers/gpu/drm/xe/xe_tuning.c         | 12 ++++--------
 drivers/gpu/drm/xe/xe_wa.c             | 12 +++---------
 7 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_rtp_test.c b/drivers/gpu/drm/xe/tests/xe_rtp_test.c
index 36a3b5420fef6..b0254b014fe45 100644
--- a/drivers/gpu/drm/xe/tests/xe_rtp_test.c
+++ b/drivers/gpu/drm/xe/tests/xe_rtp_test.c
@@ -320,7 +320,7 @@ static void xe_rtp_process_to_sr_tests(struct kunit *test)
 		count_rtp_entries++;
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, &active, count_rtp_entries);
-	xe_rtp_process_to_sr(&ctx, param->entries, reg_sr);
+	xe_rtp_process_to_sr(&ctx, param->entries, count_rtp_entries, reg_sr);
 
 	xa_for_each(&reg_sr->xa, idx, sre) {
 		if (idx == param->expected_reg.addr)
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index fc447751fe786..223b95de388cb 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -400,10 +400,9 @@ xe_hw_engine_setup_default_lrc_state(struct xe_hw_engine *hwe)
 					   PREEMPT_GPGPU_THREAD_GROUP_LEVEL)),
 		  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE)
 		},
-		{}
 	};
 
-	xe_rtp_process_to_sr(&ctx, lrc_setup, &hwe->reg_lrc);
+	xe_rtp_process_to_sr(&ctx, lrc_setup, ARRAY_SIZE(lrc_setup), &hwe->reg_lrc);
 }
 
 static void
@@ -459,10 +458,9 @@ hw_engine_setup_default_state(struct xe_hw_engine *hwe)
 		  XE_RTP_ACTIONS(SET(CSFE_CHICKEN1(0), CS_PRIORITY_MEM_READ,
 				     XE_RTP_ACTION_FLAG(ENGINE_BASE)))
 		},
-		{}
 	};
 
-	xe_rtp_process_to_sr(&ctx, engine_entries, &hwe->reg_sr);
+	xe_rtp_process_to_sr(&ctx, engine_entries, ARRAY_SIZE(engine_entries), &hwe->reg_sr);
 }
 
 static const struct engine_info *find_engine_info(enum xe_engine_class class, int instance)
diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index edab5d4e3ba5e..23f6c81d99946 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -88,7 +88,6 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 				   RING_FORCE_TO_NONPRIV_ACCESS_RD |
 				   RING_FORCE_TO_NONPRIV_RANGE_4))
 	},
-	{}
 };
 
 static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
@@ -137,7 +136,8 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
-	xe_rtp_process_to_sr(&ctx, register_whitelist, &hwe->reg_whitelist);
+	xe_rtp_process_to_sr(&ctx, register_whitelist, ARRAY_SIZE(register_whitelist),
+			     &hwe->reg_whitelist);
 	whitelist_apply_to_hwe(hwe);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_rtp.c b/drivers/gpu/drm/xe/xe_rtp.c
index 7a1c78fdfc92e..13bb62d3e615e 100644
--- a/drivers/gpu/drm/xe/xe_rtp.c
+++ b/drivers/gpu/drm/xe/xe_rtp.c
@@ -237,6 +237,7 @@ static void rtp_mark_active(struct xe_device *xe,
  *                        the save-restore argument.
  * @ctx: The context for processing the table, with one of device, gt or hwe
  * @entries: Table with RTP definitions
+ * @n_entries: Number of entries to process, usually ARRAY_SIZE(entries)
  * @sr: Save-restore struct where matching rules execute the action. This can be
  *      viewed as the "coalesced view" of multiple the tables. The bits for each
  *      register set are expected not to collide with previously added entries
@@ -247,6 +248,7 @@ static void rtp_mark_active(struct xe_device *xe,
  */
 void xe_rtp_process_to_sr(struct xe_rtp_process_ctx *ctx,
 			  const struct xe_rtp_entry_sr *entries,
+			  size_t n_entries,
 			  struct xe_reg_sr *sr)
 {
 	const struct xe_rtp_entry_sr *entry;
@@ -259,7 +261,9 @@ void xe_rtp_process_to_sr(struct xe_rtp_process_ctx *ctx,
 	if (IS_SRIOV_VF(xe))
 		return;
 
-	for (entry = entries; entry && entry->name; entry++) {
+	xe_assert(xe, entries);
+
+	for (entry = entries; entry - entries < n_entries; entry++) {
 		bool match = false;
 
 		if (entry->flags & XE_RTP_ENTRY_FLAG_FOREACH_ENGINE) {
diff --git a/drivers/gpu/drm/xe/xe_rtp.h b/drivers/gpu/drm/xe/xe_rtp.h
index 38b9f13bba5e5..4fe736a11c42b 100644
--- a/drivers/gpu/drm/xe/xe_rtp.h
+++ b/drivers/gpu/drm/xe/xe_rtp.h
@@ -430,7 +430,7 @@ void xe_rtp_process_ctx_enable_active_tracking(struct xe_rtp_process_ctx *ctx,
 
 void xe_rtp_process_to_sr(struct xe_rtp_process_ctx *ctx,
 			  const struct xe_rtp_entry_sr *entries,
-			  struct xe_reg_sr *sr);
+			  size_t n_entries, struct xe_reg_sr *sr);
 
 void xe_rtp_process(struct xe_rtp_process_ctx *ctx,
 		    const struct xe_rtp_entry *entries);
diff --git a/drivers/gpu/drm/xe/xe_tuning.c b/drivers/gpu/drm/xe/xe_tuning.c
index 23c46dd85e149..a61a2917590fe 100644
--- a/drivers/gpu/drm/xe/xe_tuning.c
+++ b/drivers/gpu/drm/xe/xe_tuning.c
@@ -85,8 +85,6 @@ static const struct xe_rtp_entry_sr gt_tunings[] = {
 	  XE_RTP_RULES(MEDIA_VERSION(2000)),
 	  XE_RTP_ACTIONS(SET(XE2LPM_SCRATCH3_LBCF, RWFLUSHALLEN))
 	},
-
-	{}
 };
 
 static const struct xe_rtp_entry_sr engine_tunings[] = {
@@ -95,7 +93,6 @@ static const struct xe_rtp_entry_sr engine_tunings[] = {
 		       ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(SET(SAMPLER_MODE, INDIRECT_STATE_BASE_ADDR_OVERRIDE))
 	},
-	{}
 };
 
 static const struct xe_rtp_entry_sr lrc_tunings[] = {
@@ -133,8 +130,6 @@ static const struct xe_rtp_entry_sr lrc_tunings[] = {
 	  XE_RTP_ACTIONS(FIELD_SET(FF_MODE, VS_HIT_MAX_VALUE_MASK,
 				   REG_FIELD_PREP(VS_HIT_MAX_VALUE_MASK, 0x3f)))
 	},
-
-	{}
 };
 
 /**
@@ -175,7 +170,7 @@ void xe_tuning_process_gt(struct xe_gt *gt)
 	xe_rtp_process_ctx_enable_active_tracking(&ctx,
 						  gt->tuning_active.gt,
 						  ARRAY_SIZE(gt_tunings));
-	xe_rtp_process_to_sr(&ctx, gt_tunings, &gt->reg_sr);
+	xe_rtp_process_to_sr(&ctx, gt_tunings, ARRAY_SIZE(gt_tunings), &gt->reg_sr);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_tuning_process_gt);
 
@@ -186,7 +181,8 @@ void xe_tuning_process_engine(struct xe_hw_engine *hwe)
 	xe_rtp_process_ctx_enable_active_tracking(&ctx,
 						  hwe->gt->tuning_active.engine,
 						  ARRAY_SIZE(engine_tunings));
-	xe_rtp_process_to_sr(&ctx, engine_tunings, &hwe->reg_sr);
+	xe_rtp_process_to_sr(&ctx, engine_tunings, ARRAY_SIZE(engine_tunings),
+			     &hwe->reg_sr);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_tuning_process_engine);
 
@@ -205,7 +201,7 @@ void xe_tuning_process_lrc(struct xe_hw_engine *hwe)
 	xe_rtp_process_ctx_enable_active_tracking(&ctx,
 						  hwe->gt->tuning_active.lrc,
 						  ARRAY_SIZE(lrc_tunings));
-	xe_rtp_process_to_sr(&ctx, lrc_tunings, &hwe->reg_lrc);
+	xe_rtp_process_to_sr(&ctx, lrc_tunings, ARRAY_SIZE(lrc_tunings), &hwe->reg_lrc);
 }
 
 void xe_tuning_dump(struct xe_gt *gt, struct drm_printer *p)
diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index db99663963010..65bfb2f894d00 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -279,8 +279,6 @@ static const struct xe_rtp_entry_sr gt_was[] = {
 	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F10(0), RAMDFTUNIT_CLKGATE_DIS)),
 	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
 	},
-
-	{}
 };
 
 static const struct xe_rtp_entry_sr engine_was[] = {
@@ -623,8 +621,6 @@ static const struct xe_rtp_entry_sr engine_was[] = {
 		       FUNC(xe_rtp_match_first_render_or_compute)),
 	  XE_RTP_ACTIONS(SET(TDL_TSL_CHICKEN, RES_CHK_SPR_DIS))
 	},
-
-	{}
 };
 
 static const struct xe_rtp_entry_sr lrc_was[] = {
@@ -817,8 +813,6 @@ static const struct xe_rtp_entry_sr lrc_was[] = {
 			     DIS_PARTIAL_AUTOSTRIP |
 			     DIS_AUTOSTRIP))
 	},
-
-	{}
 };
 
 static __maybe_unused const struct xe_rtp_entry oob_was[] = {
@@ -860,7 +854,7 @@ void xe_wa_process_gt(struct xe_gt *gt)
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, gt->wa_active.gt,
 						  ARRAY_SIZE(gt_was));
-	xe_rtp_process_to_sr(&ctx, gt_was, &gt->reg_sr);
+	xe_rtp_process_to_sr(&ctx, gt_was, ARRAY_SIZE(gt_was), &gt->reg_sr);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_wa_process_gt);
 
@@ -878,7 +872,7 @@ void xe_wa_process_engine(struct xe_hw_engine *hwe)
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, hwe->gt->wa_active.engine,
 						  ARRAY_SIZE(engine_was));
-	xe_rtp_process_to_sr(&ctx, engine_was, &hwe->reg_sr);
+	xe_rtp_process_to_sr(&ctx, engine_was, ARRAY_SIZE(engine_was), &hwe->reg_sr);
 }
 
 /**
@@ -895,7 +889,7 @@ void xe_wa_process_lrc(struct xe_hw_engine *hwe)
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, hwe->gt->wa_active.lrc,
 						  ARRAY_SIZE(lrc_was));
-	xe_rtp_process_to_sr(&ctx, lrc_was, &hwe->reg_lrc);
+	xe_rtp_process_to_sr(&ctx, lrc_was, ARRAY_SIZE(lrc_was), &hwe->reg_lrc);
 }
 
 /**
-- 
2.39.5




