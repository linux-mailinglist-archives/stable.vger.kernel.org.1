Return-Path: <stable+bounces-5262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5F080C2E1
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 09:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44CF1F20FEF
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9232C20B30;
	Mon, 11 Dec 2023 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FER41Ejm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B300EE5
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 00:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702282589; x=1733818589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ywo7wd+Xtw6xaZ7BQ+4PbxGvYxNCLgjkctluObVHMX8=;
  b=FER41EjmHF9tUQV8DKuW9TUXmGgajRVd4wM3dPQOc7hckI3gOoBqYE3o
   F+DiPNKm3kTlMmFBg+zGI/GtWzfEz7kTCQqhpu78q87ws8t4eSwzatXS7
   E/lR+cSXK9J4ZtsyMyZ68bRe50hC+tSPop6qeSeLj6KaME3/n7ex3ds/j
   1uS7z7FEdKouHNLc75gAtM4TjIJuI+i8NqPIRCXmU2g7yedB2fFGHglbL
   dYzpwRqlbDOELNd3WqwbeSTfZnipefBZ1viD5CDS2xcaap+15Elu0pbzg
   mXx3uKADP96cSlP0C4BP9fT0a74wjnt2FnNqHeZMyd0EtLk+SChzjP7aI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="461088723"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="461088723"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 00:16:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="766285626"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="766285626"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga007.jf.intel.com with SMTP; 11 Dec 2023 00:16:26 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 11 Dec 2023 10:16:25 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm: Don't unref the same fb many times by mistake due to deadlock handling
Date: Mon, 11 Dec 2023 10:16:24 +0200
Message-ID: <20231211081625.25704-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

If we get a deadlock after the fb lookup in drm_mode_page_flip_ioctl()
we proceed to unref the fb and then retry the whole thing from the top.
But we forget to reset the fb pointer back to NULL, and so if we then
get another error during the retry, before the fb lookup, we proceed
the unref the same fb again without having gotten another reference.
The end result is that the fb will (eventually) end up being freed
while it's still in use.

Reset fb to NULL once we've unreffed it to avoid doing it again
until we've done another fb lookup.

This turned out to be pretty easy to hit on a DG2 when doing async
flips (and CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y). The first symptom I
saw that drm_closefb() simply got stuck in a busy loop while walking
the framebuffer list. Fortunately I was able to convince it to oops
instead, and from there it was easier to track down the culprit.

Cc: stable@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_plane.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 9e8e4c60983d..672c655c7a8e 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -1503,6 +1503,7 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
 out:
 	if (fb)
 		drm_framebuffer_put(fb);
+	fb = NULL;
 	if (plane->old_fb)
 		drm_framebuffer_put(plane->old_fb);
 	plane->old_fb = NULL;
-- 
2.41.0


