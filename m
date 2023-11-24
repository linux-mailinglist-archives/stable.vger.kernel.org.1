Return-Path: <stable+bounces-268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520FE7F7616
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836CB1C20C99
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C31728E25;
	Fri, 24 Nov 2023 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vs9fdkJZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E421A2C1BE
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71871C433D9;
	Fri, 24 Nov 2023 14:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700835285;
	bh=KuKcrWE9Pao+lNDDMP0OBdHqOfddCaqObhAXRCB0iwY=;
	h=Subject:To:Cc:From:Date:From;
	b=vs9fdkJZyHj9iwbWq2M5BNhQebD/iSmMGY3MoZx5Hq/7v6BxydN+8sS415pxl9d4i
	 fhOVXMx9cDZwGaw1lKu0lS1nT9Az/2TdAsU6QzyulUwKyQlkMqaDisnnWT9X12+xvy
	 OFp2QQfBFeYpefQChHgdL3h/zGg18y+ck5qifDaM=
Subject: FAILED: patch "[PATCH] drm/amdgpu: add missing NULL check" failed to apply to 6.5-stable tree
To: christian.koenig@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 14:14:33 +0000
Message-ID: <2023112433-radar-sizably-d777@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 31220ee9dc5a3e25d38d29d3816b6e79d8c39abc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112433-radar-sizably-d777@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

31220ee9dc5a ("drm/amdgpu: add missing NULL check")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 31220ee9dc5a3e25d38d29d3816b6e79d8c39abc Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Fri, 6 Oct 2023 14:04:04 +0200
Subject: [PATCH] drm/amdgpu: add missing NULL check
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bo->tbo.resource can easily be NULL here.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2902
Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
CC: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index f3ee83cdf97e..d28e21baef16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -252,7 +252,7 @@ static inline bool amdgpu_bo_in_cpu_visible_vram(struct amdgpu_bo *bo)
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct amdgpu_res_cursor cursor;
 
-	if (bo->tbo.resource->mem_type != TTM_PL_VRAM)
+	if (!bo->tbo.resource || bo->tbo.resource->mem_type != TTM_PL_VRAM)
 		return false;
 
 	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &cursor);


