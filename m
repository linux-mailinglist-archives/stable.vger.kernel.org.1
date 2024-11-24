Return-Path: <stable+bounces-94963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D549D7189
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701FB287342
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FB61B0F29;
	Sun, 24 Nov 2024 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiRaPziq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009551ADFE2;
	Sun, 24 Nov 2024 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455432; cv=none; b=r8HkW/ckWGgVLqPtP/CgSG4JEP1nIM4FXDWO5vRJTR4Y0CFSp3RAbwt1b3mMDAZBlQMTBlWT4Ckv33EJk0T/FrgEZzQHXlHEnKTsQnpTxXd95ujQ6oADaJdqn56frq2s4t+hvW6r53xG+U1Hw4qrUEPn+XoKYFrU2iuz/9nR+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455432; c=relaxed/simple;
	bh=DqWiCfpkrzTx2envKHNBpAO1sH0IGlyIeYuu6hZ0jJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XA8iFkdHM6cxmlZaAzpuFbqsQWRdueqOzEuFIX1k7uAJuRU+oMJLleYGeFln4cxRQehxBWQvbcDyr6Ni3VVMRzY5Vig7Uz8uVcTzvraFge1iYi7LSAbRv+ZAgpwUrcFGsi6ULGaAgI2vUxp8r7raxMEXl1tmalQBlN4u+a8bBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiRaPziq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EE7C4CECC;
	Sun, 24 Nov 2024 13:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455431;
	bh=DqWiCfpkrzTx2envKHNBpAO1sH0IGlyIeYuu6hZ0jJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BiRaPziq31VWRl9Hskl+THHZ5X2w16QQ5ABPp2CdKLbcBIZSrc5auJaD1ph8SYaP1
	 y2CxlRkAJqzQ3bK3HKlvJ89fqSGVyyPSHSfueEItjNiU2XawJbDU/NTSjFoxIbHZeb
	 hWUfJnijKBSXSpLhgAhg/allSfbJNpwm4FSmPJI7mUYqUqPi5EuIR+Llnk/dAhva0E
	 17VERAVVE2IxO3rUKWaLueg6GrACngVFzxHSeYJiGJOwkavLw1bloHHp7xxjQKhWzI
	 rQpGypoMSnQM7W0aEOr2Xaz/NzqobQhxuP8t07/gGBAd+frtBvOC/j/yIzvrESLZqx
	 y4fLcmYS7dccw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leo Ma <hanghong.ma@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	chaitanya.dhere@amd.com,
	jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Alvin.Lee2@amd.com,
	Samson.Tam@amd.com,
	aurabindo.pillai@amd.com,
	alex.hung@amd.com,
	joshua.aberback@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 067/107] drm/amd/display: Fix underflow when playing 8K video in full screen mode
Date: Sun, 24 Nov 2024 08:29:27 -0500
Message-ID: <20241124133301.3341829-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Leo Ma <hanghong.ma@amd.com>

[ Upstream commit 4007f07a47de4a277f4760cac3aed1b31d973eea ]

[Why&How]
Flickering observed while playing 8k HEVC-10 bit video in full screen
mode with black border. We didn't support this case for subvp.
Make change to the existing check to disable subvp for this corner case.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 8697eac1e1f7e..6c9e1a10911e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -859,7 +859,7 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 	plane->immediate_flip = plane_state->flip_immediate;
 
 	plane->composition.rect_out_height_spans_vactive =
-		plane_state->dst_rect.height >= stream->timing.v_addressable &&
+		plane_state->dst_rect.height >= stream->src.height &&
 		stream->dst.height >= stream->timing.v_addressable;
 }
 
-- 
2.43.0


