Return-Path: <stable+bounces-46376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F278D0479
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FA79B2632A
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF25617B515;
	Mon, 27 May 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUJFDVrN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F6E17B4F2;
	Mon, 27 May 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819303; cv=none; b=iV+Q9iCr62ggnNptq+zmY9QaHlzQTtcjBj+8IEsZ94PYjrRVQ6vv/pADArKEckk0hbQb3sPyKK9NYh91M7rgB3zU5+e4IN2TAciBaQZU79PWgdZXmHyD/9dEU5HmLzu4Nb/AfjjBUgqLnJKWdusuTZsLPsckXKHYGbqIS/C35Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819303; c=relaxed/simple;
	bh=gT3PUxRsUL+n6n4zrXENoJgzxNiIqZwJ8cCv7JfCF08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smXf2uCXh1SpxA7k67y53UVRELoBxdnd7ny1Ssd7ADrYSKwctG9Fq9graoqVL1/D1yO74fMr361fdeLuOG70zsf7jDJgsYbWmRZAoHwzgxWE4WOWExoYAMvpvySgXKXwwbTFHfyirshilrf0+1L9HEOPR4I1atZT/iMrt9KsG7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUJFDVrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FD0C32789;
	Mon, 27 May 2024 14:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819303;
	bh=gT3PUxRsUL+n6n4zrXENoJgzxNiIqZwJ8cCv7JfCF08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUJFDVrNCYigR27WJdnT76yFkGu1BMwGeTW48jwEr/29CBpRm4zcXKTUk4XzHP5cQ
	 xTH8MqO65FyDlrhqAHnO3u5bHraDZ2BRJg/oeCcG0hOlb4/ia2dhANs8Yfp7o1gnGb
	 dxvCVisbB0VmjncLpCQJ5TFi3IcyhcKE28g8yLupDPhUnAUZEXP3yu08Qzxibm+y41
	 AWpU0FAjj0UTh4R1LSDgZMSCOOQ6MT/+RQUpvgLdy5FsHwKQ7aRblVS6hknLJc2p+b
	 x5Gd8xG2pK/+AT6/If1vlEUxFGAak8vUTbJ5hLlNZd1Hd5DJLVB62TwRD7gpPAN7s2
	 Ioi2ycWZXjfZQ==
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
Subject: [PATCH AUTOSEL 6.8 21/30] netpoll: Fix race condition in netpoll_owner_active
Date: Mon, 27 May 2024 10:13:30 -0400
Message-ID: <20240527141406.3852821-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141406.3852821-1-sashal@kernel.org>
References: <20240527141406.3852821-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
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


