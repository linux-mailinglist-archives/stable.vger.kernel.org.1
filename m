Return-Path: <stable+bounces-188139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED43BF2213
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432321881E41
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B9426B0BE;
	Mon, 20 Oct 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBcdID/z"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A3A26A0C7
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974444; cv=none; b=QvSp6pQMXhFFVeiZ/BkSBCN0B3AoFwrM38bbP6azrM4hJBoakVD5yxU4URemGXoEPTkZ6sprTBJKAxQdwAarx6b0svgDU88kFxlyhBsfBCZgGN00dbn0fA5srmlIyZdjO4acqRUNWdJp9FzMAV0zburFMEYwKGo6hXj3IGgiK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974444; c=relaxed/simple;
	bh=GtzxIQBdPGtHbRxtmVBCLjoh5oToUvZDoDokTRgA3a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5hQC8qyfcMl0RMQgmXv+m4r6w7Efr5fUPXVYjpz0zbSmiqdo9WjWwtbln5LlRmSZrZ6RSkYWpHHcBeNyKwFac54LRnVcF3NsyAZMUNHzEJn3RYyZDb+LitGx1mZck5Pp9BUMzFBWy3dKVpoUjpOOy0k5n/sOvpWBv5TShtpz4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBcdID/z; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c167b70f9so14520a12.0
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760974440; x=1761579240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoMPjv5QaA2iaHSWt7qx0y0ZWWey1KUmhoM8Z4ibSWU=;
        b=WBcdID/zc/gat6O2QkiJ+HPLr33LTHDNy8aBX08ebfT/liTe9Kj6tQojtS9sKxgYpT
         8uBYtd41jrPIss4u4VuTggC2iqjjcNIwXtbWz8MY2qTARv+d/n/yTAMY7jxpG5MRqhhI
         girCg8ry0d6/66+E/pjVEWQX7ScIKkT3aZ4mRm9p8rf5SdzrT3Q6ACsk487LhXfTbZjR
         G8pxVfmQ7RNzZaCRehDf6hk5O85+po8lM0ewm+S1qv7vP3G2oYAucU4bMyFpQdtSFNg1
         PEYn2In9VE83zFAj4TEYhoVmXW/+ZsANsExeNFGzGfsoiKec4EILEWUSxnNdney3Bpgr
         OVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760974440; x=1761579240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoMPjv5QaA2iaHSWt7qx0y0ZWWey1KUmhoM8Z4ibSWU=;
        b=hj9Oez06N2fJ24Eq6Pc33/hCrTy/KUP2+lzccs0TdcN+T5griVgx/ipux9GD/DqAEe
         NpJCMuFphZALzeC11tvXB+CezSSWb7yu9ztWCnUX3ItFkUxLyxLpSMw5WfnizFp1FXza
         8g8pebTAu5u9WyCdegy61uf8Fn4NOY/9B6iktwCnKMt+XJFdf4TLXFfE4dnObCtlb1jr
         3vkU5rerQRJiPCveLuIkmhDbTkQvljjTXL9gg8QAWyQ4fg3EUnczzentl0YI1WIBYf1I
         yeGJPIyYQS4dED56GeMAP0hoPi1pksiTMBw/1QfviuWlmCsmnmOZTtNP1zjW2dIzTydN
         8xLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi2LEyaWobwxl+DaDlOgzXlSlkfA2jfIhl614mxEIXhyfCy61HzdUILXXLQSZXhvCpYxolOOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLFEHCHO6GH1Kh9JS08hflkQjlBR73ewcpD5aZdrgbLAmKhgwh
	6U47VJeMfAU8dIXeuUXlcLmKLjGiyHpQFQJFL7sdzOBOnn1iQBfMGEQrfV2v19Y6r6ApHmET4F7
	KklzIn/GB8z380YniEQQSVIoZERY8e88q6ZdPM5P9
X-Gm-Gg: ASbGncvFA8u2+Y2t2IXedXRuIYu+WeIAZoyuYo31shGQWCcvNaO+W4bbSi3USB9ut5j
	XY1LuKaKoLaLwUhR71M8HpOX4cD59uFyTJFzpIEb7UsSiJDHljUv/BpJnkHAC9t+9MPCcaxV5m0
	gm4hoHEZuXGy4JllFCRvR37ElUA7WMYolozO6LWzO5dz/I8g/2JCJ1bpNKnJI6bIY8AfT7fZkDf
	ySm0FS7icf7i0uzLC4s+wgOcSZqp4TPwnNxmzZn9p/5WQo1diE/rmxqgLg0ckTKohZAlpAAtaru
	nOuNySbU9DPmRg==
X-Google-Smtp-Source: AGHT+IEMH+U2cQKjQIsds+8fm6Kq7It+MUdS3Lsmva3FmgSZShNlk6REjMdRJGcVQFJhUkJjZdCtVYUnoT8lrmP5r+g=
X-Received: by 2002:a05:6402:1284:b0:63c:11a5:3b24 with SMTP id
 4fb4d7f45d1cf-63c11a53bd3mr332815a12.1.1760974440107; Mon, 20 Oct 2025
 08:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de> <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com> <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
 <81d096fb-f2c2-4b26-ab1b-486001ee2cac@lucifer.local>
In-Reply-To: <81d096fb-f2c2-4b26-ab1b-486001ee2cac@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Mon, 20 Oct 2025 17:33:22 +0200
X-Gm-Features: AS18NWA-e4MpKGPDrMbiZevTJxybzfCgX9TbhLW59-uk1AksQpJ17-n6IgH3c2w
Message-ID: <CAG48ez3paQTctuAO1bXWarzvRK33kyLjHbQ6zsQLTWya8Y1=dQ@mail.gmail.com>
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

On Mon, Oct 20, 2025 at 5:01=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Thu, Oct 16, 2025 at 08:44:57PM +0200, Jann Horn wrote:
> > On Thu, Oct 9, 2025 at 9:40=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> > > On 01.09.25 12:58, Jann Horn wrote:
> > > > Hi!
> > > >
> > > > On Fri, Aug 29, 2025 at 4:30=E2=80=AFPM Uschakow, Stanislav <suscha=
ko@amazon.de> wrote:
> > > >> We have observed a huge latency increase using `fork()` after inge=
sting the CVE-2025-38085 fix which leads to the commit `1013af4f585f: mm/hu=
getlb: fix huge_pmd_unshare() vs GUP-fast race`. On large machines with 1.5=
TB of memory with 196 cores, we identified mmapping of 1.2TB of shared memo=
ry and forking itself dozens or hundreds of times we see a increase of exec=
ution times of a factor of 4. The reproducer is at the end of the email.
> > > >
> > > > Yeah, every 1G virtual address range you unshare on unmap will do a=
n
> > > > extra synchronous IPI broadcast to all CPU cores, so it's not very
> > > > surprising that doing this would be a bit slow on a machine with 19=
6
> > > > cores.
> > > >
> > > >> My observation/assumption is:
> > > >>
> > > >> each child touches 100 random pages and despawns
> > > >> on each despawn `huge_pmd_unshare()` is called
> > > >> each call to `huge_pmd_unshare()` syncrhonizes all threads using `=
tlb_remove_table_sync_one()` leading to the regression
> > > >
> > > > Yeah, makes sense that that'd be slow.
> > > >
> > > > There are probably several ways this could be optimized - like mayb=
e
> > > > changing tlb_remove_table_sync_one() to rely on the MM's cpumask
> > > > (though that would require thinking about whether this interacts wi=
th
> > > > remote MM access somehow), or batching the refcount drops for huget=
lb
> > > > shared page tables through something like struct mmu_gather, or doi=
ng
> > > > something special for the unmap path, or changing the semantics of
> > > > hugetlb page tables such that they can never turn into normal page
> > > > tables again. However, I'm not planning to work on optimizing this.
> > >
> > > I'm currently looking at the fix and what sticks out is "Fix it with =
an
> > > explicit broadcast IPI through tlb_remove_table_sync_one()".
> > >
> > > (I don't understand how the page table can be used for "normal,
> > > non-hugetlb". I could only see how it is used for the remaining user =
for
> > > hugetlb stuff, but that's different question)
> >
> > If I remember correctly:
> > When a hugetlb shared page table drops to refcount 1, it turns into a
> > normal page table. If you then afterwards split the hugetlb VMA, unmap
> > one half of it, and place a new unrelated VMA in its place, the same
> > page table will be reused for PTEs of this new unrelated VMA.
> >
> > So the scenario would be:
> >
> > 1. Initially, we have a hugetlb shared page table covering 1G of
> > address space which maps hugetlb 2M pages, which is used by two
> > hugetlb VMAs in different processes (processes P1 and P2).
> > 2. A thread in P2 begins a gup_fast() walk in the hugetlb region, and
> > walks down through the PUD entry that points to the shared page table,
> > then when it reaches the loop in gup_fast_pmd_range() gets interrupted
> > for a while by an NMI or preempted by the hypervisor or something.
> > 3. P2 removes its VMA, and the hugetlb shared page table effectively
> > becomes a normal page table in P1.
>
> This is a bit confusing, are we talking about 2 threads in P2 on differen=
t CPUs?
>
> P2/T1 on CPU A is doing the gup_fast() walk,
> P2/T2 on CPU B is simultaneously 'removing' this VMA?

Ah, yes.

> Because surely the interrupts being disabled on CPU A means that ordinary
> preemption won't happen right?

Yeah.

> By remove what do you mean? Unmap? But won't this result in a TLB flush s=
ynced
> by IPI that is stalled by P2'S CPU having interrupts diabled?

The case I had in mind is munmap(). This is only an issue on platforms
where TLB flushes can be done without IPI. That includes:

 - KVM guests on x86 (where TLB flush IPIs can be elided if the target
vCPU has been preempted by the host, in which case the host promises
to do a TLB flush on guest re-entry)
 - modern AMD CPUs with INVLPGB
 - arm64

That is the whole point of tlb_remove_table_sync_one() - it forces an
IPI on architectures where TLB flush doesn't guarantee an IPI.

(The config option "CONFIG_MMU_GATHER_RCU_TABLE_FREE", which is only
needed on architectures that don't guarantee that an IPI is involved
in TLB flushing, is set on the major architectures nowadays -
unconditionally on x86 and arm64, and in SMP builds of 32-bit arm.)

> Or is it removed in the sense of hugetlb? As in something that invokes
> huge_pmd_unshare()?

I think that could also trigger it, though I wasn't thinking of that case.

> But I guess this doesn't matter as the page table teardown will succeed, =
just
> the final tlb_finish_mmu() will stall.
>
> And I guess GUP fast is trying to protect against the clear down by check=
ing pmd
> !=3D *pmdp.

The pmd recheck is done because of THP, IIRC because THP can deposit
and reuse page tables without following the normal page table life
cycle.

> > 4. Then P1 splits the hugetlb VMA in the middle (at a 2M boundary),
> > leaving two VMAs VMA1 and VMA2.
> > 5. P1 unmaps VMA1, and creates a new VMA (VMA3) in its place, for
> > example an anonymous private VMA.
>
> Hmm, can it though?
>
> P1 mmap write lock will be held, and VMA lock will be held too for VMA1,
>
> In vms_complete_munmap_vmas(), vms_clear_ptes() will stall on tlb_finish_=
mmu()
> for IPI-synced architectures, and in that case the unmap won't finish and=
 the
> mmap write lock won't be released so nobody an map a new VMA yet can they=
?

Yeah, I think it can't happen on configurations that always use IPI
for TLB synchronization. My patch also doesn't change anything on
those architectures - tlb_remove_table_sync_one() is a no-op on
architectures without CONFIG_MMU_GATHER_RCU_TABLE_FREE.

> > 6. P1 populates VMA3 with page table entries.
>
> ofc this requires the mmap/vma write lock above to be released first.
>
> > 7. The gup_fast() walk in P2 continues, and gup_fast_pmd_range() now
> > uses the new PMD/PTE entries created for VMA3.
> >
> > > How does the fix work when an architecture does not issue IPIs for TL=
B
> > > shootdown? To handle gup-fast on these architectures, we use RCU.
> >
> > gup-fast disables interrupts, which synchronizes against both RCU and I=
PI.
> >
> > > So I'm wondering whether we use RCU somehow.
> > >
> > > But note that in gup_fast_pte_range(), we are validating whether the =
PMD
> > > changed:
> > >
> > > if (unlikely(pmd_val(pmd) !=3D pmd_val(*pmdp)) ||
> > >      unlikely(pte_val(pte) !=3D pte_val(ptep_get(ptep)))) {
> > >         gup_put_folio(folio, 1, flags);
> > >         goto pte_unmap;
> > > }
> > >
> > >
> > > So in case the page table got reused in the meantime, we should just
> > > back off and be fine, right?
> >
> > The shared page table is mapped with a PUD entry, and we don't check
> > whether the PUD entry changed here.
>
> Could we simply put a PUD check in there sensibly?

Uuuh... maybe? But I'm not sure if there is a good way to express the
safety rules after that change any more nicely than we can do with the
current safety rules, it feels like we're just tacking on an
increasing number of special cases. As I understand it, the current
rules are something like:

Freeing a page table needs RCU delay or IPI to synchronize against
gup_fast(). Randomly moving page tables to different locations (which
khugepaged does) is specially allowed only for PTE tables, thanks to
the PMD entry recheck. mremap() is kind of an weird case because it
can also move PMD tables without locking, but that's fine because
nothing in the region covered by the source virtual address range can
be part of a VMA other than the VMA being moved, so userspace has no
legitimate reason to access it.

