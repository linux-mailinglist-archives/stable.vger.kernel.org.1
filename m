Return-Path: <stable+bounces-176698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33755B3B9FE
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 13:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 331217B0223
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 11:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143AB26F297;
	Fri, 29 Aug 2025 11:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BX7LyUJo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F61299AAA
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467268; cv=none; b=IJh6hQ9B+AkuzlOkpfnWZ6/zZrPcc6x6l/Nod3MpC0kbgpChmtvRrtbFUfTto4M2XMJJXmfcNo+/PhTRHLWy5/tesuNUVR3bdOE/9UyZCb/xXwRORsnwknpwBSUc6DO8DnvRpTGHk5+n+GJXg195MD0Epeg4EX2KUKAi5FgUGYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467268; c=relaxed/simple;
	bh=nmZA8NX2LPmM1qgPQHkmSSIBfG4MoA597bUvcqMcVsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMLfBb+LY5RYi26cot2cQKHi9dldFIpnpZ/OWhL49G9ymPEM9HZYcFzwrtJO5Ian5qyEzgSMmSNnjZTWVz/WkeZflH/DMA/bpzqvHGtS8EgJX1IPVh3rmNBz/6FLX/2JSou08Y3azQKWV7g8iHG7CVtqzA71AhMoXd88wEd03do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BX7LyUJo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756467267; x=1788003267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nmZA8NX2LPmM1qgPQHkmSSIBfG4MoA597bUvcqMcVsA=;
  b=BX7LyUJoGIXlXKgb6T2pQ3JGr+mJ016ESlRlmjXTCvGLXzM0919gSXAK
   bN72u4IEY8RXa18KiXRfxzfZ35lLfhXRCtOYGW01wV1dzKKeL3mvluaTx
   YQSut4M60whi/yyRXxpuSi0+RjQ0+Wq9IRfhuiBRF/7yNe/iPnSLVqWFx
   vO37ReZXRG447iTqolmrpI7ZhxImdwAsx7KxQL5t3CWDbwiblNTWzQNBq
   xYbyhMeRdNZnXPrXHLJltAia2g8C8KeNPIjlqjh4JYHq8Kzk2kmWFxl+x
   qg9S9pFr+LoBA9+FJeRv5/8UNbwR77ebhyz1kOll9I6jSpnARYI2wEjsa
   A==;
X-CSE-ConnectionGUID: 7WIlJdetTXGAoEBciB/4gg==
X-CSE-MsgGUID: ZZo0xcsyQIil5pH8FNbFZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69025641"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69025641"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 04:34:26 -0700
X-CSE-ConnectionGUID: lWbIhQKKSBOOp3RKRACvfw==
X-CSE-MsgGUID: GHxBl/GxRVi6CQgbDfJjSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170748277"
Received: from agladkov-desk.ger.corp.intel.com (HELO fedora) ([10.245.245.245])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 04:34:24 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 2/3] drm/xe: Allow the pm notifier to continue on failure
Date: Fri, 29 Aug 2025 13:33:49 +0200
Message-ID: <20250829113350.40959-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829113350.40959-1-thomas.hellstrom@linux.intel.com>
References: <20250829113350.40959-1-thomas.hellstrom@linux.intel.com>
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

Also restrict the scope of the pm runtime reference to
the notifier callback itself to make it easier to
follow.

Marking as a fix to simplify backporting of the fix
that follows in the series.

Fixes: c6a4d46ec1d7 ("drm/xe: evict user memory in PM notifier")
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v6.16+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_pm.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index a2e85030b7f4..b57b46ad9f7c 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -308,28 +308,22 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
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
+		xe_pm_runtime_put(xe);
 		break;
 	case PM_POST_HIBERNATION:
 	case PM_POST_SUSPEND:
+		xe_pm_runtime_get(xe);
 		xe_bo_notifier_unprepare_all_pinned(xe);
 		xe_pm_runtime_put(xe);
 		break;
 	}
 
-	if (err)
-		return NOTIFY_BAD;
-
 	return NOTIFY_DONE;
 }
 
-- 
2.50.1


