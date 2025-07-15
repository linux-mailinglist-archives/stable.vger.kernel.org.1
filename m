Return-Path: <stable+bounces-161963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A760B059A3
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1943BA523
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 12:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EB82DC35D;
	Tue, 15 Jul 2025 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ceDLuJOJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC426CE31
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581549; cv=none; b=Hp3MgylimYjQ5YuDBqrpphjo1nDvidhvskzXOhOZY1PaQmz9rmS4x2vT9p+enDOs8vemi+WdFf5QyTfdyVqKSMyP+KsNfbnNL2Et+slSC84GiVnaXCZqFTqHK5tFlh6YXNkW9EcvztjltxlGTcqLFPreXlakmuGJI68bRYR9dFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581549; c=relaxed/simple;
	bh=sbt/I8AKyEPg214j6Tmokw1fhcJeEmi33wvdJY80+IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZujKDMi36rfpV9zKnkJ5jw4D3yogiBtcuDoMhfhNOu902B7LLiCX3XD7bsRW/Jg06aJCVRAv+i32N+hqrgahHVRps2aj2Ex/cXcDc05DC4Mp5K2UP0tP9uLnb3romw4WaoR9nLnwTGbxF9pXvoHbEoVtgwNcfw/EFsAvqxVTxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ceDLuJOJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F82TYe017339;
	Tue, 15 Jul 2025 12:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=y9K97HKNsIhTL3vjgMkAE5Ets7xzSA
	4EMUl7WJGddFU=; b=ceDLuJOJOUbHy5t4xdYyDPFM5M5Snbp5Ri07feIkFJthtb
	me0pY4brWNg52qH2edq7SRaW05/hgUZ/4d5Z9Gc/3KRJbWx8qgy10nkPDuBZh7Wa
	Wfv+HRKYXlTPurJJ0OZidPk01rGJUT2P16dMIhuTiWKKu4Dx5ZwdP4/yNfRkUgIo
	QXcMTQX5s2lS6mMW2E/LhATujHkm6lLgiQbaA/WBOFmKzlx2KPR0QYxyfRUFCVEI
	S4TgOONzFUCIbYZpmvYqraBYEz+nUpfyZLRUxVzK5ZRbmpKBi7gKT0Upj9S8AYq2
	OhEvy1LiOz9sz0OPKOWe9H4UBW+/GAtc0ob9nFlw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamttah0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 12:12:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56F8OdWb025505;
	Tue, 15 Jul 2025 12:12:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v31pjcs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 12:12:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56FCCFiZ58458386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 12:12:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0424620043;
	Tue, 15 Jul 2025 12:12:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E299B20040;
	Tue, 15 Jul 2025 12:12:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Jul 2025 12:12:14 +0000 (GMT)
Date: Tue, 15 Jul 2025 14:12:13 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: stable@vger.kernel.org
Cc: akpm@linux-foundation.org, dan.carpenter@linaro.org, ryan.roberts@arm.com
Subject: [PATCH 5.15.y] mm/vmalloc: leave lazy MMU mode on PTE mapping error
Message-ID: <20250715121213.1838435B99-agordeev@linux.ibm.com>
References: <2025071316-jawed-backward-2063@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025071316-jawed-backward-2063@gregkh>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EEtDJeINIBJI13pqFoQ1jJnIs7Cx6Axy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEwNyBTYWx0ZWRfX3SD6M8x72FWk GrAFFSAhY29JVaaH5XjgHwOFuYIi4Yt0BdZh3k9H+w0zpMGpFug6aL4bBLMUB3WHUjMNbAzmhHI 2/dhPwuvzmAWVohdsEyAsIoIu48oo4lclueeF4e4o4gTKUscNscaUdB30NeVAxwzwcRNDzkGPJ+
 J078UrPHD8ksEO2qsgnzOLTqdRCZL8EHE2apAdYcpUIgRR7yeJtsuMxJ2OlSEmZc+7RzKrWg1ng 89CJJyTb/+URChqd8Pj8LT5acSlTbpSedDW1cXGIMGBNSn4NyQoKi5sTkWktQNLFrlL0R/BGtuK wroaX7aKgpV6eluK89HWsfEYhh8BPyPdCaJlqXhatCl+tYc0osOuJ6BDr6nlNX1KUHHS9fx5el2
 8zHDetCWsenmVyKP3Ve2wSaMMJB5KtKtFxfUi8HDANsL84ll2Jtl1LM6hgSKMDsZ3tCplOre
X-Proofpoint-ORIG-GUID: EEtDJeINIBJI13pqFoQ1jJnIs7Cx6Axy
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=687645a1 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8
 a=Z4Rwk6OoAAAA:8 a=YVhYAdneKd-fufdUeLwA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 priorityscore=1501
 mlxlogscore=-999 bulkscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=100 clxscore=1015 phishscore=0 malwarescore=0 mlxscore=100
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
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
 mm/vmalloc.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 840e25cab934..502f51b86fa3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -460,6 +460,7 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
+	int err = 0;
 	pte_t *pte;
 
 	/*
@@ -473,15 +474,21 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
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
+
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


