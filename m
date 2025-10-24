Return-Path: <stable+bounces-189253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B07C6C08357
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 23:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 180D04E0553
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 21:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358992D3A6C;
	Fri, 24 Oct 2025 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/Yh91TT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9730E820
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761342144; cv=none; b=XVZQPIPNb6jS62PK2OE+D0ftiJtZPoexxMYxAmv7tsxXb+fBhVJrzetqb8BW9esoYEnw5lS4bcaY2bwHZq3k64+NkqNMnOrRVhRHF98PB/uy+2nJz65Ul7z+azr3q0SSe95GC/bYEQg7GCxAgAntWEkku3niJ5BsKWLKw/FG2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761342144; c=relaxed/simple;
	bh=itCXHl8ctepPB+HiWwLJlZEZIs1mP5PEgmq+YmuTNg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNYf7z/7BdApJ2w0tLpjTazat9zkstTyhef87DFeMlLNe1vw4etCmZ1jYBH+T/4gtKkX8/mDPcwOkgQR2kzdPcZNa3jQWtGbMkd1qpV+tXiSIMPgOku1Prc1OeB0aR3Kf0oCJ5G0o0/CzR7fwtgJjwvG9ffLqRp0pabcrEEzatg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/Yh91TT; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c167b70f9so3137a12.0
        for <stable@vger.kernel.org>; Fri, 24 Oct 2025 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761342140; x=1761946940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itCXHl8ctepPB+HiWwLJlZEZIs1mP5PEgmq+YmuTNg8=;
        b=B/Yh91TTwV9OoeDmC+HdIW1Cg3RzJIdiRuEPmeLJoG2SoWg0uln7tGCcoOPeyU/T1D
         78x1mhxKUpe4MNAAmWZEp68s8R1ZsK7rHj4nToyInalKHHK2NJrfg0uh2Rh1BcMUhnkg
         i8RDcfLJwONClIUoiNGJyJuqzaL7Yn0AoMS4gQBqJRNg1mKsJL6QQUjWz3fJIQKghchk
         A79wP92MHrxDFCZtEenPxDPDrKnzRPQQ7/c+ieKpECWb4ifYqi4+JNZbERfXKews89yc
         G1IDB/n+oOZEL4ANwfNB0J83igtHSRXJc3pRPCgfz0PCMkygR+057SVonolecLg/ONT+
         X39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761342140; x=1761946940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itCXHl8ctepPB+HiWwLJlZEZIs1mP5PEgmq+YmuTNg8=;
        b=J63ttkez4B5ZBWol4PO1n9VpD/kOGMMj+UmRP0H/fLRYCJ6glw2/bUMdfyf5L47/M+
         WE8a6lRh3MX2spudSskXHlrjJeqbZXDS3M7JxtYL4lhCWysKRnCTXIT+RqmwMvX5hKzS
         sqMriLuREjHPNbG0AO0nzQZXAPq0qYdhxGKJx0DRjCYGCDLl9S2d7pAnlBPUXGySipg6
         G3jWTr08jMtJXumxePCP0MySrnlKwxGuXBUcbCpfrBnnfh/0h2Fxpb2Ze4m0HLu8NuKk
         xOZkpJmgZoA3RFNLV8rZa54VNvWTAssLH7INFNnTkdXrRblrlJsGtMX8DUoB0370rJyW
         bFfg==
X-Forwarded-Encrypted: i=1; AJvYcCVdsdGOVaCHzraearMgPCLiTNhBU/KYTA6e/+VT+UMtWzSPOu0gqcwr3AafFrNUItYtDJ5j8MY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1rr5A/coatLFaWyQ3H89Zs56e3OlYAbbHNKyRMW6NlroKL89d
	GDT1GwzdvUdD2Je1RnkFK/wNXa5st0i6NA2/GZbiZQw2QJFLRQc5L9/ZCcpOef8FFIkF2f39gro
	KNizD40klGCPef5vPGKnmxNj304NGnh5Y6EVRrkPu
X-Gm-Gg: ASbGncvLbqFLKCenTUP2CwIgR4+Wn95LEJgCFqW9m8F7m1Fb74V/ndj3F4aSsbWBmXw
	6WMiDE5mXPDhsHlo6gHBJRJHJAgRm9LC1PETsxpGAhezcu/s7SgqwIvVPoktSx6Q4r4aHhCrF7s
	5UdjejUY5yOC3eFrBkMXyu/bhY3YDo+hI15R/5UykaCvkxqImVBN3fueC3slyzTLXXUiEyjZ0iM
	wCHgfjyfnQWix8WxIrgy4yFZfjywaaqunttC5ETDoKMXf194oVMoYXI8vNO3ueKwn7sn8ymwpHz
	vQqHptJYpOCBw4xJkNSSBM4N
X-Google-Smtp-Source: AGHT+IHEuDP7kJ05dEUklq0wZaHOnZX/AiJqjI2fMghi+Fp4GpS8e4Y9NafWThm7bIW+IZ3n3rPeb0fMkN98q6HdgEk=
X-Received: by 2002:a50:d6d4:0:b0:63e:447d:6aee with SMTP id
 4fb4d7f45d1cf-63e7bd47b8bmr31664a12.0.1761342140312; Fri, 24 Oct 2025
 14:42:20 -0700 (PDT)
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
 <4ebbd082-86e3-4b86-bb01-6325f300fc9c@lucifer.local> <CAG48ez1JEerijaUxDRad6RkVm3TLm8bSuWGxQYs+fc_rsJDpAQ@mail.gmail.com>
 <6e939a0f-3011-4a69-a725-6fb09880a51f@lucifer.local>
In-Reply-To: <6e939a0f-3011-4a69-a725-6fb09880a51f@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Fri, 24 Oct 2025 23:41:43 +0200
X-Gm-Features: AWmQ_bk9DtfKbZlK3w2vk9xKo4DqXkFq3shnFSr-R9L5r3HK7JG_GFbXKw4dH9c
Message-ID: <CAG48ez2kinjCP2y6q9sOqNyVAiAC_UDS+w4NCdtKvidLQ6+zdQ@mail.gmail.com>
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, "Uschakow, Stanislav" <suschako@amazon.de>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "trix@redhat.com" <trix@redhat.com>, 
	"nathan@kernel.org" <nathan@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"muchun.song@linux.dev" <muchun.song@linux.dev>, "liam.howlett@oracle.com" <liam.howlett@oracle.com>, 
	"osalvador@suse.de" <osalvador@suse.de>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:59=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Fri, Oct 24, 2025 at 09:43:43PM +0200, Jann Horn wrote:
> > > So my question is - would it be reasonable to consider this at the ve=
ry
> > > least a vanishingly small, 'paranoid' fixup? I think it's telling you
> > > couldn't come up with a repro, and you are usually very good at that =
:)
> >
> > I mean, how hard this is to hit probably partly depends on what
> > choices hypervisors make about vCPU scheduling. And it would probably
> > also be easier to hit for an attacker with CAP_PERFMON, though that's
> > true of many bugs.
> >
> > But yeah, it's not the kind of bug I would choose to target if I
> > wanted to write an exploit and had a larger selection of bugs to
> > choose from.
> >
> > > Another question, perhaps silly one, is - what is the attack scenario=
 here?
> > > I'm not so familiar with hugetlb page table sharing, but is it in any=
 way
> > > feasible that you'd access another process's mappings? If not, the at=
tack
> > > scenario is that you end up accidentally accessing some other part of=
 the
> > > process's memory (which doesn't seem so bad right?).
> >
> > I think the impact would be P2 being able to read/write unrelated data
> > in P1. Though with the way things are currently implemented, I think
> > that requires P1 to do this weird unmap of half of a hugetlb mapping.
> >
> > We're also playing with fire because if P2 is walking page tables of
> > P1 while P1 is concurrently freeing page tables, normal TLB flush IPIs
> > issued by P1 wouldn't be sent to P2. I think that's not exploitable in
> > the current implementation because CONFIG_MMU_GATHER_RCU_TABLE_FREE
> > unconditionally either frees page tables through RCU or does IPI
> > broadcasts sent to the whole system, but it is scary because
> > sensible-looking optimizations could turn this into a user-to-kernel
> > privilege escalation bug. For example, if we decided that in cases
> > where we already did an IPI-based TLB flush, or in cases where we are
> > single-threaded, we don't need to free page tables with Semi-RCU delay
> > to synchronize against gup_fast().
>
> Would it therefore be reasonable to say that this is more of a preventati=
ve
> measure against future kernel changes (which otherwise seem reasonable)
> which might lead to exploitable bugs rather than being a practiclaly
> exploitable bug in itself?

I would say it is a security fix for theoretical userspace that either
intentionally partially unmaps hugetlb mappings (which would probably
be weird), or maps and partially unmaps attacker-supplied file
descriptors (without necessarily expecting them to be hugetlb). (I
know of userspace that mmap()s file descriptors coming from untrusted
code, though I don't know examples that would then partially unmap
them.) Admittedly there is some perfectionism involved here on my
part. In particular, it irks me to make qualitative distinctions
between bugs based on how hard to hit the timing requirements for them
are.

But yes, a large part of my motivation for writing this patch was to
prevent reasonable future changes to the rest of MM from making this a
worse bug.

