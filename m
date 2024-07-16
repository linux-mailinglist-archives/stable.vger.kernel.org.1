Return-Path: <stable+bounces-59433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A4393289C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8368E1C2040C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C712919E822;
	Tue, 16 Jul 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFMmhCbs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312019E7F7;
	Tue, 16 Jul 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139997; cv=none; b=l5ZeXv5RPouE+LhA4IoC16mUzeNccQQimoeeFGfxLRc6Y8hTbU57o/wagF2crVyboBsLnlKE4xQXb0pz/XUF3/PvINjwmIVh/M2BFdYEVoCfJ6gy14THZoCEUhd34qUcNCeAGAtAFONDTKx6j+vbtFSnYvjOXXlt4PKlHB+OW84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139997; c=relaxed/simple;
	bh=hPiZBpPQPKfm8zysLlxT6NXhGRC5lcxwMo3vnGpL6WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyBjVrmGd0FAE0DXbwZiwpkuS4idnPmPt3Yowdm6Ol8Kew+2CpSl6RMzcytton+wVWaK0T4fmsJxdIcBRwqr7C3HGsWXyTUI6u6k29BLRfOnrQrdnqVjbQz1m6fO8+BLhcK4zkckDEXrNmG5MyhdIiLzpDJsH2qPGovejoNrIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFMmhCbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC02DC4AF0E;
	Tue, 16 Jul 2024 14:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721139997;
	bh=hPiZBpPQPKfm8zysLlxT6NXhGRC5lcxwMo3vnGpL6WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFMmhCbstn1AvcBA/LAqoz6g8+mJCDIfah9U5BZzoqhSOJ+Gb3xqkonrNEoFC7zSa
	 422E3qjhlk210WZuQCtA0QBNkNlRWqMO3UDb/RDccAeeN6EbtE2eMXYeBQPMZ08Hx5
	 ohDAfBp/KFI2tC91ppKpMaAB+K/kxB4C/gSuM6B9JfCwmSdn6JESBzOSFlSu92bNAE
	 q1or4fN8akQXL/0hOHoYXggIaROOjE2eVcG1r+C6ICogRzVJveAzu5JzzzRArB3Npg
	 XEmHpvX2wXwt+dv15cR7pTzOXlw6QjxMK5bcqBXPqltKW3zGTCvnQaMgPFspW2obkb
	 7fjjYIP1qG9jQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.9 17/22] drm/radeon: check bo_va->bo is non-NULL before using it
Date: Tue, 16 Jul 2024 10:24:24 -0400
Message-ID: <20240716142519.2712487-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142519.2712487-1-sashal@kernel.org>
References: <20240716142519.2712487-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.9
Content-Transfer-Encoding: 8bit

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

[ Upstream commit 6fb15dcbcf4f212930350eaee174bb60ed40a536 ]

The call to radeon_vm_clear_freed might clear bo_va->bo, so
we have to check it before dereferencing it.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 3fec3acdaf284..27225d1fe8d2e 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -641,7 +641,7 @@ static void radeon_gem_va_update_vm(struct radeon_device *rdev,
 	if (r)
 		goto error_unlock;
 
-	if (bo_va->it.start)
+	if (bo_va->it.start && bo_va->bo)
 		r = radeon_vm_bo_update(rdev, bo_va, bo_va->bo->tbo.resource);
 
 error_unlock:
-- 
2.43.0


