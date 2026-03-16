Return-Path: <stable+bounces-225507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMRIBeqvt2l3UQEAu9opvQ
	(envelope-from <stable+bounces-225507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 08:23:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B19552958EA
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 08:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 306BF3012CB3
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 07:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE6134BA5A;
	Mon, 16 Mar 2026 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdQcz/FD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774D34D394
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773645799; cv=none; b=hQ1R/6Scf07OBHv/tB+Tux/Ox6Cg1f0lRwRNgnW7Etv3GLWGEh5XSLNxbd/M+Sy51jyvpK0lnkXEOvSWGgGwzdZKkqDpBSc4Sq1WajLkuC11d0WZeQXQa40rH8ORn29vFG8FZ2mEKKja2PyUbi2FOgYU/dujJXC/Mr3Cn29Btis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773645799; c=relaxed/simple;
	bh=dMz9gxky277hIegot6eUiWfg4LVLemeokMnJMIbMVkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RX/u6FF2mYOxM8QyzxW20zlI3VFmFl1GCORRq3XQyrpUqr7v/s73soxL5qK3hMUEpl1F1TyI0YTRjTLet2DY2vpSosJIqhsNR6o570d6B06jVS7wbA28RBDWFaVK8mU8jDmXNuL/LU4RkSTeOwPWkYtWXxUwfVZ7ALtwpah7uXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdQcz/FD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773645799; x=1805181799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dMz9gxky277hIegot6eUiWfg4LVLemeokMnJMIbMVkI=;
  b=hdQcz/FDIAfj97rSmZeaBv0nr2uQ5Wh2Q5taPXBNgZaVdSDkNYmHEna1
   C9YlEVPLHFjtPegQIV1HnExmkfQKtKybLEeqbuDvy3wSbB7H016HlOOSO
   bZQL7pkJ8JTTXtAmIrdaFMJyr1fIhwpUx/MzXQpVkSdhxvrTdZ1vd7g4+
   ABU7lSU/xxVBPyD4J91pN9JT99uMZkx1g1FUEjw9Jds00vDlPyJ3PZHgf
   ZTJzABz2zoncSaZGO+vcS8kYLnLbmdTuLsLtKcAK6NxlRVoxdb/7z9uhZ
   ajOseTdUPvmXtjVRSxi7VYEvrCyaCk1VBql9ExNlqm0sBsKwjJ/iAGn87
   A==;
X-CSE-ConnectionGUID: KKu14vdESSicUh1UjGxFbQ==
X-CSE-MsgGUID: tid5XQWqRrWR3GpB3RqepQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92038916"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="92038916"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:23:18 -0700
X-CSE-ConnectionGUID: xt2/YgOhSjOiP7Zu7WzEtw==
X-CSE-MsgGUID: ttspON/4Sm+WXmL3hNUOWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="226497599"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.31])
  by fmviesa005.fm.intel.com with ESMTP; 16 Mar 2026 00:23:17 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	stable@vger.kernel.org,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Mathew Alwin <alwin.mathew@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v5 2/2] drm/xe: Reject coh_none PAT index for CPU_ADDR_MIRROR
Date: Mon, 16 Mar 2026 07:22:57 +0000
Message-ID: <20260316072257.255372-3-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316072257.255372-1-jia.yao@intel.com>
References: <20260129000147.339361-1-jia.yao@intel.com>
 <20260316072257.255372-1-jia.yao@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225507-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B19552958EA
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

Fixes: ada7486c5668 ("drm/xe: Implement madvise ioctl for xe")
Cc: stable@vger.kernel.org # v6.18
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Mathew Alwin <alwin.mathew@intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Jia Yao <jia.yao@intel.com>
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


