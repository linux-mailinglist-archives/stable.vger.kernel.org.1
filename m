Return-Path: <stable+bounces-227280-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPx/HZzmu2njpQIAu9opvQ
	(envelope-from <stable+bounces-227280-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:05:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDE42CADEE
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB3273046A8B
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDA8376BE3;
	Thu, 19 Mar 2026 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbyB4Bac"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA6E3CF696
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921579; cv=none; b=sLhMbrSMQhUlT+1FgKDm73pzbUG5Kc5m/41ZgSB62vlB0r+geGdiauyHeXQtKAfxjEQqaL3OpPcRotaaWhVcCV7l3avLycdTD8+090ODl8DDLXmwkXuS+tlu/3zf4GclYz+ZXrJXnX4jEJtXfJcAdiKMP9R8bKTzDzZa2i7RYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921579; c=relaxed/simple;
	bh=0DX803sl68mWwpix+tTkv2yE1QmvygOqsICtFQ6AKH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A22OmmpTT/gmnRW0ygb6yZIS5braICMWyFwDWrPBBU3o7E49QaeTyrItfl4kuVjfv9EkgJBjNtyyZ6d9U/Yhpi1fx6POhyAk8q6jIjjwGRnl1cPLunfo91LLtW0C7UtAlQPYsvd7GfQzzrx4U+IkTiBr9Ya5VKkZCBuPtDIt/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbyB4Bac; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773921577; x=1805457577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0DX803sl68mWwpix+tTkv2yE1QmvygOqsICtFQ6AKH0=;
  b=fbyB4BacsYvM/YhYn7tUBYUSFPq369KcJ9e99j3zik/j7dFY03PJL23A
   SeBnpPAwHVz26KAJJbKibL6qffPodrRvu/K9W3ZglaIMO9CPhxeQJXoiY
   dA8bikNcsadi8lSGrysPorge7X9qPZxoi9SjfVNnPMIy6eufMU9wU7OgD
   Ij6ezZ7fwb94VgXTvsJH+aj/U3MtLo9B15eeQpyArXczqYRpPelLJL95Z
   90PI4V1Q+CbNA9MOwqnjrvXSgW8yeR0WRTWdrsGC1Lu88mm9AkFPrBxeG
   lAig/Vs2ADAhDfEU67dB+ZlI/vMb9dFdy9CtWFcLTHWbvPay1QR7xzWTY
   A==;
X-CSE-ConnectionGUID: s7MlvxvpRxOYwbGcS0fXsw==
X-CSE-MsgGUID: 1sq5eZovQqOfwiz9/4/8mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="78593944"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="78593944"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 04:59:23 -0700
X-CSE-ConnectionGUID: 0riXiJskQRuDboGamoaJsA==
X-CSE-MsgGUID: CpNlCEPHRoifXiBgZZT3rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="223160890"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.31])
  by orviesa007.jf.intel.com with ESMTP; 19 Mar 2026 04:59:04 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	stable@vger.kernel.org,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Mathew Alwin <alwin.mathew@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v7 2/2] drm/xe: Reject coh_none PAT index for CPU_ADDR_MIRROR
Date: Thu, 19 Mar 2026 11:58:58 +0000
Message-ID: <20260319115858.444541-3-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319115858.444541-1-jia.yao@intel.com>
References: <20260129000147.339361-1-jia.yao@intel.com>
 <20260319115858.444541-1-jia.yao@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227280-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.993];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFDE42CADEE
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

v6:
- No change

v7:
- Correct fix tag

Fixes: b43e864af0d4 ("drm/xe/uapi: Add DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR")
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


