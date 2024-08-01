Return-Path: <stable+bounces-65032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB15C943DBD
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46A96B23FFB
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF316F907;
	Thu,  1 Aug 2024 00:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFiQOSqu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB4F16F8F3;
	Thu,  1 Aug 2024 00:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472096; cv=none; b=sY1ssjVWIhAFhmEx/LLNU10FU8ETp4Kcs625FhBw0BHZSkznqSacJNllo1QIjS8HyVeWMLrelTWnxnGBotTxet4b52AvWFVZxWyt7L6L3xV0XuAyNnFQSZ4WwsxL4lc+KqBIxyMh6oDr8kGtG4+s5xEHUvLnCWeidONWoTRTePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472096; c=relaxed/simple;
	bh=YNtRwT8a/UE3UjSgeuGTFUuQ8mKPAAe7QL/qzXUi3cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXnWs2bbt/PI6/sREKLslN0F2lOEB3OpUZngSYJLUzFw1PZZCm8S8EaFxtPDqaOQlAmALvRRPFrMFi2okwU1ngTE68wRnH5TeA/eMk3aQlE++Vh1ORcIMjOxZs6izYL7lhRKDlP8V4SaqdnpCuWjluVPrdIXuYCpW0+JEvW88cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFiQOSqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374C0C32786;
	Thu,  1 Aug 2024 00:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472096;
	bh=YNtRwT8a/UE3UjSgeuGTFUuQ8mKPAAe7QL/qzXUi3cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nFiQOSqucQQU8RYE3JbfNpk++RJJ81TRpJfCmjYq0g2F7800Z0G/qur7B90Irxib8
	 WSZw+q1xbhWEi9cqUHOhb+4gVeorhavrtZZQQ5617Pl7nCNlUJLzeD/MSXvJpKOnmH
	 JajRw7tJ8k8Awceh8OBYPEk2lb4s3lixLTFbllSbvEa25Umthj83oEAbR2SAMsHUu0
	 jv0Mgvyd1qw3JTTqVlhWGLobiXQQ9UhNzJVxHRSM5S6hkCb+Grq9pHTqWz9YiFanI+
	 gOBGIBRu9tW8HsPhgdCTl8/gRDDLxrWtE4LAsYGaH7z7AIPcr9nXD6RJ/NDo08wnFw
	 w4jFFZTSVB0fQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Jun <Jun.Ma2@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	kenneth.feng@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	kevinyang.wang@amd.com,
	sunran001@208suo.com,
	jesse.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 03/61] drm/amdgpu/pm: Check the return value of smum_send_msg_to_smc
Date: Wed, 31 Jul 2024 20:25:21 -0400
Message-ID: <20240801002803.3935985-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit 579f0c21baec9e7506b6bb3f60f0a9b6d07693b4 ]

Check the return value of smum_send_msg_to_smc, otherwise
we might use an uninitialized variable "now"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 86d6e88c73862..e4d524ae5a772 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1036,7 +1036,9 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 
 	switch (type) {
 	case PP_SCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &now);
+		if (ret)
+			return ret;
 
 	/* driver only know min/max gfx_clk, Add level 1 for all other gfx clks */
 		if (now == data->gfx_max_freq_limit/100)
@@ -1057,7 +1059,9 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 					i == 2 ? "*" : "");
 		break;
 	case PP_MCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetFclkFrequency, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetFclkFrequency, &now);
+		if (ret)
+			return ret;
 
 		for (i = 0; i < mclk_table->count; i++)
 			size += sprintf(buf + size, "%d: %uMhz %s\n",
-- 
2.43.0


