Return-Path: <stable+bounces-128135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA89A7AF97
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED7817E878
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AD926461A;
	Thu,  3 Apr 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCNZMQru"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8F72641F7;
	Thu,  3 Apr 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708056; cv=none; b=OO0fafV3HoSmABKf1KuepxIiAU7py/LhWeC9GIofU7BXxUpLCp2h/cLALNI7LJJ0rERlQ7TVAd6Skp8gdNZ64QUvPPNclC0Zo6FZmDbQ9rfvDqF+ZGxTo+JWaqG73Q/vGqZuoP4toGj/YNc7ZliGcAWEqf0b8PT2ErE5rYkTHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708056; c=relaxed/simple;
	bh=/IOZMtSo6mnSnWXL1xZvCmxC2/FGiJrwjbNKJESM+Kc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nc0mA17cQbCnyIVPG4ZCfEgcd93QkvXRi4Ip1c3fo8zfWQBZyMB2tSa9i1F2j7mIImxyBR33C43uc4JYx5yWSB6gL2k5TZzoMkTuY0TdQulSScEMmopkt4TVlmDQ6uaVJY8o0t2vKfcSsXJQklj46jWhOmicB/fJtBtqFYwEP3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCNZMQru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA8AC4CEE8;
	Thu,  3 Apr 2025 19:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743708056;
	bh=/IOZMtSo6mnSnWXL1xZvCmxC2/FGiJrwjbNKJESM+Kc=;
	h=From:To:Cc:Subject:Date:From;
	b=MCNZMQrurqQkhdItGEtksXvhmGGIyIUuCwgI5m4G7qWvT4Hnaoe5IaxhC9t4hZ23m
	 10MpMU6FIxnmMl9Q04biO9S/My5JzHC6/jhK1t+ryBfCPglJn+PZ/rn5oFrPRf9fvv
	 djgRfrkrN9C1efiTT/BELwNRet0GSIUiSiuAQSnpC8GLdBE75SMV1j6SMAlJTkAfFG
	 lXu+esH6LuX56ZJ3TDDfRrnX1VOx39TqE3WsLb2E4WuN6QMbR58SsXyHSPDaYXidas
	 5GS9kXeLzym4oE5KeQSL8071KghTw4MagYlYpNuI+QsE6mlHkQ+7kPYbYyl0QNbUvq
	 k5Ynfg7172QyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 1/9] drm: allow encoder mode_set even when connectors change for crtc
Date: Thu,  3 Apr 2025 15:20:42 -0400
Message-Id: <20250403192050.2682427-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
Content-Transfer-Encoding: 8bit

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

[ Upstream commit 7e182cb4f5567f53417b762ec0d679f0b6f0039d ]

In certain use-cases, a CRTC could switch between two encoders
and because the mode being programmed on the CRTC remains
the same during this switch, the CRTC's mode_changed remains false.
In such cases, the encoder's mode_set also gets skipped.

Skipping mode_set on the encoder for such cases could cause an issue
because even though the same CRTC mode was being used, the encoder
type could have changed like the CRTC could have switched from a
real time encoder to a writeback encoder OR vice-versa.

Allow encoder's mode_set to happen even when connectors changed on a
CRTC and not just when the mode changed.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241211-abhinavk-modeset-fix-v3-1-0de4bf3e7c32@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index d91d6c063a1d2..70d97a7fc6864 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1225,7 +1225,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 		mode = &new_crtc_state->mode;
 		adjusted_mode = &new_crtc_state->adjusted_mode;
 
-		if (!new_crtc_state->mode_changed)
+		if (!new_crtc_state->mode_changed && !new_crtc_state->connectors_changed)
 			continue;
 
 		DRM_DEBUG_ATOMIC("modeset on [ENCODER:%d:%s]\n",
-- 
2.39.5


