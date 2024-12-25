Return-Path: <stable+bounces-106098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE5F9FC39D
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 06:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B2607A17AD
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 05:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD9E14264A;
	Wed, 25 Dec 2024 05:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ATuF7Bpi"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9AD101EE;
	Wed, 25 Dec 2024 05:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735103827; cv=none; b=XPwRveuS9fAw36BGIrPIEQAV0gjylEB5gSKDspBUcfPm1udMJ9vPHjhHad0+t6ORI5Tj4+3cytmWXYx39IUrb2nTPRSUa3rH3lPwYzqNX4HRkcDiMjnoT4UqRftDD6pHttiEJnbaQK9KhdMZpOSBixp4Kx695boUyVAPlKg78Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735103827; c=relaxed/simple;
	bh=0txuHcWcnDSvB9rywhMrxH2nNsI+24cfzeVrBFdFCkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWNvLopQdar/vjkD13Ia8/O5bidWIYgnazZLC92eKMbCnnSuGno8JKbPANpJra37NDkYxSMVWdGhLanqSj6GfJpP/YHoVWic8d+MKpfTxd3MaunGjoOJ3h2E11GYEby8hwOMBnGRH5/+5XShyWECBPtQ8iCIsGE2BC34pwee7nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ATuF7Bpi; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BP2kx5d025770;
	Wed, 25 Dec 2024 05:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=KSKiy
	YBWLwMKYYsiDnYynubWpye0Ep3IMDEoCgd2jiU=; b=ATuF7BpiXuNrkGO/r7mnd
	asO/HI0TLSNViFe5mxKr5huSl8GWyXKFPH/CadlakJylmco0jVOQ6vku5ow+mLv5
	a94t6DhXaSnCVFT0S8Yd+xkuCLoe0OlDzKw8aDd4/vrWev8dicgH7pukILTetZT5
	CTbKgIWasDOJ1JHdJrm2Fd2PJoQqdMEr/bdy51ukvHQnEQrQH2JKWPHE+GzXj2qL
	Xs7UptcqVV7kRcCPbGo9HhocULjRR1UiyJ02oG08X6hVLnnnX0nPtAUFjWxRLsdL
	dNc3TpiAWvEirR0FO0nFQq/sLgJfOcqt6npMUaRdWlgMG4TO4DEyt/0NrhJBGDtD
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq56w2g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Dec 2024 05:16:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BP0FCCY001803;
	Wed, 25 Dec 2024 05:16:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43pk8ucjrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Dec 2024 05:16:26 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BP5GPg8035712;
	Wed, 25 Dec 2024 05:16:26 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 43pk8ucjr2-3;
	Wed, 25 Dec 2024 05:16:26 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        kuba@kernel.org
Cc: harshvardhan.j.jha@oracle.com, netdev@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 5.4.y 5.10.y 2/4] ipv6: use skb_expand_head in ip6_finish_output2
Date: Tue, 24 Dec 2024 21:16:22 -0800
Message-ID: <20241225051624.127745-3-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241225051624.127745-1-harshvardhan.j.jha@oracle.com>
References: <20241225051624.127745-1-harshvardhan.j.jha@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-25_01,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412250044
X-Proofpoint-GUID: OugqSS6DIFglZVax7x-dujeRWQOjxrNU
X-Proofpoint-ORIG-GUID: OugqSS6DIFglZVax7x-dujeRWQOjxrNU

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit e415ed3a4b8b246ee5e9d109ff5153efcf96b9f2 ]

Unlike skb_realloc_headroom, new helper skb_expand_head does not allocate
a new skb if possible.

Additionally this patch replaces commonly used dereferencing with variables.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit e415ed3a4b8b246ee5e9d109ff5153efcf96b9f2)
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
---
 net/ipv6/ip6_output.c | 51 ++++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 35 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 26d8105981e96..7806963b4539e 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -60,46 +60,29 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct net_device *dev = dst->dev;
+	struct inet6_dev *idev = ip6_dst_idev(dst);
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
-	int delta = hh_len - skb_headroom(skb);
-	const struct in6_addr *nexthop;
+	const struct in6_addr *daddr, *nexthop;
+	struct ipv6hdr *hdr;
 	struct neighbour *neigh;
 	int ret;
 
 	/* Be paranoid, rather than too clever. */
-	if (unlikely(delta > 0) && dev->header_ops) {
-		/* pskb_expand_head() might crash, if skb is shared */
-		if (skb_shared(skb)) {
-			struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
-
-			if (likely(nskb)) {
-				if (skb->sk)
-					skb_set_owner_w(nskb, skb->sk);
-				consume_skb(skb);
-			} else {
-				kfree_skb(skb);
-			}
-			skb = nskb;
-		}
-		if (skb &&
-		    pskb_expand_head(skb, SKB_DATA_ALIGN(delta), 0, GFP_ATOMIC)) {
-			kfree_skb(skb);
-			skb = NULL;
-		}
+	if (unlikely(hh_len > skb_headroom(skb)) && dev->header_ops) {
+		skb = skb_expand_head(skb, hh_len);
 		if (!skb) {
-			IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTDISCARDS);
+			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 			return -ENOMEM;
 		}
 	}
 
-	if (ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr)) {
-		struct inet6_dev *idev = ip6_dst_idev(skb_dst(skb));
-
+	hdr = ipv6_hdr(skb);
+	daddr = &hdr->daddr;
+	if (ipv6_addr_is_multicast(daddr)) {
 		if (!(dev->flags & IFF_LOOPBACK) && sk_mc_loop(sk) &&
 		    ((mroute6_is_socket(net, skb) &&
 		     !(IP6CB(skb)->flags & IP6SKB_FORWARDED)) ||
-		     ipv6_chk_mcast_addr(dev, &ipv6_hdr(skb)->daddr,
-					 &ipv6_hdr(skb)->saddr))) {
+		     ipv6_chk_mcast_addr(dev, daddr, &hdr->saddr))) {
 			struct sk_buff *newskb = skb_clone(skb, GFP_ATOMIC);
 
 			/* Do not check for IFF_ALLMULTI; multicast routing
@@ -110,7 +93,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 					net, sk, newskb, NULL, newskb->dev,
 					dev_loopback_xmit);
 
-			if (ipv6_hdr(skb)->hop_limit == 0) {
+			if (hdr->hop_limit == 0) {
 				IP6_INC_STATS(net, idev,
 					      IPSTATS_MIB_OUTDISCARDS);
 				kfree_skb(skb);
@@ -119,9 +102,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 		}
 
 		IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUTMCAST, skb->len);
-
-		if (IPV6_ADDR_MC_SCOPE(&ipv6_hdr(skb)->daddr) <=
-		    IPV6_ADDR_SCOPE_NODELOCAL &&
+		if (IPV6_ADDR_MC_SCOPE(daddr) <= IPV6_ADDR_SCOPE_NODELOCAL &&
 		    !(dev->flags & IFF_LOOPBACK)) {
 			kfree_skb(skb);
 			return 0;
@@ -136,10 +117,10 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 	}
 
 	rcu_read_lock_bh();
-	nexthop = rt6_nexthop((struct rt6_info *)dst, &ipv6_hdr(skb)->daddr);
-	neigh = __ipv6_neigh_lookup_noref(dst->dev, nexthop);
+	nexthop = rt6_nexthop((struct rt6_info *)dst, daddr);
+	neigh = __ipv6_neigh_lookup_noref(dev, nexthop);
 	if (unlikely(!neigh))
-		neigh = __neigh_create(&nd_tbl, nexthop, dst->dev, false);
+		neigh = __neigh_create(&nd_tbl, nexthop, dev, false);
 	if (!IS_ERR(neigh)) {
 		sock_confirm_neigh(skb, neigh);
 		ret = neigh_output(neigh, skb, false);
@@ -148,7 +129,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 	}
 	rcu_read_unlock_bh();
 
-	IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTNOROUTES);
+	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTNOROUTES);
 	kfree_skb(skb);
 	return -EINVAL;
 }
-- 
2.46.0


