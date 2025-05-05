Return-Path: <stable+bounces-140228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51573AAA64C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202DF1A86C14
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBD8323E9A;
	Mon,  5 May 2025 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVp29ebp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA7C323E97;
	Mon,  5 May 2025 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484451; cv=none; b=KNsn3og5HKd4KU3OiKdtEGhB1/cOQtARvTroFqDO0ION0S+aXtCn5WvnNS22lxoAMxUWYLNNLoVFwTWd6UwB9jNe889ZBvTK0Igj0A+9mE1KnA+KYzOUkNocUQ6FXsUAI3IoJs4eNg8NczfFXUGq6qliBajccRpkkyX3TaWRQUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484451; c=relaxed/simple;
	bh=xbQ9eJGPBB3lRC4J/VGPKmPFiKUbGRPltUQOe3JUaMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FjG+wL4acBr75IQTD/aV2e1i08i+LGEUhllB3vfoc+yg5mmk4ZBOQ4OoyxiTATOh9ZWBXstJTO42gc5SLVouVFFgKS8BjUjCjiLmiWzeIXd7l3DrLMsHpzhoCdUIKC+heCWXoW7qBAAkzdiMeDvRF4qo0XVSyDdT1NEeXQpi+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVp29ebp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D06C4CEED;
	Mon,  5 May 2025 22:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484451;
	bh=xbQ9eJGPBB3lRC4J/VGPKmPFiKUbGRPltUQOe3JUaMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FVp29ebpFE4H1aRoO2OBZexhrn0+iGV2uU997AF+F2XJ7j7JOQVEV6wo8SGcHkReV
	 gDoVdREmeUzzqeFIfQjOcORdcyMzZDloWgJRzcQ1LX4rdgtM+v33Rrwkt4LhHFz1Rr
	 tx13JJLtwH/OLKl/SiqJj8th2u0s3POMXYmMqFRmOi8VBrQQydobxIHUW1koskQF6R
	 ko1sMP3zts7218uPgjdTN6e1KcLvro1EWWnomRi0N3KN1Z+RBt0BxXWlgHvNhrKA8y
	 Zcx9TbKelR+7awp+63Qy+86x0g3uaGh5vGXGs35Agm464X9dg4NbSWo4w393BYLHSo
	 JAbHxtB+f2NiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	tao.zhou1@amd.com,
	YiPeng.Chai@amd.com,
	zhigang.luo@amd.com,
	victor.skvortsov@amd.com,
	sunil.khatri@amd.com,
	boyuan.zhang@amd.com,
	alex.sierra@amd.com,
	le.ma@amd.com,
	shane.xiao@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 480/642] drm/amdgpu: Use active umc info from discovery
Date: Mon,  5 May 2025 18:11:36 -0400
Message-Id: <20250505221419.2672473-480-sashal@kernel.org>
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

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit f7a594e40517fa2ab25d5ca10e7b6a158f529fb5 ]

There could be configs where some UMC instances are harvested. This
information is obtained through discovery data and populated in
umc.active_mask. Avoid reassigning this as AID mask, instead use the
mask directly while iterating through umc instances. This is to avoid
accesses to harvested UMC instances.

v2: fix warning (Alex)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 42 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  1 -
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index eafe20d8fe0b6..0a1ef95b28668 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -387,6 +387,45 @@ int amdgpu_umc_fill_error_record(struct ras_err_data *err_data,
 	return 0;
 }
 
+static int amdgpu_umc_loop_all_aid(struct amdgpu_device *adev, umc_func func,
+				   void *data)
+{
+	uint32_t umc_node_inst;
+	uint32_t node_inst;
+	uint32_t umc_inst;
+	uint32_t ch_inst;
+	int ret;
+
+	/*
+	 * This loop is done based on the following -
+	 * umc.active mask = mask of active umc instances across all nodes
+	 * umc.umc_inst_num = maximum number of umc instancess per node
+	 * umc.node_inst_num = maximum number of node instances
+	 * Channel instances are not assumed to be harvested.
+	 */
+	dev_dbg(adev->dev, "active umcs :%lx umc_inst per node: %d",
+		adev->umc.active_mask, adev->umc.umc_inst_num);
+	for_each_set_bit(umc_node_inst, &(adev->umc.active_mask),
+			 adev->umc.node_inst_num * adev->umc.umc_inst_num) {
+		node_inst = umc_node_inst / adev->umc.umc_inst_num;
+		umc_inst = umc_node_inst % adev->umc.umc_inst_num;
+		LOOP_UMC_CH_INST(ch_inst) {
+			dev_dbg(adev->dev,
+				"node_inst :%d umc_inst: %d ch_inst: %d",
+				node_inst, umc_inst, ch_inst);
+			ret = func(adev, node_inst, umc_inst, ch_inst, data);
+			if (ret) {
+				dev_err(adev->dev,
+					"Node %d umc %d ch %d func returns %d\n",
+					node_inst, umc_inst, ch_inst, ret);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
 int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 			umc_func func, void *data)
 {
@@ -395,6 +434,9 @@ int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 	uint32_t ch_inst         = 0;
 	int ret = 0;
 
+	if (adev->aid_mask)
+		return amdgpu_umc_loop_all_aid(adev, func, data);
+
 	if (adev->umc.node_inst_num) {
 		LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
 			ret = func(adev, node_inst, umc_inst, ch_inst, data);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 5250b470e5ef3..f1dc9e50d67e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1504,7 +1504,6 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.umc_inst_num = UMC_V12_0_UMC_INSTANCE_NUM;
 		adev->umc.node_inst_num /= UMC_V12_0_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V12_0_PER_CHANNEL_OFFSET;
-		adev->umc.active_mask = adev->aid_mask;
 		adev->umc.retire_unit = UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL;
 		if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
 			adev->umc.ras = &umc_v12_0_ras;
-- 
2.39.5


