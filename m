Return-Path: <stable+bounces-244567-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKI0OvCI/GleRAAAu9opvQ
	(envelope-from <stable+bounces-244567-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 14:43:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E01DE4E8597
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 14:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D240300F78C
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAAC3ED5D5;
	Thu,  7 May 2026 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AFRnoOr+"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D53B19BC
	for <stable@vger.kernel.org>; Thu,  7 May 2026 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157792; cv=none; b=XrhLdaSkqWEphV5yJvcL2HvEkVx4bq6XiFYBEbB8gt8HBLmQ9sMJUkrScNYAGd/RFaiZpx1BzfArArjGJDBp4pfDSAWMZg6cxYJE07Lic3UlYtrHKB1rC27qjFgC1HbuQ4FgoJHv2mRg93opAGfOVxEM96t4kNUIkDfL8JvyTKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157792; c=relaxed/simple;
	bh=xSZejWHY0pDmfWds3JJvIkWaZEvP/u+uuKLjPaWYVKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qd0Nindxfyz6KhqkfrBzx76fbjJ7m8rCF9xLG8F/zYwDWz/3zwIZuiSqGotigSEsOiNl4ULwDBUNKpPSwuFPMIn412MvtBrt2E1HY+gNyHBv/YX2l+axERYOVKVDRSzne9tNI1nbKfF0y9kD8nbAV8rzMJNZC9koU3+wFMdgUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AFRnoOr+; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646MfZRq4159048;
	Thu, 7 May 2026 12:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=8I3q6
	EQGlW4cGn2RfeG1Wc65NUyaElrkD0xjdbqxJeY=; b=AFRnoOr+b1Nf7+b0YcnC3
	16kKhMihX9WSkgVhW2TVN1qJdRw496ui7mmD7TlzIqXW56OD1iscE9B6HxxRN+zN
	cstA9mSHH10+oiTa8YPb/oMZ+C0cP5jBSyqLJX1PuC4sk4AqVZenK8vqhA6MrhIJ
	NfDXbRaX2mlYX/t6fW3l1fy9uabj+4Fu+eSurfZ9Ale4FPik5qZgNuJ2x2sSPQ7+
	nTsyad/DzL0+2gDWhp5OpTT6HXwv0w+i27po8939h38nyU5Oi5Pz03bV++x7Qrc7
	3UEnVCkAvK+C11tjKwReLkK1GUT4X9bHC2O+WVb+YjqD2DRI/wbzC27J8ul9krpz
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9frgty3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 May 2026 12:43:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 647CaNcE015513;
	Thu, 7 May 2026 12:43:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dx59504sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 May 2026 12:43:02 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 647CgwGw037123;
	Thu, 7 May 2026 12:43:02 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dx59504rk-3;
	Thu, 07 May 2026 12:43:01 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org, axboe@kernel.dk
Cc: Pavel Begunkov <asml.silence@gmail.com>, Kai Aizen <kai@snailsploit.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 7.0.y,6.18.y 2/2] io_uring/zcrx: warn on freelist violations
Date: Thu,  7 May 2026 05:42:53 -0700
Message-ID: <20260507124253.97596-3-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2605070126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEyNyBTYWx0ZWRfX9/QkCqIYBYwS
 i/2oHNvqL3nAcCY3tpJlBv5Osa0YHJt4PXlC5/Dr3zMPtxOcpTqJPSG8BwVUk1srf7kx37/e16o
 P0hcdwRpxXbLKoYMfKigW16i1uq2pVFN9URvdExPfLcpKnRnsQW5fCwSJjxpPRJ8ZWX/hoo4N3r
 xEvHM8vFJNiZgFi6JifEhX+QFrPPDZlsHL1RFKeEcqJkVm+ahbFTlkUWyMQwh4Dc2AVNVJAjo4/
 7C/1lPhRqR7GwnelzJ5FW0jLv2Voirh40a79+/bXXuZ8CLm8ASA19+LCCZDKgLujxTZa/ct+Agi
 bFYRvfAuhY5qKCZ2Zx17k7ukdu3QRUEZemwglgfPCk7bzjBpPBBHe4KMLWb/gRctmsoeg2+RpY+
 aI+JUF10fMzqLSIvN1Nu29OpYg7NO+Y1d0134qHdW12iLFaKU4Irr+u3j3Tlrbtc8hIOeL1ITDE
 1A4HmAPPV89mPJM8Rsw==
X-Authority-Analysis: v=2.4 cv=TZ6mcxQh c=1 sm=1 tr=0 ts=69fc88d7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=e49DGzfHAAAA:8
 a=yPCof4ZbAAAA:8 a=CQDg6DqgZazW2Alr_aEA:9 a=FO4_E8m0qiDe52t0p3_H:22
 a=2i077y4031PAf9Xs7zZX:22
X-Proofpoint-ORIG-GUID: izG_DcEj2tHVnk-2d80TZGb8i2TbvTiN
X-Proofpoint-GUID: izG_DcEj2tHVnk-2d80TZGb8i2TbvTiN
X-Rspamd-Queue-Id: E01DE4E8597
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,snailsploit.com,oracle.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244567-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit 770594e78c3964cf23cf5287f849437cdde9b7d0 ]

The freelist is appropriately sized to always be able to take a free
niov, but let's be more defensive and check the invariant with a
warning. That should help to catch any double-free issues.

Suggested-by: Kai Aizen <kai@snailsploit.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://patch.msgid.link/2f3cea363b04649755e3b6bb9ab66485a95936d5.1776760901.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
(cherry picked from commit 770594e78c3964cf23cf5287f849437cdde9b7d0)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 io_uring/zcrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 517b8ddb2cc2..4eb08c832f0b 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -587,6 +587,8 @@ static void io_zcrx_return_niov_freelist(struct net_iov *niov)
 	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
 
 	guard(spinlock_bh)(&area->freelist_lock);
+	if (WARN_ON_ONCE(area->free_count >= area->nia.num_niovs))
+		return;
 	area->freelist[area->free_count++] = net_iov_idx(niov);
 }
 
-- 
2.50.1


