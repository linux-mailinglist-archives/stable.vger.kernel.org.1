Return-Path: <stable+bounces-46338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A6A8D030A
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9F11C219AC
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F050416D4D5;
	Mon, 27 May 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDwQ7ISa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98DD16D4CF;
	Mon, 27 May 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819167; cv=none; b=a+9Rae3RiXjvREigEIZCr+J2tPvngBsOSUmKZALGOv7oLAfCABSbxsIh6n3WU8FwwwnuFLrWg4hEvbWwea3eazbuWtSJf2hPciLMSCela7ADgRMEwyPrAyK1XUSV5Q6VgquU6UaI9Ugyd3dQZWiRDOCxXRkojZ8YtWnJufeVy+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819167; c=relaxed/simple;
	bh=Yo2D0N0Wkdv82msXAa+IWmFsX/qer1p04Wv1/gT7kZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uK4fvyaLFYnYqf4l1J2hmlZzav1JHWDlKGqaTrOSZ9gshSWLo/7fU5ID/kzTNQlO4X5JBwG94lcX9hXp6M/shMFA/UI/syd611VDuQNs7tC3ib2dF/NiOE5Xavd9c3fO2mLzpFLnR9h48o+i19BhguQgBxD5MG22G7JtapfrlF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDwQ7ISa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0ECC4AF09;
	Mon, 27 May 2024 14:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819167;
	bh=Yo2D0N0Wkdv82msXAa+IWmFsX/qer1p04Wv1/gT7kZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDwQ7ISa6UwUBr1i8pJdafais/7koQiA3obVnCZzaK05/0bSiVR8i1OLiOz5ai8gC
	 LnokTdVxgVh6YghA1lE/UptBre8wpU/FzPBGvWVQ4oDFiAAQ7GUh+D3XrRi8O2MHBV
	 jQ3UVam7sULMfFBgnavWNAuIFXgHbFS/bkudtPn21Imh0f7B1OPpe7zdAhHxBJhsR7
	 k/aMtasrtm2zALMiorItTWdhgiIgYCvbNsvhQhbgoqPcnlzLBThOGt1P7v1n2heHkv
	 9GJJrzKeaeuotntPpxbduL895ePsxlGde4JMXviAkrA2CJBQs3LkN8Do+enk/cxDkf
	 y4jUzvRiIA5bA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>,
	Josef Schlehofer <pepe.schlehofer@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 18/35] net: sfp: add quirk for ATS SFP-GE-T 1000Base-TX module
Date: Mon, 27 May 2024 10:11:23 -0400
Message-ID: <20240527141214.3844331-18-sashal@kernel.org>
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

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit 0805d67bc0ef95411228e802f31975cfb7555056 ]

Add quirk for ATS SFP-GE-T 1000Base-TX module.

This copper module comes with broken TX_FAULT indicator which must be
ignored for it to work.

Co-authored-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
[ rebased on top of net-next ]
Signed-off-by: Marek Behún <kabel@kernel.org>
Link: https://lore.kernel.org/r/20240423090025.29231-1-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 44c47d34a5c68..8b316baf6305e 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -508,6 +508,9 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("Walsun", "HXSX-ATRC-1", sfp_fixup_fs_10gt),
 	SFP_QUIRK_F("Walsun", "HXSX-ATRI-1", sfp_fixup_fs_10gt),
 
+	// OEM SFP-GE-T is a 1000Base-T module with broken TX_FAULT indicator
+	SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),
+
 	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
 	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
-- 
2.43.0


