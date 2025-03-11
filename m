Return-Path: <stable+bounces-124094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984A1A5CF55
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 20:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1431686AC
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18172641D7;
	Tue, 11 Mar 2025 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYVF/67J"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75851C6FFD;
	Tue, 11 Mar 2025 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721294; cv=none; b=bCrFb0pacZQ978gqn7iHxBRUnHBxL6B1bBdHFM1OPS28Tup9CplFntatHbfZygR/WxPIMxSStfGDlFt0y6VAUz4SCiHO3FJ+VEF2h1LCEE+X6Merv8oF3f1jXoL9PLJBLgCripmtSbCEZESlSmkvmvi0DgPdYI5k+wJhhpjNEZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721294; c=relaxed/simple;
	bh=tGDxHYME1E5PBH/Xs34OVRPe9r+/N/TdI/MClA4i6nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+btTGzZCqC/7K2PWkStl3THgKnnuV1aMd2NPzOcx8K7AUtxHHqAcA28cleoWod9cFiYQgBAMBw9ldgMwKTrGwImCeyZyrlL1hN012+Q7r5U3nx9+HCW1i3Wodz6lcRIs7m+mL5ciYIpMVJf+FCstMV1axBbO/4nTU50PcrfggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYVF/67J; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741721293; x=1773257293;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tGDxHYME1E5PBH/Xs34OVRPe9r+/N/TdI/MClA4i6nA=;
  b=HYVF/67JJluVwGed6Z6Ug2V019uiWxY75Cje4rlUxqsso0CVJzm8LJLy
   YKCPM449T8Xt9dPYR7joSE7j9+5m5zAgpsawVJIhS3tswAxYK4cl7Jn3a
   2kGBFDZ3pB88K6rlfXdy90SGMvXDQKYAqxyrXG/5TH9W3KY+HAHbd3sPG
   y1T7RwlPUMxIsxYkKkkBbw0WIXMUcI15X2DkqRoosjNnk6rq84xnuCi5O
   5+pH2e+2g317M6PBr3KXBZ/bL3+YkM8R0t01F7rkk0InEAKIuGkGwUPka
   xPdb5OcRKkEaSRSMGtbB9aCKyv7nVUlnUleM6OV3Bnr4Kb7OTTl05HVra
   g==;
X-CSE-ConnectionGUID: Qdb+5u92QTi/tH658r4FHw==
X-CSE-MsgGUID: qtrEqbWKQbWW9rUdRPj1kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42987908"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="42987908"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 12:28:12 -0700
X-CSE-ConnectionGUID: 611/B4fFT/+00JyFHtPTZA==
X-CSE-MsgGUID: utPwfI9pRDGdzzgp+ZCLKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="120927902"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.111.143]) ([10.125.111.143])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 12:28:11 -0700
Message-ID: <4d800744-7b88-41aa-9979-b245e8bf794b@intel.com>
Date: Tue, 11 Mar 2025 12:28:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: introduce include/linux/pgalloc.h
To: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>, linux-kernel@vger.kernel.org
Cc: osalvador@suse.de, 42.hyeyoo@gmail.com, byungchul@sk.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 akpm@linux-foundation.org, stable@vger.kernel.org, linux-mm@kvack.org,
 max.byungchul.park@sk.com, max.byungchul.park@gmail.com
References: <20250311114420.240341-1-gwan-gyeong.mun@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzUVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT7CwXgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lczsFNBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <20250311114420.240341-1-gwan-gyeong.mun@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Leading off the comments... The subject is not _wrong_, but it only
describes a small piece of what is going on here. If you can't describe
a patch in the subject, it's also generally a good sign that the patch
needs breaking up.

On 3/11/25 04:44, Gwan-gyeong Mun wrote:
> The include/linux/pgalloc.h is going to be the home of generic page table
> population functions. Start with including asm/pgalloc.h to
> include/linux/pgalloc.h and adding functions that if an architecture needs
> to synchronize global pgds when populating the init_mm's pgd.
> 
> The newly introduced p4d_populate_kernel() and pgd_populate_kernel()
> functions synchronize global pgds after populating init_mm's p4d/pgd.
> 
> If the architecture requires to synchronize global pgds,
> add ARCH_USE_SYNC_GLOBAL_PGDS to the Kconfig of the required architecture
> and implement arch_sync_global_p4ds() and arch_sync_global_pgds() to the
> architecture.
> And this patch adds an implementation to the x86 architecture.

BTW, please don't use "this patch". Use imperative voice instead.

> Through using new introduced p4d_populate_kernel() and
> pgd_populate_kernel() functions, it addresses an Oops issues when
> performing test of loading XE GPU driver module after applying the GPU SVM
> and Xe SVM patch series[1] and the Dept patch series[2].
> 
> The issue occurs when loading the xe driver via modprobe [3], which adds
> a struct page for device memory via devm_memremap_pages().
> When a process leads the addition of a struct page to vmemmap
> (e.g. hot-plug), the page table update for the newly added vmemmap-based
> virtual address is updated first in init_mm's page table and then
> synchronized later.
> If the vmemmap-based virtual address is accessed through the process's
> page table before this sync, a page fault will occur.
> This addresses the issue by synchronizing with the global pgds immediately
> after populating the init_mm's pgd.
> 
> [1] https://lore.kernel.org/dri-devel/20250213021112.1228481-1-matthew.brost@intel.com/
> [2] https://lore.kernel.org/lkml/20240508094726.35754-1-byungchul@sk.com/
> [3]
> [   49.103630] xe 0000:00:04.0: [drm] Available VRAM: 0x0000000800000000, 0x00000002fb800000
> [   49.116710] BUG: unable to handle page fault for address: ffffeb3ff1200000
> [   49.117175] #PF: supervisor write access in kernel mode
> [   49.117511] #PF: error_code(0x0002) - not-present page
> [   49.117835] PGD 0 P4D 0
> [   49.118015] Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
> [   49.118366] CPU: 3 UID: 0 PID: 302 Comm: modprobe Tainted: G        W          6.13.0-drm-tip-test+ #62
> [   49.118976] Tainted: [W]=WARN
> [   49.119179] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [   49.119710] RIP: 0010:vmemmap_set_pmd+0xff/0x230
> [   49.120011] Code: 77 22 02 a9 ff ff 1f 00 74 58 48 8b 3d 62 77 22 02 48 85 ff 0f 85 9a 00 00 00 48 8d 7d 08 48 89 e9 31 c0 48 89 ea 48 83 e7 f8 <48> c7 45 00 00 00 00 00 48 29 f9 48 c7 45 48 00 00 00 00 83 c1 50
> [   49.121158] RSP: 0018:ffffc900016d37a8 EFLAGS: 00010282
> [   49.121502] RAX: 0000000000000000 RBX: ffff888164000000 RCX: ffffeb3ff1200000
> [   49.121966] RDX: ffffeb3ff1200000 RSI: 80000000000001e3 RDI: ffffeb3ff1200008
> [   49.122499] RBP: ffffeb3ff1200000 R08: ffffeb3ff1280000 R09: 0000000000000000
> [   49.123032] R10: ffff88817b94dc48 R11: 0000000000000003 R12: ffffeb3ff1280000
> [   49.123566] R13: 0000000000000000 R14: ffff88817b94dc48 R15: 8000000163e001e3
> [   49.124096] FS:  00007f53ae71d740(0000) GS:ffff88843fd80000(0000) knlGS:0000000000000000
> [   49.124698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   49.125129] CR2: ffffeb3ff1200000 CR3: 000000017c7d2000 CR4: 0000000000750ef0
> [   49.125662] PKRU: 55555554
> [   49.125880] Call Trace:
> [   49.126078]  <TASK>
> [   49.126252]  ? __die_body.cold+0x19/0x26
> [   49.126509]  ? page_fault_oops+0xa2/0x240
> [   49.126736]  ? preempt_count_add+0x47/0xa0
> [   49.126968]  ? search_module_extables+0x4a/0x80
> [   49.127224]  ? exc_page_fault+0x206/0x230
...

BTW, oopses are usually better in the cover letter or at least left
trimmed down to the bare essentials if you want to keep them in a commit
message.

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index d581634c6a59..0e0606cc9d4f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -427,6 +427,10 @@ config PGTABLE_LEVELS
>  	default 3 if X86_PAE
>  	default 2
>  
> +config ARCH_USE_SYNC_GLOBAL_PGDS
> +	def_bool y
> +	depends on X86_64 && (PGTABLE_LEVELS > 3)

Do we have a 3-level 64-bit paging mode I'm not aware of? ;)

I know it's not super obvious, but take a look at the relevant Kconfig
options:

config PGTABLE_LEVELS
        int
        default 5 if X86_5LEVEL
        default 4 if X86_64
        default 3 if X86_PAE
        default 2

config X86_PAE
        depends on X86_32 && !HIGHMEM4G

config X86_5LEVEL
        depends on X86_64

Expanding that back into the PGTABLE_LEVELS options:

        default 5 if X86_5LEVEL # depends on X86_64
        default 4 if X86_64
        default 3 if X86_PAE # depends on X86_32
        default 2 # can't be set if X86_64

So, 4 and 5 are 64-bit only and 2 and 3 are 32-bit only.

> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
...
> +#ifdef CONFIG_ARCH_USE_SYNC_GLOBAL_PGDS

What purpose does this #ifdef serve?

> +#if CONFIG_PGTABLE_LEVELS > 3
> +void arch_sync_global_p4ds(unsigned long start, unsigned long end)
> +{
> +	sync_global_pgds(start, end);
> +}
> +
> +void arch_sync_global_pgds(unsigned long start, unsigned long end) {}
> +
> +#if CONFIG_PGTABLE_LEVELS > 4
> +void arch_sync_global_p4ds(unsigned long start, unsigned long end) {}
> +
> +void arch_sync_global_pgds(unsigned long start, unsigned long end)
> +{
> +	sync_global_pgds(start, end);
> +}

Why does this need both a pgd and a p4d variant? I don't think it would
be the end of the world to have both {p4d,pgd}_populate_kernel() call
(just picking a random name) arch_sync_kernel_pagetables().

> new file mode 100644
> index 000000000000..072cca766245
> --- /dev/null
> +++ b/include/linux/pgalloc.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PGALLOC_H
> +#define _LINUX_PGALLOC_H
> +#include <asm/pgalloc.h>
> +
> +#ifdef CONFIG_ARCH_USE_SYNC_GLOBAL_PGDS
> +void arch_sync_global_p4ds(unsigned long start, unsigned long end);
> +void arch_sync_global_pgds(unsigned long start, unsigned long end);
> +#else
> +static inline void arch_sync_global_p4ds(unsigned long start, unsigned long end) {}
> +static inline void arch_sync_global_pgds(unsigned long start, unsigned long end) {}
> +#endif
> +
> +static inline void p4d_populate_kernel(unsigned long addr, p4d_t *p4d, pud_t *pud)
> +{
> +	p4d_populate(&init_mm, p4d, pud);
> +	arch_sync_global_p4ds(addr, addr);
> +}
> +
> +static inline void pgd_populate_kernel(unsigned long addr, pgd_t *pgd, p4d_t *p4d)
> +{
> +	pgd_populate(&init_mm, pgd, p4d);
> +	arch_sync_global_pgds(addr, addr);
> +}

So, there's x86 code that calls sync_global_pgds() today. Does that code
just _stay_ there? Isn't it redundant now?

Why does arch_sync_global_pgds() have a start and end if they're always
the same value?

I think this wants to be at *LEAST* four patches:

1. Introduce and use {pgd,p4d}_populate_kernel()
2. Introduce arch_sync_global_*() (with a better name) to those
   functions along with dummy implementations
3. Have x86 define the arch_sync...() function(s)
4. Fix up the x86 code to remove superfluous sync_global_pgds() calls

Also, I see quite a few p*d_populate(&init_mm, ...) calls. Don't those
need to get converted over?

