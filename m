Return-Path: <stable+bounces-166446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE85B19D60
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 10:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677A516BCF6
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 08:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EB42309B9;
	Mon,  4 Aug 2025 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QfL8g8kD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4CE7DA6D
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295060; cv=none; b=U8CVXZIXO/QY/GOM0JYZTjYbTqUnggThLlcvHLCbRop7Eourk9ldhqTDtX49gSqPbCQJ5rnnxiDaikqsLRyN08/CZ+X2cbnkmbe1lbMVCQylSKtIyT44WJl/k/m2lUyweyf/fl29TvC38QT0AlTRYDSgAX4bStfXUWR0Ibyn/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295060; c=relaxed/simple;
	bh=AXLc5p8OncA9VSOZd20F/TsrnJJYbX0Z5e+BQNLeMYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SLV6n0+Hy54JAoc+ts3m0uICfjORnYvnce711VYNYCPdh2AnCX6oyNWb2RZ96E9rurzd2JScAylHx+GrMCvMUhbduCeWQkGIfV7fdW1somUPpN1rZFTds6Fh5bUVeti8yjewwr89eSFpDS61cXb19fv+VZDW2VXrQ+TuxWOae/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QfL8g8kD; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754295059; x=1785831059;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AXLc5p8OncA9VSOZd20F/TsrnJJYbX0Z5e+BQNLeMYY=;
  b=QfL8g8kDRAa/eUpYELBLkSNHIlTEwrUnFoQw0jdqTbbundm4FvSqqSdi
   cGguNj7V+GAbXPLh7WX4LLmU/WaHvnA+lEFpGP9mGNEGgBhZAfyb2Gxxz
   TlSXSnRyVmzvmno76SmEX5F30o+0CNz0Z1exGge/gwWC92yGDt/Af64X5
   G2/8N1CsqSvB5TrC0OXU68ahnS1Syr3c1HYCNYDIqrkAFq563rA10gNTk
   +nlZTXpVLNzS0o25R9HhSdZlYntsIX5mIZW8IBpzUnepArprcW1sP6wAU
   F8KTSuPawACZjOjXJ5b9gTtlngqCh0nTLvvrqJzuZpcn0dliE4ExYnDcQ
   Q==;
X-CSE-ConnectionGUID: OSR0vZvmTAq8wTgh9nuXVg==
X-CSE-MsgGUID: PXOaFsv3QGubzSVAck6EDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="81997778"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="81997778"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:10:58 -0700
X-CSE-ConnectionGUID: VV/D3e1nQ8CzLbckqncnFg==
X-CSE-MsgGUID: iUuucKgGSaGuuhJAIhQ79g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="168355673"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO fedora) ([10.245.245.63])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:10:57 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Defer buffer object shrinker write-backs and GPU waits
Date: Mon,  4 Aug 2025 10:10:40 +0200
Message-ID: <20250804081040.2458-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the xe buffer-object shrinker allows GPU waits and write-back,
(typically from kswapd), perform multilpe passes, skipping
subsequent passes if the shrinker number of scanned objects target
is reached.

1) Without GPU waits and write-back
2) Without write-back
3) With both GPU-waits and write-back

This is to avoid stalls and costly write- and readbacks unless they
are really necessary.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5557#note_3035136
Fixes: 00c8efc3180f ("drm/xe: Add a shrinker for xe bos")
Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_shrinker.c | 51 +++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shrinker.c
index 1c3c04d52f55..bc3439bd4450 100644
--- a/drivers/gpu/drm/xe/xe_shrinker.c
+++ b/drivers/gpu/drm/xe/xe_shrinker.c
@@ -54,10 +54,10 @@ xe_shrinker_mod_pages(struct xe_shrinker *shrinker, long shrinkable, long purgea
 	write_unlock(&shrinker->lock);
 }
 
-static s64 xe_shrinker_walk(struct xe_device *xe,
-			    struct ttm_operation_ctx *ctx,
-			    const struct xe_bo_shrink_flags flags,
-			    unsigned long to_scan, unsigned long *scanned)
+static s64 __xe_shrinker_walk(struct xe_device *xe,
+			      struct ttm_operation_ctx *ctx,
+			      const struct xe_bo_shrink_flags flags,
+			      unsigned long to_scan, unsigned long *scanned)
 {
 	unsigned int mem_type;
 	s64 freed = 0, lret;
@@ -93,6 +93,48 @@ static s64 xe_shrinker_walk(struct xe_device *xe,
 	return freed;
 }
 
+/*
+ * Try shrinking idle objects without writeback first, then if not sufficient,
+ * try also non-idle objects and finally if that's not sufficient either,
+ * add writeback. This avoids stalls and explicit writebacks with light or
+ * moderate memory pressure.
+ */
+static s64 xe_shrinker_walk(struct xe_device *xe,
+			    struct ttm_operation_ctx *ctx,
+			    const struct xe_bo_shrink_flags flags,
+			    unsigned long to_scan, unsigned long *scanned)
+{
+	bool no_wait_gpu = true;
+	struct xe_bo_shrink_flags save_flags = flags;
+	s64 lret, freed;
+
+	swap(no_wait_gpu, ctx->no_wait_gpu);
+	save_flags.writeback = false;
+	lret = __xe_shrinker_walk(xe, ctx, save_flags, to_scan, scanned);
+	swap(no_wait_gpu, ctx->no_wait_gpu);
+	if (lret < 0 || *scanned >= to_scan)
+		return lret;
+
+	freed = lret;
+	if (!ctx->no_wait_gpu) {
+		lret = __xe_shrinker_walk(xe, ctx, save_flags, to_scan, scanned);
+		if (lret < 0)
+			return lret;
+		freed += lret;
+	}
+	if (*scanned >= to_scan)
+		return freed;
+
+	if (flags.writeback) {
+		lret = __xe_shrinker_walk(xe, ctx, flags, to_scan, scanned);
+		if (lret < 0)
+			return lret;
+		freed += lret;
+	}
+
+	return freed;
+}
+
 static unsigned long
 xe_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
 {
@@ -199,6 +241,7 @@ static unsigned long xe_shrinker_scan(struct shrinker *shrink, struct shrink_con
 		runtime_pm = xe_shrinker_runtime_pm_get(shrinker, true, 0, can_backup);
 
 	shrink_flags.purge = false;
+
 	lret = xe_shrinker_walk(shrinker->xe, &ctx, shrink_flags,
 				nr_to_scan, &nr_scanned);
 	if (lret >= 0)
-- 
2.50.1


