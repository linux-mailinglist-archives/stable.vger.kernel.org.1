Return-Path: <stable+bounces-46482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA9A8D06B9
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA7A1F240A9
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C1361FE8;
	Mon, 27 May 2024 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1q6Q5Oj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C917E8E2;
	Mon, 27 May 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825124; cv=none; b=bnFyprNavwWRPwv5AhRLjH7BSJ12RPPr3E48dXhCQqaCzZygd2eZ1tc+3d0xYHftZOeMpFUzgsr7rnMSsjmEifqkMMFNuMlINLcyok8lIxjc2f04eiRncIpUqw59LUq4yvN7rhUUK9dJ6Ku/RK2MIjH2vpKX/wkoW6darOI8B1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825124; c=relaxed/simple;
	bh=ypB96dWGLy8iJdOom+0sKyOXUXvjUh7LdOWWwNomkhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kp4Eqvk+3mA80absSV51IPqHFygGg09rRhF/BOGfEBK111+bmibnQJR/X5Svo/a7GNdvoQ7YXASOz5WrMK1Kosq+/vs8r2q+gkEvcYwoLXwF5+Dhz8QuSqdnTKlYjLBzfUSUnGsP6Pw4GjGcvQlLYo5RLU/OtqhzoHuFxOumTuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1q6Q5Oj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA1AC2BBFC;
	Mon, 27 May 2024 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825124;
	bh=ypB96dWGLy8iJdOom+0sKyOXUXvjUh7LdOWWwNomkhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1q6Q5OjK1vsT0wqFZozAZlZ+dDfHt9+4QrzpF1y2RPJCzlREzhr1upbPeJPvduun
	 taJr9bt2U08novDYtyV7QDcfu/fpZzr2GB91N2KWZ/ArA7g0/RZFblV550U7ReUIfb
	 9IKAshtH9byDCHL3v55N+s2YcmcgwvIDQLQITgWTdCISKDFPwocKJGkLndhsOKbLb8
	 jn9d8fct2IK+z0EgbBIiYsWk/w7sygueMit/lEVhvLhaOajNkjow7SEu4y8yejGVUY
	 EciQNazhb8gTjR37KVLt8Wg0xo9b0VzmxqVK99+GdwF0ZqdhHWvhlifXnffphGkZDj
	 s/BEAPHonjsXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Xi (Alex) Liu" <xi.liu@amd.com>,
	Daniel Miess <daniel.miess@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	chiahsuan.chung@amd.com,
	charlene.liu@amd.com,
	sungjoon.kim@amd.com,
	duncan.ma@amd.com,
	allen.pan@amd.com,
	danny.wang@amd.com,
	alvin.lee2@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.9 07/23] drm/amd/display: add root clock control function pointer to fix display corruption
Date: Mon, 27 May 2024 11:50:08 -0400
Message-ID: <20240527155123.3863983-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155123.3863983-1-sashal@kernel.org>
References: <20240527155123.3863983-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: "Xi (Alex) Liu" <xi.liu@amd.com>

[ Upstream commit de2d1105a3757742b45b0d8270b3c8734cd6b6f8 ]

[Why and how]

External display has corruption because no root clock control function. Add the function pointer to fix the issue.

Reviewed-by: Daniel Miess <daniel.miess@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Xi (Alex) Liu <xi.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 670255c9bc822..4dca5c5a8318f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -147,6 +147,7 @@ static const struct hwseq_private_funcs dcn351_private_funcs = {
 	//.hubp_pg_control = dcn35_hubp_pg_control,
 	.enable_power_gating_plane = dcn35_enable_power_gating_plane,
 	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
+	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn35_update_odm,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
-- 
2.43.0


