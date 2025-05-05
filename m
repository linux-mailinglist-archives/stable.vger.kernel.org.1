Return-Path: <stable+bounces-140584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED66AAAE41
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53518462CA4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D150B2D997F;
	Mon,  5 May 2025 22:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVC1focn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E121D37318F;
	Mon,  5 May 2025 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485221; cv=none; b=orKfJWiia8fsxcVR5P58vjoA7PLaI6WNfOP4u1E3sG8yW1VyTqIjaaXhZDzrm48wa3QUNXKjHARx0vy+phRKi+rihfOOE0tgV2p77su6vAJqn34PZyj8zcoKzUXeZXynELYe/rExuazrw2QPfApE7O4m86DD55lQ8rmjtDnINyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485221; c=relaxed/simple;
	bh=xUeYcQ19WA4YDx8LAq/eonv8hTGDCBs6kyGHFjgYn2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cz4enUSMuu0+ExTx+msYZHooADOFlgZBHYWIelu5PH6aEbu8BKCE5Laa2r+MxmHm7kRH3lEa+hvB3ug/S7sUUKsABbZ8o9p2J6mWav6uTgUPgDJ2fxyzQc0vUDvpBSEV6lMo9nrlFrdudAc/bH1uirdKFzWJJPq63pSsB4CdoN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVC1focn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A59C4CEEF;
	Mon,  5 May 2025 22:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485219;
	bh=xUeYcQ19WA4YDx8LAq/eonv8hTGDCBs6kyGHFjgYn2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SVC1focnSfOqZWvnrLY1O0YZC8D4IY1SU8ksD8H684bbhCRyy5IPBMpeg2C38QAAh
	 IZLjkYtagQ0ocTV0ALnJCy15ic8tw+BMmN4ScNYrHRmXngoZvCg4vZtQduOxf3+fmK
	 JAE8cM5/pxAH5HyPs4MP1ChzKOPxL0/utJwucl0OaBzv+XAAx71v9yKqGCCWvmR++l
	 hH4COtgQDvclWYJBLFSgnQlcwFlZ7Mn1Q4zIQtiLFtoZJgOFDi5F4rr0RL/a+dLOcX
	 6iRlAOUaQ0nxrVFH939r1iEv0DwRXfbi/vZYDcZ3Ln01RNiNW1Qgd1pfITBCqwB8vr
	 EiIUF794Belyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Yan <andy.yan@rock-chips.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>,
	hjc@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 217/486] drm/rockchip: vop2: Add uv swap for cluster window
Date: Mon,  5 May 2025 18:34:53 -0400
Message-Id: <20250505223922.2682012-217-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Andy Yan <andy.yan@rock-chips.com>

[ Upstream commit e7aae9f6d762139f8d2b86db03793ae0ab3dd802 ]

The Cluster windows of upcoming VOP on rk3576 also support
linear YUV support, we need to set uv swap bit for it.

As the VOP2_WIN_UV_SWA register defined on rk3568/rk3588 is
0xffffffff, so this register will not be touched on these
two platforms.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net> # on RK3568
Tested-by: Detlev Casanova <detlev.casanova@collabora.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20250303034436.192400-4-andyshrk@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 5880d87fe6b3a..2aab2a0956788 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1432,10 +1432,8 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 
 	rb_swap = vop2_win_rb_swap(fb->format->format);
 	vop2_win_write(win, VOP2_WIN_RB_SWAP, rb_swap);
-	if (!vop2_cluster_window(win)) {
-		uv_swap = vop2_win_uv_swap(fb->format->format);
-		vop2_win_write(win, VOP2_WIN_UV_SWAP, uv_swap);
-	}
+	uv_swap = vop2_win_uv_swap(fb->format->format);
+	vop2_win_write(win, VOP2_WIN_UV_SWAP, uv_swap);
 
 	if (fb->format->is_yuv) {
 		vop2_win_write(win, VOP2_WIN_UV_VIR, DIV_ROUND_UP(fb->pitches[1], 4));
-- 
2.39.5


