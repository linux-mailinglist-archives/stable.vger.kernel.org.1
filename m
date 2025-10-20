Return-Path: <stable+bounces-188090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B6EBF164E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C55CF34D04D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3DE314B81;
	Mon, 20 Oct 2025 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/Oph9MI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B6C313E1A
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965178; cv=none; b=FWaHPt4ko7EO0wJH45+ddxakUYbKrFrdp7jhd/7wyEdGs7NGVM6Oe2lJaXWi2t99+mIFoamgUa+nmrkniN96/CNj/ug1fEkmc+Pb3UaqW73nFsctiI56k50uwaFMe97OLmiLM0HRD9x/0Rd7xBu9LzbkGdzwznnHFZPsUEgWeAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965178; c=relaxed/simple;
	bh=lkvp6RuRWWaPpKgf/2nDW5LNfAF9bPyMLxfd1eW+1kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYnehT/Y103aSBOQGzfivVJskffNxt9Y8n1nv8hsBc/+TY+0Yju7efMhkNr7WlKCIF8AHe9qlYtsIfASE649Zq3ktn6vy6V2LbqrDEEXEl2ZylHzxarBIKz+RLQ9zAOwBVuqBuRQs/VvXHKclvIuUxY539yGNPEAXMgXJbLESJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/Oph9MI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461F3C4CEF9;
	Mon, 20 Oct 2025 12:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965178;
	bh=lkvp6RuRWWaPpKgf/2nDW5LNfAF9bPyMLxfd1eW+1kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/Oph9MIWipzV1n1swYkhQ/jPI7UKpsJU4Y3dBZz6Jzehx7aWMNAGmH19cx4foWOa
	 w239GZFLsiLADrxnHeJ5IxYGNx9f8wxSGShOyWxyAqYSLhhOCdg/KJ6bOP7NMORL3b
	 vUUWuL6Y85IMLbbuu/bNZHwAGc//ROt4EsxBYhY5d+zx3rD4FU2fURdK+mdsFpz5vY
	 W0e4XxvUea00xCF4xJro1qtnxeoIH1cBbneCSu6+qJrkLUHoHGTBuxdbur64c4EepS
	 rJ3wU4DX6IVeWxwy3dWvAbtp+9a4KbVEaMvkF12vVu/1/DuwQ7FFtvGxQMLdR5VV3E
	 chiMbRmnohYEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Vinod Koul <vkoul@kernel.org>,
	Devarsh Thakkar <devarsht@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] phy: cdns-dphy: Store hs_clk_rate and return it
Date: Mon, 20 Oct 2025 08:59:34 -0400
Message-ID: <20251020125935.1762853-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101614-lisp-bucktooth-cc0e@gregkh>
References: <2025101614-lisp-bucktooth-cc0e@gregkh>
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


