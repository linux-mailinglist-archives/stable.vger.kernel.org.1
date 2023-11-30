Return-Path: <stable+bounces-3482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ABD7FF5DC
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A171C2114B
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF7D537F9;
	Thu, 30 Nov 2023 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k5ROVyuZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9F3495D9;
	Thu, 30 Nov 2023 16:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5B5C433C7;
	Thu, 30 Nov 2023 16:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361943;
	bh=UDI7jv+LPp09F/5pCD/Y83bXYhh9uxwSMN36ZPpL0U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5ROVyuZwiYiGGpsPxdA8sD6yBGoxmtmHFy2wrnF2f4/hK4eUyo3HejFnSISrcA+u
	 L7TsqcNENNMO0u0vS18V5f8WkQnBMafAuc3JzexZK/vZKQea870dDqN5dK+6uCJBOa
	 wCejCrVTHmDSTLP92sAK0VpoAlHGIWiCBNu3J3Ug=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marex@denx.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 06/69] drm/panel: simple: Fix Innolux G101ICE-L01 timings
Date: Thu, 30 Nov 2023 16:22:03 +0000
Message-ID: <20231130162133.270202756@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162133.035359406@linuxfoundation.org>
References: <20231130162133.035359406@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>

[ Upstream commit 3f9a91b6c00e655d27bd785dcda1742dbdc31bda ]

The Innolux G101ICE-L01 datasheet [1] page 17 table
6.1 INPUT SIGNAL TIMING SPECIFICATIONS
indicates that maximum vertical blanking time is 40 lines.
Currently the driver uses 29 lines.

Fix it, and since this panel is a DE panel, adjust the timings
to make them less hostile to controllers which cannot do 1 px
HSA/VSA, distribute the delays evenly between all three parts.

[1] https://www.data-modul.com/sites/default/files/products/G101ICE-L01-C2-specification-12042389.pdf

Fixes: 1e29b840af9f ("drm/panel: simple: Add Innolux G101ICE-L01 panel")
Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231008223256.279196-1-marex@denx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 28d1e661f99b1..d9f1675c348e5 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2532,13 +2532,13 @@ static const struct panel_desc innolux_g070y2_l01 = {
 static const struct display_timing innolux_g101ice_l01_timing = {
 	.pixelclock = { 60400000, 71100000, 74700000 },
 	.hactive = { 1280, 1280, 1280 },
-	.hfront_porch = { 41, 80, 100 },
-	.hback_porch = { 40, 79, 99 },
-	.hsync_len = { 1, 1, 1 },
+	.hfront_porch = { 30, 60, 70 },
+	.hback_porch = { 30, 60, 70 },
+	.hsync_len = { 22, 40, 60 },
 	.vactive = { 800, 800, 800 },
-	.vfront_porch = { 5, 11, 14 },
-	.vback_porch = { 4, 11, 14 },
-	.vsync_len = { 1, 1, 1 },
+	.vfront_porch = { 3, 8, 14 },
+	.vback_porch = { 3, 8, 14 },
+	.vsync_len = { 4, 7, 12 },
 	.flags = DISPLAY_FLAGS_DE_HIGH,
 };
 
-- 
2.42.0




