Return-Path: <stable+bounces-46396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E86F8D03E2
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B4A1F20EFC
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AFB199E93;
	Mon, 27 May 2024 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amDYMmwY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02B9199E8B;
	Mon, 27 May 2024 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819385; cv=none; b=Fcgms0kGI0JWo0QqvbykTqVicLGJL2AodgrBRDjFUPKxC+94P6ShwToem8I4+KmkNfhjrFm5sGGxPra2EmTMS6iPtLUkiqP7jH3kN6U15eyur0bunqg6dm5tCF34slP5TIwZ0EhwClnDp+s6HUaBBPT3i5KeBLWOM3EgRmDdmvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819385; c=relaxed/simple;
	bh=Can2IdNu0X2Ceo51lrTYJj4NxVeEvcYzU2ZY71cXhJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKC+hGYXbEB4RcXKI5OTWXAh/5o+3luepNAUTrZBuEBzzvlcKQJW5rPwhKtCfJl1xLEMMTYkVd30gwL0mJoyU86f2d8LhsbVIuzUE2cSrslqWizG+h+3vDDIzpUCsoMWyF9PurIIM4wvvS7r2ZKeE+FIxpg/4bTUsKTjjR/SygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amDYMmwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B49C32781;
	Mon, 27 May 2024 14:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819385;
	bh=Can2IdNu0X2Ceo51lrTYJj4NxVeEvcYzU2ZY71cXhJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=amDYMmwYGYp7Qd1KHYoamawnDlhomOWR1MR/9IeoMRmvcxKy6z1PfyY0yZYQVi83n
	 5yG8sHIZAN+/qeei+8rmVSIifJB2tbNU8HdEMenjrfM9a6nJilqTIimQtyz0UzwQ5k
	 HQNqSncveS/u67NBQxgjfgIqR2rIxmez8gbMMf0tHPclNM1OZvMMXOp7su2bR5qJNA
	 uxUERhqpEqmDVEBzGRGtdfElb7B0uyZ5ByPuv96fTQtUC/XCCx9VAI2AkvJqVbcEDf
	 yIApzW8GMJGB9E/vtnTohDmiXl+3eYyUjd9ItJAHUw2RxD2zXQD5SCV23OQN//Dj+l
	 m+8GCEnLB7lFA==
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
Subject: [PATCH AUTOSEL 6.6 11/21] net: sfp: add quirk for ATS SFP-GE-T 1000Base-TX module
Date: Mon, 27 May 2024 10:15:22 -0400
Message-ID: <20240527141551.3853516-11-sashal@kernel.org>
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
index c1a481b25a120..000bd62ac0712 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -482,6 +482,9 @@ static const struct sfp_quirk sfp_quirks[] = {
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


