Return-Path: <stable+bounces-233960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XoJZOfaW1mlSGggAu9opvQ
	(envelope-from <stable+bounces-233960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:57:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF97E3BFE2B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95C733007B25
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 17:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C3C3D8912;
	Wed,  8 Apr 2026 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTgI5mrB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DF73D8907
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671026; cv=none; b=f32RJe3uL8EwbupDs79jrmDFgITLil9GtMtw9KeE9isZSakGIukSRjB9eHh1pOElE7MqYaxG+upjMbxalQKu8/dlh6m1M4hJ5S6edjUgcE3ErHEQFSt7VVpksbcc9avgTy46/992jXaVuAXgVsS/gZe4tRcuYfDd8VoM1d2y9a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671026; c=relaxed/simple;
	bh=EexbJJF2jtKb4Aapfzs+1gsTNV5f34rWCm41Wzz4bEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEDxzCh9xSOkmZ3cr5kKL8MSfK8uZJqWZhe8K+5tiRVL3YHx59oP9oaxlIorB2lmwQVhP0lWByusmXw0+G4c8FycZFSdmo3sqQQ5zdCNw9ETO10TZAsWVxbrciUK1fnmfHmZ2ocAmla7d0WHJp16XSGHw6oHfjaSeVAfAw/sxt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jTgI5mrB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775671024; x=1807207024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EexbJJF2jtKb4Aapfzs+1gsTNV5f34rWCm41Wzz4bEA=;
  b=jTgI5mrBEla+PztfOTqsrLeMoce+96CoRiBge+i48S0lMG9xn2+373vm
   uRiAy76DiqGvISncr6XDUsGaKrOeeCn0hDD54jCJ/ilAv+vBtVkHPpJCo
   DlrBmB+JE1wd+LFs5FedqTkX7EacIXFHg9WwZjKvjnBdewvdgTTZE3uya
   izG6chj6BLyYi79B37B+MDSrgAi3FkeedcxD06AoMbtJTKA8A6pAzrt6B
   yRojD6M1nG77wnkQUv5uxxGoGjYDCJyizOXjPWScCCVaJvYQV21DQrSGf
   qVB2L01JR2PKiWAMR1EPI5LFWt8JknJKJ+kiQydtlwkLH5rIYppEF2gMq
   A==;
X-CSE-ConnectionGUID: lYfkhKe/ShW6kUrtyuBQhg==
X-CSE-MsgGUID: MjMc9QLmRTGjlRYGgOiM+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76567683"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="76567683"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 10:57:04 -0700
X-CSE-ConnectionGUID: zUdu8w02Q/CB7i9vSWxsBA==
X-CSE-MsgGUID: g5sshUZKR3utFL92L20OQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="233418800"
Received: from shosgclin.sh.intel.com ([10.112.232.103])
  by fmviesa005.fm.intel.com with ESMTP; 08 Apr 2026 10:57:03 -0700
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v2 2/4] drm/xe/bo: Fix bo leak on GGTT flag validation in xe_bo_init_locked()
Date: Wed,  8 Apr 2026 17:52:53 +0000
Message-ID: <20260408175255.3402838-3-shuicheng.lin@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233960-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF97E3BFE2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When XE_BO_FLAG_GGTT_ALL is set without XE_BO_FLAG_GGTT, the function
returns an error without freeing a caller-provided bo, violating the
documented contract that bo is freed on failure.

Add xe_bo_free(bo) before returning the error.

Fixes: 5a3b0df25d6a ("drm/xe: Allow bo mapping on multiple ggtts")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 26ca878099b9..b3efadbbca00 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -2309,8 +2309,10 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 	}
 
 	/* XE_BO_FLAG_GGTTx requires XE_BO_FLAG_GGTT also be set */
-	if ((flags & XE_BO_FLAG_GGTT_ALL) && !(flags & XE_BO_FLAG_GGTT))
+	if ((flags & XE_BO_FLAG_GGTT_ALL) && !(flags & XE_BO_FLAG_GGTT)) {
+		xe_bo_free(bo);
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (flags & (XE_BO_FLAG_VRAM_MASK | XE_BO_FLAG_STOLEN) &&
 	    !(flags & XE_BO_FLAG_IGNORE_MIN_PAGE_SIZE) &&
-- 
2.43.0


