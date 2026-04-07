Return-Path: <stable+bounces-233718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFokHmpn1Wm05gcAu9opvQ
	(envelope-from <stable+bounces-233718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 22:22:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B19E3B4800
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 22:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FFF03023449
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A936AB4B;
	Tue,  7 Apr 2026 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBZcwQmW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FBC3783C3
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593235; cv=none; b=fR60Y6889szLJlDpMe6lF4q+9NPf7PehmpRGdL32eHhcZcrAnLm3NYuuO6WWcH8TYeMMfS74fXaLIomrD//tMXOsWQpu+kkfWbOnVuJ+llXKFIhVh/ivpdlWDTo5us2BWSZJfVsH3eL34Zs/cUgCjj/q0tlk0Q13tviPWzHT4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593235; c=relaxed/simple;
	bh=xVWpfY0ybCfivnB88p7FWK+T+pO4OJ4spNkild+3ifw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ij3JbZUvI18CA2nx8ONX02EOsqaID6IjYAg6Db2oulcj+dghdJBS3lEB4dl9YKdIaiikPdA9EAnnaIgGGAvVihMVQLc4fwxQOK7FffCY0RcXEJQmd//nXCWMuObluRFt8slyVGNzM6cDl0bRl6Oz1HhAL8KLD827P2A5OahLmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBZcwQmW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775593234; x=1807129234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xVWpfY0ybCfivnB88p7FWK+T+pO4OJ4spNkild+3ifw=;
  b=jBZcwQmWbubxSlc7pYgWyzeIxCGk3x1gVi0fBKjHCLD32maSZvtrrQs9
   sx94zyAlboHiExSWUQDMXmiqgDSSKzxo5JKPca+PXqZMsMMMSQHowTa1t
   g28Kl4qOBza56C++uZqW+7SvnPFq3T/XUcGjeBv9cdoZuwNIXi/Bpte6V
   ind/BnLzKVFuoQW6ZfguSMKXs8QbKd8fUclUnnr1iXWGOX2H3G7349drK
   gOe6x3c62uddFPo4MuKV8SL07GaDZ+fkYZEaRgmWPsUmfJsWNZuZLVMbR
   ekYWWc1c1/0xSmS+jrYOe9BlqSa/H9328hq9VqB7G4fMmSMiKiJlrlA1E
   g==;
X-CSE-ConnectionGUID: zx+VdEL0TL2Ri59qQwr7yw==
X-CSE-MsgGUID: CICRSgsOSOKUZXzBh5WYdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="87268150"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="87268150"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 13:20:34 -0700
X-CSE-ConnectionGUID: eCXutEecQWC8Il7jNN84TQ==
X-CSE-MsgGUID: 7qncaPO5TQ65N153ZySU9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="233231578"
Received: from shosgclin.sh.intel.com ([10.112.232.103])
  by orviesa005.jf.intel.com with ESMTP; 07 Apr 2026 13:20:33 -0700
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] drm/xe/bo: Fix bo leak on GGTT flag validation in xe_bo_init_locked()
Date: Tue,  7 Apr 2026 20:15:40 +0000
Message-ID: <20260407201542.3396317-3-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260407201542.3396317-1-shuicheng.lin@intel.com>
References: <20260407201542.3396317-1-shuicheng.lin@intel.com>
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
	TAGGED_FROM(0.00)[bounces-233718-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B19E3B4800
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When XE_BO_FLAG_GGTT_ALL is set without XE_BO_FLAG_GGTT, the function
returns an error without freeing a caller-provided bo, violating the
documented contract that bo is freed on failure.

Add xe_bo_free(bo) before returning the error.

Fixes: 5a3b0df25d6a ("drm/xe: Allow bo mapping on multiple ggtts")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 6e4ebbe72952..d09e96b996b9 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -2322,8 +2322,10 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
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


