Return-Path: <stable+bounces-188088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADAFBF1696
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 111E24F60D2
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BFE31B810;
	Mon, 20 Oct 2025 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5woLJva"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A553176F4
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965149; cv=none; b=Ad4uBrgEQUeBFdH8LpKgF5HOIs3U3kqdzJhJgLHoO7HhO2qKxMK9jM65ePafBndymAVvDw0usQcrvvI/aokkhmDlCb0apr4jvouQYay6c8rrv+GUU6K08pxcNgm37X1gmbamYaC+bY53T6+XSEVrOS9fD5/O+EyTPCfN/Z3flco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965149; c=relaxed/simple;
	bh=lkvp6RuRWWaPpKgf/2nDW5LNfAF9bPyMLxfd1eW+1kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKQK02tiGnR4iiB0bPdncvgLzpQn0EqILU34PNH2ZmmJcs2F+K02bd1hsmvi4Vz99IJR4kSV+KLrViTu7V8gOhqITIik87vxIAom+T3Mycnc+PPBcWZ0X4ro1N1cURGaKgpy1J4HJPozKkUV/chd/yrfJH+R/bYkCaeaqJGr7/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5woLJva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F3EC4CEF9;
	Mon, 20 Oct 2025 12:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965149;
	bh=lkvp6RuRWWaPpKgf/2nDW5LNfAF9bPyMLxfd1eW+1kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5woLJva82+DXR5NEIGwkGGLG++z6zweQ3wpPC4R2Q1UKed31q5cYYGHjQbUefJcE
	 3HI7foW5Qn+Bu5IPH1F47uCcPC4D9GZ+i/x0mrcKu0OyVzBvbm3sCKAjMH0W3xWFzk
	 3L7tyeGVG25QQkojVfA7M+cBcwbcQdmT5cyOkdYpPlIS8oxCwkrSssnbB5R10Zow00
	 zpL90t4yZMkQYlhSvpcTgsDe7lxeTZOVeKt3j7jQehHWm5Yu949JcH4bCtj2D3O7EY
	 7Pfkm9er2JMFP0z+Ww+lCJ/GghuVDxxmi2wji8kW0sJWvi6I50vcci4/WE8CAgbdqM
	 ALlVkJTtZTvUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Vinod Koul <vkoul@kernel.org>,
	Devarsh Thakkar <devarsht@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] phy: cdns-dphy: Store hs_clk_rate and return it
Date: Mon, 20 Oct 2025 08:59:05 -0400
Message-ID: <20251020125906.1762647-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101613-trickery-snowless-db46@gregkh>
References: <2025101613-trickery-snowless-db46@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 689a54acb56858c85de8c7285db82b8ae6dbf683 ]

The DPHY driver does not return the actual hs_clk_rate, so the DSI
driver has no idea what clock was actually achieved. Set the realized
hs_clk_rate to the opts struct, so that the DSI driver gets it back.

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Tested-by: Parth Pancholi <parth.pancholi@toradex.com>
Tested-by: Jayesh Choudhary <j-choudhary@ti.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://lore.kernel.org/r/20250723-cdns-dphy-hs-clk-rate-fix-v1-1-d4539d44cbe7@ideasonboard.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 284fb19a3ffb ("phy: cadence: cdns-dphy: Fix PLL lock and O_CMN_READY polling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/cadence/cdns-dphy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index dddb66de6dba1..7e4a45085a66a 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -79,6 +79,7 @@ struct cdns_dphy_cfg {
 	u8 pll_ipdiv;
 	u8 pll_opdiv;
 	u16 pll_fbdiv;
+	u32 hs_clk_rate;
 	unsigned int nlanes;
 };
 
@@ -154,6 +155,9 @@ static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
 					  cfg->pll_ipdiv,
 					  pll_ref_hz);
 
+	cfg->hs_clk_rate = div_u64((u64)pll_ref_hz * cfg->pll_fbdiv,
+				   2 * cfg->pll_opdiv * cfg->pll_ipdiv);
+
 	return 0;
 }
 
@@ -297,6 +301,7 @@ static int cdns_dphy_config_from_opts(struct phy *phy,
 	if (ret)
 		return ret;
 
+	opts->hs_clk_rate = cfg->hs_clk_rate;
 	opts->wakeup = cdns_dphy_get_wakeup_time_ns(dphy) / 1000;
 
 	return 0;
-- 
2.51.0


