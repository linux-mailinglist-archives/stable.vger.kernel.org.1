Return-Path: <stable+bounces-64889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF41943BB1
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F791C21C91
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9651917FF;
	Thu,  1 Aug 2024 00:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMfGTqlB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBC7148311;
	Thu,  1 Aug 2024 00:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471306; cv=none; b=ktjjnsBANiZlSCkd5pYT1kf80G6q2bhZRzpp4+DwAB9tjiYg9gjlJB+ZpWpdZ+cijVYuiopfA5iTUtohKz0cC/KakdFkZJ7jTCj4hcNV2B/f1OTIEtSeHNBTdnyS7LuNe8AXo0cTSQiFLQbvMB5fA7QP9+MCVex4KQgMzBtM04g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471306; c=relaxed/simple;
	bh=XtOBmbJSSX8k8FaJ6jexWUTSzNVx8y3Ygud8egqr274=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pm8LXyz/jnd3e3d9Yrafk5bM6G9I9rAAQ9JF805ISH8AE3ByWyA5d7s1nWZuqlKXhxlQMjOCK6aFhVyPiQSvlDvIBb6jPIXp2v5zRk3DjLAMVAYtedqLrK96Gm7cxp3GATQdTJnWkvVWnNyrIXjo9hI3c7BhA481Hi8+pTQrdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMfGTqlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFE2C32786;
	Thu,  1 Aug 2024 00:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471306;
	bh=XtOBmbJSSX8k8FaJ6jexWUTSzNVx8y3Ygud8egqr274=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lMfGTqlBGQV3JD7jXGFGClRCZrXQY8Hy48po3toNlxl0T1UlOfXdsGZHU22KK2su9
	 Kq1sLhYxtkUOUQr1sSpL3I5KnBLeaokEJpgaGA/p9WEsYtAUXgAOAONKkltdOyHANX
	 KJzSA16UvEsCD7rrvpAL6BHYUltMdAwdJFGyhpY1vXt68IS+zkmA3Rzy/tMftoI2/r
	 RM2s0mS1JwyTyrQrshwrJwCzICtS06R5/Me/ezTL2OiH94/zDJCxINz9F+EFoOaRfP
	 arTgc/ndSYExobFQez5QvPisILFGEUWPOmqRMbc5qk+sIq4YJageWyoi4XcNn9eOdm
	 czPevMpXvGlQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	yifan1.zhang@amd.com,
	Likun.Gao@amd.com,
	le.ma@amd.com,
	Prike.Liang@amd.com,
	Lang.Yu@amd.com,
	lijo.lazar@amd.com,
	victorchengchi.lu@amd.com,
	Jun.Ma2@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 064/121] drm/amdgu: fix Unintentional integer overflow for mall size
Date: Wed, 31 Jul 2024 20:00:02 -0400
Message-ID: <20240801000834.3930818-64-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit c09d2eff81a997c169e0cacacd6b60c5e3aa33f2 ]

Potentially overflowing expression mall_size_per_umc * adev->gmc.num_umc with type unsigned int (32 bits, unsigned)
is evaluated using 32-bit arithmetic,and then used in a context that expects an expression of type u64 (64 bits, unsigned).

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0e31bdb4b7cb6..71db111e20f80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1595,7 +1595,7 @@ static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 		break;
 	case 2:
 		mall_size_per_umc = le32_to_cpu(mall_info->v2.mall_size_per_umc);
-		adev->gmc.mall_size = mall_size_per_umc * adev->gmc.num_umc;
+		adev->gmc.mall_size = (uint64_t)mall_size_per_umc * adev->gmc.num_umc;
 		break;
 	default:
 		dev_err(adev->dev,
-- 
2.43.0


