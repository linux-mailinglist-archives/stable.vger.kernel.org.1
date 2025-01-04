Return-Path: <stable+bounces-106743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3045AA01204
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 04:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69473A46CE
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 03:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924C68248C;
	Sat,  4 Jan 2025 03:09:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B09336C;
	Sat,  4 Jan 2025 03:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735960179; cv=none; b=hddAiW1rRwwegvJvIhDa2YzIBTJjSAkj/c//g8P5qtWIaYGRJ2ix8MzkpAn+O2r0zQQcfaFjR9B+DBvZ4osnEE3EQoM3uhJDunV6kUFU9Tu9k3YCrBFuyysgIzS4mZsD2QQbrDEKQCMAvhxjcYN/pFNarB6u3f+gx83QPJQBPoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735960179; c=relaxed/simple;
	bh=lL23qzqKGk1HCSpA+I8gMvTDYuHvABH6EuOENggfukE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Md3y3P/SLxaq4TW+c5IS44lFggGjAc1OG3hIda3BQqcWOl/0K3OSRQd3cq6YrQ1SO8SWcYjOLJn9AA46MNUj5v4s0xUwbo70TqFEuCaX2coQVeqR5lqdT6OpTdgn5w00BindrJYNQRUn4W4lm4t/jxfdESYKcnxCNDzx6KTXcyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tTuXa-000000000zp-3fIj;
	Fri, 03 Jan 2025 22:09:30 -0500
Message-ID: <dad8250f5ed1773a2a48b40ed518678f96932ac1.camel@surriel.com>
Subject: Re: [PATCH] x86/mm: Fix flush_tlb_range() when used for zapping
 normal PMDs
From: Rik van Riel <riel@surriel.com>
To: Jann Horn <jannh@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>,  Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 03 Jan 2025 22:09:30 -0500
In-Reply-To: <CAG48ez1d9VdW+UQ3RYXMAe1-9muqz3SrC_cZ4UvcB=jpfR2X=Q@mail.gmail.com>
References: <20250103-x86-collapse-flush-fix-v1-1-3c521856cfa6@google.com>
	 <a1fff596435121b01766bed27e401e8a27bf8f92.camel@surriel.com>
	 <CAG48ez1d9VdW+UQ3RYXMAe1-9muqz3SrC_cZ4UvcB=jpfR2X=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Fri, 2025-01-03 at 23:11 +0100, Jann Horn wrote:
> On Fri, Jan 3, 2025 at 10:55=E2=80=AFPM Rik van Riel <riel@surriel.com>
> wrote:
> > On Fri, 2025-01-03 at 19:39 +0100, Jann Horn wrote:
> > > 02fc2aa06e9e0ecdba3fe948cafe5892b72e86c0..3da645139748538daac7016
> > > 6618d
> > > 8ad95116eb74 100644
> > > --- a/arch/x86/include/asm/tlbflush.h
> > > +++ b/arch/x86/include/asm/tlbflush.h
> > > @@ -242,7 +242,7 @@ void flush_tlb_multi(const struct cpumask
> > > *cpumask,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flush_tlb_mm_range((vma)->vm_mm, start=
,
> > > end,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ((vma)->vm_flags &
> > > VM_HUGETLB)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ?
> > > huge_page_shift(hstate_vma(vma))=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 : PAGE_SHIFT, false)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 : PAGE_SHIFT, true)
> > >=20
> > >=20
> >=20
> > The code looks good, but should this macro get
> > a comment indicating that code that only frees
> > pages, but not page tables, should be calling
> > flush_tlb() instead?
>=20
> Documentation/core-api/cachetlb.rst seems to be the common place
> that's supposed to document the rules - the macro I'm touching is
> just
> the x86 implementation. (The arm64 implementation also has some
> fairly
> extensive comments that say flush_tlb_range() "also invalidates any
> walk-cache entries associated with translations for the specified
> address range" while flush_tlb_page() "only invalidates a single,
> last-level page-table entry and therefore does not affect any
> walk-caches".) I wouldn't want to add yet more documentation for this
> API inside the X86 code. I guess it would make sense to add pointers
> from the x86 code to the documentation (and copy the details about
> last-level TLBs from the arm64 code into the docs).
>=20
> I don't see a function flush_tlb() outside of some (non-x86) arch
> code.

I see zap_pte_range() calling tlb_flush_mmu(),
which calls tlb_flush_mmu_tlbonly() in include/asm-generic/tlb.h,
which in turn calls tlb_flush().

The asm-generic version of tlb_flush() goes through
flush_tlb_mm(), which on x86 would call flush_tlb_mm_range
with flush_tables =3D true.

Luckily x86 seems to have its own implementation of
tlb_flush(), which avoids that issue.

>=20
> I don't know if it makes sense to tell developers to not use
> flush_tlb_range() for freeing pages. If the performance of
> flush_tlb_range() actually is an issue, I guess one fix would be to
> refactor this and add a parameter or something?
>=20

I don't know whether this is a real issue on
architectures other than x86.

For now it looks like the code does the right
thing when only pages are being freed, so we
may not need that parameter.

--=20
All Rights Reversed.

