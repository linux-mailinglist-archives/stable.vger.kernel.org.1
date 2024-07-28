Return-Path: <stable+bounces-62095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A84693E2FA
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864AB28208F
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22BE19E80A;
	Sun, 28 Jul 2024 00:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emX0fdl0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C017C61;
	Sun, 28 Jul 2024 00:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128127; cv=none; b=q+AIWkrZB2Zqjj7ggTdLVrvOO1f9lXUcyQLvrkk19ozE00XuOFEDMwXPkMYjkGBJumr3ewKxaJw4tV2p1U7rYikhH5MetB4SpGhFztG+R3x3iVc14LIJufhRvF35jyX3Y+08+ckp6zoKxp1LP7jHytZ39Bfi6t4/yxRjD7Ch31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128127; c=relaxed/simple;
	bh=HFuzLr5u+3JZM1cmw/TvSnW/58i7tvXYKKZPGRrQhdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8A982SOLSikOhefCoMqXPtTxuMrbelWstjmRtPsUSYE6YkQzm0geurKgvr4pH8f42xX98qsAJqH75pywJE/+Y3vR8h31tWTyJJToz3x3zTHXFJpr8gXMZkej+jqjvYJKuATlXWljnBThRarYZiLyRzFkkzmNXtMtJ92kyPdvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emX0fdl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AA6C4AF0C;
	Sun, 28 Jul 2024 00:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128127;
	bh=HFuzLr5u+3JZM1cmw/TvSnW/58i7tvXYKKZPGRrQhdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=emX0fdl0Q6YQQRD5gdZzghcSW3Xv/Uf5A/iTxpStQpn2uo7Cm45RAgxFcm2+rHZgA
	 CccHUn5IidzF6dYrHdd+urNqqOeq1cvf4ziBoTZtfQFsg/n1aQKbC/cGEavVkKc+D7
	 XSZcwS3N56RKQd2je3wUN00ZH4whtNAtJzoRil9xsEgLsffuMP1qr2IXGceOIRKMJ0
	 ZQ0XWPb9SE2FgyFleaHKfnPVTdyLm6gSEhFFz8BhGLz2VRgsSKcc/Y3kymIL8E4Zfa
	 0hP6afdBGjQB6JAbx18Qfr3duEbRks7gxRjA1+zUmuqHZaiD6c+8Gx6TzuTTS0ln3U
	 wp99lgbpQmZvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	nic_swsd@realtek.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/11] r8169: remove detection of chip version 11 (early RTL8168b)
Date: Sat, 27 Jul 2024 20:55:07 -0400
Message-ID: <20240728005522.1731999-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005522.1731999-1-sashal@kernel.org>
References: <20240728005522.1731999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 982300c115d229565d7af8e8b38aa1ee7bb1f5bd ]

This early RTL8168b version was the first PCIe chip version, and it's
quite quirky. Last sign of life is from more than 15 yrs ago.
Let's remove detection of this chip version, we'll see whether anybody
complains. If not, support for this chip version can be removed a few
kernel versions later.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/875cdcf4-843c-420a-ad5d-417447b68572@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index f83bd15f9e994..7ea47ee189614 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2119,7 +2119,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 
 		/* 8168B family. */
 		{ 0x7c8, 0x380,	RTL_GIGA_MAC_VER_17 },
-		{ 0x7c8, 0x300,	RTL_GIGA_MAC_VER_11 },
+		/* This one is very old and rare, let's see if anybody complains.
+		 * { 0x7c8, 0x300,	RTL_GIGA_MAC_VER_11 },
+		 */
 
 		/* 8101 family. */
 		{ 0x7c8, 0x448,	RTL_GIGA_MAC_VER_39 },
-- 
2.43.0


