Return-Path: <stable+bounces-110522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60777A1C993
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53D307A3119
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2349E1F12EE;
	Sun, 26 Jan 2025 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPdcX3Zj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35051EEA5E;
	Sun, 26 Jan 2025 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903255; cv=none; b=bJ+hyRJbPJg0wnBGgJ7cIdA0b8XURb88l9wH7nwpupUY1V3DjlHT4crMEZbNLgLlgbd8qnoSSD0gbr2jACNM7L8jTsJljQlelmfuTBF5628Wl5fJiz4LfvRdVXXjDDK8qsI4Iubkn9bRw+puV6a+yo5FzirqVl5leYkaw9JtKR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903255; c=relaxed/simple;
	bh=AUYlC3Kq1tJ9yUzra1pfHn+21oUrYNBP5wRDuPx4TAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u8T2dJ6+eBxbgERlHWMYTWLwRNN/QgLR2JFqp3n4foM/fASOHsLrYl7v9ORMF7AmORdw/uI9RjhzprNT4Ss/aEqhsoi49NPkfUwlZA6qqJveveBEValAjmPgz2snLgPNFxjKI/Xm77ooelO8LOq5XGdlDgG2dcj7zs65vPfsmE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPdcX3Zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69450C4CEEB;
	Sun, 26 Jan 2025 14:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903255;
	bh=AUYlC3Kq1tJ9yUzra1pfHn+21oUrYNBP5wRDuPx4TAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPdcX3Zj9eARevzCLHqZqL0Z9+Xf9cHx+Ic3YcS+kTqHi7w2PeOIAyrwY5UuxjCgA
	 2Mf7R9hdGriohFGoLCnupuOKb5eIpG64k1VCQDUqe/Ql4pvZJqqeCCBcUXy6PYx8nX
	 O7EIw+5NK3dOE5j7WMAGymjst3PMyyBPBEx3Bh4GFKXC1e3RYZT6hdWQGvg6Rm/2l+
	 c+7negN4Wv3d8HBLv4EazfDKCS9RWR78a+H6aI+89ECbDLgRI4V9GEcFilvsLQOWlf
	 wbxmEEjTofkBPYcqTijAwiUqgMChb5ohrBwE3W4Krgt9j6WaU3Pd5Y6Kvuq0lq2abJ
	 rqoY5BQhli8qw==
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
Subject: [PATCH AUTOSEL 6.13 20/34] drm/radeon: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:52:56 -0500
Message-Id: <20250126145310.926311-20-sashal@kernel.org>
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


