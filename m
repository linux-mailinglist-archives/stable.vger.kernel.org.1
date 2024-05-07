Return-Path: <stable+bounces-43366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8917B8BF21F
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3770B1F25A50
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43028137C2A;
	Tue,  7 May 2024 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRDy9+kn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02868137C27;
	Tue,  7 May 2024 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123515; cv=none; b=YseTaOGsnuHQ4HkTgBQbjgILfl7gwsLJPfSedF7F4tD8O0rslMZuBB7oOlyRWYsPeEcCNIkJG5Hpuo5AUsGKZjfqXeUBmo75rIwzPIFhZGBMKB1jtaCLKudBdSH/ki2rUYNugDePt055bQYaxsYAmGN392RKVX9xeVsUQpWnHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123515; c=relaxed/simple;
	bh=mPcqWpgLLmQeWUDSJ4hNN9EzC8IWpkeYOeDyImY9/zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgxhMvJSyc2UIb2aPHGa6HMSRrUfdmv64vUNema0c2cu0uJmda3+W1oD/kdBvlOzd92ilscC7h7zJIUiDfyvVaHpIEW0MGDhg0zAGeeDI3OBQ9rh1EeLCxis734hsE9RkvQoIKti53moS06q1UjO+pvrHYRy99JiVIQfqATAfPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRDy9+kn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC90C4AF67;
	Tue,  7 May 2024 23:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123514;
	bh=mPcqWpgLLmQeWUDSJ4hNN9EzC8IWpkeYOeDyImY9/zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRDy9+kn2xhSxRz+hJW2AaYQarIqR1aFl4isVZP9CrcDqM6yA0OFed3YBWnAKU1/3
	 Mm2iMwFuQRRqB6sDigTMq4BL8qu0M1Qb302/j2zuUrY442VTWBiA3fsPcOk8T7jw+G
	 1zeM9vIzToi0+T6Qy+rpoHLVNtAd4bBE551XBQlpg26AIgzuwfVCT/vq5OXJBbLJeW
	 yYumM6xUL66EjMNEDUQHgvrzL75HCdvMAAqk1Q0s90j8ynrwn2HT5vPNnIxWomr7k6
	 MVYqdBmrAE5UjceJiAx7yWD/GH2jQS41jiRws8doMvVSkjk8FFDUrA+0HtRKt90uRY
	 nQPzLMCRfy15g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sung Joon Kim <sungjoon.kim@amd.com>,
	Anthony Koo <anthony.koo@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alvin.lee2@amd.com,
	jun.lei@amd.com,
	wenjing.liu@amd.com,
	aric.cyr@amd.com,
	dillon.varone@amd.com,
	chiawen.huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 34/43] drm/amd/display: Disable seamless boot on 128b/132b encoding
Date: Tue,  7 May 2024 19:09:55 -0400
Message-ID: <20240507231033.393285-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Sung Joon Kim <sungjoon.kim@amd.com>

[ Upstream commit 6f0c228ed9184287031a66b46a79e5a3d2e73a86 ]

[why]
preOS will not support display mode programming and link training
for UHBR rates.

[how]
If we detect a sink that's UHBR capable, disable seamless boot

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 46b10ff8f6d41..72db370e2f21f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1710,6 +1710,9 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		return false;
 	}
 
+	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED)
+		return false;
+
 	if (dc->link_srv->edp_is_ilr_optimization_required(link, crtc_timing)) {
 		DC_LOG_EVENT_LINK_TRAINING("Seamless boot disabled to optimize eDP link rate\n");
 		return false;
-- 
2.43.0


