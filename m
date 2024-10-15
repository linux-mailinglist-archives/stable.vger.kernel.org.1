Return-Path: <stable+bounces-85689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CDA99E878
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4441B25F5D
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941761EC009;
	Tue, 15 Oct 2024 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FYNGta0/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F2E1EBFFF;
	Tue, 15 Oct 2024 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993964; cv=none; b=qqAAIKYA6Lzk5V6a7Rbv5ulcB4JJzNr/MOatYpeaFEK68hf76GzNhFaIS4hHNl+/pwk5ma7g0gyeMZoiEkdUi38N7Wd2fC+p/NurVC3MwbjWGL5bW5h8M9yT7FkRxsH0i3qzPftIyT1hCb8RE6eXGGnaAPsNxBffmKhxWyzngfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993964; c=relaxed/simple;
	bh=iNTqx3GxYLXaiXXApOoVPFNRNyiAWqHx2KXIE39sd+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJHq/eMwg5Ww65hg+VuZuIbsxqPVCWxO9K1XSbKTOaytaiclhjQzxyjG5jL6HtH/cx1VxGOyAMJIcOYkmg79X2QzE24qh4/kuuETaS3wlj6+FMfL74dr/8ktpbhnmPA3wTOqUYZZvwLBiS16YnWnF8L6UTuxA7SPsPsKSDx2A4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FYNGta0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F871C4CECF;
	Tue, 15 Oct 2024 12:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993963;
	bh=iNTqx3GxYLXaiXXApOoVPFNRNyiAWqHx2KXIE39sd+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FYNGta0/adTic4VYmlXuZaRITYkrYIAZQ+SmgJ/6T3zItOs8KEcx2rUhQMYBdGBn2
	 1QfcHxtbMZi7s9ZurgQdCHhBYecdZQtb5s8zb/iSkQKzEOdk9/BxCNdn3HsRPKEaNd
	 nQPJcAoReDRd2Knt36NsdGVouVQQtSp6sfQch7nw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hugh Cole-Baker <sigmaris@gmail.com>,
	"=?UTF-8?q?Milan=20P . =20Stani=C4=87?=" <mps@arvanta.net>,
	Linus Heckemann <git@sphalerite.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 567/691] drm/rockchip: define gamma registers for RK3399
Date: Tue, 15 Oct 2024 13:28:35 +0200
Message-ID: <20241015112502.847363926@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugh Cole-Baker <sigmaris@gmail.com>

[ Upstream commit 3ba000d6ae999b99f29afd64814877a5c4406786 ]

The VOP on RK3399 has a different approach from previous versions for
setting a gamma lookup table, using an update_gamma_lut register. As
this differs from RK3288, give RK3399 its own set of "common" register
definitions.

Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>
Tested-by: "Milan P. Stanić" <mps@arvanta.net>
Tested-by: Linus Heckemann <git@sphalerite.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20211019215843.42718-2-sigmaris@gmail.com
Stable-dep-of: 6b44aa559d6c ("drm/rockchip: vop: clear DMA stop bit on RK3066")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  2 ++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 24 +++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h |  1 +
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 857d97cdc67c6..14179e89bd215 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -99,6 +99,8 @@ struct vop_common {
 	struct vop_reg dither_down_en;
 	struct vop_reg dither_up;
 	struct vop_reg dsp_lut_en;
+	struct vop_reg update_gamma_lut;
+	struct vop_reg lut_buffer_index;
 	struct vop_reg gate_en;
 	struct vop_reg mmu_en;
 	struct vop_reg out_mode;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 8c873fcd0e99f..de7eb2fda4833 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -865,6 +865,24 @@ static const struct vop_output rk3399_output = {
 	.mipi_dual_channel_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 3),
 };
 
+static const struct vop_common rk3399_common = {
+	.standby = VOP_REG_SYNC(RK3399_SYS_CTRL, 0x1, 22),
+	.gate_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 23),
+	.mmu_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 20),
+	.dither_down_sel = VOP_REG(RK3399_DSP_CTRL1, 0x1, 4),
+	.dither_down_mode = VOP_REG(RK3399_DSP_CTRL1, 0x1, 3),
+	.dither_down_en = VOP_REG(RK3399_DSP_CTRL1, 0x1, 2),
+	.pre_dither_down = VOP_REG(RK3399_DSP_CTRL1, 0x1, 1),
+	.dither_up = VOP_REG(RK3399_DSP_CTRL1, 0x1, 6),
+	.dsp_lut_en = VOP_REG(RK3399_DSP_CTRL1, 0x1, 0),
+	.update_gamma_lut = VOP_REG(RK3399_DSP_CTRL1, 0x1, 7),
+	.lut_buffer_index = VOP_REG(RK3399_DBG_POST_REG1, 0x1, 1),
+	.data_blank = VOP_REG(RK3399_DSP_CTRL0, 0x1, 19),
+	.dsp_blank = VOP_REG(RK3399_DSP_CTRL0, 0x3, 18),
+	.out_mode = VOP_REG(RK3399_DSP_CTRL0, 0xf, 0),
+	.cfg_done = VOP_REG_SYNC(RK3399_REG_CFG_DONE, 0x1, 0),
+};
+
 static const struct vop_yuv2yuv_phy rk3399_yuv2yuv_win01_data = {
 	.y2r_coefficients = {
 		VOP_REG(RK3399_WIN0_YUV2YUV_Y2R + 0, 0xffff, 0),
@@ -946,7 +964,7 @@ static const struct vop_data rk3399_vop_big = {
 	.version = VOP_VERSION(3, 5),
 	.feature = VOP_FEATURE_OUTPUT_RGB10,
 	.intr = &rk3366_vop_intr,
-	.common = &rk3288_common,
+	.common = &rk3399_common,
 	.modeset = &rk3288_modeset,
 	.output = &rk3399_output,
 	.afbc = &rk3399_vop_afbc,
@@ -954,6 +972,7 @@ static const struct vop_data rk3399_vop_big = {
 	.win = rk3399_vop_win_data,
 	.win_size = ARRAY_SIZE(rk3399_vop_win_data),
 	.win_yuv2yuv = rk3399_vop_big_win_yuv2yuv_data,
+	.lut_size = 1024,
 };
 
 static const struct vop_win_data rk3399_vop_lit_win_data[] = {
@@ -972,13 +991,14 @@ static const struct vop_win_yuv2yuv_data rk3399_vop_lit_win_yuv2yuv_data[] = {
 static const struct vop_data rk3399_vop_lit = {
 	.version = VOP_VERSION(3, 6),
 	.intr = &rk3366_vop_intr,
-	.common = &rk3288_common,
+	.common = &rk3399_common,
 	.modeset = &rk3288_modeset,
 	.output = &rk3399_output,
 	.misc = &rk3368_misc,
 	.win = rk3399_vop_lit_win_data,
 	.win_size = ARRAY_SIZE(rk3399_vop_lit_win_data),
 	.win_yuv2yuv = rk3399_vop_lit_win_yuv2yuv_data,
+	.lut_size = 256,
 };
 
 static const struct vop_win_data rk3228_vop_win_data[] = {
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
index 0b3cd65ba5c1b..406e981c75bd7 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
@@ -628,6 +628,7 @@
 #define RK3399_YUV2YUV_WIN			0x02c0
 #define RK3399_YUV2YUV_POST			0x02c4
 #define RK3399_AUTO_GATING_EN			0x02cc
+#define RK3399_DBG_POST_REG1			0x036c
 #define RK3399_WIN0_CSC_COE			0x03a0
 #define RK3399_WIN1_CSC_COE			0x03c0
 #define RK3399_WIN2_CSC_COE			0x03e0
-- 
2.43.0




