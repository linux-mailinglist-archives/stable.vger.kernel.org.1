Return-Path: <stable+bounces-189250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04709C07F2B
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 21:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FEE74F032E
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 19:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1392D593A;
	Fri, 24 Oct 2025 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4eOtZbsI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839382C0267
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761335064; cv=none; b=Qr5l5EQC2zbS/fmR66ih6yoWOq/8Y6H59XSj2oy+yxBg8tL27dTeVvVBed7J8mj4iR4/H8tdPLHH9qV9x+3mqOjIaV7cU/Flzm4eixiIaG9aZTd6hO6OHLAmNxxrECHTJFlijy+MygksBGUN5LF7JZUc8Zp2uzHNfqP5dVCeJVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761335064; c=relaxed/simple;
	bh=mXiFPKytEiBqow06N6RGaTEl9sQEa/3JM2NLiXZAKic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BE+JaeAlHHCH1wfpgWomzoXmQFfdSnOo8v1d6UIaa8o00WTVVK1KCRvkmr+kz8LmHBlsy5b65oUplVRlLEImoP5VoORPbOk4p5XAFMe1mOIMdbTeoqTwOlu+E8LC77wuhxQdHOLeQ6QqUacxmcRtkjtW4mPfz/mC7RCy4Ad2oN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4eOtZbsI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c167b70f9so2137a12.0
        for <stable@vger.kernel.org>; Fri, 24 Oct 2025 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761335060; x=1761939860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uw5I3FN5HPdWCH+kw4HXhTBJbOkPUzlIALsUJzcD18w=;
        b=4eOtZbsIYlR0mVUyrlHevZfr4zhLC9gTvMBxJJbuOBbg4IUM3w+d5tmBkJPL+5PJj+
         zqTnyBaqNjOTfrODK1nwOVDIkbOgN7b5j2Q9orZV1nHuwqggmT+lmCmnijwlbtzjcWOA
         gAXixgD5ErORHn369EfvjbPUFE2pj6gtyxFqrJF29f2Q6zK+Ss8FZEJEdnoQ21UIRDMI
         y4PfE4sOiqsH9SO29JMYgG03013azwyyRlddCbaNFVDH6IVor1GfYOIl2p6JHasO5h9S
         u5BZXYe/l3/IqvzG6cWJXdXwVnV+D4/0YxBv/zQoNaXFjU1G+RfHye8t/SNxEWUFtllF
         OXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761335060; x=1761939860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uw5I3FN5HPdWCH+kw4HXhTBJbOkPUzlIALsUJzcD18w=;
        b=iFZcx7+6Rgs1JXplgYdFOaIi8HGK7ekMKb9p7i1T5wsso4fX22kYf5RfIpzIPi10Rx
         0GBd38824gmtQIGhnJo3pQj1el6DDa6HY2v0789bSR4Hg1VfJ1j1WR/Gb1iX0penI0ek
         MvPyrj5ob5kl42TAhvNIHVogwFr7SyVCizVQbmSUoKknje52IiOLbR2ZdfumIdUcmJ1t
         5bDlFB0R640eapjeIX+oEjQdPHK7QJ7YA7vUyWkQDNKpjFzvgjmTcJU+FcR9sByWf0yz
         0aKmWbgU8wXxsReUEch0c1OvOjCcU1ubP9nphgbJ0Y/Iyx3ZPIgohvwNFpNJ48U8kui4
         xZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlxp/7aBmXDns58N642B+oB6mKm/AfBD7kUAG08EWJp5mTWQ1wHr+VUqx2GmpqWdMEvP9iujA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcAkXw5EwqExpfx83hkkw6Rfxrqxm79Kj7NiSV+CqlmuCt8uOH
	eYlymf/XZfbqfY781KCvzbENJ7k+qAoGuBDewhiloaqE0xMqdNjh/Tg7eVeYqk8LhmfFrT/tndE
	CIQea0t5EJdUX1bPkuyyXbVl6g4cw7EuU/ADDhL0t
X-Gm-Gg: ASbGncvACkHT8P4fcZHlmRWCxSUHMD77h+zqdYKH90KZnue1D2cztdNMDmzazskho0r
	emJmzkwro8BxJoBgm8jzRn+iwyWJaFqy0qIbjyJamw78ARNsOLqSJhwhD6o2XB1WxL+6WUuw7mF
	WkseGWS6AtxMsdrE3yXCXKxKT7DcwgwGAjLNJn24t/7QNk3Osy3qVYd1J3jp60fiHM0O5OiF6LE
	ej4seT68Tt8gvpB3sjAZoADoRiVLMVdTN+OokfXOMVdx0eTCn0XrKCzD//wKwK3s1R2hreGl7jJ
	6GYM7OfFlP+BSV3/vxknaxJR
X-Google-Smtp-Source: AGHT+IHCNsofhlZWyDZa+5NEp4uVpox/B6YiZvZDkNFcbiIwirJ6KYLEknTw+UtD6cubS3KstakCEtOtMgZxqeC9RHE=
X-Received: by 2002:aa7:c88f:0:b0:639:da2b:69de with SMTP id
 4fb4d7f45d1cf-63e7c52dd7fmr16394a12.3.1761335059448; Fri, 24 Oct 2025
 12:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de> <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com> <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
 <81d096fb-f2c2-4b26-ab1b-486001ee2cac@lucifer.local> <CAG48ez3paQTctuAO1bXWarzvRK33kyLjHbQ6zsQLTWya8Y1=dQ@mail.gmail.com>
 <a317657d-5c4a-4291-9b53-4435012bd590@lucifer.local> <CAG48ez0ubDysSygbKjUvjR2JU6_UmFJzzXtQfk0=zQeGMPwDEA@mail.gmail.com>
 <4ebbd082-86e3-4b86-bb01-6325f300fc9c@lucifer.local>
In-Reply-To: <4ebbd082-86e3-4b86-bb01-6325f300fc9c@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Fri, 24 Oct 2025 21:43:43 +0200
X-Gm-Features: AWmQ_bkrkShnyXJyY90tkGWisY_qpMhXX7o1WPNKUw7z9NVNM7QB0SFE0mziuUY
Message-ID: <CAG48ez1JEerijaUxDRad6RkVm3TLm8bSuWGxQYs+fc_rsJDpAQ@mail.gmail.com>
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

On Fri, Oct 24, 2025 at 9:03=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Fri, Oct 24, 2025 at 08:22:15PM +0200, Jann Horn wrote:
> > On Fri, Oct 24, 2025 at 2:25=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Mon, Oct 20, 2025 at 05:33:22PM +0200, Jann Horn wrote:
> > > > On Mon, Oct 20, 2025 at 5:01=E2=80=AFPM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > On Thu, Oct 16, 2025 at 08:44:57PM +0200, Jann Horn wrote:
> > > > > > 4. Then P1 splits the hugetlb VMA in the middle (at a 2M bounda=
ry),
> > > > > > leaving two VMAs VMA1 and VMA2.
> > > > > > 5. P1 unmaps VMA1, and creates a new VMA (VMA3) in its place, f=
or
> > > > > > example an anonymous private VMA.
> > > > >
> > > > > Hmm, can it though?
> > > > >
> > > > > P1 mmap write lock will be held, and VMA lock will be held too fo=
r VMA1,
> > > > >
> > > > > In vms_complete_munmap_vmas(), vms_clear_ptes() will stall on tlb=
_finish_mmu()
> > > > > for IPI-synced architectures, and in that case the unmap won't fi=
nish and the
> > > > > mmap write lock won't be released so nobody an map a new VMA yet =
can they?
> > > >
> > > > Yeah, I think it can't happen on configurations that always use IPI
> > > > for TLB synchronization. My patch also doesn't change anything on
> > > > those architectures - tlb_remove_table_sync_one() is a no-op on
> > > > architectures without CONFIG_MMU_GATHER_RCU_TABLE_FREE.
> > >
> > > Hmm but in that case wouldn't:
> > >
> > > tlb_finish_mmu()
> > > -> tlb_flush_mmu()
> > > -> tlb_flush_mmu_free()
> > > -> tlb_table_flush()
> >
> > And then from there we call tlb_remove_table_free(), which does a
> > call_rcu() to tlb_remove_table_rcu(), which will asynchronously run
> > later and do __tlb_remove_table_free(), which does
> > __tlb_remove_table()?
>
> Yeah my bad!
>
> >
> > > -> tlb_remove_table()
> >
> > I don't see any way we end up in tlb_remove_table() from here.
> > tlb_remove_table() is a much higher-level function, we end up there
> > from something like pte_free_tlb(). I think you mixed up
> > tlb_remove_table_free and tlb_remove_table.
>
> Yeah sorry my mistake you're right!
>
> >
> > > -> __tlb_remove_table_one()
> >
> > Heh, I think you made the same mistake as Linus made years ago when he
> > was looking at tlb_remove_table(). In that function, the call to
> > tlb_remove_table_one() leading to __tlb_remove_table_one() **is a
> > slowpath only taken when memory allocation fails** - it's a fallback
> > from the normal path that queues up batch items in (*batch)->tables[]
> > (and occasionally calls tlb_table_flush() when it runs out of space in
> > there).
> >
>
> At least in good company ;)
>
> > > -> tlb_remove_table_sync_one()
> > >
> > > prevent the unmapping on non-IPI architectures, thereby mitigating th=
e
> > > issue?
> >
> > > Also doesn't CONFIG_MMU_GATHER_RCU_TABLE_FREE imply that RCU is being=
 used
> > > for page table teardown whose grace period would be disallowed until
> > > gup_fast() finishes and therefore that also mitigate?
> >
> > I'm not sure I understand your point. CONFIG_MMU_GATHER_RCU_TABLE_FREE
> > implies that "Semi RCU" is used to protect page table *freeing*, but
> > page table freeing is irrelevant to this bug, and there is no RCU
> > delay involved in dropping a reference on a shared hugetlb page table.
>
> It's this step:
>
> 5. P1 unmaps VMA1, and creates a new VMA (VMA3) in its place, for
> example an anonymous private VMA.
>
> But see below, I have had the 'aha' moment... this is really horrible.
>
> Sigh hugetlb...
>
> > "Semi RCU" is not used to protect against page table *reuse* at a
> > different address by THP. Also, as explained in the big comment block
> > in m/mmu_gather.c, "Semi RCU" doesn't mean RCU is definitely used -
> > when memory allocations fail, the __tlb_remove_table_one() fallback
> > path, when used on !PT_RECLAIM, will fall back to an IPI broadcast
> > followed by directly freeing the page table. RCU is just used as the
> > more polite way to do something equivalent to an IPI broadcast (RCU
> > will wait for other cores to go through regions where they _could_
> > receive an IPI as part of RCU-sched).
>
> I guess for IPI we're ok as _any_ of the TLB flushing will cause a
> shootdown + thus delay on GUP-fast.
>
> Are there any scenarios where the shootdown wouldn't happen even for the
> IPI case?



> > But also: At which point would you expect any page table to actually
> > be freed, triggering any of this logic? When unmapping VMA1 in step 5,
> > I think there might not be any page tables that exist and are fully
> > covered by VMA1 (or its adjacent free space, if there is any) so that
> > they are eligible to be freed.
>
> Hmmm yeah, ok now I see - the PMD would remain in place throughout, we
> don't actually need to free anything, that's the crux of this isn't
> it... yikes.
>
> "Initially, we have a hugetlb shared page table covering 1G of
> address space which maps hugetlb 2M pages, which is used by two
> hugetlb VMAs in different processes (processes P1 and P2)."
>
> "Then P1 splits the hugetlb VMA in the middle (at a 2M boundary),
> leaving two VMAs VMA1 and VMA2."
>
> So the 1 GB would have to be aligned and (xxx =3D PUD entry, y =3D VMA1
> entries, z =3D VMA2 entries)
>
>
>       PUD
>     |-----|
>     \     \
>     /     /
>     \     \      PMD
>     /     /    |-----|
>     | xxx |--->| y1  |
>     /     /    | y2  |
>     \     \    | ... |
>     /     /    |y255 |
>     \     \    |y256 |
>     |-----|    | z1  |
>                | z2  |
>                | ... |
>                |z255 |
>                |z256 |
>                |-----|
>
> So the hugetlb page sharing stuff defeats all assumptions and
> checks... sigh.
>
> >
> > > Why is a tlb_remove_table_sync_one() needed in huge_pmd_unshare()?
> >
> > Because nothing else on that path is guaranteed to send any IPIs
> > before the page table becomes reusable in another process.
>
> I feel that David's suggestion of just disallowing the use of shared page
> tables like this (I mean really does it actually come up that much?) is t=
he
> right one then.

Yeah, I also like that suggestion.

> I wonder whether we shouldn't just free the PMD after it becomes unshared=
?
> It's kind of crazy to think we'll allow a reuse like this, it's asking fo=
r
> trouble.
>
> Moving on to another point:
>
> One point here I'd like to raise - this seems like a 'just so'
> scenario. I'm not saying we shouldn't fix it, but we're paying a _very
> heavy_ penalty here for a scenario that really does require some unusual
> things to happen in GUP fast and an _extremely_ tight and specific window
> in which to do it.

Yes.

> Plus isn't it going to be difficult to mediate exactly when an unshare wi=
ll
> happen?
>
> Since you can't pre-empt and IRQs are disabled, to even get the scenario =
to
> happen is surely very very difficult, you really have to have some form o=
f
> (para?)virtualisation preemption or a NMI which would have to be very lon=
g
> lasting (the operations you mention in P2 are hardly small ones) which
> seems very very unlikely for an attacker to be able to achieve.

Yeah, I think it would have to be something like a hypervisor
rescheduling to another vCPU, or potentially it could happen if
someone is doing kernel performance profiling with perf_event_open()
(which might do stuff like copying large amounts of userspace stack
memory from NMI context depending on runtime configuration).

> So my question is - would it be reasonable to consider this at the very
> least a vanishingly small, 'paranoid' fixup? I think it's telling you
> couldn't come up with a repro, and you are usually very good at that :)

I mean, how hard this is to hit probably partly depends on what
choices hypervisors make about vCPU scheduling. And it would probably
also be easier to hit for an attacker with CAP_PERFMON, though that's
true of many bugs.

But yeah, it's not the kind of bug I would choose to target if I
wanted to write an exploit and had a larger selection of bugs to
choose from.

> Another question, perhaps silly one, is - what is the attack scenario her=
e?
> I'm not so familiar with hugetlb page table sharing, but is it in any way
> feasible that you'd access another process's mappings? If not, the attack
> scenario is that you end up accidentally accessing some other part of the
> process's memory (which doesn't seem so bad right?).

I think the impact would be P2 being able to read/write unrelated data
in P1. Though with the way things are currently implemented, I think
that requires P1 to do this weird unmap of half of a hugetlb mapping.

We're also playing with fire because if P2 is walking page tables of
P1 while P1 is concurrently freeing page tables, normal TLB flush IPIs
issued by P1 wouldn't be sent to P2. I think that's not exploitable in
the current implementation because CONFIG_MMU_GATHER_RCU_TABLE_FREE
unconditionally either frees page tables through RCU or does IPI
broadcasts sent to the whole system, but it is scary because
sensible-looking optimizations could turn this into a user-to-kernel
privilege escalation bug. For example, if we decided that in cases
where we already did an IPI-based TLB flush, or in cases where we are
single-threaded, we don't need to free page tables with Semi-RCU delay
to synchronize against gup_fast().

> Thanks, sorry for all the questions but really want to make sure I
> understand what's going on here (and can later extract some of this into
> documentation also potentially! :)

