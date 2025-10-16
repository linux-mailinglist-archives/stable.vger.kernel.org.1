Return-Path: <stable+bounces-186206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A042BE5660
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 22:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE07A3B68B0
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 20:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2D02E228C;
	Thu, 16 Oct 2025 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x8QXI5/T"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858192DF13B
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646372; cv=none; b=J0IazZKEiWSlB76lXjfQ8tO7mHJIvXqv5tagqJaP/8QB94jFZG5StvHXl7yYepcThR9kajW5FWTYsbFIBhiKmF4FU6rbWe/WG0dtrrPD9u/p5qBYnU1tVrXBbwk14ZNieJSlZ4BbqHxyc+zsRYHo47q6R51nsMmvcEXG4HxSWJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646372; c=relaxed/simple;
	bh=e04unfMcA+wl94OLQlNjKMIVqI1fY+KiZvebuibHwws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tftXAkxbcbc/bUxZK9d0LJK2aDcuJse4lYs3iyLAaVbdPmwfkoqA+2wvvkqCxMPoSLsaDV9hMBbHbnNzalqepdvsEQrXFd+kczUOzKH8js4V1w1djnPCIsbIyw1MSYb3qQIKLI+yPSUzuVZfmGTNxr6LJdzzKN+CfuM7d65EolA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x8QXI5/T; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-633c627d04eso2788a12.0
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760646369; x=1761251169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e04unfMcA+wl94OLQlNjKMIVqI1fY+KiZvebuibHwws=;
        b=x8QXI5/T2kAYaBB8/LaIsgCLIfXbAqKDwyhe/yNS2o/L3ZlCx1XgRb92qrJNzadgNF
         Ac6E3j5XwMMLwuQGPdZVlt+aup4WdYsihI36ohAHhhryvjkSkWmVTXvlkwhTBfcbnNGP
         K/uEPOJIuLqLHrBCO2PRZ6LTRvsPMdz3ubJcmSnViOR19Xpdsfqd1H9V5zOHSK0HEZKH
         BS1BAZl5T+1le1knj8Jko76GOiDLk3EqyITR3ilP7UKcY9FzJYun1+L6WTatX8o37AIk
         xKzUcVERyD88pS9byMEAs0kSU8evvgZ9uuyh3/yqofN9Ubxh+Hk+dtgEClmg1JFU7a3S
         jaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760646369; x=1761251169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e04unfMcA+wl94OLQlNjKMIVqI1fY+KiZvebuibHwws=;
        b=EMZaOT+nxbsMxbJw3DcFcWBnSCsBLJj8EJHuQI2Y4+pWDg9UAnENx538hCozbj+oXp
         90x08Mq05uVtK1pUfPpyBrX/VNcM5Pib8Q/uKJu0E3uI1BmFeZ9zkHf8kbeYSzAKaQKW
         ++lgZB4E8yf0BUGHBn+DI6jZOPK24leDf1GgOMB7DC1YZHzkshjyDzUYl2EA/XIKD3JW
         mROXcKT+C5C90lViRg/nKuY1fYNZrLueehnXPfBtzG9NYLkvAC0te2hI6pmESNbKo1Gi
         /B+rrhSQFDeM6b0hDJ34qht8oPOcnAw5QpncH0ywW+sn0/8JUumjG2FkTy783QYgA6eX
         Qthg==
X-Forwarded-Encrypted: i=1; AJvYcCXR0eaZnadN7mvsR91M03+0XSRZVS/wvSbzv8+QTC3e6gA5rU8gU89OasS0S0pTQR4WgGCkSpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzInFVvMZs0KKOSBt1FUbtBeaYjcITmrsAQlRkXXN2e5GaYZDXW
	RGdrCaYrwYP9U7dRt4JErkrmFOQhqp46DpfoWNqPhfzlSjesjcVfNaO7zhqmkQUWdjSesQBdXOa
	twpDrs0dCLMSJf2t/kuIX8ihCVUrHkqb+VOehQ3W3
X-Gm-Gg: ASbGncvZ8rAjNotCkDLckO4EfGpYaAAyelytN/Aep5MKOXE5CoEXWICmYiLqgiKn49U
	zNe/MLFDJv9QOSZmnrKFjqkwI0z4LKrXTXwb3l9ckOa2T+3IYiZrpviB3Woz0TtYaFJNb4Ebd9t
	IECd2d6vnoLdzdfSZCBB0ncA6PR73MNM2KvHOFcseYVSRyNggjzI/IvOd3Kr2+LptNrOrjSo27G
	8fSx+aDIKzkuWyaQfx7qpaOGFsKaYrOBL+sBTYUfO4j5HiTvuZcMfXXHvlvRdBdS0tutiocEK57
	ZHgDYGXZIc3ZdMAz4QDoLIsnQQ==
X-Google-Smtp-Source: AGHT+IH/u+FCKbAoouZGXJNTy6nZ13eBN9Yk1uXZGrSCfrKoknUB+Gt38BROwONPAKp2ZAt70A36LU2nCFlzOIYu7Lk=
X-Received: by 2002:aa7:d144:0:b0:634:90ba:2361 with SMTP id
 4fb4d7f45d1cf-63bee07418dmr245479a12.7.1760646368450; Thu, 16 Oct 2025
 13:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de> <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com> <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
 <e4277c1a-c8d4-429d-b455-8daa9f4bbd14@redhat.com> <CAG48ez0yz2DauOuJy=-CcpQpqReWhYH1dpW3QGHPSHQ1VbAf3g@mail.gmail.com>
 <9d9912fe-3b0b-4754-87f6-6efb49d92a7b@redhat.com>
In-Reply-To: <9d9912fe-3b0b-4754-87f6-6efb49d92a7b@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 16 Oct 2025 22:25:31 +0200
X-Gm-Features: AS18NWDLSb8iiK3deIr5crIXEpUg4U0MpY6QS-BO0TbZ3uZrFMySHGIdBYHCiHQ
Message-ID: <CAG48ez3P6nH-NFTvihmZW1nS3Q7UCz_BxCBk-jzG82-zUdF2yQ@mail.gmail.com>
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

On Thu, Oct 16, 2025 at 9:45=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
> On 16.10.25 21:26, Jann Horn wrote:
> > On Thu, Oct 16, 2025 at 9:10=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>>> I'm currently looking at the fix and what sticks out is "Fix it with=
 an
> >>>> explicit broadcast IPI through tlb_remove_table_sync_one()".
> >>>>
> >>>> (I don't understand how the page table can be used for "normal,
> >>>> non-hugetlb". I could only see how it is used for the remaining user=
 for
> >>>> hugetlb stuff, but that's different question)
> >>>
> >>> If I remember correctly:
> >>> When a hugetlb shared page table drops to refcount 1, it turns into a
> >>> normal page table. If you then afterwards split the hugetlb VMA, unma=
p
> >>> one half of it, and place a new unrelated VMA in its place, the same
> >>> page table will be reused for PTEs of this new unrelated VMA.
> >>
> >> That makes sense.
> >>
> >>>
> >>> So the scenario would be:
> >>>
> >>> 1. Initially, we have a hugetlb shared page table covering 1G of
> >>> address space which maps hugetlb 2M pages, which is used by two
> >>> hugetlb VMAs in different processes (processes P1 and P2).
> >>> 2. A thread in P2 begins a gup_fast() walk in the hugetlb region, and
> >>> walks down through the PUD entry that points to the shared page table=
,
> >>> then when it reaches the loop in gup_fast_pmd_range() gets interrupte=
d
> >>> for a while by an NMI or preempted by the hypervisor or something.
> >>> 3. P2 removes its VMA, and the hugetlb shared page table effectively
> >>> becomes a normal page table in P1.
> >>> 4. Then P1 splits the hugetlb VMA in the middle (at a 2M boundary),
> >>> leaving two VMAs VMA1 and VMA2.
> >>> 5. P1 unmaps VMA1, and creates a new VMA (VMA3) in its place, for
> >>> example an anonymous private VMA.
> >>> 6. P1 populates VMA3 with page table entries.
> >>> 7. The gup_fast() walk in P2 continues, and gup_fast_pmd_range() now
> >>> uses the new PMD/PTE entries created for VMA3.
> >>
> >> Yeah, sounds possible. And nasty.
> >>
> >>>
> >>>> How does the fix work when an architecture does not issue IPIs for T=
LB
> >>>> shootdown? To handle gup-fast on these architectures, we use RCU.
> >>>
> >>> gup-fast disables interrupts, which synchronizes against both RCU and=
 IPI.
> >>
> >> Right, but RCU is only used for prevent walking a page table that has
> >> been freed+reused in the meantime (prevent us from de-referencing
> >> garbage entries).
> >>
> >> It does not prevent walking the now-unshared page table that has been
> >> modified by the other process.
> >
> > Hm, I'm a bit lost... which page table walk implementation are you
> > worried about that accesses page tables purely with RCU? I believe all
> > page table walks should be happening either with interrupts off (in
> > gup_fast()) or under the protection of higher-level locks; in
> > particular, hugetlb page walks take an extra hugetlb specific lock
> > (for hugetlb VMAs that are eligible for page table sharing, that is
> > the rw_sema in hugetlb_vma_lock).
>
> I'm only concerned about gup-fast, but your comment below explains why
> your fix works as it triggers an IPI in any case, not just during the
> TLB flush.
>
> Sorry for missing that detail.
>
> >
> > Regarding gup_fast():
> >
> > In the case where CONFIG_MMU_GATHER_RCU_TABLE_FREE is defined, the fix
> > commit 1013af4f585f uses a synchronous IPI with
> > tlb_remove_table_sync_one() to wait for any concurrent GUP-fast
> > software page table walks, and some time after the call to
> > huge_pmd_unshare() we will do a TLB flush that synchronizes against
> > hardware page table walks.
>
> Right, so we definetly issue an IPI.
>
> >
> > In the case where CONFIG_MMU_GATHER_RCU_TABLE_FREE is not defined, I
> > believe the expectation is that the TLB flush implicitly does an IPI
> > which synchronizes against both software and hardware page table
> > walks.
>
> Yes, that's what I had in mind, not an explicit sync.
>
>
> So the big question is whether we could avoid this IPI on every unsharing=
.
>
> Assume we would ever reuse a page table that was shared, we'd have to do
> this IPI only before freeing the page table I guess, or free the page
> table through RCU.

Yeah, that would make things a lot neater. Prevent hugetlb shared page
tables from ever being reused for normal mappings, perhaps by changing
huge_pmd_unshare() so that if the page table has a share count of 1,
we zap it instead of doing nothing. (Though that has to be restricted
to shared hugetlb mappings, which are the ones eligible for page table
sharing.)

I thiiiink doing it at huge_pmd_unshare() would probably be enough to
prevent formerly-shared page tables from being reused for new stuff,
but I haven't looked in detail.

