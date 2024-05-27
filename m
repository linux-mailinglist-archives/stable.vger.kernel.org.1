Return-Path: <stable+bounces-46445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FA58D048D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8EE1F2105C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0533416EC18;
	Mon, 27 May 2024 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD/As5Qb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AE316EC0F;
	Mon, 27 May 2024 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819573; cv=none; b=lDHb60Df5Un+NkZM4z/9zfvkdzspwGH3Y5NoumkPdmyMGJTF2E1LOP5pfDrudw9Q34xZRX+Fzls4tuFmD6NN+310B/ByzmnbV2qH1m5nZ+3lTUEqh0cHb4y/eUP6LucioWv7KDKlM0jtUCQUnAHnmmXuTVhEkw+HpheHXUe44RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819573; c=relaxed/simple;
	bh=4TDtS9hjxGe1jUT8iSGEEEQdE6/obmENE9Q7Iy+Ohkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GirXgwot60E918+hlf09iMRQIsAHA5riZEkb+dUPhXW2he+rFaE92wY88Rpgye99nWR+lSNPy4jsE3xsrvACH4PDWvjmQZlhmOtlO4s5/j75EOovhWbMtd9nkg3whgUCQ9uSpWADVYrnYntC/hlqSqyKICs/+ueozYETP/Gc+Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD/As5Qb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADB1C2BBFC;
	Mon, 27 May 2024 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819573;
	bh=4TDtS9hjxGe1jUT8iSGEEEQdE6/obmENE9Q7Iy+Ohkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YD/As5Qb6XeBsBxu4Z41+WKBIzawrpJxXCyNXHyzCymQXybIKgRHJ+Yyi7JfbB1NY
	 uuLP/SCARjYT04wbBrAN62HIATD2FbSJGot3gp+lzaiEhoO+Pz77LcIs8TrJhyNDiU
	 nmF6vGgcMTDNYpvfbEq4a6kZ9lhPPriqRMujjB5+wj11GL0cZTTlEGriwHIFdKfGgt
	 18CRV9gXc9qth77W+IJD7tNVaVzulL9f1TFFDjAf49YdqyJV7bU8HMvutoR+aXEUE9
	 SaNlBTz/zbUxq3WOJUprvWfLHIlQzlrlWGzrQo/fM4k9w0xPpaDK9YXtMIP0P6cUxZ
	 YvOliDztqwOEw==
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
Subject: [PATCH AUTOSEL 5.10 09/13] netpoll: Fix race condition in netpoll_owner_active
Date: Mon, 27 May 2024 10:18:46 -0400
Message-ID: <20240527141901.3854691-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141901.3854691-1-sashal@kernel.org>
References: <20240527141901.3854691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
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
index 2ad22511b9c6d..f76afab9fd8bd 100644
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


