Return-Path: <stable+bounces-210647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I51CHM2cGl9XAAAu9opvQ
	(envelope-from <stable+bounces-210647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:14:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3E74F95F
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B06F80FB27
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2941C3191B8;
	Wed, 21 Jan 2026 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmcRuWaR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15321767A
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961615; cv=none; b=BuWV80RnX3PA/GSnxQy29lyzsYh/89m15Gaao9bQ2jxA35hJCBwCXpMZy4E37XooSubRSL/+XkQ2L5xQzRHxsngRFTc69+mf/Vgsfoa5NCsXma41tSRSBlcwBlW0pRK+s9DGvhn3P0RhH4LkTlEXF8qVrhjxKnXOE8qvnsOOWQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961615; c=relaxed/simple;
	bh=iA6e8Lak74G95EAZTFhyBLWzbGyrYi226vRJABUPFvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bl5qEaHdkjvj5pCPkcjnCAKoY6XdMZTOHWt2Eorplz4LgqCZCgwIEiaqpiyF9hrFPKX/mWFsXSrrRrnvJxb/Nz3Lw/SQOHGD/Y8Rtf5hyUilPgsABZU5FuEHR5EKJyFDgI+dqof3In2SW2pqR9FiPHbObJ8NSfQN6r/5KBZmglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmcRuWaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE41C16AAE;
	Wed, 21 Jan 2026 02:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768961615;
	bh=iA6e8Lak74G95EAZTFhyBLWzbGyrYi226vRJABUPFvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UmcRuWaRRZAADBRuOi3bBn2XhkvBBZKjK8tPVMOCHhqXDEIP3JuJ/Ym0TF7QI8Jk3
	 nALHOwJCHeydjeJBughfaOulkmZctpZU65Fq1GGpaXw5qc2VXLpzs0q9HEayPNWhx4
	 1CCQfNoOvU1QmD+QeYlwfzvCih6K+gS2xyHevipXQhYLSUO1DW9GTq1NErIBDBOEvf
	 NT5XG5v9YtezPWAKFv0U4t/t/r3MkRUklwzeiDmMySp0YVpt4JVO+VhvgN/q/Ru/mk
	 xKSL1mKSVVVkg2oVXBHmM7zKEuEPaYAfo6aKY6hitU6uCP3Zo+LobYCjdKix5gE7+t
	 hobFEKt+0hoWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] phy: phy-rockchip-inno-usb2: simplify phy clock handling
Date: Tue, 20 Jan 2026 21:13:31 -0500
Message-ID: <20260121021333.1126769-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012042-dealt-crudeness-5250@gregkh>
References: <2026012042-dealt-crudeness-5250@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210647-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,collabora.com:email]
X-Rspamd-Queue-Id: CB3E74F95F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastian Reichel <sebastian.reichel@collabora.com>

[ Upstream commit b43511233c6e34b9c0d9a55e41b078d10e7d9ea6 ]

Simplify phyclk handling by using devm_clk_get_optional_enabled to
acquire and enable the optional clock. This also fixes a resource
leak in driver remove path and adds proper error handling.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20230522170324.61349-6-sebastian.reichel@collabora.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: e07dea3de508 ("phy: rockchip: inno-usb2: Fix a double free bug in rockchip_usb2phy_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index a0bc10aa79618..caa5787f09a52 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1269,18 +1269,16 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	rphy->clk = of_clk_get_by_name(np, "phyclk");
-	if (!IS_ERR(rphy->clk)) {
-		clk_prepare_enable(rphy->clk);
-	} else {
-		dev_info(&pdev->dev, "no phyclk specified\n");
-		rphy->clk = NULL;
+	rphy->clk = devm_clk_get_optional_enabled(dev, "phyclk");
+	if (IS_ERR(rphy->clk)) {
+		return dev_err_probe(&pdev->dev, PTR_ERR(rphy->clk),
+				     "failed to get phyclk\n");
 	}
 
 	ret = rockchip_usb2phy_clk480m_register(rphy);
 	if (ret) {
 		dev_err(dev, "failed to register 480m output clock\n");
-		goto disable_clks;
+		return ret;
 	}
 
 	index = 0;
@@ -1343,11 +1341,6 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 
 put_child:
 	of_node_put(child_np);
-disable_clks:
-	if (rphy->clk) {
-		clk_disable_unprepare(rphy->clk);
-		clk_put(rphy->clk);
-	}
 	return ret;
 }
 
-- 
2.51.0


