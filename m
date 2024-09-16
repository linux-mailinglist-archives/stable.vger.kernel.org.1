Return-Path: <stable+bounces-76196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64070979D37
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 10:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4902825B3
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 08:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818C713EFF3;
	Mon, 16 Sep 2024 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxQyuVh2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D71145A07
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476568; cv=none; b=QJfWDVVvDQ5lEtWJIZgU07CGxP+Dff5ErMjee98W1NDqEz4B9km7jj3+5lnEdCTz/7DjzJyD0+w0Q+vBGt/bDTGeXgdtSTj+SSLmugWIxofl76Ir3BJp6fBC/LNHpvzZSsK70TJ8lINcBEG6BehNk4IE1EFQPpG4e4tAzcAq1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476568; c=relaxed/simple;
	bh=uymRN6t4HF0pj4doTRtGJuVhiLXV7AyJRx07mGHr4p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wl5micwux4PTAogjsvXmhk/gz1e1BwahB+XrhrgM/WM654+UNrluNJCeSfKe4z2kE4W5c0V0M858RRhIWo0UvA1M9500MgcmEbKtTUh/n7+AG+ZB7NZ7K+DX4kpAb5jTZnlyzqL94LYi9MVT9o1bCR85PTP8rLQHHsEoOJ60bMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxQyuVh2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726476567; x=1758012567;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uymRN6t4HF0pj4doTRtGJuVhiLXV7AyJRx07mGHr4p4=;
  b=bxQyuVh2D+HmB6kx+lalVeelm7sC3Fot7HhnqmjZIHMVUpXAsmHWckHJ
   hdc9791F/T0+cFd8fQ8LMBz4uvOwuHfiiaDepzi8Ri9hwTag8DDZFT7xl
   T42P67Xh00CKC8V4E4j36UKN/Y4djbL7BsvPtKAdOm2C8oeMO+mY2GFSA
   ZOhyxtrSmTJ2z8dXiasZgugOwD8INV5mrR3o0SO/gWSJrnHX3P0xjMIox
   bW7P3ZhhEm8A7lD1T5rbvbK6gtHtEtVn6+vqlLaSO5AMqyjHgrgyx6U9j
   HWGhL8oSeTg+fdXxr50ZhMmP2sLxulHu7L0r4uFeFBvRGw6NJfBc3smA7
   g==;
X-CSE-ConnectionGUID: EyWA94FQSYq8vlrNV7Kbog==
X-CSE-MsgGUID: RaQxJX+iQ8GCnG5v59z1bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="50710914"
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="50710914"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 01:49:26 -0700
X-CSE-ConnectionGUID: 57d0GLj2SUanMsARH+ANsQ==
X-CSE-MsgGUID: fEKIKArgQR69fGaFRXXFYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="69052874"
Received: from mlehtone-mobl.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.77])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 01:49:24 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Akshata Jahagirdar <akshata.jahagirdar@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/xe/vram: fix ccs offset calculation
Date: Mon, 16 Sep 2024 09:49:12 +0100
Message-ID: <20240916084911.13119-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Spec says SW is expected to round up to the nearest 128K, if not already
aligned for the CC unit view of CCS. We are seeing the assert sometimes
pop on BMG to tell us that there is a hole between GSM and CCS, as well
as popping other asserts with having a vram size with strange alignment,
which is likely caused by misaligned offset here.

v2 (Shuicheng):
 - Do the round_up() on final SW address.

BSpec: 68023
Fixes: b5c2ca0372dc ("drm/xe/xe2hpg: Determine flat ccs offset for vram")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Tested-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_vram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
index 7e765b1499b1..2a623bfcda7e 100644
--- a/drivers/gpu/drm/xe/xe_vram.c
+++ b/drivers/gpu/drm/xe/xe_vram.c
@@ -182,6 +182,7 @@ static inline u64 get_flat_ccs_offset(struct xe_gt *gt, u64 tile_size)
 		offset = offset_hi << 32; /* HW view bits 39:32 */
 		offset |= offset_lo << 6; /* HW view bits 31:6 */
 		offset *= num_enabled; /* convert to SW view */
+		offset = round_up(offset, SZ_128K); /* SW must round up to nearest 128K */
 
 		/* We don't expect any holes */
 		xe_assert_msg(xe, offset == (xe_mmio_read64_2x32(&gt_to_tile(gt)->mmio, GSMBASE) -
-- 
2.46.0


