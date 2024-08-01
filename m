Return-Path: <stable+bounces-64966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA93D943D11
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB991C2204A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026DB156C4D;
	Thu,  1 Aug 2024 00:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/YrvzGJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AC613DDDD;
	Thu,  1 Aug 2024 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471781; cv=none; b=b606v4mBtrbYzVaoF5t33OplK1Xy1Lk55bkYwSTgON3gP6Mf3DASGit//+ftmMbnmvmIRNRtO8T3TInpabPuNKG5LKSU8U53uRQ8uRArOah+j3IBbe7RmjR2fPzrxWyZ107XHuTf9RR06q19/SCKkuf6rRqY356Jz65PgpCF2p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471781; c=relaxed/simple;
	bh=oN8h7yYj3znNgxFi3tx4IFtmd/cKtHRpvkD6FO0DkQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJAv1FdID1B7fFLG+jyMih00sodijfgj9OTWteXenY/HJOhLK0cQY+qfwIoe44hjDU+A/S3yeh+Ppy53nPZo39w35elTblkL86qlDeENqYSK09xUkskUvHCaW3aP+S2WEmGwICTAmmFQVF0M2T1FkuVJ/DtiIFjOkE3rvMqxkPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/YrvzGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE72C116B1;
	Thu,  1 Aug 2024 00:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471781;
	bh=oN8h7yYj3znNgxFi3tx4IFtmd/cKtHRpvkD6FO0DkQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/YrvzGJd3v+7g9nl4eVPJ88WzlLzHo+V+kk2xPsbEAgk3ZVCj/hhEvV7gf/UUqyr
	 VG26Vvl6kfY5+liHuaioJ0MG61LTT1tGJvn9UTtGaKCHz4nN+/LBg8OtD2sOFFIrKg
	 XxEJK2PqumCCDj+U34EmQp26byz96kLbeLcYtI2slLPMKRAm7eq3GGWK2i8cLWMqj/
	 8b19ftnUXzhvXAJu90VQq1oe2X7M3lKqP3Dm4MFIiyHQrA2db0gq+yw8210zOL6UoN
	 w5MTr9BwiCc7Zt2sMHXfbOqSnQsao1EyqH2JhAclDNAXkC4Namy9WHxIM12QoXIW7g
	 mdaTyhHOSWA3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alvin.lee2@amd.com,
	chaitanya.dhere@amd.com,
	wenjing.liu@amd.com,
	hamza.mahfooz@amd.com,
	sohaib.nadeem@amd.com,
	samson.tam@amd.com,
	Qingqing.Zhuo@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 20/83] drm/amd/display: Fix index may exceed array range within fpu_update_bw_bounding_box
Date: Wed, 31 Jul 2024 20:17:35 -0400
Message-ID: <20240801002107.3934037-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit 188fd1616ec43033cedbe343b6579e9921e2d898 ]

[Why]
Coverity reports OVERRUN warning. soc.num_states could
be 40. But array range of bw_params->clk_table.entries is 8.

[How]
Assert if soc.num_states greater than 8.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c | 10 ++++++++++
 drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c | 10 ++++++++++
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   | 10 ++++++++++
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c | 10 ++++++++++
 4 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c
index e2bcd205aa936..8da97a96b1ceb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c
@@ -304,6 +304,16 @@ void dcn302_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_p
 			dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
 		}
 
+		/* bw_params->clk_table.entries[MAX_NUM_DPM_LVL].
+		 * MAX_NUM_DPM_LVL is 8.
+		 * dcn3_02_soc.clock_limits[DC__VOLTAGE_STATES].
+		 * DC__VOLTAGE_STATES is 40.
+		 */
+		if (num_states > MAX_NUM_DPM_LVL) {
+			ASSERT(0);
+			return;
+		}
+
 		dcn3_02_soc.num_states = num_states;
 		for (i = 0; i < dcn3_02_soc.num_states; i++) {
 			dcn3_02_soc.clock_limits[i].state = i;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
index 3eb3a021ab7d7..c283780ad0621 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
@@ -299,6 +299,16 @@ void dcn303_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_p
 			dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
 		}
 
+		/* bw_params->clk_table.entries[MAX_NUM_DPM_LVL].
+		 * MAX_NUM_DPM_LVL is 8.
+		 * dcn3_02_soc.clock_limits[DC__VOLTAGE_STATES].
+		 * DC__VOLTAGE_STATES is 40.
+		 */
+		if (num_states > MAX_NUM_DPM_LVL) {
+			ASSERT(0);
+			return;
+		}
+
 		dcn3_03_soc.num_states = num_states;
 		for (i = 0; i < dcn3_03_soc.num_states; i++) {
 			dcn3_03_soc.clock_limits[i].state = i;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index cf3b400c8619b..3d82cbef12740 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2885,6 +2885,16 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 				dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
 			}
 
+			/* bw_params->clk_table.entries[MAX_NUM_DPM_LVL].
+			 * MAX_NUM_DPM_LVL is 8.
+			 * dcn3_02_soc.clock_limits[DC__VOLTAGE_STATES].
+			 * DC__VOLTAGE_STATES is 40.
+			 */
+			if (num_states > MAX_NUM_DPM_LVL) {
+				ASSERT(0);
+				return;
+			}
+
 			dcn3_2_soc.num_states = num_states;
 			for (i = 0; i < dcn3_2_soc.num_states; i++) {
 				dcn3_2_soc.clock_limits[i].state = i;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index b26fcf86014c7..ae2196c36f218 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -789,6 +789,16 @@ void dcn321_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 			dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
 		}
 
+		/* bw_params->clk_table.entries[MAX_NUM_DPM_LVL].
+		 * MAX_NUM_DPM_LVL is 8.
+		 * dcn3_02_soc.clock_limits[DC__VOLTAGE_STATES].
+		 * DC__VOLTAGE_STATES is 40.
+		 */
+		if (num_states > MAX_NUM_DPM_LVL) {
+			ASSERT(0);
+			return;
+		}
+
 		dcn3_21_soc.num_states = num_states;
 		for (i = 0; i < dcn3_21_soc.num_states; i++) {
 			dcn3_21_soc.clock_limits[i].state = i;
-- 
2.43.0


