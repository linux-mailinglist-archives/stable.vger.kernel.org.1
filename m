Return-Path: <stable+bounces-28564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82201885B64
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 16:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D86A286BF6
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 15:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27A48595C;
	Thu, 21 Mar 2024 15:05:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5855792
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033544; cv=none; b=pGMYKcbev8uGD7wIbp+4mSWUhxGEwyDo5PyRA6SSUYRx7bKBjAoXoUy0LNqpllTDEIvPtfdIxyc4vVKV46VRBWwDEfnxgZitSFzXOAUK9I9dIuAuLm7ZYdIfv7DTKTbI9RwC1IDOlWEhqAYLWb2r/lBPw109LS5MBEyR0gDeOEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033544; c=relaxed/simple;
	bh=7inELJrm4VCPpcVTFR2xuYko2N7s99u0vvmAxGvv9s4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SvdjS4EbqJK1AoeAiAPwe19U6Qo6bltMzxaCUflC6XxxBXO5TWO+ix/gX37kIGlreOIuSgwhp4LDlWIv6eWXPTu4b//4y56DTOhqyIZOkma5Up8xzBHxVaJZQxR3iETq9V8KAxLl6mHSYjYTcGONNVKc+D00DafhXGTCFybaoi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Fix bo leak in intel_fb_bo_framebuffer_init
Date: Thu, 21 Mar 2024 15:56:44 +0100
Message-ID: <20240321145644.33091-1-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a reference to bo after all error paths, to prevent leaking a bo
ref.

Return 0 to clarify that this is the success path.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/display/intel_fb_bo.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/intel_fb_bo.c b/drivers/gpu/drm/xe/display/intel_fb_bo.c
index b21da7b745a5..7262bbca9baf 100644
--- a/drivers/gpu/drm/xe/display/intel_fb_bo.c
+++ b/drivers/gpu/drm/xe/display/intel_fb_bo.c
@@ -27,8 +27,6 @@ int intel_fb_bo_framebuffer_init(struct intel_framebuffer *intel_fb,
 	struct drm_i915_private *i915 = to_i915(bo->ttm.base.dev);
 	int ret;
 
-	xe_bo_get(bo);
-
 	ret = ttm_bo_reserve(&bo->ttm, true, false, NULL);
 	if (ret)
 		return ret;
@@ -48,7 +46,8 @@ int intel_fb_bo_framebuffer_init(struct intel_framebuffer *intel_fb,
 	}
 	ttm_bo_unreserve(&bo->ttm);
 
-	return ret;
+	xe_bo_get(bo);
+	return 0;
 }
 
 struct xe_bo *intel_fb_bo_lookup_valid_bo(struct drm_i915_private *i915,
-- 
2.43.0


