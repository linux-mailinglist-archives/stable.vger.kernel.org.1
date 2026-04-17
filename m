Return-Path: <stable+bounces-238414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K0sN97M4WkhyQAAu9opvQ
	(envelope-from <stable+bounces-238414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:02:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A37B4173B2
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4FF13022FA8
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFA0364032;
	Fri, 17 Apr 2026 05:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eX3iFN4F"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71282327C0D
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 05:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776405571; cv=none; b=DdYHOirQzn1pdsOtTWUYn0GzHe7IRLtJEz12SJEoGCb1zOUMVtI/pPhoOwG+eHP0/acb7ttSsJUjj3v3FdAnJZiZUEJudzb1LkGyDf6JK9JLlFQeXOTVZxuI0MAsH2nK1JPlXc+4To+zWd3PY6Dl4+gSPTmMvFo2dDMWU+VVKU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776405571; c=relaxed/simple;
	bh=OGGocu2xys/0xwbZpsro1lDSDniFsM16NOhw2/jLd6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=leFiZQpMUKc6h2U5/8+G6URlETEZNApk0KytQQH6nM6hwLRulT69XKzXjGyk2A6hcTsL0T5N4w1ieMJVd9COTeEWlVxG0LuOg0jpHhYGbO+Z9NMa/CEhGKTixWZjL+GuSaGA1il49s3OhAKcl9jFmZWGXitjKQktLthN7F5EhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eX3iFN4F; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776405569; x=1807941569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OGGocu2xys/0xwbZpsro1lDSDniFsM16NOhw2/jLd6I=;
  b=eX3iFN4FDWmP/6ZQhE93ZZxYXRabQwvLKYAWIsRVQwb9i8Lu156j+Zql
   W6MZwIcXtysxNDsOgrbD+P7BZEaEmaHmEfttCb8zs+xlwjL9xmYkZb+bw
   VP7P4idME6ciLbvEO3YPpbeJXnzr9ucsFhUU5NQTuhBsQLKHh+k6dfj16
   hkqZ0pDCibmTqf9in6EpbiOaP09M2DUQIEgQ2HZAiWwDOizGB9CF0sh/V
   aLl4rD3w0JDJ3d4pNmkFtmWWnk5/jvN1Ahe/ZyfyOSPCUscM/1DLoBsaG
   r0Xd8P+cV61CsatSV2Bh+73JnSZGRIiyBTTmCDzwHFqEgJa3g5QCr0l9R
   g==;
X-CSE-ConnectionGUID: TicsAHucR+WyGYfKSMjrEA==
X-CSE-MsgGUID: Ryek1CzATpW5HU66pTeD4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="102878737"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="102878737"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 22:59:25 -0700
X-CSE-ConnectionGUID: BV9iO/CZS2yz+4LnYyzHUA==
X-CSE-MsgGUID: 8k+oU+VTQ+e6+mIfJkzspA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="230871824"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.31])
  by orviesa008.jf.intel.com with ESMTP; 16 Apr 2026 22:59:25 -0700
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
Subject: [PATCH v10 1/2] drm/xe/uapi: Reject coh_none PAT index for CPU cached memory in madvise
Date: Fri, 17 Apr 2026 05:59:16 +0000
Message-ID: <20260417055917.2027459-2-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417055917.2027459-1-jia.yao@intel.com>
References: <20260417055917.2027459-1-jia.yao@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238414-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 5A37B4173B2
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

v10
- No change

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


