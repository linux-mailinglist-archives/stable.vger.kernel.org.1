Return-Path: <stable+bounces-161964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AF1B059A6
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5666E1A682D8
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 12:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B287F2D77F8;
	Tue, 15 Jul 2025 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OLGss0nE"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF50533D6
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581579; cv=none; b=pFci5NE7Gzd5Ctgcr5/Ls1Cr2YZgjwi31Q8aXomy8gZFFoLHiGhJsakhwpBGpBt2zCO6kGqbcGddlL0M31FIs1oJ2KLB6QXYSJMa3ZPqRQDtWUn30AFb9EY5lZJAkdBUDNZb0QNT8ujVDbJ9x0+IwGGt8BnFqFI3ALsfjYl7m50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581579; c=relaxed/simple;
	bh=t61l7dpkqXCQhFtEAgooityzw+SfvX1RFxehSEBKs7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLmYVEh2j1NCMtmP1rz/B69sY/EW0By5hIFbJ6MjazkrHtWgdjdFCfQ2jWTIjjqU8Ndo0zppbuG6sGFoylY8BF5JSe5iR7BosapZAWNyhYvRdayt9YALkwX6CgeZEr1hQmytRkeAWfsecc7sb9nV2J5zJRFm6i0mflaf1LakZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OLGss0nE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F69Evq012723;
	Tue, 15 Jul 2025 12:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SkabzdfDbsVT1bFlm9WhCawateprb1
	9uLmi2UmR0SFk=; b=OLGss0nE26MK9/1uYSYOEJjX7FRD7vpbPfZfhA1Z9thJHs
	e1vm25A0bGX72SmM029qYKXQTipC6pcsCvgxhbLDfyX516RdRFfo43TcqthrTaIF
	zNIrKUhF4xhnbEkyi4r8p0hxHGG1XTD5ftFKFHKxYDUCLvJaXxa5S889z+sL3Hbd
	qRNjfcNMCJVRVGTsGOxIX6hM2CgsFLrpkVvKO9JJl1D9cb7nsen6TMwO9M/Vkp+h
	JX6f5H9PxhuaW6cty0pblgok14MwHk8jHnTef9wEXLIPW5YcDY/ZTj/MMvwPboMr
	eFK5slI7XJTPOpBTsCqglWnRzvc7PdJZImCOkXwg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufeey43c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 12:12:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7k6ac008164;
	Tue, 15 Jul 2025 12:12:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v2e0jgkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 12:12:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56FCCmcJ23200224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 12:12:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B232D2004B;
	Tue, 15 Jul 2025 12:12:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DC0220043;
	Tue, 15 Jul 2025 12:12:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Jul 2025 12:12:48 +0000 (GMT)
Date: Tue, 15 Jul 2025 14:12:47 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: stable@vger.kernel.org
Cc: akpm@linux-foundation.org, dan.carpenter@linaro.org, ryan.roberts@arm.com
Subject: [PATCH 6.1.y] mm/vmalloc: leave lazy MMU mode on PTE mapping error
Message-ID: <20250715121247.1838435Ca0-agordeev@linux.ibm.com>
References: <2025071315-rural-exploring-3260@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025071315-rural-exploring-3260@gregkh>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEwNyBTYWx0ZWRfX40BJJA9s620q 7gaTLlYBJqNdztKEAln7tnAj5rAxqh2v19L3Xt3zLQD1/JzvO3p/tEBqSKO0GRcG5EkrHNLHzoi WcugWhSnSehmd50gsv3wlUbIYHIL+Oji8pjkSVJbfa/qKcMnYnJ3V+tXhu3SzJlIp0zntrw388N
 PJpc8gJPj+AJvydJXT4jF176xAkul0n5H+YkQJsOzQbX2z14T9XszZqwmT0n/N5Z9liau4BbmrU 4ZKycV6WAAO4UnZeFbRV8C2sKeBceMl2TeCHo1DwlhLqbl+DO1+RrMlbAbY5YJjm3rmjb4KsEpN FdC9MVOi05Hx6TJ7d1X8GSZaGPQyBXI/ACYzKth61HnJflAsXtPOpCC3OSUW0lecMw2KDkTtnaj
 Y1ZfglXn0wlkLjrPjyaeXUzSb/xyn2XmdET96bQOPj2aS50UAlEXB/gggiTGhdhpwBUHOX3A
X-Proofpoint-ORIG-GUID: LEsQpGWZWdml0jKfd7oIEZiNscMtaLIm
X-Authority-Analysis: v=2.4 cv=C9/pyRP+ c=1 sm=1 tr=0 ts=687645c4 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8
 a=Z4Rwk6OoAAAA:8 a=jhm_KF0QdqEHfoKg1xUA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: LEsQpGWZWdml0jKfd7oIEZiNscMtaLIm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=100 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=-999 bulkscore=0
 adultscore=0 clxscore=1015 mlxscore=100 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
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
 mm/vmalloc.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 562994159216..ebeb6b2e1a15 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -467,6 +467,7 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
+	int err = 0;
 	pte_t *pte;
 
 	/*
@@ -480,18 +481,25 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	do {
 		struct page *page = pages[*nr];
 
-		if (WARN_ON(!pte_none(*pte)))
-			return -EBUSY;
-		if (WARN_ON(!page))
-			return -ENOMEM;
-		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
-			return -EINVAL;
+		if (WARN_ON(!pte_none(*pte))) {
+			err = -EBUSY;
+			break;
+		}
+		if (WARN_ON(!page)) {
+			err = -ENOMEM;
+			break;
+		}
+		if (WARN_ON(!pfn_valid(page_to_pfn(page)))) {
+			err = -EINVAL;
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
 
 static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,
-- 
2.48.1


