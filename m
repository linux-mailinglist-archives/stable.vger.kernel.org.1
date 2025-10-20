Return-Path: <stable+bounces-188092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F642BF168A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35971883E1E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127B531DD9B;
	Mon, 20 Oct 2025 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZB7WNS0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C9031283D
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965203; cv=none; b=gfTJtUuUB+/kuayxIm4Zw0dNAnmCNfzY5TkT2gqe0o4TgnMOkyWQloEEpvHxooX2MHBSGXbz93PY/zyRoimzOEdOEvb4fcsSNK0nDhb5W3VbDXAF1Z+/pmg9HkEPqJKmPt1by2SW56JTiV33ui2GnN0g52EOE1FvZpQReLio5fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965203; c=relaxed/simple;
	bh=QSQW5gb+aOgfcCuxQjFW/2yhUylIOONY0BA4/Eh6vpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goV6giRWTeP5mnFJElsq2gExz1n3KobdrRhhwcMKl/8x5nZaCjHwAqIk7AIZeWhGxUS3SuXwlhOG/7ETWvW6iJOV7RXP7sLAfnkgVGJOESqbmZydF3Qcbn5cLwvPsFHL+ac4WNOOYwYjf7FUsaATKER51/iLIiejyeiIDF8Iikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZB7WNS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD64C113D0;
	Mon, 20 Oct 2025 13:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965203;
	bh=QSQW5gb+aOgfcCuxQjFW/2yhUylIOONY0BA4/Eh6vpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZB7WNS0buRB2iWcq4FpR94mgwcDarJjvtz8+57i4JgvIL1oOi4m56AmjxQJhfQiy
	 w/Es0sAl4HVQHbO7fHdN8l2E+Cg/qPGb59qBTgsmaUihQjtNxYQlGeXGfvTph4rsiq
	 stb0tfrLGN9U9zBljelckkd5xSbznn+NVhJOdL6cIMu2yCfPCZwwhNu6hIO7SQocbZ
	 T30wfONpMzLNhtlAsJE7eG5Yk5SrQv3SD1hKtmd6biVxAvk6Vym3DP/qoQ82MALTRn
	 /r7NdDo9v55bG3+I2VaFx4Gez+9KFOHIP/xRhUmB81F0i5UBn0Nf30jH1sDCrLulcn
	 2QvaNej8vW6ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Vinod Koul <vkoul@kernel.org>,
	Devarsh Thakkar <devarsht@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] phy: cdns-dphy: Store hs_clk_rate and return it
Date: Mon, 20 Oct 2025 08:59:58 -0400
Message-ID: <20251020125959.1763029-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101614-sphere-flagman-052d@gregkh>
References: <2025101614-sphere-flagman-052d@gregkh>
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


