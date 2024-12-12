Return-Path: <stable+bounces-101635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A429EEDB5
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9235C188EEBB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013CF226540;
	Thu, 12 Dec 2024 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WooTEUeW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FD2226537;
	Thu, 12 Dec 2024 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018249; cv=none; b=Pto5uZkmsRiA2zS3G9KbEQW4ybh4JMXihh51h1ir/jXXz9eDUu74MxzDKzlADZl1uKGHEs6VW92qIfujIZwBDDxaEEi6//GVwwlXmb8sqtfTTT6XDnCYCAd6VH6Nu6YzArrmHlnjNCTGdI9IYG/zNiglrk/xi9j8NlDa/eq9U/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018249; c=relaxed/simple;
	bh=xjKlUxVD2Zb7UpedXt6rdSoYNclOKirumoyguxk20xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrEpBl14D/1GmFItr4cGhzAyeESVFbOaYtXfOVwL7Ft483QgeVnZUFJj7tbEavVXev6hHk2+Fbi1LujB97OEIYiNu912KHl3kkx5Ny3qzu9s3Hbq5dHxe8XB+lwlzQ50b1GA47wqgJeBNwR55hY2cihei1v1CD2zZTuEp8Hky24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WooTEUeW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ED2C4CED7;
	Thu, 12 Dec 2024 15:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734018249;
	bh=xjKlUxVD2Zb7UpedXt6rdSoYNclOKirumoyguxk20xM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WooTEUeWY2nXiv4+XGr9mYw0h3ohjEnYNk8oHq+UzHwoylFd1+pWKNzgWVByjqgYb
	 02cpAU4Xz4/rKIVpIqPx0N4J5AcDnCKRd8EVHkKZXCFwLhUQguP02biDBkGOo+jhUE
	 Kn/plulHuq6EDPTxklikfjcHCvMFm4VhwEe1XAB4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lang Yu <lang.yu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 241/356] drm/amdgpu: refine error handling in amdgpu_ttm_tt_pin_userptr
Date: Thu, 12 Dec 2024 15:59:20 +0100
Message-ID: <20241212144254.135817597@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lang Yu <lang.yu@amd.com>

[ Upstream commit 46186667f98fb7158c98f4ff5da62c427761ffcd ]

Free sg table when dma_map_sgtable() failed to avoid memory leak.

Signed-off-by: Lang Yu <lang.yu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8c3fb1562ffef..6f06183e82b2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -794,7 +794,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 	/* Map SG to device */
 	r = dma_map_sgtable(adev->dev, ttm->sg, direction, 0);
 	if (r)
-		goto release_sg;
+		goto release_sg_table;
 
 	/* convert SG to linear array of pages and dma addresses */
 	drm_prime_sg_to_dma_addr_array(ttm->sg, gtt->ttm.dma_address,
@@ -802,6 +802,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 
 	return 0;
 
+release_sg_table:
+	sg_free_table(ttm->sg);
 release_sg:
 	kfree(ttm->sg);
 	ttm->sg = NULL;
-- 
2.43.0




