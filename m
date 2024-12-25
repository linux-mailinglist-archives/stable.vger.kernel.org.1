Return-Path: <stable+bounces-106101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB8A9FC3A3
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 06:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED8987A17AF
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 05:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0151487ED;
	Wed, 25 Dec 2024 05:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e7npYA5a"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC4413AA2B;
	Wed, 25 Dec 2024 05:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735103828; cv=none; b=NM7Da7yIS3xoQ4FiGk39seTakd3j7pOMs/VKeRb0PcVfs7D7KcsdlFKT3UB3zbRYAI+E0RtUawsgNdo7s/Leg3rYJRCdXvl/QgfCKmYZkp5rwLNhqfCuQqo/nb3pe4fOlPpJtl1hgIOb/HqQYmXlSu2h2mmksFjzYsNQBvZ5tUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735103828; c=relaxed/simple;
	bh=zaViJNomEckKKcjjBSRQLLpChjsOyScVQjvRS2k5bAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jypKrJxLyJVXBhMgb/6SC8kWEuF0AfpS8yiZmLVbWfMpmzyGYicS7km/vFoA6wrM1KOPvVHkh+R8IsfWb4gU6Je+ITyTBZJGW/KnhhPOxge4SOTZ4Hgm98u5gvlNmFjt3vcEvXipwSCqaA9TM6XUwer8ihgbr0RVKameE7mQFKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e7npYA5a; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BP3PxkL004751;
	Wed, 25 Dec 2024 05:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=ZFYCl
	pbOYCw+0yUTOUOfc8jYTx/JcRzMVv7MjxoNwKI=; b=e7npYA5amjF6uDjFKuRBd
	s0UYDDHsa2POEBa+nNMk1cAEDwJqHA6909AvIuqpJXbPjFIQjs1X5N92orv3DJTr
	O+4LYictDYwHTlAah/RuLJksE3nabBSC12X6oUWzZCEvIL15Ln8rmlPuOoGZ8kWz
	dp9MpSfgflmODUcLyYo09WjEEKAPkyUG8bawdIrMCdcx2G3d+Y9O+67PNaEQdq4q
	w/6yPC/mIGiV7jKYqztv+m2kkC54OF0ZKYioxl1ooXfR4y17tKpUTcjwly1UVRPw
	T7k1XcVr8sFx4EK0VQLTZFUH4bP62SYThJH1ENkwVVNi3C5HQAAMWOpnVWzyqbg3
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nqd5n14w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Dec 2024 05:16:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BP4vUM5000936;
	Wed, 25 Dec 2024 05:16:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43pk8ucjry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Dec 2024 05:16:28 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BP5GPgC035712;
	Wed, 25 Dec 2024 05:16:27 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 43pk8ucjr2-5;
	Wed, 25 Dec 2024 05:16:27 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        kuba@kernel.org
Cc: harshvardhan.j.jha@oracle.com, netdev@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 5.4.y 5.10.y 4/4] ipv6: fix possible UAF in ip6_finish_output2()
Date: Tue, 24 Dec 2024 21:16:24 -0800
Message-ID: <20241225051624.127745-5-harshvardhan.j.jha@oracle.com>
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
X-Proofpoint-GUID: -k21lX0dPkK94p2TMCvH-i78C820-tZ5
X-Proofpoint-ORIG-GUID: -k21lX0dPkK94p2TMCvH-i78C820-tZ5

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit e891b36de161fcd96f12ff83667473e5067b9037 ]

If skb_expand_head() returns NULL, skb has been freed
and associated dst/idev could also have been freed.

We need to hold rcu_read_lock() to make sure the dst and
associated idev are alive.

Fixes: 5796015fa968 ("ipv6: allocate enough headroom in ip6_finish_output2()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vasily Averin <vasily.averin@linux.dev>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20240820160859.3786976-3-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit e891b36de161fcd96f12ff83667473e5067b9037)
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
---
 net/ipv6/ip6_output.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index a8475848d0382..48f926157ef8c 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -69,11 +69,15 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 	/* Be paranoid, rather than too clever. */
 	if (unlikely(hh_len > skb_headroom(skb)) && dev->header_ops) {
+		/* Make sure idev stays alive */
+		rcu_read_lock();
 		skb = skb_expand_head(skb, hh_len);
 		if (!skb) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
+			rcu_read_unlock();
 			return -ENOMEM;
 		}
+		rcu_read_unlock();
 	}
 
 	hdr = ipv6_hdr(skb);
-- 
2.46.0


