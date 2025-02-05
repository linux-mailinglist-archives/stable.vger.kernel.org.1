Return-Path: <stable+bounces-112455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B009A28CC5
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC021884278
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50055149C7B;
	Wed,  5 Feb 2025 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kRtTBd2N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E065FC0B;
	Wed,  5 Feb 2025 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763626; cv=none; b=lylqkyKkxuNTds9GDXvGr77PNTuRJIwZOKl1mm83UJ0tKWcP+Hi+l2qVlGonQtz1XKhdHSZ2Or86ceWDiTLiTDprDBz3Qud5msq3tt7BsmbBgtPtQ/02X/uxFixrfyw92ZieFidr8bnCOh/KBmpmq1XR1GGxXbKRsFMybROu4JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763626; c=relaxed/simple;
	bh=EBEKkcN8yOsB03Yj6vLSqrcluO2gBOlr+mEsSBlkjh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8NuwoPMapSf1Jzei9SjDk5Axl6adNRNsxh24iKp6M6Yf2HIEFJgcw/+b29ihOtdIuJIwKxUoYX3LQGqIuvcSxyiddSxFD4RNU15rXdBkkd1W086w4D97O8yxe+Fr+s/wHDCLlOElIVnRl/aUIaDp2WJWNKm02ommTVh2vYgYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kRtTBd2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701B2C4CED1;
	Wed,  5 Feb 2025 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763625;
	bh=EBEKkcN8yOsB03Yj6vLSqrcluO2gBOlr+mEsSBlkjh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kRtTBd2NfuS0DJqLhxIYuGIFC/U5ToEa1IGSAahE0POlu1lw9DekF1DUAJh6QTnw1
	 JORdVvG9FJ+IpZHO6y7eknPgB7WOYJN5/424l94C+hqttCwWTCpV0qbcjwt6kuxaNF
	 GKhwwttv20jMR+565c9iW5/gQRrPhgGyr/Y5c2i0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Andy Yan <andyshrk@163.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 037/590] drm/rockchip: vop2: fix rk3588 dp+dsi maxclk verification
Date: Wed,  5 Feb 2025 14:36:32 +0100
Message-ID: <20250205134456.671190548@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Stuebner <heiko.stuebner@cherry.de>

[ Upstream commit 5807f4ee6d32a4cce9a4df36f0d455c64c861947 ]

The clock is in Hz while the value checked against is in kHz, so
actual frequencies will never be able to be below to max value.
Fix this by specifying the max-value in Hz too.

Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Acked-by: Andy Yan <andyshrk@163.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20241115151131.416830-1-heiko@sntech.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 9873172e3fd33..30d03ff6c01f0 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1721,9 +1721,9 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
 		else
 			dclk_out_rate = v_pixclk >> 2;
 
-		dclk_rate = rk3588_calc_dclk(dclk_out_rate, 600000);
+		dclk_rate = rk3588_calc_dclk(dclk_out_rate, 600000000);
 		if (!dclk_rate) {
-			drm_err(vop2->drm, "DP dclk_out_rate out of range, dclk_out_rate: %ld KHZ\n",
+			drm_err(vop2->drm, "DP dclk_out_rate out of range, dclk_out_rate: %ld Hz\n",
 				dclk_out_rate);
 			return 0;
 		}
@@ -1738,9 +1738,9 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
 		 * dclk_rate = N * dclk_core_rate N = (1,2,4 ),
 		 * we get a little factor here
 		 */
-		dclk_rate = rk3588_calc_dclk(dclk_out_rate, 600000);
+		dclk_rate = rk3588_calc_dclk(dclk_out_rate, 600000000);
 		if (!dclk_rate) {
-			drm_err(vop2->drm, "MIPI dclk out of range, dclk_out_rate: %ld KHZ\n",
+			drm_err(vop2->drm, "MIPI dclk out of range, dclk_out_rate: %ld Hz\n",
 				dclk_out_rate);
 			return 0;
 		}
-- 
2.39.5




