Return-Path: <stable+bounces-206325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB18BD02B4A
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 13:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EF4C30BCC37
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 12:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F8244DB9A;
	Thu,  8 Jan 2026 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8cOMaPg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D044D6B2
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872046; cv=none; b=I97ykgyb5KdQD19xlTyI9SrTK7Y6UccnFK2ll+QbNvp4c5Mlh2/NNI4Qp6/MpwTnqqH9Q4rkdBRnysnuHyF+9MNxRpzpcVmn9YpRHQk7LnWwmywah2dpK4SjEUTgMNQDGmjk2LP+6HdTDyxRkMcDLgqi5SC3KO7iPSDCjRz/+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872046; c=relaxed/simple;
	bh=jc56LgLjYKnVgX0BKLfblpQNGyqAU34pv/3BOpItWY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVimOFdM/QQY3QctLixiPkUQwa5pBY214yXhm48qC/Y3Qtrwol92HmsKWdanB5KVtIwzobJTD9cWQqTFgacSh20u1AklRCHaKBNcTetV0Eo3mSla+Mg9qXMrz4hWxhjxLkkSvqUYVLjEar5kZJ0cOdStDzCQPW06+s8QuYcS0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8cOMaPg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767872043; x=1799408043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jc56LgLjYKnVgX0BKLfblpQNGyqAU34pv/3BOpItWY8=;
  b=l8cOMaPgI8p/bL3Jy84QRASFLiDwYkXst/vHuikCRWchOfqkHGmR+ov3
   2W4V44t3u1k/FSojy5/WRA0MFvpSUUk7RNPwl0mpbYNvNa8TvX6XHYz8I
   Tz6otydVRCbq/Iq/Q6P9AerNzU6VEbJM+2fbI2Pu11almFMY973pqFrA7
   SDA6smk2SxUmme2PqDCd7RCUoMnD+KZE+nNmrfZqQ6zAWkVfjTaehohOh
   N9yyK/MnUnx+yRc5BGz4smDR5b5ykEZARG+8AnkjSlDDCzvR1Z2F5aA3T
   bEOA1HKIQgzlUNOpRCLNiB0lCf3TMvHRsRzkG82200REzpGzFqDgnTbqE
   A==;
X-CSE-ConnectionGUID: k34mublWRxKMBn7Eqodv/Q==
X-CSE-MsgGUID: H7X5l0AwSlSCaEHhA6sFnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="71824651"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="71824651"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 03:34:01 -0800
X-CSE-ConnectionGUID: CQLjPiwZRGyRJhYvOefAlQ==
X-CSE-MsgGUID: qWNH+cnaRsCmI98m6tEeJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="208024040"
Received: from yadavs-z690i-a-ultra-plus.iind.intel.com ([10.190.216.90])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 03:33:59 -0800
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v2 1/2] drm/buddy: Prevent BUG_ON by validating rounded allocation
Date: Thu,  8 Jan 2026 17:02:29 +0530
Message-ID: <20260108113227.2101872-5-sanjay.kumar.yadav@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108113227.2101872-4-sanjay.kumar.yadav@intel.com>
References: <20260108113227.2101872-4-sanjay.kumar.yadav@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When DRM_BUDDY_CONTIGUOUS_ALLOCATION is set, the requested size is
rounded up to the next power-of-two via roundup_pow_of_two().
Similarly, for non-contiguous allocations with large min_block_size,
the size is aligned up via round_up(). Both operations can produce a
rounded size that exceeds mm->size, which later triggers
BUG_ON(order > mm->max_order).

Example scenarios:
- 9G CONTIGUOUS allocation on 10G VRAM memory:
  roundup_pow_of_two(9G) = 16G > 10G
- 9G allocation with 8G min_block_size on 10G VRAM memory:
  round_up(9G, 8G) = 16G > 10G

Fix this by checking the rounded size against mm->size. For
non-contiguous or range allocations where size > mm->size is invalid,
return -EINVAL immediately. For contiguous allocations without range
restrictions, allow the request to fall through to the existing
__alloc_contig_try_harder() fallback.

This ensures invalid user input returns an error or uses the fallback
path instead of hitting BUG_ON.

v2: (Matt A)
- Add Fixes, Cc stable, and Closes tags for context

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6712
Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
Cc: <stable@vger.kernel.org> # v6.7+
Cc: Christian König <christian.koenig@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Suggested-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/drm_buddy.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index 2f279b46bd2c..5141348fc6c9 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -1155,6 +1155,15 @@ int drm_buddy_alloc_blocks(struct drm_buddy *mm,
 	order = fls(pages) - 1;
 	min_order = ilog2(min_block_size) - ilog2(mm->chunk_size);
 
+	if (order > mm->max_order || size > mm->size) {
+		if ((flags & DRM_BUDDY_CONTIGUOUS_ALLOCATION) &&
+		    !(flags & DRM_BUDDY_RANGE_ALLOCATION))
+			return __alloc_contig_try_harder(mm, original_size,
+							 original_min_size, blocks);
+
+		return -EINVAL;
+	}
+
 	do {
 		order = min(order, (unsigned int)fls(pages) - 1);
 		BUG_ON(order > mm->max_order);
-- 
2.52.0


