Return-Path: <stable+bounces-46332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C66988D02F7
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6765C1F21F39
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3240715F3E3;
	Mon, 27 May 2024 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCjH7ER+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE52715F3E1;
	Mon, 27 May 2024 14:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819158; cv=none; b=A+NxxYBwT/hiK3yePaPZBMiIVwDSbWqUBrHjpEjek7ZKuvAaXdZxAdtntccykMC58GSkMVfNF2qdMJ35Tqd6c31A7cxRMawYsby34RZPY3fz4ECjnMM4P8ZzOBlFLS/hGLIvofiwYvSdG/dQrnkC54UThV1D9FH+eKf2FJ1aHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819158; c=relaxed/simple;
	bh=ipdVRS8ScoHWmhSb3/7HjtF4soPF3OSter9BKeL3Jeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZGOpqtfPFharAwPy9IjYW+/yu1QRexTHrBD6qkZXpK8AT1bycRA2xdrNGHmv6QPgM5F4VzCQeHawRkeNAMKibr/yWVvMT5O1Js3j2iMKRXxqs7/OMs6nyM080RINX9vDIxxQxqojPKzxOQBZu8WKDzBocS9U6GBrIEDzAl9W1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCjH7ER+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BD3C2BBFC;
	Mon, 27 May 2024 14:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819157;
	bh=ipdVRS8ScoHWmhSb3/7HjtF4soPF3OSter9BKeL3Jeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rCjH7ER++bsw683Z0e8weZZcfLnj17sSFpc4EZIDTJXLLFK/AUICJqgkStGXBlyRM
	 SMd8YZO6xuW15x1sI2m0rd7ZoD/R7G2lBQY5U0O556o7NXnFqAS4e4l+hzWqt6QaLg
	 9N/wqP2mEUxztAVYSopPraBkI5usBfCkOIrEXuXgpdIDkT1MV7NQiGr2JprMHmyCmm
	 5RygfcLvRDbYKaKoTGx/v4rAVRFbvrWSl5joPIRdVvrQSdREXseAoUL7kq1fj3rFyT
	 ThQHwczC9PWMEnlDZbUJbWsLPlmxeYdvNsOekmhGL3Q0NWT279g5CJ4VRTWramimGL
	 XXnE5hxR1qsCA==
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
Subject: [PATCH AUTOSEL 6.9 12/35] net: sfp: add quirk for another multigig RollBall transceiver
Date: Mon, 27 May 2024 10:11:17 -0400
Message-ID: <20240527141214.3844331-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141214.3844331-1-sashal@kernel.org>
References: <20240527141214.3844331-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
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
index f75c9eb3958ef..6e7639fc64ddc 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -506,6 +506,7 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
+	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
 };
-- 
2.43.0


