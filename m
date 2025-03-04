Return-Path: <stable+bounces-120359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F81A4EC76
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 19:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2E9900A82
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24F9290BBF;
	Tue,  4 Mar 2025 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TTO869xl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF7624EAB6
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109640; cv=none; b=Rlz3hr6pzbObo7GmUN3tmL+iUGRl5AJTllYf1Cg0SM13vPHANL3ISBcgUwFhnHODz3pelxVog5FUZLss7cY0ZMk566rypOcYSGsC83wQkvvLtsDot0VIH9KTFgzZgVe+fJVLnZa5J9UFrXv+O4tvWN1mqePB47cQMtcvyhg8O40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109640; c=relaxed/simple;
	bh=KACD+HRKWUt1KmXIIu5IM9U2jfv4bZXfbf1wqQzbCuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gthiO6HUCNjyUZTQ/4y8QMEA/QUwNqIzLDDWrdKfsvWBxchxsBLKOHmpfKaKiQrWYJ1yBxhALxLVq2AoYBV/y94EFyiX49UUNCSuA2kwkYQLuQjznHORw/e1Z+WtD4pEgfvN/Nz5YVHTKpa66wW0A9jVhywPeQeOmCz/6Ldje5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TTO869xl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741109638; x=1772645638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KACD+HRKWUt1KmXIIu5IM9U2jfv4bZXfbf1wqQzbCuA=;
  b=TTO869xl2B4Ot3hjpGGVlYc+lRv+zxTYBWBVWpVDLANf2IYU652LhH4/
   K0iQME1uSFsBL8OCV54JYg4mSrIl1vwiHTv3hnjr9eB/OTBm6bCm4WU2P
   uzxe8Q+XPicNxR/Q7b0V/pfl/vVE8u4DZqhps54U9cW0Lvox0V+nMPMPv
   QUOp4LF/ryQBGAjh4hFNZoQZEW4G6c2f4szHXfQLq29kHfF/fuuViZodQ
   n6v941MdzJpdZd0eXcw5FmzJl0BxNWi5enEhukaIfAksQXQxgnJnUO0jc
   8jpvco0itbDGYGRknKelA80xibYGggsL6u9POEZun+a3Ijw884+LiQj76
   g==;
X-CSE-ConnectionGUID: 3oMDcEP/Sri3H3BfXX/p9Q==
X-CSE-MsgGUID: lFCWgZ9bQRiiVu6ZnhwF/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42172075"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="42172075"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 09:33:58 -0800
X-CSE-ConnectionGUID: R72aXBDBQamsO2w++iYZFA==
X-CSE-MsgGUID: gbnrz+10See2dQtwJTn8UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="119123287"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO fedora..) ([10.245.246.227])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 09:33:56 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Oak Zeng <oak.zeng@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] drm/xe/hmm: Style- and include fixes
Date: Tue,  4 Mar 2025 18:33:40 +0100
Message-ID: <20250304173342.22009-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304173342.22009-1-thomas.hellstrom@linux.intel.com>
References: <20250304173342.22009-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add proper #ifndef around the xe_hmm.h header, proper spacing
and since the documentation mostly follows kerneldoc format,
make it kerneldoc. Also prepare for upcoming -stable fixes.

Fixes: 81e058a3e7fd ("drm/xe: Introduce helper to populate userptr")
Cc: Oak Zeng <oak.zeng@intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_hmm.c | 9 +++------
 drivers/gpu/drm/xe/xe_hmm.h | 5 +++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hmm.c b/drivers/gpu/drm/xe/xe_hmm.c
index 089834467880..c56738fa713b 100644
--- a/drivers/gpu/drm/xe/xe_hmm.c
+++ b/drivers/gpu/drm/xe/xe_hmm.c
@@ -19,11 +19,10 @@ static u64 xe_npages_in_range(unsigned long start, unsigned long end)
 	return (end - start) >> PAGE_SHIFT;
 }
 
-/*
+/**
  * xe_mark_range_accessed() - mark a range is accessed, so core mm
  * have such information for memory eviction or write back to
  * hard disk
- *
  * @range: the range to mark
  * @write: if write to this range, we mark pages in this range
  * as dirty
@@ -43,11 +42,10 @@ static void xe_mark_range_accessed(struct hmm_range *range, bool write)
 	}
 }
 
-/*
+/**
  * xe_build_sg() - build a scatter gather table for all the physical pages/pfn
  * in a hmm_range. dma-map pages if necessary. dma-address is save in sg table
  * and will be used to program GPU page table later.
- *
  * @xe: the xe device who will access the dma-address in sg table
  * @range: the hmm range that we build the sg table from. range->hmm_pfns[]
  * has the pfn numbers of pages that back up this hmm address range.
@@ -112,9 +110,8 @@ static int xe_build_sg(struct xe_device *xe, struct hmm_range *range,
 	return ret;
 }
 
-/*
+/**
  * xe_hmm_userptr_free_sg() - Free the scatter gather table of userptr
- *
  * @uvma: the userptr vma which hold the scatter gather table
  *
  * With function xe_userptr_populate_range, we allocate storage of
diff --git a/drivers/gpu/drm/xe/xe_hmm.h b/drivers/gpu/drm/xe/xe_hmm.h
index 909dc2bdcd97..9602cb7d976d 100644
--- a/drivers/gpu/drm/xe/xe_hmm.h
+++ b/drivers/gpu/drm/xe/xe_hmm.h
@@ -3,9 +3,14 @@
  * Copyright © 2024 Intel Corporation
  */
 
+#ifndef _XE_HMM_H_
+#define _XE_HMM_H_
+
 #include <linux/types.h>
 
 struct xe_userptr_vma;
 
 int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma, bool is_mm_mmap_locked);
+
 void xe_hmm_userptr_free_sg(struct xe_userptr_vma *uvma);
+#endif
-- 
2.48.1


