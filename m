Return-Path: <stable+bounces-140781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10541AAAF19
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCEE44A4778
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C649C3AC5B9;
	Mon,  5 May 2025 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6nm6vIl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE51394A07;
	Mon,  5 May 2025 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486248; cv=none; b=FZpWnGgz/aARPS+xSjYuQUuas6vjCbZQi2IXyEiqKwRTdgaPxUzkQJF0PFR+cjKpuiVu5iWskNrvLxIaP4Iuoa0l07JLWVB6u3nGh0Kcm02vd34kRY0t+Y191nEmeO1lje+1JNJj96GImdP9ck9pNzgbunrwCV0SMh/yDRNzW2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486248; c=relaxed/simple;
	bh=DeY8uxQA1x9ocfmMil2jLWQfLGARUOIkI3MCrBHp49g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZX02xPXzU2xscH9IYdlJwgKqmhgdLwKrH0CrxZrU5NudTI72qhr19+G3IqbwMdft/dDLutJYuXa7xIeCFKrYHOCbTU0/of0KEnQDkZZBEFtosfSHJENZD6qhmmU7GCyBWOs165NaPdYTfbeHNshqF3iw+m0tM5zBwfDF4RX1qF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6nm6vIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73BAC4CEED;
	Mon,  5 May 2025 23:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486246;
	bh=DeY8uxQA1x9ocfmMil2jLWQfLGARUOIkI3MCrBHp49g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S6nm6vIly6nigL3nm22+vo9D9lOshcOFolQ0YbXw3tqxF0AQmroFjZLJZ4hXo1lp4
	 u2ad7KOBlFZPUIGPRv5UPN9S+3E4yezhOCRVlAeoKZ/A5bMg+Dk1DoWjrBLR8HP/1z
	 brTGCNf3ELD4oglUWhVAuOIj6z8EsFx3g+AdqxlGCxJ6Yl9k+Beyh9QiHuXMw9aW6b
	 02bnF09NDGALib6QSBa5Y2xmNDWXdbNyDjFGpj7BXGm+BsEuc+BWwh5gRZp3dbywJ+
	 B9G8AnUWGSBTPZXN7nQ5x3qtsHyN18WC11YXuezMjc6b126Ue/1jiFslg2N2rBaF1c
	 BFgVFJLCqN4rg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiang Liu <gerry@linux.alibaba.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Hawking.Zhang@amd.com,
	sunil.khatri@amd.com,
	YiPeng.Chai@amd.com,
	candice.li@amd.com,
	le.ma@amd.com,
	Feifei.Xu@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 224/294] drm/amdgpu: reset psp->cmd to NULL after releasing the buffer
Date: Mon,  5 May 2025 18:55:24 -0400
Message-Id: <20250505225634.2688578-224-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Jiang Liu <gerry@linux.alibaba.com>

[ Upstream commit e92f3f94cad24154fd3baae30c6dfb918492278d ]

Reset psp->cmd to NULL after releasing the buffer in function psp_sw_fini().

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6a24e8ceb9449..a4ab02c85f65b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -506,7 +506,6 @@ static int psp_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct psp_context *psp = &adev->psp;
-	struct psp_gfx_cmd_resp *cmd = psp->cmd;
 
 	psp_memory_training_fini(psp);
 
@@ -516,8 +515,8 @@ static int psp_sw_fini(void *handle)
 	amdgpu_ucode_release(&psp->cap_fw);
 	amdgpu_ucode_release(&psp->toc_fw);
 
-	kfree(cmd);
-	cmd = NULL;
+	kfree(psp->cmd);
+	psp->cmd = NULL;
 
 	psp_free_shared_bufs(psp);
 
-- 
2.39.5


