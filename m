Return-Path: <stable+bounces-204346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B89CEC097
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 14:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B77FD3007CA0
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D589531691E;
	Wed, 31 Dec 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCnGyVC5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F2423185E
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767188805; cv=none; b=s3uasPVR9UpThsdcoRenYq6DgckBEtGJXVAmvXDfpiRvVIA8rvsCVi04hWLhYhidh2TtVxmwtAbYW+9PtSzo90Qn4ijxOsrLGxFhRinB2NHwYLZTq9+wB3QewoodZKnYkBCFWo8jKtSkPCtjtjdN2IcSj1B0s1OfetXWzzlC3GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767188805; c=relaxed/simple;
	bh=F6UAQEVDOjWn3V1v8A7KHj3aosvOIwlHnPmPkbmgNW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIi9zlL6uis6Uq/y9UjrUZtaE2T2nhowoOSGE8/GMRoeB4fMBeTbwLURnimJwD8XOHo2cGEre0dKgVbclL7BcKVyUMYNgvv4QJYzt3+BwJwHV407q2TIixrawok/Hi2KXrJ2mPkrtuTyEa2sVXR2R3jWz7Hj8EeyyIoPrMaHgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCnGyVC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BA3C113D0;
	Wed, 31 Dec 2025 13:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767188805;
	bh=F6UAQEVDOjWn3V1v8A7KHj3aosvOIwlHnPmPkbmgNW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NCnGyVC5tC3IGD5sgqr2eT8YVOGb1ALtY0SMMVMBlhu5GyudujpJprFwqZ2CmEjFh
	 bqBIe5d/BjrQ6JAn+o3/1vkdmoQZkpYJnQ9S4BsIPELnLW6byWwSrqQ6BoynaeFIxM
	 lpIWSr/D47k3o95TYftdQacwH0ROTD6pFVWJXbMGJov18AKN9hnSPzUKUSR5rQQIr2
	 Cbye7awudj34lWkf7DRuTGjDnqhulj0fTKz8AqWWTGshcid9lpr41VP2blt3kTAoZe
	 7E5hcOosVS2jDF50d1PsiTq13VcBka39w1l3mXMNV58zbcYqfOu+Xkk+jH+NjaeNHw
	 g3+iS0gZpOkDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactco.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] r8169: fix RTL8117 Wake-on-Lan in DASH mode
Date: Wed, 31 Dec 2025 08:46:42 -0500
Message-ID: <20251231134642.2899730-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122945-mold-ducktail-63db@gregkh>
References: <2025122945-mold-ducktail-63db@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: René Rebe <rene@exactco.de>

[ Upstream commit dd75c723ef566f7f009c047f47e0eee95fe348ab ]

Wake-on-Lan does currently not work for r8169 in DASH mode, e.g. the
ASUS Pro WS X570-ACE with RTL8168fp/RTL8117.

Fix by not returning early in rtl_prepare_power_down when dash_enabled.
While this fixes WoL, it still kills the OOB RTL8117 remote management
BMC connection. Fix by not calling rtl8168_driver_stop if WoL is enabled.

Fixes: 065c27c184d6 ("r8169: phy power ops")
Signed-off-by: René Rebe <rene@exactco.de>
Cc: stable@vger.kernel.org
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://patch.msgid.link/20251202.194137.1647877804487085954.rene@exactco.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adapted tp->dash_enabled check to tp->dash_type != RTL_DASH_NONE comparison ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6b5bf7d49296..d272e77999cf 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2513,9 +2513,6 @@ static void rtl_wol_enable_rx(struct rtl8169_private *tp)
 
 static void rtl_prepare_power_down(struct rtl8169_private *tp)
 {
-	if (tp->dash_type != RTL_DASH_NONE)
-		return;
-
 	if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
 	    tp->mac_version == RTL_GIGA_MAC_VER_33)
 		rtl_ephy_write(tp, 0x19, 0xff64);
@@ -4763,7 +4760,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
 
 	rtl_prepare_power_down(tp);
 
-	if (tp->dash_type != RTL_DASH_NONE)
+	if (tp->dash_type != RTL_DASH_NONE && !tp->saved_wolopts)
 		rtl8168_driver_stop(tp);
 }
 
-- 
2.51.0


