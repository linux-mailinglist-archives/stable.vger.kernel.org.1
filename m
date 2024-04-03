Return-Path: <stable+bounces-35715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13520897167
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 15:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DD01C26094
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F621487C4;
	Wed,  3 Apr 2024 13:42:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE5147C6C
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151762; cv=none; b=o4EBtIhBraTkorW26f02NsyPscXdehOmdvwYR+D4ZfPOTvIZG/7scou1sBFI7tC0a5Su1rCDx61LqpjHAwUKBA9rt7QwfwBEKeh7liDBfok7GKIp4hnmyjzIwS58VZe6yESs8RzUB1At59nKFo6na9qTL0DPRjExkgrX3uqSRSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151762; c=relaxed/simple;
	bh=7XJi41d9Re5gVVrPke7IhsbhwtFi74bxFKgZive4JeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/MRf/Kcw4BIGYqc9/TkVy+A5r4KYSk5m8X4RHAMeItXHp65BgcItksYOo8cOBuYLcxEYV5yOf/E58N0ZI/cAW51VyXKzX2uEZMlibIx+tLCyRW3gOY3cT7WjJpWLFpUi/r0q8tfnSvbtj52Ug/VerhMJGtRishF02GlXrE3BNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	stable@vger.kernel.org
Subject: [v2] drm/xe: Fix bo leak in intel_fb_bo_framebuffer_init
Date: Wed,  3 Apr 2024 15:34:18 +0200
Message-ID: <20240403133418.42870-1-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a unreference bo in the error path, to prevent leaking a bo ref.

Return 0 on success to clarify the success path.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/display/intel_fb_bo.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/intel_fb_bo.c b/drivers/gpu/drm/xe/display/intel_fb_bo.c
index b21da7b745a5..a9c1f9885c6b 100644
--- a/drivers/gpu/drm/xe/display/intel_fb_bo.c
+++ b/drivers/gpu/drm/xe/display/intel_fb_bo.c
@@ -31,7 +31,7 @@ int intel_fb_bo_framebuffer_init(struct intel_framebuffer *intel_fb,
 
 	ret = ttm_bo_reserve(&bo->ttm, true, false, NULL);
 	if (ret)
-		return ret;
+		goto err;
 
 	if (!(bo->flags & XE_BO_SCANOUT_BIT)) {
 		/*
@@ -42,12 +42,16 @@ int intel_fb_bo_framebuffer_init(struct intel_framebuffer *intel_fb,
 		 */
 		if (XE_IOCTL_DBG(i915, !list_empty(&bo->ttm.base.gpuva.list))) {
 			ttm_bo_unreserve(&bo->ttm);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err;
 		}
 		bo->flags |= XE_BO_SCANOUT_BIT;
 	}
 	ttm_bo_unreserve(&bo->ttm);
+	return 0;
 
+err:
+	xe_bo_put(bo);
 	return ret;
 }
 
-- 
2.43.0


