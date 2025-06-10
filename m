Return-Path: <stable+bounces-152359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53028AD471B
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 01:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3250E189C8BC
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 23:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7557326E705;
	Tue, 10 Jun 2025 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sZGeAK8q"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA517E
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599736; cv=none; b=kTClxVEk/JloJO3R+x727Ulya3N1UlVLsiRFi9jGf6QXm5IBb9CujfIaE5cA/PQUJOP7JL8CGshR3KS5xkroBhitLTY8+zelgH5J7PiuEQF3ApNNuvlmOdoFf2+J8lCqgd/xneSzSML822aDtcpy2wdatFE3LY4RolMNNkHPPzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599736; c=relaxed/simple;
	bh=HghRxOZqHT/qQ12pZeCfvtnDrqSSdbXz96fFLc7FM9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WiRgeZjghK1EYJCQRXaH4uzrpooO6UYmWdsDgEW0lV3LLyigPJL9O3Y8aNxRZ1vy79ZCayJsyg05cqhWRPxO9tmsYlCQ1403TawZ14eZ1nn9HZrJVEnFUUhQdemxCNvifYIFpmlKkEiS5BMO3Kcz+mFmy+m0gAd97Us28FL/gZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sZGeAK8q; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ALtlKO017476
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 23:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=iIQRgFWd8NeKn9BbSQcmVSgcbA+uj
	7DFg7nwJMsnX3U=; b=sZGeAK8qgiez9NAaNBU0O91O861/leBtcJtBMpImNb8VJ
	y6l+a3rvRd/9wX1pQF+FPL6Qy0o+5O8XWwHYsAbAsBFTQsUsD2H/ig0R4bv5sRln
	U3ot0g4ALjIuSVeIAup9mi/vPRoFOjShfgeFtTT6wUUXiaSFVkdgLefxmSXQ5lSo
	EpH25mtGuh47xkqC7pt5G5IyUxL/X+wm0W5J3sfQla2qDoHn7viESePM5ETdfwjB
	q7j2hCVeKACneTIQVQ7PdqGEEe8y8lwJFt+kzzjMLEwGm5QIc8/mg4rCsuyX8y0H
	IFZhmO84QYFaJ0jwjeJkFOt1Y+fwCdoov3+9u9WZw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dyww8wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 23:55:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ANDfdL007379
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 23:55:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv95vpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 23:55:33 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55ANtWaI035125
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 23:55:32 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 474bv95vp7-1;
	Tue, 10 Jun 2025 23:55:32 +0000
From: Larry Bassel <larry.bassel@oracle.com>
To: stable@vger.kernel.org
Cc: chuck.lever@oracle.com
Subject: [PATCH 5.4.y] NFSD: Fix NFSv3 SETATTR/CREATE's handling of large file sizes
Date: Tue, 10 Jun 2025 16:55:04 -0700
Message-ID: <20250610235504.3021366-1-larry.bassel@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_11,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=851 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506100198
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=6848c5f5 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=Ipdae8FxCv_xMkJhFWwA:9
X-Proofpoint-ORIG-GUID: TZ5MRFweE2uaTRdHVLzJqeFmbGRrpeup
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE5OCBTYWx0ZWRfX6r+BiLUGBaa3 n5QA+SyBAbNnIhpxR63dvWSLzXTPVfqc48iRQGVKz4YnN72FzgNIN30Z6ShGXAKaa9APkDo/MQr 2NgK86FhMiA4G5JplReNPcxvKlVtkDNP6cTl3JvY2wUkWQECg6NyxztkOVZvaij/c5WOZpYqFvd
 wisBQFt8YqrMFSoGQq0FI2i6GxsSszvsl7GF/5xaKPRgx2f1ZxsnlhkE/4OYRsW+WAbfmqUjmOF 2Pn9iyjMevwSWVeMV8udlCyy73nOl2TIpxehm6yme2/e32wCOwKS5TpZAwpbId/dRbCIP3CpYZK 31kK29zNmr2wckt9rJjCT70/0kEhkqnGwh/pSmFuEa9scGctinJGRIYbEBVIZAHzjgpGM+0oSSr
 eaAesv0c9hSelfvbSumA+ZpnabHXKyIj7+2uP33kxOxWN/HkAXUUiLn6/09KPvh1hFkSj5xx
X-Proofpoint-GUID: TZ5MRFweE2uaTRdHVLzJqeFmbGRrpeup

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit a648fdeb7c0e17177a2280344d015dba3fbe3314 ]

iattr::ia_size is a loff_t, so these NFSv3 procedures must be
careful to deal with incoming client size values that are larger
than s64_max without corrupting the value.

Silently capping the value results in storing a different value
than the client passed in which is unexpected behavior, so remove
the min_t() check in decode_sattr3().

Note that RFC 1813 permits only the WRITE procedure to return
NFS3ERR_FBIG. We believe that NFSv3 reference implementations
also return NFS3ERR_FBIG when ia_size is too large.

Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
(cherry picked from commit a648fdeb7c0e17177a2280344d015dba3fbe3314)
[Larry: backport to 5.4.y. Minor conflict resolved due to missing commit 9cde9360d18d
NFSD: Update the SETATTR3args decoder to use struct xdr_stream]
Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
---
 fs/nfsd/nfs3xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 03e8c45a52f3..25b6b4db0af2 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -122,7 +122,7 @@ decode_sattr3(__be32 *p, struct iattr *iap, struct user_namespace *userns)
 
 		iap->ia_valid |= ATTR_SIZE;
 		p = xdr_decode_hyper(p, &newsize);
-		iap->ia_size = min_t(u64, newsize, NFS_OFFSET_MAX);
+		iap->ia_size = newsize;
 	}
 	if ((tmp = ntohl(*p++)) == 1) {	/* set to server time */
 		iap->ia_valid |= ATTR_ATIME;
-- 
2.46.0


