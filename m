Return-Path: <stable+bounces-43262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77D48BF0FD
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B50281D7B
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CF513A899;
	Tue,  7 May 2024 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejiwwGE3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58D613A897;
	Tue,  7 May 2024 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122863; cv=none; b=ozgR9tiyhrEuz7Qwpgqv03JjZs1Y0FCKgKe3eWfjv3wZSXvA7rn+ZqxVYpba2bfqnE3o7FSexNeq/50rDNvscW2glfHRBLWN/JfUUiuKG1ivXlxO1JnQRVUGEHLwe3Jy3VebFy7Ya09YP2xDLrBFBsswg4DsuuqDunRQJ0aH3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122863; c=relaxed/simple;
	bh=B/GZDjaew3eFAUQrGbv/TKwXyHTUiAo67mAVzMwgEYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bukq6eH8cyytdnlwSS822CKMlbkUvfEtZuuYmFWCNpWjDHP6lgthoL8WawI/yy8lSCINS0STkggDgpS6e9msd2hDiGAN03IaisEXXJPaHDq4pGIugRjjjqrZAL/CvBubYB+Z/4zmLUI9eH5O/MFR7w2zR+mk5WTbA3mlaXFLLJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejiwwGE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C84DC2BBFC;
	Tue,  7 May 2024 23:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122863;
	bh=B/GZDjaew3eFAUQrGbv/TKwXyHTUiAo67mAVzMwgEYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejiwwGE3xKDa3hdyx5l6U8JRxim6N8EQIy2MsH/Punfh5mvv+Z73y0kfwCZDFeqJB
	 qhzWvr9Cl/IIBq+WvDFKrF8Sg74C3Yr8pFl3/Li7YHVYjaaFlivGDuFjsdgM+rGUrk
	 Bqd/BDvu38Q0o6DorKIQLITMByvaskRQm3iY/5JfJDmAHCWtOsmHH0zn15iCzRTAvK
	 lZn8uMI6lEWXZ8b4H2a6Hx12URij7DP9l3xYpp5EkqrKDjvEWyarJRbvGOa+pJAVqx
	 yLscHiVlGwk2HxN4dGmMwyEGBILKxOvlbw6jy/D6kLOvLd2VElV1hF/ufZPTjBnT5P
	 V80sE5b0TlEaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Xiao <Jack.Xiao@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Felix.Kuehling@amd.com,
	shaoyun.liu@amd.com,
	jonathan.kim@amd.com,
	guchun.chen@amd.com,
	shashank.sharma@amd.com,
	Tim.Huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 09/12] drm/amdgpu/mes: fix use-after-free issue
Date: Tue,  7 May 2024 19:00:11 -0400
Message-ID: <20240507230031.391436-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230031.391436-1-sashal@kernel.org>
References: <20240507230031.391436-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit

From: Jack Xiao <Jack.Xiao@amd.com>

[ Upstream commit 948255282074d9367e01908b3f5dcf8c10fc9c3d ]

Delete fence fallback timer to fix the ramdom
use-after-free issue.

v2: move to amdgpu_mes.c

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index bebd136ed5444..9a4cbfbd5d9e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1083,6 +1083,7 @@ void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
 		return;
 
 	amdgpu_mes_remove_hw_queue(adev, ring->hw_queue_id);
+	del_timer_sync(&ring->fence_drv.fallback_timer);
 	amdgpu_ring_fini(ring);
 	kfree(ring);
 }
-- 
2.43.0


