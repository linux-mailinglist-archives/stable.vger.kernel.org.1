Return-Path: <stable+bounces-204323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E7ECEB540
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 07:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55DD930169AA
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 06:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE01130FC31;
	Wed, 31 Dec 2025 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HTSGSnV3"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA88B221DB5;
	Wed, 31 Dec 2025 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767161799; cv=none; b=SHlE3H+HG0VBRMyNyE19+uNMz9WByH2mfucjLSXWPOcwPak0ThwHmMVzMs12PGBZakzJG/rHdA38iQKB5vPeLgWZOGY7aslkyOs3Lh11Wm+c9hQ5x/DcenzgIFoFpa8ZK8jCkmXcWcnfZY3BpFyGLvDvrqbDSPMP7Mc2j7O7ZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767161799; c=relaxed/simple;
	bh=mVtPOFCGMGNHE0TVNVloYDBmH5WN0nZnLCbGzaP5jQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLcjr0W9ZfAPSmP1qctJBZk5PoWawRg7CASw5D74r1RdkerNus4yaZ9A6jT/75aAPIlaXpMkc9y1d6zGT/Gpgi5ajNEH079OJUOxGSziY90tyfUxxpW43XnxCPQAHuBBPA8s/wsh/aIJkrW1hFC7SHcXKv0oqA8fXec+gLc02W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HTSGSnV3; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV1uasH1217347;
	Wed, 31 Dec 2025 06:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=O9L1i
	CamBEXkxI0wpVy158tFqdIiJVtz1+GqywUzvHo=; b=HTSGSnV31gNgL5n/5deQi
	HRhwIo4tyqkAGokwmJbkqBE2pT4rNjt9LDq9SWxTXA7o7CLIXBiFLeSV53F5jDmd
	8bndpIAzi31Ejf83J9+YZp8Yo4fCsF199X64/L8+6QNUM/y+pKYLim6dwZ69DMd7
	cEjk0pUhPmjpXmia2HpODPrKTusDHjuVs4MjZxkKv/AWQeZC/m3zp+qf+9Z+gLNb
	JPpSQgtCTSXGZkx97Kk+6gWrFSGrygyg74sNuHnZoJB+p4cYASm5fL9JNhtlhio1
	nDyjonVNhuy8BrWIqTJi+NOoQGXvK1Lx2X8UrqEUHM3XJVu/ikLy+V2OAP42tIAd
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba680kcu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Dec 2025 06:16:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BV5nYo8013716;
	Wed, 31 Dec 2025 06:16:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5w8c7s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Dec 2025 06:16:20 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BV6GE8a009609;
	Wed, 31 Dec 2025 06:16:19 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ba5w8c7mt-3;
	Wed, 31 Dec 2025 06:16:19 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: zohar@linux.ibm.com, akpm@linux-foundation.org
Cc: ardb@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        graf@amazon.com, guoweikang.kernel@gmail.com,
        harshit.m.mogalapalli@oracle.com, henry.willard@oracle.com,
        hpa@zytor.com, jbohac@suse.cz, joel.granados@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, noodles@fb.com,
        paul.x.webb@oracle.com, rppt@kernel.org, sohil.mehta@intel.com,
        sourabhjain@linux.ibm.com, stable@vger.kernel.org, tglx@linutronix.de,
        x86@kernel.org, yifei.l.liu@oracle.com
Subject: [PATCH v3 2/3] of/kexec: refactor ima_get_kexec_buffer() to use ima_validate_range()
Date: Tue, 30 Dec 2025 22:16:08 -0800
Message-ID: <20251231061609.907170-3-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251231061609.907170-1-harshit.m.mogalapalli@oracle.com>
References: <20251231061609.907170-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512310052
X-Proofpoint-ORIG-GUID: EyYdMcQB00pS9vAZuoFkmQXsOm74SBFQ
X-Proofpoint-GUID: EyYdMcQB00pS9vAZuoFkmQXsOm74SBFQ
X-Authority-Analysis: v=2.4 cv=HPLO14tv c=1 sm=1 tr=0 ts=6954bfb5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=yPCof4ZbAAAA:8 a=pjPCvf8BpcJgz2SLxb0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDA1MiBTYWx0ZWRfX1j3WZIKLBWAg
 oMcR11qFZgBdxeitogJoG4Gi5vIKY/kQBKjl3pCpc/Mhy5xHPoL1++wQwlAL0AhYWMBF32iFUH/
 A+IDviXHxAjlJzffAjGJXdrxUPR1Men9kwa2HyvK0Iq9TF0sUvxomyit+RpwLlupWeMih5rCAwE
 hEezZRGq7JoRibH8Q7jqB7emx/lmXfwJlYFqiA0v4F0idLyqDRniCT1vQpFRaVihWdUFm4E56/T
 8RzYmsT4pknJWpQproiG/DQPvZBUR1ksymSQOoXBohToudInG+ianjMzUNqDePlIGsWtuTTb0j1
 W3p2QWxpNZ3p22q3v2+lSrZO6Y8c0//Y7MTKbh1qSMDfQ/5cxRKGyevzlce7OH3R+qZxC6H5qa0
 y4zE/GVHknJor5O8+jUNoe6eYsgFcMMtfyO2jmW+BNQ5D4OfF7WfDvydGViW5a/3dXEGfsRdORN
 uBVHF2b4FkBkzc9sYEg==

Refactor the OF/DT ima_get_kexec_buffer() to use a generic helper to
validate the address range. No functional change intended.

Cc: stable@vger.kernel.org
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
V2-> V3: Add RB from Mimi Zohar.
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


