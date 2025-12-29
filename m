Return-Path: <stable+bounces-203477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFACCE6399
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 09:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 994D630181AE
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 08:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE6324DFF9;
	Mon, 29 Dec 2025 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hk3c2xRx"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE58243951;
	Mon, 29 Dec 2025 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766996170; cv=none; b=rI/Vl1nfuXx5FmpUJE20PQV53W815mbhPf0s/S5obtp1cIraXV/RX5dwU8wCWJerokb7wPhar6L6xWfGy4/8Eb5UU4NnHprawqF1k5GsEFz6OlKDHBnkL0kH84n1G1z7fhptPwCruNRAogHRGezv25Tx2Of1e+D41DNOZgBAJBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766996170; c=relaxed/simple;
	bh=Wmx85wmq620EWgMBeQw8wBok92AaaxxkkIkdQr5RHPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KibQ4quSbneG3ZAoM0/RVs8ynvr8RBMPZOCXOuf9p8pf51PNmC0FkNg6xuxlgsNIq2Lkjqj6/druas0NLJoPfpUMjHPPqji5DkUg15skdLrrO5oS3ABM2OD4xiWEP0ptjeDf4WJHwbP3Tm83cNNxnvuGqg8tiyB3Y7rvfYkCliE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hk3c2xRx; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BT2j1Ex758065;
	Mon, 29 Dec 2025 08:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=yYT7w
	MenZMNN7NbypYzu5g9N+yk+N6R4Gx8aGrK6Ikw=; b=Hk3c2xRxEMqz1lV/bxegM
	DdBHvXy6Cp9R3pocIJH7rwDbpKvtCtAqy8H5u6AyhLHeEDCWC6yQjsaLnOh6xFDM
	i3qN28cSECE1fVTANjf1qg6V5UP+zgsrpdYPOTcDy/2WJRA5JFHfSMmYTmDGfBnx
	tTP6dFebwklCrjxmoth6ZMpSmib/m/o0ip2iLsInl9cMN8csGYMH/5OkKSemRACo
	DtNS7lNCFOQlPgW3RFoso7BmSMwUGGfoYx0lduGp3qT80t+MageKMyFT0x9+gcPc
	ebqka/7ifrBbZOYq8Ggtsz34hX05JcPRoGNaQFu/9PW2I+2uxDFK60K6IC1xmo4i
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba61w9c2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Dec 2025 08:15:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BT41mJm038909;
	Mon, 29 Dec 2025 08:15:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5w6xkfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Dec 2025 08:15:32 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BT8FRej007295;
	Mon, 29 Dec 2025 08:15:32 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ba5w6xkd1-3;
	Mon, 29 Dec 2025 08:15:31 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: zohar@linux.ibm.com
Cc: akpm@linux-foundation.org, ardb@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, graf@amazon.com,
        guoweikang.kernel@gmail.com, harshit.m.mogalapalli@oracle.com,
        henry.willard@oracle.com, hpa@zytor.com, jbohac@suse.cz,
        joel.granados@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, noodles@fb.com, paul.x.webb@oracle.com,
        rppt@kernel.org, sohil.mehta@intel.com, sourabhjain@linux.ibm.com,
        stable@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
        yifei.l.liu@oracle.com
Subject: [PATCH v2 2/3] of/kexec: refactor ima_get_kexec_buffer() to use ima_validate_range()
Date: Mon, 29 Dec 2025 00:15:22 -0800
Message-ID: <20251229081523.622515-3-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251229081523.622515-1-harshit.m.mogalapalli@oracle.com>
References: <20251229081523.622515-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_02,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512290075
X-Authority-Analysis: v=2.4 cv=LL1rgZW9 c=1 sm=1 tr=0 ts=695238a5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=pjPCvf8BpcJgz2SLxb0A:9
X-Proofpoint-ORIG-GUID: 9oJhsk-UKZ6qUfemTxpfzq54qdwFtfIC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA3NSBTYWx0ZWRfX8e/ie67fa651
 AKiYjhfk591sOmuqoOsLJ+b3PFylX+CTCuDWgQChOpy3+ngbJUPKdvKCFWUVhQAZeWP5iAq60EF
 CpdcwPxWnm7tV2mWVxTE2ekmDMnGbU8wNX3GbA28bXJvWu1XpSjEWZxtnzlr+mtUfIVfzkpNwjr
 ITije5w+KN8O0KoO8vnqlKNqCBJfaTf5cJ2/fdIorl1VW+PGWD+v1EcwtpJcNL6THZ0t3ES/8uO
 2oGjQf1PDuoHQ8TUgtpM6psfeET6rU+gem6uHIXEKZlxXui4LsvTOjDvvxvHquI7KtUHJYhyGG9
 Gw3sqIlM5mh2ma6ltp48yTUKnXU6mZlgyvHJ//G3zcyFNl8dA5FOkEclDZA7q4+iaumBkjeMgH8
 T+5wMSxV+yyli1raRr7KzxVaTMWTWxwC4n78HvBWc4Dq5gHBAPssadEJksWkuoqkvSIuUl8SizT
 idxheMzDP1cAvz7gttw==
X-Proofpoint-GUID: 9oJhsk-UKZ6qUfemTxpfzq54qdwFtfIC

Refactor the OF/DT ima_get_kexec_buffer() to use a generic helper to
validate the address range. No functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/of/kexec.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 1ee2d31816ae..c4cf3552c018 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -128,7 +128,6 @@ int __init ima_get_kexec_buffer(void **addr, size_t *size)
 {
 	int ret, len;
 	unsigned long tmp_addr;
-	unsigned long start_pfn, end_pfn;
 	size_t tmp_size;
 	const void *prop;
 
@@ -144,17 +143,9 @@ int __init ima_get_kexec_buffer(void **addr, size_t *size)
 	if (!tmp_size)
 		return -ENOENT;
 
-	/*
-	 * Calculate the PFNs for the buffer and ensure
-	 * they are with in addressable memory.
-	 */
-	start_pfn = PHYS_PFN(tmp_addr);
-	end_pfn = PHYS_PFN(tmp_addr + tmp_size - 1);
-	if (!page_is_ram(start_pfn) || !page_is_ram(end_pfn)) {
-		pr_warn("IMA buffer at 0x%lx, size = 0x%zx beyond memory\n",
-			tmp_addr, tmp_size);
-		return -EINVAL;
-	}
+	ret = ima_validate_range(tmp_addr, tmp_size);
+	if (ret)
+		return ret;
 
 	*addr = __va(tmp_addr);
 	*size = tmp_size;
-- 
2.50.1


