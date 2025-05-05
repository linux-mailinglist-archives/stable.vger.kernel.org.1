Return-Path: <stable+bounces-140212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989A4AAA651
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD31982300
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F0732118F;
	Mon,  5 May 2025 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxotl+Cx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6387321191;
	Mon,  5 May 2025 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484360; cv=none; b=M3ZHOO5LW0dtDUCWjq6/q2aetC0PjesNV9SEET/+dk2BwNUAfGBX1CJ0b/PRQ2Z0fEahhRULEuRe1S9/Iso8I8teYYGWe1HoAOFdBZAkmqceatumRMCrPK+oQSODiP/5B4mkMyOlG5s6ylysx3ccHKL8INGhMdQmCC+WTJXFAHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484360; c=relaxed/simple;
	bh=eJzNfnN3jGhOzCWCY+HCLm6FOF8VBEZD9BO5A5izIkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=errHfICIPZZR+cI8tCnmO7JZdqoBEaqwX0u+TXeAWMgE3muaVPkcsrDHkYKDBhlhiNOzguFSx8JK5Gb6+f2DtwhqlHfaJ85zArzUORju0SCyY7x+8yCCMKn8Hu3KowvFazk9NxA8fOhkKT8Blfpe6TBV6+frvP3uDbfcSenGBqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxotl+Cx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41C3C4CEE4;
	Mon,  5 May 2025 22:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484360;
	bh=eJzNfnN3jGhOzCWCY+HCLm6FOF8VBEZD9BO5A5izIkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxotl+Cxo2bOYfgbCfEVcuoe5w3AdY5+h2KGiFK5ASVicVuq6DF7ynN+TgDJv9IY7
	 8xqMICXsSqsjo4gS11SoAvDn3TEjsd5QA4jnvnZnN7GNFCK0n/LkFsm3XkyZ4S0M1E
	 kooVRCWkR1ed2IEr29dOyaJmmZGXw9qXpdPNWwXqBaeu3GJiaceCOZ3bLMrkMJkWDa
	 XMBv02H5umy0ANiEa1uJX0ICF3TGtPgPvnr6Uw9G7IESzx9ygFBcCUNJ8PQ82w1yXI
	 ZpMKn0HhXIggcUbzmQdB4lDnj/ydKn1PZ6TqPRPH6RvR4DWrCBiddn2vF4IsaGkQ3q
	 bizqBSECmHufA==
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
	candice.li@amd.com,
	le.ma@amd.com,
	YiPeng.Chai@amd.com,
	Feifei.Xu@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 464/642] drm/amdgpu: reset psp->cmd to NULL after releasing the buffer
Date: Mon,  5 May 2025 18:11:20 -0400
Message-Id: <20250505221419.2672473-464-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index e5fc80ed06eae..665cc277cdc05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -533,7 +533,6 @@ static int psp_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct psp_context *psp = &adev->psp;
-	struct psp_gfx_cmd_resp *cmd = psp->cmd;
 
 	psp_memory_training_fini(psp);
 
@@ -543,8 +542,8 @@ static int psp_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_ucode_release(&psp->cap_fw);
 	amdgpu_ucode_release(&psp->toc_fw);
 
-	kfree(cmd);
-	cmd = NULL;
+	kfree(psp->cmd);
+	psp->cmd = NULL;
 
 	psp_free_shared_bufs(psp);
 
-- 
2.39.5


