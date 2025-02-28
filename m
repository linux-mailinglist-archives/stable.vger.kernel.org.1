Return-Path: <stable+bounces-119895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F4192A4922F
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCFE16C55E
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 07:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907CC1C5499;
	Fri, 28 Feb 2025 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CcqH9r+n"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7491B70825
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727876; cv=none; b=s+V623z/a2l/21oCjL+WotpovmmEgDMm7XU2TF9g8TU1bKpyA8udS0GTrwuip0bBuGtsSzNMCEoianSneMwR3j2siKKxryhZNNWHULmAUha4GvWBKpzfv60eW8O0JW0wDFBfJVe5HaDaY6Hu1GuML2DjFJnMFDeI3VllAGnnM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727876; c=relaxed/simple;
	bh=CEkfLAZp/UoSi/lc1J+/rutqDaJvRm0Fzr05Jy05b/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1KDTgQCWf2U0aWx1n9057qeG/iz0qyH9SZKBjpnDpk+1JksZKBl6o2i7CMg5ieARpfEgzrD/SgFMUQmK8PBHQNJrtl/fALS0C34Sw+OVAs56s+yR8oCdmOAhowYTNIySbupfr87E7GDJl2Z45Z+sKp3VdM5RGkn9suAEd5w8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CcqH9r+n; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740727875; x=1772263875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CEkfLAZp/UoSi/lc1J+/rutqDaJvRm0Fzr05Jy05b/E=;
  b=CcqH9r+nu3Yhc8+PsTDCqTZ9C6ZuJpoN/mPL19RTVC9c8uNxioiMhBDd
   WcnX130vyqiTMd3Xq4CR4DBtiMQ963nKLz7ix1MkVK6NmmTkk4Vbxodwq
   1KkBZk778C567qXlM+ohsICU9LJSqH+zBy+FAMYXNcPnOpX3FjqEljj7e
   Z2m2Z0gcVM0H9tM6WqE8P1ou1WL+utuAbyWCRlrksbCY8iVB3oTssXZuq
   Cv91aoEgCC4p3pQqi3MdmArUh2Sz7a0URf1DXIHa4N3jg+Xwrfud1WHNG
   y9/Z9Mr/NJAjQjbZNX1WcACZ57/7nrJJCCfN4B7HtRR/6a59BrULJwyje
   Q==;
X-CSE-ConnectionGUID: DAwOUL4XRICoKtMSsXPwXw==
X-CSE-MsgGUID: /iavKNt/SveclCxBXo/Kxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45297764"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="45297764"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:31:14 -0800
X-CSE-ConnectionGUID: YBEkS2DcTAWhDShtRRsoRg==
X-CSE-MsgGUID: 49WHmvn0SwGv6g/GbSa9bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121386223"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO fedora..) ([10.245.246.232])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:31:12 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] drm/xe/vm: Validate userptr during gpu vma prefetching
Date: Fri, 28 Feb 2025 08:30:55 +0100
Message-ID: <20250228073058.59510-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228073058.59510-1-thomas.hellstrom@linux.intel.com>
References: <20250228073058.59510-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If a userptr vma subject to prefetching was already invalidated
or invalidated during the prefetch operation, the operation would
repeatedly return -EAGAIN which would typically cause an infinite
loop.

Validate the userptr to ensure this doesn't happen.

v2:
- Don't fallthrough from UNMAP to PREFETCH (Matthew Brost)

Fixes: 5bd24e78829a ("drm/xe/vm: Subclass userptr vmas")
Fixes: 617eebb9c480 ("drm/xe: Fix array of binds")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.9+
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 996000f2424e..6fdc17be619e 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2306,8 +2306,17 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
 			break;
 		}
 		case DRM_GPUVA_OP_UNMAP:
+			xe_vma_ops_incr_pt_update_ops(vops, op->tile_mask);
+			break;
 		case DRM_GPUVA_OP_PREFETCH:
-			/* FIXME: Need to skip some prefetch ops */
+			vma = gpuva_to_vma(op->base.prefetch.va);
+
+			if (xe_vma_is_userptr(vma)) {
+				err = xe_vma_userptr_pin_pages(to_userptr_vma(vma));
+				if (err)
+					return err;
+			}
+
 			xe_vma_ops_incr_pt_update_ops(vops, op->tile_mask);
 			break;
 		default:
-- 
2.48.1


