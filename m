Return-Path: <stable+bounces-64970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CE2943D1A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F958285BB4
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBCE21C19C;
	Thu,  1 Aug 2024 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0qIjsBH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478BB157E61;
	Thu,  1 Aug 2024 00:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471798; cv=none; b=UkHYqsDMDPIHto8pMAgJJEDJiMTRUcaM1oQaH5DHyXVzGg80tYrBKJskELMlTFLhFnMWWSWEW+/ihPb6is/tsGkHKR8RuP66RGUmfsN9W+fz+1i4jOdOqIV0a0g99iBakEbC9SJwEAEGtr7jMvcV9nGOq9CrzlLZX3/GVjG3MjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471798; c=relaxed/simple;
	bh=+3L1MknO07wOY49inR3xzFOkxj/UaQNw3ONi5j/xy+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vg1T4GTW/eT3U++lWEy9C5RrjuKmudcDpI7k87YU3TRU01Cbdh7yXl/L6dFnuS48ugPVLeI11JStDx7d3o/ji3wpy7oi0qQzl7J1ks2dsD2eMywLlvvM+SUrt16gsfN+3SoNaH1bT4pZ1SGFtj7t4OE2g8obLNHQXHbJImRtecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0qIjsBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C830C116B1;
	Thu,  1 Aug 2024 00:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471797;
	bh=+3L1MknO07wOY49inR3xzFOkxj/UaQNw3ONi5j/xy+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0qIjsBH4JX5UbdBgRhdzryheXHLNyDXjguAejk2osG5uiwW36NAw6NX+tmmlh9Ip
	 4JMaNXosk+Nwygv4FYlK08FNHdU3EUGFV8WmLwyjdDszCgrb/KFMUKUfLfDbT1ZuTt
	 3p48RrLGs+tUZiXQP8apYZS9WEhwIxK5jZ++Ph2w0ylOBo3LYMfZQ4SD6bw1zHCc5A
	 CEFw8zYSBZGMSybflAJoAD9FZ+zvZD0dtU4y+RykaVPqP9ktJh1jvGq9/ChYtWH3G/
	 4wtRZaTJejP3n0wXdt3F1Bm5HCtBBZDZAq53dlD3+tq70vW1bYBTnrQTGIbj2d4xuf
	 ULQfAghanvy9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Jun <Jun.Ma2@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 24/83] drm/amdgpu: Fix out-of-bounds read of df_v1_7_channel_number
Date: Wed, 31 Jul 2024 20:17:39 -0400
Message-ID: <20240801002107.3934037-24-sashal@kernel.org>
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

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit d768394fa99467bcf2703bde74ddc96eeb0b71fa ]

Check the fb_channel_number range to avoid the array out-of-bounds
read error

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
index 5dfab80ffff21..cd298556f7a60 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
@@ -70,6 +70,8 @@ static u32 df_v1_7_get_hbm_channel_number(struct amdgpu_device *adev)
 	int fb_channel_number;
 
 	fb_channel_number = adev->df.funcs->get_fb_channel_number(adev);
+	if (fb_channel_number >= ARRAY_SIZE(df_v1_7_channel_number))
+		fb_channel_number = 0;
 
 	return df_v1_7_channel_number[fb_channel_number];
 }
-- 
2.43.0


