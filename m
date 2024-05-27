Return-Path: <stable+bounces-46393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 460598D03D8
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7746F1C21659
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304DF190681;
	Mon, 27 May 2024 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUfP1HQv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF429190678;
	Mon, 27 May 2024 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819380; cv=none; b=ADBOGKmgmskkbSfhvwCTZqpjMgNod2sWxBn+DHMbm3k+9HTog+QHfCOWyiNGc6GRwFEOvNxrQtGXzb4UmXTjZIlcw6CVQvbDcjW9tmKUdH/4xBOuda/LoWKHGJL6o77u8bZPLqpSwBVokbk+g0res8Soe4a7aehatGAmnNc7haE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819380; c=relaxed/simple;
	bh=ienhWxL0nifnR2BV4FJfNecXkeTTxFDFIofd/LZnwf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6MjCM2WWv/pjDb1CerrTGZL4Wuc5i5gcxHcERo084o0YwCuA2n42Degvb40JjXUdLagI6/vamRuB89oCqTR4eQtjdBc6s65QIIBQHkQHGUSRFTCCyl6kjaGU829Bnk0TKPKxYa2DGajFMvCEMWnZXKJZNUuFP5CuR/C3QO8r5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUfP1HQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C85FC2BBFC;
	Mon, 27 May 2024 14:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819379;
	bh=ienhWxL0nifnR2BV4FJfNecXkeTTxFDFIofd/LZnwf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EUfP1HQvXMjwdwOTYKcTbp31c3VjU40Cn8iJE4bSCGnFn74QxQorI53jcqi8jNBMJ
	 RDmko8LUb8NjZP4zJKExiLlY+mvcYUeXaLQC4GxfeZVjV08jc+YtuFbgX3iMvld/vM
	 3fxgvcyJJRr9e0JIP/NQ+UHLDl0Vpw816HPooMG133R+MjemJVyKSwFS7aYDAB6k3j
	 Y/bKJuKDmx3vqJ1t5F5Ilxi0wusTuNhLvrZVadEPF0mdLPHlQn11x6jUmJuBFiORGe
	 aIvpbzBPHynwlCSu74I+f7UHkVVZaruJWJGfIZe1O1IuaBG7mtchfQJ6ABgA0CmRLt
	 K3MEMULBlPpDA==
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
Subject: [PATCH AUTOSEL 6.6 08/21] net: sfp: add quirk for another multigig RollBall transceiver
Date: Mon, 27 May 2024 10:15:19 -0400
Message-ID: <20240527141551.3853516-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141551.3853516-1-sashal@kernel.org>
References: <20240527141551.3853516-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index 3679a43f4eb02..c1a481b25a120 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -486,6 +486,7 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
+	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
 };
-- 
2.43.0


