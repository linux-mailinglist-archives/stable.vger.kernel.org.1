Return-Path: <stable+bounces-64856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4777F943AE4
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C45ADB2548F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA3112DDBA;
	Thu,  1 Aug 2024 00:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuGP6t5B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85411F50F;
	Thu,  1 Aug 2024 00:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471143; cv=none; b=ixrldVA7AgSj7fW1tKUVexTQEUN9VoL1HMqdkh2x8tgjwqLxGxvqWNTdxzg08UZU41l/gem39s5i80y+7LEUIRxO8iyAWWG5jFcvH4jqX4pDPiMd3b9elDD6ln9NfoKgWFuibe24UX77OBAMidJMES7o6TlOzOkq3aSktc42Jyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471143; c=relaxed/simple;
	bh=mTvjHh/jMriSdBoszi2VSAV3u1VAPiUYVFmeIZKAnN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqlAyBVieudNRI0/HLcR+It8zizW1AGMdS15W9r/ix91JPNpYSAuykw8QI+stvz7KwS6P9XmC+G2VYEhoBJeqECT6dBfug9NykYPdEN0eS8ZjJhgpbSgHZmtGvFtwkHosGY5nojH10e10DvXqHTzgxlAX1A2pm5B03zUopSDGj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuGP6t5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D738C32786;
	Thu,  1 Aug 2024 00:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471142;
	bh=mTvjHh/jMriSdBoszi2VSAV3u1VAPiUYVFmeIZKAnN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RuGP6t5BxYnTUzZ9REOPrUSxW3dXPjuR3jnoMAVXFykxD9yiFxRDpAwbT2nE8EocP
	 d+5yPmMT/oWmSYUJU8i7xJ91RA7hFCdRIWGYR00cgT2B2i2Yjyoaq/KXNMV2B3qnW5
	 4ywfFGrcP1n+nYz0oPpVqxX0/W0iq3adcCiLjqHy5JnQziSInoFH1OdAsH2g6xe04k
	 9CMu1cQstSv9YOL5xZn9bwkviCQYG/M2i2kjVLDz1ufrpoTzCpUWx4Xj2y/PqxmNsm
	 dJ2yDXVy+WNrNWavDfYeoeCNanpZnX75/dKtzIgK+QqyfjSf3ZLfHnWVEAjXfNtuab
	 PC2NczsE5Yq6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Asad Kamal <asad.kamal@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	mario.limonciello@amd.com,
	candice.li@amd.com,
	Jun.Ma2@amd.com,
	victorchengchi.lu@amd.com,
	andrealmeid@igalia.com,
	hamza.mahfooz@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 031/121] drm/amd/amdgpu: Check tbo resource pointer
Date: Wed, 31 Jul 2024 19:59:29 -0400
Message-ID: <20240801000834.3930818-31-sashal@kernel.org>
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

From: Asad Kamal <asad.kamal@amd.com>

[ Upstream commit 6cd2b872643bb29bba01a8ac739138db7bd79007 ]

Validate tbo resource pointer, skip if NULL

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 33f791d92ddf3..b151effc55dab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5011,7 +5011,8 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 		shadow = vmbo->shadow;
 
 		/* No need to recover an evicted BO */
-		if (shadow->tbo.resource->mem_type != TTM_PL_TT ||
+		if (!shadow->tbo.resource ||
+		    shadow->tbo.resource->mem_type != TTM_PL_TT ||
 		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||
 		    shadow->parent->tbo.resource->mem_type != TTM_PL_VRAM)
 			continue;
-- 
2.43.0


