Return-Path: <stable+bounces-238250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOiFAeZx4GlkgwAAu9opvQ
	(envelope-from <stable+bounces-238250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 07:21:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DE840A54A
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 07:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DE0230E5330
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 05:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401A3364EAF;
	Thu, 16 Apr 2026 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dmx4oaqA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8512363090
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 05:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776316804; cv=none; b=RPfMZVtbfou2b3TFRtnjXMXrwS5FMk7iMWDuhLNUm+5ShwSJmExytdIfGriXLLM0TpDKrB5VbYeofNXw1smiLGnFLxa3MOLbJGqJao4IlqQFyZn39vF6Hy1rJbrsXZvP9zavphenqCiYttDVYCpY35E5QVnF0huNzakZao3b5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776316804; c=relaxed/simple;
	bh=Egpj/pulBkJvdV9i2mAO9YG5vyuiCMX7boqbXrGww7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCBXHgLNLvgK68LSDZQbIh1Jtr8R2tmRSBBolDxCS6iZgThwqEz0ibXQ0P//g3AXP9MoONAd91/yGEF3SjVVWw5E+CQYdwr57mv41fvkhpz2FYTQ3GJR5a44L4j5SzmGj0sZ/2APjFGtDreV7uPNzJO06XZtG4K7lEvJ8tS/snA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dmx4oaqA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776316802; x=1807852802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Egpj/pulBkJvdV9i2mAO9YG5vyuiCMX7boqbXrGww7M=;
  b=Dmx4oaqAIDMNb/O028/EW+Wnnd3Mh91Qmc/9+YLY5eyCq3LQ1HWIVO2T
   deP+0GQgeJiQB+gzjwAY2gmqORZDfvos4DAzJ5VmTvzSL2JzvZYKySqye
   ZHI06eY9KFnnI6DNJqlvcFOio0vYP42H6T9s5XS4u1r0wYyBR6Y7LQdg/
   t5VUGXdXnodt+8GyKzLD2f25vxFgIKd9HbE3O1ofN0De1MFFwiQHPL5QE
   cEboFHJZ/mxcTiXsT9rTLsa/pxd3nSVLaXyLv37n1uVEfxeGI5aOsDnCg
   OmAswg+7UYT6fiCycZFXKt8nKPaYsvseqvTXpu6qr/zbtTRefxuOrFW/4
   g==;
X-CSE-ConnectionGUID: i86HGnX+TJGDm61mDEJUbw==
X-CSE-MsgGUID: AeTtzZQYTaOJJbQnegyi3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77213045"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77213045"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 22:20:01 -0700
X-CSE-ConnectionGUID: 8A+4+sW1QhaUZBg4ciwBxA==
X-CSE-MsgGUID: 527cb4J/Q5ObTl4kiqYmow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="227963726"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.31])
  by fmviesa008.fm.intel.com with ESMTP; 15 Apr 2026 22:20:00 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	stable@vger.kernel.org,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Mathew Alwin <alwin.mathew@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH v9 1/2] drm/xe/uapi: Reject coh_none PAT index for CPU cached memory in madvise
Date: Thu, 16 Apr 2026 05:19:56 +0000
Message-ID: <20260416051957.651337-2-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416051957.651337-1-jia.yao@intel.com>
References: <20260416051957.651337-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	TAGGED_FROM(0.00)[bounces-238250-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4DE840A54A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add validation in xe_vm_madvise_ioctl() to reject PAT indices with
XE_COH_NONE coherency mode when applied to CPU cached memory.

Using coh_none with CPU cached buffers is a security issue. When the
kernel clears pages before reallocation, the clear operation stays in
CPU cache (dirty). GPU with coh_none can bypass CPU caches and read
stale sensitive data directly from DRAM, potentially leaking data from
previously freed pages of other processes.

This aligns with the existing validation in vm_bind path
(xe_vm_bind_ioctl_validate_bo).

v2(Matthew brost)
- Add fixes
- Move one debug print to better place

v3(Matthew Auld)
- Should be drm/xe/uapi
- More Cc

v4(Shuicheng Lin)
- Fix kmem leak issues by the way

v5
- Remove kmem leak because it has been merged by another patch

v6
- Remove the fix which is not related to current fix

v7
- No change

v8
- Rebase

v9
- Limit the restrictions to iGPU

Fixes: ada7486c5668 ("drm/xe: Implement madvise ioctl for xe")
Cc: stable@vger.kernel.org # v6.18
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Mathew Alwin <alwin.mathew@intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Acked-by: Michal Mrozek <michal.mrozek@intel.com>
Acked-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/gpu/drm/xe/xe_vm_madvise.c | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
index 66f00d3f5c07..c78906dea82b 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -621,6 +621,45 @@ static int xe_madvise_purgeable_retained_to_user(const struct xe_madvise_details
 	return 0;
 }
 
+static bool check_pat_args_are_sane(struct xe_device *xe,
+				    struct xe_vmas_in_madvise_range *madvise_range,
+				    u16 pat_index)
+{
+	u16 coh_mode = xe_pat_index_get_coh_mode(xe, pat_index);
+	int i;
+
+	/*
+	 * Using coh_none with CPU cached buffers is not allowed on iGPU.
+	 * On iGPU the GPU shares the LLC with the CPU, so with coh_none
+	 * the GPU bypasses CPU caches and reads directly from DRAM,
+	 * potentially seeing stale sensitive data from previously freed
+	 * pages. On dGPU this restriction does not apply, because the
+	 * platform does not provide a non-coherent system memory access
+	 * path that would violate the DMA coherency contract.
+	 */
+	if (coh_mode != XE_COH_NONE || IS_DGFX(xe))
+		return true;
+
+	for (i = 0; i < madvise_range->num_vmas; i++) {
+		struct xe_vma *vma = madvise_range->vmas[i];
+		struct xe_bo *bo = xe_vma_bo(vma);
+
+		if (bo) {
+			/* BO with WB caching + COH_NONE is not allowed */
+			if (XE_IOCTL_DBG(xe, bo->cpu_caching == DRM_XE_GEM_CPU_CACHING_WB))
+				return false;
+			/* Imported dma-buf without caching info, assume cached */
+			if (XE_IOCTL_DBG(xe, !bo->cpu_caching))
+				return false;
+		} else if (XE_IOCTL_DBG(xe, xe_vma_is_cpu_addr_mirror(vma) ||
+					    xe_vma_is_userptr(vma)))
+			/* System memory (userptr/SVM) is always CPU cached */
+			return false;
+	}
+
+	return true;
+}
+
 static bool check_bo_args_are_sane(struct xe_vm *vm, struct xe_vma **vmas,
 				   int num_vmas, u32 atomic_val)
 {
@@ -750,6 +789,14 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 		}
 	}
 
+	if (args->type == DRM_XE_MEM_RANGE_ATTR_PAT) {
+		if (!check_pat_args_are_sane(xe, &madvise_range,
+					     args->pat_index.val)) {
+			err = -EINVAL;
+			goto free_vmas;
+		}
+	}
+
 	if (madvise_range.has_bo_vmas) {
 		if (args->type == DRM_XE_MEM_RANGE_ATTR_ATOMIC) {
 			if (!check_bo_args_are_sane(vm, madvise_range.vmas,
-- 
2.43.0


