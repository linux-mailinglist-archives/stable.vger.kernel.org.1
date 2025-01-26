Return-Path: <stable+bounces-110573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 698C9A1CA04
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C981886B26
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8A01D61A4;
	Sun, 26 Jan 2025 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhhZbE8g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5371D6187;
	Sun, 26 Jan 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903389; cv=none; b=EyWWQ/07SZYbJi/ewE0+lcqHnkl81Cpv6VpetX9h8HBOvGjiIp/MSM/7XRMJmzhvbs3jGSfWuXE2MGTake+2oJvKNhpZ21opgzqdXaVObw7TfwKUCaCgjP9VdyRldkSkcQbY925vYFsvg1hgolwukG/f3Be4upLc4xRNFSP0ADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903389; c=relaxed/simple;
	bh=eOTtRRo0BVYeiu6R746gwstLSaxRow6rUQ+63N00bRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tU0LjV+jlP8BPaGSSxPpeVcUjVu7yBhrwSneQSm5O48AcHZoBIu5dX7Fsb6JH84XVCbBO+OMbxeTB9HwIRfZpsUkvS15S6XP6zLbl7P/X44UjGHVefXqioopDsvOF1jlN31dzZ97xTwDE1K+ySn1QX6/xfnffSDz0EJIXkpQLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhhZbE8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347B2C4CEE2;
	Sun, 26 Jan 2025 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903388;
	bh=eOTtRRo0BVYeiu6R746gwstLSaxRow6rUQ+63N00bRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QhhZbE8guNYTV1rQx89PyLMFYag4DMQZSitTpSaMCwzG2bk9MHq5BzOzdcrJ0JtB3
	 ED/iYJ0xMwHFUTowAo9VS4SilZvHXCeX6Lx5iHQBFkBikNbI2mHwsiehg+Do4m7hHn
	 U3PjdEdAzNkNIttnRzhH7lLy4/qx+QSWl3LpThS6UAJfiC1sixrPTJe1n/Zl5kBqcB
	 JthpHjAWuoAfRnj3G2IfIgn8PNyyy9XN5GDdvxumUfFJaMV1QkLOnHXSV1ThujnQUM
	 kDI/yot05gQ0/oawO0L2Px0RCZ2w9qlphfsJFz/vEmtpSBTiAoo5o3hk+EBVXI+3nJ
	 U8uIiXcnhUbdw==
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
	chiahsuan.chung@amd.com,
	hamza.mahfooz@amd.com,
	sunil.khatri@amd.com,
	alex.hung@amd.com,
	aurabindo.pillai@amd.com,
	hersenxs.wu@amd.com,
	mwen@igalia.com,
	Wayne.Lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 06/17] drm/amd/display: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:56:01 -0500
Message-Id: <20250126145612.937679-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145612.937679-1-sashal@kernel.org>
References: <20250126145612.937679-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
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
index 8a152f4974d3c..aab99df3ba1ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -955,8 +955,10 @@ static int amdgpu_dm_audio_component_get_eld(struct device *kdev, int port,
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


