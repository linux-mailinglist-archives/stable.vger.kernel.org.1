Return-Path: <stable+bounces-48185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB648FCD75
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163D41C2160E
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B9D188CA9;
	Wed,  5 Jun 2024 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTWxmSWx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8331CA2FA;
	Wed,  5 Jun 2024 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589083; cv=none; b=rrmnmp/cUrF99NuphEb3aXw5DUznNsWyYFH3/4O1jevaUg5B2INLUXoA3fJ/nqr5WljzKd9FGtvpIh+DuUAVws9Ba3x3Ei5UsovSV92fA6e3kejQMmuvCeotzzPbstrW0lvdy+jQ2r+IJ2dDUjN2EcqhFEV7pQlLvlgaE3d4/tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589083; c=relaxed/simple;
	bh=ak9Vp86IkHKL5lFnKpGX/0AEgziySgCTH33SslKVXYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDwvEYiJ2cJyzZTK7hZG2kwKhejDZVKOMyDboKQXjyiYv6sx5sEwoUJ9g5Fzmn50o3qwnOk9qlaODXwCkoJTVZBH0fZ3WNfm35aSwW3vTP+4d66TblZp5AgLpkXB1rkcEVKPXjMx/q8XletV/cUHamAj6bq2L6868351MSPXAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTWxmSWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58380C3277B;
	Wed,  5 Jun 2024 12:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589082;
	bh=ak9Vp86IkHKL5lFnKpGX/0AEgziySgCTH33SslKVXYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LTWxmSWxWpvxHjinDHvCqR7244M+HHVY/BuhoXd8TXf3t57EVAJuBF4Nu4GvVhwOt
	 FQIlqVzRTOO4E3rV6u4mDzw5c9IyXHcj/7RYDxxBcsL2PzOF54L7qdNVGTRUfiYrQd
	 09oQO+REXNIxOBGkmfAftiepmIu4f2rngr2ZKYDC9oRDDx9PpxbKcCHfjVwRJdDt4P
	 rGbjWYODnVbh8xpc2BZvwgaurDRckxbVXwgHLYfXTYM1HiF2uqPl0OFKarz6ut3xN2
	 2b+I6wWbrT0ckKsIuJvYru0IFqBvhWMsxPFa5JF9pPX6AbJm71mHHvd583czoQs42W
	 m2+6llNRtLU9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Feifei Xu <Feifei.Xu@amd.com>,
	Feifei Xu <feifei.xu@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	nathan@kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 17/18] Revert "drm/amdkfd: fix gfx_target_version for certain 11.0.3 devices"
Date: Wed,  5 Jun 2024 08:03:56 -0400
Message-ID: <20240605120409.2967044-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120409.2967044-1-sashal@kernel.org>
References: <20240605120409.2967044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit dd2b75fd9a79bf418e088656822af06fc253dbe3 ]

This reverts commit 28ebbb4981cb1fad12e0b1227dbecc88810b1ee8.

Revert this commit as apparently the LLVM code to take advantage of
this never landed.

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Feifei Xu <feifei.xu@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 913c70a0ef44f..0c94bdfadaabf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -402,15 +402,8 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			f2g = &gfx_v11_kfd2kgd;
 			break;
 		case IP_VERSION(11, 0, 3):
-			if ((adev->pdev->device == 0x7460 &&
-			     adev->pdev->revision == 0x00) ||
-			    (adev->pdev->device == 0x7461 &&
-			     adev->pdev->revision == 0x00))
-				/* Note: Compiler version is 11.0.5 while HW version is 11.0.3 */
-				gfx_target_version = 110005;
-			else
-				/* Note: Compiler version is 11.0.1 while HW version is 11.0.3 */
-				gfx_target_version = 110001;
+			/* Note: Compiler version is 11.0.1 while HW version is 11.0.3 */
+			gfx_target_version = 110001;
 			f2g = &gfx_v11_kfd2kgd;
 			break;
 		default:
-- 
2.43.0


