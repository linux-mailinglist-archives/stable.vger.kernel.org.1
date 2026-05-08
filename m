Return-Path: <stable+bounces-244720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JA1Hpys/WlOhgAAu9opvQ
	(envelope-from <stable+bounces-244720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:27:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FB44F43FE
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99517301A3B8
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 09:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0B43A3807;
	Fri,  8 May 2026 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="orMMXEIR"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB39282F23;
	Fri,  8 May 2026 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232373; cv=none; b=ioyOKkQYhaAzYJQ3mjwJEhMtnZbansk8Hvm8YNR7jXxVAE5lCT8l7oQc1g8chZDLEdXVUXn4+BUXosj7bvTIlYC3YZfnxDW0WVMUQqGf4/iEz0wnVc1C/V0fGhnihTD0yWzV/M+3uVK/NkfmQO8ooLiwrb+dINOPiLzCny3SqBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232373; c=relaxed/simple;
	bh=vKtZPYZy5mDRJrTc0HMiaqrNFWzK5E15tucVq04mSsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzLPnSwhVEFvb812RWJl0amklYSf2R/jx2p7hBuiETi55tb2XTsOlJKwit3NJb8nCgjdzJcW+/gEsxCQHQfdG/EHlHkzCh9ZJNAXQwAHqCve2xhxei3K7lT2dY4sOltLEsexuTWRCaNGPhuMr/pUhg8rMB7GyHUHBbO3RiwTaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=orMMXEIR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NEJWTFcrhwXUCuH7FCKk5xX/jw6eM+HVoJCnUbbErK4=; b=orMMXEIRHSjQfNSsW94x1FUSHl
	3U7rXixUWgG7duBeYeQ5RhQpH9yPmmyj3ey8zfwhxwQiUfqIN3Rse1Fvk+AYJsPFsXSEXs35e+ysj
	FWJJ3mBeOTeKuNxa0kari632HPbDMOnLC/KplX30DFy/MnymExu9ekBpegmdEOqURQ1Ypi6opkFa8
	6wuH4hCXUsPfh9WplsdiSg+g+9uVL7ihKbgf/OrZDFVGvcR3+WJWCe+ThJ3/GlH+tGGM763i1uVvX
	S5KTI8T04i/7k62EfoBQYa2TbEep1/g4hNBbPJl9NpECSBPWuVBoy4TfalMU3KvtUK0tNxHkAzUqD
	npUCz3Cw==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLHR1-000000040qm-3OIc;
	Fri, 08 May 2026 09:24:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8B611301C52; Fri, 08 May 2026 11:23:41 +0200 (CEST)
Date: Fri, 8 May 2026 11:23:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/mm: fix freeing of PMD-sized vmemmap pages
Message-ID: <20260508092341.GP3126523@noisy.programming.kicks-ass.net>
References: <20260429-vmemmap-v2-1-8dfcacffd877@kernel.org>
 <0c20d1e6-1a39-42c5-8c94-9bd2222fb6b3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c20d1e6-1a39-42c5-8c94-9bd2222fb6b3@kernel.org>
X-Rspamd-Queue-Id: D2FB44F43FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244720-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,linux.dev:email,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 11:19:26AM +0200, David Hildenbrand (Arm) wrote:
> On 4/29/26 12:49, David Hildenbrand (Arm) wrote:
> > In commit bf9e4e30f353 ("x86/mm: use pagetable_free()"), we switched
> > from freeing non-boot page tables through __free_pages() to
> > pagetable_free().
> > 
> > However, the function is also called to free vmemmap pages.
> > 
> > Given that vmemmap pages are not page tables, already the page_ptdesc(page)
> > is wrong. But worse, pagetable_free() calls
> > 
> > 	__free_pages(page, compound_order(page));
> > 
> > As vmemmap pages are not compound pages (see vmemmap_alloc_block()) --
> > except for HVO, which doesn't apply here -- we will only free the first
> > page when freeing a PMD-sized vmemmap page, leaking the other ones.
> > 
> > Fix it by properly decoupling pagetable and vmemmap freeing.
> > free_pagetable() no longer has to mess with SECTION_INFO, as only the
> > vmemmap is marked like that in register_page_bootmem_memmap().
> > 
> > The indentation in remove_pmd_table() is messed up, let's fix that
> > while touching it.
> > 
> > Note that we'll try to get rid of that bootmem info handling soon. For
> > now, we'll handle it similar to free_pagetable(), just avoiding the
> > ifdef.
> > 
> > Tested-by: Lance Yang <lance.yang@linux.dev>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Fixes: bf9e4e30f353 ("x86/mm: use pagetable_free()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > ---
> > Reproduced and tested with a simple VM with a virtio-mem device,
> > repeatedly adding and removing memory.
> > 
> > Found by code inspection while working on bootmem_info removal.
> > ---
> 
> @x86 maintainers, do you want to take this through your tree or should we merge
> this through the MM tree?
> 
> I have another MM series coming up that will touch this code (no fixes, though).

I'm thinking this should go in rather more urgent, yes?

It looks good to me, Dave you want to stick this in x86/urgent?

