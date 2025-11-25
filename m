Return-Path: <stable+bounces-196901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A26C8530A
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 14:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E12AA4E9D86
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6B51D516C;
	Tue, 25 Nov 2025 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWTH3QfP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65121507F
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764077659; cv=none; b=ZxOOIY2rd1Dt11bTTRpyYMOXWQrfybVZyXI5VTDiEABC80ZGVw0cDl6OCnHJkJUJprPgFGRpW+c48OdTkkSrNr3DtKVS4JMoU+gYrE4yay1+nbHxToYFxdPdVv47/N/TTvMOwFbYqe+5RXo2nTvLCfQROXW6fmgkJyoG0YQLrKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764077659; c=relaxed/simple;
	bh=ncAmHFRwrd1NdZKJ+0cTeRDuglxHsodpfVMuecLUaUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XJvFexZ0oNXeHfYz0C+kHsD06OD4B+4OOOXXo4LkoxyeB1fjuvLrfMeP3KhwKHtJ+BFzznTNvhwvxFw2Avtx79X6w61obi0a+4VK2gdQon+Mr/FLNLE9c6rm/neqt3+lXKwy1NsRPbI2CsTum/A6Qv4k7T3tSZ6UTMfVrDadroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWTH3QfP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764077657; x=1795613657;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ncAmHFRwrd1NdZKJ+0cTeRDuglxHsodpfVMuecLUaUE=;
  b=TWTH3QfPB/KM5lR/Izrmrr6IoHT9L2in0EBpWW0yRlPv/LhCPzevmNfT
   fPuvbCRuIZEOvw6z+44CRHSXCeuL0tWSFM3MK7FM+3nSRE5V85f+y8XPI
   E0LfR0Kjcn6wDiIt+AjqEzSCEi40K4gfCaFDkIdLYC4RdQYZG/9KUyvPt
   Hg2fFpmymi5Q9L+5SLvrUwNkSHtNfla9M8AFTgioZc2g5uvmfm+cUDguv
   PbKYq6LHiPZZuoOIUTfgvudhtYL/o5V5sXUvyp8nhoqevlO1LgwwccZJt
   wmY1s/OrnJ6jFP/OcRc4955ZOHG31dD7Vrg564qFEGFLGrYk9gFfbLHhL
   g==;
X-CSE-ConnectionGUID: rdIQJMdgSzeQeus9Qer/6w==
X-CSE-MsgGUID: 2lCLMPKDRnS9vnu0jkNZvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65984730"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="65984730"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 05:34:16 -0800
X-CSE-ConnectionGUID: kPttoz08R2qsbry/5BzHAA==
X-CSE-MsgGUID: P21qfUWyRSKjOvqQfWbRYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="192726793"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com) ([10.245.246.222])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 05:34:12 -0800
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	=?UTF-8?q?=EA=B9=80=EA=B0=95=EB=AF=BC?= <km.kim1503@gmail.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Krzysztof Karas <krzysztof.karas@intel.com>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [PATCH] drm/i915/gem: NULL-initialize the eb->vma[].vma pointers in gem_do_execbuffer
Date: Tue, 25 Nov 2025 14:33:38 +0100
Message-ID: <20251125133337.26483-2-krzysztof.niemiec@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize eb->vma[].vma pointers to NULL when the eb structure is first
set up.

During the execution of eb_lookup_vmas(), the eb->vma array is
successively filled up with struct eb_vma objects. This process includes
calling eb_add_vma(), which might fail; however, even in the event of
failure, eb->vma[i].vma is set for the currently processed buffer.

If eb_add_vma() fails, eb_lookup_vmas() returns with an error, which
prompts a call to eb_release_vmas() to clean up the mess. Since
eb_lookup_vmas() might fail during processing any (possibly not first)
buffer, eb_release_vmas() checks whether a buffer's vma is NULL to know
at what point did the lookup function fail.

In eb_lookup_vmas(), eb->vma[i].vma is set to NULL if either the helper
function eb_lookup_vma() or eb_validate_vma() fails. eb->vma[i+1].vma is
set to NULL in case i915_gem_object_userptr_submit_init() fails; the
current one needs to be cleaned up by eb_release_vmas() at this point,
so the next one is set. If eb_add_vma() fails, neither the current nor
the next vma is nullified, which is a source of a NULL deref bug
described in [1].

When entering eb_lookup_vmas(), the vma pointers are set to the slab
poison value, instead of NULL. This doesn't matter for the actual
lookup, since it gets overwritten anyway, however the eb_release_vmas()
function only recognizes NULL as the stopping value, hence the pointers
are being nullified as they go in case of intermediate failure. This
patch changes the approach to filling them all with NULL at the start
instead, rather than handling that manually during failure.

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15062
Fixes: 544460c33821 ("drm/i915: Multi-BB execbuf")
Reported-by: Gangmin Kim <km.kim1503@gmail.com>
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
---
 .../gpu/drm/i915/gem/i915_gem_execbuffer.c    | 27 ++++++-------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index b057c2fa03a4..02120203af55 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -951,13 +951,13 @@ static int eb_lookup_vmas(struct i915_execbuffer *eb)
 		vma = eb_lookup_vma(eb, eb->exec[i].handle);
 		if (IS_ERR(vma)) {
 			err = PTR_ERR(vma);
-			goto err;
+			return err;
 		}
 
 		err = eb_validate_vma(eb, &eb->exec[i], vma);
 		if (unlikely(err)) {
 			i915_vma_put(vma);
-			goto err;
+			return err;
 		}
 
 		err = eb_add_vma(eb, &current_batch, i, vma);
@@ -966,19 +966,8 @@ static int eb_lookup_vmas(struct i915_execbuffer *eb)
 
 		if (i915_gem_object_is_userptr(vma->obj)) {
 			err = i915_gem_object_userptr_submit_init(vma->obj);
-			if (err) {
-				if (i + 1 < eb->buffer_count) {
-					/*
-					 * Execbuffer code expects last vma entry to be NULL,
-					 * since we already initialized this entry,
-					 * set the next value to NULL or we mess up
-					 * cleanup handling.
-					 */
-					eb->vma[i + 1].vma = NULL;
-				}
-
+			if (err)
 				return err;
-			}
 
 			eb->vma[i].flags |= __EXEC_OBJECT_USERPTR_INIT;
 			eb->args->flags |= __EXEC_USERPTR_USED;
@@ -986,10 +975,6 @@ static int eb_lookup_vmas(struct i915_execbuffer *eb)
 	}
 
 	return 0;
-
-err:
-	eb->vma[i].vma = NULL;
-	return err;
 }
 
 static int eb_lock_vmas(struct i915_execbuffer *eb)
@@ -3362,6 +3347,7 @@ i915_gem_do_execbuffer(struct drm_device *dev,
 	struct sync_file *out_fence = NULL;
 	int out_fence_fd = -1;
 	int err;
+	int i;
 
 	BUILD_BUG_ON(__EXEC_INTERNAL_FLAGS & ~__I915_EXEC_ILLEGAL_FLAGS);
 	BUILD_BUG_ON(__EXEC_OBJECT_INTERNAL_FLAGS &
@@ -3375,7 +3361,10 @@ i915_gem_do_execbuffer(struct drm_device *dev,
 
 	eb.exec = exec;
 	eb.vma = (struct eb_vma *)(exec + args->buffer_count + 1);
-	eb.vma[0].vma = NULL;
+
+	for (i = 0; i < args->buffer_count; i++)
+		eb.vma[i].vma = NULL;
+
 	eb.batch_pool = NULL;
 
 	eb.invalid_flags = __EXEC_OBJECT_UNKNOWN_FLAGS;
-- 
2.45.2


