Return-Path: <stable+bounces-203112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D10CD1478
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 19:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18B2B30B11B3
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449FA34CFCF;
	Fri, 19 Dec 2025 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C5YomseO"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D534C121;
	Fri, 19 Dec 2025 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166967; cv=none; b=rT+cgU5nqb9cXQd1aFFkdNguN44x9qLUeJaCU3PuoVoLlJbwou4UAsTuhNztM2yc71/RmM98zRtsSjg2csAAdcyTodmJVpIDpNf2nPqmHCEIwur0fBmFeucvcyVy6XOVv1jP/K2p7cwbQNI/Kn3/OgrlOG3H9n3ZstU3735ZUJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166967; c=relaxed/simple;
	bh=GR1Rwdmws6f8QkL3KUPdolzzc53/OcIe9woYRWrgESY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4Ww+ksYsumCQahK4y5bCffV+0ZRkymLOmKos1Xlvcwt8SDBkp0/IA/ENCBhyHchiiccTXg5yrHlIckbpjklvmmIrjBUvOSmlhxQnjuSld/S9aOkm4P702rZdnC4TZI3Slm3knfOG9bQ3Q51Xv0NbMHBoX5QYKCBsrwYGN9sBoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C5YomseO; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJGaEGc2980959;
	Fri, 19 Dec 2025 17:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=sNe/0MAXAOC1VNXdnuf7J8X0YhBVV
	BH20168b+oieb8=; b=C5YomseOba3BQsI1NdbPM6SVMDzclhnRb/CGjwqf0gjzn
	eGS+kgNYoo0JQwopoipUM1641QraMXjNy/gdqbYOnTntqHs0z1qQzEL9V894mXbb
	yXrdPvl9fG8Tc2gYhs9PBbNGfTkW3eHyQCmNmtXHucj4KwOLHt1NoqTDtDoprjWV
	iy1Mg9XkHshXAqEhBWnSzg3Xjs3DA5MzD9f6wE01kZMcHYO73nn/u1E0nPKblC3j
	dH4Q+MVvku5yDpCJie9Hhfdrg7DVSvQWX7DjN0dJsYVaNYo5JxIQPxJ7Np1UoagE
	LtDDA10+f8O+SiYuf72z78FhYgHdvKJ+kA5PXaJlA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b4r291h5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 17:55:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJGgUiV023755;
	Fri, 19 Dec 2025 17:55:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtb984y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 17:55:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BJHtYGX015634;
	Fri, 19 Dec 2025 17:55:34 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b4qtb9844-1;
	Fri, 19 Dec 2025 17:55:34 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, stable@vger.kernel.org, muchun.song@linux.dev,
        osalvador@suse.de, david@kernel.org, linmiaohe@huawei.com,
        jiaqiyan@google.com, william.roche@oracle.com, rientjes@google.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@Oracle.com, rppt@kernel.org, surenb@google.com,
        mhocko@suse.com
Subject: [PATCH v2] mm/memory-failure: teach kill_accessing_process to accept hugetlb tail page pfn
Date: Fri, 19 Dec 2025 10:55:16 -0700
Message-ID: <20251219175516.2656093-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_06,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512190150
X-Authority-Analysis: v=2.4 cv=WZgBqkhX c=1 sm=1 tr=0 ts=69459197 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=f-Xke4JHVjhQjhv6I2sA:9
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: i9u8nulIWI20L2djzK7Y8_P-03FJISUO
X-Proofpoint-GUID: i9u8nulIWI20L2djzK7Y8_P-03FJISUO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDE1MCBTYWx0ZWRfX2SrnGd1Q1guE
 zmC0VgapUQCEqw5sPzeXeHlV+sET1e0cdKC+zAprTS3hiS8UROJKxzuU+tHRteBm1trTn1xsJji
 8VvJwEkPN4svxeGNsIksCKurKHjRmWH7gCXp3flRznry7VmET+qlUDewanBnds7dHpjxWv4wBK8
 rLlGI+qMrliSdKkICnoPegHaQI3jkR9unI1NyJQejC9DwylPYCV2Ec3vUubgcxeFCXAw+fGIId3
 cP8eZW7wnedSnOM3GP3g4ob6cK4Qumd/xW/7p+ZR1HEM6A6SwcvJTx+W23ZuoQevutlxKNVOHFN
 6q48YAoRCHfOa9P7ruNfmsyrgkWbnt6E5APd8R4v+Sv7Y+peBB17h6vBeufDohc9xy0v50OynLE
 12RdbNj1PdxvPjaRPqdQamuVqIDplV0xDyVBd6QlsPpYRkvZhWNPDxcVXDcKZkhzmPPNIavAYOR
 Vlp9HrUEH+weJOgonUQ==

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
v1 -> v2:
  pickup R-B, add stable to cc list.
---
 mm/memory-failure.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3edebb0cda30..c9d87811b1ea 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -681,9 +681,11 @@ static void set_to_kill(struct to_kill *tk, unsigned long addr, short shift)
 }
 
 static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
-				unsigned long poisoned_pfn, struct to_kill *tk)
+				unsigned long poisoned_pfn, struct to_kill *tk,
+				int pte_nr)
 {
 	unsigned long pfn = 0;
+	unsigned long hwpoison_vaddr;
 
 	if (pte_present(pte)) {
 		pfn = pte_pfn(pte);
@@ -694,10 +696,11 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
 			pfn = swp_offset_pfn(swp);
 	}
 
-	if (!pfn || pfn != poisoned_pfn)
+	if (!pfn || (pfn > poisoned_pfn || (pfn + pte_nr - 1) < poisoned_pfn))
 		return 0;
 
-	set_to_kill(tk, addr, shift);
+	hwpoison_vaddr = addr + ((poisoned_pfn - pfn) << PAGE_SHIFT);
+	set_to_kill(tk, hwpoison_vaddr, shift);
 	return 1;
 }
 
@@ -749,7 +752,7 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
 
 	for (; addr != end; ptep++, addr += PAGE_SIZE) {
 		ret = check_hwpoisoned_entry(ptep_get(ptep), addr, PAGE_SHIFT,
-					     hwp->pfn, &hwp->tk);
+					     hwp->pfn, &hwp->tk, 1);
 		if (ret == 1)
 			break;
 	}
@@ -772,8 +775,8 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 
 	ptl = huge_pte_lock(h, walk->mm, ptep);
 	pte = huge_ptep_get(walk->mm, addr, ptep);
-	ret = check_hwpoisoned_entry(pte, addr, huge_page_shift(h),
-					hwp->pfn, &hwp->tk);
+	ret = check_hwpoisoned_entry(pte, addr, huge_page_shift(h), hwp->pfn,
+				&hwp->tk, pages_per_huge_page(h));
 	spin_unlock(ptl);
 	return ret;
 }
@@ -2023,10 +2026,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		*hugetlb = 0;
 		return 0;
 	} else if (res == -EHWPOISON) {
-		if (flags & MF_ACTION_REQUIRED) {
-			folio = page_folio(p);
-			res = kill_accessing_process(current, folio_pfn(folio), flags);
-		}
+		if (flags & MF_ACTION_REQUIRED)
+			res = kill_accessing_process(current, pfn, flags);
 		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		return res;
 	} else if (res == -EBUSY) {
@@ -2037,6 +2038,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		return action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
 	}
 
+
 	folio = page_folio(p);
 	folio_lock(folio);
 
-- 
2.43.5


