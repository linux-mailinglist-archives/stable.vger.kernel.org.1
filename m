Return-Path: <stable+bounces-172589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ECDB328BE
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631B19E14A2
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 13:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433AA13B5AE;
	Sat, 23 Aug 2025 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hq9r5E98"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F5811CA9
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755955011; cv=none; b=Kny/5CCwJcMwAIH+Xaf9iOF6/47pJqSRp3UIMhpuafxc5MJiGUqPGRJqqOZ+cF7upjN1n04fqsefZMnSw1yg6Vl6NuH7RvfgVT9weXo0F8j/Lj1RjwXwT4YXH6SMhWmazzQuWvFhXrPWuQtmqLgskmWou3Uv4Z+iARhpSr+7kiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755955011; c=relaxed/simple;
	bh=puMNeMlK3w8wfWIDIEMS6YCOGp1yDbeRLySPr+4HsbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVUXDBq8BfTVNw7yWzYYQF6awk3iD/3NNHAYD2UrkCo5Kq63x+LFxFEVwHSLhi0Uvi2YffceUyk2WcfTwmAy+rPRrj9bzSRSxNOR5JvUw29pRMjsq1SrXi152WwJ565RB6NJWlvXEPwKtn9XF88JDIrNr8JKJjA1/iIXx247HrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hq9r5E98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC073C4CEE7;
	Sat, 23 Aug 2025 13:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755955010;
	bh=puMNeMlK3w8wfWIDIEMS6YCOGp1yDbeRLySPr+4HsbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hq9r5E98mLP9lxiuD2UII3xlMofDOKkTkb5xybgreLjwSfRPlOOZmqubzFgpqKsrT
	 nc/578y2REKIj9QT8e7x9OzV3rFzc8ZHcjZALOyc2jOjiXo/kzIQQSha+pgaLnplwl
	 BrEeXp9wWEjxOVreOz9HDzHnE9QjOd9XbAZGLMtpleSYOmon7/aSWiDfkow8ODjQzU
	 6H7uTW3Q0ctI3U/CERXi3ErBEKSEMQjEFqIlH+8v5SMOsU/HCEerLV03kxcOHvJYCc
	 XWnmCGEzV0pWjlhGn0mi1vF+ZmSFZhsNmt+Bj5Ca1yN98oaqLNXSt01DpDhwTsdwZE
	 JzyzFaQ+BmPuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y] drm/amd: Restore cached manual clock settings during resume
Date: Sat, 23 Aug 2025 09:16:47 -0400
Message-ID: <20250823131647.2118519-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082108-oil-trailing-aa0d@gregkh>
References: <2025082108-oil-trailing-aa0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 796ff8a7e01bd18738d3bb4111f9d6f963145d29 ]

If the SCLK limits have been set before S3 they will not
be restored. The limits are however cached in the driver and so
they can be restored by running a commit sequence during resume.

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://lore.kernel.org/r/20250725031222.3015095-3-superm1@kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4e9526924d09057a9ba854305e17eded900ced82)
Cc: stable@vger.kernel.org
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d79a1d94661a..81490f4c6eca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -76,6 +76,9 @@ static void smu_power_profile_mode_get(struct smu_context *smu,
 				       enum PP_SMC_POWER_PROFILE profile_mode);
 static void smu_power_profile_mode_put(struct smu_context *smu,
 				       enum PP_SMC_POWER_PROFILE profile_mode);
+static int smu_od_edit_dpm_table(void *handle,
+				 enum PP_OD_DPM_TABLE_COMMAND type,
+				 long *input, uint32_t size);
 
 static int smu_sys_get_pp_feature_mask(void *handle,
 				       char *buf)
@@ -2144,6 +2147,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
+	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
@@ -2175,6 +2179,12 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 
 	adev->pm.dpm_enabled = true;
 
+	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
+		ret = smu_od_edit_dpm_table(smu, PP_OD_COMMIT_DPM_TABLE, NULL, 0);
+		if (ret)
+			return ret;
+	}
+
 	dev_info(adev->dev, "SMU is resumed successfully!\n");
 
 	return 0;
-- 
2.50.1


