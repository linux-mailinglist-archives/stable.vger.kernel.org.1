Return-Path: <stable+bounces-64841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88786943AB2
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391EE1F2281A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA6614E2E3;
	Thu,  1 Aug 2024 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXecAyAL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6956513A244;
	Thu,  1 Aug 2024 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471004; cv=none; b=u7+2Kc+WGq/A+Pdj15g08tdyGJ9zgDaDZtoZjukNokNMcZsJ2KG5KmrOXN8aqif3nqwgP0vLRhzoUlZNUccwMMYV6VANMiZU10YGsw/CYeXljw65zg/zNpbKmADLjSvSjYiL1gPrlGt90ObG0PHVnaaUTE+goGqaK3DHH03+KKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471004; c=relaxed/simple;
	bh=arEer1dFqmWmtbAkxJOM64J6aTbELKyZiNwZtZtziE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcLbjmrB6aRMPUZzh4sggyA1QA6xMJWDBlHIoEkGh1HO0HRetDOT12vuFiDTAklWtz8khqEFTrlIiMlvgWHGYRRV5aRlL7sYJxvq3ROUfFvFS9ZRz95XyOLaxjbTYgJfdF4faYgLaVk+tuvWAoYxezNWyLHdd/SIdUf0zZjt7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXecAyAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED8FC32786;
	Thu,  1 Aug 2024 00:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471004;
	bh=arEer1dFqmWmtbAkxJOM64J6aTbELKyZiNwZtZtziE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HXecAyALU8Fgjiz2RnM7GV1Adcr2k5coesxkvoccIwvGM6WMp4ukhX4VMb+o+v0po
	 ieMeM+HY2Envd792HyXj52699KfJU8uoerMVserdKKjLOZhDXnx6tXJ52wkjc8YtV7
	 z6z7VE318F1q5HYYrx/KsCG06yApdcbXAucZ865gjvY4pTrp9aC45e5OZvBDymsC9b
	 ReZSAVIBdrGvgwgUiDJVoTrxKr2y8tHPMNcz6kJg3yl7TD0vDoHCh2T4PcH4WM1VsN
	 Cg4J8gcq0xoeb6Prw9D1w30JEBFOgerCDtk3zm7pm2WjeooHrgCfrgixMf2vOi379I
	 kPneJm5atQDZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
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
	srinivasan.shanmugam@amd.com,
	hamza.mahfooz@amd.com,
	lenko.donchev@gmail.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 016/121] drm/amd/display: Add missing NULL pointer check within dpcd_extend_address_range
Date: Wed, 31 Jul 2024 19:59:14 -0400
Message-ID: <20240801000834.3930818-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit 5524fa301ba649f8cf00848f91468e0ba7e4f24c ]

[Why & How]
ASSERT if return NULL from kcalloc.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
index a72c898b64fab..584b9295a12af 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
@@ -165,6 +165,7 @@ static void dpcd_extend_address_range(
 		*out_address = new_addr_range.start;
 		*out_size = ADDRESS_RANGE_SIZE(new_addr_range.start, new_addr_range.end);
 		*out_data = kcalloc(*out_size, sizeof(**out_data), GFP_KERNEL);
+		ASSERT(*out_data);
 	}
 }
 
-- 
2.43.0


