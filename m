Return-Path: <stable+bounces-110575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36650A1CA09
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C9A7A2DA8
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0743B1FDE05;
	Sun, 26 Jan 2025 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEduJBqM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B581FDE01;
	Sun, 26 Jan 2025 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903392; cv=none; b=lp1yqK3wvpsQT/a1ifszrjxBTRfHBN24JD/rdGTjFtUZnaSrPyCeBAIlfD0IhWoqY2ll+CJEsy2PeIYU79CPHMsW418JPQeTgOorBeYfHz/hFby5je6B8XvaKb8PLsqVk2oPFIShtNRw99ygkyO78VT6UWCUriC1oYZn4cXIe8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903392; c=relaxed/simple;
	bh=kME5yRiRSilS8XC5gTZceQWF76oZl872X/ZUtzoDK68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pEKBjk7shbL4l8RHR+G2hM4tYDpQJEa95o1OY9v23Iej36bzFwwuEOiR+86PLO6iqwA9RK9hLEfQHzRfnfLmVBh0ssfN2TXP76MeIElp1NfZxwW7Geweddap97DJxuL/PGd7ltlKg096E11J08fYs1LsGGlcVfZ6KX2wWg+VLZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEduJBqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D74C4CED3;
	Sun, 26 Jan 2025 14:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903392;
	bh=kME5yRiRSilS8XC5gTZceQWF76oZl872X/ZUtzoDK68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gEduJBqMjTWIzlEe+NOudpf5TZUzDX2tB8ivtS6t5tkcsXp8EbJWdpQ8beVWWp/e1
	 MUvJMo9S2dZqIA10CSPFlP5g3pgeEyswuodBIJKvB9Lq048K567AIdvi0OiNijf3zL
	 R96v3SwBkfA4+n3x9frZfn8vj8rEQCP9w8dZJUGXF2j8rmw1hZg7vTkbQj03IVmFp9
	 1KYe1Fdv09UJG+bqr9XyzzkqFwXFjvjAg3WtrpcQcOsmJtt6j97DdqYozl80jE0Ugy
	 RUKb/T2HzCMHDO5nmGkXRhkztNCUorHk3oYFSd3q586pmF+7nfI+haw1FKt8sG3JaZ
	 d79Oca24LN5sw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 08/17] drm/radeon: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:56:03 -0500
Message-Id: <20250126145612.937679-8-sashal@kernel.org>
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

[ Upstream commit b54c14f82428c8a602392d4cae1958a71a578132 ]

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241206-drm-connector-eld-mutex-v2-8-c9bce1ee8bea@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index fc22fe709b9c1..da37a827337bc 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -773,8 +773,10 @@ static int radeon_audio_component_get_eld(struct device *kdev, int port,
 		if (!dig->pin || dig->pin->id != port)
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


