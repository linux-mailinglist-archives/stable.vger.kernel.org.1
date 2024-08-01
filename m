Return-Path: <stable+bounces-65069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D0A943E07
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42E42824B2
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3BF1953B0;
	Thu,  1 Aug 2024 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUBFS12r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37533149C6D;
	Thu,  1 Aug 2024 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472239; cv=none; b=aIqSidCB+EhybTqInpdZUl73OCgGK2hDJFlW87KnfuttUgaaiK+YLcw/KBukiOO6PcRGV1rM+RYTrLUje7bx+3/sRsoGIZ/w11bU14wv5SLTCp9DRanqrLF30MS5AmWW8f/v/D8t9c5xrFMupWGeK7XtoSEeVhiY2XRPqqR8rgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472239; c=relaxed/simple;
	bh=LpoCdwaWUoRWBE+x1GDSw7i3LrDW4M8O7ykQsCghiWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o55uKMC7uEPk0vYPCj7Bptwiqk88xNUa+/+8AImtA/OVlvOpVn0J5U92Dr4YX2WvNvK7VLz8DKdcPOYxljWTsTBbXuF4Unk9+4+0IQtFUiAEyf/6Ld/44vWYafJEj6tCFdVLojPpi3UWcUdBQkkfY2Nk10JeCtzjtMXYcTEr6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUBFS12r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726C6C32786;
	Thu,  1 Aug 2024 00:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472239;
	bh=LpoCdwaWUoRWBE+x1GDSw7i3LrDW4M8O7ykQsCghiWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hUBFS12r6L4V1Wwk+YJAYGG0MLPAA+oJwt4wX1a3zmfUj1EOiFZNlKoyHtUKo5uoT
	 pwoxhAUp7V1eq+t8zP8KR4e40wYZXT5WgdmDvjY7w1OEQYFGvIo1t+8VQVmbsNoVNf
	 LenyhwmMw7rIGtxN8S4GeS0yN2GB3cTWtEXMx0JWUyTdfdfOEeisSfR01xDwFDe/xA
	 ZuuhdAFKMO/jtEGqu6jjazE9iI5Lz65ZZdIX6KINSFask5fi6n2dIsg3dsbQ3OHVBC
	 CvGLRCz9LVEt/KkF0HHAR7jiZUch9L0ezm8ktNsgL+EYG2ScG3S/f92A8QqA1h93QB
	 9hKpBKK3ZDy+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wayne Lin <wayne.lin@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
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
	alex.hung@amd.com,
	mwen@igalia.com,
	joshua@froggi.es,
	mario.limonciello@amd.com,
	Roman.Li@amd.com,
	Bhawanpreet.Lakha@amd.com,
	rdunlap@infradead.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 40/61] drm/amd/display: Correct the defined value for AMDGPU_DMUB_NOTIFICATION_MAX
Date: Wed, 31 Jul 2024 20:25:58 -0400
Message-ID: <20240801002803.3935985-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Wayne Lin <wayne.lin@amd.com>

[ Upstream commit ad28d7c3d989fc5689581664653879d664da76f0 ]

[Why & How]
It actually exposes '6' types in enum dmub_notification_type. Not 5. Using smaller
number to create array dmub_callback & dmub_thread_offload has potential to access
item out of array bound. Fix it.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 2c9a33c80c818..df18b4df1f2c1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -49,7 +49,7 @@
 
 #define AMDGPU_DM_MAX_NUM_EDP 2
 
-#define AMDGPU_DMUB_NOTIFICATION_MAX 5
+#define AMDGPU_DMUB_NOTIFICATION_MAX 6
 
 /*
 #include "include/amdgpu_dal_power_if.h"
-- 
2.43.0


