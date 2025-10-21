Return-Path: <stable+bounces-188385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506E9BF7D0D
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B36C488875
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 17:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966991E32A2;
	Tue, 21 Oct 2025 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qri/7Jmy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A851DFD8B
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066257; cv=none; b=c0NIUDzkvWxQ9z43ykf3G9UgNEqhDZynDagcBjajUJd58aaPi9CV2NsBBmyrfRrrEI+9TtP2oGTbdcR+gR01ReiLyx9FA1WwfdE2+o2iyRnOtIPT6K7W9iV9RnxWMLoORORqY/501F7Uz5yjeYwFVwChAc60n2Rbo9j2HIzkL0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066257; c=relaxed/simple;
	bh=vEsy+FIZqhKiqOgmaM41cI/y/reDoFdRKQbxIVoMbp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3koT54QTq08UyFrHKXt1NO8QlhoQStKPmmHapzusjZHAQT86+fmM3v99XNZP3iwmT9se31c13IrbY/y/n+8MdrSZlqwhOOdiQco5j4ebdhgkPMiAq0OXfOQjfA5baZNeJZ4LPfEpAuO7dl1PBIaEbboZ6PjILUgbVE7o0hgFZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qri/7Jmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25C7C4CEF1;
	Tue, 21 Oct 2025 17:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761066256;
	bh=vEsy+FIZqhKiqOgmaM41cI/y/reDoFdRKQbxIVoMbp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qri/7JmyEE9GCGS4rGj1bYe8/4qhukahslXu63y4ulPAj0HqKEYWz92F72pMDT4uK
	 prL9Z1dq4kUqm0Bcoe3jAm+jz2KUamoHn1H/9oiQnUbg32VaoUa8BoyoDaLIPHJEeY
	 i+NayZ4+rgHVTmmQkwO1PYEnhA9nXYBp20ab+rsTZUYidXH+8eJSBs6UNe+U7j4qCL
	 SNnDWn+o6D8GK07zD44TvBo2tmjIvMqXMEV2o9HyS77QbP0wkRtK3T4P2gw+763po5
	 UMdcMaJ87MSz/ECBihrW0JIlU3F++cA13hqmcBJWYWtdR1olfnRKyMlW2Mbf0LAkF/
	 10HIH1xyUq1MQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Vinod Koul <vkoul@kernel.org>,
	Devarsh Thakkar <devarsht@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] phy: cdns-dphy: Store hs_clk_rate and return it
Date: Tue, 21 Oct 2025 13:04:12 -0400
Message-ID: <20251021170414.2402792-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101626-squeamish-relock-6780@gregkh>
References: <2025101626-squeamish-relock-6780@gregkh>
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
index 3dfdfb33cd0ac..23ab48671b79c 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -80,6 +80,7 @@ struct cdns_dphy_cfg {
 	u8 pll_ipdiv;
 	u8 pll_opdiv;
 	u16 pll_fbdiv;
+	u32 hs_clk_rate;
 	unsigned int nlanes;
 };
 
@@ -155,6 +156,9 @@ static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
 					  cfg->pll_ipdiv,
 					  pll_ref_hz);
 
+	cfg->hs_clk_rate = div_u64((u64)pll_ref_hz * cfg->pll_fbdiv,
+				   2 * cfg->pll_opdiv * cfg->pll_ipdiv);
+
 	return 0;
 }
 
@@ -298,6 +302,7 @@ static int cdns_dphy_config_from_opts(struct phy *phy,
 	if (ret)
 		return ret;
 
+	opts->hs_clk_rate = cfg->hs_clk_rate;
 	opts->wakeup = cdns_dphy_get_wakeup_time_ns(dphy) / 1000;
 
 	return 0;
-- 
2.51.0


