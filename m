Return-Path: <stable+bounces-40925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E31E8AF99F
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A291C2349D
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D93144D3E;
	Tue, 23 Apr 2024 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j9fyUVLH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F585274;
	Tue, 23 Apr 2024 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908558; cv=none; b=KVIjpeFRoLkL+sUrLUCTy2Ndf1MMoOTe67DyrdJViPPQxqUy21ZKqRX5UOGRNgIZrojeUTCD+wpdlYRhb7JsM00CmU5vL94rTCvnlmHQdBLgRFcdj2BBciS0fgeDr8AgvxSw/rzsMpu+FA0GwIpiV9lP6bPNyKElutWpP24GGbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908558; c=relaxed/simple;
	bh=LCR5GUpLQ9h0ahYvxvegx9HFKXp6SZ8EFVExXNVDdn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLz7/0wloqZXbxlMNrIhMndkqXnrmquTvyMyHqE9eSWvZXiImxBATNFpwuLQ6dYaijzpJm4aYqTGOh7O1XVJGb1glB7fALPfsNrC+EoT6+FsQXj4vc1bEpxAL4dxdXfsR4qOS2WCFG0rB8gmXgOKfua+o8X0IvOX4Dz4n/WlIKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j9fyUVLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2613EC32783;
	Tue, 23 Apr 2024 21:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908558;
	bh=LCR5GUpLQ9h0ahYvxvegx9HFKXp6SZ8EFVExXNVDdn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j9fyUVLH46Rm1NZxcoUFnoXxBPoy4aI3hSVgoHu/BWS0F7su/K9uTIR60gMl2o564
	 HK3kVfLQwlWs2Y0aLKZie+5Zi5cdICslU3KBY3FliacHMaBntA2Jrb7hYN7IC6N7dI
	 xcEjolWUICaiW/UhA6q5ySbl+Jf0iC5wacHh8CPE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.8 144/158] drm/xe: Fix bo leak in intel_fb_bo_framebuffer_init
Date: Tue, 23 Apr 2024 14:39:26 -0700
Message-ID: <20240423213900.539304256@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
References: <20240423213855.824778126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

commit 652ead9b746a63e4e79d7ad66d3edf0a8a5b0c2f upstream.

Add a unreference bo in the error path, to prevent leaking a bo ref.

Return 0 on success to clarify the success path.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240404090302.68422-1-maarten.lankhorst@linux.intel.com
(cherry picked from commit a2f3d731be3893e730417ae3190760fcaffdf549)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
2.44.0




