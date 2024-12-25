Return-Path: <stable+bounces-106100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542489FC3A2
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 06:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092FE1884451
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 05:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90177145A19;
	Wed, 25 Dec 2024 05:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ddhTV2Eq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD74513B2AF;
	Wed, 25 Dec 2024 05:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735103827; cv=none; b=Pu1vXp1EqJVR0cX68aYd7WYueXXaP6HkDZ2uHeQfEsIJth+hHKl538ssim7iJZks1Q8jbzW21A5MEE0Jn6byasLjvvlT6rLJygoUss4IYx56yI5xquSHtnFFMEnyPCN2xhtc6iiPHcD2d7hHxoPDLHUzXCRcA/nt+K1aIYqr5Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735103827; c=relaxed/simple;
	bh=8g8ETFIgrUxfnGeZYXx7/SoNr5i/5yaC2b109Wxz7iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCkGSmUNb1yEa8lCfFGNMSM+jxuW1Kkn+JTDUaNAAg2Z5sc868q4wfXFASqq3Vf0YnYDES7kC+E/5YJmtxwEPhr/yzqIeYCTzsvEPwqscJ+tlxBymyXQVu6A4NbYKmN408ntvfE8W/+F055tDrOsxbKmzwTddnQLAwWz5LU342I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ddhTV2Eq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BP0BoPO022195;
	Wed, 25 Dec 2024 05:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=BaCeY
	+sGMCrCb/dCVqGWlDTz9P7md1sAUO+PBqDm/Xo=; b=ddhTV2EqFg9DBSMEDgBsf
	leBHO/tcJKeZsOdf8hM7F5sPguzloDf57/J9FXZ89gob4JWgQn4zZC5Xki+bOnHL
	TVLzFAtlvPqo9VfHj8el/JBXFB1EXbduDaLPzAitKL9KbYn+DSyzHCSGoHC5jwtq
	jd4VeCBzDsSoF70w/3ognk+Br7dgj3EUlgG9exUBoR4aSbcarmaUK2qhxHM85glZ
	T/1Yx2XM2O9vv5eXvWfbtJcK5vDqKq5pM5YwBhAUghX6YFAuUhaByr0cJNL495Eu
	UAsd8e63HHeACyCHgckVOPTT2dmnJD/z0mVgKdcZrCR4Q7wDPXWg6DgM0qbR4XEA
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq6sd2qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Dec 2024 05:16:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BP0FCCZ001803;
	Wed, 25 Dec 2024 05:16:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43pk8ucjrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Dec 2024 05:16:27 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BP5GPgA035712;
	Wed, 25 Dec 2024 05:16:27 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 43pk8ucjr2-4;
	Wed, 25 Dec 2024 05:16:26 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        kuba@kernel.org
Cc: harshvardhan.j.jha@oracle.com, netdev@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 5.4.y 5.10.y 3/4] ipv6: use skb_expand_head in ip6_xmit
Date: Tue, 24 Dec 2024 21:16:23 -0800
Message-ID: <20241225051624.127745-4-harshvardhan.j.jha@oracle.com>
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
X-Proofpoint-ORIG-GUID: kvukrOxS4lfgXt07fl7SRpExSXU24MMU
X-Proofpoint-GUID: kvukrOxS4lfgXt07fl7SRpExSXU24MMU

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit 0c9f227bee11910a49e1d159abe102d06e3745d5 ]

Unlike skb_realloc_headroom, new helper skb_expand_head
does not allocate a new skb if possible.

Additionally this patch replaces commonly used dereferencing with variables.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 0c9f227bee11910a49e1d159abe102d06e3745d5)
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
---
 net/ipv6/ip6_output.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7806963b4539e..a8475848d0382 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -254,6 +254,8 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
+	struct net_device *dev = dst->dev;
+	struct inet6_dev *idev = ip6_dst_idev(dst);
 	unsigned int head_room;
 	struct ipv6hdr *hdr;
 	u8  proto = fl6->flowi6_proto;
@@ -261,22 +263,16 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	int hlimit = -1;
 	u32 mtu;
 
-	head_room = sizeof(struct ipv6hdr) + LL_RESERVED_SPACE(dst->dev);
+	head_room = sizeof(struct ipv6hdr) + LL_RESERVED_SPACE(dev);
 	if (opt)
 		head_room += opt->opt_nflen + opt->opt_flen;
 
-	if (unlikely(skb_headroom(skb) < head_room)) {
-		struct sk_buff *skb2 = skb_realloc_headroom(skb, head_room);
-		if (!skb2) {
-			IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
-				      IPSTATS_MIB_OUTDISCARDS);
-			kfree_skb(skb);
+	if (unlikely(head_room > skb_headroom(skb))) {
+		skb = skb_expand_head(skb, head_room);
+		if (!skb) {
+			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 			return -ENOBUFS;
 		}
-		if (skb->sk)
-			skb_set_owner_w(skb2, skb->sk);
-		consume_skb(skb);
-		skb = skb2;
 	}
 
 	if (opt) {
@@ -318,8 +314,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 
 	mtu = dst_mtu(dst);
 	if ((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb)) {
-		IP6_UPD_PO_STATS(net, ip6_dst_idev(skb_dst(skb)),
-			      IPSTATS_MIB_OUT, skb->len);
+		IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
 
 		/* if egress device is enslaved to an L3 master device pass the
 		 * skb to its handler for processing
@@ -332,17 +327,17 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		 * we promote our socket to non const
 		 */
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
-			       net, (struct sock *)sk, skb, NULL, dst->dev,
+			       net, (struct sock *)sk, skb, NULL, dev,
 			       dst_output);
 	}
 
-	skb->dev = dst->dev;
+	skb->dev = dev;
 	/* ipv6_local_error() does not require socket lock,
 	 * we promote our socket to non const
 	 */
 	ipv6_local_error((struct sock *)sk, EMSGSIZE, fl6, mtu);
 
-	IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_FRAGFAILS);
+	IP6_INC_STATS(net, idev, IPSTATS_MIB_FRAGFAILS);
 	kfree_skb(skb);
 	return -EMSGSIZE;
 }
-- 
2.46.0


