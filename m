Return-Path: <stable+bounces-62117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A061093E342
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DAC1F21EAB
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04571145FF9;
	Sun, 28 Jul 2024 00:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8oBLF0m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED6145FE5;
	Sun, 28 Jul 2024 00:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128186; cv=none; b=VQ5u2nn+tVpra8fYd2fN439C/n6qf4qD5AN22lBgxZxR6CDENYCOoMTEqzOZoYD1JBVMVscEp5VvKDOH4qVgy8g+HWK+u6qmYyr7Q3mu52f46w6shkKshe85dEYF156VmFfZNTYKwYvjGjWzluiPQgSXkn8P+cG38iT6TzMhx38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128186; c=relaxed/simple;
	bh=ikeuWCXrxjCQHltsyiY2pA1siT/zUcYoD+54RCZZhQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DkLJyjHUgIDeDNEygaDYb9dYcLoEsqUgYR6guzqeQ3XMwu9jjBhooijfvLezBhCeleZqoE6yrbD0fvlmExMFF8XD6J5ZIyabEYNC9LRFdtfqAw+nckCNLGlS0lHR7tH8W+swYHpV+G6LknVJVTkI43wuBbWOmcQ0coQRkHeX4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8oBLF0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BFFC32781;
	Sun, 28 Jul 2024 00:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128186;
	bh=ikeuWCXrxjCQHltsyiY2pA1siT/zUcYoD+54RCZZhQI=;
	h=From:To:Cc:Subject:Date:From;
	b=Z8oBLF0mACAbg0m9LeQMKXJeprb1xfQCIZ2eCxr2gH6jhM5kaEJCXZAcRrWVYin0x
	 p7zqT2KTo1xMaADsF0C5dG5VbUZyXo5pb6tmjPHYCOuoT4s9fNr4KghyobCd5gOPmA
	 IZJTZpYvrm9caztoeWehboU65Pzx3YlsZ0D7WlaKX0F+gk7LFY42RPJwlNtSF13OPo
	 p47EmNrRwOfdCrCn35JWLkVTpJPG5lSUd+AJxDO0mlwVsWiDwOGSPECINESEL/Ku6y
	 z5oxUlPAdYYqiY7YvgCBSEMGZ5ovu2bEPKx0oyuQ8b6i9I+3n1fddHzN3ZXhK8i52Q
	 lPFuPQ14EWrqw==
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
Subject: [PATCH AUTOSEL 5.4 1/6] r8169: remove detection of chip version 11 (early RTL8168b)
Date: Sat, 27 Jul 2024 20:56:14 -0400
Message-ID: <20240728005622.1736526-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index 319f8d7a502da..32ea1d902a173 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2185,7 +2185,9 @@ static void rtl8169_get_mac_version(struct rtl8169_private *tp)
 		/* 8168B family. */
 		{ 0x7cf, 0x380,	RTL_GIGA_MAC_VER_12 },
 		{ 0x7c8, 0x380,	RTL_GIGA_MAC_VER_17 },
-		{ 0x7c8, 0x300,	RTL_GIGA_MAC_VER_11 },
+		/* This one is very old and rare, let's see if anybody complains.
+		 * { 0x7c8, 0x300,	RTL_GIGA_MAC_VER_11 },
+		 */
 
 		/* 8101 family. */
 		{ 0x7c8, 0x448,	RTL_GIGA_MAC_VER_39 },
-- 
2.43.0


