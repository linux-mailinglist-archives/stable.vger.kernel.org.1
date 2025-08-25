Return-Path: <stable+bounces-172897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8305BB34FAC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 01:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8631E1B26CA1
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 23:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1582A2853F2;
	Mon, 25 Aug 2025 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maQSuN8y"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868281720;
	Mon, 25 Aug 2025 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756164406; cv=none; b=Urd9FysU+hoCCws5sV7s7+UOk03H0uMOayKY9rLYpsjeIHKg8VaWxkGs9++E9e0GJuvdSdUa47z6ayN2+j+18WR5BLEMxQLNqmeuVUPpHh50HBoFf/290slv58rECR9WacETaKZ7COA7OqYfCYv0b337fNlFMr+EhmQwN2RQ+s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756164406; c=relaxed/simple;
	bh=JG18q78ZVkG4W76knSsJW1ICQmeXz/fQ1c5jpSC+ai8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEAnByhEPbCanZfbdnAP6TAlVhAJVyDXolAxLaMvVI72xL7ZuVQH61RqQUTaVPl/EyLeX7PNGlPZtuecV3ZyU1mlT0Ia8An0C/TOTqP4uVnLhkykbkJLZ8u2I6bhzwKqd2p+H08OD+iSVsfaT5xmTM9/u95F19TF10AMriOp9es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maQSuN8y; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c7aa4ce823so1513678f8f.0;
        Mon, 25 Aug 2025 16:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756164403; x=1756769203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JG18q78ZVkG4W76knSsJW1ICQmeXz/fQ1c5jpSC+ai8=;
        b=maQSuN8yROjE/KD00Y7bwf1xPaywL9F5vFGZG63KniYeOLAG1pToyQxkT+T1c99aiC
         NgiaI9AgrvaZqdJpZLDyjeUaqcEzlRR7icjX8arhba2GkGaDiURH3VXkZO1o1TifBx6y
         ieEQUgHW7DxNYQ6TpymO0I+46PpIbHzksB8E5X+MuNwiI90DMv2yAhLYQUrcIFbijlP6
         qDdkdfpc873JupX0Znso8jB5gVzY5+WjUOcf+UkEtk5AvUEmTKaiazF0ISCle1vYTQLd
         sWjUpVQ0srpi3icdU3qlXFy9Oe7OlQWUYDZLbt7NG+eBtczBglfXrOK83kr1XtvBMCFq
         WbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756164403; x=1756769203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JG18q78ZVkG4W76knSsJW1ICQmeXz/fQ1c5jpSC+ai8=;
        b=WvQzOpyoniBcOap/dFX/e6X0k4ZgxTg2iJdRYboG/Q2y17FFjK7B5Fla8DpqPJ6Wpc
         l07CB6kUlhBwe2BbKygAQEbiuL6A4Pq2zaOTy32yrctAvHYIPDDxgx1stKI9CD9yeig7
         cuOaYyJiEZkz6beIs0B8GMPG13I92bi+j/wvMBNwW8XjUSga8mU60Nb+Vnj8BAlsI5Ga
         36aqLAIjsC9L7uxsnkRnerz6ODBzBcu7QO+NTjwF8Qceq1XdrF8u79SEWDrB1pOgqtnI
         FN26vea7cAl61rrDy8DDrERM3/3as+5B7NSWqr3vUyDSjeKQIEZPXNcUbe0j2c3qf1sr
         68bA==
X-Forwarded-Encrypted: i=1; AJvYcCV3hthbKgtMEX5W5cCdoHRt4kQdjM1GNAiHfgAnCWy0ppixvfmcGvWT10qkP+5XbZvuiA66JK9leaJ+0Fw=@vger.kernel.org, AJvYcCVpllZ6XJZypLCwlpLYzsZg0Smv8A8WwoDMMj8sI8OKipAMiXLzQ4jT3VHJIYuzssTPPKU8KOnk@vger.kernel.org
X-Gm-Message-State: AOJu0YwckJDId39Ul9fNsunP4dsiKUFBQlCzrXxOhBizUz4axqHj+4Dn
	iTIJ4FRkhFRSj5wD2dXDGxC7j0bMOwjYB7wTXsv5ByR4NTH3xG6uHqB1aC9F3aNrYKTu+iv0KST
	G5aygvP33dfVztOIzd/pgPTxuqLmyc5o=
X-Gm-Gg: ASbGncuoebKanZrK1QNuMuDRtrATFJkMzCLOkHwxhbY1bzh4/wM/PySLNiafG/txaei
	RgIAdXssQ3mzVHNw3kK4SEZHNDl1Zem5/HGbcnv0aercwyK+1LUmesDaNUgKdi4SNJAGSkW+0h5
	FwvQxc0fYBTE/zXK8d6rMQaKtYv7GiEeFZf6EMkqLg50lI1YQpSHUkNjrYfhyBmQUohtb30Kn9+
	L/Wo5/5Vboxxmf2r3YMw92YwJUTAdepq051HHhbxNKJT58K41gia0OQ2uJM85poZKhN7NSjoled
	QlINtB8=
X-Google-Smtp-Source: AGHT+IH1DfEr+Lu3NtBpYyp3/OYkyFwA5ty+ZQKhZUgugEu1nKOFeJs8vUUL857y82BshZV21sS4nTMdByEDq1urCgs=
X-Received: by 2002:a05:6000:4383:b0:3b7:882c:790 with SMTP id
 ffacd0b85a97d-3c5dc73625cmr10812283f8f.37.1756164403017; Mon, 25 Aug 2025
 16:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822041526.467434-1-CFSworks@gmail.com> <CAMj1kXH38gOUpDDdarCXPAY3BHBbuFzdD=Dq7Knsg-qHJoNqzQ@mail.gmail.com>
 <CAH5Ym4gTTLcyucnXjxFtNutVR1HQ0G2k_YBSNO-7G3-4YXUtag@mail.gmail.com>
 <CAMj1kXF00Y0=67apXVbOC+rpbEEvyEovFYf4r_edr6mXjrj0+A@mail.gmail.com>
 <CAH5Ym4h+2w6aayzsVu__3qu3-6ETq1HK7u18yGzOrRqZ--2H9w@mail.gmail.com>
 <874itx14l5.wl-maz@kernel.org> <CAH5Ym4iqvQuO6JxO-jypTp05Ug_2vDokCDoBgGB+cOzgmTQpkQ@mail.gmail.com>
 <871poz2299.wl-maz@kernel.org>
In-Reply-To: <871poz2299.wl-maz@kernel.org>
From: Sam Edwards <cfsworks@gmail.com>
Date: Mon, 25 Aug 2025 16:26:31 -0700
X-Gm-Features: Ac12FXymuHj_F3D9l2e_hmE46sF5hQJvepyvPpmnqbK0RbrKURVSn9TFQXq54tw
Message-ID: <CAH5Ym4hgOCMggPTmdmmEObupzbHm+w6=J_7u+skOxRHE3Z9VnQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/boot: Zero-initialize idmap PGDs before use
To: Marc Zyngier <maz@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baruch Siach <baruch@tkos.co.il>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 2:12=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
> > So: where do the terms P4D, PUD, and PMD fit in here? And which one's
> > our missing fencepost?
> > PGD ----> ??? ----> ??? ----> ??? ----> ??? ----> PTE (|| low VA bits
> > =3D final PA)
>
> I'm struggling to see what you consider a problem, really. For me, the
> original mistake is that you seem to have started off the LSBs of the
> VA, instead of the MSBs.

Right; I did my example MMU walk in reverse to start with the levels
that are never folded and work my way up to the PGD level, since I was
trying to deduce PTRS_PER_PGD, essentially.

As for the ultimate source of my confusion, it's best explained in
this paragraph from the paging documentation [0] (emphasis my own):

The entry part of the name is a bit confusing because while in Linux 1.0
this did refer to a single page table entry in the single top level page ta=
ble,
it was retrofitted to be an array of mapping elements when two-level page
tables were first introduced, ***so the pte is the lowermost page table, no=
t
a page table entry.***

As I see it, this creates a habit of using the names for the table
entries and the tables themselves interchangeably. Kernel folk who
don't work on the MM subsystem much (like myself) don't share this
habit. So when I say something like "an 'array of PGDs' is nonsense,"
I mean "an 'array of top-level page tables' is an oxymoron: if there's
an array of them, they aren't top-level." But someone more seasoned
like you thinks I'm saying "array of PGD entries" and asks "What's the
problem? That's, tautologically, what the PGD is..."

It's absolutely on me for not thinking to RTFM earlier. Thank you for
your patience. In my defense, I don't think there's any way I could
have known that "PTE" was a misnomer. The RISC-V team added a few
helpful comments in their pgtable*.h that probably helps people
encountering these MM terms for the first time through those files.
I'm considering sending a patch to clarify the comments on the ARM64
#defines similarly.

I've included a glossary of terms [1] in case this confusion comes up
again with somebody else.

> I find it much easier to reason about a start level (anywhere from -1
> to 2, depending on the page size and the number of VA bits), and the
> walk to always finish at level 3. The x86 naming is just compatibility
> cruft that I tend to ignore.

Indeed, I think this is probably what most seasoned ARM people do.
People who are first mentally visualizing the tree -- and specifically
Linux's intent with the tree -- will probably still be relying on the
PxD terms to bootstrap their understanding, however.

Thank you once again for your patience,
Sam

[0]: https://docs.kernel.org/mm/page_tables.html
[1]:
"PTE"
A newcomer probably thinks: "Page Table Entry, the final descriptor at
the end of an MMU walk."
Actual meaning: Bottom-most translation table *OR* an entry of that
table. It was once an initialism, but it's taken on a meaning of its
own.

"PGD"
A newcomer probably thinks: "Page Global Directory, or the pointer
thereto -- the thing you find in TTBRn_ELx"
Actual meaning: Page Global Directory or the pointer thereto *OR* Page
Global Descriptor: an entry of the Page Global Directory, which
encodes a pointer to the P4DIR if 5-level translation is enabled, or a
lower PxDIR if not.

#define PTRS_PER_PTE
A newcomer probably thinks: "Number of frames pointed from a single
Page Table Entry (so... er... 1???)"
Actual meaning: Number of entries in the "PTE," the final translation table=
.

#define PGDIR_SIZE
A newcomer probably thinks: "Number of bytes of VM represented by one
PGDIR." (or even "Number of bytes the top-level page table occupies in
memory.")
Actual meaning: Number of bytes of VM represented by *one entry* of
the PGDIR. The 'DIR' is a misnomer here.

#define PGD_SIZE
Actual meaning: Number of bytes the top-level page table occupies in
memory. Defined separately from PAGE_SIZE because it may be smaller
(never larger).

