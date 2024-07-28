Return-Path: <stable+bounces-62180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC6193E6A9
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F95B20BFE
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDE775817;
	Sun, 28 Jul 2024 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naushqms"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0AB1E487;
	Sun, 28 Jul 2024 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181573; cv=none; b=BI1j8Bg3PIsRGvqE0RZKkuw/kl6qZvAOzO55t4wAzZeQ4IoUHbAB3jY+VRU0sadaBC/vbQV5kuQcv6WlAvS8wM4oXO5M0aeaY/8waVYpwrwqJ6xoPZPYz8STmdD7Hl3Jduo+4qs9ztgD5l7wAW3VI9s5u2XaD0pX7pICOPBo78M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181573; c=relaxed/simple;
	bh=C+xvaKhz48FqvqprkaQycS+Bx+tlJK4t2v/ibyQ+V1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWN5WqqlFYfa4n58fkMV4fu12augLiOX0sBhNv0WeYeSVaowVRMn2cCwgv8AEoRm0uYwhZjC1eZftfJ1KMD+esmwErssCGXRBmKNSiS3/0ZZ42zey6qaPrr0j/JhAMk2yCZ3sD6KQjs/TQjn8pFEEYG0aQFvU31k9sugTJRfJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naushqms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1DDC4AF0F;
	Sun, 28 Jul 2024 15:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181573;
	bh=C+xvaKhz48FqvqprkaQycS+Bx+tlJK4t2v/ibyQ+V1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=naushqmsQQNZxnApQ3NhFDh8GTlj2sCBwU6+idukb/mAu9KiHu+Qg60ydV9je4Cb5
	 Gy8CxMtUMAuM4c0MuRX+STAh0mI6jwVOqbySLIioelptrZ6VRrGiEzaf29WqwZ5IDu
	 2DhDiecA/thquED0I3U0osAsxefRFnXQODTsXQs3Aa5ZzKSo1hIZoBbsAn0kSD91Si
	 znLKdmBlyw6BajIxjFJh2seEbEyhILffDn70RYth5JyQNzruiSnWN4JcG1SlYMfAdv
	 d2ZK9ziIdeljMYQ1ukkFZaWfBBQmHy0oZEzfDg18wbFfZ1MmYlKPEqPv0tNxh4P6re
	 hvt+dN0O56MdA==
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
	rajneesh.bhardwaj@amd.com,
	Felix.Kuehling@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 02/20] drm/amdgpu: fix potential resource leak warning
Date: Sun, 28 Jul 2024 11:45:00 -0400
Message-ID: <20240728154605.2048490-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154605.2048490-1-sashal@kernel.org>
References: <20240728154605.2048490-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 349416e176a12..1cf1498204678 100644
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


