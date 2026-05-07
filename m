Return-Path: <stable+bounces-244566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGeQAtyI/GleRAAAu9opvQ
	(envelope-from <stable+bounces-244566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 14:43:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4244E8571
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 14:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1EFB3011C52
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 12:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369DA3ED5D5;
	Thu,  7 May 2026 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L7R3Jpj3"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A21B372B3D
	for <stable@vger.kernel.org>; Thu,  7 May 2026 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157785; cv=none; b=cpzY2o25bQF0MFDTjuA2EFhLKqqKIYHcIvV7ZfW/OmuJu1Z7BS9/rc3u0JgtIxxPoPgdHiTiBR3TkuuyYb4v8Zk68ARxjykyp/pLC00zhNVWUU6wzw6CFaVp/NwaR/E4mTuSVcqCdes01qYNJJYkrluw9illM6bL23Ijh7HuYBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157785; c=relaxed/simple;
	bh=3YPl6R9T0+4/oMwmoswOu4CziH3gdfN/bFi5wfaBeD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHKO3Uj4Vcg68cfBo/m33G7CrAaZvqrYt3zfMhky8rVPKkSNrWHlU6G2kk7zSNpDga4i9fFai8PuqXdgkJQBhXCK1kzlWHVOQ1KubGLgsGyVZhlhzgmKz3ARBltIMEop37Nc9WZc8lIt9jum5xExIQpBOMUSaBKbYdJSM1H7Ki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L7R3Jpj3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646MfXPp4158935;
	Thu, 7 May 2026 12:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=rffbh
	rq5kgbQWFpRjVfS/yiq3wBeg/KHi1XwC7MZWQE=; b=L7R3Jpj3RZso8slDi3ymw
	/7n+vCxdr6Z1PHuFsm4zscgJ74gtljKmRcsyoDlIlMA25RUs6I1zzAmrcpbDDZYg
	2tmUPD5RJ1xDcGwopWQD04JUkDojOHkvtPij27SleeVoTJT1MGVX8P1yqIyOvyC/
	K2P4+FivOUGmObALAMLM7oPl9gFHkNMgEPY3mb2JlIUETbEH8RKnppjj9vro+1L8
	7Hvg5FlsR2RiZzXVjdgtk/anPk0t+b2MydhzP+h0+f2bLohC0rnyhBJh85kBJV5c
	IRh6J5FIqkxtih5AO4prJnQHJhw2UtVspfpXmii/XRDg/1HE2DXFJQ88SJgeycQ8
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9frgty1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 May 2026 12:43:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 647CaPiv015622;
	Thu, 7 May 2026 12:43:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dx59504s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 May 2026 12:43:00 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 647CgwGu037123;
	Thu, 7 May 2026 12:43:00 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dx59504rk-2;
	Thu, 07 May 2026 12:43:00 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org, axboe@kernel.dk
Cc: Pavel Begunkov <asml.silence@gmail.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 7.0.y,6.18.y 1/2] io_uring/zcrx: use guards for locking
Date: Thu,  7 May 2026 05:42:52 -0700
Message-ID: <20260507124253.97596-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260507124253.97596-1-harshit.m.mogalapalli@oracle.com>
References: <20260507124253.97596-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=967
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2605070126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEyNyBTYWx0ZWRfXwcqfKyyHkleR
 QMRI3TmvF7e1uJgOc2K6wKHPvPY1Lw2gr9kTYUeAHiyhAaPbNdepCxXk00MxN5/ricFwBnD9ULY
 +PUzp471SrKzxQSZCWeH6LncWFwVa5Ga0VepHI13HCJbDESR24Cj6073YP+znax9vInXY3bHN0S
 3bA9jNChmGqQyVlsrLt59npO463lBe8cKzJdsYQHJGMpFrknlM2eJxvyQ8lQoRMbYkr06CmzBA0
 V4Nmxi7Gt7vVbrZDwk29cTyWHGEaPquXpGxGEfaCIES8+iGM7g+6iBtqFm6UOsIIoNXTwD9NLt1
 9FhqJ4mfWpo2xBCekKUUXPSiJjZqeh5dhRRFFMttTCAkzTPfhtEBWc0hMAvQ1ZqfE5GnYS0Ijg/
 t2kj0iOvuryA0DTS6Sg5JTYuFalBiPdv65X9ewOQNiIEdrYLppMcbIkf/BHpvv/R7kNC37wTjC6
 Q/qaMZYeF8l22HObKUw==
X-Authority-Analysis: v=2.4 cv=TZ6mcxQh c=1 sm=1 tr=0 ts=69fc88d5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=Y9Y3uDrJOTeolJIxXIwA:9 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: Sekk_dCbD0nMivJXrXD74wHLN1yseEW6
X-Proofpoint-GUID: Sekk_dCbD0nMivJXrXD74wHLN1yseEW6
X-Rspamd-Queue-Id: 7E4244E8571
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244566-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit 898ad80d1207cbdb22b21bafb6de4adfd7627bd0 ]

Convert last several places using manual locking to guards to simplify
the code.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://patch.msgid.link/eb4667cfaf88c559700f6399da9e434889f5b04a.1774261953.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
(cherry picked from commit 898ad80d1207cbdb22b21bafb6de4adfd7627bd0)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 io_uring/zcrx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index af4b88e106ab..517b8ddb2cc2 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -586,9 +586,8 @@ static void io_zcrx_return_niov_freelist(struct net_iov *niov)
 {
 	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
 
-	spin_lock_bh(&area->freelist_lock);
+	guard(spinlock_bh)(&area->freelist_lock);
 	area->freelist[area->free_count++] = net_iov_idx(niov);
-	spin_unlock_bh(&area->freelist_lock);
 }
 
 static void io_zcrx_return_niov(struct net_iov *niov)
@@ -1029,7 +1028,8 @@ static void io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *ifq)
 {
 	struct io_zcrx_area *area = ifq->area;
 
-	spin_lock_bh(&area->freelist_lock);
+	guard(spinlock_bh)(&area->freelist_lock);
+
 	while (area->free_count && pp->alloc.count < PP_ALLOC_CACHE_REFILL) {
 		struct net_iov *niov = __io_zcrx_get_free_niov(area);
 		netmem_ref netmem = net_iov_to_netmem(niov);
@@ -1038,7 +1038,6 @@ static void io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *ifq)
 		io_zcrx_sync_for_device(pp, niov);
 		net_mp_netmem_place_in_cache(pp, netmem);
 	}
-	spin_unlock_bh(&area->freelist_lock);
 }
 
 static netmem_ref io_pp_zc_alloc_netmems(struct page_pool *pp, gfp_t gfp)
@@ -1264,10 +1263,10 @@ static struct net_iov *io_alloc_fallback_niov(struct io_zcrx_ifq *ifq)
 	if (area->mem.is_dmabuf)
 		return NULL;
 
-	spin_lock_bh(&area->freelist_lock);
-	if (area->free_count)
-		niov = __io_zcrx_get_free_niov(area);
-	spin_unlock_bh(&area->freelist_lock);
+	scoped_guard(spinlock_bh, &area->freelist_lock) {
+		if (area->free_count)
+			niov = __io_zcrx_get_free_niov(area);
+	}
 
 	if (niov)
 		page_pool_fragment_netmem(net_iov_to_netmem(niov), 1);
-- 
2.50.1


