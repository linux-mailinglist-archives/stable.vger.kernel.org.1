Return-Path: <stable+bounces-179086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B126CB4FE2D
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 15:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B19D1885FD7
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F40532A3D8;
	Tue,  9 Sep 2025 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gWE2zF72"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA792F747B
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425938; cv=none; b=f1Y72xprjep+2Gcx32sjuwdOc59onFB4+fxD4aS2kAWIlJAYPmdxvX974kUj1jJjCxi9WY8rFaIKhdkOxnoPIKwwlfXOFbrqIlJyS3V6og9h2JJMhrw1ybPUqr+RmUJbnQEZhsGijS6DowUWf+UJVZSkcDSW3dL3kkkCd7+kXDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425938; c=relaxed/simple;
	bh=ij0WgQZ59KsrB/QDwB5NjaceRRLyZemaLmUcf2WThCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOGXqPTzeCP76q3q1b48g4kDrstlVlZjLw078vJitRE8oGA5b32TepJbhI2ZPrAoXgMGavlj9xz0gIid1x+3q1lPE0heizuFHCcI4DRmU4focsCj/uEzqywcwO30N2NDLS6qvrRzpdE8kQVJtiDvMwn/0A4CiS+a9j89+e5Oyks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gWE2zF72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D5BC4CEF4;
	Tue,  9 Sep 2025 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757425938;
	bh=ij0WgQZ59KsrB/QDwB5NjaceRRLyZemaLmUcf2WThCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWE2zF72GEeCbH4wrG3rt2k3EurVff/96CbyT7Jp8jo9y+EREPBqywWPMXepEpJT7
	 tB8vssJarcNmPXtEtTb5VgfMEGofis14WR2gwoWOe/rkV8BsQgZ8Sn1GxPkdllWGXJ
	 XEVoopzyJvy60jJnl7UdgpTsoE/S2bkShU5vescs=
Date: Tue, 9 Sep 2025 15:52:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Kiryl Shutsemau <kas@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	bibo mao <maobibo@loongson.cn>, Borislav Betkov <bp@alien8.de>,
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
	Dev Jain <dev.jain@arm.com>, Dmitriy Vyukov <dvyukov@google.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Ingo Molnar <mingo@redhat.com>, Jane Chu <jane.chu@oracle.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Joerg Roedel <joro@8bytes.org>, John Hubbard <jhubbard@nvidia.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Thomas Huth <thuth@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>, Pedro Falcato <pfalcato@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V2 6.12.y] mm: introduce and use
 {pgd,p4d}_populate_kernel()
Message-ID: <2025090947-everglade-hassle-bcbc@gregkh>
References: <2025090602-bullwhip-runner-63fe@gregkh>
 <20250909055432.7584-1-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909055432.7584-1-harry.yoo@oracle.com>

On Tue, Sep 09, 2025 at 02:54:32PM +0900, Harry Yoo wrote:
> Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
> populating PGD and P4D entries for the kernel address space.  These
> helpers ensure proper synchronization of page tables when updating the
> kernel portion of top-level page tables.
> 
> Until now, the kernel has relied on each architecture to handle
> synchronization of top-level page tables in an ad-hoc manner.  For
> example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for direct
> mapping and vmemmap mapping changes").
> 
> However, this approach has proven fragile for following reasons:
> 
>   1) It is easy to forget to perform the necessary page table
>      synchronization when introducing new changes.
>      For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
>      savings for compound devmaps") overlooked the need to synchronize
>      page tables for the vmemmap area.
> 
>   2) It is also easy to overlook that the vmemmap and direct mapping areas
>      must not be accessed before explicit page table synchronization.
>      For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
>      sub-pmd ranges")) caused crashes by accessing the vmemmap area
>      before calling sync_global_pgds().
> 
> To address this, as suggested by Dave Hansen, introduce _kernel() variants
> of the page table population helpers, which invoke architecture-specific
> hooks to properly synchronize page tables.  These are introduced in a new
> header file, include/linux/pgalloc.h, so they can be called from common
> code.
> 
> They reuse existing infrastructure for vmalloc and ioremap.
> Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
> and the actual synchronization is performed by
> arch_sync_kernel_mappings().
> 
> This change currently targets only x86_64, so only PGD and P4D level
> helpers are introduced.  Currently, these helpers are no-ops since no
> architecture sets PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.
> 
> In theory, PUD and PMD level helpers can be added later if needed by other
> architectures.  For now, 32-bit architectures (x86-32 and arm) only handle
> PGTBL_PMD_MODIFIED, so p*d_populate_kernel() will never affect them unless
> we introduce a PMD level helper.
> 
> [harry.yoo@oracle.com: fix KASAN build error due to p*d_populate_kernel()]
> Link: https://lkml.kernel.org/r/20250822020727.202749-1-harry.yoo@oracle.com
> Link: https://lkml.kernel.org/r/20250818020206.4517-3-harry.yoo@oracle.com
> Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Kiryl Shutsemau <kas@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: bibo mao <maobibo@loongson.cn>
> Cc: Borislav Betkov <bp@alien8.de>
> Cc: Christoph Lameter (Ampere) <cl@gentwo.org>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Dmitriy Vyukov <dvyukov@google.com>
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jane Chu <jane.chu@oracle.com>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Thomas Gleinxer <tglx@linutronix.de>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> [ Adjust context ]
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  include/linux/pgalloc.h | 29 +++++++++++++++++++++++++++++
>  include/linux/pgtable.h | 13 +++++++------
>  mm/kasan/init.c         | 12 ++++++------
>  mm/percpu.c             |  6 +++---
>  mm/sparse-vmemmap.c     |  6 +++---
>  5 files changed, 48 insertions(+), 18 deletions(-)
>  create mode 100644 include/linux/pgalloc.h

Can you resend these with the upstream git id from Linus's tree in it,
so we know how to compare it with the original?

thanks,

greg k-h

