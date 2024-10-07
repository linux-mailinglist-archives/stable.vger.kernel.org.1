Return-Path: <stable+bounces-81349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A25993169
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692541F23061
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B311D8E08;
	Mon,  7 Oct 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KfCNELaq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144B125B9
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315382; cv=none; b=QIVTJhdr3qmOrxPgtxA0uQF6PHTNLty3fMM/isnKkPH76nXDt7rB+v1YQQt0Mh8Owt6DabDj3YgHA2vYY2WbdMkQJBBKU5OmuryWMVZiWFK93vIpdk+5y3KZVeohJjTmqg/ZBalacUNuswdp2jEMO/gq/Cf3QgwdlifC2YN8ego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315382; c=relaxed/simple;
	bh=vGsE5OVzXD3Arvlw1UzVj8ECdfsBMZR+whbHeXQWTK0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=edb9hkNE2B38NSRsV4TjrG7321YTJ4kHcz86FWrynFgje46vp8IOB+gMRTkR+LRpTLqXanketK4tZOvmzQ7SVmGum0EbZy2xw6GgPZT0qRD19yfuyOtEZa9PBGXlCrI9xEVbv0jKVVxaRjVoTlnWgtI3xvE7RuextFXUtuQ2QV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KfCNELaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5BAC4CECC;
	Mon,  7 Oct 2024 15:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728315382;
	bh=vGsE5OVzXD3Arvlw1UzVj8ECdfsBMZR+whbHeXQWTK0=;
	h=Subject:To:Cc:From:Date:From;
	b=KfCNELaqD60rcf0rK9fspb7U4hakAYzCcrXsBpUBmOfZ4phqQghN5l/pgZLbxqlHm
	 sN8o4qi7F++r/oMB7TLRClDWdMzpCJhGHhpzpm6kacGy67yRHPZN9G1DKkhkZUchh4
	 cAjQvFdYiVOGL6Pq6A/PZvUsXcooPI0fz3jnPxU8=
Subject: FAILED: patch "[PATCH] drm/rockchip: vop: clear DMA stop bit on RK3066" failed to apply to 5.15-stable tree
To: val@packett.cool,heiko@sntech.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 17:36:08 +0200
Message-ID: <2024100707-brunch-thumb-0511@gregkh>
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
git cherry-pick -x 6b44aa559d6c7f4ea591ef9d2352a7250138d62a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100707-brunch-thumb-0511@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


