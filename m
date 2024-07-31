Return-Path: <stable+bounces-64840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB863943AAF
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E901C21635
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876A3139CFA;
	Thu,  1 Aug 2024 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8ZNe8qy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349E27447;
	Thu,  1 Aug 2024 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470999; cv=none; b=MzSwf3MTV6RTVRhiq2uiYleVY54SbEDracci6wS14769PQvM9otriWGBmlnH0bayFO/pI60JQDE7nrIatTOvm6wTg+mOHd178aPPr/1sQAdmjU+nJXh2wxOc/7nNfL8ksMhdE3ubMXn7nRpsZpJpBevVWMoA4LdC1MLrSY084HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470999; c=relaxed/simple;
	bh=fgiPoZwn9qiy3fBSpCl/aJUVApcDXGDJwFtJim0JWyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LT3tpfmJFokPLYLvZkdXDF17hWQRtFdOxh0e2SCZvpa0icLy/hL4RHep+dePuXdbekd75834+bZZfC2Biueqnn+DW/o/xH3qk50gcEarRg8+Ay9SLZKkKbzXaIguv/FxLEydaY1oX1b+4UBFHV+RQn54YTvZNlrtmP7eZwqd8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8ZNe8qy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B63C32786;
	Thu,  1 Aug 2024 00:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470999;
	bh=fgiPoZwn9qiy3fBSpCl/aJUVApcDXGDJwFtJim0JWyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s8ZNe8qyjqEjEbXd+mma1uZxDEUcDI0xnozori5w1SuvB+qeqR7/MKgDZAMbUEMpc
	 czqrKZJqyvfHtP6ZYMGUfkw1RCx/XUQtgC3Os07dA1vtHZb9nAT6zHpFjqKpAmdL4M
	 ZfjLDIymWpyHb9njX6oyv6Ussi4qn6ORaUEN2KK1f66RjwWUybS5fyA19nKEIFYpca
	 DPODOtK0+4LufdZkWHyuakJTYryrNewKQJ7prY9bZj5pnEcu6bei3yl/wBRgSMm0gL
	 BosHl5PHIBsfIlT3g359eeRx/THJdfexCj2NDIKa0LJr2ffL/Fh+/QbuQncGl+RHQK
	 162+AF/7IBD5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
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
	wenjing.liu@amd.com,
	wayne.lin@amd.com,
	zhikai.zhai@amd.com,
	arnd@arndb.de,
	cruise.hung@amd.com,
	ivlipski@amd.com,
	sungjoon.kim@amd.com,
	michael.strauss@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 015/121] drm/amd/display: Check index for aux_rd_interval before using
Date: Wed, 31 Jul 2024 19:59:13 -0400
Message-ID: <20240801000834.3930818-15-sashal@kernel.org>
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 9ba2ea6337b4f159aecb177555a6a81da92d302e ]

aux_rd_interval has size of 7 and should be checked.

This fixes 3 OVERRUN and 1 INTEGER_OVERFLOW issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 1818970b8eaf7..b8e704dbe9567 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -914,10 +914,10 @@ static enum dc_status configure_lttpr_mode_non_transparent(
 			/* Driver does not need to train the first hop. Skip DPCD read and clear
 			 * AUX_RD_INTERVAL for DPTX-to-DPIA hop.
 			 */
-			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA && repeater_cnt > 0 && repeater_cnt < MAX_REPEATER_CNT)
 				link->dpcd_caps.lttpr_caps.aux_rd_interval[--repeater_cnt] = 0;
 
-			for (repeater_id = repeater_cnt; repeater_id > 0; repeater_id--) {
+			for (repeater_id = repeater_cnt; repeater_id > 0 && repeater_id < MAX_REPEATER_CNT; repeater_id--) {
 				aux_interval_address = DP_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1 +
 						((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (repeater_id - 1));
 				core_link_read_dpcd(
-- 
2.43.0


