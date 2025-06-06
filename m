Return-Path: <stable+bounces-151609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E67AAD00A9
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 12:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADBB73B12B1
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BC5286D69;
	Fri,  6 Jun 2025 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ir8x+hOl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F99173451
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749206766; cv=none; b=EnfXPK5X/NenvZClA7Qj8t59Nk/qhGZ9MltmchKdd5Cz2xpE1Y2fFAWW5wQuEKGF7fCgyRygiv6j+Dv7FwvYFtejDlLkWLRcO4uTK2rwXwdf2mFoVe/5nHC2QnNObbWva8UTgCOKziAXpV+fUWlJJ3DBzO3SVWR8jLWlzOJDzUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749206766; c=relaxed/simple;
	bh=wzGOkaUW3bbxY09FXNB96VVIHZueGpKPYNLTiW2Gfs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nfslUv0jswoXqmZ/Q40kx0the2rXtQBr0T0GprAs0hLnUwRSin4ZfkopX+qUo2rSG2eleyywobk28rgZ6iy4oMkzRofAx47nNslG/8t0ZZ6nSWgfKb7lUWyZzLDZ5MnThaI8kK/80PtJjCglgzXNJMFHIZYuUIZrUDux3MllQYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ir8x+hOl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749206764; x=1780742764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wzGOkaUW3bbxY09FXNB96VVIHZueGpKPYNLTiW2Gfs8=;
  b=Ir8x+hOloB98rq6E/pZQomwLQttEyMnl16RThDGzo0CojUXEXaPsHpYA
   OovdRzGMZqtMP746DQ+ldJxtgAmI1F1p+XCO0FPSPztu/felH8LF8eROh
   QYZCQEagBlk/KtrBYaLx/VQ8OZSPWwNBqdzbTTzMP9x2MxmqnWza2ViEU
   l+wsRFPRpRFcMViDsfzdUwrKwyt+oYYfIsQaUWKqOb2ItbXT84azIMOjU
   0EJjN/BVsnfYofZ4/EE51y7sORB5NA3e4OhyAMVlA2Fl9ql+NCrSnG1sn
   IuYblGkqKBvCZw3Z3eO5w2A6jgW5coX0e7sgWNrmy7a/xmRnWOqJbVaZS
   Q==;
X-CSE-ConnectionGUID: KF8+sGVtSOiamrS3OP7bqA==
X-CSE-MsgGUID: bJwNlTthSH+mb8gPuRXGWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="50582336"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="50582336"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 03:46:03 -0700
X-CSE-ConnectionGUID: qWvp0pdQQ6mOJZIV5sNEBQ==
X-CSE-MsgGUID: vb6o8Ne4RA+BxO3Zn08obg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="146384863"
Received: from johunt-mobl9.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.52])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 03:46:02 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/xe: Move DSB l2 flush to a more sensible place
Date: Fri,  6 Jun 2025 11:45:47 +0100
Message-ID: <20250606104546.1996818-3-matthew.auld@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

Flushing l2 is only needed after all data has been written.

Fixes: 01570b446939 ("drm/xe/bmg: implement Wa_16023588340")
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/drm/xe/display/xe_dsb_buffer.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_dsb_buffer.c b/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
index f95375451e2f..9f941fc2e36b 100644
--- a/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
+++ b/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
@@ -17,10 +17,7 @@ u32 intel_dsb_buffer_ggtt_offset(struct intel_dsb_buffer *dsb_buf)
 
 void intel_dsb_buffer_write(struct intel_dsb_buffer *dsb_buf, u32 idx, u32 val)
 {
-	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
-
 	iosys_map_wr(&dsb_buf->vma->bo->vmap, idx * 4, u32, val);
-	xe_device_l2_flush(xe);
 }
 
 u32 intel_dsb_buffer_read(struct intel_dsb_buffer *dsb_buf, u32 idx)
@@ -30,12 +27,9 @@ u32 intel_dsb_buffer_read(struct intel_dsb_buffer *dsb_buf, u32 idx)
 
 void intel_dsb_buffer_memset(struct intel_dsb_buffer *dsb_buf, u32 idx, u32 val, size_t size)
 {
-	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
-
 	WARN_ON(idx > (dsb_buf->buf_size - size) / sizeof(*dsb_buf->cmd_buf));
 
 	iosys_map_memset(&dsb_buf->vma->bo->vmap, idx * 4, val, size);
-	xe_device_l2_flush(xe);
 }
 
 bool intel_dsb_buffer_create(struct intel_crtc *crtc, struct intel_dsb_buffer *dsb_buf, size_t size)
@@ -74,9 +68,12 @@ void intel_dsb_buffer_cleanup(struct intel_dsb_buffer *dsb_buf)
 
 void intel_dsb_buffer_flush_map(struct intel_dsb_buffer *dsb_buf)
 {
+	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
+
 	/*
 	 * The memory barrier here is to ensure coherency of DSB vs MMIO,
 	 * both for weak ordering archs and discrete cards.
 	 */
-	xe_device_wmb(dsb_buf->vma->bo->tile->xe);
+	xe_device_wmb(xe);
+	xe_device_l2_flush(xe);
 }
-- 
2.49.0


