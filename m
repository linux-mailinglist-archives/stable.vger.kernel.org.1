Return-Path: <stable+bounces-128000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1525A7AE09
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2041650EA
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8BD1B4247;
	Thu,  3 Apr 2025 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH5BHpaT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9541ACEC8;
	Thu,  3 Apr 2025 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707719; cv=none; b=Tv3nay0cv7k7Nr3UyDyyylvdmbdfMmBEWdwNhynZvgw0SirnYNqdXjsVRY2rD7CO1lF0cSdx++ORJB3JgfJTi+4QKkkkFfKYBSwxQREyqRddx+UXH8PFSKhXkAzG+WJax6D7CnrTGuT0x0pvNJ+0zw60LtURDJxz5vUFTXV7tjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707719; c=relaxed/simple;
	bh=AS4RaIshtcU30uLBqrbLWUqtMzDm0R+BHz6wn5S4PGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T5yAOirEzvDhU6OPzMOF8X9c6KDv1w4XGYK8ezgtk6JMHfdYoaBlalmpVsWrac9srnr0lzAG1l2kMy5ug6VwN8ucKcNkLgYIfrgac04sde2k4fTI9fIQ7dbfEz3SQfyJBIq6E6UhkVxym3/mMwaryrtecwtsGuI3prXl8Llj5CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH5BHpaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A92C4CEE3;
	Thu,  3 Apr 2025 19:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707719;
	bh=AS4RaIshtcU30uLBqrbLWUqtMzDm0R+BHz6wn5S4PGo=;
	h=From:To:Cc:Subject:Date:From;
	b=fH5BHpaT0tWs6EfDEKYVvTfAKGUZ5bnsCie5C03zmog3HMr1qlTszJWVhu0X/qSVu
	 i25LWx+JgVKZUkUkrgbBxQjsSw2s2SvSJgzBAQ8ndwYk2OSEq3FAvi/URCny8KgKpe
	 P0Uo+50x8yvc8c+VAKJBaga5XKrC0vrVce9k4aqSDQOqoJ+45Kwl9hlCz4W3dy1Y8C
	 9tfkBuK3ugiepaQRbJfe0Ywhq8kg4eRlSk8OPy14EkLQLT5V/aLBpvjteX+1MYN+1F
	 0JhumqjZK6PbrKwHGkNywtqU/GXbeQA0N/oYpfV7j5BRIWNYQw5Xy06hI18JenHiFP
	 EYKCXfkFZ25Eg==
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
Subject: [PATCH AUTOSEL 6.13 01/37] drm: allow encoder mode_set even when connectors change for crtc
Date: Thu,  3 Apr 2025 15:14:37 -0400
Message-Id: <20250403191513.2680235-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 5186d2114a503..32902f77f00dd 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1376,7 +1376,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 		mode = &new_crtc_state->mode;
 		adjusted_mode = &new_crtc_state->adjusted_mode;
 
-		if (!new_crtc_state->mode_changed)
+		if (!new_crtc_state->mode_changed && !new_crtc_state->connectors_changed)
 			continue;
 
 		drm_dbg_atomic(dev, "modeset on [ENCODER:%d:%s]\n",
-- 
2.39.5


