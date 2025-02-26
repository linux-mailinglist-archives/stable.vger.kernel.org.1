Return-Path: <stable+bounces-119620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FD5A45678
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 08:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50BB189575A
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 07:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26417194A66;
	Wed, 26 Feb 2025 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fJmBCwMR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7333923AD;
	Wed, 26 Feb 2025 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740554209; cv=none; b=o8vlP3WCdDQA4UU3Vwa6QF+Beshpw2r4nqXFmjLjXzrtOLtK06v4FA4Iw0U581x1wkIgas+6uOl6PlftcDfmgb848Xf6aMFGQp0DGcgL65EAvfp92OsCKlmh/TU+4PGxsCzA2961UYHRYYUV48knroBf6ZKdZUYRK3Yrg4ekuvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740554209; c=relaxed/simple;
	bh=D8ggxto9h0+YmFo1mS6CdwDp0jJBo3gfXuOouTuXqVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gunFTeErAVJUWmVLUADJoaWv84LaUJ+jxgD8I3LBW/E6pT0WTzhdLezT+Ow49Mo+ndDpXtVOeQ6kHhew5FCwbwJ4tDQe5YE9/O1zxVWJQp65D9pnDuOzdFrTgkzxWrmBaAdm4dTqSrrvLGkD1+mUtGaSbOz2cSM9XerhPbqF8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fJmBCwMR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q6PclK028516;
	Wed, 26 Feb 2025 07:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=s0daWTZ+h3e4CYzqQrGN8s4MZibHUn
	ZL7K/uuxn95uA=; b=fJmBCwMRObf/ZnmW9sa5kvECELdq3pHny4YsS08gG4Q/gi
	cHvYhexKdM49XUtPcMrfs73oN/ZdfMLz6FY2OmcsUNM0SZZDnM5/HvUF6h4zwFBe
	vFi5tLlUP/a5CAAfTf3GozhcWZ68RkW8rgvEm8VIj/UJFvQeTAGP2/m8MdcG+wFS
	daCY2Rk1F27oScWMb820pAU2LMDCMe6sT8sTjJ8XcQO7ZrI+4V3we7Kbolu27cGQ
	eJ2dy8AMJpgFvKxeLbjjXwerdyzBz9CiHa8VOFLzS+gydJZSPoDSW21uUznHjMXa
	388ehXkYWD9DEqwggjCN/SeJCK0D0qwXKl1/AeAA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451wp6864a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 07:16:15 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51Q7DWT5027408;
	Wed, 26 Feb 2025 07:16:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451wp68648-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 07:16:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q4rJnR027390;
	Wed, 26 Feb 2025 07:16:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdkh853-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 07:16:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51Q7G82A17170924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 07:16:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1A112004B;
	Wed, 26 Feb 2025 07:16:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 519E420049;
	Wed, 26 Feb 2025 07:16:06 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.19.83])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Feb 2025 07:16:06 +0000 (GMT)
Date: Wed, 26 Feb 2025 08:16:04 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dev Jain <dev.jain@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm: hugetlb: Add huge page size param to
 huge_ptep_get_and_clear()
Message-ID: <Z76/tK6yr32O2C4h@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250217140419.1702389-1-ryan.roberts@arm.com>
 <20250217140419.1702389-2-ryan.roberts@arm.com>
 <Z73Szw4rSHSyfpoy@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <290f858c-07d4-4690-998c-2aefac664d7b@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <290f858c-07d4-4690-998c-2aefac664d7b@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XY_V547MWzFXGjFNryOxXjG0TG-cKJAp
X-Proofpoint-ORIG-GUID: vG3krsx3_W2UnseQJeBqT6t6C7a6pKKC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=592 clxscore=1015
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260055

On Tue, Feb 25, 2025 at 03:43:04PM +0000, Ryan Roberts wrote:
> >> +pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> >> +			      unsigned long addr, pte_t *ptep, unsigned long sz)
> >> +{
> >> +	return __huge_ptep_get_and_clear(mm, addr, ptep);
> >> +}
> > 
> > Is there a reason why this is not a header inline, as other callers of
> > __huge_ptep_get_and_clear()?
> 
> I was trying to make the change as uninvasive as possible, so didn't want to
> change the linkage in case I accidentally broke something. Happy to make this an
> inline in the header though, if you prefer?

Yes, please.

> Thanks,
> Ryan

Thanks!

