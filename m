Return-Path: <stable+bounces-197704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DEFC96CD8
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 12:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9AFE4343663
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 11:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A8E302149;
	Mon,  1 Dec 2025 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wkisGbD1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A22C29E0E9
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764587265; cv=none; b=GKXUYs88DXiCf8rIWUXvc05bLnF+roZysDBAN2jyJSkzqepOxqtQhVV7czy7fQ7//FHioSABOD1H6dQQpCVP8HUG4JQ5wvFzme4e2LHhGLp+VGd7Y/czFcnIoKM4ITZjJX2iTFmTCmpz4iSZSiwuuEeULnw4x0+kpeYM9L1eG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764587265; c=relaxed/simple;
	bh=ivsPpTIrmgMxpL4foD/Hw6PuLmzZJ5p/e9U00gE3Pr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoZ+GessiiqYKgot8zoN5g1S8E8k21geXu0Ae6lq3PKCRlP/jMi2/oL7n4Q/5py8LqnI/7oK141C6Mz56DTaIQfqryeY/z+Q7qdgryqeImbiBxZdwj1bHMN/X7wRisS413L9XhIOBikeIlEYMWbLDXxP3B6PYZ510J+Na+TKe/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wkisGbD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6261C4CEF1;
	Mon,  1 Dec 2025 11:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764587265;
	bh=ivsPpTIrmgMxpL4foD/Hw6PuLmzZJ5p/e9U00gE3Pr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wkisGbD1W7yijhxmD+3JOHJUfGFEJUmceW65a03iSk4/FkVrMb5XUlUw2mxlGbrT1
	 WThq7/JfbLt4ywEknqJ+VarV4DXTEamIFJ9jo6kHeI3/M+il0OhV0DsiMvQkGWlpAB
	 1zFCZRgX224iPdp6aAfpoBctLGX/+ueDJS9T1sUM=
Date: Mon, 1 Dec 2025 12:07:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: stable@vger.kernel.org, hbathini@linux.ibm.com, mpe@ellerman.id.au,
	ritesh.list@gmail.com
Subject: Re: [PATCH] powerpc/64s/radix/kfence: map __kfence_pool at page
 granularity
Message-ID: <2025120130-comprised-water-debe@gregkh>
References: <20250910110245.123817-1-aboorvad@linux.ibm.com>
 <149c66a94a28f33330e2016e50e4f3faad4dd59d.camel@linux.ibm.com>
 <dcd1165bab40f31878bb86cd2f582ed950c491ae.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcd1165bab40f31878bb86cd2f582ed950c491ae.camel@linux.ibm.com>

On Mon, Dec 01, 2025 at 04:28:08PM +0530, Aboorva Devarajan wrote:
> On Mon, 2025-09-29 at 07:07 +0530, Aboorva Devarajan wrote:
> > On Wed, 2025-09-10 at 16:32 +0530, Aboorva Devarajan wrote:
> > 
> > 
> > > From: Hari Bathini <hbathini@linux.ibm.com>
> > > 
> > > When KFENCE is enabled, total system memory is mapped at page level
> > > granularity. But in radix MMU mode, ~3GB additional memory is needed
> > > to map 100GB of system memory at page level granularity when compared
> > > to using 2MB direct mapping.This is not desired considering KFENCE is
> > > designed to be enabled in production kernels [1].
> > > 
> > > Mapping only the memory allocated for KFENCE pool at page granularity is
> > > sufficient to enable KFENCE support. So, allocate __kfence_pool during
> > > bootup and map it at page granularity instead of mapping all system
> > > memory at page granularity.
> > > 
> > > Without patch:
> > >   # cat /proc/meminfo
> > >   MemTotal:       101201920 kB
> > > 
> > > With patch:
> > >   # cat /proc/meminfo
> > >   MemTotal:       104483904 kB
> > > 
> > > Note that enabling KFENCE at runtime is disabled for radix MMU for now,
> > > as it depends on the ability to split page table mappings and such APIs
> > > are not currently implemented for radix MMU.
> > > 
> > > All kfence_test.c testcases passed with this patch.
> > > 
> > > [1] https://lore.kernel.org/all/20201103175841.3495947-2-elver@google.com/
> > > 
> > > Fixes: a5edf9815dd7 ("powerpc/64s: Enable KFENCE on book3s64")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> > > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > > Link: https://msgid.link/20240701130021.578240-1-hbathini@linux.ibm.com
> > > 
> > > ---
> > > 
> > > Upstream commit 353d7a84c214 ("powerpc/64s/radix/kfence: map __kfence_pool at page granularity")
> > > 
> > > This has already been merged upstream and is required in stable kernels as well.
> > > 
> > > ---
> > >  arch/powerpc/include/asm/kfence.h        | 11 +++-
> > >  arch/powerpc/mm/book3s64/radix_pgtable.c | 84 ++++++++++++++++++++++--
> > >  arch/powerpc/mm/init-common.c            |  3 +
> > >  3 files changed, 93 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/include/asm/kfence.h b/arch/powerpc/include/asm/kfence.h
> > > index 424ceef82ae615..fab124ada1c7f2 100644
> > > --- a/arch/powerpc/include/asm/kfence.h
> > > +++ b/arch/powerpc/include/asm/kfence.h
> > > @@ -15,10 +15,19 @@
> > >  #define ARCH_FUNC_PREFIX "."
> > >  #endif
> > >  
> > > +#ifdef CONFIG_KFENCE
> > > +extern bool kfence_disabled;
> > > +
> > > +static inline void disable_kfence(void)
> > > +{
> > > +	kfence_disabled = true;
> > > +}
> > > +
> > >  static inline bool arch_kfence_init_pool(void)
> > >  {
> > > -	return true;
> > > +	return !kfence_disabled;
> > >  }
> > > +#endif
> > >  
> > >  #ifdef CONFIG_PPC64
> > >  static inline bool kfence_protect_page(unsigned long addr, bool protect)
> > > diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> > > index 15e88f1439ec20..b0d927009af83c 100644
> > > --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> > > +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/hugetlb.h>
> > >  #include <linux/string_helpers.h>
> > >  #include <linux/memory.h>
> > > +#include <linux/kfence.h>
> > >  
> > >  #include <asm/pgalloc.h>
> > >  #include <asm/mmu_context.h>
> > > @@ -31,6 +32,7 @@
> > >  #include <asm/uaccess.h>
> > >  #include <asm/ultravisor.h>
> > >  #include <asm/set_memory.h>
> > > +#include <asm/kfence.h>
> > >  
> > >  #include <trace/events/thp.h>
> > >  
> > > @@ -293,7 +295,8 @@ static unsigned long next_boundary(unsigned long addr, unsigned long end)
> > >  
> > >  static int __meminit create_physical_mapping(unsigned long start,
> > >  					     unsigned long end,
> > > -					     int nid, pgprot_t _prot)
> > > +					     int nid, pgprot_t _prot,
> > > +					     unsigned long mapping_sz_limit)
> > >  {
> > >  	unsigned long vaddr, addr, mapping_size = 0;
> > >  	bool prev_exec, exec = false;
> > > @@ -301,7 +304,10 @@ static int __meminit create_physical_mapping(unsigned long start,
> > >  	int psize;
> > >  	unsigned long max_mapping_size = memory_block_size;
> > >  
> > > -	if (debug_pagealloc_enabled_or_kfence())
> > > +	if (mapping_sz_limit < max_mapping_size)
> > > +		max_mapping_size = mapping_sz_limit;
> > > +
> > > +	if (debug_pagealloc_enabled())
> > >  		max_mapping_size = PAGE_SIZE;
> > >  
> > >  	start = ALIGN(start, PAGE_SIZE);
> > > @@ -356,8 +362,74 @@ static int __meminit create_physical_mapping(unsigned long start,
> > >  	return 0;
> > >  }
> > >  
> > > +#ifdef CONFIG_KFENCE
> > > +static bool __ro_after_init kfence_early_init = !!CONFIG_KFENCE_SAMPLE_INTERVAL;
> > > +
> > > +static int __init parse_kfence_early_init(char *arg)
> > > +{
> > > +	int val;
> > > +
> > > +	if (get_option(&arg, &val))
> > > +		kfence_early_init = !!val;
> > > +	return 0;
> > > +}
> > > +early_param("kfence.sample_interval", parse_kfence_early_init);
> > > +
> > > +static inline phys_addr_t alloc_kfence_pool(void)
> > > +{
> > > +	phys_addr_t kfence_pool;
> > > +
> > > +	/*
> > > +	 * TODO: Support to enable KFENCE after bootup depends on the ability to
> > > +	 *       split page table mappings. As such support is not currently
> > > +	 *       implemented for radix pagetables, support enabling KFENCE
> > > +	 *       only at system startup for now.
> > > +	 *
> > > +	 *       After support for splitting mappings is available on radix,
> > > +	 *       alloc_kfence_pool() & map_kfence_pool() can be dropped and
> > > +	 *       mapping for __kfence_pool memory can be
> > > +	 *       split during arch_kfence_init_pool().
> > > +	 */
> > > +	if (!kfence_early_init)
> > > +		goto no_kfence;
> > > +
> > > +	kfence_pool = memblock_phys_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
> > > +	if (!kfence_pool)
> > > +		goto no_kfence;
> > > +
> > > +	memblock_mark_nomap(kfence_pool, KFENCE_POOL_SIZE);
> > > +	return kfence_pool;
> > > +
> > > +no_kfence:
> > > +	disable_kfence();
> > > +	return 0;
> > > +}
> > > +
> > > +static inline void map_kfence_pool(phys_addr_t kfence_pool)
> > > +{
> > > +	if (!kfence_pool)
> > > +		return;
> > > +
> > > +	if (create_physical_mapping(kfence_pool, kfence_pool + KFENCE_POOL_SIZE,
> > > +				    -1, PAGE_KERNEL, PAGE_SIZE))
> > > +		goto err;
> > > +
> > > +	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
> > > +	__kfence_pool = __va(kfence_pool);
> > > +	return;
> > > +
> > > +err:
> > > +	memblock_phys_free(kfence_pool, KFENCE_POOL_SIZE);
> > > +	disable_kfence();
> > > +}
> > > +#else
> > > +static inline phys_addr_t alloc_kfence_pool(void) { return 0; }
> > > +static inline void map_kfence_pool(phys_addr_t kfence_pool) { }
> > > +#endif
> > > +
> > >  static void __init radix_init_pgtable(void)
> > >  {
> > > +	phys_addr_t kfence_pool;
> > >  	unsigned long rts_field;
> > >  	phys_addr_t start, end;
> > >  	u64 i;
> > > @@ -365,6 +437,8 @@ static void __init radix_init_pgtable(void)
> > >  	/* We don't support slb for radix */
> > >  	slb_set_size(0);
> > >  
> > > +	kfence_pool = alloc_kfence_pool();
> > > +
> > >  	/*
> > >  	 * Create the linear mapping
> > >  	 */
> > > @@ -381,9 +455,11 @@ static void __init radix_init_pgtable(void)
> > >  		}
> > >  
> > >  		WARN_ON(create_physical_mapping(start, end,
> > > -						-1, PAGE_KERNEL));
> > > +						-1, PAGE_KERNEL, ~0UL));
> > >  	}
> > >  
> > > +	map_kfence_pool(kfence_pool);
> > > +
> > >  	if (!cpu_has_feature(CPU_FTR_HVMODE) &&
> > >  			cpu_has_feature(CPU_FTR_P9_RADIX_PREFETCH_BUG)) {
> > >  		/*
> > > @@ -875,7 +951,7 @@ int __meminit radix__create_section_mapping(unsigned long start,
> > >  	}
> > >  
> > >  	return create_physical_mapping(__pa(start), __pa(end),
> > > -				       nid, prot);
> > > +				       nid, prot, ~0UL);
> > >  }
> > >  
> > >  int __meminit radix__remove_section_mapping(unsigned long start, unsigned long end)
> > > diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
> > > index d3a7726ecf512c..21131b96d20901 100644
> > > --- a/arch/powerpc/mm/init-common.c
> > > +++ b/arch/powerpc/mm/init-common.c
> > > @@ -31,6 +31,9 @@ EXPORT_SYMBOL_GPL(kernstart_virt_addr);
> > >  
> > >  bool disable_kuep = !IS_ENABLED(CONFIG_PPC_KUEP);
> > >  bool disable_kuap = !IS_ENABLED(CONFIG_PPC_KUAP);
> > > +#ifdef CONFIG_KFENCE
> > > +bool __ro_after_init kfence_disabled;
> > > +#endif
> > >  
> > >  static int __init parse_nosmep(char *p)
> > >  {
> > 
> > 
> > Hi,
> > 
> > Just a gentle reminder, this patch is required in the stable kernels.
> > 
> > Please let me know if there are any comments.
> > 
> > Thanks,
> > Aboorva
> 
> 
> 
> CC'ing Greg to check whether this patch can be backported to the stable
> kernels.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

