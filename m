Return-Path: <stable+bounces-46432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69C18D045D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FEB3820FE
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3742B7344B;
	Mon, 27 May 2024 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBl1XbtK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E407273443;
	Mon, 27 May 2024 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819520; cv=none; b=hk64UesegBMJGD4DNnDlV7c4sjRifchJVj8BEvT96FFnYSuLiTuaFo7kjVmj+dLXTzLBfY7CpGyqvpwFjE/760SAXCF8oi7/uKr5sjeemXC9/uDVwoJPgDS6SrlKc6PXf5DiF484RLewjPxcPrayTci4TwPi8K7Z3V8XRvMoyrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819520; c=relaxed/simple;
	bh=LFdVJ1u8oZJXp9vkV1GNaoYs334Var2HnGA/TUOuOGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNWVHxJxMnvjI7qosBRCeye/iwYCysb/apezclXujC1r7cVBOSJGjTzTwxZyNRZAryJzO6rn3dqTe+/65J7YlbbLhy8o57c7PUY40k4qHWzn2EaOAAENO5hVdP6mmE/wxIPmTSNIbq9h1TUJbsj2jPzUeU00Wt7l+77g0fVbPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBl1XbtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC59C2BBFC;
	Mon, 27 May 2024 14:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819519;
	bh=LFdVJ1u8oZJXp9vkV1GNaoYs334Var2HnGA/TUOuOGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBl1XbtKWv6m9JS+xm62zvgqnQ0GYk3gs6ziV24obutqJItqa9FLGbeXjgAMQA9n9
	 Y1OXIN/UHTCHV9sWqswO+BDoy+2BFnlB0kR0pq07uDBt8HE5fZD00K0CPO2Oe+Kfa3
	 HAuvv/u/F2pig8RwcVJWIA4DpzhIfMHhx6+0onjZfVf4De0hCLF7kIZ4rCwV8747kq
	 L7KPUfsSRFSkCUZvH8aTcyCZKMIKnIzLO8dbsyX5TAraZK/9xTEwyhCa/ebWXIQWGf
	 eiOb1sJn/VObe2/1cmBP20Q4I+NMZ6Y0Lvtrci91ObwfozAUjX/Kr6RRYGvJBCwAUT
	 6MVc53s8+RWHg==
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
Subject: [PATCH AUTOSEL 5.15 09/13] netpoll: Fix race condition in netpoll_owner_active
Date: Mon, 27 May 2024 10:18:03 -0400
Message-ID: <20240527141819.3854376-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141819.3854376-1-sashal@kernel.org>
References: <20240527141819.3854376-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
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
index 47a86da6ab980..2a9d95368d5a2 100644
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


