Return-Path: <stable+bounces-210114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC1ED387AC
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 21:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01BF730128D0
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 20:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2F22EFD8C;
	Fri, 16 Jan 2026 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oh1Gk0wT"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B9B2609FD;
	Fri, 16 Jan 2026 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768596010; cv=none; b=UOM7YugC5xnRZ/QwuT8xHViKuLasPvFtW67OsS6ij7mrV2ru+xVA5ggizKhZ8VzPBLcJNdJKpfWgOjSPNIDt0xRagoBSantXLcwQLcZ+E86jlgYq19XTRqHYr3KSRAkUNXlZ1nzMAD7Xoh6KEcTiG/V7YkFh2EU8gU2NiEN/okg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768596010; c=relaxed/simple;
	bh=OnqDKgnOUsetcSvvnbBUi8oR3OJNQssalACqwFlTR4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhvwNj6RCFY1UrdMUWN1ejioHH5E2RvYikehyKx56EaVec70CeEE96BLQADWqEQoOG+w+IgBzH/+67FmpUJoCkN9Db48zlWShP1H1pO0npxcfvG9+gWq3YEbqiHquKWMICNLA/7rzxtJKgb83ca+0mdpcwn5Z9R+O62Tu3PGv6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oh1Gk0wT; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GKb0V73839187;
	Fri, 16 Jan 2026 20:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=PJgG6
	l0Amdkwy+w0l87obtGT6Q5vG5xjNv8DqWki1Kc=; b=oh1Gk0wTgKF65PBN8pz+C
	UM7mb9/uNMQo0f5mtJ4fhjKyyNOgoEYSOEBKEROxAMejQ51Cq2dTugYlodV6oaq8
	bJ5nLU96z8ESBC7qUxQKot4uU66lxZSmg/mdcCCAHkw7PQ1F7Nvlv7OH2s531xOx
	eHc/skdZeHdnNH/QGcjdTEh0vHqk2Hym0qWqgrSMCrrGrciW9Qho4fBn5ON81NcB
	oF5TI2sgbrZQcQP+1gJ9VuUY53K79ilDHMc6E/PErcKTuQrM9hkJHwu5bPi3F5jg
	hQBKsU7x2HgZdQj2Z12pvYDFVAG3o9c74mFyXsk3mrbz1VbxC9+LiAtb0dfUrUqu
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bqvh7g068-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 20:38:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60GKKjWI011135;
	Fri, 16 Jan 2026 20:38:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bqv9m0gh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 20:38:53 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60GKclNN019846;
	Fri, 16 Jan 2026 20:38:53 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bqv9m0gen-2;
	Fri, 16 Jan 2026 20:38:53 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, stable@vger.kernel.org, muchun.song@linux.dev,
        osalvador@suse.de, david@kernel.org, linmiaohe@huawei.com,
        jiaqiyan@google.com, william.roche@oracle.com, rientjes@google.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@Oracle.com, rppt@kernel.org, surenb@google.com,
        mhocko@suse.com, willy@infradead.org, clm@meta.com
Subject: [PATCH v6 2/2] mm/memory-failure: teach kill_accessing_process to accept hugetlb tail page pfn
Date: Fri, 16 Jan 2026 13:38:33 -0700
Message-ID: <20260116203834.3179551-2-jane.chu@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260116203834.3179551-1-jane.chu@oracle.com>
References: <20260116203834.3179551-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_07,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601160154
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDE1NCBTYWx0ZWRfX+8DAjX7b6/G6
 uc0jAwOOjy75t+rz1RgrhZVcuzzsMvCf91Gj740HGgnRDbAI2C60LEHweDDIT3BFElGU1VIpaZ2
 IyjdHsdgJ4U/R81j76L/3ECGAOTMjQ17e8V0StRSRPQIm0l02ECZ7tgCTeOnGlJsMHr7dN4jbAz
 FuC/PE5d4U4ARVgpaV3H0UFF4pOdxF0Ca6fsgDQf31MZm3qvMWaNYITlvEuv8dWOtcKOwYGfTeC
 OaoJcOniVQuxoSWrQf0ITRWFNU+lI8tOtha+6ZF/3ehK1P59EJKs/gMa+y4RfJ+wSrGiD9nwbDY
 pFd2utEu5nO1/R1vhGmW2TVXfufX8w2s6WuMMXcXI1JBmLSbj5bt7RTJ9DXYIjeaRepPsUBObUK
 1+lyiKp1qZFui2cDK41Z3OEC7fO0oKffZM377Ko55PDEF7fyV82maDccss+Pf0HJ6aX46dmcCVY
 i7tn6x60dxovIDHEMcw==
X-Proofpoint-ORIG-GUID: co0pzrNzwGword2GpAv5iFPpblfIQj5y
X-Proofpoint-GUID: co0pzrNzwGword2GpAv5iFPpblfIQj5y
X-Authority-Analysis: v=2.4 cv=A9lh/qWG c=1 sm=1 tr=0 ts=696aa1de cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=i0EeH86SAAAA:8 a=PxEJfYR7Scfl-YKRXAAA:9
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
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
---
v5 -> v6:
  comment from Miaohe, add an acked-by.
v5, v4: No change.
v2 -> v3:
  incorporated suggestions from Miaohe and Matthew.
v1 -> v2:
  pickup R-B, add stable to cc list.
---
 mm/memory-failure.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 49ced16e9c1a..2d330176364a 100644
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
+	if (!pfn || pfn != (poisoned_pfn & mask))
 		return 0;
 
-	set_to_kill(tk, addr, shift);
+	hwpoison_vaddr = addr + ((poisoned_pfn - pfn) << PAGE_SHIFT);
+	set_to_kill(tk, hwpoison_vaddr, shift);
 	return 1;
 }
 
@@ -2050,10 +2054,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
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


