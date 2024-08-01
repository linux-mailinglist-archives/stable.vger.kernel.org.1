Return-Path: <stable+bounces-65111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871E6943EAF
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3509D1F226C8
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1E61A4B56;
	Thu,  1 Aug 2024 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChuavGD5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E51814B947;
	Thu,  1 Aug 2024 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472474; cv=none; b=tIdK8xO+6IrU+SbaCrNWN0BipJDCaGJ+r1rJ5Hd4uwZ5aZZzMm52PnEA72sq/z33EB+bx8ldHtcQoGjDsvOsCyOERC2mJ3JJoF8XOZyl/fmsh2wyqksV9USXHQ+pdE6tB+hGJ9shjLbGXF2H6dKkS7qeVRv6gr47n/cHTjO2nKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472474; c=relaxed/simple;
	bh=7V/Z4AoShq9paLdlzPWed8ZdB76kr/7LaYu3OlHA7uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqYNIVDuAENK34FJlzxOim6qyz7yQSJq4aXG3VsyBJmKecksUwjN7s7uOhGyLMzCCJfNRVd+ZDegUqPmP3DirClthNqWCFeQdBAzAEgvklmPwknByT5i8yv0nl55NFCxGhwNaODGyPkNougvCSLBaz2RW3fT6Jx1kErHOCmaP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChuavGD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFCBC116B1;
	Thu,  1 Aug 2024 00:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472474;
	bh=7V/Z4AoShq9paLdlzPWed8ZdB76kr/7LaYu3OlHA7uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ChuavGD5tsZb3+rQFC5kaFU/RcNH5iyg6OltyIonU+BeXVx4e+JqBeFYoqE4itdip
	 unb4PULYWgGQ/czvBSswi6zOx9MxRlbwlw/piDEn79S5V3WFEvc70VHqaPR7YYjhlK
	 d05D1IijC4iReqmEPKz8RlISnocloQVCxaIWlQfLDOYf2Ey0WP+z/qTqo4GEK2ztla
	 o9Df9N0W9flPKPZPSeUZt72QmIt/MgRwrhbv+xlE1bDgE1+VXu0T9LwSB/qG6L1wbh
	 TsX4Qm0oJTv3AMGAQVKIVax/rbo2U0z1NkxRcX3qW3C/JCNyr8LuzOTvODg8unt0Xq
	 9Em14qFKB34IQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	tao.zhou1@amd.com,
	Hawking.Zhang@amd.com,
	felix.kuehling@amd.com,
	lijo.lazar@amd.com,
	candice.li@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 21/47] drm/amdgpu: the warning dereferencing obj for nbio_v7_4
Date: Wed, 31 Jul 2024 20:31:11 -0400
Message-ID: <20240801003256.3937416-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit d190b459b2a4304307c3468ed97477b808381011 ]

if ras_manager obj null, don't print NBIO err data

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 74cd7543729be..af1ca5cbc2fa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -370,7 +370,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		else
 			WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
 
-		if (!ras->disable_ras_err_cnt_harvest) {
+		if (ras && !ras->disable_ras_err_cnt_harvest && obj) {
 			/*
 			 * clear error status after ras_controller_intr
 			 * according to hw team and count ue number
-- 
2.43.0


