Return-Path: <stable+bounces-108655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE3CA115F4
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 01:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0841D1888434
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 00:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0447184F;
	Wed, 15 Jan 2025 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7BMgD8R"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD9E4C6C
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 00:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736900027; cv=none; b=n+HKxSiktUdgkqRMY4DjkMW+pyXmm0rVnEc3bIba6LwEIkc282/qheUOrMn50rvAO8VbxuAdrLAX+P2E3ANlJzf3ZglWRCF0WV11LvUjZOG3zL4ySi+z5OXN8PzyEFPSKSAnT9mO+A5UvHREBY1phxJk/C4CpThxB7CXJXBuYnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736900027; c=relaxed/simple;
	bh=XELd0H26p70FWGslkgds25MVjN+qHMsjNGPtdEnT2sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ff6bpSREANY2HtuMT8V4OYJ+ARAIJ467u49WUyqeY1xUzIF8SLK9V5pobQ41KzROAeNRqbBst/qQVzI6NQt8WdLEdgcmIY3gBnDA6QcNCCLgJoKcSzOGTzDk99U7IQ+6LPGOUVA2U5JMPQVXL5d7zesRUx4hbm52xvAfqtTrEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7BMgD8R; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736900026; x=1768436026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XELd0H26p70FWGslkgds25MVjN+qHMsjNGPtdEnT2sU=;
  b=m7BMgD8RRMgpzc4WRNeMqrsGd//D/m8aWXgvPpDkBKsY/TfpIAQJSG9H
   hd+v7S8AfvaU51PuZ6y2VovjZ6ouEuxph3mmH+iOGRjSSsi2aLtOrVUve
   Sr7NCTFfO5XV+3OX/23ZMUrug1sx5wjQhJUjnIOmCS7GnXYy/Y3elAcJl
   3ip5GJtYHZswAoN6Vqbh7vD7v2kBO00l6nY+ylG6HzjBVBpz6ZKclPzMd
   t6hGVMOGqP55ML2kYwPC06m/id1e0K9jyIRI1wK9kf3l3eFMNmQlfTQ2P
   mtjH/jBdD2zrCEuoX9HEAbZuft4QF9YAsviwqGjLBdImC/Eb1c4FZMVUh
   w==;
X-CSE-ConnectionGUID: D6lIA3lkRXSaT7ZQyHX2Cw==
X-CSE-MsgGUID: TchCm+8JSa61fRpIDaEbuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36430740"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="36430740"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:13:45 -0800
X-CSE-ConnectionGUID: iV1pwWIvSIu0IiWxb9pgbw==
X-CSE-MsgGUID: CnRo+vn/S5m2do6Fjx9H+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105831897"
Received: from valcore-skull-1.fm.intel.com ([10.1.39.17])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:13:45 -0800
From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/i915/guc: Debug print LRC state entries only if the context is pinned
Date: Tue, 14 Jan 2025 16:13:34 -0800
Message-ID: <20250115001334.3875347-1-daniele.ceraolospurio@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the context is unpinned the backing memory can also be unpinned,
so any accesses via the lrc_reg_state pointer can end up in unmapped
memory. To avoid that, make sure to only access that memory if the
context is pinned when printing its info.

v2: fix newline alignment

Fixes: 28ff6520a34d ("drm/i915/guc: Update GuC debugfs to support new GuC")
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v5.15+
Reviewed-by: John Harrison <John.C.Harrison@Intel.com>
---
 .../gpu/drm/i915/gt/uc/intel_guc_submission.c | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index 12f1ba7ca9c1..158f78a0941f 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -5519,12 +5519,20 @@ static inline void guc_log_context(struct drm_printer *p,
 {
 	drm_printf(p, "GuC lrc descriptor %u:\n", ce->guc_id.id);
 	drm_printf(p, "\tHW Context Desc: 0x%08x\n", ce->lrc.lrca);
-	drm_printf(p, "\t\tLRC Head: Internal %u, Memory %u\n",
-		   ce->ring->head,
-		   ce->lrc_reg_state[CTX_RING_HEAD]);
-	drm_printf(p, "\t\tLRC Tail: Internal %u, Memory %u\n",
-		   ce->ring->tail,
-		   ce->lrc_reg_state[CTX_RING_TAIL]);
+	if (intel_context_pin_if_active(ce)) {
+		drm_printf(p, "\t\tLRC Head: Internal %u, Memory %u\n",
+			   ce->ring->head,
+			   ce->lrc_reg_state[CTX_RING_HEAD]);
+		drm_printf(p, "\t\tLRC Tail: Internal %u, Memory %u\n",
+			   ce->ring->tail,
+			   ce->lrc_reg_state[CTX_RING_TAIL]);
+		intel_context_unpin(ce);
+	} else {
+		drm_printf(p, "\t\tLRC Head: Internal %u, Memory not pinned\n",
+			   ce->ring->head);
+		drm_printf(p, "\t\tLRC Tail: Internal %u, Memory not pinned\n",
+			   ce->ring->tail);
+	}
 	drm_printf(p, "\t\tContext Pin Count: %u\n",
 		   atomic_read(&ce->pin_count));
 	drm_printf(p, "\t\tGuC ID Ref Count: %u\n",
-- 
2.43.0


