Return-Path: <stable+bounces-186197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D414BE53B2
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 21:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C05482D96
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 19:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE092D9EE4;
	Thu, 16 Oct 2025 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AfKJobVv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520B42D94BB
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642820; cv=none; b=SpwfBhscihOq5iEK2GfIFgnmSdgAehcSPJ7o1sxP97fvkMCj2pA8D8JQnlkO+B8smeEDNvAr+XV5VG0J+MQEm43nQ0ItFlUy+60XZ36kGDoLIRjTrloxIZAff3iXqbScFJyovovwZJf5SVXLQXE4Te86fg5A3kI2rjNsOxeMikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642820; c=relaxed/simple;
	bh=Z4K3CmGQhxkB24mFx9E87SF9HhnIB+xHsfgBt0vqC10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjsazIQyQsrIORK+pnBOhO4+2jsoTIurYn9rW9nvyHz5UVnBNsa5BYjwdNFCmCtmdh32LJyVwW9urARNMHPJ238fxAK3USTo2aJM4cYEX5i1dmbj0pvmiHyyPNRV0+sYSiBRdp93o6t2vOHMhsOSSqlNlsGDPz2jvNzrGgHRNbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AfKJobVv; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c167b70f9so2580a12.0
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760642816; x=1761247616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4K3CmGQhxkB24mFx9E87SF9HhnIB+xHsfgBt0vqC10=;
        b=AfKJobVvICqXTrPMJTeQqgEbWkRfS3xdwuJgDDYeVbGQR2AWNmKUb/gyTOSOywNJEc
         sxhDKpJUBnr/sf2mpt8GSGMdrhWg8doQK8UsWIDlM85aEx1PDpQ8bo+hH4sqEn7qyp6q
         fX9jyMM3X0ll3eDcaC57psRm33hB72wmBIGuBSVoN8ccf0rTpEzdfzmxeCYfvV85qNnJ
         yyFlueJYd3NiWgWj44MYpoOCnaPZGI17t3hjkN0zu+jXYY0k9vhpVQp6+VF5m6RmvaEP
         KUlLAAzdG+f1+cxbzhMuO+N+SauZko5/b2y3PeEaedWBzoBayyh2gP9alH+tX5iLDeKy
         WwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760642816; x=1761247616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4K3CmGQhxkB24mFx9E87SF9HhnIB+xHsfgBt0vqC10=;
        b=p91G2OJUecJC1lgPGnJWuzKBMOO3+PE6QjX2OvDpefLOGQl8ECYDW+WOQ1SkklQgQ/
         L/zItHsRQSsFv9oDcbTYg3YJeTKcKauUUlKBsRuvcCdLqYT6JA6HFoq8SECbBf8fPkKv
         ScZ96Pn+k6SAUMXqXAMeMryi5Es0MVLPy/DcVcKI9hQl4cjOaMJAoyLexvSRwSvAWEjT
         imcakd1bPQB6xLEkzUHafcCyc6ksCyjwe8JaU+2DHD6MDPfeUBBYD9MILzR3v001YDcK
         BiQlfmzxRX/pP0jvMhMb/IO9t3nQJjroTTDaNVj0arHuZf9i2Aw9pllQ4OpNZTa/zRIE
         ctlg==
X-Forwarded-Encrypted: i=1; AJvYcCXrnbzm8DuXPPUaGMP/kgl/tHqdIf19LRzuRLXbBoYhE02D1m5dsbwsnt6T6jcZSQhY2bTPU1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEwNe9mDK5s2OfmOXJU70PaedUZj1t8EtGyHgNvWmUJr3s4LUH
	PObJTISXbizDTfn+z9ukYm5zB0L39B0+BLcWjQuIfAISIOPXXaNLAo3EYpWLruDCFSzV6VjeSgA
	KdFyceY8UXsSlqKqqluNtjyDLSvDa/rPvTegChVBD
X-Gm-Gg: ASbGnctkR/zKm5hCIU4eec1Gx8ptSoHO95pY+mdMfTLFpPcVwjGbW+QF7QeJtDrw2e5
	gQgpZUNkDdpzwK1Lq1J2ak5XVYPdlkJSRz3CqH1AAQsTdgymJPIc/dSNapcotfI5VfFYQfFeAqg
	QTiDRaq5U5//RcSFDWoT2m6LrzaEYtZPkZS+yuuXBK2HIGzcu4HevccJmHLF8yjaAwpjO/q4Hum
	Ej9iV1VNqNh1QSSOo3BiQ7tF5TxU0uh/mWnR3ZrI6aaidQ/u8m7BzhzAtdsmhOl5RDJa4/zAZxd
	m+3et1513I5APfkm2NsaDQkJew==
X-Google-Smtp-Source: AGHT+IFSkPBYjPqAaxyKpCKp2eJnQr5HaNLRzD2pbX8r+A+QqRs0jInVBDCbCWKpORR4+60IktmUfG1H/6ZHo6Vavxw=
X-Received: by 2002:a05:6402:1641:b0:624:45d0:4b33 with SMTP id
 4fb4d7f45d1cf-63bee07947dmr244804a12.7.1760642816180; Thu, 16 Oct 2025
 12:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de> <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com> <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
 <e4277c1a-c8d4-429d-b455-8daa9f4bbd14@redhat.com>
In-Reply-To: <e4277c1a-c8d4-429d-b455-8daa9f4bbd14@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 16 Oct 2025 21:26:19 +0200
X-Gm-Features: AS18NWDujHmIcngg16PpQMwwg8oF-_NIKvOm0btkYEtdspLHhr2gR_-TbMZsznU
Message-ID: <CAG48ez0yz2DauOuJy=-CcpQpqReWhYH1dpW3QGHPSHQ1VbAf3g@mail.gmail.com>
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

On Thu, Oct 16, 2025 at 9:10=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
> >> I'm currently looking at the fix and what sticks out is "Fix it with a=
n
> >> explicit broadcast IPI through tlb_remove_table_sync_one()".
> >>
> >> (I don't understand how the page table can be used for "normal,
> >> non-hugetlb". I could only see how it is used for the remaining user f=
or
> >> hugetlb stuff, but that's different question)
> >
> > If I remember correctly:
> > When a hugetlb shared page table drops to refcount 1, it turns into a
> > normal page table. If you then afterwards split the hugetlb VMA, unmap
> > one half of it, and place a new unrelated VMA in its place, the same
> > page table will be reused for PTEs of this new unrelated VMA.
>
> That makes sense.
>
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
> > 4. Then P1 splits the hugetlb VMA in the middle (at a 2M boundary),
> > leaving two VMAs VMA1 and VMA2.
> > 5. P1 unmaps VMA1, and creates a new VMA (VMA3) in its place, for
> > example an anonymous private VMA.
> > 6. P1 populates VMA3 with page table entries.
> > 7. The gup_fast() walk in P2 continues, and gup_fast_pmd_range() now
> > uses the new PMD/PTE entries created for VMA3.
>
> Yeah, sounds possible. And nasty.
>
> >
> >> How does the fix work when an architecture does not issue IPIs for TLB
> >> shootdown? To handle gup-fast on these architectures, we use RCU.
> >
> > gup-fast disables interrupts, which synchronizes against both RCU and I=
PI.
>
> Right, but RCU is only used for prevent walking a page table that has
> been freed+reused in the meantime (prevent us from de-referencing
> garbage entries).
>
> It does not prevent walking the now-unshared page table that has been
> modified by the other process.

Hm, I'm a bit lost... which page table walk implementation are you
worried about that accesses page tables purely with RCU? I believe all
page table walks should be happening either with interrupts off (in
gup_fast()) or under the protection of higher-level locks; in
particular, hugetlb page walks take an extra hugetlb specific lock
(for hugetlb VMAs that are eligible for page table sharing, that is
the rw_sema in hugetlb_vma_lock).

Regarding gup_fast():

In the case where CONFIG_MMU_GATHER_RCU_TABLE_FREE is defined, the fix
commit 1013af4f585f uses a synchronous IPI with
tlb_remove_table_sync_one() to wait for any concurrent GUP-fast
software page table walks, and some time after the call to
huge_pmd_unshare() we will do a TLB flush that synchronizes against
hardware page table walks.

In the case where CONFIG_MMU_GATHER_RCU_TABLE_FREE is not defined, I
believe the expectation is that the TLB flush implicitly does an IPI
which synchronizes against both software and hardware page table
walks.

