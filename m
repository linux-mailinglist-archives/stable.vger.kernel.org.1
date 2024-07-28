Return-Path: <stable+bounces-62148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB11793E60C
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610D51F21621
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853836FE16;
	Sun, 28 Jul 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRsq/lsX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F61756B81;
	Sun, 28 Jul 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181373; cv=none; b=GDZ3ef2nTRAoWohJwSQ38X6Ie/GVIPVD1LHNygbuUM8/EPfKnmMu3xNCquBdTymF2snar6e0j0iF+bQg+zb45wmVxWEuenx42cYRfnFIDaukZWL/gvhaI9NoEq4EennLTYCLIPmm481nRh50IahjPjNTP/RHfWSVlm2PMcGGNJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181373; c=relaxed/simple;
	bh=evwQZkRUF/zumdh/YjluMsV7L3aSvbNQgjm+zZAIJKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SVMS/H6N8jgylMEGQm2TdDx1f5Ws7VZOM1t8buwpB+bh1geNYCuU21n0zHVcpc7VkSkh0lWIcusXwf7+gmQ3ej2RSaK96mIaxiOSVGo4MBBdztZJWQTOtqS7gwqqU5lA3QtWfDbfNQAz9l1pSPqaFqv9hUyJH6elvdZzJselVBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRsq/lsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF68C4AF0A;
	Sun, 28 Jul 2024 15:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181372;
	bh=evwQZkRUF/zumdh/YjluMsV7L3aSvbNQgjm+zZAIJKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QRsq/lsXjn+QjtYWSkB+KSo86gP8dNi37pNq5NlHsQ7zT5G1jERJT2SfmCdF4UDgI
	 9caCRWWl0XPuqBFj71NM5LsIW7nIs8KhUvkGgVBDNEuwGdeRrkHm8bOsz3t2RnBvCj
	 PMChTOsXXmoDhNAsCot2DOWeMVw68vXJH1wKQw75tlmOSkElBKUiNkVo0wqi9bj3wQ
	 bqhkXg258oKyICWWLFri9bLdTV+OWYUCx+tqAQLvV8C84ROib3C9lybj/PszZtqzLv
	 0wVBDLTg6oVsFnqjUBnQivnmP4zHJY9pywzrxnTbvU1J9lw7EL+xO7k/ohfUOSJbLn
	 7uVEpCAwhnDdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <Tim.Huang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	shashank.sharma@amd.com,
	Felix.Kuehling@amd.com,
	rajneesh.bhardwaj@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 04/34] drm/amdgpu: fix potential resource leak warning
Date: Sun, 28 Jul 2024 11:40:28 -0400
Message-ID: <20240728154230.2046786-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Tim Huang <Tim.Huang@amd.com>

[ Upstream commit 22a5daaec0660dd19740c4c6608b78f38760d1e6 ]

Clear resource leak warning that when the prepare fails,
the allocated amdgpu job object will never be released.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 66e8a016126b8..9b748d7058b5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -102,6 +102,11 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
 	if (!r)
 		r = amdgpu_sync_push_to_job(&sync, p->job);
 	amdgpu_sync_free(&sync);
+
+	if (r) {
+		p->num_dw_left = 0;
+		amdgpu_job_free(p->job);
+	}
 	return r;
 }
 
-- 
2.43.0


