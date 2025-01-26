Return-Path: <stable+bounces-110551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24FFA1C9DE
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E85F1881584
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFB51F9A91;
	Sun, 26 Jan 2025 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSE2Uch+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1644190052;
	Sun, 26 Jan 2025 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903336; cv=none; b=o3kF/JhJew3SXQarpsU2jKdNp1h3+rc15INJhSoJJkFd7sBP4IERTF5r10U3AL2kiy98mE2x7loSUTRAJVtvl4UjNOJSmaVE0jAWHqC5aRV9M61pCKhypJ+s/t9R+TauMoIzQOt3Cs2WRxJIHKRWEtxSqc3B99bwA+39QOymQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903336; c=relaxed/simple;
	bh=eobPHnESK3HhnA4oyak0zVx+YXq6YNDAcH29j12Pm7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NOIuOoV1UVtsukT6PJb6WcUY50X5fX5t90IEfLKdg/if17OPOMilnxI6nw944yN+IpB1gXWlK0GGfaFWpg8RDb6MR04YSxzY3TexCq96VXLs60Y7YVQxFft1imUYkh/MGx+qH2H3TRyxYZ04HhlM/vzXMIXk3E8EQBLpiCTXa0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSE2Uch+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774CCC4CEE3;
	Sun, 26 Jan 2025 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903335;
	bh=eobPHnESK3HhnA4oyak0zVx+YXq6YNDAcH29j12Pm7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSE2Uch+AFzT7RL+GzZ4gQPgeol2Kf7cJLLDf5XJeVK6wTlGv3wl3LbtCh4CoaizF
	 XylRCq7A/0LeBje9Bsudp5Z4phu9/XHFF1Yanfwz4gSpcKWP9V02nj5YqBLpOy3gE0
	 3HowQtP4luWdopwFV+pJB41v6qpV/+QHllfgcZYG0UJtibNhOAgoBYGJ63McZX5pNF
	 r60Jc0IjorwX58udaXqEl0BU0XNSsiOZNRxJH6pmJ9gZSq3jiJz21nLvS8RCFS0/+f
	 eYNHj7WHClIFwAIQV2rl6z9yrZX+2NwDU9ozvdbQtYiNoz757+cyrbkELg08A+ldz7
	 KvdInR6Jn5p7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	hamza.mahfooz@amd.com,
	chiahsuan.chung@amd.com,
	sunil.khatri@amd.com,
	alex.hung@amd.com,
	aurabindo.pillai@amd.com,
	hersenxs.wu@amd.com,
	mwen@igalia.com,
	Wayne.Lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 15/31] drm/amd/display: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:54:31 -0500
Message-Id: <20250126145448.930220-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145448.930220-1-sashal@kernel.org>
References: <20250126145448.930220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 819bee01eea06282d7bda17d46caf29cae4f6d84 ]

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241206-drm-connector-eld-mutex-v2-4-c9bce1ee8bea@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ea403fece8392..84b801171fe5a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1036,8 +1036,10 @@ static int amdgpu_dm_audio_component_get_eld(struct device *kdev, int port,
 			continue;
 
 		*enabled = true;
+		mutex_lock(&connector->eld_mutex);
 		ret = drm_eld_size(connector->eld);
 		memcpy(buf, connector->eld, min(max_bytes, ret));
+		mutex_unlock(&connector->eld_mutex);
 
 		break;
 	}
-- 
2.39.5


