Return-Path: <stable+bounces-87153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2EC9A637A
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B252FB276F4
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFEB1E7C3A;
	Mon, 21 Oct 2024 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H4+WpBPE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D321E47B4;
	Mon, 21 Oct 2024 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506752; cv=none; b=a92hpZsztsgfhQycBD0GHGXQR/ylQA3zhEaVFJ45MKlPDhhfuSfVCOHmPL+oO2AWAITwRJOt3NCghUTcP+xxLsTa98W/1Bj4fxoiokz58sezAsS1GDajedPkkePEQZRprO4GWNNI8My7E6RlkCBK5SLUp46jYtNWe6R4DPlBmCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506752; c=relaxed/simple;
	bh=BwuquZrntVnM7mmwQ0PNYRPtNoMjvEC6CgW6m7P+68w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQI2CPkUUfY4k48+COGx2mLOS/FHz8zLHTR9+oYnFIaeA5msGhZ6dg/Fij3k6pb1QN++xX8XLjft4r0s6o8TK/gZj1ChKK2i1gOWj5T3OIv3H3lcmG3mAULQEBqvqeulHmjOb8ArxRsvB3Wdj/ZiUhu8A4RjNs3UBt+SHkacl2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H4+WpBPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914FAC4CEC7;
	Mon, 21 Oct 2024 10:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729506752;
	bh=BwuquZrntVnM7mmwQ0PNYRPtNoMjvEC6CgW6m7P+68w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H4+WpBPE4HdzMEcQ8UGjuIsE3DqxNqNfCcyw2NOLR2gmAbLzJQLah6Ide27BnSOd/
	 4ubCyGVXZd4CUj2tSJv8ZFJ04Mul8t8TEZx1fP6C10rAJ+24eMulkAPa9ZMnG/EJHt
	 cGroYSOCD0JHaHlpA2xcOsJAB2vNMaSuWKSik5Bo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.11 068/135] drm/amdgpu/swsmu: Only force workload setup on init
Date: Mon, 21 Oct 2024 12:23:44 +0200
Message-ID: <20241021102301.993035776@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102259.324175287@linuxfoundation.org>
References: <20241021102259.324175287@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit cb07c8338fc2b9d5f949a19d4a07ee4d5ecf8793 upstream.

Needed to set the workload type at init time so that
we can apply the navi3x margin optimization.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3618
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3131
Fixes: c50fe289ed72 ("drm/amdgpu/swsmu: always force a state reprogram on init")
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 580ad7cbd4b7be8d2cb5ab5c1fca6bb76045eb0e)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2226,7 +2226,7 @@ static int smu_bump_power_profile_mode(s
 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 					  enum amd_dpm_forced_level level,
 					  bool skip_display_settings,
-					  bool force_update)
+					  bool init)
 {
 	int ret = 0;
 	int index = 0;
@@ -2255,7 +2255,7 @@ static int smu_adjust_power_state_dynami
 		}
 	}
 
-	if (force_update || smu_dpm_ctx->dpm_level != level) {
+	if (smu_dpm_ctx->dpm_level != level) {
 		ret = smu_asic_set_performance_level(smu, level);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to set performance level!");
@@ -2272,7 +2272,7 @@ static int smu_adjust_power_state_dynami
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
 
-		if (force_update || smu->power_profile_mode != workload[0])
+		if (init || smu->power_profile_mode != workload[0])
 			smu_bump_power_profile_mode(smu, workload, 0);
 	}
 



