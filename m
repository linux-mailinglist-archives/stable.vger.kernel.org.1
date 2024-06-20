Return-Path: <stable+bounces-54701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 261A7910160
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 12:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0FF1F22F52
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 10:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4253A1A8C3B;
	Thu, 20 Jun 2024 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPJOGzZj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190541A8C04
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878913; cv=none; b=cqj9WSdHWGnajIVI60zw/zE0ZF3U1wgaG8BYOH2cGUPB1+pQxdt8RNpv1rxJKS/apJgfELKwUbNa2Qw9WdLlNE+4bxPopdHbwEU5sT8JLLLchHR8gyq4dtMRlGtY9olLix9w95gG1b/PSgQuhfZjXi+otPAdt8wnJT2guVrhG+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878913; c=relaxed/simple;
	bh=URS0Qt3USCIRZFnWBj/hR/PUU+4lYOxdLBJy7htzw4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZNywlYXsSbW2xfQhUjflm78vwuFvycr1vepNHe79TrXUjL7w5X2XvEaMgilnKdyZiKsb4Yqxmnz3auoPG3GEtZCeD/bJShWI6ar6TmP0LxVDwzJnAsFVidv3nJVAQhSCb5clHL/yHRoMCwxSnwtBaiVKfgTrxbYGOSDHNGu6s78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPJOGzZj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718878911; x=1750414911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=URS0Qt3USCIRZFnWBj/hR/PUU+4lYOxdLBJy7htzw4s=;
  b=mPJOGzZjWko0OgznUEWVS4kAFdHQL5jtJfJP7LdZI5x+k2G6tKlFh5Dp
   ylndDlVuELkSWx13KUWUamqZ/Q27XXCidyRTXeBFtu94icG8IIcc0ltcC
   /OTO9oK4KJFkLULmbJD0Tlp2rMWibaLJk7jKSD8o7J/34qPaSrknOUg34
   IV+32R1HaRYnjvLWClpwBiHApMsQAYAAlltNg57SYAiC/IaTUJ/XsGA0N
   0baW747ORnoKatNm+IHCo2MVPz1eSBWGatRX2GhrLTKLkC7KQFUwn6el8
   Zw08QwaApSn8bZJfm2J9rsz5+QdA0IhveDjF3coR7c/j0ELtb7ZJEkWu8
   g==;
X-CSE-ConnectionGUID: MTQzkbsiQe6TLsWoY5wupw==
X-CSE-MsgGUID: NMz+QGZxRXaHjSbRR8h0aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="41250400"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="41250400"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 03:21:32 -0700
X-CSE-ConnectionGUID: LfJu2XfbR4uAMh6IqCq5yw==
X-CSE-MsgGUID: 9iu84QLzQOKFDjb+82GnYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="72926710"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.229])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 03:21:30 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: fix error handling in xe_migrate_update_pgtables
Date: Thu, 20 Jun 2024 11:20:26 +0100
Message-ID: <20240620102025.127699-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Don't call drm_suballoc_free with sa_bo pointing to PTR_ERR.

References: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2120
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_migrate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index 05f933787860..c9f5673353ee 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -1358,7 +1358,7 @@ xe_migrate_update_pgtables(struct xe_migrate *m,
 						 GFP_KERNEL, true, 0);
 			if (IS_ERR(sa_bo)) {
 				err = PTR_ERR(sa_bo);
-				goto err;
+				goto err_bb;
 			}
 
 			ppgtt_ofs = NUM_KERNEL_PDE +
@@ -1406,7 +1406,7 @@ xe_migrate_update_pgtables(struct xe_migrate *m,
 					 update_idx);
 	if (IS_ERR(job)) {
 		err = PTR_ERR(job);
-		goto err_bb;
+		goto err_sa;
 	}
 
 	/* Wait on BO move */
@@ -1458,10 +1458,10 @@ xe_migrate_update_pgtables(struct xe_migrate *m,
 
 err_job:
 	xe_sched_job_put(job);
+err_sa:
+	drm_suballoc_free(sa_bo, NULL);
 err_bb:
 	xe_bb_free(bb, NULL);
-err:
-	drm_suballoc_free(sa_bo, NULL);
 	return ERR_PTR(err);
 }
 
-- 
2.45.1


