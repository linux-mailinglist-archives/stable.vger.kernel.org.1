Return-Path: <stable+bounces-127956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CB4A7AD9F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895E83BA77D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6235E25BAD7;
	Thu,  3 Apr 2025 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leLdJ+od"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1981C25BAD4;
	Thu,  3 Apr 2025 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707599; cv=none; b=UXFBe8CDc9WHSvFauYhml6CXhw817ThuOLNFJN3eF3FLu3M6KDEdp0BLxbL5r7ceoIGvkCUMPvByMY7vIZvqavnoswCk3+kpIybS50CJO5Ix+Zd6jfQC6K4LwIEYidSBEq5z8vsQDMPYvtroxwmkirZL2r0zLCYhd2QOgSbetA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707599; c=relaxed/simple;
	bh=AS4RaIshtcU30uLBqrbLWUqtMzDm0R+BHz6wn5S4PGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lth0qRLDF+8TvE0mDOWdwdYS8OtIFz7p7rxprjd+MTN5MrdQiK14owPAIXuKwNTIRN718ZJsiPrecXLBStql6nS2Qa6FI5b6p/1MkUFMyoZEE1jZbKXGVPUO27C9ZOVT/YWowsQBwlSAlcmC6nLAaNKWdjtR9eINZXRJfNGnP0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leLdJ+od; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9441AC4CEE3;
	Thu,  3 Apr 2025 19:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707598;
	bh=AS4RaIshtcU30uLBqrbLWUqtMzDm0R+BHz6wn5S4PGo=;
	h=From:To:Cc:Subject:Date:From;
	b=leLdJ+odZ61X9Yu06Rp4KBGbQ4tMXwj0SNQE+FK6e65QZV9hqXByVqBkY0XbW+szR
	 n/YHODia+6eNKe3c2f31Djf7P1FtmZcXiYwAWia1Zba+Xa53xZcsNVR3US8Md+naiz
	 sjrCx1ZLQuuz1wcjBaFK3Xj7nqxMp1J5fX44KzdG4J3HEgCDE3n74kDc9O6O4ne2v1
	 hhVoCzAKd+PUfDLrW9XYWXU9/sEuxKOfnHjHZEk0uf47BjDnLfNfq0/UbBlzfd+sTD
	 tUDbdZsESIoyQS92MIW+R5mg5xGZ/oo3MQaq5GHlupLkpBkoWphdGMOVUxqC6qxS3D
	 5VRDPM7+Q/kaQ==
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
Subject: [PATCH AUTOSEL 6.14 01/44] drm: allow encoder mode_set even when connectors change for crtc
Date: Thu,  3 Apr 2025 15:12:30 -0400
Message-Id: <20250403191313.2679091-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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


