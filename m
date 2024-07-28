Return-Path: <stable+bounces-62105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F30693E31B
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6032821C3
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2947144D16;
	Sun, 28 Jul 2024 00:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWCUQmtM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCA51448E0;
	Sun, 28 Jul 2024 00:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128153; cv=none; b=i6tG8Cz6ZQE1FITAutZSrjr9msAH0QV2uxvK94a+zY77Nza4IvNlYep06BBlYdcl+bDOi0aB+mFTBN4+iEtR3GIBcSyVwN21yzGy2vjc5WtuUQNgkiB+LEt7LmonnaWS2IQdqAKrdHwT67GBOJm+QZuxNYyv9yLtSckMstM7w/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128153; c=relaxed/simple;
	bh=AtOypMrJH3W6eFp8TztixhTbDabUJbIX1xRP7MiIJpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qsPuPYZSIGkUZRyCbwxOG06lWAymLOl/RpQVWgClcVSwYhSZJZ1tC2j6c2GcDRhv5/NTg8DdUmjA80xO7zZ1XkZD88Qk0dwUPQ+9n8qN3WOont91RErjQMcQ6s9PtqAf/v9wtDHgOG0n+Fiy0etw+TWxuEhGrkgJVTkgRaqJlpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWCUQmtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DF7C32781;
	Sun, 28 Jul 2024 00:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128152;
	bh=AtOypMrJH3W6eFp8TztixhTbDabUJbIX1xRP7MiIJpI=;
	h=From:To:Cc:Subject:Date:From;
	b=pWCUQmtMCW/MeGqgLCpvLN8PbJ5m7BuN//GJ68RLTtcs8Jgv3ED84T7Nz802LtLds
	 xb6E+JEtfDpykgiN86odLd6Xky9qslKPIFafHBh1CymcQeD4mlLqjDR3lte5KPba5v
	 WKGpNHMugreVM7t0JFA6o/xDueuFosmsYLMHHePszo2iJuohO0ox3vjKoqhyjDHzti
	 ORZ3Af2Yub3KdO3pcZdt5UZqkvEgHUpCZropSiLtNhmyIFWFKZTFQB2PZN0VtPdmHa
	 iEpfZr8cQC/0eg25hx+kYnF1IGPp+n00tq6PNxEv5kgbWS4zE53t9qTO7T2u2m5zFF
	 W9pTafoDf2WCw==
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
Subject: [PATCH AUTOSEL 5.15 1/6] r8169: remove detection of chip version 11 (early RTL8168b)
Date: Sat, 27 Jul 2024 20:55:42 -0400
Message-ID: <20240728005549.1734443-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 76d820c4e6eef..c0ad5cd963d08 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2063,7 +2063,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
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


