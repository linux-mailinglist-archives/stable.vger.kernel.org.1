Return-Path: <stable+bounces-119929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351DDA497A2
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 11:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D208B18942D6
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C088E25F7A4;
	Fri, 28 Feb 2025 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3lOQbtN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEF525CC77
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739477; cv=none; b=FnroSJ6XgykeNvmqCUfSlJeU5og0P/ryGpD6xUq17p2vCIMzEsnYrGBwmTc/sWMx5ytUTmPBkEQaoKLsgNxMjRbNt8bVfEkxJ4v/kYCW4qLvL3DTIEgPmdNVptJUkY5OIQu1X+JBFZmdwP6/4ya5urtUWROKdz7lTa273sVoffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739477; c=relaxed/simple;
	bh=KACD+HRKWUt1KmXIIu5IM9U2jfv4bZXfbf1wqQzbCuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDdr+mVKux2ADSkDS3f6R2i3E4bXPiIhfPNq7pUzkGJPGkmG4dd/aXvb6N0kHmLEOE/pJ0pImf31kEvxdHfFwz8/Sbm6j582Mmfi5AmaGxzOjMbIx8zGmufKJZK5VNujljAhobyv3qi04z/zB92Kd8pGDIT6dpj2KqUvrwkRP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3lOQbtN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740739475; x=1772275475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KACD+HRKWUt1KmXIIu5IM9U2jfv4bZXfbf1wqQzbCuA=;
  b=h3lOQbtNbqpIM0iE2VdhHn1FcmfGbhL2XTGacZyfsb4wW2oW0Puhz6Fd
   waj84mYnfReoH+uVPN3S1nXWqn1pEX/TxMiLFN/FZnWOxhzMvo++8jacv
   c43VLV9PWm4QxqOyRfCUVyrAbXprU4p/3HEclCF6VGjmNU5Gx9GnXOqLY
   13DGEmQGkBM3TuUniNm9jHjeQ54ZOtcwvbLqhjS7iuudBatpjaYpbYj0a
   L5ULwhKDzQ4E5TPy+wzIzUUISQ1Yr2qVhFULeEhv0yPVIuOrA7yZC0j5d
   iCtJ1SnD7CVfnwsTzVhsg1jtUacsAFT3MbLTzrMrZjjeEh7gzGH8oFGBW
   w==;
X-CSE-ConnectionGUID: mR/Df7crSbaCkiWBmZyIsA==
X-CSE-MsgGUID: mrgNv6IMQ0itMVBxedkD/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40840563"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="40840563"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 02:44:34 -0800
X-CSE-ConnectionGUID: POcrjnFfShmIE5inW8tyMg==
X-CSE-MsgGUID: Uq63RyckS62FOP544wKp4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="148114580"
Received: from monicael-mobl3 (HELO fedora..) ([10.245.246.40])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 02:44:33 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Oak Zeng <oak.zeng@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] drm/xe/hmm: Style- and include fixes
Date: Fri, 28 Feb 2025 11:44:16 +0100
Message-ID: <20250228104418.44313-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228104418.44313-1-thomas.hellstrom@linux.intel.com>
References: <20250228104418.44313-1-thomas.hellstrom@linux.intel.com>
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


