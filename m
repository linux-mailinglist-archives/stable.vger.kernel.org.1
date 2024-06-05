Return-Path: <stable+bounces-48130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9348FCCC3
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83D7282007
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0AB196440;
	Wed,  5 Jun 2024 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpoiUwcE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA325195FF3;
	Wed,  5 Jun 2024 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588948; cv=none; b=K/XOxNCjrhgDD+PeI0Vir74nckBhn+0sDC9hHmwaG7SDKwlFHBqswuUAnyQ8ZsaUZhlBvbvbmVYR9nbSU8/Dqt+DPRGbb1bm81HH0jyEIacrj1X+gb61FN8IO3+9wC5zJVWVSsZhB+QMnqa4nwrN1MFYhWyHlvq0UrpAIn8eSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588948; c=relaxed/simple;
	bh=FgrilCR7PCWlydzFzxiRwvpWlP3ziGuP2hn1K1zPjP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hn40l3qVsug1VbnjIPsXouN9jhtfroQyGdKy+gRcmRgrIjPX+V7p2qtJTRBmvvG8i+Hj3vwJHE68KzhHWOEPKTKYt+2HWp7np/71p0jBzul1nawcZyjWjqriyBkD7A2gdPW0l4n6vam0D6yjOk64PgtJ3Xt882Qa31mFA7ZanyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpoiUwcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A11C4AF0C;
	Wed,  5 Jun 2024 12:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588948;
	bh=FgrilCR7PCWlydzFzxiRwvpWlP3ziGuP2hn1K1zPjP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lpoiUwcEd3QeCvbo8sxWtAv5NfjYRdhX9HvmGnZFBcOETw0+xrXYG378UOpv342/g
	 z4KsaYyQknH5rt4W4Q1H8ze8jfFcQV5nl/jP4UORQWKD6VQMEbrqGnm8P9FDoZGOSn
	 2pF05AolCec/aqAuAvSUHnBSkoNb9DcJRbYUH4myZBbkx/dvEOHy1Ge8f7N9owrse2
	 mHGGs0CulGFg0+hO1KLU3+GmMMKEupZKw1QUybQkoQ683fYNuhFEHc5qyqr/FzroNW
	 zvwq+3elyqSUGfpeEa9WWgo8lvn1bTVjs12llcycK6bwr4GM3hzkGDScP+mW45/R+I
	 a444d9XOfAzSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hawking Zhang <Hawking.Zhang@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	YiPeng.Chai@amd.com,
	kevinyang.wang@amd.com,
	lijo.lazar@amd.com,
	lee@kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.9 03/23] drm/amdgpu: correct hbm field in boot status
Date: Wed,  5 Jun 2024 08:01:46 -0400
Message-ID: <20240605120220.2966127-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120220.2966127-1-sashal@kernel.org>
References: <20240605120220.2966127-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Hawking Zhang <Hawking.Zhang@amd.com>

[ Upstream commit ec58991054e899c9d86f7e3c8a96cb602d4b5938 ]

hbm filed takes bit 13 and bit 14 in boot status.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index e0f8ce9d84406..db9cb2b4e9823 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -43,7 +43,7 @@ struct amdgpu_iv_entry;
 #define AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(x)		AMDGPU_GET_REG_FIELD(x, 7, 7)
 #define AMDGPU_RAS_GPU_ERR_SOCKET_ID(x)			AMDGPU_GET_REG_FIELD(x, 10, 8)
 #define AMDGPU_RAS_GPU_ERR_AID_ID(x)			AMDGPU_GET_REG_FIELD(x, 12, 11)
-#define AMDGPU_RAS_GPU_ERR_HBM_ID(x)			AMDGPU_GET_REG_FIELD(x, 13, 13)
+#define AMDGPU_RAS_GPU_ERR_HBM_ID(x)			AMDGPU_GET_REG_FIELD(x, 14, 13)
 #define AMDGPU_RAS_GPU_ERR_BOOT_STATUS(x)		AMDGPU_GET_REG_FIELD(x, 31, 31)
 
 #define AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT	1000
-- 
2.43.0


