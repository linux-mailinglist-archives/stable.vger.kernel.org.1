Return-Path: <stable+bounces-127842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DDAA7AC48
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA05A1899459
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012C926FA53;
	Thu,  3 Apr 2025 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3xsnZng"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFEB26FA45;
	Thu,  3 Apr 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707216; cv=none; b=fgxUF6kbtokfU0bnFZPgrwxdrACe5HvQYpCGanODSPAtcOjwuva8a4MMh6RyP8WaJQsQOmuDVGMqBNM06cDNxGDqXtPlOUDe3qCexekGg+GgZ9DDSlX9E+RRzQs8YaGhvfMXQw6kkT2J6key3iF7NxmxWrHYAyA/VXS6f38ZOdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707216; c=relaxed/simple;
	bh=biff+y5CO/LGp/6H2MKDDrr1C1tIENa+pvU9gLtDvNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IB8IsiMWK2EbXvXgoUA7+JCuVAkaTRUsRBStXHi61ACMlbSBMko2fe06h45BOdPSPmObNeVz7IoYfa9RPLB5F4kezQ9ZFoKRZ0cY9pT/7Aqm8BEe+udsCEz6oq+PpSwkDJL5bLxiSrisWbb8YzXQsv+jl4kw9whv+TdBq0V0bjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3xsnZng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30670C4CEE3;
	Thu,  3 Apr 2025 19:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707216;
	bh=biff+y5CO/LGp/6H2MKDDrr1C1tIENa+pvU9gLtDvNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3xsnZngJbpgt5uQP5sxng9Mziasi/H4pxAxTHRMnOQewj2HlSIlaiWP2ONuveMkK
	 o+qqKp9oa57D+2KwBcZowxed3ktHszB7t61sitsomHtSkY62sc8LmpLdAzSpoSKCF+
	 t6YX2q74Zas6vd3mEm7BnFmDf04OB89SrqhR0txaYUSrABCBv3s+ArmTraI7WDTet4
	 US7otHs2xkZrpzGnN7SW0Rgfw/K/qwTa/iwgwHjrGTNLt9cD7ZZI0vsxdBhdAuTtLH
	 97vgh39oLWd4IgDIyfzu6RUutlc5kSAE+m1EnpndRawOYv4NPnM/68UQf4Mvsk2e4V
	 om+KYUvkR8uCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Birger Koblitz <mail@birger-koblitz.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 24/47] net: sfp: add quirk for 2.5G OEM BX SFP
Date: Thu,  3 Apr 2025 15:05:32 -0400
Message-Id: <20250403190555.2677001-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Birger Koblitz <mail@birger-koblitz.de>

[ Upstream commit a85035561025063125f81090e4f2bd65da368c83 ]

The OEM SFP-2.5G-BX10-D/U SFP module pair is meant to operate with
2500Base-X. However, in their EEPROM they incorrectly specify:
Transceiver codes   : 0x00 0x12 0x00 0x00 0x12 0x00 0x01 0x05 0x00
BR, Nominal         : 2500MBd

Use sfp_quirk_2500basex for this module to allow 2500Base-X mode anyway.
Tested on BananaPi R3.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Link: https://patch.msgid.link/20250218-b4-lkmsub-v1-1-1e51dcabed90@birger-koblitz.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index dcec92625cf65..9a5de80acd2f7 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -515,6 +515,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 
 	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
 	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
+	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
-- 
2.39.5


