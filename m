Return-Path: <stable+bounces-126644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B86FA70DBF
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 00:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA75016F5D3
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 23:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794E2269CFD;
	Tue, 25 Mar 2025 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XAbRax3e"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A9254B1A
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742946294; cv=none; b=j+S8wkM54VRpjKJH08Yz0wwF2RtqRlMb2D8bcRSG3DdJlS00aBCcdmmwuulDQD6DyPMkAHcRmlNhaHReBOODOEf2u7YX0wEFtLYIgaTLvC8W5I+VRIfd8JEeWYDM3YwkHZNMNST8dnCsfr102+bMtq8gazz9eus1sJUKY4RBef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742946294; c=relaxed/simple;
	bh=5hc9k3osfaqw0Bqo8AzzRsABtaJ3x4fPy1xau/HPG2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+3V5iW79yij1QaTmHE9epfdm7N/mvDGpavUFyboAtPccZEg/o7Or1aMuFXdZVlwdUCS1vGq3jbBraiBjJy2oYBNVUMDAj7n2Z4WHFc76umjqAIncwRJpu//jHANBtNNYj7u1u72IM1wZUpzxo7ZDOeD1kuKbe1UvrlXVVsXCaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XAbRax3e; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PLtvYJ025363;
	Tue, 25 Mar 2025 23:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=koErJwERXF6Um/NgPSIm0Q7JyhkvZ
	T5qAyuSmJhKHTQ=; b=XAbRax3ewNdzqDGksy/wH6uBdHCnFGfVRQ/EFPxaCqa6X
	eFLSLXk1nl0SD6nij5nZcYqUyP9/OHIOq9gpLUO4KZme0FeLkZDoIpWgxoYsqkDD
	mA1STg7aLppZwKG05BuwFWmgK5zWkOKl4uL7/REXuXnK/11FKfotpbnVb90tH/dp
	PoKxZDf6UULVEMbnMwSM6Qn/kEM04gxh1Isp3JQSzQ6nClrylEl9p5mB0BFKMQyd
	0jSklzv8LT6MHXem2GRYlqllxumO0Z+YJ+APVsE0alMGgyVi66pQ2EI/tG0YnN6c
	mnr0r8hzY6vfrDJ71SeA1YdDAtRCBB8P24JiSXFDA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn8707w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 23:44:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52PN9xl4015177;
	Tue, 25 Mar 2025 23:44:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj92nb48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 23:44:36 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52PNiaL3038603;
	Tue, 25 Mar 2025 23:44:36 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45jj92nb3v-1;
	Tue, 25 Mar 2025 23:44:36 +0000
From: Larry Bassel <larry.bassel@oracle.com>
To: stable@vger.kernel.org
Cc: xieyongji@bytedance.com, jasowang@redhat.com, kuba@kernel.org,
        harshit.m.mogalapalli@oracle.com
Subject: [PATCH 5.4.y] virtio-net: Add validation for used length
Date: Tue, 25 Mar 2025 16:44:02 -0700
Message-ID: <20250325234402.2735260-1-larry.bassel@oracle.com>
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
 definitions=main-2503250156
X-Proofpoint-GUID: eQ08XEJYIQXBb5akdc7bnszNEysC8K72
X-Proofpoint-ORIG-GUID: eQ08XEJYIQXBb5akdc7bnszNEysC8K72

From: Xie Yongji <xieyongji@bytedance.com>

commit ad993a95c508 ("virtio-net: Add validation for used length")

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


