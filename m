Return-Path: <stable+bounces-46345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F898D0321
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B751C218C8
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D00715FA6A;
	Mon, 27 May 2024 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY0cZgor"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E3716EBE3;
	Mon, 27 May 2024 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819185; cv=none; b=HcYxDrCio7uICjZkAwcYWqQ8Jj4h+ZlVEsKi6g4LJWJxy9FvAQ6ypoB18s7qj5Jh9QTZYTyYZkZHd6T4LAIUDAuh4Fae3TcnPbs26vXq+2nWLdhO6U0SHTjNmnAIucgQviJgcTme+oDtvCA+mjavHb+EYPjv8b/JZ6P9jiv5HhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819185; c=relaxed/simple;
	bh=gT3PUxRsUL+n6n4zrXENoJgzxNiIqZwJ8cCv7JfCF08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKabxNcD0kX2tLorc/fWHrIpNPs53Ta9w5xU8oaqY5x5+vLSiclJtLuP+PMt4VhfKNB14SFGrSCZVLq7fLWLjd6P5QhmBKB9IPqzXmHmvF3kPEcAP3t25/bndLIwqQJw5xrhGAiGNfsvl6uqrehtCtmHUgG4A+3xG1qzTuf1tvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY0cZgor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A12C32789;
	Mon, 27 May 2024 14:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819185;
	bh=gT3PUxRsUL+n6n4zrXENoJgzxNiIqZwJ8cCv7JfCF08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UY0cZgorTHnzQpnYN41e+Eb9ZJgpDMjxLI3IW1IqfHuZp4lHQe8RF4tNEHGSpnxcO
	 37zI8sdUibYM45mul9UjzHqbDFdfnR4r3pvY57CoM37E5Z9boWQ+cZD4sJ+jfd5wUV
	 NIWns8gZVUJll8fvvexv0N1TLo8APh9AXSKUnSnjt4NrpIjMqX3t8LWVukSzulj+Bu
	 CEvAf7ZNniE4FJnS8OMzg12FwX0EuDzs4m/AMzAVxlhZ/0J6r08luMddBRHW7BFC1o
	 rYtavUyoZyeVgU8G6TAbrdyI4IsGLKYmL2zgQaoRiWyXugg9Qvu3barIdLtjD5vR3h
	 KAChQN7/FZ14A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 25/35] netpoll: Fix race condition in netpoll_owner_active
Date: Mon, 27 May 2024 10:11:30 -0400
Message-ID: <20240527141214.3844331-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141214.3844331-1-sashal@kernel.org>
References: <20240527141214.3844331-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit c2e6a872bde9912f1a7579639c5ca3adf1003916 ]

KCSAN detected a race condition in netpoll:

	BUG: KCSAN: data-race in net_rx_action / netpoll_send_skb
	write (marked) to 0xffff8881164168b0 of 4 bytes by interrupt on cpu 10:
	net_rx_action (./include/linux/netpoll.h:90 net/core/dev.c:6712 net/core/dev.c:6822)
<snip>
	read to 0xffff8881164168b0 of 4 bytes by task 1 on cpu 2:
	netpoll_send_skb (net/core/netpoll.c:319 net/core/netpoll.c:345 net/core/netpoll.c:393)
	netpoll_send_udp (net/core/netpoll.c:?)
<snip>
	value changed: 0x0000000a -> 0xffffffff

This happens because netpoll_owner_active() needs to check if the
current CPU is the owner of the lock, touching napi->poll_owner
non atomically. The ->poll_owner field contains the current CPU holding
the lock.

Use an atomic read to check if the poll owner is the current CPU.

Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/r/20240429100437.3487432-1-leitao@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 543007f159f99..55bcacf67df3b 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -316,7 +316,7 @@ static int netpoll_owner_active(struct net_device *dev)
 	struct napi_struct *napi;
 
 	list_for_each_entry_rcu(napi, &dev->napi_list, dev_list) {
-		if (napi->poll_owner == smp_processor_id())
+		if (READ_ONCE(napi->poll_owner) == smp_processor_id())
 			return 1;
 	}
 	return 0;
-- 
2.43.0


