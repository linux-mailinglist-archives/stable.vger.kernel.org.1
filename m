Return-Path: <stable+bounces-65093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B961943E50
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A83B1F21071
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4376F1A072C;
	Thu,  1 Aug 2024 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vn/FVhOx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011361A0722;
	Thu,  1 Aug 2024 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472389; cv=none; b=CJuBzZIudqdQPx4UI38lRmfbBAgar0+9eETXYqRjHkx5LYbe/mFOjLt27Vqj0S3XX/LrLBdh1jisKBhdQGd9Oao+ib7q0W0sSQ5FQyAg32PcWg+wck2gplpNu3D+zMqcS5eyPvCH6pv1k7o5fhPlVs273pgIBhQqo4yEo3BuraI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472389; c=relaxed/simple;
	bh=onH4nwG0PEBMdqEH7lbkYWYYlADZyb3z7vMJkMN6TLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJOVWHxFzPT5XsBEIzbE8XeHGzMdvq4VcwiXnx1CVGJwCQfXELR5XyZMBQLnHQSXNXsvqk/UwUdbjr3IhSwDT91cKmjTooD7dhQDncNvU29WmqWCYUh9kn+98h6ARCGZjC1wadnTbhGpJPIrps703sjNqmc3T8B759HaSrkwKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vn/FVhOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C937FC32786;
	Thu,  1 Aug 2024 00:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472388;
	bh=onH4nwG0PEBMdqEH7lbkYWYYlADZyb3z7vMJkMN6TLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vn/FVhOxcFiHp9d1vJHpmpcTdYRfwRlOgnwl+0F+QE9uZIKvVjoKfqO/BpMAkWcyd
	 NlhKHWO5BVSom8V8qbHjy81t0KnylSRhjGQTcLo5dc/At3/C4xo9Mz43H3QS/Omk0m
	 gJXzRQk6x8ryPWaaOzgCk1+WkTP3Lc6Cxhe9Iv2ObpfThdtvMf7mBQwEeqXWVWgQ/W
	 fUZ30Zn9yNXmBYQ2m+wI35bf6yFY85oPXy5TtmNeAO1qH6/6Wq1ccMLi3PvHrn3KUx
	 Pu3Zrd5VisS8AaZpwso79SGuADEx0SZZbOHKIFke/FkCZIUDasv+6ZCXE5rfPm+Gfr
	 d8d9aqRhBKPnA==
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
	sunran001@208suo.com,
	kevinyang.wang@amd.com,
	jesse.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 03/47] drm/amdgpu/pm: Check the return value of smum_send_msg_to_smc
Date: Wed, 31 Jul 2024 20:30:53 -0400
Message-ID: <20240801003256.3937416-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index cf74621f94a75..8b46214fc6fe3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1026,7 +1026,9 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 
 	switch (type) {
 	case PP_SCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &now);
+		if (ret)
+			return ret;
 
 	/* driver only know min/max gfx_clk, Add level 1 for all other gfx clks */
 		if (now == data->gfx_max_freq_limit/100)
@@ -1047,7 +1049,9 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
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


