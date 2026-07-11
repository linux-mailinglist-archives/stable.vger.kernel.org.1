Return-Path: <stable+bounces-273376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EsmuLIr+UWqSLAMAu9opvQ
	(envelope-from <stable+bounces-273376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 10:27:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EC0740E69
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 10:27:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZmJcywno;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273376-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273376-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6D7F3018AE6
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E1B32861E;
	Sat, 11 Jul 2026 08:27:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571B24336D;
	Sat, 11 Jul 2026 08:27:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783758467; cv=none; b=sEyvisr1+i4d41OpVkGA4hyjQZ7Rgx4bJkGc7Y73QY1X01CeuEm2u1N8D/0e3QZ1h0Zq6oJB3WdlcyScjmF7Ar3vE5j6CFHCbV4BeAy+eMIqZZ0EEY6I41o9fOJp4x36q0zYeeOhQDd3clwIj1XB/A9BdAHDEjzxh1R1BPP8Wb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783758467; c=relaxed/simple;
	bh=Sh0BG3OaVGa+q2GPtfq3zxIc9aKKQrT95SBJzzgDxaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIsE05BSWKzkG1j/7SOlj9sDBHy5bX+g4OoaETirANzdjbNbfat40EMvqgrHQeJpk+bmFoLARzUoixO52CjniInn0PSTxEODRzcRhX+FEJbK3NBesMgrfoKRwUb22k23sJAApAefCczJztZTkX0z/Yi/5kWTu+Fw1oiq0qcz+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmJcywno; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AA81F00A3D;
	Sat, 11 Jul 2026 08:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783758465;
	bh=o+9YUEALLTL+0259dlnNxroPvNI9JdmPox5B/61vnaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZmJcywnoP8pPUDaImC5Qgcr5kg1sl/cTQdYsbPJKkAaHXp6XTAodQLk25zI+RO+E6
	 vlVmvzA8B51o5fWTM6JdeeUL+Xfa/Pzo8JNGor0Rtswishsat7zGPuRwOM8FBSzsiw
	 JlqJRXxL6R/nzkixHrrVUf7/Uzkc2Xjw+6JIp7obqP9nVuhOnjahos/YYoSJc6EgU1
	 k1x1QFlXGk4pOumZZpLv/4Tql4QK4/6sN5TJcXixaLH+zP/PKTf8vKR8bTq2jUU/s9
	 C5y2Xkvg1AQdWKQLXYIFaHwKaPOFVU8foh2ckIST4j6o+HWI2vh5P/wM+2vdKMVsr7
	 ToCVy8ckpgvFQ==
Date: Sat, 11 Jul 2026 09:27:32 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Carlier <devnexen@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Subject: Re: [PATCH] x86/mm/pat: acquire mmap lock on page table free to
 avoid ptdump UAF
Message-ID: <alH8fAnP1JlevCPU@lucifer>
References: <20260710-fix-cpa-ptdump-race-v1-1-d898699a7417@kernel.org>
 <529e37eb-ad4c-4b0f-8ba3-c5608aa7a893@intel.com>
 <alE6fUJZzELlUfxP@lucifer>
 <f2af8fae-62b8-4c5a-8f8d-594b93912dc0@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2af8fae-62b8-4c5a-8f8d-594b93912dc0@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@intel.com,m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:rppt@kernel.org,m:kas@kernel.org,m:akpm@linux-foundation.org,m:devnexen@gmail.com,m:vbabka@kernel.org,m:david@kernel.org,m:liam@infradead.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:stable@vger.kernel.org,m:jackmanb@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273376-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,infradead.org,redhat.com,alien8.de,zytor.com,linux-foundation.org,gmail.com,kvack.org,vger.kernel.org,google.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lucifer:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07EC0740E69

+cc Brendan for fun's sake ;)

On Fri, Jul 10, 2026 at 12:50:26PM -0700, Dave Hansen wrote:
> On 7/10/26 11:53, Lorenzo Stoakes wrote:
> > On Fri, Jul 10, 2026 at 09:26:48AM -0700, Dave Hansen wrote:
> >> 1. We could just bite the bullet and have separate ptdump files for the
> >>    top and bottom of the address space:
> >> 	current_kernel_top
> >> 	current_kernel_bottom
> >> 	current_user_top
> >> 	current_user_bottom
> >> 	etc..
> >>    Then the lock you take is dictated by the file.
> >
> > I mean that'd break userspace though wouldn't it?
>
> It's debugfs. So, yeah, I can see it breaking things, but it's also way
> less of a concern. Nobody ever complained about the new PTI file getting
> added in there.

I wonder how many people use this :P but I expect some do and would moan about a
_removal_.

I guess we could have a warning if somebody used it.

>
> >> 2. We could always take both init_mm and current->mm locks. That seems
> >>    icky.
> >
> > It's actually the least awful of all of these I think :) and the one I
> > implemented ([0]).
>
> Oh, cool, I missed that. That's a good pairing with this one!

Yeah, sent it separately as they stand separately and this already addresses the
init_mm side of it anyway.

>
> >> 3. We could have ptdump_walk_pgd() take a different lock for each
> >>    'range'. Logically:
> >>
> >> 	if (range->start < PAGE_OFFSET)
> >> 		mmap_write_lock(mm);
> >> 	else
> >> 		mmap_write_lock(&init_mm);
> >
> > I don't love this. It feels a hack for x86 that's put in the wrong place,
> > i.e. core code.
> >
> > And can you can make this assumption for efi_mm for all arches? Could other
> > arches might be weird about this?
>
> Yeah, it's possible they're weird. But I thought the whole idea of
> efi_mm was to reuse the non-kernel part of the address space. So oddly
> enough it kinda makes sense.
>
> But, yeah, I totally get the reluctance to do this.

Yeah it's all a bit sucky this :(

>
> >> I'm kinda leaning toward #3.
> >
> > Another way forwards might be simply have the caller _call
> > ptdump_walk_pgd() twice_ once with the range set to [0, PAGE_OFFSET) passing whatever mm
> > != init_mm, and again for [PAGE_OFFSET, ~0) passing init_mm?
>
> Ahh, yeah, that's a good point. It could be done a layer up too.
>
> > Are there cases where you expect to see a delta in the kernel range in x86
> > for an arbitrary mm?
>
> Are you asking if current->mm->pgd[255->511] is always the same as
> init_mm->pgd[255->511]?

Yes :)

>
> I think so, except for the LDT PGD when PTI is on. That can be different
> between mms, and it's a single pgd_t entry. I think Brendan had some
> grand plans to use this PGD for other things for ASI as well.

Yeah I wondered if PTI or something else funky (Brendan's mermap?) might have
changed this.

But whether that'd actually be accessible from the debugfs "this mm's "?

>
> So, yeah, the upper half of the address space is *normally* identical.
> But PTI plus set_ldt() is abnormal and we have to deal with it. The only
> times that code frees page tables is at exit time and in an error path.
>
> So, how does this interact with mmap_lock? Surely, someone looked at
> this recently because the comment says:
>
>  * Lock order:
>  *      context.ldt_usr_sem
>  *        mmap_lock
>  *          context.lock
>
> and not mmap_sem. But, alas, I don't see any mmap_lock anywhere. Someone
> changed the comment and didn't look at the code.

Was a simple mmap_sem -> mmap_lock change since we renamed the lock right?

>
> Is there some mmap_lock interaction that I'm missing? I don't see it
> _anywhere_ in the ldt code.

Presumably dup_mmap() -> arch_dup_mmap() -> ldt_dup_context()?

But I don't think that interacts with the init_mm nested lock stuff we're
looking at here, as it's not touching init_mm and in any case ptdump is
unconditionally taking the mm's mmap write lock as-is without issue.

Cheers, Lorenzo

