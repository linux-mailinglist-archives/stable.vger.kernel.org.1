Return-Path: <stable+bounces-994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9B87F7D7B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 752BBB2160C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9195D3A8C5;
	Fri, 24 Nov 2023 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jcETRDoZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4033E39FE8;
	Fri, 24 Nov 2023 18:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD04C433C7;
	Fri, 24 Nov 2023 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850294;
	bh=IlOQR+QMS67l8tkFOgc1xLnfS6JZOE8izHmYeqSjyLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jcETRDoZFOVWBP4DhOMdQ0rAMI0WPo/9105nI7l2vU7SdsQE/WU1X9r2zTfOnByWX
	 +M4z22TnXNzXh46HOfrFq0UgV5i+hQial6lZw97S5Fj11ho/7awHOQOHcCjnYgB1Zb
	 Dl54VpqhOzhljUBW55yn80FxF876w4Rwd7wJxIRw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 523/530] drm/amdgpu: lower CS errors to debug severity
Date: Fri, 24 Nov 2023 17:51:29 +0000
Message-ID: <20231124172044.104120081@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <christian.koenig@amd.com>

commit 17daf01ab4e3e5a5929747aa05cc15eb2bad5438 upstream.

Otherwise userspace can spam the logs by using incorrect input values.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1411,7 +1411,7 @@ int amdgpu_cs_ioctl(struct drm_device *d
 		if (r == -ENOMEM)
 			DRM_ERROR("Not enough memory for command submission!\n");
 		else if (r != -ERESTARTSYS && r != -EAGAIN)
-			DRM_ERROR("Failed to process the buffer list %d!\n", r);
+			DRM_DEBUG("Failed to process the buffer list %d!\n", r);
 		goto error_fini;
 	}
 



