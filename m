Return-Path: <stable+bounces-81544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4049E9943FF
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714B01C2190E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 09:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B21175D59;
	Tue,  8 Oct 2024 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gc3KtdYV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA716EBEC
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379136; cv=none; b=YzLUEN/aG7ee8ob/BqfAK8HuyOU6hUYTCM5FzSqPpibr+DV+oznQ/HWpB0Z8YTFWUlGmFxnuSa5jupns5XXGNpj1fEvn52HH42moSonYiqJSxAbi8hvR5tdWskJCbDnnh/XLw+kIQi7ZqApBzYjL/WvDeQGXHmSOI4/6meknS60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379136; c=relaxed/simple;
	bh=aElBsS5D/pxYAhWQRjfyKDWORbPpMeZdjhL7Pi9hYQQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hoomO/LbqAcxbVjKrzyQiwCtyCARtAZNqaKH1pJK3Lr1IN3R+rHt+5E09dAY3mIZNjYlW5kZ60U7WpK4Z+BdvRLwzJRh4pqqLdy0SIum35HZ4+EzfbWQjKzI//Pd0uXzaAQaxSRea1+K3R6YUNCfhjiyDmj6hzIF3SXbb7X04oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gc3KtdYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D5FC4CEC7;
	Tue,  8 Oct 2024 09:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728379136;
	bh=aElBsS5D/pxYAhWQRjfyKDWORbPpMeZdjhL7Pi9hYQQ=;
	h=Subject:To:Cc:From:Date:From;
	b=gc3KtdYVsX9vn0HLw8g+ce0OVd1oKyrb83ibxl3XAz+ZnXZnefNKiIUpo1jccO+jJ
	 6h4LZQa+nk5w1qUUjDMz3XP4TwyZSE9srv1RoyxRMvRxkTd5X1ssMFZpaRltJrexGn
	 KEbWo1iRmah7PaAl29px8T00j0ka7SIN1siDmIks=
Subject: FAILED: patch "[PATCH] drm/rockchip: vop: enable VOP_FEATURE_INTERNAL_RGB on RK3066" failed to apply to 5.15-stable tree
To: val@packett.cool,heiko@sntech.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Oct 2024 11:18:45 +0200
Message-ID: <2024100845-extradite-silencer-e137@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6ed51ba95e27221ce87979bd2ad5926033b9e1b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100845-extradite-silencer-e137@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

6ed51ba95e27 ("drm/rockchip: vop: enable VOP_FEATURE_INTERNAL_RGB on RK3066")
8e140cb60270 ("drm/rockchip: vop: limit maximum resolution to hardware capabilities")
3ba000d6ae99 ("drm/rockchip: define gamma registers for RK3399")
604be85547ce ("drm/rockchip: Add VOP2 driver")
b382406a2cf4 ("drm/rockchip: Make VOP driver optional")
540b8f271e53 ("drm/rockchip: Embed drm_encoder into rockchip_decoder")
1e0f66420b13 ("drm/display: Introduce a DRM display-helper module")
da68386d9edb ("drm: Rename dp/ to display/")
c5060b09f460 ("drm/bridge: Fix it6505 Kconfig DRM_DP_AUX_BUS dependency")
9cbbd694a58b ("Merge drm/drm-next into drm-misc-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6ed51ba95e27221ce87979bd2ad5926033b9e1b9 Mon Sep 17 00:00:00 2001
From: Val Packett <val@packett.cool>
Date: Mon, 24 Jun 2024 17:40:49 -0300
Subject: [PATCH] drm/rockchip: vop: enable VOP_FEATURE_INTERNAL_RGB on RK3066

The RK3066 does have RGB display output, so it should be marked as such.

Fixes: f4a6de855eae ("drm: rockchip: vop: add rk3066 vop definitions")
Cc: stable@vger.kernel.org
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20240624204054.5524-3-val@packett.cool

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 9bcb40a640af..e2c6ba26f437 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -515,6 +515,7 @@ static const struct vop_data rk3066_vop = {
 	.output = &rk3066_output,
 	.win = rk3066_vop_win_data,
 	.win_size = ARRAY_SIZE(rk3066_vop_win_data),
+	.feature = VOP_FEATURE_INTERNAL_RGB,
 	.max_output = { 1920, 1080 },
 };
 


