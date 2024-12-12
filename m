Return-Path: <stable+bounces-103552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CF19EF865
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F040189A333
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C832236EA;
	Thu, 12 Dec 2024 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/4ZLrV2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE77222D67
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024912; cv=none; b=MD849PxC6Yxo3VlNjpW1T5MMeCZ78B9oA/yx45HD4d4/H7SuIDAIpdeqwoe05hofiuphdmL61ZTO/hgU2ARlFRIZqQyHd7SMt+DnNjzvpVtfwGog9FrQ7mPHIKeF8zqK6hIzxGqZMIadW4jSJ06otdHwFffYCuuVi6hfle5o6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024912; c=relaxed/simple;
	bh=rq+KQ3VuQ6pQ39JLoebWnHfmizo/QbMi9JMJ5nXIMGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzpv19qaHaARetjwEVwDLqLvbK7MKf1hvsACH5hlSqRwojrR4pTGRNiKQFdNMkWc1BoP/MG5kAZIPpC6KWkD5pibADF6UefeyCofdhsOtCdqYNodGMwPAlrWGKUFC1eitDC8D1uAFRLNpvab+5o0srL7xVSik+5u9/BpQ9yPWl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/4ZLrV2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734024911; x=1765560911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rq+KQ3VuQ6pQ39JLoebWnHfmizo/QbMi9JMJ5nXIMGo=;
  b=Q/4ZLrV2X8ciTRsapwC9f7Ny1UilX9Eg/qDvBz7vsADPYh1YPBXJ6dFz
   5NbLp1PaAnw/dox822Royk05f6dEA73IdBhy+WUcOtmFI9z7l9xvpi0AH
   fHQKTOCzST68zOXWwY74bjLFl/jTUuYKvck7yZwxyThkN/Hn7k/6dDG05
   rC9y4B51cxmH3v56fTy/7RWIAgD3kouUty0MxzcdS5Af8muSJkuETtjuk
   G8lTGr5zgvcvak77IJRN3qbYyjvuDOxbLJoz7sg/qWTYsg9Abq2z1B7tv
   dH0CM10qEPryiPAX6Iw+vGqB5WuW1+0nmalVdXGeTa/GTBkRHTdOJljW+
   Q==;
X-CSE-ConnectionGUID: 1fPENQxUTOWMlhqc0Jrnxw==
X-CSE-MsgGUID: WQ4wsjMWSwK5rReOx6t34g==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38392198"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="38392198"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 09:35:10 -0800
X-CSE-ConnectionGUID: D1bBCyZ2Q6SWzgg3+fzuPA==
X-CSE-MsgGUID: TjlZq59OSf2/BM6IA9iyHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96145196"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 09:35:10 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: matthew.brost@intel.com,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/client: Better correlate exec_queue and GT timestamps
Date: Thu, 12 Dec 2024 09:34:32 -0800
Message-ID: <20241212173432.1244440-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This partially reverts commit fe4f5d4b6616 ("drm/xe: Clean up VM / exec
queue file lock usage."). While it's desired to have the mutex to
protect only the reference to the exec queue, getting and dropping each
mutex and then later getting the GPU timestamp, doesn't produce a
correct result: it introduces multiple opportunities for the task to be
scheduled out and thus wrecking havoc the deltas reported to userspace.

Also, to better correlate the timestamp from the exec queues with the
GPU, disable preemption so they can be updated without allowing the task
to be scheduled out. We leave interrupts enabled as that shouldn't be
enough disturbance for the deltas to matter to userspace.

Test scenario:

	* IGT'S `xe_drm_fdinfo --r --r utilization-single-full-load`
	* Platform: LNL, where CI occasionally reports failures
	* `stress -c $(nproc)` running in parallel to disturb the
	  system

This brings a first failure from "after ~150 executions" to "never
occurs after 1000 attempts".

Cc: stable@vger.kernel.org # v6.11+
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3512
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_client.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
index 298a587da7f17..e307b4d6bab5a 100644
--- a/drivers/gpu/drm/xe/xe_drm_client.c
+++ b/drivers/gpu/drm/xe/xe_drm_client.c
@@ -338,15 +338,12 @@ static void show_run_ticks(struct drm_printer *p, struct drm_file *file)
 
 	/* Accumulate all the exec queues from this client */
 	mutex_lock(&xef->exec_queue.lock);
-	xa_for_each(&xef->exec_queue.xa, i, q) {
-		xe_exec_queue_get(q);
-		mutex_unlock(&xef->exec_queue.lock);
+	preempt_disable();
 
+	xa_for_each(&xef->exec_queue.xa, i, q)
 		xe_exec_queue_update_run_ticks(q);
 
-		mutex_lock(&xef->exec_queue.lock);
-		xe_exec_queue_put(q);
-	}
+	preempt_enable();
 	mutex_unlock(&xef->exec_queue.lock);
 
 	gpu_timestamp = xe_hw_engine_read_timestamp(hwe);
-- 
2.47.0


