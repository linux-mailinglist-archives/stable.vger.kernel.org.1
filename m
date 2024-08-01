Return-Path: <stable+bounces-64959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10442943D02
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416AE1C2202C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E7F13D896;
	Thu,  1 Aug 2024 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atyeGyIv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC4815253F;
	Thu,  1 Aug 2024 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471734; cv=none; b=BZi6chxOG7RLozB8/BdLjajg5/J+FmVL0SW6gBHTwae7HQ7pwBINKxDAzWv3EydR3w2jTyGTwPPQXK3pdv0vz8X8OQYHjGEUf33is4aaRtvAhE8ClN1a1lO1tZ/2agu7Ccvfvaq/i/kE1nkL9Ph+7fmH2NCkU+7ovC2LwvHVj+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471734; c=relaxed/simple;
	bh=82yBQ9HMB3EWbKBAE5gC3b8YGIBzlQWgv+Awk7sMSTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFf8DMCFtnE97xXQzM1qFTI+M8wU+TyGITIrS6E+FanZnLowV6WpHIGrXGipcRalbs2Le478blqOuYm1UoHSNapI8JDeZS1idyywRvpxa0LGAn/062Sa35+iRgnDAJtnMbDYkB58PYLeqNnIgIIuzSXCPB1Ig1Xdxed0MTdnUhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atyeGyIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5D7C32786;
	Thu,  1 Aug 2024 00:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471734;
	bh=82yBQ9HMB3EWbKBAE5gC3b8YGIBzlQWgv+Awk7sMSTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atyeGyIv0lSWSCnNckQIuvsPCx6MpUgzWdZmQG9VX3/pDJEO8VR1o1PpLjixI3DGr
	 oSu7YkXu4TkP2gp5TBuqMTQuHHh6ig6OI9TQXhnncjUgGzIHJbq5zK6mMF8957Ju7N
	 65cMHOkA1Io6ySs7orz5DnXO7qJ27Xm1ZIORL4Fjz2bl9X8fzhxhqOcIf2c+lgSGRe
	 GXNb/LMZYImt5zgNCOicDjTqlageTc/ywunbjcixJKYUkkNOvKB9h+sdE+9tHPqXmk
	 2cG7YjiS6GliOW+Wxjx8lFxOpg3dzrFHuH50/9+HUoqrpHJ80juUOIwa1zjpSmchiy
	 rtL/UAie8Tc2g==
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
	hamza.mahfooz@amd.com,
	lewis.huang@amd.com,
	mghaddar@amd.com,
	ian.chen@amd.com,
	srinivasan.shanmugam@amd.com,
	Bhawanpreet.Lakha@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 13/83] drm/amd/display: Skip updating link encoder for unknown eng_id
Date: Wed, 31 Jul 2024 20:17:28 -0400
Message-ID: <20240801002107.3934037-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit efabdce3db9f3d306084c8946983f3d895810a6b ]

This prevents accessing to negative index of link_encoders array.

This fixes an OVERRUN issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 2c366866f5700..6fc0cb918b9e5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -408,7 +408,7 @@ static void link_destruct(struct dc_link *link)
 		 * the dynamic assignment of link encoders to streams. Virtual links
 		 * are not assigned encoder resources on creation.
 		 */
-		if (link->link_id.id != CONNECTOR_ID_VIRTUAL) {
+		if (link->link_id.id != CONNECTOR_ID_VIRTUAL && link->eng_id != ENGINE_ID_UNKNOWN) {
 			link->dc->res_pool->link_encoders[link->eng_id - ENGINE_ID_DIGA] = NULL;
 			link->dc->res_pool->dig_link_enc_count--;
 		}
-- 
2.43.0


