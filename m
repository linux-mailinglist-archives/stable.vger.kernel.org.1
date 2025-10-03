Return-Path: <stable+bounces-183340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FA7BB86D9
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 01:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABD14A7CED
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 23:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE5226738D;
	Fri,  3 Oct 2025 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LS/kmKKz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD654258EF0;
	Fri,  3 Oct 2025 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534994; cv=none; b=iW7nzliuSpLg6J6KtQG/YxrD0domJaH0TEU7ietI+cJx7V7KhK2tnycTzMQNqWVctVJbVK+oaKUCeLwW2LIwJ78cMNcASQLQWw7jgRLZSKRRl7XLCumov1Z51evFLfvs7ywq2LijT9VzMM6eugPRKlFT7WPYJqRzN+3wqPrXQ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534994; c=relaxed/simple;
	bh=47AvyOWPHlbSO2un6BzmIJP/MkBr9VZmNYEfPDKfDN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FTKnnu0egf179OMw/nu3H7Wrp/p+a+eEt31qRLsqQ1GyoqXUz0eUcR/cH3Wj+2lL6k1z9ISNIvsyg9nVflCh56Wau271ZO0HYp9CJMVbtEAoQySkbhIaDGFJqK0OBpesPVDvuKThO6a4quQBNjUuGXOlgRinsEauQEn2bwK1bZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LS/kmKKz; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593NHFL5006553;
	Fri, 3 Oct 2025 23:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=/DePuG+339Tf3yEfFPTR5CHQ4Z9q/
	o+eWd6Rq4seq/Y=; b=LS/kmKKz+pQO30foMCZezQrzHSdbmNGMuPQ8fyrmjK8X7
	C8FKd8I4L+kOPryKPt+x7hXaXa8A6ATQHxtdOoqweEcgm7fDacsVMVFsBie8DNTX
	q1lp40sE0KSMGaL9NRzOIbk5a5f6uPK6o9dWX4WN7nRy+cvBsBWtS7C3r2vQ5b2I
	Z/5gpzVwMJsHEfmQzAfXJ/a8IpoK5WBleSXc/BGEZaK2lYU8Q3r0a7Zl3vbEJ075
	wFfyc45w+dMX7p3ugv62Q93wUFeUCf3tAL+vEPHjpIRkYL9UkeP0rDKa90zprKji
	Ed4jQUxPGy7SmlZXkNe0DeUsZyKW9DWTHAnj60U0A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49jqryr0r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Oct 2025 23:42:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 593Ncm1u029705;
	Fri, 3 Oct 2025 23:42:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49hw1g42ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Oct 2025 23:42:36 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 593NgZcL009324;
	Fri, 3 Oct 2025 23:42:35 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49hw1g42dx-1;
	Fri, 03 Oct 2025 23:42:35 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc: yifei.l.liu@oracle.com, netdev@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH Linux-5.15.y Linux-5.10.y Linux-5.4.y 1/1] udp: Fix memory accounting leak.
Date: Fri,  3 Oct 2025 16:42:06 -0700
Message-ID: <20251003234206.3392808-1-yifei.l.liu@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510030200
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDE5NCBTYWx0ZWRfX4RxWkJtPUIHY
 Y4VwGVuhxSauiVkPaTl0LNUzVqnfbo0VjfhDRGTFsaeXI8WhkTgS3nqUWhLMdwvn37JQC+enVrc
 ziizAd9hTLA0F1x6Fkw+nIbQuIggiIf46Xcwv5CKoVHUzj7FgCCPXUVTkX4P5/gG0jKO5EGcHBb
 /IcVIe3h9SNTgqQZLkh/DDe8jSV3IQi7y6ttZIYU3w6f5mUB1F17WB9i1dTbGHzgpnoTrFIgLOD
 kAWkYzOEidXtTgLUQ/fvZm6zmQO2IMIa7toPfShYDcfRfzbIhpRxvFK6m6nZnYY+mUVWlHXc1Ii
 xQ+AUYuSoD5qNVK2/DNt/NNHn+akQkuwfpt8w8Ain95Azw9DzvQyNyCHqd6HH1Yv9Iy4bU0DuJ3
 vuhptY6fRtuyvkcsrnREb72jCg0+bKU38tTwJLVu8fmnsujaB9k=
X-Proofpoint-GUID: WnhGTLLVrTQ3JvnAkMxPgwhJafu5U9ug
X-Proofpoint-ORIG-GUID: WnhGTLLVrTQ3JvnAkMxPgwhJafu5U9ug
X-Authority-Analysis: v=2.4 cv=TdSbdBQh c=1 sm=1 tr=0 ts=68e05f6d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=bC-a23v3AAAA:8 a=vggBfdFIAAAA:8 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=0J9PpQkizUzvAjNcVFoA:9
 a=FO4_E8m0qiDe52t0p3_H:22 cc=ntf awl=host:13625

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
(cherry picked from commit df207de9d9e7a4d92f8567e2c539d9c8c12fd99d)
[Yifei: resolve minor conflicts and fix CVE-2025-22058]
Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
---
 net/ipv4/udp.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 51a12fa486b6..3ebd5765fb9f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1459,12 +1459,12 @@ static bool udp_skb_has_head_state(struct sk_buff *skb)
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
@@ -1484,10 +1484,8 @@ static void udp_rmem_release(struct sock *sk, int size, int partial,
 	if (!rx_queue_lock_held)
 		spin_lock(&sk_queue->lock);
 
-
-	sk->sk_forward_alloc += size;
-	amt = (sk->sk_forward_alloc - partial) & ~(SK_MEM_QUANTUM - 1);
-	sk->sk_forward_alloc -= amt;
+	amt = (size + sk->sk_forward_alloc - partial) & ~(PAGE_SIZE - 1);
+	sk->sk_forward_alloc += size - amt;
 
 	if (amt)
 		__sk_mem_reduce_allocated(sk, amt >> SK_MEM_QUANTUM_SHIFT);
@@ -1671,7 +1669,7 @@ EXPORT_SYMBOL_GPL(skb_consume_udp);
 
 static struct sk_buff *__first_packet_length(struct sock *sk,
 					     struct sk_buff_head *rcvq,
-					     int *total)
+					     unsigned int *total)
 {
 	struct sk_buff *skb;
 
@@ -1704,8 +1702,8 @@ static int first_packet_length(struct sock *sk)
 {
 	struct sk_buff_head *rcvq = &udp_sk(sk)->reader_queue;
 	struct sk_buff_head *sk_queue = &sk->sk_receive_queue;
+	unsigned int total = 0;
 	struct sk_buff *skb;
-	int total = 0;
 	int res;
 
 	spin_lock_bh(&rcvq->lock);
-- 
2.50.1


