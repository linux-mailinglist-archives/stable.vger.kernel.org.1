Return-Path: <stable+bounces-46370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254B98D0381
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50D72A57B4
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4C0176FCE;
	Mon, 27 May 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qtxb8lDY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B08176FBB;
	Mon, 27 May 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819287; cv=none; b=BFiGf/TqeobGfodHFN/srrUXg0eSN6G45HL30J9AdfH1oAtuJgfJKyav906eL7zn3imoNqczOoEVOrXoIToj2tiVbRZIOyWynk9bOADbWyLUTNofMGGBTQKMDbWKN06uPrWiq9NrBd8/nW96K095fAoHoUyipz45wctLpOPE+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819287; c=relaxed/simple;
	bh=Yo2D0N0Wkdv82msXAa+IWmFsX/qer1p04Wv1/gT7kZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMLYHzyJYuEo+e2r/8n0jkwYiLxFHF6eeaA3faYrQazyPj4O4ULKVuuU0sqUSifl4/BDk0SeNbTdNnpCBCODYP9mbrs6wgBrJIQ38QqtKLOBxa/XQSkrORoum8lOoldXAiIHDepu36Mdy9jpMfZjCl99gMNr2uN6ufGGrWmhAns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qtxb8lDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC39C32781;
	Mon, 27 May 2024 14:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819287;
	bh=Yo2D0N0Wkdv82msXAa+IWmFsX/qer1p04Wv1/gT7kZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qtxb8lDYs2uhKArynQL72ws7M+4Rd8Cw+QyZyW6OBkzFyi9ayqGDEzbV1aYBBWy0+
	 JUDonL46b/AFO22zPHIhSYl6nP34nsUazauT4u/xJzBZKut5/2q1IQ8TLCe6A293xr
	 JLowyXH4pR5Bb2dNXctDYk4+5j/JE6WSeqYygcPLGZew0nLGECQr00riL5VS8KPxvT
	 BSBf3P42q8V0oBfHju+SXzISjFBIAxK0d3X/qze6cj9h9Np3I+DDpknwQP0rZCQL3P
	 5rk3d3RUJkRAtoXQs6WKc9AAQg7JtfZfVgLwsUiK/OcO2X6rLvlqkAzse3mkltrYmd
	 k/O3kvp4LLJSg==
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
Subject: [PATCH AUTOSEL 6.8 15/30] net: sfp: add quirk for ATS SFP-GE-T 1000Base-TX module
Date: Mon, 27 May 2024 10:13:24 -0400
Message-ID: <20240527141406.3852821-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141406.3852821-1-sashal@kernel.org>
References: <20240527141406.3852821-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
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


