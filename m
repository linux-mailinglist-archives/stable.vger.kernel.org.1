Return-Path: <stable+bounces-141005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B68EAAAD36
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB7E189DAAA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD343E657B;
	Mon,  5 May 2025 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXqVR+YS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C552835D7BB;
	Mon,  5 May 2025 23:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487217; cv=none; b=C+9WpU3OP1bcPMgijoMq4oX0YVV2q7qXaL2t6JMbLJQvt8AoPPfnS14cdKJfb9Tfxsko02iikmf36CB1p0eiFVfedSHfNgNsl7yL7hWeb0ieTEeO2BJsCet8ZWLyAuAkcpOElDWOBDkoqvfW7Z5ERn+JGzm9x5nf1NnyIAcTKN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487217; c=relaxed/simple;
	bh=5zR+lwq2a5dv+bnsRox8dZeRRNielnENs8rDTU2I3zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbsEh5r6u4OWmzMS036GvAU8TB7kpFS5SAmjo5RGZ1wQ5wyknJR+QL2Fdl+ZIOEx9i/JcmGHU3HSXbERS+1nRrryd0AvEdIbp+41JxEzhigcmdAMZFfUc109ZppiB+ejD9w+ebQUGJ/JDJXOCf8seurFmPU0eGOOuKgVwEpzijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXqVR+YS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AB3C4CEE4;
	Mon,  5 May 2025 23:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487216;
	bh=5zR+lwq2a5dv+bnsRox8dZeRRNielnENs8rDTU2I3zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YXqVR+YS4oiJb/ODm5aLTSc8JIgD2bAshksugJgjf9Hqe0Z69brB33Kvsr7aa/aiC
	 1yPR3087EB9Thnexmmvz4T4fxrvUpsMVf3lwf8NtLNS4jqd/NChlLDdT17cE69RmGe
	 noolZ6bn/INEJ7N71WfC4BTEU9XPQCHZAq8MW9unHIhOconbvIgJRtWv7UtVR7DYYb
	 Vsy/b2sPy0381Zkxr9bdro0ktHcGVvfiRB/77YraubC1JsVUBxCTZCDmFTbUHvkAxp
	 wmM3CXDZvpPq9C607T2skCBtiI5T8ssxS80CcbRVFL40F9UtsGzgDSwNoSLbwJMxQc
	 EU3sLsB26klyw==
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
Subject: [PATCH AUTOSEL 5.10 062/114] bonding: report duplicate MAC address in all situations
Date: Mon,  5 May 2025 19:17:25 -0400
Message-Id: <20250505231817.2697367-62-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 7caaf5b49c7b5..c5ccd42af528e 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2239,7 +2239,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	RCU_INIT_POINTER(bond->current_arp_slave, NULL);
 
-	if (!all && (!bond->params.fail_over_mac ||
+	if (!all && (bond->params.fail_over_mac != BOND_FOM_ACTIVE ||
 		     BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)) {
 		if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
 		    bond_has_slaves(bond))
-- 
2.39.5


