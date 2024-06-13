Return-Path: <stable+bounces-51815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB23E9071C1
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F95D281E71
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03301448C6;
	Thu, 13 Jun 2024 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OvVYZiLJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB3C1292FF;
	Thu, 13 Jun 2024 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282395; cv=none; b=LfqwiTe8RVYytJ3kYD60xs/8nOiuVheCUw0IWdUIZHhWtEHgVG7HbyLypfLHdg9VQkyyIkxNoYUwUS9caXEK7PufoHG3ccx/JcxpKgR6PIunQEumLWTcP6is+FT9SRxjXObXX8DKJqn9YxnyyYoCr+R3IK+MuPqLwFsxGfVlJcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282395; c=relaxed/simple;
	bh=+u/qCwMuLUfioWldgqQAbBDS9UON3+HRoY3c61r0i3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oR9m4vmZ8MGcdiHTY0F9j+8brdh43TdLbp9oPjTuVVRayvx3l1NnFyY4r/tgSuMLuiY9cU58bujYBwuIgiqDIIrgsoIXJ6kI0BB53nAXMhIUwITRUpYvtXmRE6KVDB1vfK3e9ywWD2lxoLaqIn0x7Saa6OhxxOAXECUPbfE6GC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OvVYZiLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CBAC2BBFC;
	Thu, 13 Jun 2024 12:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282395;
	bh=+u/qCwMuLUfioWldgqQAbBDS9UON3+HRoY3c61r0i3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OvVYZiLJAg9IpT3LKSGo+fJXHgBg7jsbQGk542nr4yyc7C/lPm+EcdSWhfmRW/hqm
	 sOzcgOWSXzNa6DdyNgy9RX9KYb1RPTsnZa4xBgZv5uavkyCUn0kye/cQAdHyZOHCZe
	 o09vqBvyPj7JJDyJ1TzVUKbDZ2YO3aOEM+EAwA4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Walle <mwalle@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 263/402] drm/bridge: tc358775: fix support for jeida-18 and jeida-24
Date: Thu, 13 Jun 2024 13:33:40 +0200
Message-ID: <20240613113312.410806903@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

From: Michael Walle <mwalle@kernel.org>

[ Upstream commit 30ea09a182cb37c4921b9d477ed18107befe6d78 ]

The bridge always uses 24bpp internally. Therefore, for jeida-18
mapping we need to discard the lowest two bits for each channel and thus
starting with LV_[RGB]2. jeida-24 has the same mapping but uses four
lanes instead of three, with the forth pair transmitting the lowest two
bits of each channel. Thus, the mapping between jeida-18 and jeida-24
is actually the same, except that one channel is turned off (by
selecting the RGB666 format in VPCTRL).

While at it, remove the bogus comment about the hardware default because
the default is overwritten in any case.

Tested with a jeida-18 display (Evervision VGG644804).

Fixes: b26975593b17 ("display/drm/bridge: TC358775 DSI/LVDS driver")
Signed-off-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240225062008.33191-5-tony@atomide.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358775.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 55697fa4d7c8b..2e299cfe4e487 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -453,10 +453,6 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 	dev_dbg(tc->dev, "bus_formats %04x bpc %d\n",
 		connector->display_info.bus_formats[0],
 		tc->bpc);
-	/*
-	 * Default hardware register settings of tc358775 configured
-	 * with MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA jeida-24 format
-	 */
 	if (connector->display_info.bus_formats[0] ==
 		MEDIA_BUS_FMT_RGB888_1X7X4_SPWG) {
 		/* VESA-24 */
@@ -467,14 +463,15 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 		d2l_write(tc->i2c, LV_MX1619, LV_MX(LVI_B6, LVI_B7, LVI_B1, LVI_B2));
 		d2l_write(tc->i2c, LV_MX2023, LV_MX(LVI_B3, LVI_B4, LVI_B5, LVI_L0));
 		d2l_write(tc->i2c, LV_MX2427, LV_MX(LVI_HS, LVI_VS, LVI_DE, LVI_R6));
-	} else { /*  MEDIA_BUS_FMT_RGB666_1X7X3_SPWG - JEIDA-18 */
-		d2l_write(tc->i2c, LV_MX0003, LV_MX(LVI_R0, LVI_R1, LVI_R2, LVI_R3));
-		d2l_write(tc->i2c, LV_MX0407, LV_MX(LVI_R4, LVI_L0, LVI_R5, LVI_G0));
-		d2l_write(tc->i2c, LV_MX0811, LV_MX(LVI_G1, LVI_G2, LVI_L0, LVI_L0));
-		d2l_write(tc->i2c, LV_MX1215, LV_MX(LVI_G3, LVI_G4, LVI_G5, LVI_B0));
-		d2l_write(tc->i2c, LV_MX1619, LV_MX(LVI_L0, LVI_L0, LVI_B1, LVI_B2));
-		d2l_write(tc->i2c, LV_MX2023, LV_MX(LVI_B3, LVI_B4, LVI_B5, LVI_L0));
-		d2l_write(tc->i2c, LV_MX2427, LV_MX(LVI_HS, LVI_VS, LVI_DE, LVI_L0));
+	} else {
+		/* JEIDA-18 and JEIDA-24 */
+		d2l_write(tc->i2c, LV_MX0003, LV_MX(LVI_R2, LVI_R3, LVI_R4, LVI_R5));
+		d2l_write(tc->i2c, LV_MX0407, LV_MX(LVI_R6, LVI_R1, LVI_R7, LVI_G2));
+		d2l_write(tc->i2c, LV_MX0811, LV_MX(LVI_G3, LVI_G4, LVI_G0, LVI_G1));
+		d2l_write(tc->i2c, LV_MX1215, LV_MX(LVI_G5, LVI_G6, LVI_G7, LVI_B2));
+		d2l_write(tc->i2c, LV_MX1619, LV_MX(LVI_B0, LVI_B1, LVI_B3, LVI_B4));
+		d2l_write(tc->i2c, LV_MX2023, LV_MX(LVI_B5, LVI_B6, LVI_B7, LVI_L0));
+		d2l_write(tc->i2c, LV_MX2427, LV_MX(LVI_HS, LVI_VS, LVI_DE, LVI_R0));
 	}
 
 	d2l_write(tc->i2c, VFUEN, VFUEN_EN);
-- 
2.43.0




