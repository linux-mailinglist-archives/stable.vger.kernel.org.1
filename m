Return-Path: <stable+bounces-110519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E455EA1C9A6
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DCB166420
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC7E1A83ED;
	Sun, 26 Jan 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wr5UklEx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894BF17B50A;
	Sun, 26 Jan 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903249; cv=none; b=Y34YxHpz2yoAR8iiLHf8x0aVlVO53FyN28WS7DTKecaMBlsQ8BakdhR6E1Cz56HF2PExPd9QVsTNWz8e11YnaSgFn2TGp0DuYeO7vFoMjTojQnFwhU5zkEFEi4rfMZeb4Hk8lGkzCj5Fq/usnFooo0gUjVSZ+jKMkIlaung8iTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903249; c=relaxed/simple;
	bh=/iurob1wvptApvnWNCoz++NMp2598YmHcrTGhG+XRog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXxMMVvp7HUa75HmB+sfW3M1bu7YHg9pGeeHqea/TPn23js4KHwnz5Th9Lqo+k4BSdJ8tjdz9J8FqjgBZgGUG0okF0nldgkDwma6fO+VjIFIH0suTvLxI52v0uK7k+Kesg9k1jWMTWNmQyBbut4E/9qqvCg42XfjWs0MXa8pnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wr5UklEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9549C4CEE3;
	Sun, 26 Jan 2025 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903249;
	bh=/iurob1wvptApvnWNCoz++NMp2598YmHcrTGhG+XRog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wr5UklExPeKoeU2HC+QUPi6X9jDVZHxwhr7CJToTQ3/i/uhhgmTT4txREGsybcWEx
	 YgWuMukXjB8bajd4npaimtqtknJq0Xg3zMixj/jC876W0NdPC/xkGZF3si1bPzLKyS
	 ky2wPy4TSgDf/ZEWIyfNUPHfOsP0hwGwX7D2B+BhEuZnumHUKkZeZlXL2Z3wk2Xrud
	 M8t4dhOODMMXZFoTuY65Js2HOrAGBc67jH91a7O+66AlQqfaH6FJ3uvcN/z9rrxGzT
	 I0WCFOtmvNBi4w1wa28d9kOhkHrSffjVRdE0FsuRKfhlTv0fm8gc/BrBlieNqKVQ5Z
	 aknJ1MqsmOyWQ==
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
Subject: [PATCH AUTOSEL 6.13 17/34] drm/amd/display: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:52:53 -0500
Message-Id: <20250126145310.926311-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145310.926311-1-sashal@kernel.org>
References: <20250126145310.926311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index d394f758272e3..d6b193dcc25c9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1037,8 +1037,10 @@ static int amdgpu_dm_audio_component_get_eld(struct device *kdev, int port,
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


