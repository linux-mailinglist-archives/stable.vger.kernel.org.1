Return-Path: <stable+bounces-95056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A97C9D72A5
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E84285CC6
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92EB1D5AAD;
	Sun, 24 Nov 2024 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3pLz6QC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C2A1D5AA3;
	Sun, 24 Nov 2024 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455841; cv=none; b=BDCnKKEWGQap1wSz3X2sFCMPTOhD5id8Y/0QRvvdo626rD1VE5R/G/S1YopBJMMJzlDDIu6Y7Z4SEuBwL9XcGMaLG1gxA8b4A3lTnEzbQDNAg71XttJbKMgqp2fNKXbkYJAGs6P129vFuyWnssZsaXYKFhC4Yy8bsBwm7Z1/86M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455841; c=relaxed/simple;
	bh=du1Bt53xiLW4ccF1yhrtiFQnbnCJCIvDdLzQKDrzXw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLTgXpgDQUR0rF3ckLCmgGMNgf14qWiQz6X4weDKOhCTla/aTwP3z0fhzqEHbSsK4yYW2+RoT1a3XofaThXSBdH+43EqPStHvEvgR9sgM8slQNp4HtaPA2WPscpGyLKCYDqlH56uSN4RfnpDuDnrBG+PrtBf4A6H5Ufk7/aDJJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3pLz6QC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A595CC4CECC;
	Sun, 24 Nov 2024 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455841;
	bh=du1Bt53xiLW4ccF1yhrtiFQnbnCJCIvDdLzQKDrzXw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T3pLz6QCVCzCPhrsrhfnJsxury7oBHNRQuHr2GlI5hrFtdzCOguZM9nTlCGKxm/WC
	 ownkwJ5+45A5BXS11PJREsHWD3ap4Ai32oj0VlecotmmMBYgJXSYopTYoAdcoa8TVZ
	 2u0tZ8UuHSCMINwg5F5BjmRbu2pbVyzdIhrn0ub1eyDup8HEB6ceTnzMEfZXCfWmiC
	 z5Lr7JV2ELRuOCNzLaPxWOTutgWGy8+uowVOHpAdQN5WVkbyIkRTGZ+En8UUQjolOO
	 bqmb7cdeg7r8UlQBk9UcbRNzOTNYBFZ8emWZSITWO04sOx8Cb62LXUlOoXCrDeXSp+
	 shtofyV081C3A==
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
	aurabindo.pillai@amd.com,
	Samson.Tam@amd.com,
	alex.hung@amd.com,
	joshua.aberback@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 53/87] drm/amd/display: Fix underflow when playing 8K video in full screen mode
Date: Sun, 24 Nov 2024 08:38:31 -0500
Message-ID: <20241124134102.3344326-53-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index ef0150a258b12..49d9e4d7b911e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -862,7 +862,7 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 	plane->immediate_flip = plane_state->flip_immediate;
 
 	plane->composition.rect_out_height_spans_vactive =
-		plane_state->dst_rect.height >= stream->timing.v_addressable &&
+		plane_state->dst_rect.height >= stream->src.height &&
 		stream->dst.height >= stream->timing.v_addressable;
 }
 
-- 
2.43.0


