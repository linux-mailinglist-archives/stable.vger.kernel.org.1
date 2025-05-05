Return-Path: <stable+bounces-141635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF9AAB525
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC31A3A1DE2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CA0346041;
	Tue,  6 May 2025 00:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSVGe7BG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6392E61CD;
	Mon,  5 May 2025 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486970; cv=none; b=DUtD/9Lo42LMmdyraz42yEI56ZWSA94VuX6lWS4IVVGTZB0bF31CHap0T0tywBaloSrab+4J2FdKsXiU0qcnDTi6t19elAbtxJW+e9c8SrWxoICG5C6PMp5g8+lBvkpxau5eoGLh8DybKLmF8MoZus06nVHRevbq761VovpssqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486970; c=relaxed/simple;
	bh=lD9jUtI1KHMpBHJeJ+oEJotljTUv3A4dNQi5VxznjOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBhyvXgPf6Fhgx0ntxRR4o4IkXLDby8n5fcUJ0WMLRWrZUn+SbJYwv+u+OTVzzzDiEF9PwiSaIO+cODs7Lyo1jLK8uCi8B3LXOpQdWeghHCAo2gJGgX1vOlTrzRBQ/Uv7GYY/wXn98+VSsX6/gUtr4HSpxkiyl8RyvLCTVLfFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSVGe7BG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBC0C4CEEF;
	Mon,  5 May 2025 23:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486970;
	bh=lD9jUtI1KHMpBHJeJ+oEJotljTUv3A4dNQi5VxznjOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BSVGe7BGA7gq74CQjVTKMCqiSut5icBdJI6H1bmZytyj2CbpnlHN57OaFOW504zdt
	 NcuF18xuF/XcTyPB5/tJfCJ0AV8NHzYv77M/AcXYz5raPQfC/oQABFd8pSIQYkVsui
	 2MTIMX5Tgjp1fs6Gp/QOCvnvMJ8mP17TD4e7zgTvAeKO7Dx5lNNiVt3pjs8T8yF5MC
	 FMoXKbiQ9oWPzItwxBdzvuAxLsnu58uc3DWU6nnEKjdPfOrmo+OTMbeLPM5RaCL5pC
	 S3+GQnvtyHhBraQC34cvxg73Jwx4/Pu31faMK60a75E72yncdjbKMW5/YFrqyYLiUn
	 eH4XHnZaed5vA==
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
Subject: [PATCH AUTOSEL 5.15 086/153] bonding: report duplicate MAC address in all situations
Date: Mon,  5 May 2025 19:12:13 -0400
Message-Id: <20250505231320.2695319-86-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 75499e2967e8f..6bdc29d04a580 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2355,7 +2355,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	RCU_INIT_POINTER(bond->current_arp_slave, NULL);
 
-	if (!all && (!bond->params.fail_over_mac ||
+	if (!all && (bond->params.fail_over_mac != BOND_FOM_ACTIVE ||
 		     BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)) {
 		if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
 		    bond_has_slaves(bond))
-- 
2.39.5


