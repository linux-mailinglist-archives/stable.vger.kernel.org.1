Return-Path: <stable+bounces-20297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98229856B7A
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 18:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549D7285E4B
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 17:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06D113956B;
	Thu, 15 Feb 2024 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdxADgb4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A2B135A40
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019207; cv=none; b=n9T1Cn5k0cj/rEIULRbbs0ru5Vcz/LG/wO6IQzbLaeTsB1IM5/JCf2zqVl9LbS+1b0okl8tATGRtYfeR8AyaTPDQOR4j3Ubeyv0momWw3rJcGQ1ORoisTJwFP8kkjPmIIQ6faLXgyGpzDDL7s18MzSIOuL/aHTZUdXW+gKFvEN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019207; c=relaxed/simple;
	bh=QsAcbwqS9NG5zOC8meKG7XXp4iiGY4OFkDlGSkASW1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRk19vkSgcZgjDx3+HS1vcz7nKhh9fvpJu+8SzcBqFq+nA79nXOkeMbDC1Zla1fvfW3o+Sn3Zvs7YbhAybOS7aXh5v6ZLQTG8SHoz273W6kQhDrOLdrV7ESqav9CY3+LkZoyBzQuup4DdFzYiqo/km6hWoE8dYSt4MSzDfZn0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdxADgb4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708019206; x=1739555206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QsAcbwqS9NG5zOC8meKG7XXp4iiGY4OFkDlGSkASW1E=;
  b=cdxADgb4MOaChSTFa+fCzB6r4MQQpBrZrym3tlmLTnTwkSYPRFsrz5kr
   z9lwQObxfqRZIn7ew5TgwzFnyegE0uWHuJjeYl4kCKBuEL2E2AhVkVNke
   3GyQetpsutJ9brMqbKruMjvC85uSXSHQMYjB6BvuSRiSr+I9NkMG9Vm5+
   h/mgIBZOfvlP/HMI9zEhOxTRF7vbUNW2L71A85acYSaCiwSh5qGB8R7tU
   ITaZmZSIBDrhKOkpw1Fn9d1XcYOLVaV5k4CGAhHy1RPrEKADPo30hGqf5
   Gz6RK44gwEmdWE3NxsXkGB/uDtwTcO2mCS6P8N1KL4VLMlrLsS1N1ZUvy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="13513994"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="13513994"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 09:46:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="3892077"
Received: from dhalpin-mobl1.ger.corp.intel.com (HELO mwauld-mobl1.intel.com) ([10.252.21.158])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 09:46:40 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/6] drm/buddy: fix range bias
Date: Thu, 15 Feb 2024 17:44:33 +0000
Message-ID: <20240215174431.285069-8-matthew.auld@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215174431.285069-7-matthew.auld@intel.com>
References: <20240215174431.285069-7-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is a corner case here where start/end is after/before the block
range we are currently checking. If so we need to be sure that splitting
the block will eventually give use the block size we need. To do that we
should adjust the block range to account for the start/end, and only
continue with the split if the size/alignment will fit the requested
size. Not doing so can result in leaving split blocks unmerged when it
eventually fails.

Fixes: afea229fe102 ("drm: improve drm_buddy_alloc function")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: <stable@vger.kernel.org> # v5.18+
---
 drivers/gpu/drm/drm_buddy.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index c1a99bf4dffd..d09540d4065b 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -332,6 +332,7 @@ alloc_range_bias(struct drm_buddy *mm,
 		 u64 start, u64 end,
 		 unsigned int order)
 {
+	u64 req_size = mm->chunk_size << order;
 	struct drm_buddy_block *block;
 	struct drm_buddy_block *buddy;
 	LIST_HEAD(dfs);
@@ -367,6 +368,15 @@ alloc_range_bias(struct drm_buddy *mm,
 		if (drm_buddy_block_is_allocated(block))
 			continue;
 
+		if (block_start < start || block_end > end) {
+			u64 adjusted_start = max(block_start, start);
+			u64 adjusted_end = min(block_end, end);
+
+			if (round_down(adjusted_end + 1, req_size) <=
+			    round_up(adjusted_start, req_size))
+				continue;
+		}
+
 		if (contains(start, end, block_start, block_end) &&
 		    order == drm_buddy_block_order(block)) {
 			/*
-- 
2.43.0


