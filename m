Return-Path: <stable+bounces-62080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C6993E2C4
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553FB1C21120
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D57194AE8;
	Sun, 28 Jul 2024 00:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlacWLRF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C244194ADE;
	Sun, 28 Jul 2024 00:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128087; cv=none; b=JImBNhjfrHuY5OWPUk3P+mu8/4k5ilUzNuTkkaIUoh2RskvUIRs/37bLsSPulbfoY0tjfQ3EK3LomIhxgouTXicCAP8NJwstr6x2onHX3mAj4PDN+pyeiO/wEAPQBYYdkrRZBVwX51R4P6+eS1x5oY9/HTvrS5sPRSID6f7DJyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128087; c=relaxed/simple;
	bh=A1B1pETy9mu1bcOWk7QkxccDmQJheKKax2mhnK4pa4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQZT6eSyvcvoFuU2p4pVB6Fm/qU14doj/pD8hWRl4wqj3xqAAIMUvZH67Miz3lNDH6lrcYomaLEaIZRfQ770FGINUZTi8Oo19W+ThW8I5qgpBsx6hJGG037cwvJQxeVMBICdyuhkVZqC4wEcOubWZ1ogptinuPf488jP8ojL9oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlacWLRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43667C32781;
	Sun, 28 Jul 2024 00:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128087;
	bh=A1B1pETy9mu1bcOWk7QkxccDmQJheKKax2mhnK4pa4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nlacWLRF2mNRMoNFibB7pzqVR+0aeIEG7E4OznPqV7bw/K/iQl5fN3ibbLbzmWPGB
	 Hem9BXMwMrpQBz4fxkyhaTBRJQv5ajF+K5j7drvRyX6dyVkRJ/gb3y8oG7QFLTBoh5
	 P7d+u4Y1Lw+syA0X2pOcHYdtMarqcGdWKV9KXBV+FV1i3wz1jLbmhKaDFIDu8e69qc
	 wnN6Xsi9uklot107Rlzgxc7A0MSJAc84BMvJ5vw9ELB1ICNXkrMBd69r4iyFpyeqxB
	 D/WPJd6LMCdsyB5TQ7RsDssNw3dgTaZQj+qedf3W+7HAOUw/oOiCFhLqZOerGiWBoi
	 otF9Ppo0yJhwA==
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
Subject: [PATCH AUTOSEL 6.6 02/15] r8169: remove detection of chip version 11 (early RTL8168b)
Date: Sat, 27 Jul 2024 20:54:23 -0400
Message-ID: <20240728005442.1729384-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005442.1729384-1-sashal@kernel.org>
References: <20240728005442.1729384-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index d759f3373b175..dfd114845a3ed 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2135,7 +2135,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 
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


