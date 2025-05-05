Return-Path: <stable+bounces-141240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF36AAB1C3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFF51BC5011
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2BE41A06C;
	Tue,  6 May 2025 00:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnpmyRIY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58FF2D3A90;
	Mon,  5 May 2025 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485592; cv=none; b=rYHZE4tKDLLhPiX6XhKVRpmCWmw/hseaqRZs1sX+Fwf5YzC8bajQYsHplGGmSJJADhk08/SF8D49rcmFOl4GzJMstI59UZ8CiZD0mZ1nnSjHwezBefLtRpUUwMvDV/V9osP5QZUD3qbWyeJbACkFMXsnVLbFt8WERQXbE3n6/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485592; c=relaxed/simple;
	bh=DOv+hluDJkeFw0cpusk/kDnSBNSBHKrAs1jKiJmtKps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D1wKP/Axft5vdXkP7HrEvgfxPGV2ROEkh7NWOYlUQ6JJJF4dj9+DoLphDuVOY7/n0OaSlYm9CIEQCuVRtFbD+Q7FsEffPEeDXJJi3AJLLFNeuA9i0Rym27KefbaDKqSjHidktlVx9ru61rKOVp3tevQfVzmCG0K7clpVo9JHLjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnpmyRIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BDBC4CEED;
	Mon,  5 May 2025 22:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485591;
	bh=DOv+hluDJkeFw0cpusk/kDnSBNSBHKrAs1jKiJmtKps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YnpmyRIYGdrF6rzhU3A+xiUpK8625quO+ruHlHmUJsUnwZ7P4MBdGIaxFQfHTCNNN
	 Eu+pz6qqWXz5hcRc5h1suen3zOi2l2r48VrXFRtpb5SAlUUVLJl+h6Td8FsliCixhy
	 w+B0GFfcEHRUCEebxIt1yC+CZerLY4PHJzL3MiUuc2HmfG+2WTHsUpsrksjRdKluOW
	 VqG+4/HaGsIAgo146QflZOsC57a907gcnYjukYaCJWIMKrk0Etz1n0MWshQTZdgAid
	 uxFzJsKPxxbizTdp5M8hm7ooKS3it07WgJlcaooxPbH+6Up2hD+f+sPKsRm7hnNZ3z
	 oVUbn1PAtUdEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	mario.limonciello@amd.com,
	alex.hung@amd.com,
	chiahsuan.chung@amd.com,
	sunil.khatri@amd.com,
	aurabindo.pillai@amd.com,
	Yilin.Chen@amd.com,
	mwen@igalia.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 377/486] drm/amd/display/dm: drop hw_support check in amdgpu_dm_i2c_xfer()
Date: Mon,  5 May 2025 18:37:33 -0400
Message-Id: <20250505223922.2682012-377-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 33da70bd1e115d7d73f45fb1c09f5ecc448f3f13 ]

DC supports SW i2c as well.  Drop the check.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index beb57fe13e10b..71e9bd390348e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8300,7 +8300,7 @@ static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i;
 	int result = -EIO;
 
-	if (!ddc_service->ddc_pin || !ddc_service->ddc_pin->hw_info.hw_supported)
+	if (!ddc_service->ddc_pin)
 		return result;
 
 	cmd.payloads = kcalloc(num, sizeof(struct i2c_payload), GFP_KERNEL);
-- 
2.39.5


