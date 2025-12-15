Return-Path: <stable+bounces-201117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF36CC00B6
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 22:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19566300252C
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 21:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879112DC34B;
	Mon, 15 Dec 2025 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="jp1sm1wP"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D631ED95;
	Mon, 15 Dec 2025 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765835599; cv=none; b=q3GDtSKJ5rVsWI02LRB3BJ3Me1d5kRmh1ZgHMkag9E82EWdxrSD8mgLpdT2HaedAMRX3f/Y7j3QA90SyWDediy1U14pM042V+mdqN5Zl40HilCCjrya/P6N4MlIBAEW1EhUUVA4V9BYPfQATYLEryPT+uZNmXD4QJqXG7G5ciEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765835599; c=relaxed/simple;
	bh=VdB6pkdFc/o4rj2JtI3OfsfQ2Nfp72KVM68MNHT+X7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBlo/tibzhElWM5h4QVU1Flzqm9eNsHL2WtS5X7txJENX2t6MUi/eeIqzg7hsn8VoW9ZbKvzpXYfCX1PDrA4sHMpgfTBogrSHopIdsnnEYgP1zrGjbr7+AC45czO3MkDbcIM8yZAL8HQstz52wgURlwShyezMQWBkjEzq1Wk/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=jp1sm1wP; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1765835597; x=1797371597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ivVHRCNPE/AEBGIGPxjAnsXpluPPY8gcWfiHsZIixyI=;
  b=jp1sm1wPkHfO3GUcVxAVLbO/1FgqupZ1NUNmNTmVPcvQvP+dqpPNywoT
   TXm4RO5VvCXt3a3oJbNnfjuBZRsQBogdkIEAGCCkdARtdV/TBVZDVPxOf
   zdL3WdXaFXh3PQnyV1nHLs1/Zf7C6Yxuwzt2NL/T91dqrOoCh7GxBwlxl
   POFcwUqU/R5kUWOWZ0gU9bBHInmjiroi19pAl75aN5VZN/85WzJf+Y6Mv
   ohxRz7wF9QurSEdGlLjtzUD1P1K04tcl9oXKwZJ/Gk6kLzRqMFXOk2PeO
   WKnaSGiQDfHRs1qLbB5imlhSBipJJLlSrIcLBSejM0yZjx1O6W0O73ZlU
   A==;
X-CSE-ConnectionGUID: zz+ZhduFSJuLYxGWtvGFdg==
X-CSE-MsgGUID: 0pJfKiQURGS7C1YWn76q2w==
X-IronPort-AV: E=Sophos;i="6.21,151,1763424000"; 
   d="scan'208";a="8923277"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 21:52:06 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:25859]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.162:2525] with esmtp (Farcaster)
 id e26318dd-e345-4cab-93f7-06e4569cea1d; Mon, 15 Dec 2025 21:52:06 +0000 (UTC)
X-Farcaster-Flow-ID: e26318dd-e345-4cab-93f7-06e4569cea1d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 15 Dec 2025 21:52:03 +0000
Received: from dev-dsk-gyokhan-1b-83b48b3c.eu-west-1.amazon.com (10.13.234.1)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 15 Dec 2025 21:52:01 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>
CC: <edumazet@google.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux@gyokhan.com>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] tcp_metrics: use dst_dev_net_rcu()
Date: Mon, 15 Dec 2025 21:51:19 +0000
Message-ID: <20251215215119.63681-3-gyokhan@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215215119.63681-1-gyokhan@amazon.de>
References: <20251215215119.63681-1-gyokhan@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 50c127a69cd6285300931853b352a1918cfa180f ]

Replace three dst_dev() with a lockdep enabled helper.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-7-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.com>
---
 net/ipv4/tcp_metrics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 03c068ea27b6..10e86f1008e9 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -170,7 +170,7 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 	struct net *net;
 
 	spin_lock_bh(&tcp_metrics_lock);
-	net = dev_net_rcu(dst_dev(dst));
+	net = dst_dev_net_rcu(dst);
 
 	/* While waiting for the spin-lock the cache might have been populated
 	 * with this entry and so we have to check again.
@@ -273,7 +273,7 @@ static struct tcp_metrics_block *__tcp_get_metrics_req(struct request_sock *req,
 		return NULL;
 	}
 
-	net = dev_net_rcu(dst_dev(dst));
+	net = dst_dev_net_rcu(dst);
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
@@ -318,7 +318,7 @@ static struct tcp_metrics_block *tcp_get_metrics(struct sock *sk,
 	else
 		return NULL;
 
-	net = dev_net_rcu(dst_dev(dst));
+	net = dst_dev_net_rcu(dst);
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


