Return-Path: <stable+bounces-140964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DDBAAACEB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D762F189448C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D28F3CEB77;
	Mon,  5 May 2025 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir5AZy11"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F313A80E8;
	Mon,  5 May 2025 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487038; cv=none; b=tngk7iDeb0N+i83epw/RX287s9wg7LfeAs5LpZSMnk+osad0w1RQRh5w77te6iwV5Ic3XPYiXSgfPlq8Hx7gBNeAA78+ZPY7Gxne7BoEzq3KwlREigsrju0TsIYZEgjo0GJi0MGVAgcif9u6uhR5ybXWMRX5v+lptPAljzU5z/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487038; c=relaxed/simple;
	bh=uBdoissBPpGSULb9insgyqATPgy7GITB84igV0I3bo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QyjDuxrZF1I/RkpfY2YdS8Pa2zN1nXWA+0prAP0UXhC4Tfz2UGTm39c8Ini7a0fN9VI+NcuqPnj/oe8SM80vVaKMoJ62f9r5/C4Y6FwXnAhLSc4RcWDSz5cUY6/Jl2gvlCuxDlPmpLX9jiXygxvyJE6dOgZq+UxtUij9lx2K5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir5AZy11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF07C4CEE4;
	Mon,  5 May 2025 23:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487036;
	bh=uBdoissBPpGSULb9insgyqATPgy7GITB84igV0I3bo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ir5AZy11nZcAizCdGy+1r7A5a+fL0Ej4mdDkSyIMI2UHyfWjWgmdvkiQ6FJ5vjwEJ
	 EFKytDhtJYTQTXQGc4CCxyR7W0mdkxN9J73hr3n/mIbE/ilI0QwN9psUFAiFWh0WZP
	 8RQSgV+W4s/dqxL3lCtUdPfgoo/Ip07pt1C1HdsmwdVsbNh6sYSmnWIfgB9yruSDfK
	 ZWbClV5DpO5CsKI36XKQdhwCeLU92VsARDc1StTV2FLwgi3YOZfkumZAlNWD/m6p2Q
	 VTgDmWdbPB6vvYArGhRHF7EoKe8HNIPqN3WNfHbIXCdIoVC4+joh2YEDtirTU1XYlu
	 4YpBr0+FlYt2Q==
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
	YiPeng.Chai@amd.com,
	le.ma@amd.com,
	Feifei.Xu@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 121/153] drm/amdgpu: reset psp->cmd to NULL after releasing the buffer
Date: Mon,  5 May 2025 19:12:48 -0400
Message-Id: <20250505231320.2695319-121-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index a8b7f0aeacf83..64bf24b64446b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -353,7 +353,6 @@ static int psp_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct psp_context *psp = &adev->psp;
-	struct psp_gfx_cmd_resp *cmd = psp->cmd;
 
 	psp_memory_training_fini(psp);
 	if (psp->sos_fw) {
@@ -373,8 +372,8 @@ static int psp_sw_fini(void *handle)
 	    adev->asic_type == CHIP_SIENNA_CICHLID)
 		psp_sysfs_fini(adev);
 
-	kfree(cmd);
-	cmd = NULL;
+	kfree(psp->cmd);
+	psp->cmd = NULL;
 
 	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
 			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
-- 
2.39.5


