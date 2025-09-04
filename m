Return-Path: <stable+bounces-177725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7721B43C89
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC0B1737E1
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 13:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DAD2FF667;
	Thu,  4 Sep 2025 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxjYlKrj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F49B2FF654
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991214; cv=none; b=piTqbgLbVBoJ35elYdzJB3+94zYn0wXZatcdb+8czd/1UIichMbBkk/N4mbNg15r+2nlrxZlEMq3w4lx2rBLQc2CV58txJ9jXHNVOfxkPtAwN0ozo6IkiKJY25j5GceMbua28uh+to1GqDPt+7TCM0zy+JuvRK4/tH+ytjmQzsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991214; c=relaxed/simple;
	bh=JRIAqmSw+b6IVBNCwhygkbBfnOm+6XVmct7plXZqPV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kq2Xb3kRu4o98SSSxW5FIUoLrfdpNpkGaR6rd2OFNuMElH4jAuz4UiEFsbIHA1fjybV7oCfJMm9/V7sveXhFYaczYWb3BLvjmbV6EXR3avkRoIFMGb6m6FDQOvLhocLheuBapVRJSidbWxpN9d63h6GiPtcPLgpwQv2cGHcTgag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxjYlKrj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756991212; x=1788527212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JRIAqmSw+b6IVBNCwhygkbBfnOm+6XVmct7plXZqPV4=;
  b=kxjYlKrjv421kIdln4Ps2pJcd8NTd+Pzy3FR0tYq9oNkSjcl/rmDfjh2
   sDphmaOVKqaE+tO3nDaPl0EVAMCgqPR23ZteNuQklI7auS9G5l44zMKV6
   4vrckvVMM8g4IiD4pV3tzgT1SoR4dBS7GTdx4b9TbDcxsTai/+pFg9ynS
   fm/Xv4g2d6xyKPrD50F2HU3Jhzk2yqBFL74p7dafnWzTEfcIBlMDruMSt
   UIozTHlmYt1EnEkMu5CMOb+4nmLLmRly99L6PLD/zVgH6mpfSRVES53D1
   rxVFPVbZVKlBMMZMS0Dz8mPJsTHF9Tg5o+ZD5b9CSD/U35II0J8w32HSI
   A==;
X-CSE-ConnectionGUID: RrDra5JmTYeCUuotsDGt1w==
X-CSE-MsgGUID: xZCUXTcCSDeFa0mai7DhdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="76930831"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="76930831"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:06:52 -0700
X-CSE-ConnectionGUID: S2k+BwUYS/etGabNX++9MQ==
X-CSE-MsgGUID: Q5VBwsqjTeWZvSDhRXkjIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="171459086"
Received: from abityuts-desk.ger.corp.intel.com (HELO fedora) ([10.245.244.98])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:06:50 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v3 2/3] drm/xe: Allow the pm notifier to continue on failure
Date: Thu,  4 Sep 2025 15:06:04 +0200
Message-ID: <20250904130614.3212-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904130614.3212-1-thomas.hellstrom@linux.intel.com>
References: <20250904130614.3212-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Its actions are opportunistic anyway and will be completed
on device suspend.

Marking as a fix to simplify backporting of the fix
that follows in the series.

v2:
- Keep the runtime pm reference over suspend / hibernate and
  document why. (Matt Auld, Rodrigo Vivi):

Fixes: c6a4d46ec1d7 ("drm/xe: evict user memory in PM notifier")
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v6.16+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_pm.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index a2e85030b7f4..bee9aacd82e7 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -308,17 +308,17 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
 	case PM_SUSPEND_PREPARE:
 		xe_pm_runtime_get(xe);
 		err = xe_bo_evict_all_user(xe);
-		if (err) {
+		if (err)
 			drm_dbg(&xe->drm, "Notifier evict user failed (%d)\n", err);
-			xe_pm_runtime_put(xe);
-			break;
-		}
 
 		err = xe_bo_notifier_prepare_all_pinned(xe);
-		if (err) {
+		if (err)
 			drm_dbg(&xe->drm, "Notifier prepare pin failed (%d)\n", err);
-			xe_pm_runtime_put(xe);
-		}
+		/*
+		 * Keep the runtime pm reference until post hibernation / post suspend to
+		 * avoid a runtime suspend interfering with evicted objects or backup
+		 * allocations.
+		 */
 		break;
 	case PM_POST_HIBERNATION:
 	case PM_POST_SUSPEND:
@@ -327,9 +327,6 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
 		break;
 	}
 
-	if (err)
-		return NOTIFY_BAD;
-
 	return NOTIFY_DONE;
 }
 
-- 
2.50.1


