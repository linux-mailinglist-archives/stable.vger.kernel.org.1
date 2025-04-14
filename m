Return-Path: <stable+bounces-132663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19619A88BBB
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 20:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABC73B5DE3
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A376127990D;
	Mon, 14 Apr 2025 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tjuusrbe"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255923D285
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656652; cv=none; b=blgQVKWbd1RLapvDWRfRA6U9zQBxZ4gNR82mj7olMlVg5Xa+sBuBqt8ldOkUd5GNgyYNHcR3/uPzn5AroBY6K5TDoLpntkkqyTw+JBISKfxTHtHMk+j79QZs72BvyEzXLU7p20rTDRZx4OigA4gHcsvE5gtuZxfivsBucVua+X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656652; c=relaxed/simple;
	bh=NMTCv4smwbB3aDB2leB8W3xAGvBWXZqyrPSHdBaRu/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=US/tBUH+pesLKVAkizEr/OcBxId7zokW0ftOMQnaTE8R4TI9ge/hnf4iYlncLwMbAbhw33scUb/wmreBnNJSTKuW4LOntdc/JqBVa4TjfE1meIXqug/6/u8cJRmYua4aLAvPhADScPwDYuoiCs4zhtTo7NY3LG9uswcVVJgRIHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tjuusrbe; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EIMnww021326;
	Mon, 14 Apr 2025 18:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=r1I1AV+wkb9tMVQf0qcQyUIdRuiI/sMHnHyxE4yHLOI=; b=
	Tjuusrbe2D1pna9qNh9rdsaQoDxKQ64cMllFe1P0MDTDmOkQH3kX4vQI9i9xD5BM
	YH9VjlSDI1NmH31ALr7cgwsi0qFIChNELscJU/4ghPB3MMOuW6isT/sQt+56ocWE
	D8D19Zhzs8n2ldvV/PqKa+U/bQbnxfNu+x3eJnKPNtxOputHOuOMrhSOv12A0QzR
	9epc74C/t1aExBBV7rCxKh7EghA7Vv+F3uAISgNRSMlwpSmQ15ug9uIfywr/Lkv1
	w5r5GGrLfUNGGyxpFaKxRJKZyH5Ke1n4YaYWUCVNfx+V/E78dGQ9/gRT0xYYvISU
	AiwVAf/KIbTDh9iFfIAhRQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4617ju81u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 18:50:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53EHGloP024656;
	Mon, 14 Apr 2025 18:50:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d4y5f8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 18:50:39 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53EIoUHG035509;
	Mon, 14 Apr 2025 18:50:38 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 460d4y5f48-4;
	Mon, 14 Apr 2025 18:50:38 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com,
        =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <courmisch@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 3/6] phonet/pep: fix racy skb_queue_empty() use
Date: Mon, 14 Apr 2025 11:50:20 -0700
Message-ID: <20250414185023.2165422-4-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414185023.2165422-1-harshit.m.mogalapalli@oracle.com>
References: <20250414185023.2165422-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504140137
X-Proofpoint-GUID: fKmSFeeTN-gmvme_uOZQHEANJajGxOLp
X-Proofpoint-ORIG-GUID: fKmSFeeTN-gmvme_uOZQHEANJajGxOLp

From: Rémi Denis-Courmont <courmisch@gmail.com>

[ Upstream commit 7d2a894d7f487dcb894df023e9d3014cf5b93fe5 ]

The receive queues are protected by their respective spin-lock, not
the socket lock. This could lead to skb_peek() unexpectedly
returning NULL or a pointer to an already dequeued socket buffer.

Fixes: 9641458d3ec4 ("Phonet: Pipe End Point for Phonet Pipes protocol")
Signed-off-by: Rémi Denis-Courmont <courmisch@gmail.com>
Link: https://lore.kernel.org/r/20240218081214.4806-2-remi@remlab.net
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Harshit: backport to 5.15.y, clean cherrypick from 6.1.y commit]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/phonet/pep.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index 65d463ad8770..3ea23e7caab6 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -916,6 +916,37 @@ static int pep_sock_enable(struct sock *sk, struct sockaddr *addr, int len)
 	return 0;
 }
 
+static unsigned int pep_first_packet_length(struct sock *sk)
+{
+	struct pep_sock *pn = pep_sk(sk);
+	struct sk_buff_head *q;
+	struct sk_buff *skb;
+	unsigned int len = 0;
+	bool found = false;
+
+	if (sock_flag(sk, SOCK_URGINLINE)) {
+		q = &pn->ctrlreq_queue;
+		spin_lock_bh(&q->lock);
+		skb = skb_peek(q);
+		if (skb) {
+			len = skb->len;
+			found = true;
+		}
+		spin_unlock_bh(&q->lock);
+	}
+
+	if (likely(!found)) {
+		q = &sk->sk_receive_queue;
+		spin_lock_bh(&q->lock);
+		skb = skb_peek(q);
+		if (skb)
+			len = skb->len;
+		spin_unlock_bh(&q->lock);
+	}
+
+	return len;
+}
+
 static int pep_ioctl(struct sock *sk, int cmd, unsigned long arg)
 {
 	struct pep_sock *pn = pep_sk(sk);
@@ -929,15 +960,7 @@ static int pep_ioctl(struct sock *sk, int cmd, unsigned long arg)
 			break;
 		}
 
-		lock_sock(sk);
-		if (sock_flag(sk, SOCK_URGINLINE) &&
-		    !skb_queue_empty(&pn->ctrlreq_queue))
-			answ = skb_peek(&pn->ctrlreq_queue)->len;
-		else if (!skb_queue_empty(&sk->sk_receive_queue))
-			answ = skb_peek(&sk->sk_receive_queue)->len;
-		else
-			answ = 0;
-		release_sock(sk);
+		answ = pep_first_packet_length(sk);
 		ret = put_user(answ, (int __user *)arg);
 		break;
 
-- 
2.47.1


