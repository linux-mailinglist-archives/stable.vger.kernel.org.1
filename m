Return-Path: <stable+bounces-186183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86426BE5174
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 20:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF44419A6D2E
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 18:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861214438B;
	Thu, 16 Oct 2025 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sGaP0exY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB6D2AD32
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640338; cv=none; b=NE+X6bMH2eJ47i43UN85VdG7LJkdHJGYGPR3RnLDg+7F4vivL+bgje440aMhT5+QWwKS+VqPTAZl04nS8saQvu0Ymez6u9sMaUtKq1RzE+MQxGvCCQgAO9dG7+00irHkz18r6PNmMftF+PGPQIuOoBTg1/C0X7/M+UUyGsTj2Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640338; c=relaxed/simple;
	bh=tSiAsiXFNrovAlX4G1WpxqgTAT+Xxjv5/WDeLRT3plM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaOdizgcnwr4BXRdIdr3hYasQ3Kk4UL+84eGAjar6WmpsqWNlHTfHeyqSIvl9bibAHDW/c2aCGdMDRcJhItO5SxEYV/lhEbG8+bipJB/Kzfpcon0lp28B1L8J3E+sfT37iYuKIQYulDeDW8NGeIpaADx9E1otXv9z4XyIspk3RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sGaP0exY; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c167b70f9so1873a12.0
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 11:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760640335; x=1761245135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKAdvV4xTE9n5qoKZxok1YZP3tAtC9BHXBT0bF0XgI4=;
        b=sGaP0exYOPSC+5Q2Zf+8aI7Zvp0QmXIUiZdirZE4aFJPxYA4VlO/MDpru1/+ZjiICC
         efhu/BAMm1Tz8enkXrklzLLK4AR5zyQTi5hfyRxsHJ07bizANwDD7t+KG/tgLtsT8Rt5
         3ZlvUCtrbZfmN1NYfL+bRw8hZlI4OAxoZFgAsixicJRK8rB7NZCREVSiyBPzlweDoFy/
         AkJTJMOqqnNebpTGrExZTgMHH5gRgRSwOwHVN2b9OowRHMDyDnq2ItpvT0e7aGdosGbl
         Vu7Ixz8LYlBlDn07jGWJeSLb8rz5slKyBEbx5dzHFdn8RrRtdfhluj+NMKCPapXgauWK
         hMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640335; x=1761245135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKAdvV4xTE9n5qoKZxok1YZP3tAtC9BHXBT0bF0XgI4=;
        b=qRhSlOwoflR3vXZS7geJ3jb3czKgCEOHSAdC7khVyCHgnQoZaoa/b5Vg+Dk4lQs6Lh
         x3Pwt5xK7b0Sc87+d7WuZflNtQmCGOhUTmJlcL2SCK5qS1E4tIPBQnfLLLRJU21GMPiY
         UP5HFaseuPZX2NaWa/AuYh1uaEvMddwy4eAzwHILliv2J+4qngI9eAigfDsaw/VUHVRy
         nEqEhYkdue234YVfzP3xExIPdI0m7xbIZXatVDH9l9pNkGCYrK1yOvpSPcnsP6enHME4
         szv2O7HwrTB/5dvrlfhfR50+nZXHT0xDj8cLn9eQX8WdM1wffe+FgKl2Badc15V0VCcM
         eDOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOQytW9rrcua/LR0gvm9Ldqi6XTyC7aXpDbz6oSLmjBk6duOGOKXtwwTTELTWFgCnBbmw2xxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd4IFvAKgW+T/f8naIPWzC3eu1bzdlLABcpWN+SpCjCquHSlDi
	w/XtNSuo9CM3moogOwqmcnPEeDZH9TeRSGNc0cWzpCs5wlmBZL7/vAtNbDu37Ms7/H+S4OFt3Mg
	4poSVnDarVb+eA8hSrS45kENaC8vFYjTePdfQPUen
X-Gm-Gg: ASbGncspwIkcE9ckM27nHtEOFv8ICo7Bxwn+WG4Qbndg94CCavawFT4yiAP3dVSp5WC
	ZppqNUs6KEodTWQDs6P5I8VOF9uPd1I5UxeA216aUQ1o8VUbxS99KUseDMlsl2bkoJGf4zX19kW
	riIhXjeB72/XIPKqXB/pHGdr1rTPmyTcHL0uayQ5mmSeHHFxasNQHLu74afsmwn5LnIoLOh9qPH
	4rAzZrqoYK0r6VayS2txa8Ky2EIfCDhRXXHNfUbKr1UdRQaMMUspwMeJHRx6kOcQSD3qmXjaTGO
	gbWMWN6NnKNBspcL0IJU6EuCBw==
X-Google-Smtp-Source: AGHT+IHMU7eVzIIxanU4159bOcDF3YZy3khy4dytu3X9pooQwOC3RvBQR6FnIdRDKA1rp6F4oJCjxXDvC7z56ZeUki0=
X-Received: by 2002:a50:ed13:0:b0:62f:c78f:d0d4 with SMTP id
 4fb4d7f45d1cf-63bebfe1112mr244762a12.6.1760640334407; Thu, 16 Oct 2025
 11:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de> <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com>
In-Reply-To: <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 16 Oct 2025 20:44:57 +0200
X-Gm-Features: AS18NWAPtIHsIZ0KkjzqmIc9gow3CG1PS8LMsfQSH4RUrDyio7sggwn916JOBbk
Message-ID: <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
To: David Hildenbrand <david@redhat.com>
Cc: "Uschakow, Stanislav" <suschako@amazon.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"trix@redhat.com" <trix@redhat.com>, "ndesaulniers@google.com" <ndesaulniers@google.com>, 
	"nathan@kernel.org" <nathan@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"muchun.song@linux.dev" <muchun.song@linux.dev>, "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"liam.howlett@oracle.com" <liam.howlett@oracle.com>, "osalvador@suse.de" <osalvador@suse.de>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 9:40=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
> On 01.09.25 12:58, Jann Horn wrote:
> > Hi!
> >
> > On Fri, Aug 29, 2025 at 4:30=E2=80=AFPM Uschakow, Stanislav <suschako@a=
mazon.de> wrote:
> >> We have observed a huge latency increase using `fork()` after ingestin=
g the CVE-2025-38085 fix which leads to the commit `1013af4f585f: mm/hugetl=
b: fix huge_pmd_unshare() vs GUP-fast race`. On large machines with 1.5TB o=
f memory with 196 cores, we identified mmapping of 1.2TB of shared memory a=
nd forking itself dozens or hundreds of times we see a increase of executio=
n times of a factor of 4. The reproducer is at the end of the email.
> >
> > Yeah, every 1G virtual address range you unshare on unmap will do an
> > extra synchronous IPI broadcast to all CPU cores, so it's not very
> > surprising that doing this would be a bit slow on a machine with 196
> > cores.
> >
> >> My observation/assumption is:
> >>
> >> each child touches 100 random pages and despawns
> >> on each despawn `huge_pmd_unshare()` is called
> >> each call to `huge_pmd_unshare()` syncrhonizes all threads using `tlb_=
remove_table_sync_one()` leading to the regression
> >
> > Yeah, makes sense that that'd be slow.
> >
> > There are probably several ways this could be optimized - like maybe
> > changing tlb_remove_table_sync_one() to rely on the MM's cpumask
> > (though that would require thinking about whether this interacts with
> > remote MM access somehow), or batching the refcount drops for hugetlb
> > shared page tables through something like struct mmu_gather, or doing
> > something special for the unmap path, or changing the semantics of
> > hugetlb page tables such that they can never turn into normal page
> > tables again. However, I'm not planning to work on optimizing this.
>
> I'm currently looking at the fix and what sticks out is "Fix it with an
> explicit broadcast IPI through tlb_remove_table_sync_one()".
>
> (I don't understand how the page table can be used for "normal,
> non-hugetlb". I could only see how it is used for the remaining user for
> hugetlb stuff, but that's different question)

If I remember correctly:
When a hugetlb shared page table drops to refcount 1, it turns into a
normal page table. If you then afterwards split the hugetlb VMA, unmap
one half of it, and place a new unrelated VMA in its place, the same
page table will be reused for PTEs of this new unrelated VMA.

So the scenario would be:

1. Initially, we have a hugetlb shared page table covering 1G of
address space which maps hugetlb 2M pages, which is used by two
hugetlb VMAs in different processes (processes P1 and P2).
2. A thread in P2 begins a gup_fast() walk in the hugetlb region, and
walks down through the PUD entry that points to the shared page table,
then when it reaches the loop in gup_fast_pmd_range() gets interrupted
for a while by an NMI or preempted by the hypervisor or something.
3. P2 removes its VMA, and the hugetlb shared page table effectively
becomes a normal page table in P1.
4. Then P1 splits the hugetlb VMA in the middle (at a 2M boundary),
leaving two VMAs VMA1 and VMA2.
5. P1 unmaps VMA1, and creates a new VMA (VMA3) in its place, for
example an anonymous private VMA.
6. P1 populates VMA3 with page table entries.
7. The gup_fast() walk in P2 continues, and gup_fast_pmd_range() now
uses the new PMD/PTE entries created for VMA3.

> How does the fix work when an architecture does not issue IPIs for TLB
> shootdown? To handle gup-fast on these architectures, we use RCU.

gup-fast disables interrupts, which synchronizes against both RCU and IPI.

> So I'm wondering whether we use RCU somehow.
>
> But note that in gup_fast_pte_range(), we are validating whether the PMD
> changed:
>
> if (unlikely(pmd_val(pmd) !=3D pmd_val(*pmdp)) ||
>      unlikely(pte_val(pte) !=3D pte_val(ptep_get(ptep)))) {
>         gup_put_folio(folio, 1, flags);
>         goto pte_unmap;
> }
>
>
> So in case the page table got reused in the meantime, we should just
> back off and be fine, right?

The shared page table is mapped with a PUD entry, and we don't check
whether the PUD entry changed here.

