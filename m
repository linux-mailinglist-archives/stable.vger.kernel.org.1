Return-Path: <stable+bounces-158736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041ADAEAF4C
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 08:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7957A176996
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 06:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FC721885A;
	Fri, 27 Jun 2025 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGRcjnLp"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF25217F2E;
	Fri, 27 Jun 2025 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007348; cv=none; b=Ig0Dx5wm0HXoxPrSZ7IQ+KBCz038Rfr2FEKcfkF89MpURw+Gn2lEAoGVNjQU6B553Myk37K0ikwvuCZVdHENPlN0v8LoLyGiYTrdwczQF3lbg3hq4CQw/Iq7eoK5XOx5OpzS4FBaKlVC9QyrOtnsDdHfPzg0dzCJmix/xncOVAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007348; c=relaxed/simple;
	bh=AonkeL2UG9zbG1SpDxserAwv5MTYfIP9basgeC0vKE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tshwWtHhBrGwn+qc6znduZjT3HdYoBGl2i7Ge70IQbAhAnT2hsWfV8CTFwMBRScxQemShV8WLlwecJEBVD2UKlQ8y7ad+UUbFExcGZkSEiFl7eIc5WlLCCc2wUqZuqG0NE2wPb87ar1TKGUIlY4D6EKoCYMDudT4P1IxLTs0LHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGRcjnLp; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4e7fb730078so546577137.1;
        Thu, 26 Jun 2025 23:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751007346; x=1751612146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AonkeL2UG9zbG1SpDxserAwv5MTYfIP9basgeC0vKE8=;
        b=VGRcjnLp/nEYOax3eQVuQK3MApRAj+QwQd7bTqQgr4/eFyK0mJAjF7uc+tKTb+gvIB
         fmmiu0DGXu0kVJyIQs0qz0RRnmAvYJp4lHbBsHIRj+6uqBmyIqUagVK/k3TPD2vn726O
         wt2g4klpoCuO0lUbgj7kED+1pJyIkvAZfpc7IGpCUIkMxcMCBA799ZKW2Llwhn+b2sVr
         rk020UM3ww+3vKPKgACz0rG5IdlUxR+ZkL93yudsV0/rFfQ96w8NsOYKrTrOLiUGTRIk
         hvk9W5uFxFD8tIwhOTRZiHSsDYZksjQ1YyvVBO5a0JA0bpaLo6QWsuAa28bZbfxgjRSF
         PGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751007346; x=1751612146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AonkeL2UG9zbG1SpDxserAwv5MTYfIP9basgeC0vKE8=;
        b=VgHhtLMFFPnU1vTFSXRUipUH0JqXTCIs/OJjqtw5D/0zO17IgkFTxhzV0N7BeUYmUf
         6zytMaZBvT82tJQasxe4oSrYnahfw2ChhBS3XJEWNQKstg93i8fmchDphFvfHmjUvKNE
         yAk2sQe04NPgfv3xCsjKiIjc+h9FxZ9D/FxWsc8EPnpJeimh6KUjx61pOABWlm9lDDQu
         IOb/R35FggnUJkQagdej9DSz9JNaieUWZicBcstMF0/riPGHcSCL9bXdpG40ErBCU8bO
         Cdux8rDBJicRar5PloWTfR9TOhv+VISG2nhPowfbsRi1+JacOezrGcYGk5xRdas6BepL
         5bfw==
X-Forwarded-Encrypted: i=1; AJvYcCWRZj7GUEXzmYAcX8B+xCA7YLLaAS7lLevlPQpSlgEbJMM4l04QLZkxAYvCNyjRk4yT4dTWLjYM@vger.kernel.org, AJvYcCXa4TIzVxplxrCkNmoFUR+rf/PqFZRPegfIUQxd+whVvAYZ2AqurAxsAJyn9W85T6qDAor2lXrmN98awTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv4ipa9g0rj5KmfC6JBHH3YrkJO6X9H49s6gcbXW5Vbwj/0x54
	cnhL4+/RKtq5wLHDKm7zpP0e6McPiQhV7rn9reDNeTkuQ0NuYDJH548UaXjejzOzQ/4OIEmhJZR
	7cMtZgEN87yCDPZ1UDZScWJFHIHETV5Q=
X-Gm-Gg: ASbGncsBPh1wbv1t8Yumpt6BXXbtcmbrNIEG1CKVgF0IurntuUlRhQeiKVJthWevpe/
	t3ReKD4oriADhqkuRDds4P9po/8vRgGp55TtdKLVtD0WuR9wdTuYJ77muMqKnpFjp3nsHmMoM1W
	YC38vezFvYDQ1KTHvdLM38Z5jOkxu0MT5OJCsqYleQI4bewbl9cbe0sQ==
X-Google-Smtp-Source: AGHT+IHID72abIG7KO9tY0TMUT/7rvTScdoSDX7SF0tYvqk7dfZNu62uOYY7u8MoIAmAQhMkN3cJSxhZsgMz1pZQ9R4=
X-Received: by 2002:a05:6102:919:b0:4e5:acea:2dec with SMTP id
 ada2fe7eead31-4ee4f6a6083mr1641746137.7.1751007346178; Thu, 26 Jun 2025
 23:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627062319.84936-1-lance.yang@linux.dev> <CAGsJ_4xQW3O=-VoC7aTCiwU4NZnK0tNsG1faAUgLvf4aZSm8Eg@mail.gmail.com>
In-Reply-To: <CAGsJ_4xQW3O=-VoC7aTCiwU4NZnK0tNsG1faAUgLvf4aZSm8Eg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 27 Jun 2025 18:55:35 +1200
X-Gm-Features: Ac12FXxvwUg1I8DIO0v6b56l2GT04XdFM5Ht5dpca7QYboGTabvmi5kE5vPkba0
Message-ID: <CAGsJ_4z+DU-FhNk9vkS-epdxgUMjrCvh31ZBwoAs98uWnbTK-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/rmap: fix potential out-of-bounds page table
 access during batched unmap
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, baolin.wang@linux.alibaba.com, 
	chrisl@kernel.org, kasong@tencent.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, lorenzo.stoakes@oracle.com, 
	ryan.roberts@arm.com, v-songbaohua@oppo.com, x86@kernel.org, 
	huang.ying.caritas@gmail.com, zhengtangquan@oppo.com, riel@surriel.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com, 
	mingzhe.yang@ly.com, stable@vger.kernel.org, 
	Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 6:52=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Fri, Jun 27, 2025 at 6:23=E2=80=AFPM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > From: Lance Yang <lance.yang@linux.dev>
> >
> > As pointed out by David[1], the batched unmap logic in try_to_unmap_one=
()
> > can read past the end of a PTE table if a large folio is mapped startin=
g at
> > the last entry of that table. It would be quite rare in practice, as
> > MADV_FREE typically splits the large folio ;)
> >
> > So let's fix the potential out-of-bounds read by refactoring the logic =
into
> > a new helper, folio_unmap_pte_batch().
> >
> > The new helper now correctly calculates the safe number of pages to sca=
n by
> > limiting the operation to the boundaries of the current VMA and the PTE
> > table.
> >
> > In addition, the "all-or-nothing" batching restriction is removed to
> > support partial batches. The reference counting is also cleaned up to u=
se
> > folio_put_refs().
> >
> > [1] https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857fc=
be@redhat.com
> >
>
> What about ?
>
> As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
> may read past the end of a PTE table when a large folio spans across two =
PMDs,
> particularly after being remapped with mremap(). This patch fixes the
> potential out-of-bounds access by capping the batch at vm_end and the PMD
> boundary.
>
> It also refactors the logic into a new helper, folio_unmap_pte_batch(),
> which supports batching between 1 and folio_nr_pages. This improves code
> clarity. Note that such cases are rare in practice, as MADV_FREE typicall=
y
> splits large folios.

Sorry, I meant that MADV_FREE typically splits large folios if the specifie=
d
range doesn't cover the entire folio.

>
> Thanks
> Barry

