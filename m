Return-Path: <stable+bounces-46412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 186FE8D0478
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43268B298EB
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000F61C8FCB;
	Mon, 27 May 2024 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEFfsqxu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6281C8FC3;
	Mon, 27 May 2024 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819456; cv=none; b=BUewiRwQF1ZD3eteQO0mmrwq4ixKqRd7KB9U26MjsqWUgD6vbhYpbTbeZNxjv6o7uUQAXkYFluOXU0aq/mHqmUSeYsiJzc/jQG/HLcS12H/tfoxX+H3lhcKiwAZ63Q/y3eD8xm1vsHwQHOBfriUx/Bod9//JWBftBR7oPz7dklI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819456; c=relaxed/simple;
	bh=0VsCbmNruxupIb/bY5JujCUgbM95n3h1KT33gAeNu5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geugNhT2KjjOiioC7UrATrTaTIaLMhB/t0YbXfecMCviQRt/d7BUGbvGdB6nyBLvlBpqsvUmXDYn6q3z66D6DBPOwTAn5r8VC/YmjwwmFldGsNsdy9FWcGooo/3mk3/wy24K0+t6NIvHKujRP01C9YPKB7/JEcgS1qGGCVhjj10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEFfsqxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D67C2BBFC;
	Mon, 27 May 2024 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819456;
	bh=0VsCbmNruxupIb/bY5JujCUgbM95n3h1KT33gAeNu5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEFfsqxuLBiCVU8vGKRVrJqOQV4YhA4T+jbj/HBM1BKB+D9HjC9PNhKU7u9YkPa1Q
	 Kvipt5Ya3/YudTwte5X3U+es6+0hPRvTBDiTdze0ku9tYHfNqPgN4NuYpaJBdEEo/v
	 U3PT/Wk2ii2C+O5JYwHi4mg6IIYNfW7mI6PJnLMOgeopI13CfpA3V9lWROxCkwf6Wn
	 oFlFqWtmbILGtxeDrO7PJbbZxoLIIsIlu4gI+3fYVaWJ/MHqvKiuRyHKrRl/3c2up0
	 3i34MHmxxNxgB7gre0zoO0h08fDfzAJKQMWs3MgG3o+SPV7Tr+rhqh8nTordFVIlSQ
	 fpvRAv+YHDVYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/17] net: sfp: add quirk for another multigig RollBall transceiver
Date: Mon, 27 May 2024 10:16:43 -0400
Message-ID: <20240527141712.3853988-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141712.3853988-1-sashal@kernel.org>
References: <20240527141712.3853988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
Content-Transfer-Encoding: 8bit

From: Marek Behún <kabel@kernel.org>

[ Upstream commit 1c77c721916ae108c2c5865986735bfe92000908 ]

Add quirk for another RollBall copper transceiver: Turris RTSFP-2.5G,
containing 2.5g capable RTL8221B PHY.

Signed-off-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 9b1403291d921..010107d53ab49 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -413,6 +413,7 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
+	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
 };
-- 
2.43.0


