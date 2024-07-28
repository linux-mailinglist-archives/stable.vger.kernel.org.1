Return-Path: <stable+bounces-62204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A14CB93E6E8
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D583B21408
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442BF12AAC6;
	Sun, 28 Jul 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4ryGm4R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007746BFD4;
	Sun, 28 Jul 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181721; cv=none; b=JaDFqRb6RB5uXp7qSqYxVtYZLziy8BTkQKu5uis97hb0yO5K9O5HNcwHP6tzhkmYHEs1fU2B3QQZPhjiLTWivzRnPDnJbuaJRIlTfAj7XAyNC0R3cevIWiwHx30I7+h0riiOq8Stx6qu8UkBTgqWU8LA+vAMyU5FQxHJgDgCBcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181721; c=relaxed/simple;
	bh=brUqzKAvh3xyZVF8gixLWzR2W5IvsWZaHgyR051s5Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0R1dQAnA79hzr+pIeCnIYIG+NRlkJvJK9r/NwGm8D4Zx+7WKtsNAJidPfiF54+Pj+8tPKPaMBIckkR8X2VS1Ed+b2mjcw3IIDPMR4u3rTV/oONhoG2stUK8s4U8eH/LxSj0ugV5ki3DfIPc9kGRRuYhF2N3fORxo4nNXEKN87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4ryGm4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A720C4AF0B;
	Sun, 28 Jul 2024 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181720;
	bh=brUqzKAvh3xyZVF8gixLWzR2W5IvsWZaHgyR051s5Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N4ryGm4RXSxMp3tEWarpIImSG8eZXDrGtOieihSTfqdSrLyUZtCKRWTjkvpQbPO1S
	 0N+UJ+lYoc378XCvhcPBOk3I1iIqYF9aHvUr1sbW2KTsvXvk6qVjog39SsuHSdvt3F
	 bjiUnLrqvvl3HTiNK3aO5Z4f4bAkLWMbLxAKRaGnHdUo83jB7FfNQ7Dr5exKPIJgKr
	 OIw5zx/K5eeruBkRLLC5/kclnMnSRaqveOLxGF9ro5vzUo4ZfbAjcDiofEsFOEIprV
	 Sp60UE2xAKM7T12fSn6nT/T6f8Q6+Y8zoMo2/2Dy0c2foHQ41pQc+NyZLqkcxJcUKx
	 LwiENoZt+ut3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bob Zhou <bob.zhou@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	evan.quan@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Jun.Ma2@amd.com,
	lijo.lazar@amd.com,
	mario.limonciello@amd.com,
	ruanjinjie@huawei.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 06/17] drm/amd/pm: Fix the null pointer dereference for vega10_hwmgr
Date: Sun, 28 Jul 2024 11:47:16 -0400
Message-ID: <20240728154805.2049226-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154805.2049226-1-sashal@kernel.org>
References: <20240728154805.2049226-1-sashal@kernel.org>
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

From: Bob Zhou <bob.zhou@amd.com>

[ Upstream commit 50151b7f1c79a09117837eb95b76c2de76841dab ]

Check return value and conduct null pointer handling to avoid null pointer dereference.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 29 ++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 2628f12e0eedc..f8333410cc3e4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3422,13 +3422,17 @@ static int vega10_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwmgr, co
 	const struct vega10_power_state *vega10_ps =
 			cast_const_phw_vega10_power_state(states->pnew_state);
 	struct vega10_single_dpm_table *sclk_table = &(data->dpm_table.gfx_table);
-	uint32_t sclk = vega10_ps->performance_levels
-			[vega10_ps->performance_level_count - 1].gfx_clock;
 	struct vega10_single_dpm_table *mclk_table = &(data->dpm_table.mem_table);
-	uint32_t mclk = vega10_ps->performance_levels
-			[vega10_ps->performance_level_count - 1].mem_clock;
+	uint32_t sclk, mclk;
 	uint32_t i;
 
+	if (vega10_ps == NULL)
+		return -EINVAL;
+	sclk = vega10_ps->performance_levels
+			[vega10_ps->performance_level_count - 1].gfx_clock;
+	mclk = vega10_ps->performance_levels
+			[vega10_ps->performance_level_count - 1].mem_clock;
+
 	for (i = 0; i < sclk_table->count; i++) {
 		if (sclk == sclk_table->dpm_levels[i].value)
 			break;
@@ -3735,6 +3739,9 @@ static int vega10_generate_dpm_level_enable_mask(
 			cast_const_phw_vega10_power_state(states->pnew_state);
 	int i;
 
+	if (vega10_ps == NULL)
+		return -EINVAL;
+
 	PP_ASSERT_WITH_CODE(!vega10_trim_dpm_states(hwmgr, vega10_ps),
 			"Attempt to Trim DPM States Failed!",
 			return -1);
@@ -5002,6 +5009,8 @@ static int vega10_check_states_equal(struct pp_hwmgr *hwmgr,
 
 	vega10_psa = cast_const_phw_vega10_power_state(pstate1);
 	vega10_psb = cast_const_phw_vega10_power_state(pstate2);
+	if (vega10_psa == NULL || vega10_psb == NULL)
+		return -EINVAL;
 
 	/* If the two states don't even have the same number of performance levels
 	 * they cannot be the same state.
@@ -5135,6 +5144,8 @@ static int vega10_set_sclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 		return -EINVAL;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	vega10_ps->performance_levels
 	[vega10_ps->performance_level_count - 1].gfx_clock =
@@ -5186,6 +5197,8 @@ static int vega10_set_mclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 		return -EINVAL;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	vega10_ps->performance_levels
 	[vega10_ps->performance_level_count - 1].mem_clock =
@@ -5427,6 +5440,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr *hwmgr)
 		return;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return;
+
 	max_level = vega10_ps->performance_level_count - 1;
 
 	if (vega10_ps->performance_levels[max_level].gfx_clock !=
@@ -5449,6 +5465,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr *hwmgr)
 
 	ps = (struct pp_power_state *)((unsigned long)(hwmgr->ps) + hwmgr->ps_size * (hwmgr->num_ps - 1));
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return;
+
 	max_level = vega10_ps->performance_level_count - 1;
 
 	if (vega10_ps->performance_levels[max_level].gfx_clock !=
@@ -5639,6 +5658,8 @@ static int vega10_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_
 		return -EINVAL;
 
 	vega10_ps = cast_const_phw_vega10_power_state(state);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	i = index > vega10_ps->performance_level_count - 1 ?
 			vega10_ps->performance_level_count - 1 : index;
-- 
2.43.0


