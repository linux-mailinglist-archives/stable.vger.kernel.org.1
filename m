Return-Path: <stable+bounces-66788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5272994F278
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DDF1C20C41
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25934188007;
	Mon, 12 Aug 2024 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MSS5hLrf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89AD187FFA;
	Mon, 12 Aug 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478786; cv=none; b=O/u11suD8anVoobhFp211YHl5HU/wCotesPG3qCK1mQGIvzKHbZk8qgxLzaoOfbFIO6IwsAu8c2eihyewEo+RpF7oKv3llk4lCGBEy44SYZ675amu5OLBeshL2WzERmDJ4bwro8zPB9OunHtIeTP+fOKBqQgTkyEWdzxg0+oEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478786; c=relaxed/simple;
	bh=vkevaCzJdNULAQaEfyr2jfKXBozJy47XTGkERg1Rg0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYujraGDdBWp7lo8KG/vpfDhGSolLUPYMhpqiVBoR9+G7h60KkpNOGf44eDXaePmyd4MT4t/heVqyl/PtQ+TWm1IHvaC1GxY4fh73e9NyYOz7z1BkNRTw+73DZ10pGhk554XBy03XWAVIOWK+F8qmbNeF5BkkbZxorTtiWHOooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MSS5hLrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182B1C4AF09;
	Mon, 12 Aug 2024 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723478786;
	bh=vkevaCzJdNULAQaEfyr2jfKXBozJy47XTGkERg1Rg0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSS5hLrfdrDf31BbFgNFnp9rcGnf7hAlJl5Kb2iSUZidExtW9RDRnJ44kMFQggw5c
	 nOiEEvtKphkEY0/dfi6SeP8oKsuyy7138MZwNCaaHoILR0NHvH2C27XIp2Gycj1OFh
	 9g26kyk9vP2E8uEmlol8fapCUh8y/sGqTj4jDAqQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Wang <kevinyang.wang@amd.com>,
	Ma Jun <Jun.Ma2@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 037/150] drm/amdgpu/pm: Fix the null pointer dereference in apply_state_adjust_rules
Date: Mon, 12 Aug 2024 18:01:58 +0200
Message-ID: <20240812160126.596911192@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160125.139701076@linuxfoundation.org>
References: <20240812160125.139701076@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit d19fb10085a49b77578314f69fff21562f7cd054 ]

Check the pointer value to fix potential null pointer
dereference

Acked-by: Yang Wang<kevinyang.wang@amd.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  7 +++++--
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    | 14 ++++++++------
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |  7 +++++--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 9f2f3f6a79adb..750b7527bdf83 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3327,8 +3327,7 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 			const struct pp_power_state *current_ps)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
-	struct smu7_power_state *smu7_ps =
-				cast_phw_smu7_power_state(&request_ps->hardware);
+	struct smu7_power_state *smu7_ps;
 	uint32_t sclk;
 	uint32_t mclk;
 	struct PP_Clocks minimum_clocks = {0};
@@ -3345,6 +3344,10 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 	uint32_t latency;
 	bool latency_allowed = false;
 
+	smu7_ps = cast_phw_smu7_power_state(&request_ps->hardware);
+	if (!smu7_ps)
+		return -EINVAL;
+
 	data->battery_state = (PP_StateUILabel_Battery ==
 			request_ps->classification.ui_label);
 	data->mclk_ignore_signal = false;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index b015a601b385a..eb744401e0567 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1065,16 +1065,18 @@ static int smu8_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 				struct pp_power_state  *prequest_ps,
 			const struct pp_power_state *pcurrent_ps)
 {
-	struct smu8_power_state *smu8_ps =
-				cast_smu8_power_state(&prequest_ps->hardware);
-
-	const struct smu8_power_state *smu8_current_ps =
-				cast_const_smu8_power_state(&pcurrent_ps->hardware);
-
+	struct smu8_power_state *smu8_ps;
+	const struct smu8_power_state *smu8_current_ps;
 	struct smu8_hwmgr *data = hwmgr->backend;
 	struct PP_Clocks clocks = {0, 0, 0, 0};
 	bool force_high;
 
+	smu8_ps = cast_smu8_power_state(&prequest_ps->hardware);
+	smu8_current_ps = cast_const_smu8_power_state(&pcurrent_ps->hardware);
+
+	if (!smu8_ps || !smu8_current_ps)
+		return -EINVAL;
+
 	smu8_ps->need_dfs_bypass = true;
 
 	data->battery_state = (PP_StateUILabel_Battery == prequest_ps->classification.ui_label);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index d8cd23438b762..2628f12e0eedc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3263,8 +3263,7 @@ static int vega10_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 			const struct pp_power_state *current_ps)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
-	struct vega10_power_state *vega10_ps =
-				cast_phw_vega10_power_state(&request_ps->hardware);
+	struct vega10_power_state *vega10_ps;
 	uint32_t sclk;
 	uint32_t mclk;
 	struct PP_Clocks minimum_clocks = {0};
@@ -3282,6 +3281,10 @@ static int vega10_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 	uint32_t stable_pstate_sclk = 0, stable_pstate_mclk = 0;
 	uint32_t latency;
 
+	vega10_ps = cast_phw_vega10_power_state(&request_ps->hardware);
+	if (!vega10_ps)
+		return -EINVAL;
+
 	data->battery_state = (PP_StateUILabel_Battery ==
 			request_ps->classification.ui_label);
 
-- 
2.43.0




