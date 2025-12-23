Return-Path: <stable+bounces-203246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5AFCD7B4A
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 02:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22EAE307C41E
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 01:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D2D2765ED;
	Tue, 23 Dec 2025 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bSmd0JZ7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B62737FC;
	Tue, 23 Dec 2025 01:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452920; cv=none; b=qZj8SpgFp5HEXEn18cFFDz4brc8KGNofJuxA9oC8G0PGygasjckrM1IrwEWmWMGY99bi6JwMWMPh4UFvGTizb35PJnJ6p/eDpy8wButXWSY3Lf2twOBd4FM/voDhVCQhrOMlYoVk6C5oj1nO0MDw4ivdHUosscdPLAu00EEyH3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452920; c=relaxed/simple;
	bh=7ujObCNC4gD/KMN7DjExhLtnUNjWr8GP7Mj8AmGN5Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5AKrrpjiWoKZh5ryXm18mUQ7EVyhPtAv2yS4anT/7qG6/Qy1cKL+bwY5H6i2Qt9f27q7w7F7A5lZUioD6nglL6xerlzcRd8RJM/on6PYw7UbrqtFkkSJJd/DmbdvbIwbS+ia9+EhNWpKKfHI5n1IST+aQ2EmVEjfIqn6F7FV4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bSmd0JZ7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN1A1u83530557;
	Tue, 23 Dec 2025 01:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=g8vI6
	UeUIC5rlql2XyjZDS+hvGt7ge2waCZe4vBSUiE=; b=bSmd0JZ71DQdSCrWKMh3s
	+HeHah9kkrHv9OlJnWd0eXzeGK7eHzcwynIM6g3j7AHGNrBN3GrA0h+R6dKi3RPn
	14xI7QmQDxp69bpoah4vWLRyBQnfeudpQfsROjHvT/PcnSSLhswqD8O/qebyN1GH
	Rvamc+mkH5MjvqS8Hk36Q07q7i7Ycs1vSFrotgeIurYB6Yc+RVdtui6wUOV6WCnm
	2hcf0/cZjrpLmnEivJI9CVS5vLklB6giqSrc7ft77iGZ6mDv67psAEIyqu0aBHib
	8ucBOYoP9V++zuFyxr50At1F3PVO40broEJqS+ap9+FQMHEE68Vkgy4NWfz3aOzK
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b7h5p007m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 01:21:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMM6cmQ002549;
	Tue, 23 Dec 2025 01:21:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j87x0fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 01:21:27 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BN1LNiE016978;
	Tue, 23 Dec 2025 01:21:26 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b5j87x0df-2;
	Tue, 23 Dec 2025 01:21:26 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, stable@vger.kernel.org, muchun.song@linux.dev,
        osalvador@suse.de, david@kernel.org, linmiaohe@huawei.com,
        jiaqiyan@google.com, william.roche@oracle.com, rientjes@google.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@Oracle.com, rppt@kernel.org, surenb@google.com,
        mhocko@suse.com, willy@infradead.org
Subject: [PATCH v3 2/2] mm/memory-failure: teach kill_accessing_process to accept hugetlb tail page pfn
Date: Mon, 22 Dec 2025 18:21:12 -0700
Message-ID: <20251223012113.370674-2-jane.chu@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251223012113.370674-1-jane.chu@oracle.com>
References: <20251223012113.370674-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512230009
X-Proofpoint-ORIG-GUID: SNTz1od7Q6g2sZiLwfgm_J9kJ9Xg7Udy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDAwOSBTYWx0ZWRfX1g7XaczizzLi
 8NtApq7fTlAU8KspGhDJKWjfJ2BHFNNj3Br8fl9DNpBHZw5GEKXTrRsNy1pVQ/tIGMVYnCdU4qI
 BvN98hK5+HTTWhmtJ/NmgPypRFK81e1idkbW/2chZqdD9io5/xPqDJh7sm9uwfeqy1MHd4fjoYd
 9I5ROCxPenSkDLoUr7wHcHUZQNryWZbn+LhIuJKDF/Lx5fSpIgFmIx9wk+R46kDXhBOmVShg6y0
 9cYbD9NYU2KLijj4QCCstGkl6ZhwbuI3tcxojDAy1zJvdgqNUx0Osc/D7DoPqtA+Fvujiut/500
 YvCpNO2mOmLmS01y+ofXgJkxzNUa48ae02DmQmkaU7JSTGZIyGJfC+YV3C8K6YdImFwyNlutqDE
 g7heQh+rf0hwbk+CKp6SxnKqPjTy3XnpzVg71Er8BKHc/3oFNZl23c2e1z4akZqe6ts6F/j8zLU
 Ww6UgYTH0J8p47UsR/g==
X-Authority-Analysis: v=2.4 cv=S5/UAYsP c=1 sm=1 tr=0 ts=6949ee98 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=DOqXzVRdv2y7BJT1fF0A:9
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: SNTz1od7Q6g2sZiLwfgm_J9kJ9Xg7Udy

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
v2 -> v3:
  incorporated suggestions from Miaohe and Matthew.
v1 -> v2:
  pickup R-B, add stable to cc list.
---
 mm/memory-failure.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 8b47e8a1b12d..98612ac961b0 100644
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
 
@@ -2038,10 +2042,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		return 0;
 	case MF_HUGETLB_ALREADY_POISONED:
 	case MF_HUGETLB_ACC_EXISTING_POISON:
-		if (flags & MF_ACTION_REQUIRED) {
-			folio = page_folio(p);
-			res = kill_accessing_process(current, folio_pfn(folio), flags);
-		}
+		if (flags & MF_ACTION_REQUIRED)
+			res = kill_accessing_process(current, pfn, flags);
 		if (res == MF_HUGETLB_ALREADY_POISONED)
 			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		else
-- 
2.43.5


