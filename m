Return-Path: <stable+bounces-116710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE8FA39AB1
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D9F18936A0
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6021A22FF38;
	Tue, 18 Feb 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QPnszBdv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC71A841C
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877919; cv=none; b=U0h3cKpLbeGc2HzJRBLGYJm4Xd0l+OspZaWtn4C+wvPkRyWHOGPQfn4tu+EPIojqcGzUZK/zkE/5fk6ZzbLrdNkt33YF+sns4lWYhood+DTMatUZlAA26WjccBwWrKTJXjmeBoIT3KCuA5lX5zv99qhdHL9SSOzBEmJS8+AuNAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877919; c=relaxed/simple;
	bh=DJQ5xNvVKsIojkKFji6RGRisJlxs1QBLM6tnkF19Flw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=R4U9VSONSJDoyqFeDELDYJQTFQed0mDEQ0zZs3RiXC0uh5UaOd+BbLbrW0jr7s/sg3HANJJrujRc/OF7hPVz9AjdjtZAZg/6cYHFR5LLtmKhsAjUrSV5iDRSpz4rqKxwNBdWBBLqmXkiigTbJoD/FDhCQgP2xxLHA9g2yMw+wEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QPnszBdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BB7C4CEE2;
	Tue, 18 Feb 2025 11:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739877918;
	bh=DJQ5xNvVKsIojkKFji6RGRisJlxs1QBLM6tnkF19Flw=;
	h=Subject:To:Cc:From:Date:From;
	b=QPnszBdveA+2HdAPrHpyBwt3ghi5NKUX1P+nZvwmJNe8IpUAPeQK8ekbl50W6KjUf
	 yz4eh924W8nIYmAicd7rXmuIjCQXfRxy9jsT4laAmToZweLEAbPikD5p1FRca2EefO
	 rL/YppToADRsYVi6vDwqJNan+bkfXfG8c7TTUhXs=
Subject: FAILED: patch "[PATCH] drm/xe: Carve out wopcm portion from the stolen memory" failed to apply to 6.12-stable tree
To: nirmoy.das@intel.com,lucas.demarchi@intel.com,maarten.lankhorst@linux.intel.com,matthew.auld@intel.com,rodrigo.vivi@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 12:25:15 +0100
Message-ID: <2025021815-sublease-unneeded-0077@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e977499820782ab1c69f354d9f41b6d9ad1f43d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021815-sublease-unneeded-0077@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e977499820782ab1c69f354d9f41b6d9ad1f43d9 Mon Sep 17 00:00:00 2001
From: Nirmoy Das <nirmoy.das@intel.com>
Date: Mon, 10 Feb 2025 15:36:54 +0100
Subject: [PATCH] drm/xe: Carve out wopcm portion from the stolen memory

The top of stolen memory is WOPCM, which shouldn't be accessed. Remove
this portion from the stolen memory region for discrete platforms.
This was already done for integrated, but was missing for discrete
platforms.

This also moves get_wopcm_size() so detect_bar2_dgfx() and
detect_bar2_integrated can use the same function.

v2: Improve commit message and suitable stable version tag(Lucas)

Fixes: d8b52a02cb40 ("drm/xe: Implement stolen memory.")
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: stable@vger.kernel.org # v6.11+
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250210143654.2076747-1-nirmoy.das@intel.com
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
(cherry picked from commit 2c7f45cc7e197a792ce5c693e56ea48f60b312da)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c b/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
index 423856cc18d4..d414421f8c13 100644
--- a/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
@@ -57,38 +57,6 @@ bool xe_ttm_stolen_cpu_access_needs_ggtt(struct xe_device *xe)
 	return GRAPHICS_VERx100(xe) < 1270 && !IS_DGFX(xe);
 }
 
-static s64 detect_bar2_dgfx(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
-{
-	struct xe_tile *tile = xe_device_get_root_tile(xe);
-	struct xe_mmio *mmio = xe_root_tile_mmio(xe);
-	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
-	u64 stolen_size;
-	u64 tile_offset;
-	u64 tile_size;
-
-	tile_offset = tile->mem.vram.io_start - xe->mem.vram.io_start;
-	tile_size = tile->mem.vram.actual_physical_size;
-
-	/* Use DSM base address instead for stolen memory */
-	mgr->stolen_base = (xe_mmio_read64_2x32(mmio, DSMBASE) & BDSM_MASK) - tile_offset;
-	if (drm_WARN_ON(&xe->drm, tile_size < mgr->stolen_base))
-		return 0;
-
-	stolen_size = tile_size - mgr->stolen_base;
-
-	/* Verify usage fits in the actual resource available */
-	if (mgr->stolen_base + stolen_size <= pci_resource_len(pdev, LMEM_BAR))
-		mgr->io_base = tile->mem.vram.io_start + mgr->stolen_base;
-
-	/*
-	 * There may be few KB of platform dependent reserved memory at the end
-	 * of vram which is not part of the DSM. Such reserved memory portion is
-	 * always less then DSM granularity so align down the stolen_size to DSM
-	 * granularity to accommodate such reserve vram portion.
-	 */
-	return ALIGN_DOWN(stolen_size, SZ_1M);
-}
-
 static u32 get_wopcm_size(struct xe_device *xe)
 {
 	u32 wopcm_size;
@@ -112,6 +80,44 @@ static u32 get_wopcm_size(struct xe_device *xe)
 	return wopcm_size;
 }
 
+static s64 detect_bar2_dgfx(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
+{
+	struct xe_tile *tile = xe_device_get_root_tile(xe);
+	struct xe_mmio *mmio = xe_root_tile_mmio(xe);
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	u64 stolen_size, wopcm_size;
+	u64 tile_offset;
+	u64 tile_size;
+
+	tile_offset = tile->mem.vram.io_start - xe->mem.vram.io_start;
+	tile_size = tile->mem.vram.actual_physical_size;
+
+	/* Use DSM base address instead for stolen memory */
+	mgr->stolen_base = (xe_mmio_read64_2x32(mmio, DSMBASE) & BDSM_MASK) - tile_offset;
+	if (drm_WARN_ON(&xe->drm, tile_size < mgr->stolen_base))
+		return 0;
+
+	/* Carve out the top of DSM as it contains the reserved WOPCM region */
+	wopcm_size = get_wopcm_size(xe);
+	if (drm_WARN_ON(&xe->drm, !wopcm_size))
+		return 0;
+
+	stolen_size = tile_size - mgr->stolen_base;
+	stolen_size -= wopcm_size;
+
+	/* Verify usage fits in the actual resource available */
+	if (mgr->stolen_base + stolen_size <= pci_resource_len(pdev, LMEM_BAR))
+		mgr->io_base = tile->mem.vram.io_start + mgr->stolen_base;
+
+	/*
+	 * There may be few KB of platform dependent reserved memory at the end
+	 * of vram which is not part of the DSM. Such reserved memory portion is
+	 * always less then DSM granularity so align down the stolen_size to DSM
+	 * granularity to accommodate such reserve vram portion.
+	 */
+	return ALIGN_DOWN(stolen_size, SZ_1M);
+}
+
 static u32 detect_bar2_integrated(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
 {
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);


