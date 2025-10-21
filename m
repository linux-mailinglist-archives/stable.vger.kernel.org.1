Return-Path: <stable+bounces-188369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35634BF7901
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEC7188B43A
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C01B3446D3;
	Tue, 21 Oct 2025 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzfkrtkW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3283431F5
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062531; cv=none; b=W4aQN6OOO+zVm80FGxIzSWYwSVG0uMYGanhII1aeZLtWfJRNPflWen8KgEzNIc2V/i8qITKcxDx/gFL++jOTGUgnHVVOJzBbJelQJhqerZDKf+14W2NzT5ZP+TqiUFVDou/JAcC1xWOGZhRqXxIge396yvcghYRMKth7jfJDS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062531; c=relaxed/simple;
	bh=4KFZHYMsbv/BYXDIXyPlo/a8ZgJ43MoWABfe0ubKhi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOg9Tz/XnZ/U/aVTNxlYmEKjhstqzRgRBm2Ig2yuHaEb7r/C4WTy+HouvoIcmYt21B/FaRSf2EkzOY/XcwRzsT4QWN1q8wB+hn8iKX8t68Jmpa26CVBS3HvIvaHea0iOLM4gR8RmbumckxCZSwTUWR90XczJFHqo1b3iThpZezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzfkrtkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C89BC4CEF1;
	Tue, 21 Oct 2025 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761062530;
	bh=4KFZHYMsbv/BYXDIXyPlo/a8ZgJ43MoWABfe0ubKhi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SzfkrtkWaLKJQGREGHIrdPgOWFw8a/Qj37ATIERSCH0BARIfbVZHqkCogHrpRmhyC
	 awQo8PjdjhI6Xt9jaRBF9g1PWrBok3YGad6zFpkUPLW7TR5Cv8uXiRN9mHrqtq1/cG
	 sPd46M5PnYBeXP237FDkme58ngEoXoLEx3eGDtefT3loCOTa/dYGNooN6hd7y29kGu
	 iKfiIE4nKgBYQlQRulwlGc2BDwFDg0HX8j0KpMqgh13B20H2Vp0wLeoGQE0Nfk7bmo
	 dC4aGMDzYjB/hG0+CbozKu98zQivqs+zy0KXzKNeS0vD16uQPSQTsl6Zx5g5untuOz
	 dtCLWFOuG2z4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Vinod Koul <vkoul@kernel.org>,
	Devarsh Thakkar <devarsht@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/3] phy: cdns-dphy: Store hs_clk_rate and return it
Date: Tue, 21 Oct 2025 12:02:05 -0400
Message-ID: <20251021160207.2330991-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101625-laborer-imaging-a408@gregkh>
References: <2025101625-laborer-imaging-a408@gregkh>
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
Stable-dep-of: 2c27aaee934a ("phy: cadence: cdns-dphy: Update calibration wait time for startup state machine")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/cadence/cdns-dphy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index ed87a3970f834..f79ec4fab4093 100644
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


