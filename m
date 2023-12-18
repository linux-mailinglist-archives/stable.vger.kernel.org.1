Return-Path: <stable+bounces-7332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1C2817211
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9641F23A32
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BF44FF87;
	Mon, 18 Dec 2023 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="05QdF8SY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E13F3A1C6;
	Mon, 18 Dec 2023 14:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FA0C433C7;
	Mon, 18 Dec 2023 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908185;
	bh=gq5qG6dluvApFjD7wF0TRrrQ0B3igRkpw9KgZ0iCL3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=05QdF8SYw7immsI2lRM9Z9eeBkh5CnIl+AnMjtdqgaoitnHVacNYR/4X31/J8cPXa
	 G+15vfxRkBdh67KsRqingLGXKp6nTLF/VQ60ge2BpEoV96jwVDFJSsp/jlwOxmDPh3
	 S6LCQfBC+4Lz2/Uhx7eeZOCS1msGFnRMFhD8jFrk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Alan Previn Teres Alexis <alan.previn.teres.alexis@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 083/166] drm/i915: Use internal class when counting engine resets
Date: Mon, 18 Dec 2023 14:50:49 +0100
Message-ID: <20231218135108.718831379@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

[ Upstream commit 1f721a93a528268fa97875cff515d1fcb69f4f44 ]

Commit 503579448db9 ("drm/i915/gsc: Mark internal GSC engine with reserved uabi class")
made the GSC0 engine not have a valid uabi class and so broke the engine
reset counting, which in turn was made class based in cb823ed9915b ("drm/i915/gt: Use intel_gt as the primary object for handling resets").

Despite the title and commit text of the latter is not mentioning it (and
has left the storage array incorrectly sized), tracking by class, despite
it adding aliasing in hypthotetical multi-tile systems, is handy for
virtual engines which for instance do not have a valid engine->id.

Therefore we keep that but just change it to use the internal class which
is always valid. We also add a helper to increment the count, which
aligns with the existing getter.

What was broken without this fix were out of bounds reads every time a
reset would happen on the GSC0 engine, or during selftests when storing
and cross-checking the counts in igt_live_test_begin and
igt_live_test_end.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Fixes: 503579448db9 ("drm/i915/gsc: Mark internal GSC engine with reserved uabi class")
[tursulin: fixed Fixes tag]
Reported-by: Alan Previn Teres Alexis <alan.previn.teres.alexis@intel.com>
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231201122109.729006-2-tvrtko.ursulin@linux.intel.com
(cherry picked from commit cf9cb028ac56696ff879af1154c4b2f0b12701fd)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/intel_reset.c             |  2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c |  5 +++--
 drivers/gpu/drm/i915/i915_gpu_error.h             | 12 ++++++++++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
index cc6bd21a3e51f..5fa57a34cf4bb 100644
--- a/drivers/gpu/drm/i915/gt/intel_reset.c
+++ b/drivers/gpu/drm/i915/gt/intel_reset.c
@@ -1297,7 +1297,7 @@ int __intel_engine_reset_bh(struct intel_engine_cs *engine, const char *msg)
 	if (msg)
 		drm_notice(&engine->i915->drm,
 			   "Resetting %s for %s\n", engine->name, msg);
-	atomic_inc(&engine->i915->gpu_error.reset_engine_count[engine->uabi_class]);
+	i915_increase_reset_engine_count(&engine->i915->gpu_error, engine);
 
 	ret = intel_gt_reset_engine(engine);
 	if (ret) {
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index dc7b40e06e38a..836e4d9d65ef6 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -4774,7 +4774,8 @@ static void capture_error_state(struct intel_guc *guc,
 			if (match) {
 				intel_engine_set_hung_context(e, ce);
 				engine_mask |= e->mask;
-				atomic_inc(&i915->gpu_error.reset_engine_count[e->uabi_class]);
+				i915_increase_reset_engine_count(&i915->gpu_error,
+								 e);
 			}
 		}
 
@@ -4786,7 +4787,7 @@ static void capture_error_state(struct intel_guc *guc,
 	} else {
 		intel_engine_set_hung_context(ce->engine, ce);
 		engine_mask = ce->engine->mask;
-		atomic_inc(&i915->gpu_error.reset_engine_count[ce->engine->uabi_class]);
+		i915_increase_reset_engine_count(&i915->gpu_error, ce->engine);
 	}
 
 	with_intel_runtime_pm(&i915->runtime_pm, wakeref)
diff --git a/drivers/gpu/drm/i915/i915_gpu_error.h b/drivers/gpu/drm/i915/i915_gpu_error.h
index 9f5971f5e9801..48f6c00402c47 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.h
+++ b/drivers/gpu/drm/i915/i915_gpu_error.h
@@ -16,6 +16,7 @@
 
 #include "display/intel_display_device.h"
 #include "gt/intel_engine.h"
+#include "gt/intel_engine_types.h"
 #include "gt/intel_gt_types.h"
 #include "gt/uc/intel_uc_fw.h"
 
@@ -232,7 +233,7 @@ struct i915_gpu_error {
 	atomic_t reset_count;
 
 	/** Number of times an engine has been reset */
-	atomic_t reset_engine_count[I915_NUM_ENGINES];
+	atomic_t reset_engine_count[MAX_ENGINE_CLASS];
 };
 
 struct drm_i915_error_state_buf {
@@ -255,7 +256,14 @@ static inline u32 i915_reset_count(struct i915_gpu_error *error)
 static inline u32 i915_reset_engine_count(struct i915_gpu_error *error,
 					  const struct intel_engine_cs *engine)
 {
-	return atomic_read(&error->reset_engine_count[engine->uabi_class]);
+	return atomic_read(&error->reset_engine_count[engine->class]);
+}
+
+static inline void
+i915_increase_reset_engine_count(struct i915_gpu_error *error,
+				 const struct intel_engine_cs *engine)
+{
+	atomic_inc(&error->reset_engine_count[engine->class]);
 }
 
 #define CORE_DUMP_FLAG_NONE           0x0
-- 
2.43.0




