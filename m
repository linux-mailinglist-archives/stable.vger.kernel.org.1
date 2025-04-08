Return-Path: <stable+bounces-131284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A242A80992
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381864A6909
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96605269831;
	Tue,  8 Apr 2025 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hpp5x6KR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378526F46A;
	Tue,  8 Apr 2025 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115981; cv=none; b=b4RaYjqHkfrpxxlK8k+Xc89r6T8Qh3igQU0uDnFowdoJKa34Q06W7ExJz32fAwLXjDBWSvO9/TQJwruKamPEJ3cW/NtmyXv6LGPAGHxaQwrVLmJUSszyu1tc5R3K4GeFTaKWj3IP3WiL/3/lbbZuxeOpGvCFHz0N/ZdLSmbgmvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115981; c=relaxed/simple;
	bh=kMv0L0V+MwZagxs7lbsY7J4TbT6S/YfpvyjO71uXIUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDZvcM+EVvpsIshhNUt6GhdDgpZCNjeE2IlrYWgGZCYZu+b3LR3JPDcEVTEAgU8bjVM9KUBZlTdQKsN+29EJgV7C7mkeU+iNuIvclh9FnpCF4wb8XxzW0P6EwrkdFsEeBN/0qYn83lyzG7ZwSNsvRD1Y1hzEqz0fpEznVTucekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hpp5x6KR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB775C4CEE5;
	Tue,  8 Apr 2025 12:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115981;
	bh=kMv0L0V+MwZagxs7lbsY7J4TbT6S/YfpvyjO71uXIUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hpp5x6KRycQ/wN1reYxSNHa0FDUmcQMavTBXBgyOVxp5BMcEWda5YC7IFN7T46s6Y
	 m3gibZgZI5l7ECdZTbJ3Y42i3nR/OkNcQ7OtjNpoynlrunOLv825yYIbsaxpcmj0FO
	 hNzECcdRNCjnNx88H/oDPQttpWiQz8hTeiyOVxAQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matt Dowling <madowlin@amazon.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 159/204] udp: Fix memory accounting leak.
Date: Tue,  8 Apr 2025 12:51:29 +0200
Message-ID: <20250408104824.979049629@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit df207de9d9e7a4d92f8567e2c539d9c8c12fd99d ]

Matt Dowling reported a weird UDP memory usage issue.

Under normal operation, the UDP memory usage reported in /proc/net/sockstat
remains close to zero.  However, it occasionally spiked to 524,288 pages
and never dropped.  Moreover, the value doubled when the application was
terminated.  Finally, it caused intermittent packet drops.

We can reproduce the issue with the script below [0]:

  1. /proc/net/sockstat reports 0 pages

    # cat /proc/net/sockstat | grep UDP:
    UDP: inuse 1 mem 0

  2. Run the script till the report reaches 524,288

    # python3 test.py & sleep 5
    # cat /proc/net/sockstat | grep UDP:
    UDP: inuse 3 mem 524288  <-- (INT_MAX + 1) >> PAGE_SHIFT

  3. Kill the socket and confirm the number never drops

    # pkill python3 && sleep 5
    # cat /proc/net/sockstat | grep UDP:
    UDP: inuse 1 mem 524288

  4. (necessary since v6.0) Trigger proto_memory_pcpu_drain()

    # python3 test.py & sleep 1 && pkill python3

  5. The number doubles

    # cat /proc/net/sockstat | grep UDP:
    UDP: inuse 1 mem 1048577

The application set INT_MAX to SO_RCVBUF, which triggered an integer
overflow in udp_rmem_release().

When a socket is close()d, udp_destruct_common() purges its receive
queue and sums up skb->truesize in the queue.  This total is calculated
and stored in a local unsigned integer variable.

The total size is then passed to udp_rmem_release() to adjust memory
accounting.  However, because the function takes a signed integer
argument, the total size can wrap around, causing an overflow.

Then, the released amount is calculated as follows:

  1) Add size to sk->sk_forward_alloc.
  2) Round down sk->sk_forward_alloc to the nearest lower multiple of
      PAGE_SIZE and assign it to amount.
  3) Subtract amount from sk->sk_forward_alloc.
  4) Pass amount >> PAGE_SHIFT to __sk_mem_reduce_allocated().

When the issue occurred, the total in udp_destruct_common() was 2147484480
(INT_MAX + 833), which was cast to -2147482816 in udp_rmem_release().

At 1) sk->sk_forward_alloc is changed from 3264 to -2147479552, and
2) sets -2147479552 to amount.  3) reverts the wraparound, so we don't
see a warning in inet_sock_destruct().  However, udp_memory_allocated
ends up doubling at 4).

Since commit 3cd3399dd7a8 ("net: implement per-cpu reserves for
memory_allocated"), memory usage no longer doubles immediately after
a socket is close()d because __sk_mem_reduce_allocated() caches the
amount in udp_memory_per_cpu_fw_alloc.  However, the next time a UDP
socket receives a packet, the subtraction takes effect, causing UDP
memory usage to double.

This issue makes further memory allocation fail once the socket's
sk->sk_rmem_alloc exceeds net.ipv4.udp_rmem_min, resulting in packet
drops.

To prevent this issue, let's use unsigned int for the calculation and
call sk_forward_alloc_add() only once for the small delta.

Note that first_packet_length() also potentially has the same problem.

[0]:
from socket import *

SO_RCVBUFFORCE = 33
INT_MAX = (2 ** 31) - 1

s = socket(AF_INET, SOCK_DGRAM)
s.bind(('', 0))
s.setsockopt(SOL_SOCKET, SO_RCVBUFFORCE, INT_MAX)

c = socket(AF_INET, SOCK_DGRAM)
c.connect(s.getsockname())

data = b'a' * 100

while True:
    c.send(data)

Fixes: f970bd9e3a06 ("udp: implement memory accounting helpers")
Reported-by: Matt Dowling <madowlin@amazon.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20250401184501.67377-3-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 88da11922d677..da96252dd8a16 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1437,12 +1437,12 @@ static bool udp_skb_has_head_state(struct sk_buff *skb)
 }
 
 /* fully reclaim rmem/fwd memory allocated for skb */
-static void udp_rmem_release(struct sock *sk, int size, int partial,
-			     bool rx_queue_lock_held)
+static void udp_rmem_release(struct sock *sk, unsigned int size,
+			     int partial, bool rx_queue_lock_held)
 {
 	struct udp_sock *up = udp_sk(sk);
 	struct sk_buff_head *sk_queue;
-	int amt;
+	unsigned int amt;
 
 	if (likely(partial)) {
 		up->forward_deficit += size;
@@ -1462,10 +1462,8 @@ static void udp_rmem_release(struct sock *sk, int size, int partial,
 	if (!rx_queue_lock_held)
 		spin_lock(&sk_queue->lock);
 
-
-	sk_forward_alloc_add(sk, size);
-	amt = (sk->sk_forward_alloc - partial) & ~(PAGE_SIZE - 1);
-	sk_forward_alloc_add(sk, -amt);
+	amt = (size + sk->sk_forward_alloc - partial) & ~(PAGE_SIZE - 1);
+	sk_forward_alloc_add(sk, size - amt);
 
 	if (amt)
 		__sk_mem_reduce_allocated(sk, amt >> PAGE_SHIFT);
@@ -1650,7 +1648,7 @@ EXPORT_SYMBOL_GPL(skb_consume_udp);
 
 static struct sk_buff *__first_packet_length(struct sock *sk,
 					     struct sk_buff_head *rcvq,
-					     int *total)
+					     unsigned int *total)
 {
 	struct sk_buff *skb;
 
@@ -1683,8 +1681,8 @@ static int first_packet_length(struct sock *sk)
 {
 	struct sk_buff_head *rcvq = &udp_sk(sk)->reader_queue;
 	struct sk_buff_head *sk_queue = &sk->sk_receive_queue;
+	unsigned int total = 0;
 	struct sk_buff *skb;
-	int total = 0;
 	int res;
 
 	spin_lock_bh(&rcvq->lock);
-- 
2.39.5




