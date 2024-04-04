Return-Path: <stable+bounces-35902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A718983B0
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 11:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302CD1C21F60
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 09:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334F571736;
	Thu,  4 Apr 2024 09:02:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2E43399A
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221378; cv=none; b=HfE3HvKFNJvvuM1mmK5to5vv3171g9twuSWRVQzOWSDxQEnPGWtK5iwIGWw9VZIFw9vi3l8UZX9UXF105u9iTFyxU6amAMAAZbPYyuY9ULAZNenHgkHbu57KkheR8lki91dymJ2yTwrxKBczBlwP/pxTAQgpNqSD6dzWbcKlVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221378; c=relaxed/simple;
	bh=gq7BxwFdQzkXpUhqAxpDswtrLbjHtAYGcb6TkSdSzDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zm0D0KSn0MHBIFnOn7dfC9SeJYysU6k4JO/3JwzeECNIVAjv6CoJb4Ek5F7nJ+F5hgS8hz6N3suiS/iiyL08tJ4kKJ613BUO+01VD1jxVvpeWha5ECPaX4dhZcPbs+L8K+iOaaM4V2PScpAlJH4dHC2EXAAYrlc7Ao9HyAJ8Ar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Fix bo leak in intel_fb_bo_framebuffer_init
Date: Thu,  4 Apr 2024 11:03:02 +0200
Message-ID: <20240404090302.68422-1-maarten.lankhorst@linux.intel.com>
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
index dba327f53ac5..e18521acc516 100644
--- a/drivers/gpu/drm/xe/display/intel_fb_bo.c
+++ b/drivers/gpu/drm/xe/display/intel_fb_bo.c
@@ -31,7 +31,7 @@ int intel_fb_bo_framebuffer_init(struct intel_framebuffer *intel_fb,
 
 	ret = ttm_bo_reserve(&bo->ttm, true, false, NULL);
 	if (ret)
-		return ret;
+		goto err;
 
 	if (!(bo->flags & XE_BO_FLAG_SCANOUT)) {
 		/*
@@ -42,12 +42,16 @@ int intel_fb_bo_framebuffer_init(struct intel_framebuffer *intel_fb,
 		 */
 		if (XE_IOCTL_DBG(i915, !list_empty(&bo->ttm.base.gpuva.list))) {
 			ttm_bo_unreserve(&bo->ttm);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err;
 		}
 		bo->flags |= XE_BO_FLAG_SCANOUT;
 	}
 	ttm_bo_unreserve(&bo->ttm);
+	return 0;
 
+err:
+	xe_bo_put(bo);
 	return ret;
 }
 
-- 
2.43.0


