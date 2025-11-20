Return-Path: <stable+bounces-195411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD84C761B3
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 95FCC355DA4
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B832E303A10;
	Thu, 20 Nov 2025 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jfk1/TN8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7713E3009CA
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667789; cv=none; b=Zfmw64eJ19kCGPjwtHeXKRkbGzHwepX0SUw0W7t8+BdEKOsqyOkd/ORHEbOYJ0DAiCw+An9u71CrOt/VXW6ms7NTxyfSQCP3AZsedQykoy9DQNx3bOVY355lxH9waV5AMGXFEYr06rGm4iw1co/67sArvdhBo0IUSHTssp/u1BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667789; c=relaxed/simple;
	bh=9qBUwC0W1CdAcd3h/7fprjBtTevu4OM9vZ8Ci3eq+HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlvJbjdciT8aRukhHsqo+Wwa/zXuF3t5cnNnr9iTB8ilUGYu60sJt+E8Paix9odYCN0jAY8dhmIeVGtJyqYhPW9Mw7wD2WaJu1ZFvtwpr3dlBEZSAj3q3RriauhhTRIa+zWJbrUekgpUkNcvvUdJmt6JAYALMkPSepFq7C9Vvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jfk1/TN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B4FC116C6;
	Thu, 20 Nov 2025 19:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763667787;
	bh=9qBUwC0W1CdAcd3h/7fprjBtTevu4OM9vZ8Ci3eq+HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jfk1/TN8QMf0xJIcSB585SknBeLzYhatHnohMWOBw9XOGzkjOwwFjLpxbDOXQ190G
	 1JLq4W6SUa8sm196+oN8o6TbE9QSYS1Z7fyZnjHCEzgf332GXuhsmNVXcQc//Gtb4F
	 +4FZWkY2slFHhs0DkALEK0hdamYsX92X3ujKu+QyOFBuOTaxRmlMFduKfZt5pv+65k
	 u6kmOokQfcZy6secnZd4A7so8pCVf+LAAcEzRNRcUlhii9sdqDlATmkH0mSScOKTpf
	 K0d37nHB6S7/68rQqTsLrsD0MH3xZVH7H0XRD1HUk6UaFNPfLoqq2k5bJzxxlMqrwO
	 8qQAA0lHFgW4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] net: netpoll: flush skb pool during cleanup
Date: Thu, 20 Nov 2025 14:43:02 -0500
Message-ID: <20251120194303.2293083-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120194303.2293083-1-sashal@kernel.org>
References: <2025112005-polio-gratify-8d3b@gregkh>
 <20251120194303.2293083-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 6c59f16f1770481a6ee684720ec55b1e38b3a4b2 ]

The netpoll subsystem maintains a pool of 32 pre-allocated SKBs per
instance, but these SKBs are not freed when the netpoll user is brought
down. This leads to memory waste as these buffers remain allocated but
unused.

Add skb_pool_flush() to properly clean up these SKBs when netconsole is
terminated, improving memory efficiency.

Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20241114-skb_buffers_v2-v3-2-9be9f52a8b69@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 49c8d2c1f94c ("net: netpoll: fix incorrect refcount handling causing incorrect cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netpoll.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 76bdb6ce46378..3f6dca03fa600 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -536,6 +536,14 @@ static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
 	return -1;
 }
 
+static void skb_pool_flush(struct netpoll *np)
+{
+	struct sk_buff_head *skb_pool;
+
+	skb_pool = &np->skb_pool;
+	skb_queue_purge_reason(skb_pool, SKB_CONSUMED);
+}
+
 int netpoll_parse_options(struct netpoll *np, char *opt)
 {
 	char *cur=opt, *delim;
@@ -784,7 +792,7 @@ int netpoll_setup(struct netpoll *np)
 
 	err = __netpoll_setup(np, ndev);
 	if (err)
-		goto put;
+		goto flush;
 	rtnl_unlock();
 
 	/* Make sure all NAPI polls which started before dev->npinfo
@@ -795,6 +803,8 @@ int netpoll_setup(struct netpoll *np)
 
 	return 0;
 
+flush:
+	skb_pool_flush(np);
 put:
 	DEBUG_NET_WARN_ON_ONCE(np->dev);
 	if (ip_overwritten)
@@ -842,6 +852,8 @@ void __netpoll_cleanup(struct netpoll *np)
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
 	} else
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+
+	skb_pool_flush(np);
 }
 EXPORT_SYMBOL_GPL(__netpoll_cleanup);
 
-- 
2.51.0


