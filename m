Return-Path: <stable+bounces-141227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4FEAAB19A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04054E1419
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DBB36452F;
	Tue,  6 May 2025 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glCzmUjK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032582D26B2;
	Mon,  5 May 2025 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485546; cv=none; b=DjkRRSCFi+xQNP6vKllw9l4c0bJBtl/C2xkvUo/v6ACHw1Y2rC4TBxX8xWrDZFHBOco/oguVXU9CU3syGbo5Kn21koyZKZGUwzZVxzm+yQHSKP429rS5QWoduCRVlGwMwyQhHvmrSxdCh3ecb5gw6dwYr+Yu+K40oXNtuG9UI04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485546; c=relaxed/simple;
	bh=rGczOpTAIDyhclrEPlCeWm4VUlOtOanjNMGktYdkV7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sT3BmJxs71nNl2gn/mn38XEuNghOBQ1tf1b1EB3E+0rCViPuSaUnu//6avUaZcPP+QXnoShpEvF1tATNV2f3XkCdrPXNKy0svxig7BjkAQSPQB3A5dNqbx7fzoDyr5xtSoHUw9OIXPA5kz2WNDCNgB9kfOOmO2sBxplvq1PixjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glCzmUjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED6EC4CEE4;
	Mon,  5 May 2025 22:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485545;
	bh=rGczOpTAIDyhclrEPlCeWm4VUlOtOanjNMGktYdkV7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=glCzmUjKXsa8+9V5zBwUBXJrkNc3KJmRNoXgRoiAoe8RY+3ZrwltceLA3M2A+rbDX
	 saNCBEkJdOw7CP5ztdqvaOVvR6J6uSgyGPOXCUeYRZfiFwhqeavIfX3WaPkMy7bRrR
	 awXEjO1ywVrbKtMe2QXX5UqiWLcDaO2SZVMeHt/qrB/+EXiR6hFJFIXaBr7NkTbSpM
	 Le7p2WYNxU95EYA/t5l7al+oFMcxK6b6vKDm9BdEiflVK3iQIWFTPdIlGTNTzqXAO1
	 z/8G/o3APQxOGF660zSXXdaCG1/8liVuXsFaK8OwVd2TemmybSnxe5jEyL+VW6glIp
	 Dqsrjpd3MOuLw==
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
	le.ma@amd.com,
	YiPeng.Chai@amd.com,
	candice.li@amd.com,
	Feifei.Xu@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 365/486] drm/amdgpu: reset psp->cmd to NULL after releasing the buffer
Date: Mon,  5 May 2025 18:37:21 -0400
Message-Id: <20250505223922.2682012-365-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index d70855d7c61c1..31a376f2742a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -531,7 +531,6 @@ static int psp_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct psp_context *psp = &adev->psp;
-	struct psp_gfx_cmd_resp *cmd = psp->cmd;
 
 	psp_memory_training_fini(psp);
 
@@ -541,8 +540,8 @@ static int psp_sw_fini(void *handle)
 	amdgpu_ucode_release(&psp->cap_fw);
 	amdgpu_ucode_release(&psp->toc_fw);
 
-	kfree(cmd);
-	cmd = NULL;
+	kfree(psp->cmd);
+	psp->cmd = NULL;
 
 	psp_free_shared_bufs(psp);
 
-- 
2.39.5


