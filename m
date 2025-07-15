Return-Path: <stable+bounces-161962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5419CB0599F
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842411A6754E
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 12:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85102DC35D;
	Tue, 15 Jul 2025 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ItxGLttX"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0713533D6
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581508; cv=none; b=JpgELll99jUIeBM1TSgppOO25WTC4kPC7x6xXYfO+eB2//MvBXFVQazfHjBvSMTrBPkLNXyRmQAoN9tVNS9XHS6p/dh/CJyEF7VRCeezIT+ibmpPmDcnmhb2FrHYI8eS9Juqk9cLuN8hS0eGl/ZqrHap3Muid543zHpAU6MktRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581508; c=relaxed/simple;
	bh=ukL7qKCPhrNzQQuwXepY8/8fST3QWK5bxr6W6c0N7Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBY9POjXj4U+wNAuWPq6GkiwaW80eRrK4IECwjOOpmj03NrUo/iGEBwRb/TeUGPjPvAvaUBZ6xNdUCqA/1pyPR0U1Kg7jEMuy88Rq5MLvXdnoCSeCYhXHCeJz9s+viOBGgdG9tMp5nvEzxwB5/YwsDjL6JhsjhupBXOwmoozP4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ItxGLttX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F3fF4F016761;
	Tue, 15 Jul 2025 12:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=IeFUQd/26SIwETdDdNfouBl/NgkfFy
	hkaNgwt5jz2CA=; b=ItxGLttXO+B14uCWZBhVTEBTXbiBVwiVcDoC3AXGv4LvkM
	58+uWDZTLcs+BixhkP5mJn/WNNgVNhJCzWXbEV5SjMTmDWAfXubVhN4IFkLv+LUP
	xL667oxh5FCp7kOjDaIHxQKd5MCP2uksDWWs09xlqgOFvh8TBsHGLBnmpoLwmGmM
	mK08j31fS+5qelhu58uL4LRJhUElEhBOuRiZPZTHiq8YPrDL/AOKO7eIuB/ENPU2
	aEhrtTICPGeEX7TGRBagRjKuYHotuYOuSulcHUn7EkEkdcEBLu9KmI6MoZcr2kaA
	B9MN2n3Ohzwx5OtPyDlGomWFy4kFLU6tGGCsVylg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4txwnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 12:11:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56FA6mw5021906;
	Tue, 15 Jul 2025 12:11:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v4r320hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 12:11:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56FCBeVv15925722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 12:11:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECC672004E;
	Tue, 15 Jul 2025 12:11:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDBC120043;
	Tue, 15 Jul 2025 12:11:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Jul 2025 12:11:39 +0000 (GMT)
Date: Tue, 15 Jul 2025 14:11:38 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: stable@vger.kernel.org
Cc: akpm@linux-foundation.org, dan.carpenter@linaro.org, ryan.roberts@arm.com
Subject: [PATCH 5.10.y] mm/vmalloc: leave lazy MMU mode on PTE mapping error
Message-ID: <20250715121138.1838435A9f-agordeev@linux.ibm.com>
References: <2025071323-settling-calculus-60b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025071323-settling-calculus-60b3@gregkh>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=6876457e cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8
 a=Z4Rwk6OoAAAA:8 a=5P0lE76X0mNynxRVqSkA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: HpV7YUQkXt_uy0-eOoK3-FKPznzX4uL9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEwNyBTYWx0ZWRfX82EWV4eXYOkL 7lZ9diTxkhYnTzfCAD9gbNbikTFRNmrCgUhPflJeHq60Wmdf2XZdXUbsAJK5iUxjG2sgAfzqDF4 F4oK1grE1dCog7+bViSW+HJqnpJVqWJppAffANL1IOYyjapNjf4dgSZf7yHgFWWUe94BWjAUDPF
 fJXUsLO0Xsvx6tZYlZ+ACE1wgi+2PeF1W8aMBEfzDRmQX8/qkFVqfvqJzm5PrCa4CFclQ1+LMKG Qn5oipJdBgN4JuOlV3Z111lxp28s6TiVI+zGkfS4BYCveF/RKNuqvxQg4yKiF5xiExw1vxPRkhD 8Bp5QPFiGI/WkiPlTHyVh1SiWomWDL79c+q4elwD+RlwFhSjEepmbf4iIp94gmeD3zuosGYxoXW
 CiXvISttysTqdyGA54iojtaPnBrNeglk5CXvfQIYVLHciiPh2B/xUMshx+wihABrZitiseen
X-Proofpoint-ORIG-GUID: HpV7YUQkXt_uy0-eOoK3-FKPznzX4uL9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 bulkscore=0
 mlxlogscore=-999 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=100
 malwarescore=0 spamscore=100 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150107

vmap_pages_pte_range() enters the lazy MMU mode, but fails to leave it in
case an error is encountered.

Link: https://lkml.kernel.org/r/20250623075721.2817094-1-agordeev@linux.ibm.com
Fixes: 2ba3e6947aed ("mm/vmalloc: track which page-table levels were modified")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202506132017.T1l1l6ME-lkp@intel.com/
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit fea18c686320a53fce7ad62a87a3e1d10ad02f31)
---
 mm/vmalloc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index fd1c8f51aa53..66c24ed6e201 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -193,6 +193,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
+	int err = 0;
 	pte_t *pte;
 
 	/*
@@ -206,15 +207,20 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
 	do {
 		struct page *page = pages[*nr];
 
-		if (WARN_ON(!pte_none(*pte)))
-			return -EBUSY;
-		if (WARN_ON(!page))
-			return -ENOMEM;
+		if (WARN_ON(!pte_none(*pte))) {
+			err = -EBUSY;
+			break;
+		}
+		if (WARN_ON(!page)) {
+			err = -ENOMEM;
+			break;
+		}
 		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
 		(*nr)++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	*mask |= PGTBL_PTE_MODIFIED;
-	return 0;
+
+	return err;
 }
 
 static int vmap_pmd_range(pud_t *pud, unsigned long addr,
-- 
2.48.1


