Return-Path: <stable+bounces-140732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7005FAAAB07
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A193F3A5249
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A04638CEB4;
	Mon,  5 May 2025 23:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4zIygeo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15238C411;
	Mon,  5 May 2025 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486091; cv=none; b=JyajLG99dwSQgbBkDo8MHUvLa13hZ8Qh8dgPEPKcS8UYjWTOmhzClf9vCMIStFT0g4FSu4x8HRbMUOm+xGaZ0vTUqP/o3Vkr0+QCOUN08HkzZhEiphII3t67cfzZLlYw4ALypIGvBj95kyPmP0L0VT+LA7eXl1em0weTX82CHZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486091; c=relaxed/simple;
	bh=7vZJ/qgoHpmHGdqWagURVrg/UArHS/UJRLHVDnt/V3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEhGkaJV9YiwpO5kMS8fpQb1WZWRerCTVDfaY3Neb42AIAFeSCnCF1c/P3k1XpWAaHae0aaUCpu20VkH00qaYE8nYfJM71P0imkUjUQdbo06/ReKbIp01JP12Y9NusANIIaVQ4+CA180p8Jjy44FftelJ3gQUP8OOS+uVffQhks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4zIygeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEBDC4CEF1;
	Mon,  5 May 2025 23:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486090;
	bh=7vZJ/qgoHpmHGdqWagURVrg/UArHS/UJRLHVDnt/V3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U4zIygeoytiXMsrrGgg5YnqMZg99sApFMjBd3jFAx+/d2Gl+2wmiVmsA6udz29fn9
	 mNcxrhG/y+PvySSGtrvV33Dx6geLS+sUX0RbBFhT02jS+G7C2Wn/FT9MCJEEfI74KU
	 3ekuED9nm8DKa+yMR5tKgcQ1jWtqN8YP2LbVTNv7m2gZv7SAy30dsR+rnAs/qnmC5K
	 6HmtDY4+75w+/q4PWJlm21lWdz7IbckebY+2qrpvSZ2XkKsm5G8I88JmG7Lmajw+Wi
	 s8LucJQiwgKRzRkXV+BOTrSlt+9fc4O/BOEPYVsa4yiemjeZpv84tbKs4ZSF7SIF3s
	 ctAO1YGGJxjwA==
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
Subject: [PATCH AUTOSEL 6.6 150/294] bonding: report duplicate MAC address in all situations
Date: Mon,  5 May 2025 18:54:10 -0400
Message-Id: <20250505225634.2688578-150-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 7eb62fe55947f..56c241246d1af 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2469,7 +2469,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	RCU_INIT_POINTER(bond->current_arp_slave, NULL);
 
-	if (!all && (!bond->params.fail_over_mac ||
+	if (!all && (bond->params.fail_over_mac != BOND_FOM_ACTIVE ||
 		     BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)) {
 		if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
 		    bond_has_slaves(bond))
-- 
2.39.5


