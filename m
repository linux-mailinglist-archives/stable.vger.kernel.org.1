Return-Path: <stable+bounces-212917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uiQHHcQrfWmPQgIAu9opvQ
	(envelope-from <stable+bounces-212917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 23:08:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CF8BF052
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 23:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B25F3011852
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 22:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CDF3502AE;
	Fri, 30 Jan 2026 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuFO6BzM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FE2D23B6
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810881; cv=none; b=tyZB6CzjredteGVJTde09u1pKzt4JTivl70Ea894x1Z2OspOys8F8aL/LZZvXme2tyS2DETMqZKjzNhgiRQmYIEqdf3vbIUAhwUJ+VzrO7pqjZUF3tU1tst0BxBSbecLQ3ksZnRlRoknwng8aX8XRIMxkwqpMKEcvOpA1vyMEqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810881; c=relaxed/simple;
	bh=Dg+h7Tev3AkPmB+X8QR61HHPpOAMika6IoT9ZBEYiNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdSAwPkR9lKDJvmp1J+JwHQwPquQo6b7dKm+RQfmvl2rWuMiUTz15iUc666G2NqTghQjtrQ/6Rdt8Mlv7ywAH7xpBMOxuTeWd/CutJDS/Jvfb246AVG66PXwmj/McabPTmPxB57FppnJGyDcIFGpd4S0jpuEUE5DREmEGVYOrs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuFO6BzM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769810880; x=1801346880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dg+h7Tev3AkPmB+X8QR61HHPpOAMika6IoT9ZBEYiNI=;
  b=fuFO6BzMsrTwqeJIejHk/SvGbTCn3xkmUNCm7uB6uZ52QiZBJwyAbUKV
   OVLlV4uz0OML62jdWCMOv01pid/R1kvd0EjmM4QxmNJRoZ4TXWcOkboVU
   3xZ8tfjJbHXwqhZ8BIYqKpP/XS7RPOOyeW9W29lmM1KiJhsr+V5ZE7lmK
   NTYukm98sbfL4c+qrMXakAhOvBbNBPei6rgTi7cUcwZ/kSvXM2v6hntSQ
   9kSJ7aXvAAPx4lNc+tLonBTVbVbL4G+vobhIm+WnNa8MKifLk8HUKSKT+
   4kvjX7EwaNZWeedIW9iCFj6OcWTMSvGo5KLS93/v155ClrW08xwdPFeQr
   w==;
X-CSE-ConnectionGUID: 7czJqK+ATd+FatyPsfiI4Q==
X-CSE-MsgGUID: 4JgZ45zDQyWnjZjWIUjCDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="81800203"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="81800203"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 14:08:00 -0800
X-CSE-ConnectionGUID: DionjiCNSe2Jtsk607jDBw==
X-CSE-MsgGUID: OBuSjlPCRnGavi+Z2H5EJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="213459060"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.45])
  by fmviesa005.fm.intel.com with ESMTP; 30 Jan 2026 14:07:59 -0800
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	stable@vger.kernel.org,
	Mathew Alwin <alwin.mathew@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v3] drm/xe/uapi: Reject coh_none PAT index for CPU cached memory in madvise
Date: Fri, 30 Jan 2026 22:07:49 +0000
Message-ID: <20260130220750.573838-1-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129000147.339361-1-jia.yao@intel.com>
References: <20260129000147.339361-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212917-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: C4CF8BF052
X-Rspamd-Action: no action

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

Fixes: ada7486c5668 ("drm/xe: Implement madvise ioctl for xe")
Cc: stable@vger.kernel.org # v6.18
Cc: Mathew Alwin <alwin.mathew@intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Jia Yao <jia.yao@intel.com>
---
 drivers/gpu/drm/xe/xe_vm_madvise.c | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
index add9a6ca2390..50b82e821da7 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -352,6 +352,44 @@ static void xe_madvise_details_fini(struct xe_madvise_details *details)
 	drm_pagemap_put(details->dpagemap);
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
+		} else if (XE_IOCTL_DBG(xe, xe_vma_is_cpu_addr_mirror(vma)) ||
+			   xe_vma_is_userptr(vma)) {
+			/* System memory (userptr/SVM) is always CPU cached */
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static bool check_bo_args_are_sane(struct xe_vm *vm, struct xe_vma **vmas,
 				   int num_vmas, u32 atomic_val)
 {
@@ -442,6 +480,14 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 	if (err || !madvise_range.num_vmas)
 		goto madv_fini;
 
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
@@ -485,6 +531,7 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 err_fini:
 	if (madvise_range.has_bo_vmas)
 		drm_exec_fini(&exec);
+free_vmas:
 	kfree(madvise_range.vmas);
 	madvise_range.vmas = NULL;
 madv_fini:
-- 
2.43.0


