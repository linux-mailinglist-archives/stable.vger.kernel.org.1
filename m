Return-Path: <stable+bounces-84803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A6D99D22A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82392867D0
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF8F1AD41F;
	Mon, 14 Oct 2024 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n8wkIeHc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B53F1AC44C;
	Mon, 14 Oct 2024 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919268; cv=none; b=Wk89PzhAca5moKJjGVX2A9ISEbGpBiOVuEAUe4mmp0mTLG2Q0vmRg0PGkW5V26JXWlGJv79PuTtfuTej+YlPlxQksMmXEo05UMMvZtP1V6jc7gufO8/0WbfxAUnHLNsrmEcwppK6UpU3xNighPiiWGtuIIdbetZFLyqO3/QKMSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919268; c=relaxed/simple;
	bh=dc6DTZU0aKnFEpVzmCy8Y8xVYc/rbDH+Q/gyY4ZPt5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6iNyuGs1CXkgH6UIDVe71/l65CBH3eOnUMHJN/mI9ZcsvoXNe7H0BS3oj5G6kdp1lyLw44KLlkF1MxTubv+uOJBInANwPsgCoFKgc+mqSD3kPrkf1MpVzirVmubbF4JciHMMY1TpQPOnvRW2URl91F0ap/9HtFHFaZo9WKc3og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n8wkIeHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2518C4CEC3;
	Mon, 14 Oct 2024 15:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728919268;
	bh=dc6DTZU0aKnFEpVzmCy8Y8xVYc/rbDH+Q/gyY4ZPt5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8wkIeHc6A7cOpVW57wO4nvuTtQBSKm8QVoN/IXgW6Dru27oeGQxV45jmzXlrC/82
	 iPYnv/FpGeKqmsQqi+ilRmPm8OmEOCAkbHDElfzlfrq9UwXLVk9f0j00yOQJShEzq5
	 rdTNL/k/Ly+o2Sy8pTf7VOg2Q3zPKsYxTh8tXICU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Val Packett <val@packett.cool>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.1 559/798] drm/rockchip: vop: clear DMA stop bit on RK3066
Date: Mon, 14 Oct 2024 16:18:33 +0200
Message-ID: <20241014141239.958352392@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Val Packett <val@packett.cool>

commit 6b44aa559d6c7f4ea591ef9d2352a7250138d62a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    4 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |    1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |    1 +
 3 files changed, 6 insertions(+)

--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1559,6 +1559,10 @@ static void vop_crtc_atomic_flush(struct
 	VOP_AFBC_SET(vop, enable, s->enable_afbc);
 	vop_cfg_done(vop);
 
+	/* Ack the DMA transfer of the previous frame (RK3066). */
+	if (VOP_HAS_REG(vop, common, dma_stop))
+		VOP_REG_SET(vop, common, dma_stop, 0);
+
 	spin_unlock(&vop->reg_lock);
 
 	/*
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -117,6 +117,7 @@ struct vop_common {
 	struct vop_reg lut_buffer_index;
 	struct vop_reg gate_en;
 	struct vop_reg mmu_en;
+	struct vop_reg dma_stop;
 	struct vop_reg out_mode;
 	struct vop_reg standby;
 };
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -431,6 +431,7 @@ static const struct vop_output rk3066_ou
 };
 
 static const struct vop_common rk3066_common = {
+	.dma_stop = VOP_REG(RK3066_SYS_CTRL0, 0x1, 0),
 	.standby = VOP_REG(RK3066_SYS_CTRL0, 0x1, 1),
 	.out_mode = VOP_REG(RK3066_DSP_CTRL0, 0xf, 0),
 	.cfg_done = VOP_REG(RK3066_REG_CFG_DONE, 0x1, 0),



