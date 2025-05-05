Return-Path: <stable+bounces-140370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C262AAA7F5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FF31883EC7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E045344536;
	Mon,  5 May 2025 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBLvJQh1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5703234452E;
	Mon,  5 May 2025 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484711; cv=none; b=mgxFQPZFT2X7l3RLDVdUMZMsYWtD+E9dWE5EJoelDWtD4aMm+33+wDxUiWU9CoNgelRTkZQaRIh0YKUXr5OBomCQCol5PuvglwIGlSzxQvYxwCx5RMdynlykz2SuWReUtB4BaLK8ir7FKKH49BTPe28CmQZw2cXDvDGhgHYGlO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484711; c=relaxed/simple;
	bh=iczV1HlI/2jffBDU8pp3h5oTO12sKfPrCJaQ6eo9G8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pXgROGtlM2ixwlZX7FoGYttKcg9o36K5JfBQkIXIfjjHxPtM5hXbcgs8jSxyqhjdtR8DR9r8T6GMaEw3ABBeqbInRwyCFqhHcRjfK3cutpfEOBQfx2OAvr8UDdfKadtF0LtRantB8yzgeSPKjKtXFJ81aRCnBKNEoRyxMfIm8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBLvJQh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE33C4CEED;
	Mon,  5 May 2025 22:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484710;
	bh=iczV1HlI/2jffBDU8pp3h5oTO12sKfPrCJaQ6eo9G8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qBLvJQh17K3tWJQ2CJMT3owIop34cYBWEygdwvV/YMTKAH+Di19KcvvAABIIP9sgG
	 v/KfYHhpNvfL3oQ2RIbXvSAT3Fp1knZm7zoYoGPn3KFmJOqKPaXNiXbIs+Dw7T0QBR
	 6ZN7I28bnFKdCt/QYn5zNAHvqatUh4EyXh5NNINo3pjF2+BHlgQxP1mt/0fHIRnAJS
	 KMA9F39r2d8HdRKaIlkQyV3lHE2BOqCgTvqmVIobb0rf3OvPPdlAx8zDURpRhkYdrL
	 lyf6EEOX3Y3SYiOTx3c0cFatk5t2ZMocRx6hYnOSoxe/ZZVAgkbjdsPbllw6pBmP5V
	 j0HrIrtcf06EQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 621/642] drm: Add valid clones check
Date: Mon,  5 May 2025 18:13:57 -0400
Message-Id: <20250505221419.2672473-621-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Jessica Zhang <quic_jesszhan@quicinc.com>

[ Upstream commit 41b4b11da02157c7474caf41d56baae0e941d01a ]

Check that all encoders attached to a given CRTC are valid
possible_clones of each other.

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241216-concurrent-wb-v4-3-fe220297a7f0@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 32902f77f00dd..40e4e1b6c9110 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -574,6 +574,30 @@ mode_valid(struct drm_atomic_state *state)
 	return 0;
 }
 
+static int drm_atomic_check_valid_clones(struct drm_atomic_state *state,
+					 struct drm_crtc *crtc)
+{
+	struct drm_encoder *drm_enc;
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
+									  crtc);
+
+	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask) {
+		if (!drm_enc->possible_clones) {
+			DRM_DEBUG("enc%d possible_clones is 0\n", drm_enc->base.id);
+			continue;
+		}
+
+		if ((crtc_state->encoder_mask & drm_enc->possible_clones) !=
+		    crtc_state->encoder_mask) {
+			DRM_DEBUG("crtc%d failed valid clone check for mask 0x%x\n",
+				  crtc->base.id, crtc_state->encoder_mask);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * drm_atomic_helper_check_modeset - validate state object for modeset changes
  * @dev: DRM device
@@ -745,6 +769,10 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 		ret = drm_atomic_add_affected_planes(state, crtc);
 		if (ret != 0)
 			return ret;
+
+		ret = drm_atomic_check_valid_clones(state, crtc);
+		if (ret != 0)
+			return ret;
 	}
 
 	/*
-- 
2.39.5


