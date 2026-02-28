Return-Path: <stable+bounces-220457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +In5Afw7o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:03:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3731C68AA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BF903509A61
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD6C3BA8E6;
	Sat, 28 Feb 2026 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Go2XSjQf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7553BA8D3;
	Sat, 28 Feb 2026 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300345; cv=none; b=aBkLT4Dal0Ui5qh5nrHsox4qfMjbRDD61nEdBS54MTZdy0Oxhj/N11AjPr2mlu/5ZuQtgB10na1njor6WS6t0DI3d2Iwk2SQJ8t7Bc70kj24QdBhsopiaYq6lw4TFc3FVMto33bRo9LtTUPCZZYrmaf3dXXOdjbQ1Dfc6ub0UtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300345; c=relaxed/simple;
	bh=QmJOBZaR5RMLhXGQoqBBPsyIqSkr6eHuIJHE0yzIkCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8KeVAf2FaM8MX0oB80JesQApQx1XHwwtN4jNU5WWLPCY+ixslSRauje9gt9jdnj2yqT7eor/q0kwJkIw1XnnnfyjwSJKppVGtTrggJCRXAcfm0SLtZyHr9IGEwPm9bD4HIzy4WsKvhpyZJ2HEYovqrp2P0bZtb+H0MGjYch3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Go2XSjQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80544C19424;
	Sat, 28 Feb 2026 17:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300345;
	bh=QmJOBZaR5RMLhXGQoqBBPsyIqSkr6eHuIJHE0yzIkCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Go2XSjQfdsF8IZMTK70BnyRsQPm/OJEzBiELQqV/ygD28IlJjodgy+zoXj7AsLOy3
	 ZCTARIstp66CYZXT0+V4/VzWXVBJOWRjR2qKAudGZy9QKRX7zU1FGxdmgPJUAlVGuD
	 N6Ug+3XspxPFbcda5fk7zyCT7tP1hXhH4II8DELhGAVdVmxVUkCFwUItCzR+QE9FIE
	 APdrM0y6T/rAodnjEYMVBa8kaD7OZM60s4Mz11CEmtWkZmiTfP5Ot2hulRsQGQBr+m
	 z/sr7C69rBlXEotau9kPApGNOxi0G7z9YJeUBf9WSIdnPaTU4k2TzUCzHpx7n0ISpF
	 JjIv2KzeC8R8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 378/844] phy: cadence-torrent: restore parent clock for refclk during resume
Date: Sat, 28 Feb 2026 12:24:51 -0500
Message-ID: <20260228173244.1509663-379-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220457-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,linaro.org:email,ti.com:url,msgid.link:url]
X-Rspamd-Queue-Id: 4B3731C68AA
X-Rspamd-Action: no action

From: "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>

[ Upstream commit 434e1a0ee145d0389b192252be4c993f86cf1134 ]

While suspend and resume, parent clock config for refclk was getting lost.
So save and restore it in suspend and resume operations.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Thomas Richard (TI.com) <thomas.richard@bootlin.com>
Link: https://patch.msgid.link/20251216-phy-cadence-torrent-resume-restore-refclk-parent-v3-1-8a7ed84b47e3@bootlin.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 37fa4bad6bd72..877f22177c699 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -397,6 +397,7 @@ struct cdns_torrent_refclk_driver {
 	struct clk_hw		hw;
 	struct regmap_field	*cmn_fields[REFCLK_OUT_NUM_CMN_CONFIG];
 	struct clk_init_data	clk_data;
+	u8 parent_index;
 };
 
 #define to_cdns_torrent_refclk_driver(_hw)	\
@@ -3326,11 +3327,29 @@ static const struct cdns_torrent_vals sgmii_qsgmii_xcvr_diag_ln_vals = {
 	.num_regs = ARRAY_SIZE(sgmii_qsgmii_xcvr_diag_ln_regs),
 };
 
+static void cdns_torrent_refclk_driver_suspend(struct cdns_torrent_phy *cdns_phy)
+{
+	struct clk_hw *hw = cdns_phy->clk_hw_data->hws[CDNS_TORRENT_REFCLK_DRIVER];
+	struct cdns_torrent_refclk_driver *refclk_driver = to_cdns_torrent_refclk_driver(hw);
+
+	refclk_driver->parent_index = cdns_torrent_refclk_driver_get_parent(hw);
+}
+
+static int cdns_torrent_refclk_driver_resume(struct cdns_torrent_phy *cdns_phy)
+{
+	struct clk_hw *hw = cdns_phy->clk_hw_data->hws[CDNS_TORRENT_REFCLK_DRIVER];
+	struct cdns_torrent_refclk_driver *refclk_driver = to_cdns_torrent_refclk_driver(hw);
+
+	return cdns_torrent_refclk_driver_set_parent(hw, refclk_driver->parent_index);
+}
+
 static int cdns_torrent_phy_suspend_noirq(struct device *dev)
 {
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(dev);
 	int i;
 
+	cdns_torrent_refclk_driver_suspend(cdns_phy);
+
 	reset_control_assert(cdns_phy->phy_rst);
 	reset_control_assert(cdns_phy->apb_rst);
 	for (i = 0; i < cdns_phy->nsubnodes; i++)
@@ -3352,6 +3371,10 @@ static int cdns_torrent_phy_resume_noirq(struct device *dev)
 	int node = cdns_phy->nsubnodes;
 	int ret, i;
 
+	ret = cdns_torrent_refclk_driver_resume(cdns_phy);
+	if (ret)
+		return ret;
+
 	ret = cdns_torrent_clk(cdns_phy);
 	if (ret)
 		return ret;
-- 
2.51.0


