Return-Path: <stable+bounces-268283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U6FWIADSPGpDswgAu9opvQ
	(envelope-from <stable+bounces-268283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:00:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7154C6C32E9
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:00:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b="XuxD/Ybc";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268283-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268283-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 768E1300723A
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 07:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C4E33A9D1;
	Thu, 25 Jun 2026 07:00:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2472F8EA0;
	Thu, 25 Jun 2026 07:00:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370811; cv=none; b=EQ7ynfKHo2ca9LC8ey5BpzJK4AQ/3RCRvZdk14k00qNu0Hfs/n4K1UvKuIvpJw2Hnj3Ig6eyTYLXb3AWCKymXZQXWnEzvWrt5QP2ZCeWWBh2AP5tp66q4epaEhNKYm6muHP4YUlCGYEVdVHd2JbUOnb7CcgT6Mc6uQyeWmWi2KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370811; c=relaxed/simple;
	bh=u4jABPlZSzfgRRcXDTKbxucxNVmhlGdcQNnwT4HDB88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfYbS3kRnM/z7zB5yB9PSF8F1mXjjdYFhSXORoOjNjD2GC6/YPk45XpLQ57sIjhE5sJhtJMvHtFYBTCn1TfAm1cFAHYrKFsAAXeZgQp5GFId+3oXbuHv+SFtH/NVlDixDUk0dWvW4A2SEDMQ4vdh0pCh260OCADbLDd8DIuZL+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XuxD/Ybc; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9CFB2BCE;
	Wed, 24 Jun 2026 23:59:55 -0700 (PDT)
Received: from [10.164.19.14] (unknown [10.164.19.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31CDA3F836;
	Wed, 24 Jun 2026 23:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782370800; bh=u4jABPlZSzfgRRcXDTKbxucxNVmhlGdcQNnwT4HDB88=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XuxD/YbcCBHLeD5/+EryCgdigQZJqPQxElywZZ0Ilifij5vaKJr4RZqj0Lvru/pd1
	 Rkf/Sw7ploOIVlaucD7ISq1Z3UyP+NgM0R3KKQw28OG8hEDpg3fzF5EaCiet5MFZJr
	 qzRT5ERDLz3i4MXs8olfw97jn7GefhMLUGYAieCg=
Message-ID: <2fd3688b-b4d0-4a2f-8d49-4d4b9c512c66@arm.com>
Date: Thu, 25 Jun 2026 12:29:53 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
To: kernel test robot <lkp@intel.com>, akpm@linux-foundation.org,
 david@kernel.org, ljs@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, riel@surriel.com,
 liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 kas@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ryan.roberts@arm.com, anshuman.khandual@arm.com, stable@vger.kernel.org
References: <20260625042853.2752898-1-dev.jain@arm.com>
 <202606251341.jfIr1D7m-lkp@intel.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <202606251341.jfIr1D7m-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268283-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lkp@intel.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:llvm@lists.linux.dev,m:oe-kbuild-all@lists.linux.dev,m:riel@surriel.com,m:liam@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7154C6C32E9



On 25/06/26 11:15 am, kernel test robot wrote:
> Hi Dev,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Dev-Jain/mm-rmap-use-huge_ptep_get-in-try_to_unmap_one/20260625-123050
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20260625042853.2752898-1-dev.jain%40arm.com
> patch subject: [PATCH] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
> config: hexagon-allnoconfig (https://download.01.org/0day-ci/archive/20260625/202606251341.jfIr1D7m-lkp@intel.com/config)
> compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 6cc609bb250b21b47fc7d394b4019101e9983597)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260625/202606251341.jfIr1D7m-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202606251341.jfIr1D7m-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> mm/rmap.c:2100:13: error: call to undeclared function 'huge_ptep_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     2100 |                         pteval = huge_ptep_get(mm, address, pvmw.pte);
>          |                                  ^
>>> mm/rmap.c:2100:11: error: assigning to 'pte_t' from incompatible type 'int'
>     2100 |                         pteval = huge_ptep_get(mm, address, pvmw.pte);
>          |                                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    2 errors generated.

Weird that I need a stub. This should do:

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2abaf99321e90..4661f88eee55b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1261,6 +1261,16 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
 {
 }

+static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr,
+				  pte_t *ptep)
+{
+#ifdef CONFIG_MMU
+	return ptep_get(ptep);
+#else
+	return *ptep;
+#endif
+}
+
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
diff --git a/mm/rmap.c b/mm/rmap.c
index 1c77d5dc06e9f..aa8a254efaecc 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2095,11 +2095,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_FOLIO(!pvmw.pte, folio);

-		/*
-		 * Handle PFN swap PTEs, such as device-exclusive ones, that
-		 * actually map pages.
-		 */
-		pteval = ptep_get(pvmw.pte);
+		address = pvmw.address;
+		if (folio_test_hugetlb(folio)) {
+			pteval = huge_ptep_get(mm, address, pvmw.pte);
+		} else {
+			/*
+			 * Handle PFN swap PTEs, such as device-exclusive ones,
+			 * that actually map pages.
+			 */
+			pteval = ptep_get(pvmw.pte);
+		}
 		if (likely(pte_present(pteval))) {
 			pfn = pte_pfn(pteval);
 		} else {
@@ -2110,7 +2115,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		}

 		subpage = folio_page(folio, pfn - folio_pfn(folio));
-		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
 				 PageAnonExclusive(subpage);

