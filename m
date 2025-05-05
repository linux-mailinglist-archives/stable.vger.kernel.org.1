Return-Path: <stable+bounces-140059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B331FAAA476
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499387AB3F1
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0656D288CB5;
	Mon,  5 May 2025 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0Ob9kcs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55A9300A5E;
	Mon,  5 May 2025 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484000; cv=none; b=hGOUBd7iBpnRmysXZfy7lHoKVRHOrsUNILHwkYg0hpiqhR9//KavnYf4eCgRwsjHbeD9xiCYurE4wtFtpBVwLkkg1qoB/NBIK0zQhmagbL15TlmsBkGZCbFJSXF2ZG4NLMCmgnWUrVCKXe2WAsv+cspx3fj8ZUkiVBdKzSH9F2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484000; c=relaxed/simple;
	bh=0Dw+TlmbU7HZaO2btYZNwOIWdoCbStzZgQMRrDQiPnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XcKUrHI67cDD2yO34CI06BQOqtAAeFO5bQodN2ctsJ7Ipc8qHiaaGYVKUGSRrqC0TqfJaIHZ8w3A+crs/TWXla674BelOWh80dKvg+aGiHtpV8PVPrWtPCg8vGo6FQTdkflym4nyqjT9OE0N65UzlCSUErcD6Ru8sY4g9sMc96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0Ob9kcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BACC4CEE4;
	Mon,  5 May 2025 22:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484000;
	bh=0Dw+TlmbU7HZaO2btYZNwOIWdoCbStzZgQMRrDQiPnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0Ob9kcsdbw8uERpLIRGsw/yJeFl3G08bQC/zWeGCc6Z3cGt++ETzR1XrHXCIvhR3
	 rSYLpW5gB3BG6GWIztb678KSYgJj+UJ7YDbyhJm4cKtI6BtZqD+V9N44EcnGwbbTn4
	 jGLnVfleqNs7IFF7REXSqHVoJp2hIOoQUyQhJjt9VqII9ZQvJy600PLI2vzXr+by0B
	 OLLOCYhb8tCjhrGYEAr9uRtv+YhhsZkevIfmjQHEUthJZCB/IiBFsnvgNqs1F3AnBh
	 60uzEH6JCFSR1zxjnPUvg985ota4DvJDbZK9eZLSMnGrvM3IFcLCM4pM0uZEoTxDAZ
	 2/LdrUcff2McQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 312/642] bonding: report duplicate MAC address in all situations
Date: Mon,  5 May 2025 18:08:48 -0400
Message-Id: <20250505221419.2672473-312-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 28d68d396a1cd21591e8c6d74afbde33a7ea107e ]

Normally, a bond uses the MAC address of the first added slave as the bond’s
MAC address. And the bond will set active slave’s MAC address to bond’s
address if fail_over_mac is set to none (0) or follow (2).

When the first slave is removed, the bond will still use the removed slave’s
MAC address, which can lead to a duplicate MAC address and potentially cause
issues with the switch. To avoid confusion, let's warn the user in all
situations, including when fail_over_mac is set to 2 or not in active-backup
mode.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20250225033914.18617-1-liuhangbin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4da5fcb7def47..203d3467dcbcd 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2551,7 +2551,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	RCU_INIT_POINTER(bond->current_arp_slave, NULL);
 
-	if (!all && (!bond->params.fail_over_mac ||
+	if (!all && (bond->params.fail_over_mac != BOND_FOM_ACTIVE ||
 		     BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)) {
 		if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
 		    bond_has_slaves(bond))
-- 
2.39.5


