Return-Path: <stable+bounces-76058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA89977EDC
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 13:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0947EB20838
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 11:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA77C1D6C7F;
	Fri, 13 Sep 2024 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwbAvmZw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509A513CABC
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228277; cv=none; b=VQicTpVzLd5t8m2ey67hlZNkWR6N9f3q5FqvRPp+GLPP7qaO6YYbrd/QQ/8G6XM3y73xd+ioXjh1ll6skvN2UXhjVgcICo8jzIyc10CXP/0wQzmmcn5TaFmtf2Ixal8mxxlhAY/oaPMKUsp/0ba06/2lhN32XpDWpwMXrczAvX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228277; c=relaxed/simple;
	bh=rSWCJdBAc1nq/FNK0QvoGdZgx4JTA0BQvkuYlc62Sgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G2NZRf7VWQK/kHidFcyHawUU0+u+cg92NucNNBjgecWKir4lgl3KkBt7nUQ+OWnrKBWA211DTX4b/LJG8F4BxHA9bHTL5xkxGh5nVfsleOx2t43+Jl5+hV2lnzvR7biVy7YVEuidSnx/kvfLbSPJlXBBunSzWAafiDj/d/lS4ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwbAvmZw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726228276; x=1757764276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rSWCJdBAc1nq/FNK0QvoGdZgx4JTA0BQvkuYlc62Sgo=;
  b=FwbAvmZwTjm8wxArvF5gm1ju9qkRYwzEMM5MpPa4OuGNXv/zZHmEub/I
   h0wZaDezG9dOcMr2OIJVUHR6980GanCt76/oVTo4uLN0sNF7rxRmF0aF+
   hoWNaklS0tK0WA4hsyZu1ylvbn+F4EZOrDUxVL7LWq6Sv/keIj5/x2Mkz
   MCA2yJcttKpCQXVSJKRjVdIdNsRlwPZGGepLDSABfWDoVpt0Uuor64MEn
   fwktxHxk8PReS+4e+6fBxTWTLy36HNa+/zxn1ctwSO3bSoO44Y0aTLdMg
   rkX//zvDFU5/Zgse9zTJYBruBX0U0D17d2DQdSrnpgYPlehRzA2WxFBWL
   A==;
X-CSE-ConnectionGUID: CD8fdJ/mSm2qj4YI+IpPgw==
X-CSE-MsgGUID: mlMXPYuaQZe9GqpyQtpsAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35791403"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="35791403"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 04:51:15 -0700
X-CSE-ConnectionGUID: eJc8mSBvSnuJ+M+oRBo0VA==
X-CSE-MsgGUID: RM4PaBucSwaCtAQeTHAFLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="72797126"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.158])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 04:51:14 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Akshata Jahagirdar <akshata.jahagirdar@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/vram: fix ccs offset calculation
Date: Fri, 13 Sep 2024 12:51:03 +0100
Message-ID: <20240913115102.309587-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Spec says SW is expected to round up to the nearest 128K, if not already
aligned. We are seeing the assert sometimes pop on BMG to tell us that
there is a hole between GSM and CCS, as well as popping other asserts
with having a vram size with strange alignment, which is likely caused
by misaligned offset here.

BSpec: 68023
Fixes: b5c2ca0372dc ("drm/xe/xe2hpg: Determine flat ccs offset for vram")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
---
 drivers/gpu/drm/xe/xe_vram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
index 7e765b1499b1..8e65cb4cc477 100644
--- a/drivers/gpu/drm/xe/xe_vram.c
+++ b/drivers/gpu/drm/xe/xe_vram.c
@@ -181,6 +181,7 @@ static inline u64 get_flat_ccs_offset(struct xe_gt *gt, u64 tile_size)
 
 		offset = offset_hi << 32; /* HW view bits 39:32 */
 		offset |= offset_lo << 6; /* HW view bits 31:6 */
+		offset = round_up(offset, SZ_128K); /* SW must round up to nearest 128K */
 		offset *= num_enabled; /* convert to SW view */
 
 		/* We don't expect any holes */
-- 
2.46.0


