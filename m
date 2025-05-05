Return-Path: <stable+bounces-140787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2BDAAAF3A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0D91A8654A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4DD272E6E;
	Mon,  5 May 2025 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAC86Ai5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E702E62C3;
	Mon,  5 May 2025 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486259; cv=none; b=Ap9ibdDfvNbXm8tfMbY/K7PSxmlKvHBkRLCCyngS9RLIXqk074TqJhMrMH5TijwV/n9bctovaoDcHAbo4YiE9L67KmJ+EGBf58AQwv/Tp6JlnQfHPhVg3L+zwtArSAldO5UmHQ0SuGl40rICADX+uYHxBg6/yaSJy25baKWzEUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486259; c=relaxed/simple;
	bh=9jXK83eDDEbj9eepUBjb69Lo4Doz+C0DzdurWImoQwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g4a4tmUyiksdQZtzkPWxZlzmF09YIyVMkRGC66ORg7JjtkvreRhL/S9mLI1y/k849WYOQKQGQZeQMUJwZuxFPE6doJ1d8eQXqrkKfOgsBRwddkd/vz+jTWU9PIGRXekvAkwiRrMzDeKGS90ZH0Us2r0QiQOGEEECgKe1gOqYXys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAC86Ai5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F34BC4CEED;
	Mon,  5 May 2025 23:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486257;
	bh=9jXK83eDDEbj9eepUBjb69Lo4Doz+C0DzdurWImoQwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAC86Ai52Qv6d8OXPTauGEtDWgu2QMf2e2rMTyivpfJxEYsQZyNDCr3A0h8InONae
	 yGs2x6ZHTqVBkllbwkN+QEGxeqYITNX49psZfgznvLmVNTEcOQ8IGtRTdE7ayNzZbo
	 codDupLYGrrC8eZkOhO1FoAavBYTtewTebICG2ksRCpn2OFYMPwbgoEXpVUzXQ/gxg
	 OW3soDBr3BtWTRwAoNSt7X1+22x/ZgUORh1EIAWKPDmJ2jk4zRxiYykRzqJCYINFXF
	 rjY5RnsJPrlr0ZR0r2p7d//Bna0BEz2mor7qMbNb1GtZHu7zVWvITC2gqaZwTaIUuU
	 AkfKzW3zAJIvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joshua Aberback <joshua.aberback@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	rodrigo.siqueira@amd.com,
	Alvin.Lee2@amd.com,
	dillon.varone@amd.com,
	alex.hung@amd.com,
	Austin.Zheng@amd.com,
	chris.park@amd.com,
	rostrows@amd.com,
	yi-lchen@amd.com,
	PeiChen.Huang@amd.com,
	aurabindo.pillai@amd.com,
	linux@treblig.org,
	Samson.Tam@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 227/294] drm/amd/display: Increase block_sequence array size
Date: Mon,  5 May 2025 18:55:27 -0400
Message-Id: <20250505225634.2688578-227-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Joshua Aberback <joshua.aberback@amd.com>

[ Upstream commit 3a7810c212bcf2f722671dadf4b23ff70a7d23ee ]

[Why]
It's possible to generate more than 50 steps in hwss_build_fast_sequence,
for example with a 6-pipe asic where all pipes are in one MPC chain. This
overflows the block_sequence buffer and corrupts block_sequence_steps,
causing a crash.

[How]
Expand block_sequence to 100 items. A naive upper bound on the possible
number of steps for a 6-pipe asic, ignoring the potential for steps to be
mutually exclusive, is 91 with current code, therefore 100 is sufficient.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/inc/core_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index eaad1260bfd18..4b284ce669ae5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -532,7 +532,7 @@ struct dc_state {
 	 */
 	struct bw_context bw_ctx;
 
-	struct block_sequence block_sequence[50];
+	struct block_sequence block_sequence[100];
 	unsigned int block_sequence_steps;
 	struct dc_dmub_cmd dc_dmub_cmd[10];
 	unsigned int dmub_cmd_count;
-- 
2.39.5


