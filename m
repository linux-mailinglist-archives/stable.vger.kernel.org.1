Return-Path: <stable+bounces-20806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2444B85BBE3
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 13:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581171C22358
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 12:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C8567E79;
	Tue, 20 Feb 2024 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="uEyjcR8V"
X-Original-To: stable@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54485A787;
	Tue, 20 Feb 2024 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431724; cv=none; b=s3D0glpnJ5a7fnBS0SRB7MfRY44Wk0magc7FT+ik39MNb4dA1i4o0XVq5DNfTzYq9+QHS1ldX+5GQN7PT8Mu72bpZ1lK5ePtNPFJE9r301ai/Pw7IV0l3lKy5BneID+yWxIF/9oFZIWrUTxSYQhbZ5XiFdsnQl/NF9MuIGe4cUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431724; c=relaxed/simple;
	bh=lx2Zc2pBT3bvlCLnN8gbcnhxqOzDirH/yNVWnwLQu6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h7/NfqmYx/eoFsVd/ZbvN8lTFXpHeYfq461MlIvIocq/cMG73ENlBADHthcyNFI393hvaLTMXmrjyKO7EypoVSkYIFb4td2bWvXewjmH7AoH9anKVDOhba6Hg0tb36fqXPNFh7MFB06PJ4gsUOv17UJWb7ieFsll6Ret9t4+xRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=uEyjcR8V; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from jackdaw.fritz.box (unknown [IPv6:2a02:8012:909b:0:d103:fdef:9fb8:df5c])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id AC1467D982;
	Tue, 20 Feb 2024 12:22:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1708431721; bh=lx2Zc2pBT3bvlCLnN8gbcnhxqOzDirH/yNVWnwLQu6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20Tom=20Parkin=20<tparkin@katalix.com>|To:=20netdev@vger.ke
	 rnel.org|Cc:=20Tom=20Parkin=20<tparkin@katalix.com>,=0D=0A=09David
	 =20Howells=20<dhowells@redhat.com>,=0D=0A=09stable@vger.kernel.org
	 |Subject:=20[PATCH=20net]=20l2tp:=20pass=20correct=20message=20len
	 gth=20to=20ip6_append_data|Date:=20Tue,=2020=20Feb=202024=2012:21:
	 56=20+0000|Message-Id:=20<20240220122156.43131-1-tparkin@katalix.c
	 om>|MIME-Version:=201.0;
	b=uEyjcR8V/v40hJc/qZrJvNjeeBrgpzFhLTF6mnkS6ag57WmViseIGiXL2YqMqgs97
	 0/fftv4a2kPkW2UjQYFU+C5Qc+hL4ZyODLW2llQ7w+l0HfG/uGWSJUYHWJk5qTLU6D
	 Ww6F4HVILXkw2xPl7iZnUQcmfvxKdCTKyogJYrIwwgTMUPXk5PT6JdsHHVLqLhAAWr
	 Qt6mpQ3Z3775uGikDuQPVl+oryAIXUTFAyzK87opQ6DZ+2zd/q+dvsI0v1hE+GzZz2
	 B8JhcGGMCOMWKMkr1k0SXo8N8d7vlSQqSgKRw++XOHtfHUWHuEhNAqx0OJ+gZsxfvt
	 cwB7zvZ6puTUg==
From: Tom Parkin <tparkin@katalix.com>
To: netdev@vger.kernel.org
Cc: Tom Parkin <tparkin@katalix.com>,
	David Howells <dhowells@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net] l2tp: pass correct message length to ip6_append_data
Date: Tue, 20 Feb 2024 12:21:56 +0000
Message-Id: <20240220122156.43131-1-tparkin@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp_ip6_sendmsg needs to avoid accounting for the transport header
twice when splicing more data into an already partially-occupied skbuff.

To manage this, we check whether the skbuff contains data using
skb_queue_empty when deciding how much data to append using
ip6_append_data.

However, the code which performed the calculation was incorrect:

     ulen = len + skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0;

...due to C operator precedence, this ends up setting ulen to
transhdrlen for messages with a non-zero length, which results in
corrupted packets on the wire.

Add parentheses to correct the calculation in line with the original
intent.

Fixes: 9d4c75800f61 ("ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()")
Cc: David Howells <dhowells@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
This issue was uncovered by Debian build-testing for the
golang-github-katalix-go-l2tp package[1].

It seems 9d4c75800f61 has been backported to the linux-6.1.y stable
kernel (and possibly others), so I think this fix will also need
backporting.

The bug is currently seen on at least Debian Bookworm, Ubuntu Jammy, and 
Debian testing/unstable.

Unfortunately tests using "ip l2tp" and which focus on dataplane
transport will not uncover this bug: it's necessary to send a packet
using an L2TPIP6 socket opened by userspace, and to verify the packet on
the wire.  The l2tp-ktest[2] test suite has been extended to cover this.

[1]. https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1063746
[2]. https://github.com/katalix/l2tp-ktest

---
 net/l2tp/l2tp_ip6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index dd3153966173..7bf14cf9ffaa 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -627,7 +627,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 back_from_confirm:
 	lock_sock(sk);
-	ulen = len + skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0;
+	ulen = len + (skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0);
 	err = ip6_append_data(sk, ip_generic_getfrag, msg,
 			      ulen, transhdrlen, &ipc6,
 			      &fl6, (struct rt6_info *)dst,
-- 
2.34.1


