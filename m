Return-Path: <stable+bounces-141517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 039AAAAB428
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDA1189D1E1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A848340AB8;
	Tue,  6 May 2025 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMrHudWy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C372ED085;
	Mon,  5 May 2025 23:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486557; cv=none; b=cNDlgznWCDJ8v/d/hUZYqrOfHGHfT4ORd+KRWQ0F21g23NxGTTORAWFe6hmot6Ggp7Vs81H5ZLO850U0Q66XIlRgrPCpC3+5UW4wrCenSqYvaUmVnk6lXwmXkjjH5kXzu5JsyDbcKy7yXebJ79L5yABvGovGSKWfXyJvfG1nW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486557; c=relaxed/simple;
	bh=M57+MGIitVlZ7L9cTp3dvP1dnfas3v/3MLvR3vJ6H/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NEFM3QgMioD2LPrVdhB62LEhga0R5cxl5eBFRck5tSdTVu26NUT6okfDmkEYtg+50cWWFknYdPwwXt7BbigKie9aULKIJf8CiHERfLSYy6NknhWu+g9QMQJKT+8Qvy57HIoCgaEl04hGIqbAsLdK5IBKqPTcWDWt1adxpSEZdiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMrHudWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CC2C4CEEF;
	Mon,  5 May 2025 23:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486557;
	bh=M57+MGIitVlZ7L9cTp3dvP1dnfas3v/3MLvR3vJ6H/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NMrHudWygExBWmv6CFxQA2cR34+ZrxyOt1+m+c4AZ0NYFeOQFe7Hj6IS8RoDI2sR6
	 TYH+EtQSnjJtn4wV3iC++N3en86r7GzbwZdIjmxYmxK0pMby5OTkr2LqKnbrr+L8Ew
	 yScyTMJHLYC0CbXiW2d9KAg7mjTl7y5174SCVg9BIDp7j5hYhcJ4D5b8SbQ1UsoybI
	 jBot2Y6Sth067esdBfpvhOcTnZzwNHwRkZYgHGBa81lpgS/AG+1/PodEa+YeVGSnRt
	 dWmxxFQK3vQF2dbpE3mkJEV9BEeY23HmcLPJP0VVuAGMazgzQKV2Hcqrmw1z1qz5Eu
	 yynhJyGvZeFVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 090/212] net: phylink: use pl->link_interface in phylink_expects_phy()
Date: Mon,  5 May 2025 19:04:22 -0400
Message-Id: <20250505230624.2692522-90-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Choong Yong Liang <yong.liang.choong@linux.intel.com>

[ Upstream commit b63263555eaafbf9ab1a82f2020bbee872d83759 ]

The phylink_expects_phy() function allows MAC drivers to check if they are
expecting a PHY to attach. The checking condition in phylink_expects_phy()
aims to achieve the same result as the checking condition in
phylink_attach_phy().

However, the checking condition in phylink_expects_phy() uses
pl->link_config.interface, while phylink_attach_phy() uses
pl->link_interface.

Initially, both pl->link_interface and pl->link_config.interface are set
to SGMII, and pl->cfg_link_an_mode is set to MLO_AN_INBAND.

When the interface switches from SGMII to 2500BASE-X,
pl->link_config.interface is updated by phylink_major_config().
At this point, pl->cfg_link_an_mode remains MLO_AN_INBAND, and
pl->link_config.interface is set to 2500BASE-X.
Subsequently, when the STMMAC interface is taken down
administratively and brought back up, it is blocked by
phylink_expects_phy().

Since phylink_expects_phy() and phylink_attach_phy() aim to achieve the
same result, phylink_expects_phy() should check pl->link_interface,
which never changes, instead of pl->link_config.interface, which is
updated by phylink_major_config().

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Link: https://patch.msgid.link/20250227121522.1802832-2-yong.liang.choong@linux.intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phylink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index fc58e4afb38dd..3069a7df25d3f 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1566,7 +1566,7 @@ bool phylink_expects_phy(struct phylink *pl)
 {
 	if (pl->cfg_link_an_mode == MLO_AN_FIXED ||
 	    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
-	     phy_interface_mode_is_8023z(pl->link_config.interface)))
+	     phy_interface_mode_is_8023z(pl->link_interface)))
 		return false;
 	return true;
 }
-- 
2.39.5


