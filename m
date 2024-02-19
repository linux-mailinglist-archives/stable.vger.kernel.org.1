Return-Path: <stable+bounces-20523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 243FA85A311
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 13:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC552833E7
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAFA2D05D;
	Mon, 19 Feb 2024 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwWISvid"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9092D602
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345206; cv=none; b=LzJC30DLwl99ld94DtPTyT5VtaROgXZIYiJVbnh8bqfG55fTlbJKZk/xgRfS4TMGKOvrNaEjmZxu0wHAaDwHT2U0z9KCFtsbbIJzPzNg0hlb8SBDe4SAFvAkwFRH8f6z9zJfw1mbl2GFCHL/IQ+2jZS0ULpKN0RYUCfJPk4jcEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345206; c=relaxed/simple;
	bh=7JBRlvt+i6bh1/V8Jw81kJw0o9ZLt0D7L5GHyjg/Bqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=as4sla5aDDRUEhrxw3xxRl6ORmyGer9WGCiukdl4npzhbfoPMFgJBJOmo/QnrjTbNHKOiiCw9OIED/mXuDnNA0gak5+nl89qvDj864/2LGOKefjU5alfOSXqtUjtAEgV7Tn4xyGa5YwzNx16ZuvYzl0VR197ygT/Akl3nuAZ+4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwWISvid; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708345204; x=1739881204;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7JBRlvt+i6bh1/V8Jw81kJw0o9ZLt0D7L5GHyjg/Bqg=;
  b=jwWISvidh0xmS4TDq3RccbNMSY1FW591LuEp8Jt3U0+i2G07DsacKURI
   mSRZDaFh8aUPF4Y/Pi8YpQ5cpfJY53TVcRTrBcIONbQCYQQr95v+hXqjM
   L/o2g8ACeuzDWR8dGuV6tEC5La4/DHz0lMKr4dTGAguKiwCG9w4z3FptZ
   kJPM3/o2+6HtsbIpuznLSjL2di3dL4zn4FfTlGn4iCMzjuM+m5GZS6YAo
   OOcQw4zqFAD/JUwMmDYay9i2Quzs/DErTzMzeUOtF1u9pvwSqjUEHPqs6
   GB3VoSKLjdivoG1jnc3G/0XHudgGw+J7c3104Cx8jthYiveK07Xs7/KRg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2553154"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2553154"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:20:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4730229"
Received: from proe-mobl.ger.corp.intel.com (HELO mwauld-mobl1.intel.com) ([10.252.22.52])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:20:02 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] drm/buddy: fix range bias
Date: Mon, 19 Feb 2024 12:18:52 +0000
Message-ID: <20240219121851.25774-4-matthew.auld@intel.com>
X-Mailer: git-send-email 2.43.0
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
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/drm_buddy.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index c4222b886db7..f3a6ac908f81 100644
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


