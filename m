Return-Path: <stable+bounces-139999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62829AAA387
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F8F4631DE
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7679D283FFD;
	Mon,  5 May 2025 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/ffQbya"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3124A28467C;
	Mon,  5 May 2025 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483865; cv=none; b=d2wDKH3vk59jm3u8HsaahZHWPsVZDUZdoAMHEKrMtMaEHAWYRnbFZSNLApakktIxk7eNWMGdIWQEKNMR8tAaZeqxcbYmgDOU3e5qXkQ7MmscQR09jXImwB2j2rIfthRpjee8/3fCIMnUJHo1T5Jil+vyluVEWYkvKXVgumadLhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483865; c=relaxed/simple;
	bh=xF8SmHu4JDO2uxxWJ+km3PqAGMefMdeEyhaIJCZaJu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XIXujLl57obrN2GK9NsuJio6qt3cnLnu4mh3aVHUV9zFbYej7y4WxlmnbjU3f5RRTPyPmXjCNH5w32cycvLmkgfjsi5FUTdLsuvM4yzU3hf1NudcpFjpwEm4rtUc+i++YZ6UvbhTH45e9XVoFSscEjt8AJld3aQqjNSxCQe+rlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/ffQbya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AF6C4CEE4;
	Mon,  5 May 2025 22:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483864;
	bh=xF8SmHu4JDO2uxxWJ+km3PqAGMefMdeEyhaIJCZaJu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/ffQbyaFlOSywDkmPigan83H+IfUfk1jL+xE0uhCdviw5MVWsPS+yotIPcCdJiT7
	 ZUopYKKbmcC7PsO0arGsFALDfIf2/iyj7kWnu1yuvjo1uKXyO3qCFwrTdbRDZMWo8t
	 F6nHOaUFtjJln+6GdCm2BvyF+YvxdYUzUsPHCgluT6ON+p5lWn4/Mm8/8CJ+YkhS/J
	 IekuslfyBi1V1vGZu9kyfxKG28otqFiHF/edxqgrkeBe1QIXxqwUwzWbeZ4rGX0QBx
	 zIi0guKl5uHThRG8I7KovfQXP34IzQkT+7I4F491N6Yvt0+N7ecx6cOEdL/W/YPGBz
	 51Doju6S0hmeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dillon Varone <Dillon.Varone@amd.com>,
	Aric Cyr <aric.cyr@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	chiahsuan.chung@amd.com,
	Alvin.Lee2@amd.com,
	alex.hung@amd.com,
	Leo.Zeng@amd.com,
	Ilya.Bakoulin@amd.com,
	Iswara.Nagulendran@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 252/642] drm/amd/display: Fix p-state type when p-state is unsupported
Date: Mon,  5 May 2025 18:07:48 -0400
Message-Id: <20250505221419.2672473-252-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Dillon Varone <Dillon.Varone@amd.com>

[ Upstream commit a025f424af0407b7561bd5e6217295dde3abbc2e ]

[WHY&HOW]
P-state type would remain on previously used when unsupported which
causes confusion in logging and visual confirm, so set back to zero
when unsupported.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index a49604b7701f7..1406ee4bff801 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -563,6 +563,7 @@ void set_p_state_switch_method(
 	if (!dc->ctx || !dc->ctx->dmub_srv || !pipe_ctx || !vba)
 		return;
 
+	pipe_ctx->p_state_type = P_STATE_UNKNOWN;
 	if (vba->DRAMClockChangeSupport[vba->VoltageLevel][vba->maxMpcComb] !=
 			dm_dram_clock_change_unsupported) {
 		/* MCLK switching is supported */
-- 
2.39.5


