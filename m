Return-Path: <stable+bounces-204511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D893BCEF517
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 21:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1ED9300386B
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 20:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C83B2D3755;
	Fri,  2 Jan 2026 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gp+doviZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B562D47F5
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767386274; cv=none; b=EsyzV6Js3wMjaekzDMOueHkOisiLtSzETqqjDtlgO63Aw01GkjpYLtq9htL8qctnXVYYpj160UeCjLASxy9u2Q68ROPHVqXjEeAMIceiWf8ZjzEg1zPofIrdZIuJaiSLl3rrmlIdRRWqrCRk1J2pWw/qc0O79na9vT1bivxPK2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767386274; c=relaxed/simple;
	bh=9U39uEtGZsFKnJP5vaG5bTqRwGpxhIUb+UqumRYmKMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0R9J6Jey/+/ko5Jxh5ggD9Az6dKlT0n77Lw8+hTLVehxnGGv9FiYBfXGAHsHmHmi5IEyUkdyDvEhFIVDNY5t7oqnyOc5AGjRaP4N534iJEQd4r9OeC4BIl6VESxr4A5Z2XzLEHVXspeqaybl+tMEGvB65H5q9JRdN5DJeGNfto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gp+doviZ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 602BvTN23050597;
	Fri, 2 Jan 2026 20:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=HrQ+K
	aRNBQpyZdzUIDBh8FdEz/p274p7yzx1+6LFLDs=; b=gp+doviZNKA5SrKQD7ovY
	Plb8F/cJy7yeyEd9oaOfj9Vco9mwHy2WoiF0Ptbgf7zHW0nWZ9GDnjU9M5JVEUj2
	IkwxnOuafJgi5WiWi4Gwls8bNNNGcZYoosO6rFPU5FV+04HUxGSuqMxvywFlRpk2
	Se1W8iEV6Dv1RSwvTR92V9W1oTRnrMGDVcH0GpaCLB88+QxvpcdUwuR3bRVYO65N
	TWMBl1i9mr23v6ZC9HMSrk4rfkyutZoJRv8m14e/QzRjDmAzfOfSzqZICiQVXu+N
	f7uPIe7wefHW9vaeGrxHu2HqN6gkrfbyQG6T2CbV4qp/dEyY4dJujAA78iWteGYr
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba72qndrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Jan 2026 20:37:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 602IN29Y023014;
	Fri, 2 Jan 2026 20:37:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5wa66mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Jan 2026 20:37:47 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 602KbZ4f025726;
	Fri, 2 Jan 2026 20:37:46 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ba5wa66fb-7;
	Fri, 02 Jan 2026 20:37:46 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 6/7] net: use dst_dev_rcu() in sk_setup_caps()
Date: Fri,  2 Jan 2026 12:37:26 -0800
Message-ID: <20260102203727.1455662-7-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260102203727.1455662-1-harshit.m.mogalapalli@oracle.com>
References: <20260102203727.1455662-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601020184
X-Proofpoint-GUID: cpIOizBc_SdNlnOE1B1HCGEkUuc8vcTn
X-Authority-Analysis: v=2.4 cv=MqBfKmae c=1 sm=1 tr=0 ts=69582c9c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ux8SEuwtf45YKZxbMsoA:9
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: cpIOizBc_SdNlnOE1B1HCGEkUuc8vcTn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE4NSBTYWx0ZWRfX3mdnRXWtU5DK
 tjMYBu4gtwtjqisFK5+xDzYwku5AzXPe1Wx53v4Ap9SRDX40htGp5SdXScWkEgUmBL5yCc3vBtD
 lbHp8q3bUbx39PT4/PkzV7lIaU6+j3eilN+f3lsnfgKJU2YcgEalQaAzf4OOHR5Qa8qd+6Jk6rX
 llbJvAILxYc0hrUJKNZVH/LhwJjVB+ZH0OJryVqWjzjUQqtPt0zlIb4mlE2gk2cr+Xq7Z0EoXCG
 eUNDkWdpz6GDqg8Sq6XAvLx4/w+hoh6HRIdYtlxiMV7ju3iqH2xoAbPkV7ZhP2bFI61VEPiOVr7
 4dMq7l97t9VeGIAyeBPctttUuScjxgYEpQsQNjuOWVf96A0AXLyMLWfFhXHeNd//EGE1GWbd7jA
 MadVzcKel373utMn0yr3W10ykKFXv0B/D9HddQ01jlA1Qte4236VM0anOid/NZMeJ4OI1h9bz91
 TnTpjig8bL4gS4qFRvA==

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 99a2ace61b211b0be861b07fbaa062fca4b58879 ]

Use RCU to protect accesses to dst->dev from sk_setup_caps()
and sk_dst_gso_max_size().

Also use dst_dev_rcu() in ip6_dst_mtu_maybe_forward(),
and ip_dst_mtu_maybe_forward().

ip4_dst_hoplimit() can use dst_dev_net_rcu().

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-6-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 99a2ace61b211b0be861b07fbaa062fca4b58879)
[Harshit: Backport to 6.12.y, resolve conflict due to missing commit:
22d6c9eebf2e ("net: Unexport shared functions for DCCP.")  in 6.12.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 include/net/ip.h        |  6 ++++--
 include/net/ip6_route.h |  2 +-
 include/net/route.h     |  2 +-
 net/core/sock.c         | 16 ++++++++++------
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 5f0f1215d2f9..c65ca2765e29 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -470,12 +470,14 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 						    bool forwarding)
 {
 	const struct rtable *rt = dst_rtable(dst);
+	const struct net_device *dev;
 	unsigned int mtu, res;
 	struct net *net;
 
 	rcu_read_lock();
 
-	net = dev_net_rcu(dst_dev(dst));
+	dev = dst_dev_rcu(dst);
+	net = dev_net_rcu(dev);
 	if (READ_ONCE(net->ipv4.sysctl_ip_fwd_use_pmtu) ||
 	    ip_mtu_locked(dst) ||
 	    !forwarding) {
@@ -489,7 +491,7 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 	if (mtu)
 		goto out;
 
-	mtu = READ_ONCE(dst_dev(dst)->mtu);
+	mtu = READ_ONCE(dev->mtu);
 
 	if (unlikely(ip_mtu_locked(dst))) {
 		if (rt->rt_uses_gateway && mtu > 576)
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 9255f21818ee..59f48ca3abdf 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -337,7 +337,7 @@ static inline unsigned int ip6_dst_mtu_maybe_forward(const struct dst_entry *dst
 
 	mtu = IPV6_MIN_MTU;
 	rcu_read_lock();
-	idev = __in6_dev_get(dst_dev(dst));
+	idev = __in6_dev_get(dst_dev_rcu(dst));
 	if (idev)
 		mtu = READ_ONCE(idev->cnf.mtu6);
 	rcu_read_unlock();
diff --git a/include/net/route.h b/include/net/route.h
index 232b7bf55ba2..cbb4d5523062 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -369,7 +369,7 @@ static inline int ip4_dst_hoplimit(const struct dst_entry *dst)
 		const struct net *net;
 
 		rcu_read_lock();
-		net = dev_net_rcu(dst_dev(dst));
+		net = dst_dev_net_rcu(dst);
 		hoplimit = READ_ONCE(net->ipv4.sysctl_ip_default_ttl);
 		rcu_read_unlock();
 	}
diff --git a/net/core/sock.c b/net/core/sock.c
index 1781f3a642b4..97cc796a1d33 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2524,7 +2524,7 @@ void sk_free_unlock_clone(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(sk_free_unlock_clone);
 
-static u32 sk_dst_gso_max_size(struct sock *sk, struct dst_entry *dst)
+static u32 sk_dst_gso_max_size(struct sock *sk, const struct net_device *dev)
 {
 	bool is_ipv6 = false;
 	u32 max_size;
@@ -2534,8 +2534,8 @@ static u32 sk_dst_gso_max_size(struct sock *sk, struct dst_entry *dst)
 		   !ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr));
 #endif
 	/* pairs with the WRITE_ONCE() in netif_set_gso(_ipv4)_max_size() */
-	max_size = is_ipv6 ? READ_ONCE(dst_dev(dst)->gso_max_size) :
-			READ_ONCE(dst_dev(dst)->gso_ipv4_max_size);
+	max_size = is_ipv6 ? READ_ONCE(dev->gso_max_size) :
+			READ_ONCE(dev->gso_ipv4_max_size);
 	if (max_size > GSO_LEGACY_MAX_SIZE && !sk_is_tcp(sk))
 		max_size = GSO_LEGACY_MAX_SIZE;
 
@@ -2544,9 +2544,12 @@ static u32 sk_dst_gso_max_size(struct sock *sk, struct dst_entry *dst)
 
 void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 {
+	const struct net_device *dev;
 	u32 max_segs = 1;
 
-	sk->sk_route_caps = dst_dev(dst)->features;
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
+	sk->sk_route_caps = dev->features;
 	if (sk_is_tcp(sk)) {
 		struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -2562,13 +2565,14 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 			sk->sk_route_caps &= ~NETIF_F_GSO_MASK;
 		} else {
 			sk->sk_route_caps |= NETIF_F_SG | NETIF_F_HW_CSUM;
-			sk->sk_gso_max_size = sk_dst_gso_max_size(sk, dst);
+			sk->sk_gso_max_size = sk_dst_gso_max_size(sk, dev);
 			/* pairs with the WRITE_ONCE() in netif_set_gso_max_segs() */
-			max_segs = max_t(u32, READ_ONCE(dst_dev(dst)->gso_max_segs), 1);
+			max_segs = max_t(u32, READ_ONCE(dev->gso_max_segs), 1);
 		}
 	}
 	sk->sk_gso_max_segs = max_segs;
 	sk_dst_set(sk, dst);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(sk_setup_caps);
 
-- 
2.50.1


