Return-Path: <stable+bounces-89182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B5D9B46FD
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 11:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE8E1F23E35
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 10:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9509204924;
	Tue, 29 Oct 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dicsO6f9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABC817A58F
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198185; cv=none; b=T2M3rtyy4eZ9YEhqqxbRYbdKbAD7kswYxWK15s3zExKEzup+9sNfrHv1IblHgIghGeUq36LS9vQuDLFMZLlgkMsgIdaxmot2Eugm0Z72i87sebBwRT9KIr9LPtf2E5J6OrYuQdouqT0i7JrZjCCRw+Wn128KoNSogIBNHGUyLQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198185; c=relaxed/simple;
	bh=+c7uqtwM0LtCVyXtTwKf77mzC8r+EFwaFYB6Ujodsbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZrgKc5ON35X8ooQonQQrWix7fsrA0rZdUCALTlYlzLgEtS3iZUHs5VtmcLVcreXndStr/YMcSYuYuldiE0UrT7lpoaKmFTYmWYIhy1eymWUGjCdoG9K8QzozqjPVKurOAWfqDwWUeaj1ACAccerO4XKNbwXL1GB/1SrNyIw/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dicsO6f9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730198183; x=1761734183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+c7uqtwM0LtCVyXtTwKf77mzC8r+EFwaFYB6Ujodsbc=;
  b=dicsO6f9vvyLiS9paL0WDqWYd7oWFt6wuPBiNm8g8Lf9kc5oSbMVbT17
   7zjizY1EZHlYuO9pCh/pOFSkPo0OQxKxZVXSbN06rDk9RmRd7auWS6BBN
   nkWk9nvmS1ejYrMMKctLWiBpLWz17uQ8k70s4GZPCFxRn43cuvOd+v5aG
   TPUC/+0tQMhj2ZETlvsO9KIJ8IqakPslt+KCEIB/Lu+UQwaFIV6s+q4/j
   cxUqvACiE8SXvQ/uRKddwQIMoIOIcVuFEo7hAb5+56+Amd07qtWwr3pbL
   BChiFRMecKQXhPOCinA5lAiGCWpyNDCVWR7O2kvO7Kd5E/i4Nlz7QmRri
   w==;
X-CSE-ConnectionGUID: WlszT1XrQXqCYPGv0Gr+yg==
X-CSE-MsgGUID: YWuy3525QkmNUhFo+BB7NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29937681"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29937681"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:36:23 -0700
X-CSE-ConnectionGUID: XLn90pLKTrWNnx3/YT85Yw==
X-CSE-MsgGUID: +bjG3bPwTOysZRt1N9XhDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="105262790"
Received: from nirmoyda-desk.igk.intel.com ([10.102.138.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:36:20 -0700
From: Nirmoy Das <nirmoy.das@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v4 2/3] drm/xe/ufence: Flush xe ordered_wq in case of ufence timeout
Date: Tue, 29 Oct 2024 10:54:15 +0100
Message-ID: <20241029095416.3919218-2-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241029095416.3919218-1-nirmoy.das@intel.com>
References: <20241029095416.3919218-1-nirmoy.das@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Deutschland GmbH, Registered Address: Am Campeon 10, 85579 Neubiberg, Germany, Commercial Register: Amtsgericht Muenchen HRB 186928
Content-Transfer-Encoding: 8bit

Flush xe ordered_wq in case of ufence timeout which is observed
on LNL and that points to recent scheduling issue with E-cores.

This is similar to the recent fix:
commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
response timeout") and should be removed once there is a E-core
scheduling fix for LNL.

v2: Add platform check(Himal)
    s/__flush_workqueue/flush_workqueue(Jani)
v3: Remove gfx platform check as the issue related to cpu
    platform(John)
v4: Use the Common macro(John) and print when the flush resolves
    timeout(Matt B)

Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v6.11+
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
---
 drivers/gpu/drm/xe/xe_wait_user_fence.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
index f5deb81eba01..5b4264ea38bd 100644
--- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
+++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
@@ -155,6 +155,13 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
 		}
 
 		if (!timeout) {
+			LNL_FLUSH_WORKQUEUE(xe->ordered_wq);
+			err = do_compare(addr, args->value, args->mask,
+					 args->op);
+			if (err <= 0) {
+				drm_dbg(&xe->drm, "LNL_FLUSH_WORKQUEUE resolved ufence timeout\n");
+				break;
+			}
 			err = -ETIME;
 			break;
 		}
-- 
2.46.0


