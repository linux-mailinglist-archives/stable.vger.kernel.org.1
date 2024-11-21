Return-Path: <stable+bounces-94503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFAF9D4892
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 09:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAB41F2271B
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 08:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6400C1C9B8C;
	Thu, 21 Nov 2024 08:12:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1B1CACDC
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176730; cv=none; b=bI3n7nrIpERLBI6jD1F17ENgsoWOt+Ds+XoTx6dhnIIigJ8oWSKoY21yuM8koMArDIGHhCnuCFusqasKV9AF58CZY/SNJ3yDHC60V1seAnsAUuEhdGEGK2GzOE1tLPk3cKSS1t6/7onufZzT8oaG0WrjI9Frj/N6PEQ9UY9bmTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176730; c=relaxed/simple;
	bh=4KbSoZBMONX9yuA0w9jTpvBgncA61f6KYrqlZq8krfE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ChSdXVwKTUvRDfNFreOJwZp+MY/9H6q+MD5PWe64gDVQenPXi+idfdY45pRjQ/MFiV6j3R9VX0sMbC2suAlGViTGUKApFHAPU+HfJwz0buRsvogoBxgDYWNjezRhbUGoIiAtIDeHt4GryIQip0tGv8/BbwjGelCc2aeS6SK2BoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL5i1LV018516;
	Thu, 21 Nov 2024 08:12:05 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xgm0nbv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Nov 2024 08:12:05 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 21 Nov 2024 00:12:03 -0800
Received: from pek-blan-cn-d1.wrs.com (128.224.34.185) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 21 Nov 2024 00:12:02 -0800
From: Bin Lan <bin.lan.cn@windriver.com>
To: <stable@vger.kernel.org>
CC: <dengler@linux.ibm.com>, <freude@linux.ibm.com>, <ifranzki@linux.ibm.com>
Subject: [PATCH 6.6] s390/pkey: Wipe copies of clear-key structures on failure
Date: Thu, 21 Nov 2024 16:12:22 +0800
Message-ID: <20241121081222.3792207-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QkPUbrPgoqoPs682Ww8yS232UeEJ2DZr
X-Proofpoint-GUID: QkPUbrPgoqoPs682Ww8yS232UeEJ2DZr
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673eeb55 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=VlfZXiiP6vEA:10 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8 a=_TdOzBteYNlyqZi9DD4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_06,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411210063

From: Holger Dengler <dengler@linux.ibm.com>

[ Upstream commit d65d76a44ffe74c73298ada25b0f578680576073 ]

Wipe all sensitive data from stack for all IOCTLs, which convert a
clear-key into a protected- or secure-key.

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
[ Resolve minor conflicts to fix CVE-2024-42156 ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/s390/crypto/pkey_api.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index d2ffdf2491da..70fcb5c40cfe 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1366,9 +1366,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		rc = cca_clr2seckey(kcs.cardnr, kcs.domain, kcs.keytype,
 				    kcs.clrkey.clrkey, kcs.seckey.seckey);
 		DEBUG_DBG("%s cca_clr2seckey()=%d\n", __func__, rc);
-		if (rc)
-			break;
-		if (copy_to_user(ucs, &kcs, sizeof(kcs)))
+		if (!rc && copy_to_user(ucs, &kcs, sizeof(kcs)))
 			rc = -EFAULT;
 		memzero_explicit(&kcs, sizeof(kcs));
 		break;
@@ -1401,9 +1399,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 				      kcp.protkey.protkey,
 				      &kcp.protkey.len, &kcp.protkey.type);
 		DEBUG_DBG("%s pkey_clr2protkey()=%d\n", __func__, rc);
-		if (rc)
-			break;
-		if (copy_to_user(ucp, &kcp, sizeof(kcp)))
+		if (!rc && copy_to_user(ucp, &kcp, sizeof(kcp)))
 			rc = -EFAULT;
 		memzero_explicit(&kcp, sizeof(kcp));
 		break;
@@ -1555,11 +1551,14 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		if (copy_from_user(&kcs, ucs, sizeof(kcs)))
 			return -EFAULT;
 		apqns = _copy_apqns_from_user(kcs.apqns, kcs.apqn_entries);
-		if (IS_ERR(apqns))
+		if (IS_ERR(apqns)) {
+			memzero_explicit(&kcs, sizeof(kcs));
 			return PTR_ERR(apqns);
+		}
 		kkey = kzalloc(klen, GFP_KERNEL);
 		if (!kkey) {
 			kfree(apqns);
+			memzero_explicit(&kcs, sizeof(kcs));
 			return -ENOMEM;
 		}
 		rc = pkey_clr2seckey2(apqns, kcs.apqn_entries,
@@ -1569,15 +1568,18 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		kfree(apqns);
 		if (rc) {
 			kfree(kkey);
+			memzero_explicit(&kcs, sizeof(kcs));
 			break;
 		}
 		if (kcs.key) {
 			if (kcs.keylen < klen) {
 				kfree(kkey);
+				memzero_explicit(&kcs, sizeof(kcs));
 				return -EINVAL;
 			}
 			if (copy_to_user(kcs.key, kkey, klen)) {
 				kfree(kkey);
+				memzero_explicit(&kcs, sizeof(kcs));
 				return -EFAULT;
 			}
 		}
-- 
2.43.0


