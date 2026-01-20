Return-Path: <stable+bounces-210555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMWiLQu6b2kOMQAAu9opvQ
	(envelope-from <stable+bounces-210555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 18:23:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEF4487C2
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 18:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21E40780765
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 14:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D937A407596;
	Tue, 20 Jan 2026 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OT1RdLuF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DBE1F37D4
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919728; cv=none; b=u+E2ng0ogYGeRqJp6Il7l478H6PisYpiv9PzSdK2JcGfDQBRRMChN0WLGxc3FmImUuz+F0reMo/GgSD5okYMrMM+mUPZJrxGk7msnn+xV+reZa0yByjlTGgHkZbNl00MlBnpx8Z7bRj2CVp3NPHImxsTh9b0S8ZcewN0j04bJSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919728; c=relaxed/simple;
	bh=CcR8WWhjCXEIGjN5Z77f7XLe7vIqq2ciTdPVJ57DYQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dz56iJ+8v74rKBBGeQA2xW/3VH0r6NG1ta2jbbZTM7VBsR/GiGEywEhVMJLwK2YuO3p+zfrb/5EN/YMIhP8Rk59p6rAR2bcdnH2yGQZlG6ir7XnpxUGjsDPgsT8tJu3jA2WWr+ibXSGLogaCxV02PmzRbjZhKuNdm9CTU8rbJI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OT1RdLuF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768919726; x=1800455726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CcR8WWhjCXEIGjN5Z77f7XLe7vIqq2ciTdPVJ57DYQE=;
  b=OT1RdLuFeiddAeYVGv/nRUJ02b6E8FQh+4s2nypuc6kNHbD/kwd2zYf5
   TGFe7i50f6SVPFw+f678IFVwnHsFJCDnvOV++CIytrKep58i0qXm120UZ
   a6t+Vbqn+Iv1s4R0jzzQoEoM3UPPLNQQwv+BUy/CLGdrBSnjv6TOKMTEu
   Ih8L7hX/Wkq91mAu+udbIXNYSnBUCt/4oJsQnjssYbLqQmTQa5sHxy9G4
   fU7xVzTh1H0HWLhj+wF1Vr/2BI9gLLb4om3ha5hijFclL8pqIDvNd4fQh
   1Qps0RRZWw5ZaLtMQEnTtRAeBp1d641Lto1fOmvj9THO4lFiTx1AX9H/y
   g==;
X-CSE-ConnectionGUID: hzLMRYLDTPW9o+FCWBRhtA==
X-CSE-MsgGUID: OshxUPrBTJiHCN11nRbVWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="69327962"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="69327962"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 06:35:25 -0800
X-CSE-ConnectionGUID: Q2M738IbT/OJ/ksNIpAHYg==
X-CSE-MsgGUID: jfckAYjmQLWCm7UsLMNjHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="206171973"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO fedora) ([10.245.244.250])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 06:35:24 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm, drm/xe: Fix xe userptr in the absence of CONFIG_DEVICE_PRIVATE
Date: Tue, 20 Jan 2026 15:34:58 +0100
Message-ID: <20260120143459.9485-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120143459.9485-1-thomas.hellstrom@linux.intel.com>
References: <20260120143459.9485-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-210555-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.intel.com:mid,intel.com:email,intel.com:dkim,lists.freedesktop.org:email]
X-Rspamd-Queue-Id: 5AEF4487C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CONFIG_DEVICE_PRIVATE is not selected by default by some distros,
for example Fedora, and that leads to a regression in the xe driver
since userptr support gets compiled out.

It turns out that DRM_GPUSVM, which is needed for xe userptr support
compiles also without CONFIG_DEVICE_PRIVATE, but doesn't compile
without CONFIG_ZONE_DEVICE.
Exclude the drm_pagemap files from compilation with !CONFIG_ZONE_DEVICE,
and remove the CONFIG_DEVICE_PRIVATE dependency from CONFIG_DRM_GPUSVM and
the xe driver's selection of it, re-enabling xe userptr for those configs.

v2:
- Don't compile the drm_pagemap files unless CONFIG_ZONE_DEVICE is set.
- Adjust the drm_pagemap.h header accordingly.

Fixes: 9e9787414882 ("drm/xe/userptr: replace xe_hmm with gpusvm")
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.18+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/Kconfig    |  2 +-
 drivers/gpu/drm/Makefile   |  4 +++-
 drivers/gpu/drm/xe/Kconfig |  2 +-
 include/drm/drm_pagemap.h  | 18 ++++++++++++++----
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index a33b90251530..d3d52310c9cc 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -210,7 +210,7 @@ config DRM_GPUVM
 
 config DRM_GPUSVM
 	tristate
-	depends on DRM && DEVICE_PRIVATE
+	depends on DRM
 	select HMM_MIRROR
 	select MMU_NOTIFIER
 	help
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 0deee72ef935..0c21029c446f 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -108,9 +108,11 @@ obj-$(CONFIG_DRM_EXEC) += drm_exec.o
 obj-$(CONFIG_DRM_GPUVM) += drm_gpuvm.o
 
 drm_gpusvm_helper-y := \
-	drm_gpusvm.o\
+	drm_gpusvm.o
+drm_gpusvm_helper-$(CONFIG_ZONE_DEVICE) += \
 	drm_pagemap.o\
 	drm_pagemap_util.o
+
 obj-$(CONFIG_DRM_GPUSVM) += drm_gpusvm_helper.o
 
 obj-$(CONFIG_DRM_BUDDY) += drm_buddy.o
diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 4b288eb3f5b0..c34be1be155b 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -39,7 +39,7 @@ config DRM_XE
 	select DRM_TTM
 	select DRM_TTM_HELPER
 	select DRM_EXEC
-	select DRM_GPUSVM if !UML && DEVICE_PRIVATE
+	select DRM_GPUSVM if !UML
 	select DRM_GPUVM
 	select DRM_SCHED
 	select MMU_NOTIFIER
diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
index 46e9c58f09e0..2baf0861f78f 100644
--- a/include/drm/drm_pagemap.h
+++ b/include/drm/drm_pagemap.h
@@ -243,6 +243,8 @@ struct drm_pagemap_devmem_ops {
 			   struct dma_fence *pre_migrate_fence);
 };
 
+#if IS_ENABLED(CONFIG_ZONE_DEVICE)
+
 int drm_pagemap_init(struct drm_pagemap *dpagemap,
 		     struct dev_pagemap *pagemap,
 		     struct drm_device *drm,
@@ -252,17 +254,22 @@ struct drm_pagemap *drm_pagemap_create(struct drm_device *drm,
 				       struct dev_pagemap *pagemap,
 				       const struct drm_pagemap_ops *ops);
 
-#if IS_ENABLED(CONFIG_DRM_GPUSVM)
+struct drm_pagemap *drm_pagemap_page_to_dpagemap(struct page *page);
 
 void drm_pagemap_put(struct drm_pagemap *dpagemap);
 
 #else
 
+static inline struct drm_pagemap *drm_pagemap_page_to_dpagemap(struct page *page)
+{
+	return NULL;
+}
+
 static inline void drm_pagemap_put(struct drm_pagemap *dpagemap)
 {
 }
 
-#endif /* IS_ENABLED(CONFIG_DRM_GPUSVM) */
+#endif /* IS_ENABLED(CONFIG_ZONE_DEVICE) */
 
 /**
  * drm_pagemap_get() - Obtain a reference on a struct drm_pagemap
@@ -334,6 +341,8 @@ struct drm_pagemap_migrate_details {
 	u32 source_peer_migrates : 1;
 };
 
+#if IS_ENABLED(CONFIG_ZONE_DEVICE)
+
 int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 				  struct mm_struct *mm,
 				  unsigned long start, unsigned long end,
@@ -343,8 +352,6 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation);
 
 const struct dev_pagemap_ops *drm_pagemap_pagemap_ops_get(void);
 
-struct drm_pagemap *drm_pagemap_page_to_dpagemap(struct page *page);
-
 void drm_pagemap_devmem_init(struct drm_pagemap_devmem *devmem_allocation,
 			     struct device *dev, struct mm_struct *mm,
 			     const struct drm_pagemap_devmem_ops *ops,
@@ -359,4 +366,7 @@ int drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
 void drm_pagemap_destroy(struct drm_pagemap *dpagemap, bool is_atomic_or_reclaim);
 
 int drm_pagemap_reinit(struct drm_pagemap *dpagemap);
+
+#endif /* IS_ENABLED(CONFIG_ZONE_DEVICE) */
+
 #endif
-- 
2.52.0


