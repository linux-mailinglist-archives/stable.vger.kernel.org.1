Return-Path: <stable+bounces-119729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6AEA46866
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 18:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C44D7A4E0A
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 17:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2A4229B36;
	Wed, 26 Feb 2025 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JhxAaaVV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91D2253EA
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592114; cv=none; b=poViC1wB1e1wmnwQn1a06dSE/Uwsrvh2ah008Q9m4N4Pk4kVfSFkCW8nWnuBI+ioF/yqPy5qvi2+o4skeXf6O65HeYgn1o0B5qK3MiSvH1RcengWXbTHubAi2/qxQyIuNfdRGWtTHfUaD/EheGkFBbQieUVELPOicCPrD1vKWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592114; c=relaxed/simple;
	bh=utwP7sgrc/mPnToD/YRZ2ym51BUM5uJh8Ub8FCA++1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r5eZwy8wYP4QxgjFP+7xUbcdzwxjWarJ22DAl6WGY3shihqYn5nGgS/VZnL3xD0TJ3ZjzKwIG8gShNGzkhDlE7tlhsWPCNS+GZopckAXnUEN+rPg0i/8+Q7/cu4DKvH4PWQ96HK+cew7PQV87k+uEZ9fSEpLlXpaurxdin0bXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JhxAaaVV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740592113; x=1772128113;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=utwP7sgrc/mPnToD/YRZ2ym51BUM5uJh8Ub8FCA++1Y=;
  b=JhxAaaVVhEV3WT4N3gJUUDATEW820CywLMSvCcavnFcVSgKHlYmlVZRq
   3pQx0u+7MCRuqYIimMTxbu1PstuH8vsYADmgRAglUquZ0FvCDbVPcKDEr
   p+1eFdyNGO2fy7CIgA/kkTAM41Yzdcgt5go7x9uUb2p5J9BMhwOj3Hspc
   rkH208OLTtkZIKsGkmtwvqEbICndDEaV0VF8ErsOwAgjqdb4vY3J6lTki
   9N/FDVzY6GaAuU7un7gmI9KWDWHocaeyxBLKGg5/HxDw6rIJzF+wGlM4I
   6DvZ2iPFbJyUrOWgA4lTx6psii9oqiFov4fp/m4HLK9lYdWACsBLtwEzP
   A==;
X-CSE-ConnectionGUID: bnXdCKu9Tjy6ywR3p/Cv3Q==
X-CSE-MsgGUID: fuhjohFYSTGx5yEAo4fJeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52852783"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="52852783"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:48:33 -0800
X-CSE-ConnectionGUID: tgX7Db6KRBSxEFxu8U08zg==
X-CSE-MsgGUID: zn2jJ2oYTNC2PFNOYu3X4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="121715666"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.27])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:48:31 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/xe/userptr: properly setup pfn_flags_mask
Date: Wed, 26 Feb 2025 17:47:49 +0000
Message-ID: <20250226174748.294285-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently we just leave it uninitialised, which at first looks harmless,
however we also don't zero out the pfn array, and with pfn_flags_mask
the idea is to be able set individual flags for a given range of pfn or
completely ignore them, outside of default_flags. So here we end up with
pfn[i] & pfn_flags_mask, and if both are uninitialised we might get back
an unexpected flags value, like asking for read only with default_flags,
but getting back write on top, leading to potentially bogus behaviour.

To fix this ensure we zero the pfn_flags_mask, such that hmm only
considers the default_flags and not also the initial pfn[i] value.

v2 (Thomas):
 - Prefer proper initializer.

Fixes: 81e058a3e7fd ("drm/xe: Introduce helper to populate userptr")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
---
 drivers/gpu/drm/xe/xe_hmm.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hmm.c b/drivers/gpu/drm/xe/xe_hmm.c
index 089834467880..2e4ae61567d8 100644
--- a/drivers/gpu/drm/xe/xe_hmm.c
+++ b/drivers/gpu/drm/xe/xe_hmm.c
@@ -166,13 +166,20 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
 {
 	unsigned long timeout =
 		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
-	unsigned long *pfns, flags = HMM_PFN_REQ_FAULT;
+	unsigned long *pfns;
 	struct xe_userptr *userptr;
 	struct xe_vma *vma = &uvma->vma;
 	u64 userptr_start = xe_vma_userptr(vma);
 	u64 userptr_end = userptr_start + xe_vma_size(vma);
 	struct xe_vm *vm = xe_vma_vm(vma);
-	struct hmm_range hmm_range;
+	struct hmm_range hmm_range = {
+		.pfn_flags_mask = 0, /* ignore pfns */
+		.default_flags = HMM_PFN_REQ_FAULT,
+		.start = userptr_start,
+		.end = userptr_end,
+		.notifier = &uvma->userptr.notifier,
+		.dev_private_owner = vm->xe,
+	};
 	bool write = !xe_vma_read_only(vma);
 	unsigned long notifier_seq;
 	u64 npages;
@@ -199,19 +206,14 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
 		return -ENOMEM;
 
 	if (write)
-		flags |= HMM_PFN_REQ_WRITE;
+		hmm_range.default_flags |= HMM_PFN_REQ_WRITE;
 
 	if (!mmget_not_zero(userptr->notifier.mm)) {
 		ret = -EFAULT;
 		goto free_pfns;
 	}
 
-	hmm_range.default_flags = flags;
 	hmm_range.hmm_pfns = pfns;
-	hmm_range.notifier = &userptr->notifier;
-	hmm_range.start = userptr_start;
-	hmm_range.end = userptr_end;
-	hmm_range.dev_private_owner = vm->xe;
 
 	while (true) {
 		hmm_range.notifier_seq = mmu_interval_read_begin(&userptr->notifier);
-- 
2.48.1


