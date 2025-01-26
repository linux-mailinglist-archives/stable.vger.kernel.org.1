Return-Path: <stable+bounces-110553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBD0A1CA0B
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2B83ADF66
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5611F9F7A;
	Sun, 26 Jan 2025 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7Q/63gR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0BF1F9F74;
	Sun, 26 Jan 2025 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903339; cv=none; b=i9dhn+Jpyi2exRlH+7od9JjKNrSxr3aOLOWS/h2j5XC+h+kbhrZAG8o2wLWDXkB/+pG3EgVeK/1Kcbd2I8iB7fu5OTNoyamX9e8+4CZTSHYMfjMWAzwFGlfQschrhvXjBb+9TarVurrRRGlEoPUPkwS5jfYJTcCcfIS/XWAxOPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903339; c=relaxed/simple;
	bh=AUYlC3Kq1tJ9yUzra1pfHn+21oUrYNBP5wRDuPx4TAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eKDnPsw7N+b4CQcSHz6SbplqpJ+2nxY/Dt6QFa1GHARE/XTW5NkS5c6tyt7Qq4t79sRb72KHjYdIuv6LPJuhuDbuFBPcwwWO0KIjKkf35K07Gq8eAciGe5e/5ncA6NJ9E6jOwqzBn5NLAMd9a+ypy7KJWjDhVdOGKbzQ66EBZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7Q/63gR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDA1C4CED3;
	Sun, 26 Jan 2025 14:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903339;
	bh=AUYlC3Kq1tJ9yUzra1pfHn+21oUrYNBP5wRDuPx4TAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7Q/63gR3yfy4m4DevP4EaHdNskGZbLn7frjVZINZI8r1qpHZb+W0ScTB6pKY/f3b
	 bArpuCKDcY2p4AxDklHLdPKnnmBqJMLidh04pRjWIq/lkBqWHZ3Ol8ShmoHbqmkkX1
	 +8ophDlEizCsaHH72b2JbRbFIyFuqGX5obdBYcnCb2RxjfrXw2wwFmlGzDADuU5KEX
	 /aDZPmq2VYjW6Sdit1WjX4XnocU/UktlyPOHXWRIhX2KE9hcutE/C8IKARRzCZRp12
	 0KR+0KPJslKkhOg1sjgLsODoCtSAPcOc1iczzOH6XNba09jQ3F8eRZTKgCDWgj/umu
	 CJPyTsUQhiewg==
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
Subject: [PATCH AUTOSEL 6.12 17/31] drm/radeon: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:54:33 -0500
Message-Id: <20250126145448.930220-17-sashal@kernel.org>
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
index 5b69cc8011b42..8d64ba18572ec 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -775,8 +775,10 @@ static int radeon_audio_component_get_eld(struct device *kdev, int port,
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


