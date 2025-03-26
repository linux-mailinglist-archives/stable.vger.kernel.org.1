Return-Path: <stable+bounces-126658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 622C4A70EE2
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 03:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB315189C2E8
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DAD129A78;
	Wed, 26 Mar 2025 02:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HMS/fSjY"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A649659
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955477; cv=none; b=EfIIm4EiBxz1p+Fapw/ig3Nntt6MGyhPZDDH5KPTvn4tQ+Z6r6sLRdWUCbKjSwPnILIYj6fps+l8CpwlN3fgSxSQnoL2T2SJrJ9+IOy1aLcK/XHu9KhCQttyUSv28yW0Hidf94djjtKYIIhfl/e6q5iUrewTfKU6HYWmxcrGIGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955477; c=relaxed/simple;
	bh=r/AlbwF9hPxenpwlO5t7XgX679U6N/riqxILu99VmQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nPAbMJY5E3q9ay9HJIvU0QgfdROGvggFdgGbRYaOFFeiacKzqQKdMBuUz63iMKErL0sHldoY14kT/yymNtaC2OdE6jQ5sVStWiXKeeTzVzvP4niJN1tOmvU2duJuzl1KXG/zEdabspS0akqVfWUso/D9mwVB3FAn8lXSqvX/s30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HMS/fSjY; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PLtshn006722;
	Wed, 26 Mar 2025 02:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=7uy2xzynTsJOXvPZ6Gqwx71RYgwFp
	9xWldVT+uikZSM=; b=HMS/fSjY395OZ4ZGv5U03o4L9tu6vNcdWpQnPF3p8ggWE
	+ic2VPmLPjIU1YDMU4Cp/toqrfveX3ukjUv/2xoRu5IZpMVWfeLB2qW8/mJe+eKg
	C6Bh3OE3qkkQFT/TRJQOsFK8flMvCDvqk7jG2GF7Pi77E1LAeFPKZZv1EVzCYr80
	RQMXIfpXGXVhyKXicxiuj13SKS6uWorrJHXN89+6ZH66lzBUJKls0AgvJ8zFLHNS
	9fhWHOaCWHra5fowiRSi09eeI9zOSpFBk2XMFGpzqJxCcguW5dFncuq0UR9IUTpf
	lEULLkBZRHO9tLmewk5rwNhbRc+L6fbJ33L30gmqQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn8b8pcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 02:17:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q1DpLR015884;
	Wed, 26 Mar 2025 02:17:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj92s7xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 02:17:36 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52Q2Hadx026276;
	Wed, 26 Mar 2025 02:17:36 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45jj92s7xc-1;
	Wed, 26 Mar 2025 02:17:36 +0000
From: Larry Bassel <larry.bassel@oracle.com>
To: stable@vger.kernel.org
Cc: xieyongji@bytedance.com, jasowang@redhat.com, kuba@kernel.org,
        harshit.m.mogalapalli@oracle.com
Subject: [PATCH 5.4.y V2] virtio-net: Add validation for used length
Date: Tue, 25 Mar 2025 19:17:02 -0700
Message-ID: <20250326021702.2740484-1-larry.bassel@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260012
X-Proofpoint-GUID: tLWPHC4TcMUKQFb45AidDBwCfEAoPL9e
X-Proofpoint-ORIG-GUID: tLWPHC4TcMUKQFb45AidDBwCfEAoPL9e

From: Xie Yongji <xieyongji@bytedance.com>

[ Upstream commit ad993a95c508417acdeb15244109e009e50d8758 ]

This adds validation for used length (might come
from an untrusted device) to avoid data corruption
or loss.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Link: https://lore.kernel.org/r/20210531135852.113-1-xieyongji@bytedance.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit ad993a95c508417acdeb15244109e009e50d8758)
[Larry: backport to 5.4.y. Minor conflict resolved due to missing commit 9ce6146ec7b50
virtio_net: Add XDP frame size in two code paths]
Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
---
v1 -> v2: Fixed the Upstream commit line ID format as per stable docs.

 drivers/net/virtio_net.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 182b67270044..215c546bf50a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -717,6 +717,12 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	len -= vi->hdr_len;
 	stats->bytes += len;
 
+	if (unlikely(len > GOOD_PACKET_LEN)) {
+		pr_debug("%s: rx error: len %u exceeds max size %d\n",
+			 dev->name, len, GOOD_PACKET_LEN);
+		dev->stats.rx_length_errors++;
+		goto err_len;
+	}
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(rq->xdp_prog);
 	if (xdp_prog) {
@@ -819,6 +825,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 err_xdp:
 	rcu_read_unlock();
 	stats->xdp_drops++;
+err_len:
 	stats->drops++;
 	put_page(page);
 xdp_xmit:
@@ -871,6 +878,13 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	head_skb = NULL;
 	stats->bytes += len - vi->hdr_len;
 
+	truesize = mergeable_ctx_to_truesize(ctx);
+	if (unlikely(len > truesize)) {
+		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
+			 dev->name, len, (unsigned long)ctx);
+		dev->stats.rx_length_errors++;
+		goto err_skb;
+	}
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(rq->xdp_prog);
 	if (xdp_prog) {
@@ -990,14 +1004,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	}
 	rcu_read_unlock();
 
-	truesize = mergeable_ctx_to_truesize(ctx);
-	if (unlikely(len > truesize)) {
-		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
-			 dev->name, len, (unsigned long)ctx);
-		dev->stats.rx_length_errors++;
-		goto err_skb;
-	}
-
 	head_skb = page_to_skb(vi, rq, page, offset, len, truesize, !xdp_prog,
 			       metasize);
 	curr_skb = head_skb;
-- 
2.46.0


