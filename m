Return-Path: <stable+bounces-141522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776CAAAB445
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A956F3A6893
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4711138253B;
	Tue,  6 May 2025 00:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYcNVUUM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30217381E1A;
	Mon,  5 May 2025 23:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486583; cv=none; b=GHvXMuHHmYrW1D/mTc4zud9iudMAzwXgHlTPRMB8u0Hn4I+XzteNMFlzQPZTNfQeS81F2f1GJn5rmend1R2JkLo6r9mK8ffuVcryX9d64FEk7vjQQS6gYSTM3ADp1VPJagWZw877s59geV/l6iUUoU4DafpkFTm5S1ud6r+OzGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486583; c=relaxed/simple;
	bh=5vqwOQMoxkHQre/5nMOtaa2tCID368xye4ecQUKhAzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CioVwph0BRt3B2vWRVk32TKxDl4qJhAdJ+NYqBeSf6L/neyBej9+B3f6STbFMcwTSEB4eAm76regud0faEJiElbIuNaXqyMyKD3AboibnzGBWHpr6wUFK5INUrb6pCvhf3qjuZC58CN7SRpZ+7XuyZq+ZMXO9aGWNROq0H88zZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYcNVUUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF809C4CEE4;
	Mon,  5 May 2025 23:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486580;
	bh=5vqwOQMoxkHQre/5nMOtaa2tCID368xye4ecQUKhAzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IYcNVUUMDNmC+qB5lZuYkL8KUJaoHgXTwSWHwCrNjkrM9XLuKeCZJY9+7U/KmxUC6
	 3dWuobqrKLl/yXlTxnU0wgVqcIFrsDfU9lyynHE6axP4CAeN/fuyY/pSR+cGKTl8tf
	 Lpmn3qwmcWFrGD29Lukb3LAwN11xF81eSmr29p/zwscGspBEwbYG5B/vOnawrvmiUf
	 q659jHimfwwiUIOtbTTsaUmUJIlvCZMxU4dE007O6uJESu9OWzl7fmkvjZ2EE9B+Eh
	 VFSiDrX0yL6EIsX3WP+c0xNeVZ1kurw6q37dvYrclBCFs7I8SKeUl8fEh/TjDPbs5v
	 hOWFgjxjNFhmg==
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
Subject: [PATCH AUTOSEL 6.1 100/212] drm/rockchip: vop2: Add uv swap for cluster window
Date: Mon,  5 May 2025 19:04:32 -0400
Message-Id: <20250505230624.2692522-100-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 955ef2caac89f..6efa0a51b7d65 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1289,10 +1289,8 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 
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


