Return-Path: <stable+bounces-189246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10511C07BF2
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 20:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE20A3A2B99
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17B72638B2;
	Fri, 24 Oct 2025 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qDPsnq/4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0382AE90
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330175; cv=none; b=ep7q1Vi0OZmG0UFPJg35Sp7WaS+bFGKTQih05raFCtBBABFzqW5LojMom4ysYEqNrPx8csqw0OJfPvwPxB2pjZpgnnGqlhqb7ffMOFiJBbjh47zUwvqwJ2eZjAOcWBxjf4pccH/nEw2ef5DRVs/yadwXL+ir7xXRfV8af+ZsnnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330175; c=relaxed/simple;
	bh=45Glqcg0Gem2buj0wbJpYwnV1KF+cWqGHfkH8qGnEIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAnGouvN586qwQUCBHVP61g6SRu+g5GaPIDdaIF1pKnmcqJtGZR4w6bET9XPVKesK++egMjITaPTMlFCxXu02E2LgTX73DvhFfWmQ8RmNAXJhT6ZWhml4VWm69ZCgQez9Xk2hxxg2Vsv2GCdLDKtg0p7QIhAOfGiNyCAkK06YaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qDPsnq/4; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c167b70f9so1307a12.0
        for <stable@vger.kernel.org>; Fri, 24 Oct 2025 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761330172; x=1761934972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45Glqcg0Gem2buj0wbJpYwnV1KF+cWqGHfkH8qGnEIw=;
        b=qDPsnq/4hBYF1PSnptCJpkwklVEhfgyQTe0RBWzsux8snIxcXfBSasOlmd5s3UILhr
         qklnz3gTp8BY0iP54u5UDCEcyhdoTcG96sg55IDtKUAO0E0vWQsp1FFxMojoh9SG05up
         DezKw9u3SInWZjyX7cK7UiCE23UL1ZB8eahNmblyc4H6DAbcQXH+fCeUG+WKEujRwEys
         tpupM5DQnG3++4cxx79/gBicKw2NK/qMfWOk+6nbYld0VvQS415Zfh7V/ZY0UR2TNyWG
         3hrlaNnaYTjq0GOqhAIlaU3JXjGR2TQp8WR7TYcO5m3vuMk+s5sGpgf1jh4zYGEMpN7W
         Tmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761330172; x=1761934972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45Glqcg0Gem2buj0wbJpYwnV1KF+cWqGHfkH8qGnEIw=;
        b=bVxZQziGlR5Ux5s3aUr4pynAdpts+jvncncmAgidXgkyJHHyfY6halTL7YK7sWbjhJ
         EeDoLCmgyJ+dcKiqi4iNyEh/GnTxzsSBbzYzKgOdBxagZb8UNJt3GwR9qJ7Xl6p4gij7
         CzgjGj6TNhHDltxJb/+HOghH6GpcIVYFQldT+h2i8OfSUaGC4DdorNWDujNJRas1vWUZ
         ebUJxON3tObOyeTBWGxUc/zftmavZwE4oC7tHBMXMWAgiNrhtRUcJPzZ2WKslgfXGX1J
         6Ljw0zzWAe49eNYm1RYDuOxJmlDMokcv3VIyGoUWtkvQUMp69IBB9Sr4jClDa3THg11R
         gcXg==
X-Forwarded-Encrypted: i=1; AJvYcCVuNbxuMPs7Kk9f6tiV+cZTtUIiz12IKXQ1Qf5+BaaUK1efxQDj7SShpfRIG3pHZ+ttacrVDIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTTAe45nRfWrYWGCVPc3w6UxWXEFfknu3/LJWldi18TxGz5sco
	jy4Y8xanR+mfi8h8uCIzgjcatLtsYQej/K7buVCy0HvTmaV2KuI7ziR3bcXrFdheeP/0EV2KJ69
	UGnxnfu1L8ojlfqOUHYWvbPd5Wq1HEunO+uPo88gQ
X-Gm-Gg: ASbGncsx63I9F4Y+AvnWITFMTV/+5B2f2JqHSE8dcVvEZ/PwswpME3WADBDptvwySaR
	wfyGhN39Iq0qLmyAle4Quw60PRK70R3bzqCrH2DCvfNFpEGO1yRnOM7wnUQ0E7hBf1v5+3k2say
	HRefB80xIomx3EOEjOBNAPsaGIw9PtGVnMxHpxtQGYcnM8Du4M949JpOYxqMx6Ev8YGiIvttBmT
	MgwPKkflcK/t8wLsL8+AqqlcsnJEGfwYBaKepHHUH5cqcl5W6X69+Ai8eUQCXBWk8cbf6RCMMxK
	O5bQzz+bfhknI/WOD8+2lOQOFgKiy0wySqY=
X-Google-Smtp-Source: AGHT+IF72XD6SS5uDBKsgbfB0n3K/IVSTeCBW002wjaTSguk72ryj0OlbZfGYhZoZqQsDkeyA4MwnU2ur7strGUV+P0=
X-Received: by 2002:a05:6402:304d:10b0:62f:c78f:d0d4 with SMTP id
 4fb4d7f45d1cf-63e7c419587mr8272a12.6.1761330171855; Fri, 24 Oct 2025 11:22:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de> <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com> <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
 <81d096fb-f2c2-4b26-ab1b-486001ee2cac@lucifer.local> <CAG48ez3paQTctuAO1bXWarzvRK33kyLjHbQ6zsQLTWya8Y1=dQ@mail.gmail.com>
 <a317657d-5c4a-4291-9b53-4435012bd590@lucifer.local>
In-Reply-To: <a317657d-5c4a-4291-9b53-4435012bd590@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Fri, 24 Oct 2025 20:22:15 +0200
X-Gm-Features: AWmQ_bkmWlnCuKy5iWPqVB59F3jAKLbUke72jlVyJisSwjfh1b1sb1NWw36vd2g
Message-ID: <CAG48ez0ubDysSygbKjUvjR2JU6_UmFJzzXtQfk0=zQeGMPwDEA@mail.gmail.com>
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, "Uschakow, Stanislav" <suschako@amazon.de>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "trix@redhat.com" <trix@redhat.com>, 
	"ndesaulniers@google.com" <ndesaulniers@google.com>, "nathan@kernel.org" <nathan@kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "muchun.song@linux.dev" <muchun.song@linux.dev>, 
	"mike.kravetz@oracle.com" <mike.kravetz@oracle.com>, 
	"liam.howlett@oracle.com" <liam.howlett@oracle.com>, "osalvador@suse.de" <osalvador@suse.de>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:25=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Oct 20, 2025 at 05:33:22PM +0200, Jann Horn wrote:
> > On Mon, Oct 20, 2025 at 5:01=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > On Thu, Oct 16, 2025 at 08:44:57PM +0200, Jann Horn wrote:
> > > > 4. Then P1 splits the hugetlb VMA in the middle (at a 2M boundary),
> > > > leaving two VMAs VMA1 and VMA2.
> > > > 5. P1 unmaps VMA1, and creates a new VMA (VMA3) in its place, for
> > > > example an anonymous private VMA.
> > >
> > > Hmm, can it though?
> > >
> > > P1 mmap write lock will be held, and VMA lock will be held too for VM=
A1,
> > >
> > > In vms_complete_munmap_vmas(), vms_clear_ptes() will stall on tlb_fin=
ish_mmu()
> > > for IPI-synced architectures, and in that case the unmap won't finish=
 and the
> > > mmap write lock won't be released so nobody an map a new VMA yet can =
they?
> >
> > Yeah, I think it can't happen on configurations that always use IPI
> > for TLB synchronization. My patch also doesn't change anything on
> > those architectures - tlb_remove_table_sync_one() is a no-op on
> > architectures without CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>
> Hmm but in that case wouldn't:
>
> tlb_finish_mmu()
> -> tlb_flush_mmu()
> -> tlb_flush_mmu_free()
> -> tlb_table_flush()

And then from there we call tlb_remove_table_free(), which does a
call_rcu() to tlb_remove_table_rcu(), which will asynchronously run
later and do __tlb_remove_table_free(), which does
__tlb_remove_table()?

> -> tlb_remove_table()

I don't see any way we end up in tlb_remove_table() from here.
tlb_remove_table() is a much higher-level function, we end up there
from something like pte_free_tlb(). I think you mixed up
tlb_remove_table_free and tlb_remove_table.

> -> __tlb_remove_table_one()

Heh, I think you made the same mistake as Linus made years ago when he
was looking at tlb_remove_table(). In that function, the call to
tlb_remove_table_one() leading to __tlb_remove_table_one() **is a
slowpath only taken when memory allocation fails** - it's a fallback
from the normal path that queues up batch items in (*batch)->tables[]
(and occasionally calls tlb_table_flush() when it runs out of space in
there).

> -> tlb_remove_table_sync_one()
>
> prevent the unmapping on non-IPI architectures, thereby mitigating the
> issue?

> Also doesn't CONFIG_MMU_GATHER_RCU_TABLE_FREE imply that RCU is being use=
d
> for page table teardown whose grace period would be disallowed until
> gup_fast() finishes and therefore that also mitigate?

I'm not sure I understand your point. CONFIG_MMU_GATHER_RCU_TABLE_FREE
implies that "Semi RCU" is used to protect page table *freeing*, but
page table freeing is irrelevant to this bug, and there is no RCU
delay involved in dropping a reference on a shared hugetlb page table.
"Semi RCU" is not used to protect against page table *reuse* at a
different address by THP. Also, as explained in the big comment block
in m/mmu_gather.c, "Semi RCU" doesn't mean RCU is definitely used -
when memory allocations fail, the __tlb_remove_table_one() fallback
path, when used on !PT_RECLAIM, will fall back to an IPI broadcast
followed by directly freeing the page table. RCU is just used as the
more polite way to do something equivalent to an IPI broadcast (RCU
will wait for other cores to go through regions where they _could_
receive an IPI as part of RCU-sched).

But also: At which point would you expect any page table to actually
be freed, triggering any of this logic? When unmapping VMA1 in step 5,
I think there might not be any page tables that exist and are fully
covered by VMA1 (or its adjacent free space, if there is any) so that
they are eligible to be freed.

> Why is a tlb_remove_table_sync_one() needed in huge_pmd_unshare()?

Because nothing else on that path is guaranteed to send any IPIs
before the page table becomes reusable in another process.

