Return-Path: <stable+bounces-120237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 548CFA4DCC1
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 12:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE437A384F
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 11:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607261FFC57;
	Tue,  4 Mar 2025 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjeC8CWk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59491FECB1
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088299; cv=none; b=AtFitGgYCeJnryS87wHRcMQxo2EAFpyPEBWJQCEFVoMI91iImquzxC2U0MVeNkW3UP5ykWM7r9nEfh9r5WM+xu5Iy+fRMmTDCF56c0J6cnQKz3BcvHN1fX19Mke7fncKy+B8EVmPYqWFrla//x5AK6B1fAtSic5JVRp4N6G1sbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088299; c=relaxed/simple;
	bh=KACD+HRKWUt1KmXIIu5IM9U2jfv4bZXfbf1wqQzbCuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9JxYyhourrud9ehdKY25YoXJcxPUPdfnPc8oaqvO7UFzNtzqXX//83wD2r9aitIUJIda/+/ff5BBMz7eqeklk4EOM9a2K6cy1tNpxZlPYsIrR/pPd0ZWXf67bzSZCKlxl/5dWvCxdqRRbXDPbZTpOUR+j3WfLj9lVB7HXuwxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjeC8CWk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741088298; x=1772624298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KACD+HRKWUt1KmXIIu5IM9U2jfv4bZXfbf1wqQzbCuA=;
  b=EjeC8CWkrNopF7TpCMtPqgXinVqyyWNdh9huRdbMjQLN2Y1PJmIfQmng
   IdmOQpKN9NRp5cldOo8mk9SkCtwD/g7Wbbz9jfB66dF2f3KY0GgXl+cZD
   n+v0nQ2Vova3Ljd7j1bIc4HxPFIuxQAbyPVJVzYiXOWaDnJxEXE6Vdm63
   wO2ilR2jw+eywqipI695VDra42yC/WNEttx6Z1aOnuAgP4eCIOY7gMnRn
   RDhIorjMxDwOB5lNE/92LlufnMzZn6BbK6d6LWgBlshtVHaMOn/t8NqGZ
   nmT//43tJjwn1eOeTUJHGukWFmtqFS5x8VrFu+F8Vdc7aiMp/yzi7+dsT
   A==;
X-CSE-ConnectionGUID: 7mqVIJdfTVq4IdYGq9yLpA==
X-CSE-MsgGUID: ZzJtykF3RKO/gDfvjur1pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="59413170"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="59413170"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:38:18 -0800
X-CSE-ConnectionGUID: xZHQcpISQDiZaNjIZjCD+g==
X-CSE-MsgGUID: Yl8PLdEGS5mqLqVHVWMKbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="123471662"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO fedora..) ([10.245.246.227])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:38:15 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Oak Zeng <oak.zeng@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] drm/xe/hmm: Style- and include fixes
Date: Tue,  4 Mar 2025 12:37:56 +0100
Message-ID: <20250304113758.67889-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304113758.67889-1-thomas.hellstrom@linux.intel.com>
References: <20250304113758.67889-1-thomas.hellstrom@linux.intel.com>
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


