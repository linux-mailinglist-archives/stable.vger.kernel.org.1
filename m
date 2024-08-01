Return-Path: <stable+bounces-65110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB87943EAD
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA981F2256D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3683F1BC69C;
	Thu,  1 Aug 2024 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmmvj15g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D6C1BC68F;
	Thu,  1 Aug 2024 00:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472470; cv=none; b=JRhRtyaimtEQB2wT8/rh9EX7Y6KOTpDvHNquNb7TNf/nfm1BQ9JYWS7hzM19SAtN138mnLXtddQUpKBS54qoRQEvbsho56SByJv/bsDatSsAFhvQcIsSogCMc03Xg3fid9mGExcBUSX3t/SzNBIYFbD++JmtdxejPro1+ieizLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472470; c=relaxed/simple;
	bh=SFCQKDRoQxZ9HNuxOmdKGBw7E3AQ6cBJ+ggwF+lL5CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjzQ9/P217yyUNaOCZUzXYic5K7d2j+Eyp2rclOQi2atsXIgnxKq7u4gY8r60jMVZuH0QLozDNa1bpfDXXKFPDmQRFIksDcW1WG8ydfKgdVAGsnc0y5VM4ctbbRa1Aq0zeq6ZonMaHYZKSKn2viwJ4jIoJgDNr7n3KePeF09fY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmmvj15g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420FAC116B1;
	Thu,  1 Aug 2024 00:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472469;
	bh=SFCQKDRoQxZ9HNuxOmdKGBw7E3AQ6cBJ+ggwF+lL5CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kmmvj15gPdLW1HDHDc8IdH0vl1Xtpl0JsiaZsti4N3k8PM+DfiTtiZTrMurJUjZn3
	 SfFXPfSkQ2EP00BJaRP7wrdDllDcZjlzv0R3j/CA2/6I90sdDdT766m0oAT59XmwHU
	 44tN/Hp3FhYlOYk2HpD2y5OiLdKsJ+FEDsFrAuiTnWMDZiAhKxaPKoWZzedEPbTHkr
	 qOnIFuh+SfVxsLyncY1eokXp0+T7saLHEKO+Ramp7HHVi3I0tpRyvZMlQ3fRH/Kl/Q
	 jILjnGjEYWqISqVqMuDvsTv36tC8Pdx9zN6ZUQ3+yHOvjd4ls0u0Tk5r87PRM8ZD42
	 x6Thrg0suqAYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	lijo.lazar@amd.com,
	le.ma@amd.com,
	Likun.Gao@amd.com,
	shiwu.zhang@amd.com,
	Lang.Yu@amd.com,
	YiPeng.Chai@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 20/47] drm/amdgpu: fix the waring dereferencing hive
Date: Wed, 31 Jul 2024 20:31:10 -0400
Message-ID: <20240801003256.3937416-20-sashal@kernel.org>
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

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit 1940708ccf5aff76de4e0b399f99267c93a89193 ]

Check the amdgpu_hive_info *hive that maybe is NULL.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index f305a0f8e9b9a..a8b7f0aeacf83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1178,6 +1178,9 @@ static void psp_xgmi_reflect_topology_info(struct psp_context *psp,
 	uint8_t dst_num_links = node_info.num_links;
 
 	hive = amdgpu_get_xgmi_hive(psp->adev);
+	if (WARN_ON(!hive))
+		return;
+
 	list_for_each_entry(mirror_adev, &hive->device_list, gmc.xgmi.head) {
 		struct psp_xgmi_topology_info *mirror_top_info;
 		int j;
-- 
2.43.0


