Return-Path: <stable+bounces-98562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDA09E471E
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 22:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578C616952D
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3C418A6D7;
	Wed,  4 Dec 2024 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNk6IDqk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D1C18C900
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733348836; cv=none; b=tvu81IJWbJcSAgPH1M9rIb0IB9qH7p5qfolA+s6E/y2OTwf8Ma8pwGiJZA9U/LMqpLu/wh0G0YPAPTrlRB16f9xVgOjjrZnUY3coJOsA+xiWoKAt3HQfkIeaJffQJXWGEXi5EcAuermSv8YY4vTj5Bi0vlXJHEkt1isQVLonShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733348836; c=relaxed/simple;
	bh=jA5LHzErPwAfWK7eyxNlm68vjWtVI89o3vDkO3V6Li4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cO08u97PWK9gSiCiFiuM4XTQB9xCnZTqmVRZ3Mf9fXsHqN01gpzX3GplrxUMNEZfadl4umC6HmJrO7HwL4dxObZyzLGASqp6qFLUFuZKJwnvSrM+9YFJjxAKXZXN6zc+qMxhuzMVQGypcBem4As6FBEYSzVxrCGwFPeW89slPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNk6IDqk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733348835; x=1764884835;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jA5LHzErPwAfWK7eyxNlm68vjWtVI89o3vDkO3V6Li4=;
  b=kNk6IDqkxNjiu4bknTDBFQP0XJLVopE6OvVwIPzwooaaQ+XIBhkPgUOC
   XQcI/yMDhYiVY5qTr/vXgn28hsnyZzZgmyuysm4XIFgCREf5OXjOzbztp
   C0Vgms6H7F5yaP9rPCzBvHqKE0IAsjMJmVehcEbb6T/JlID5BV+WttVuu
   n4SKbNiNuv4E/emN06fE4XrHUL5qpisphLsrMFhMEZiSFLV4egoLPbVmL
   KKhkWQsuoiFqbVOxo7qZ+MtnL+nPqeQBoMlwk+wfM1oncjvRDHVPSm/4v
   Zfo1VQPZlqk+8SS1i1XHV86R93eRRpMlZs5pT4nhIRSS53BFuLqQZDhN6
   Q==;
X-CSE-ConnectionGUID: xQ8SRLncSI6AAlrPviZHQA==
X-CSE-MsgGUID: Xhmw1eagTE6DO0eAubJawg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33558002"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="33558002"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 13:47:14 -0800
X-CSE-ConnectionGUID: 4qDg6l5uSzq/56AkIrDmWQ==
X-CSE-MsgGUID: TYo1ktk4QIGAa5PwTk9WCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="93967203"
Received: from nirmoyda-desk.igk.intel.com ([10.211.135.230])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 13:47:12 -0800
From: Nirmoy Das <nirmoy.das@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Wait for migration job before unmapping pages
Date: Wed,  4 Dec 2024 23:06:05 +0100
Message-ID: <20241204220605.1786340-1-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Deutschland GmbH, Registered Address: Am Campeon 10, 85579 Neubiberg, Germany, Commercial Register: Amtsgericht Muenchen HRB 186928
Content-Transfer-Encoding: 8bit

There could be still migration job going on while doing
xe_tt_unmap_sg() which could trigger GPU page faults. Fix this by
waiting for the migration job to finish.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3466
Fixes: 75521e8b56e8 ("drm/xe: Perform dma_map when moving system buffer objects to TT")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 73689dd7d672..40c5c74e9306 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -857,8 +857,16 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 
 out:
 	if ((!ttm_bo->resource || ttm_bo->resource->mem_type == XE_PL_SYSTEM) &&
-	    ttm_bo->ttm)
+	    ttm_bo->ttm) {
+		long timeout = dma_resv_wait_timeout(ttm_bo->base.resv,
+						     DMA_RESV_USAGE_BOOKKEEP,
+						     true,
+						     MAX_SCHEDULE_TIMEOUT);
+		if (timeout < 0)
+			ret = timeout;
+
 		xe_tt_unmap_sg(ttm_bo->ttm);
+	}
 
 	return ret;
 }
-- 
2.46.0


