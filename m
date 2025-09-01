Return-Path: <stable+bounces-176801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F32B3DCBA
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 10:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A464405FE
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 08:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EC42FB994;
	Mon,  1 Sep 2025 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDSvDkmA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF212FB608
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715935; cv=none; b=g06Zj5q8WLIRc+M4kqtC20JdrlwKRW5qBHJSGZJYQWc3OF3yhYf52Kezl09TjAASAXaf4AB3epopcTEAyKwgOLs2YLIBuqD0skU6rskFXT8RaWjevknCxUNGpLCLeZV+XwywbouLOgJBx/cJNnjSk7l05yzl7g6F3952TcT/bGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715935; c=relaxed/simple;
	bh=JRIAqmSw+b6IVBNCwhygkbBfnOm+6XVmct7plXZqPV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SL/qUOylMxAssRqH8getqZFP/ZFU5IxQX5RTQiZjwtSMTl8Gt4q+gk8YoICwEcKqAcc0jIOR9Sn73cVFtO19mtTEOCL1PEiYQ/T3y10tohXx8t4O9qXDXYxqavSv6AYk36/iMD7Wr8Q1jxRFjxm6hSdgxc/CXVXpiKHn8OmKAls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDSvDkmA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756715933; x=1788251933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JRIAqmSw+b6IVBNCwhygkbBfnOm+6XVmct7plXZqPV4=;
  b=NDSvDkmAX8FEbF40qQY15LXk5N3Is5vfk3csNHGJYIg6mUEZOjboeOdQ
   NRb0ywAD27yX69B9iiS/M9XKVJ6SW9pjnDAQFVmlF7ujRU24bbGb6/Vj7
   at7EA3ZLtk9xb8MpDfOxdor00Oe2S/PvuckSO0D+Keh/Kzdu6LBUEloNz
   slrMtEMT3zKfJaU88LMPrXlYyH9siAtiY61+fk4iIjEz8fVY5YukHLIrH
   uGeO0hU3inoqzQ7Ic0CysOxmBLFKjShloUETkfbcfW9DRHfiCqrU1Zc0L
   PNlkfSfhp06KKmOS8J0egaSfOC0kuvqDIFCcUh/PFoOlEg9AHVvfpxX78
   Q==;
X-CSE-ConnectionGUID: WfZ564LVTda5jdmsAYuswA==
X-CSE-MsgGUID: lvemem3WTxSLHLGIxF7M1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="58899196"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="58899196"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 01:38:52 -0700
X-CSE-ConnectionGUID: 3FnZ54oFQTG5DQSoWSvtAQ==
X-CSE-MsgGUID: h1B+0p9VQj2zz+pTSR5q+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="201910250"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO fedora) ([10.245.244.171])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 01:38:50 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v2 2/3] drm/xe: Allow the pm notifier to continue on failure
Date: Mon,  1 Sep 2025 10:38:28 +0200
Message-ID: <20250901083829.27341-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250901083829.27341-1-thomas.hellstrom@linux.intel.com>
References: <20250901083829.27341-1-thomas.hellstrom@linux.intel.com>
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


