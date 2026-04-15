Return-Path: <stable+bounces-238051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ofivFxgu32ltPwAAu9opvQ
	(envelope-from <stable+bounces-238051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 08:20:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C52400CD5
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 08:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D86683042D26
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323D838A721;
	Wed, 15 Apr 2026 06:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPilC1ws"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E227388E6C
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 06:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776233998; cv=none; b=YIDDanqf3XZsKhTjG2xhImIIEZvkOOYLP7J/TPa8SikZubO3zTd2SDvgMWIjnK7bxY5nAJ2KMADz19XqLPH6PSZY1F3c51GVMKtvxw58c8wY0BqIbiNEpOKZ2hAOfM0GNi/WSyRTsW0jiuXq15Y0aryobye4SmGpjVLyQTWXJmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776233998; c=relaxed/simple;
	bh=eMbR7Cu1NFOdCWd/VCVRpcxvp6hUIpsNoyHhWBg1QX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOUYo7qV3iRrPpmKuoMkGjXQfNwhE782XoL0ZJn7HBjpOUVCIlEUw1ynxIYg02Df4mhH7kZHRG64dZ/UtFEvnAO1RjjWd4t5XXm+LH7PxraH25QseNDdxP8Bpz/5NPnlLrR9IwMITZuG2Ruux8P78bMpBaxEdyEN2i5EE/KQaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPilC1ws; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776233997; x=1807769997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eMbR7Cu1NFOdCWd/VCVRpcxvp6hUIpsNoyHhWBg1QX8=;
  b=NPilC1wsu3ZPH7O+ant52Ju2QchnZRa+8bmTIfxLcZHggVw73ZauNZqc
   k1muWdMpIOzld+TN7Y19RElm3OHU2CfIUXAoSUurwMfsfrEVyQSO0/qAI
   hcde5fVxi6NdvaVCVuEOu273VS1QwSqO9Y/bAwKaJoY7Ymd0GpufyBggW
   h0KISiq+g4xARShmja/Aa3UaHuQIyVrk/Vh9igaGmRLp2reGzlt6UwI6t
   uEomTz96a4etydEJr3U4mdMHrj+Wz395kuCDgn80ouITnwiZxm30QXtkd
   ti4PnC3z3lkga8orXY/FJJMApMz+FTCRJQFl6x4ZKZTIwRlcGrs5nOmwW
   g==;
X-CSE-ConnectionGUID: uXZgH3V4R+qW0Cb1YzYxzw==
X-CSE-MsgGUID: TNhWlh4ORea1OhJYVgB34Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77080168"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77080168"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 23:19:56 -0700
X-CSE-ConnectionGUID: cux5SkvST12rEPN8GnhTGQ==
X-CSE-MsgGUID: 1fGEu1g6SFKSfHQge3M+0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227675220"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.31])
  by fmviesa008.fm.intel.com with ESMTP; 14 Apr 2026 23:19:56 -0700
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
Subject: [PATCH v8 1/2] drm/xe/uapi: Reject coh_none PAT index for CPU cached memory in madvise
Date: Wed, 15 Apr 2026 06:19:50 +0000
Message-ID: <20260415061951.427699-2-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415061951.427699-1-jia.yao@intel.com>
References: <20260129000147.339361-1-jia.yao@intel.com>
 <20260415061951.427699-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238051-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: C9C52400CD5
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
 drivers/gpu/drm/xe/xe_vm_madvise.c | 45 ++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
index 66f00d3f5c07..f6e4a44db654 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -621,6 +621,43 @@ static int xe_madvise_purgeable_retained_to_user(const struct xe_madvise_details
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
+	 * Using coh_none with CPU cached buffers is not allowed.
+	 * Otherwise CPU page clearing can be bypassed, which is a
+	 * security issue. GPU can directly access system memory and
+	 * bypass CPU caches, potentially reading stale sensitive data
+	 * from previously freed pages.
+	 */
+	if (coh_mode != XE_COH_NONE)
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
@@ -750,6 +787,14 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
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


