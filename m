Return-Path: <stable+bounces-233959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIR+NvaW1mmiGQgAu9opvQ
	(envelope-from <stable+bounces-233959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:57:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B836E3BFE2A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 919B93007B0F
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 17:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A77C3D8904;
	Wed,  8 Apr 2026 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NsWUWMYF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6273D47AC
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671024; cv=none; b=NbmLdC+gqn9PYTpeVU1Km7/rdVVdkbVljTD+galVwByBX0zXFLvTf/PQ7PGaz6XEvGsGWWGvNi6DJZkAVLl/eYlr/hpBNlCS1G7Z2hexq4Vlg9BErlVRj5LMZyNUJbWkurOwqz6ElsjmdBZIsEjxwoyXwOWWjCg6KUyxpZKIc0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671024; c=relaxed/simple;
	bh=VNnwW4W7hKnznqq5a4Sxm1x1GKOexhllyjN1PzVXWwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0uypJLCWvGD0fOTaq0W8djN/RyIdMdcfAJF+KKj/4xxcCfjSbadTawbkmIVHXXKm6/oRQPLA36XnB17cn7hUA7Maddoi7TgVyC9Ts2mr2qzEgOwQGRsgNwcBMr1hArxNttZ2E6HT1j13EzrPEIk3YB2CrtDR15R4q4Bp2EW7+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NsWUWMYF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775671022; x=1807207022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VNnwW4W7hKnznqq5a4Sxm1x1GKOexhllyjN1PzVXWwA=;
  b=NsWUWMYFywlGoKquP8Z9545sdQecao9Uq19H2yRAGIN0//EXw4QBw5FN
   ywpvYXFVVcZXnousW6WM/TAtFsmBQ9DymSCH4+1SzKp42zV2ADtlq+Rsk
   tQnqc48Z8W20UlRj0dmrKI4CeJLiGVxVmF+DPRYaVCI6kQizYpHA4fOnQ
   t2IkiI7VktRBGHAurt7L50XpxH4XZZ40O3jICQIOQDd4SCx/4w/Lgrb0J
   x3Md/JIGDrLF7gnr9woJk7AOKO0gurtnQ+ciB+rJptso2+F/L0jZJ/Rq3
   VIRmcQT7SZrvcgK4t/yZAZjg10Ujt9T0+xTHQyqhyNMqn4Zs+sFVMFlXw
   w==;
X-CSE-ConnectionGUID: DK/LEQeVRcOHCS1natMwYw==
X-CSE-MsgGUID: vsm6KCNUQWiYCs0hOhb7JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76567678"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="76567678"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 10:57:02 -0700
X-CSE-ConnectionGUID: 74kqzZKwRmmSMVUZ/hq7YQ==
X-CSE-MsgGUID: j1Zzfn2GSzWW0PWc3m5HUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="233418792"
Received: from shosgclin.sh.intel.com ([10.112.232.103])
  by fmviesa005.fm.intel.com with ESMTP; 08 Apr 2026 10:57:00 -0700
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v2 1/4] drm/xe/bo: Fix bo leak on unaligned size validation in xe_bo_init_locked()
Date: Wed,  8 Apr 2026 17:52:52 +0000
Message-ID: <20260408175255.3402838-2-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260408175255.3402838-1-shuicheng.lin@intel.com>
References: <20260408175255.3402838-1-shuicheng.lin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233959-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B836E3BFE2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When type is ttm_bo_type_device and aligned_size != size, the function
returns an error without freeing a caller-provided bo, violating the
documented contract that bo is freed on failure.

Add xe_bo_free(bo) before returning the error.

Fixes: 4e03b584143e ("drm/xe/uapi: Reject bo creation of unaligned size")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 1db2486b7cee..26ca878099b9 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -2329,8 +2329,10 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 		alignment = SZ_4K >> PAGE_SHIFT;
 	}
 
-	if (type == ttm_bo_type_device && aligned_size != size)
+	if (type == ttm_bo_type_device && aligned_size != size) {
+		xe_bo_free(bo);
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (!bo) {
 		bo = xe_bo_alloc();
-- 
2.43.0


