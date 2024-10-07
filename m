Return-Path: <stable+bounces-81348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45071993166
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BB91C23631
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A2E1D90D7;
	Mon,  7 Oct 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tahoicb+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038241D90A3
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315379; cv=none; b=G3V+xjmbpJwk2+33D2VzYrL0hnKPY1RsCHat04b8IgnJKKbdGXpC5oAxcBP25DYDEOLVHxct8fOXdamM0E/y6XF3/Vi6wEL2XSlTvGmdUbtbJYMAA7y7IG2EMQj9hMj6bzNJVdq9m7LcP78KIXT2W0BI4omV97Wl84aWxG8tjR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315379; c=relaxed/simple;
	bh=d0GXo3oXBzk9TdH+hLIZ2DVaREj7+azlgG32EWfAgB4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NnqvfOeND2IJAvs2uP8bbao5L/wp47Vk+sEgHEqLF5he4CcO/mygGxbNfTFkrLEaH75t/2WzeiObFzmXabG6MhQjPKMQCSZlaEefXbXOQhxXnWUimbn3s9R5MME46CTzyP6fnV4ofcp8h3WTw/2kz7BwjWaZl5JwubEDhvord98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tahoicb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B94AC4CEC7;
	Mon,  7 Oct 2024 15:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728315378;
	bh=d0GXo3oXBzk9TdH+hLIZ2DVaREj7+azlgG32EWfAgB4=;
	h=Subject:To:Cc:From:Date:From;
	b=tahoicb+c07UOfakq4q23XLgdKCTWZ5o+8ExCToHO6rKBliL5LzaG8hs8onFXmH66
	 kWjPrwEpfQEhRPAqFJCkbGZ0GJ0BjxTxyGkWUrnu6AMgev5TplKvImEZQRZCcrEbnd
	 LjfUeKi8WJ4/0qX0M5qz96pCnxwnMYmBCH2g1iBA=
Subject: FAILED: patch "[PATCH] drm/rockchip: vop: clear DMA stop bit on RK3066" failed to apply to 5.10-stable tree
To: val@packett.cool,heiko@sntech.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 17:36:07 +0200
Message-ID: <2024100707-camping-hammock-c18a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6b44aa559d6c7f4ea591ef9d2352a7250138d62a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100707-camping-hammock-c18a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

6b44aa559d6c ("drm/rockchip: vop: clear DMA stop bit on RK3066")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6b44aa559d6c7f4ea591ef9d2352a7250138d62a Mon Sep 17 00:00:00 2001
From: Val Packett <val@packett.cool>
Date: Mon, 24 Jun 2024 17:40:48 -0300
Subject: [PATCH] drm/rockchip: vop: clear DMA stop bit on RK3066

The RK3066 VOP sets a dma_stop bit when it's done scanning out a frame
and needs the driver to acknowledge that by clearing the bit.

Unless we clear it "between" frames, the RGB output only shows noise
instead of the picture. atomic_flush is the place for it that least
affects other code (doing it on vblank would require converting all
other usages of the reg_lock to spin_(un)lock_irq, which would affect
performance for everyone).

This seems to be a redundant synchronization mechanism that was removed
in later iterations of the VOP hardware block.

Fixes: f4a6de855eae ("drm: rockchip: vop: add rk3066 vop definitions")
Cc: stable@vger.kernel.org
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20240624204054.5524-2-val@packett.cool

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index a13473b2d54c..e88fbd5685a3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1583,6 +1583,10 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 	VOP_AFBC_SET(vop, enable, s->enable_afbc);
 	vop_cfg_done(vop);
 
+	/* Ack the DMA transfer of the previous frame (RK3066). */
+	if (VOP_HAS_REG(vop, common, dma_stop))
+		VOP_REG_SET(vop, common, dma_stop, 0);
+
 	spin_unlock(&vop->reg_lock);
 
 	/*
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index b33e5bdc26be..0cf512cc1614 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -122,6 +122,7 @@ struct vop_common {
 	struct vop_reg lut_buffer_index;
 	struct vop_reg gate_en;
 	struct vop_reg mmu_en;
+	struct vop_reg dma_stop;
 	struct vop_reg out_mode;
 	struct vop_reg standby;
 };
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index b9ee02061d5b..9bcb40a640af 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -466,6 +466,7 @@ static const struct vop_output rk3066_output = {
 };
 
 static const struct vop_common rk3066_common = {
+	.dma_stop = VOP_REG(RK3066_SYS_CTRL0, 0x1, 0),
 	.standby = VOP_REG(RK3066_SYS_CTRL0, 0x1, 1),
 	.out_mode = VOP_REG(RK3066_DSP_CTRL0, 0xf, 0),
 	.cfg_done = VOP_REG(RK3066_REG_CFG_DONE, 0x1, 0),


