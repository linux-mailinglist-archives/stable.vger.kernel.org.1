Return-Path: <stable+bounces-140609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 360C2AAAE3A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7527B3D55
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BEA2BFC63;
	Mon,  5 May 2025 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv6slrQ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4BE27F4C9;
	Mon,  5 May 2025 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485272; cv=none; b=Vv7JigB5GsPMeqm705mbLKaTMa6R3Rznjaa1x4I5h9pt3csdOdSjZDoMzBODJzAh64Ysii3RUtAIU9LYgwYHk5ySGCFugPhqDp7kMjDh+lqeuHaUf955LPII3DEAx3zow9Mlfqnnd4kU72fEi4zAQEdIkBVU/9HlstZ7b/4Uj2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485272; c=relaxed/simple;
	bh=/SHsAolBGXlNCIBtpLLAkQTtEBGdSSCB4TNjucA5LtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LthaRu5ZEElFKvKjqvWQO12srOQd5phRX/FwcKLeq49G1MS3MmZcUDLRe3vwNAeNMGCR2+GKhWSSN9zjwJbRPfbbB2wOXARSYPQ6Ovq3xoZdd7T77UzoPTHgza3PBdK/MqjvPfabXBEoKqiOnnFKXvJOvFubHboQ9ECgy2QC+Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv6slrQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D114C19423;
	Mon,  5 May 2025 22:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485272;
	bh=/SHsAolBGXlNCIBtpLLAkQTtEBGdSSCB4TNjucA5LtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cv6slrQ31+e0FE06qHUCG/FgxHzUDzcCAV8tPvtQCelkqenByLVu2BMn0U0zBSnbh
	 zGDWJZ+Fjjv0PxM6a0tYEzGdUPVvyOopwMrZOr8bMUTMx+0UILy20EmbeFHm3C8n69
	 tnPEFXZ3b18he1whtpO2jZ1ubl1gE2oc6yKhP+jPFhdPvUohxQTocA/VoFoYu/ZxQz
	 8po2zWXo1i4zgxj7PNRpaZEwkesb8TlcQ7ekLeh4mV78e7knnj28lv5on8afebzY1z
	 ylgUusNniBr3vFl1YTXn3k+qx5yJ4P2eXXo9cq/u+usrC4Tw03qKH7ZZguZ1EIZVjj
	 ui+JgvBhsAVNg==
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
Subject: [PATCH AUTOSEL 6.12 246/486] bonding: report duplicate MAC address in all situations
Date: Mon,  5 May 2025 18:35:22 -0400
Message-Id: <20250505223922.2682012-246-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 4d73abae503d1..4d2e30f4ee250 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2542,7 +2542,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	RCU_INIT_POINTER(bond->current_arp_slave, NULL);
 
-	if (!all && (!bond->params.fail_over_mac ||
+	if (!all && (bond->params.fail_over_mac != BOND_FOM_ACTIVE ||
 		     BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)) {
 		if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
 		    bond_has_slaves(bond))
-- 
2.39.5


