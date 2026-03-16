Return-Path: <stable+bounces-225621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOHcAvAzuGmvaAEAu9opvQ
	(envelope-from <stable+bounces-225621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:46:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0F829D9CC
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FB683046027
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD9738E5D1;
	Mon, 16 Mar 2026 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YiytAmpF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5397334695
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679379; cv=none; b=D2cS/VczZiJYwHOfDBGsCsRBpZb4grubk4Qm+ld+vFyYl5Lzjv/EX4MEJ0seC9Ht6vh6K0wWoEfdgnA7XO2pm1XzKiO6kgyAGM865WPbOnY5k9FmfOTmKzHaJf3d8/7nHUtYiega/1H9au4bdImeGReZrfJEuxVKhG7I5t7iY8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679379; c=relaxed/simple;
	bh=qyfPteuWc+oHpiV0crwOxOWddDIRSMv914tnOFqikyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKjeaVUF5yjULutNMlnHrhqh4agqGwhgVedBv6lu5jMqP6uyGxIhmdu8n+sbSgRBYkhq1FHJV5tkFmLRTo3zaEAc1oyJy7XqJ60kYH25MOjjdBw2DytXw6MqnugeHroJNR6OSK3Ell+rQ42WnFh1MkBKEzS4gUb+NT7NjnjeB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YiytAmpF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773679378; x=1805215378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qyfPteuWc+oHpiV0crwOxOWddDIRSMv914tnOFqikyU=;
  b=YiytAmpF8IUkucib9GcVd4aj5f1BsxN2i5cvh6vtl59K0QYF9zpv9f6y
   kBXRQBfg2zfy85qO0jx5IeK+5BCrtp2REuZkKwrqFN1iB8mGmIx+Yhoqm
   YibL2DLS+tBmzk6XpnE6DrttsyLfvmlG9EmANXUn4tqCvCTJRPmk9UBwq
   Kgq7UUn7Lw8aMmyOnV6bm5YDW1fwHWRx5glS1i/Ik57QtVJV8u1q6QZUd
   kREfLBOG1cmUxR8PeJE8nWlQby57Z1LqVuncYIMR+a+roCtEaM97UxunK
   3MptxQoj5TWQyHMH+Nw8M18syIdOkmL89uGk9mFJSSdm495uQHS0Wp98F
   g==;
X-CSE-ConnectionGUID: jYR3v4NpQ8CxDEpd6OeJgA==
X-CSE-MsgGUID: E7rDZntkS1mTma4yrKu0FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="97308783"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="97308783"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:42:58 -0700
X-CSE-ConnectionGUID: G7x+sTvDRYuESNUNG7N7Og==
X-CSE-MsgGUID: N6VGxwcISfaKfCtLytDyIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221013872"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.31])
  by orviesa006.jf.intel.com with ESMTP; 16 Mar 2026 09:42:58 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	stable@vger.kernel.org,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Mathew Alwin <alwin.mathew@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v6 2/2] drm/xe: Reject coh_none PAT index for CPU_ADDR_MIRROR
Date: Mon, 16 Mar 2026 16:42:53 +0000
Message-ID: <20260316164253.262406-3-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316164253.262406-1-jia.yao@intel.com>
References: <20260129000147.339361-1-jia.yao@intel.com>
 <20260316164253.262406-1-jia.yao@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-225621-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7D0F829D9CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add validation in xe_vm_bind_ioctl() to reject PAT indices with
XE_COH_NONE coherency mode when used with
DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR, consistent with the existing
validation for DRM_XE_VM_BIND_OP_MAP_USERPTR.

CPU address mirror mappings use system memory which is CPU cached,
making them incompatible with COH_NONE PAT index. Using COH_NONE with
CPU cached buffers is a security issue: GPU can bypass CPU caches and
directly read stale sensitive data from DRAM, potentially leaking data
from previously freed pages.

Although CPU_ADDR_MIRROR mappings don't create actual memory mappings
(the range is reserved for dynamic mapping on GPU page faults), the
underlying system memory is still CPU cached, so the same PAT coherency
restrictions as MAP_USERPTR should apply.

v2:
- Correct fix tag

Fixes: e1fbc4f18d5b ("drm/xe/uapi: support pat_index selection with vm_bind")
Cc: stable@vger.kernel.org # v6.18
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Mathew Alwin <alwin.mathew@intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 5572e12c2a7e..1c4b4a5eeadb 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3491,7 +3491,7 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
 		    XE_IOCTL_DBG(xe, obj &&
 				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
 		    XE_IOCTL_DBG(xe, coh_mode == XE_COH_NONE &&
-				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
+				 (op == DRM_XE_VM_BIND_OP_MAP_USERPTR || is_cpu_addr_mirror)) ||
 		    XE_IOCTL_DBG(xe, comp_en &&
 				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
 		    XE_IOCTL_DBG(xe, op == DRM_XE_VM_BIND_OP_MAP_USERPTR &&
-- 
2.43.0


