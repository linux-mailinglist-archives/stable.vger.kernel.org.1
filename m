Return-Path: <stable+bounces-65043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EED943DC9
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B1B2853A1
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27582189B84;
	Thu,  1 Aug 2024 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdCfUBxx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6860189BAC;
	Thu,  1 Aug 2024 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472150; cv=none; b=bvPbPwGVDw1evJ+hfhXsn3OQgtHAXS1Ky0jB10KrS3zW+lZtpClz9HCLo2UUcra7yZVPFl31fiN1DmjHtSNCR2dRdYz0dcXxiAbuPkR9OLvnAzcH2FJ4kSExY5dDONJgJPp2+toZFUuhV005wGQnZZB2UnhQ4wVzyDOnoWtfoFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472150; c=relaxed/simple;
	bh=fv1f1fLbBCDkLiL1oAGmxdCX7giF0BqILDwkHn88ax8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOPrZeqzYqZGFI8Ee+TMmTKwW7ZTR+5ekPnTcvgvBVMzh2fosVm0yG8BzYOaoqLqgjrbM+q+xOmOcA7d9xBrNQ9Uho8JxjH02sqb4HIxPUuw5vs0+zurwlDBO+iGsqpVVa8eIr77a6Sp/dDsusTXl8Fm2iKdqJFm0sgnPZp9qas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdCfUBxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCF5C4AF0E;
	Thu,  1 Aug 2024 00:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472149;
	bh=fv1f1fLbBCDkLiL1oAGmxdCX7giF0BqILDwkHn88ax8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hdCfUBxx4HGYa18/hWqrM73d0CPzyKkngiId3895FpVNtRCaNZDpOgvwg9mG+lB9g
	 smtcR1kif2Rfms/ScwAlMH1pLW5Ee8W0qv6dQDHK9bTUDMalHbAaq3DDn4GjBN13vq
	 c8Qxk5IF2TLLqadHRNXCN0mWOv3Mwx+FaRqglmnt5NyzzwJXdUHLGtVevuvKnvTatK
	 iRvWzGu4XQZ2c/O5bepZLUXGqQo/uvRuIc8ntNp6t4KcvrFE8ToqxbMdbgW9lJ72wu
	 izT9OgAqx/dWi4g+kq4RpX1HZobwgWNvG80p/itO5Wnvt7pqjQb1VqSvuJ5N8+KubH
	 hYxcPKl65kKdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
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
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 14/61] drm/amd/display: Skip inactive planes within ModeSupportAndSystemConfiguration
Date: Wed, 31 Jul 2024 20:25:32 -0400
Message-ID: <20240801002803.3935985-14-sashal@kernel.org>
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

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit a54f7e866cc73a4cb71b8b24bb568ba35c8969df ]

[Why]
Coverity reports Memory - illegal accesses.

[How]
Skip inactive planes.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 1070cf8701960..b2ad56c459ba6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -1099,8 +1099,13 @@ void ModeSupportAndSystemConfiguration(struct display_mode_lib *mode_lib)
 
 	// Total Available Pipes Support Check
 	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
-		total_pipes += mode_lib->vba.DPPPerPlane[k];
 		pipe_idx = get_pipe_idx(mode_lib, k);
+		if (pipe_idx == -1) {
+			ASSERT(0);
+			continue; // skip inactive planes
+		}
+		total_pipes += mode_lib->vba.DPPPerPlane[k];
+
 		if (mode_lib->vba.cache_pipes[pipe_idx].clks_cfg.dppclk_mhz > 0.0)
 			mode_lib->vba.DPPCLK[k] = mode_lib->vba.cache_pipes[pipe_idx].clks_cfg.dppclk_mhz;
 		else
-- 
2.43.0


