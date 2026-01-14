Return-Path: <stable+bounces-208384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA79ED2167F
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 22:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E498A30EB66D
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 21:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32E436AB73;
	Wed, 14 Jan 2026 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dA05Yg8Y"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D22A3793C1;
	Wed, 14 Jan 2026 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426718; cv=none; b=rXhiI8oPlSy/8lVbMGLHLpBivkf5+N+AInZnuqrmSDqlnrfJdBEEqoedVaN07wsdFHEeuzQsjBgRak8LE6fPLUne9vY5d80LkRmqm4NHQmp1AJDavAQqzqJwESiN02QHQAdoUUaJ3lEL6qKaIUFQw8sdx+ezIHfRmZ80YyQye8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426718; c=relaxed/simple;
	bh=7et2XV9ghG8rH222c4uPVF0n9Zxwp15qLuRnjQM1YT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ra0z2UHV5KT6rYe+lp0AOYHj5nf/xIE68O4tPEvoMv279PFG/MbIQagRl4XgPesIuOgEHU2aGH5Vus5Xn8eNDR6MDdccicrND/3zcgS0MQ/g6HR2956OO7YimtgV5YS6M2Ick0x6OJ4sf+7btDUGU2rJW12afACQP1Fnv1b/ziQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dA05Yg8Y; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EHxToq1362564;
	Wed, 14 Jan 2026 21:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=/s9Ai
	ghKRjqX8gVI7ACM0hWfzlx9xJSRT2Y4is2Sfcw=; b=dA05Yg8Y5AxwFM4CxQ8A4
	KgwQKSozt30Ms3S+/jMKBXAUkge8FbM1KxuFUDMpU0RF97h32hPyB28xPHK1FKzz
	z5fWWsIS8plV6UjJ+J1OOMCAg4744VDQYFvFqQg2J7idISMr1nIMvAbZesjPoomg
	JEVDSwHI8TGe547Il1olhklYt6F2DTehQjoN5DIhcRkun6gIwV5YzoC0Lnj65ZXf
	7QvzzA0po4TL8glkjLK9x0/xBkwoWO+epqM1S2GJv7ZfI8hYm5ZOungUze0MLNbK
	1fCCZ7P/deyvPSwNAMCJaC3BQ3A8Ngd1AV394inApFMfdlVMXgSamnCxVgkaVm9Q
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5vp19m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 21:37:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60ELQwus008258;
	Wed, 14 Jan 2026 21:37:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7ab113-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 21:37:33 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60ELbSxN024482;
	Wed, 14 Jan 2026 21:37:32 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bkd7ab0y3-2;
	Wed, 14 Jan 2026 21:37:32 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, stable@vger.kernel.org, muchun.song@linux.dev,
        osalvador@suse.de, david@kernel.org, linmiaohe@huawei.com,
        jiaqiyan@google.com, william.roche@oracle.com, rientjes@google.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@Oracle.com, rppt@kernel.org, surenb@google.com,
        mhocko@suse.com, willy@infradead.org, clm@meta.com
Subject: [PATCH v5 2/2] mm/memory-failure: teach kill_accessing_process to accept hugetlb tail page pfn
Date: Wed, 14 Jan 2026 14:37:20 -0700
Message-ID: <20260114213721.2295844-2-jane.chu@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260114213721.2295844-1-jane.chu@oracle.com>
References: <20260114213721.2295844-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_06,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601140177
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE3NyBTYWx0ZWRfX1FYBaLflYAyE
 6Pp+i69tqY+fI64Ndv00DSkezV6n8vkIqEQyor7BdGTrPU8HHiXjGK9iBXuX6ZFDFvOC4M6ItSb
 Q0QtTutM/+gLckIOJrqIPooQR/2zO6r6Bn1dFD9jIu2DhEBJvoMDhWpQobuieP7cpmICOiZk39t
 ZlwhnRbVoa0iQJNKpy4NoWdXeslCfBAeS2f9nPNBa2NoCvwIolFIMhwriu1TDE5RFcLkZMGfpQp
 JLPXRPavEauBem6Afb2+qX8UGXvlGCWJDSN+uQT2pflU+Z+5mifLSvLVal2PpaULqGiLTFvmXR7
 h4LvW4ecKvFdou7ZdjcpA9xYpH1ZT0Nqtb9OYQpWqGpCmpFuPm0TDkwtxWZG7KTJkkS8BLoIx+Y
 Zqqo9BPePK10q8vbzscM/yXy0G5eQ8IojucIMxJc20R+HqyRKEBlLMofObddV7TE1kJprn7WasZ
 EpPx+MZUxOOvXOYntzw==
X-Proofpoint-GUID: 7wvxSWdPElon3xwNnM82G_zapD9kBtwj
X-Authority-Analysis: v=2.4 cv=aZtsXBot c=1 sm=1 tr=0 ts=69680c9e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=DOqXzVRdv2y7BJT1fF0A:9
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: 7wvxSWdPElon3xwNnM82G_zapD9kBtwj

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
v5, v4: No change.
v2 -> v3:
  incorporated suggestions from Miaohe and Matthew.
v1 -> v2:
  pickup R-B, add stable to cc list.
---
 mm/memory-failure.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 2563718c34c6..f6b806499caa 100644
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
 
@@ -2055,10 +2059,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	case MF_HUGETLB_FOLIO_PRE_POISONED:
 	case MF_HUGETLB_PAGE_PRE_POISONED:
 		rv = -EHWPOISON;
-		if (flags & MF_ACTION_REQUIRED) {
-			folio = page_folio(p);
-			rv = kill_accessing_process(current, folio_pfn(folio), flags);
-		}
+		if (flags & MF_ACTION_REQUIRED)
+			rv = kill_accessing_process(current, pfn, flags);
 		if (res == MF_HUGETLB_PAGE_PRE_POISONED)
 			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		else
-- 
2.43.5


