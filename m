Return-Path: <stable+bounces-65296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F407F945D50
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 13:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AB14B22770
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 11:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E452D1DF664;
	Fri,  2 Aug 2024 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VqMzCUU3"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37F21E286C
	for <stable@vger.kernel.org>; Fri,  2 Aug 2024 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722598787; cv=none; b=W5U3LY8FX2v9efQVavvwyAtrNue35iLnyrweIc+i8L4UesW1NeQGZ01JRXwOljFk5cbI6RNMhbexJAIUSlPzU2t4gn+a11TIp7of69AYZrq84jkytN8uBrmP0J37PFFmOKSRRl5e134mtD9ATNr3zcS5CqyUNiedmpAdncWIQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722598787; c=relaxed/simple;
	bh=YEeA9yZ+FdbnrB9Fczr6g/QmyM1yRTbrJoSd9CO0em0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbMCsGcSFoBUq5I7KpA1/jH7RHJTbvqWvIFpP0QuhDw7zgnXwcPe7NylB1WjywkYBeYzLZBoAo8v77paylUlGlXmwPVijMtszr8CXnTRnuqpnm9/MrXJNjXx+Wy8lwID+lmCfFzr67hWP+Wq1PdC7fMsSnGi05P3xFFhocP7f34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VqMzCUU3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472AMdmE003567;
	Fri, 2 Aug 2024 11:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=R
	za51S0WzjcNjAtddEA/TSQ2QrosHjQmMNxfBtASWCQ=; b=VqMzCUU3ZXGMTj6jh
	BTjBobwaJdKDNCN0T0cznFjhSJ9VUv2a6WSZ1hBaGgfFVGkU/+q0zKRAcqaOTU9H
	e4f/pxU77hm3Omhd+EIj6vZILpQXc/P9GGBPjzOeWjIKlx1/Q/pfkzT4GnQip/4Y
	iw6Ei5UtH8vHiXTKUTBphsW9dYPJGNsr56Ztkr1Bhgl5ltn5Yy2eDralFSl8CcNY
	mQbNDI9zJwwmFhIMZuqxne1o2mztOciaG2dHuWpr6vgDkdqmIlPyBiHu83g6RUpV
	9gtiJYCUva97IfHFFT5vW8xZWlVOhH7loUfrVnxm3axpLp4Ge9Vazz+16qD//IxT
	GrFtA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40rjds90at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 11:39:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 472AnSMC003827;
	Fri, 2 Aug 2024 11:39:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40p4c43cca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 11:39:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 472BdZoD023127;
	Fri, 2 Aug 2024 11:39:35 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40p4c43cbs-1;
	Fri, 02 Aug 2024 11:39:35 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: kuba@kernel.org, stable@vger.kernel.org
Cc: davem@davemloft.net, horms@kernel.org, lee@kernel.org, sashal@kernel.org,
        sd@queasysnail.net, sec@valis.email, liam.merwick@oracle.com,
        vegard.nossum@oracle.com, dan.carpenter@linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y] tls: fix race between tx work scheduling and socket close
Date: Fri,  2 Aug 2024 04:39:31 -0700
Message-ID: <20240802113931.2501476-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240307091420.1c09dd0e@kernel.org>
References: <20240307091420.1c09dd0e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_08,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408020079
X-Proofpoint-ORIG-GUID: PS-hdYh43O2K-3olCTp5ecEKVyRZx-CR
X-Proofpoint-GUID: PS-hdYh43O2K-3olCTp5ecEKVyRZx-CR

From: Jakub Kicinski <kuba@kernel.org>

commit e01e3934a1b2d122919f73bc6ddbe1cdafc4bbdb upstream.

Similarly to previous commit, the submitting thread (recvmsg/sendmsg)
may exit as soon as the async crypto handler calls complete().
Reorder scheduling the work before calling complete().
This seems more logical in the first place, as it's
the inverse order of what the submitting thread will do.

Reported-by: valis <sec@valis.email>
Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
[Lee: Fixed merge-conflict in Stable branches linux-6.1.y and older]
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Harshit: bp to 5.15.y, minor conflict resolutin due to missing commit:
8ae187386420 ("tls: Only use data field in crypto completion function")
in 5.15.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is a fix for CVE-2024-26585, minor conflict resolution involved
Ran the tls self tests: 

ok 183 tls.13_chacha.shutdown_reuse
# PASSED: 183 / 183 tests passed.
# Totals: pass:183 fail:0 xfail:0 xpass:0 skip:0 error:0

 net/tls/tls_sw.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 90f6cbe5cd5d..c17c3a14b9c1 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -468,7 +468,6 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
 	struct scatterlist *sge;
 	struct sk_msg *msg_en;
 	struct tls_rec *rec;
-	bool ready = false;
 
 	if (err == -EINPROGRESS) /* see the comment in tls_decrypt_done() */
 		return;
@@ -502,19 +501,16 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
 		/* If received record is at head of tx_list, schedule tx */
 		first_rec = list_first_entry(&ctx->tx_list,
 					     struct tls_rec, list);
-		if (rec == first_rec)
-			ready = true;
+		if (rec == first_rec) {
+			/* Schedule the transmission */
+			if (!test_and_set_bit(BIT_TX_SCHEDULED,
+					      &ctx->tx_bitmask))
+				schedule_delayed_work(&ctx->tx_work.work, 1);
+		}
 	}
 
 	if (atomic_dec_and_test(&ctx->encrypt_pending))
 		complete(&ctx->async_wait.completion);
-
-	if (!ready)
-		return;
-
-	/* Schedule the transmission */
-	if (!test_and_set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask))
-		schedule_delayed_work(&ctx->tx_work.work, 1);
 }
 
 static int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx)
-- 
2.45.2


