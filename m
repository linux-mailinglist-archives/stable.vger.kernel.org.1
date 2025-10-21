Return-Path: <stable+bounces-188375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC2CBF7BF6
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB77189B1B9
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 16:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925A2350D51;
	Tue, 21 Oct 2025 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLilfz38"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529CB34A768
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065016; cv=none; b=jbz9/iD9mk1qJhC69E8zmIhPbi4Gm3jY8WTo9wWP5CFsTIwWy9mSsl7jhvgXcx9Et2bo9ZcGPqqf5rKw4cI/MDFh9KIcglA5IE34h57wWKLUJwyuz93u6h51oInCe5+CAqjJ7mSf0DqDRhBBRr8dbN3Glo0JHxw3V56BYBDTDnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065016; c=relaxed/simple;
	bh=5yz81mRGOTUR9sOvbRNFi4QHFKwQI7KdNFxikQ8+KtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tevdDZ2BbUKm0OUsq9OH/okkLWpsQcv75l6wd+roEHhQYTH1zl6blUQ83xeb2kyFjEtdKovIJl5bRXe/IhankyJW0H6SpLMJ/RGBJOn+f9svoDkUDsgKHvGWMeFX2DR715Ux0ey43r718q221qkWpcmfgweWiyZlc1HjfTQYBCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLilfz38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E24C4CEF1;
	Tue, 21 Oct 2025 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761065016;
	bh=5yz81mRGOTUR9sOvbRNFi4QHFKwQI7KdNFxikQ8+KtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLilfz38RtACfQO9TqxNOA+KHtMdBD3fvW8ltACUBSfrgFqgaH6SzOsGKm3WjIC5g
	 KpgUY6n4cbcc5r03MZR5IE2AHgtfi5f+3QtTyVF5Q54s6MizG8P3kjInzJv3c/BmqA
	 8y1+GGyOLv2fdN1MXGYsJab6ilJi+c8JCGP4mmETDQCOb1kA1vIrNNnvt/lqyQWSg1
	 JjyrJ12kPLw4UTLMvij+85hrGSIxsLKG90LkHOfwcD0a9q3IBW8WdBBu0Swo2W9VRC
	 KQsVxYDWR28B36sgPTJEmhghijUr+qikWQPDA8GAYSqF3I7nNqxSqWD4jMjNyXENOT
	 zVKm02oMCug1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Vinod Koul <vkoul@kernel.org>,
	Devarsh Thakkar <devarsht@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] phy: cdns-dphy: Store hs_clk_rate and return it
Date: Tue, 21 Oct 2025 12:43:31 -0400
Message-ID: <20251021164333.2380694-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101625-happiness-heavily-11c6@gregkh>
References: <2025101625-happiness-heavily-11c6@gregkh>
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


