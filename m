Return-Path: <stable+bounces-208246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A323D17376
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 09:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0775C304C903
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 08:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519783793A8;
	Tue, 13 Jan 2026 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y6Xn65lq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7801E35C1BA;
	Tue, 13 Jan 2026 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768291727; cv=none; b=n2Ary7y/NjU8txrKY82rlSox8hzziWLoeFtBvj6Zp9P8PBq14X6oj08Nh4x5ejjblqsogJ2e/CmjvrCV3pg+DqAWu/qkWzwT1hgNQ03NmLDj5VTnvNOALbqH1Y1l81qEZnpAhgt9+6oI2GRn3gPsGNSFjneOT1bGrV8r3hQS49E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768291727; c=relaxed/simple;
	bh=/EGTVnbeBxc/LBiBSNT7OnA8DIrYdKBg8efXMUJaG4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8zuvia/UHYMOI1h+Dbt+OjXXzZfHNLM6Rxi6obuM5sB1kydCdnfa7NAm29c+L3MeNAPBvBp/MPR1TeMhjaPmcWh0GmJd08toqutmsZ7ahK10FLQ4dAQbGBqsmx/kTABN0TSojt+V03D44o1ZWelHgsBEBUd8FXL1TD+NOIHovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y6Xn65lq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1gc9m2735700;
	Tue, 13 Jan 2026 08:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=texge
	5LwbT7wQEHYVdtPM4RdyChOR+/v4clnE+Ul5cw=; b=Y6Xn65lq13OjtF//AHdIt
	jeEpMuuU7f4iCROaMst2ctjTex2rWr9nyvxNEFcI7Lx0jKFLER1VTNaG6/PpHk9L
	0RvjwuG6Q6ppt6nLmVV+PKaM3uYCrjp/EQQh6qZH1Vxsd2UzXixVaavY7rL1Q43W
	QtLwTsv6ji+UZdTBDgwdbnzksEBsDhaH1JlBsN8jvkL5bHMoQrOyGsNX7KQigoZr
	LYGcRuMFcD22v8XbWsgOVAdkqYh+uI6U7ZXbZQkwLwervJVbFFH0W0+ggP+XuGtJ
	3mc4eoNK6GvgdDJDjo16cB2uKUl/9MB5md2KxMRuYMw0mYt4SR43z0JMLpSRkU1k
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrr8ayca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 08:08:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60D696cG035299;
	Tue, 13 Jan 2026 08:08:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd78ewyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 08:08:16 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60D88Ahi038767;
	Tue, 13 Jan 2026 08:08:15 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bkd78ewra-2;
	Tue, 13 Jan 2026 08:08:15 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, stable@vger.kernel.org, muchun.song@linux.dev,
        osalvador@suse.de, david@kernel.org, linmiaohe@huawei.com,
        jiaqiyan@google.com, william.roche@oracle.com, rientjes@google.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@Oracle.com, rppt@kernel.org, surenb@google.com,
        mhocko@suse.com, willy@infradead.org
Subject: [PATCH v4 2/2] mm/memory-failure: teach kill_accessing_process to accept hugetlb tail page pfn
Date: Tue, 13 Jan 2026 01:07:51 -0700
Message-ID: <20260113080751.2173497-2-jane.chu@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260113080751.2173497-1-jane.chu@oracle.com>
References: <20260113080751.2173497-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601130067
X-Proofpoint-ORIG-GUID: Xqyk_lGVSiW9PUEfVr1-L7_4BEe1nbSX
X-Proofpoint-GUID: Xqyk_lGVSiW9PUEfVr1-L7_4BEe1nbSX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA2NyBTYWx0ZWRfX/uVFYipRxRcq
 tbQeeZm9Dufx0wHeEy+sBKwvjWQYpDyj1REYaWQguXLvP/J07RHX0VEBjTIyt4pa/FITGHODl8m
 PK0GFG5y1/bLF9HcwD0BRWl83ttjmNKn25dHMl+LTnZkxLW0URXkQf+HdtuvQ8Sk/6QLhTudnYd
 vZSUvXcEWgKbFfnS02yymB5YJXPzw5aAR4P4NuA1SJ2+jN2TICd/hbt0NRPk6lt8SKPQm4BKMOJ
 snrzl0k4Ncbqyn6Ld+FMhKLS+8kQ2MxlLKBdetm5cmyXY9Equr8rnSt3hWOeTBHCXWrBrMSixHL
 VdW3yO6TUDDbbFSKcSyakmpRzEUC9Ri+i1idpWz1QcHgN0L5eUP1qVH9yDefT/Q1ViWWhWR2WS2
 ZMSJ1fqhU3YBynh14OfqvXlRMQQhN9CdYmQ21XS89oCKt7upMXMp1aC9JPFexAgdo+z6KZxb6QZ
 AHzosOoXyHaZ6Q6lZEw==
X-Authority-Analysis: v=2.4 cv=QIllhwLL c=1 sm=1 tr=0 ts=6965fd71 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=DOqXzVRdv2y7BJT1fF0A:9
 a=1CNFftbPRP8L7MoqJWF3:22

When a hugetlb folio is being poisoned again, try_memory_failure_hugetlb()
passed head pfn to kill_accessing_process(), that is not right.
The precise pfn of the poisoned page should be used in order to
determine the precise vaddr as the SIGBUS payload.

This issue has already been taken care of in the normal path, that is,
hwpoison_user_mappings(), see [1][2].  Further more, for [3] to work
correctly in the hugetlb repoisoning case, it's essential to inform
VM the precise poisoned page, not the head page.

[1] https://lkml.kernel.org/r/20231218135837.3310403-1-willy@infradead.org
[2] https://lkml.kernel.org/r/20250224211445.2663312-1-jane.chu@oracle.com
[3] https://lore.kernel.org/lkml/20251116013223.1557158-1-jiaqiyan@google.com/

Cc: <stable@vger.kernel.org>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
v4 -> v3: No change.
v2 -> v3:
  incorporated suggestions from Miaohe and Matthew.
v1 -> v2:
  pickup R-B, add stable to cc list.
---
 mm/memory-failure.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b3e27451d618..885dc1d4f212 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -692,6 +692,8 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
 				unsigned long poisoned_pfn, struct to_kill *tk)
 {
 	unsigned long pfn = 0;
+	unsigned long hwpoison_vaddr;
+	unsigned long mask;
 
 	if (pte_present(pte)) {
 		pfn = pte_pfn(pte);
@@ -702,10 +704,12 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
 			pfn = softleaf_to_pfn(entry);
 	}
 
-	if (!pfn || pfn != poisoned_pfn)
+	mask = ~((1UL << (shift - PAGE_SHIFT)) - 1);
+	if (!pfn || ((pfn & mask) != (poisoned_pfn & mask)))
 		return 0;
 
-	set_to_kill(tk, addr, shift);
+	hwpoison_vaddr = addr + ((poisoned_pfn - pfn) << PAGE_SHIFT);
+	set_to_kill(tk, hwpoison_vaddr, shift);
 	return 1;
 }
 
@@ -2049,10 +2053,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		return action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
 	case MF_HUGETLB_FOLIO_PRE_POISONED:
 	case MF_HUGETLB_PAGE_PRE_POISON:
-		if (flags & MF_ACTION_REQUIRED) {
-			folio = page_folio(p);
-			res = kill_accessing_process(current, folio_pfn(folio), flags);
-		}
+		if (flags & MF_ACTION_REQUIRED)
+			res = kill_accessing_process(current, pfn, flags);
 		if (res == MF_HUGETLB_FOLIO_PRE_POISONED)
 			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		else
-- 
2.43.5


