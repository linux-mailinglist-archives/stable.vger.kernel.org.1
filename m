Return-Path: <stable+bounces-80566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F7D98DE95
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBAD128394F
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A261D07B1;
	Wed,  2 Oct 2024 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WSflk7SX"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BD01D0B9E
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882030; cv=none; b=LXpK2+s0e/QIoWRAjaJ69V+L26YcLTWCXU9QE8rlwCKmMhWFISvNdeJ0qGhzDHtQq3e+F6oT3BZorJB3IeAQbPN6g5Mx2qQHT4LBoEOPdYbOYfZbFTuVOlokqefEjX6cnyIvY37JVtE/jwPpX/5mavqAXqBwCdehfhJDoyxPKXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882030; c=relaxed/simple;
	bh=3FGk5ek3QCNiObVzkJBAdyRC+waJ0j8R2Adkb8IIwMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z9dXf9oaCBS0LRHro2PzAzOEoJ857QVhhxFsjtlYOsAyLyrGZshRs3BWKHj9tLY9MBcf21ZlDleQAeS0Ej1ke35INay1ubm++wnSxLDLg7LlM4oPTgcFTgsjwoq4GW68pNWV52VYyeLJa39zQFl0oKTNQUCeXojHunAscBkdcE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WSflk7SX; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492CdCc4003096;
	Wed, 2 Oct 2024 15:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=v
	otGSwVOY8EclyzkDnSwCRB/31YwzzUbxH/dtKt86yY=; b=WSflk7SXbNAoE25fR
	8pjO2bguuNwSCd/zk3VV/bZA4jnrkzinNrBD0L2S08idu4j0s9RednuvnZbL6xw3
	YVWu4SmcWmdTeCKuQ2PCOblcqM7Dfx9Wbb/WnL5nDxVM8OspVD/J7Otx28b0Iqap
	QUC1Q8CsRUlctcT3YKcHKbPhMmovWXkS2+6A4ev1C6AGlUgbPoDBeYlYxQDQToug
	cfqTFx2WYcLzkDach3s3WB4LA7UEx5DX2eeAMwdUGhtC5ab3sTraLxG4txZdhJx1
	sWBe7Va4l2a/Si/MOBgzrQRXMvmcNj/2HrjHrsovdN5v1jzRZEOwenIwRCvxW/Hm
	VaoGw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qb9h7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:13:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492EhTDu028497;
	Wed, 2 Oct 2024 15:13:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x8897asw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:13:37 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 492FCqrX028673;
	Wed, 2 Oct 2024 15:13:36 GMT
Received: from localhost.localdomain (dhcp-10-175-43-118.vpn.oracle.com [10.175.43.118])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x88979xb-3;
	Wed, 02 Oct 2024 15:13:36 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
        mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
        ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
        shivani.agarwal@broadcom.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jens Axboe <axboe@kernel.dk>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH RFC 6.6.y 13/15] null_blk: Remove usage of the deprecated ida_simple_xx() API
Date: Wed,  2 Oct 2024 17:12:34 +0200
Message-Id: <20241002151236.11787-3-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002151236.11787-1-vegard.nossum@oracle.com>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <20241002151236.11787-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020111
X-Proofpoint-GUID: 2thZe7-qCndLS5tnLsXz1nrSZgoyVOKr
X-Proofpoint-ORIG-GUID: 2thZe7-qCndLS5tnLsXz1nrSZgoyVOKr

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 95931a245b44ee04f3359ec432e73614d44d8b38 ]

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/bf257b1078475a415cdc3344c6a750842946e367.1705222845.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Jens Axboe <axboe@kernel.dk>
(cherry picked from commit 95931a245b44ee04f3359ec432e73614d44d8b38)
[Harshit: backport to 6.6.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f1b7d7fdffec8..85ab763184b31 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1819,7 +1819,7 @@ static void null_del_dev(struct nullb *nullb)
 
 	dev = nullb->dev;
 
-	ida_simple_remove(&nullb_indexes, nullb->index);
+	ida_free(&nullb_indexes, nullb->index);
 
 	list_del_init(&nullb->list);
 
@@ -2154,7 +2154,7 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
 
 	mutex_lock(&lock);
-	rv = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
+	rv = ida_alloc(&nullb_indexes, GFP_KERNEL);
 	if (rv < 0) {
 		mutex_unlock(&lock);
 		goto out_cleanup_zone;
-- 
2.34.1


