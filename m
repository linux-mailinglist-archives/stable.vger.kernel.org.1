Return-Path: <stable+bounces-128095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C66A7AEFC
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C87AF7A7818
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523CD230BDA;
	Thu,  3 Apr 2025 19:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDBDUK36"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA742309A8;
	Thu,  3 Apr 2025 19:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707959; cv=none; b=tnZyt4WKVnhg03Zu0d6qrzwRUp4qyD3AU6Y18mKanGxrNZSRnbjVHY+mbXQxkEXv9bH7DDQ0+Df9HspUzm9RUbugzddlWRoaDJ39wcSN2Tridoc4/nXPse1FTCDBveIg1MBGWSjdr/95UL1amOvYhExBwad9KSKpu5Xj59auwHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707959; c=relaxed/simple;
	bh=aCUomGsdaP+/h1uVvks0w3gDQ3U8zxPSSxUAoF+OzKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PXuFdC/XsxCdzYJy2nmuUIzfcIPbeIDrczJtWRL6m4NRIV9KhILf9wStw2z24gIdGWmwoXTJsoDNwuA3ysbUa9Q8s4qDhhz1hM/K4hy7oNgidFLh3J814EFXsjiGqfHaA/bYuoyXj3EPOEYAbZ8fChrDoi2XDOtT0gxtQ+OXQpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDBDUK36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9040EC4CEE3;
	Thu,  3 Apr 2025 19:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707958;
	bh=aCUomGsdaP+/h1uVvks0w3gDQ3U8zxPSSxUAoF+OzKk=;
	h=From:To:Cc:Subject:Date:From;
	b=EDBDUK36LKpVZpOoPRU+g4EY83A1L1lMo4dzMqouI7u3BnBI228bsx7yhnBXOuVQi
	 5HOU63nI9V2nwjrgq53bHK1CDampq7OQ2+rfoj4g1ykkmL0ja1/WcuEuUUgebnoTYx
	 qvYAvGO3YGy4LTZ3HpYBWpsOTjDl7aAeIUFdk/ADzhEycFxSNX0Jrmwaffn9H6a80z
	 NmZyYGTbqBdFZr+GjGb+3jAH4Ed/sNS6b3ICbpAxVre08nTvW5XRqjT/wiKDLfDRtC
	 q0P4fjUOjHHvYOeEA5kZ87bHXgyGOKdmEaW5SNIeRIFxOtYtW6zP3iAuzGih9mWFih
	 f9qSfjN4j8j/Q==
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
Subject: [PATCH AUTOSEL 6.1 01/20] drm: allow encoder mode_set even when connectors change for crtc
Date: Thu,  3 Apr 2025 15:18:54 -0400
Message-Id: <20250403191913.2681831-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index b097bff1cd18e..66d223c2d9ab9 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1389,7 +1389,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 		mode = &new_crtc_state->mode;
 		adjusted_mode = &new_crtc_state->adjusted_mode;
 
-		if (!new_crtc_state->mode_changed)
+		if (!new_crtc_state->mode_changed && !new_crtc_state->connectors_changed)
 			continue;
 
 		drm_dbg_atomic(dev, "modeset on [ENCODER:%d:%s]\n",
-- 
2.39.5


