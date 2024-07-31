Return-Path: <stable+bounces-64866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 170E0943B32
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06BB21C21298
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53F216DED4;
	Thu,  1 Aug 2024 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8CG5nBT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB916DEC7;
	Thu,  1 Aug 2024 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471176; cv=none; b=mo/23eoDEbghPvVh0iEr1DDMk6ulCdw2bSN2mCvUOct9RBE7GuHsxYpYuYtAE0xam3uHlkbw28xmmW1BpMaqbk524aCG39y5o522fdzLuIlHArw46ejcwYc+VhYYRqzyQNZjh7n0GbxkCNjRoAi12/3a2mgXX4wciza2mh8U2AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471176; c=relaxed/simple;
	bh=JnjjrtI9ZluhYZ4pqtI1wpNaxDeCQ+KgDX1I7VdNqHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rq9WZe38NFvjy65/a2uSALrRlBgOEQTpDxS09sjfAcIZNCYESgEHwIATwoMTeqJaI8+wH2yuMkkGk7UDbTSUne8pUKxwl8R+AUDOXXkHQKtOknNRNPLvmzQtee4JlNGunhjQ0ffCrF4NX7awp3I6Y7yYjIjIkmYje5xXW4pU7U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8CG5nBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188EDC32786;
	Thu,  1 Aug 2024 00:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471176;
	bh=JnjjrtI9ZluhYZ4pqtI1wpNaxDeCQ+KgDX1I7VdNqHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8CG5nBT4m8LgQRDwm5SIZBlefI68cj0zQH4Z4XZP+cMkfgZSg/aBkZDMzXY4leVN
	 9ctBml6OjRn23L8cWZWCeTrx5n9yaJRCvbGMf5n3J5L3oq4Ai93isNcNleytvQjXtV
	 obV87TTk8HRiCKeoNS95yYjtJReiQaUbKBFfDuNLGAiZn4av9mvee4JBdkHn4PDAVY
	 QVcOA4gp7CMzJnV8lof3wNbF69grSuFFCfX3RX92LvanxzvOtrc0iTqGrzTirXSaur
	 rJNg1D+sY6+/dfuTOOzimScMUjtcczEn4Os1anS3Gq9lrhsvtFcbA3wKydp2V0XzXO
	 JOH0xyoNgrbbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Jun <Jun.Ma2@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	kenneth.feng@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mario.limonciello@amd.com,
	lijo.lazar@amd.com,
	ruanjinjie@huawei.com,
	alexious@zju.edu.cn,
	sunran001@208suo.com,
	jesse.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 041/121] drm/amdgpu/pm: Check input value for CUSTOM profile mode setting on legacy SOCs
Date: Wed, 31 Jul 2024 19:59:39 -0400
Message-ID: <20240801000834.3930818-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit df0a9bd92fbbd3fcafcb2bce6463c9228a3e6868 ]

Check the input value for CUSTOM profile mode setting on legacy
SOCs. Otherwise we may use uninitalized value of input[]

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 1fcd4451001fa..8f851d2b59486 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5640,7 +5640,7 @@ static int smu7_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, uint
 	mode = input[size];
 	switch (mode) {
 	case PP_SMC_POWER_PROFILE_CUSTOM:
-		if (size < 8 && size != 0)
+		if (size != 8 && size != 0)
 			return -EINVAL;
 		/* If only CUSTOM is passed in, use the saved values. Check
 		 * that we actually have a CUSTOM profile by ensuring that
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index f9efb0bad8072..827669e01343b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -4091,9 +4091,11 @@ static int vega20_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 	if (power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 		struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
-		if (size == 0 && !data->is_custom_profile_set)
+
+		if (size != 10 && size != 0)
 			return -EINVAL;
-		if (size < 10 && size != 0)
+
+		if (size == 0 && !data->is_custom_profile_set)
 			return -EINVAL;
 
 		result = vega20_get_activity_monitor_coeff(hwmgr,
@@ -4155,6 +4157,8 @@ static int vega20_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 			activity_monitor.Fclk_PD_Data_error_coeff = input[8];
 			activity_monitor.Fclk_PD_Data_error_rate_coeff = input[9];
 			break;
+		default:
+			return -EINVAL;
 		}
 
 		result = vega20_set_activity_monitor_coeff(hwmgr,
-- 
2.43.0


