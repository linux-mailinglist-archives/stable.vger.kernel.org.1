Return-Path: <stable+bounces-141567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4EBAAB49A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CD63AD793
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8B1343488;
	Tue,  6 May 2025 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hj/9Wlgj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6F12F152F;
	Mon,  5 May 2025 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486731; cv=none; b=QNupMP0dqAnMPju0OiLEEnqbeQ1NHiwUyz9sXtAJ+eErO82rF2mX4CsVqGYKTl/tBEI45IYraaBoUzMiR5rd3bsFolK8qxqTn+/cSAle3ucNFMCDJWg+JBD6kSjgmuVl0W/WWp2DvnEnqtAgkT2NL/njQsq13rjD431IhXpH5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486731; c=relaxed/simple;
	bh=vh9+QMtTfFQtALxE6B+h1YKZ4lOs8NdgSXIifjjRR1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R4RjL4giiXBu7rbWN8yvJ2oTlTSFt7HCDXzZUsmEH+ooKzUWfW6fsvH4rHqt/m6NpmgZ7Gud1prI6sl8zcI21Dqx9+5iDuGUB9lzE4yMU8VCiJmuhX66LF6w7kXqMrRpL3mOMEk1ai/KH/iQfG/ZpK3f5SxheIT+LI0uusNyTVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hj/9Wlgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA57C4CEE4;
	Mon,  5 May 2025 23:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486730;
	bh=vh9+QMtTfFQtALxE6B+h1YKZ4lOs8NdgSXIifjjRR1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hj/9WlgjyTtro4PPwEfP4yrfGBMIk5OCVwvr6Cq9hdb8FJk7IkGLv2V4gJFS0qotm
	 4zbThTrKQUm12Hwj9CqYOEVqO0TyeaZwv0XP2FerSNUcrU2YPUkJtL6JkgVxblZ+88
	 a6EoeT3L584EpT6nj1XSw+m3iDM5XAortKXkviRVLWtcQ8hqCYLr31j0WvNfW0UlS1
	 z+FriybuLLX37AfFUzphL82BlclFLLbcd61LCaAQVa/C7NemyRes8gdBwp31fX3yq+
	 on7VYWXa4vhZYZ3G6Z2YC4C9m69GSxfEgJeKHZnsW77qfH2c0/GDTvRdv+u6nSXAcp
	 LYEny9IgKsN0Q==
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
Subject: [PATCH AUTOSEL 6.1 173/212] drm/amd/display/dm: drop hw_support check in amdgpu_dm_i2c_xfer()
Date: Mon,  5 May 2025 19:05:45 -0400
Message-Id: <20250505230624.2692522-173-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 7dee02e8ba6fa..4666bbd5483f0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7281,7 +7281,7 @@ static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i;
 	int result = -EIO;
 
-	if (!ddc_service->ddc_pin || !ddc_service->ddc_pin->hw_info.hw_supported)
+	if (!ddc_service->ddc_pin)
 		return result;
 
 	cmd.payloads = kcalloc(num, sizeof(struct i2c_payload), GFP_KERNEL);
-- 
2.39.5


