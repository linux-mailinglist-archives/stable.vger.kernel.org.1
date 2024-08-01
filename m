Return-Path: <stable+bounces-65149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF72943FAE
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C65C2B281E4
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C031BE873;
	Thu,  1 Aug 2024 00:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIfmde+L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB2314C596;
	Thu,  1 Aug 2024 00:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472659; cv=none; b=OYk3uKfgYcnsKkrX3q6WWDAY4Tf3f2esgpeKiLev6rgqXM7+dpeKhJ5rnpDDhgbXwCVDuZW/0xXGv++rDl9MCGwOQ3jW207DoigCqgxnxLM4CEbHrzXHqU1y9GBGdvTU+u/ttqU4HTnf3z5GdJBAUbEBOvaQqzs2eetIEciTInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472659; c=relaxed/simple;
	bh=3RbiJGro6g0WQhZesVXepLZ0myZ851L/loTBg/yGXgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kem26UFx/p68p64WFxq1Xo2jb+wdHYm4ht114ixlXhl/T9CM7RgkIG/rC9+RtKd9oRJxbKstAoC2I3yZetWdJ4epreK67GFP+26O8tHK8LB5izQLQMdoxkc8ipFVX1LzF3flQcDa1ZHPKiYTDRpXvDr5jzlac6FXP6qw0mYh3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIfmde+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAACEC32786;
	Thu,  1 Aug 2024 00:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472659;
	bh=3RbiJGro6g0WQhZesVXepLZ0myZ851L/loTBg/yGXgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NIfmde+LiUwNoXwQqupTyfGzwK6ReAEr0dGaZLsp9Bmb84ynZVyRv/C4UmQVXxvVa
	 10Y4u6IRNgbHIyFRGgqFoTUEf2cWWKN+ZHZd7wCehe/lJKCEZ38l32Un9SLZRNUFJp
	 8aUuZNFoHSSI09QpBursRGjgQp5NSpCzEqT+3PU3i7I8r4DD7+/TbESZG4XPXalEf1
	 H4JhD+D8OAtOan+93WKUTMJEjW+8ekNo5i43KNwq3g8sOB1R6lIMt9pEGkuYjSK11F
	 Hao7QIiqs/dSsSp0ADKqPWtHkhaJIAQBWBn8GrKnUv/LktWZ43VdD5HMhQcX9Wzp+4
	 lex1MQBzCa5ZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Jun <Jun.Ma2@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 12/38] drm/amdgpu: Fix out-of-bounds read of df_v1_7_channel_number
Date: Wed, 31 Jul 2024 20:35:18 -0400
Message-ID: <20240801003643.3938534-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit d768394fa99467bcf2703bde74ddc96eeb0b71fa ]

Check the fb_channel_number range to avoid the array out-of-bounds
read error

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
index d6aca1c080687..9587e8672a01c 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
@@ -70,6 +70,8 @@ static u32 df_v1_7_get_hbm_channel_number(struct amdgpu_device *adev)
 	int fb_channel_number;
 
 	fb_channel_number = adev->df.funcs->get_fb_channel_number(adev);
+	if (fb_channel_number >= ARRAY_SIZE(df_v1_7_channel_number))
+		fb_channel_number = 0;
 
 	return df_v1_7_channel_number[fb_channel_number];
 }
-- 
2.43.0


