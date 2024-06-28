Return-Path: <stable+bounces-56089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D626991C5A9
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 20:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1255C1C22EB7
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 18:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCD81CD5A0;
	Fri, 28 Jun 2024 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI30o1qA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD082DDC0;
	Fri, 28 Jun 2024 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599251; cv=none; b=X8bSIZzq31sj1NeAn85Oy0XfnTtgsqwVqS10+fZjmXUXnQX4PmUej0zk6GH0/81IaET9FjtvERiwNHFHq0OUJh0yKSiVbYGZy0l6iKqde89DyOupsqKghLPiTCo/7D2m4Mjr352dQjN2t/osxnuSQI53zCXQ9B+1xs8TX/llDgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599251; c=relaxed/simple;
	bh=EoIMkdip0Jqkq5yLw0PSMZmQ3Q58+ZzMoc5HAn1XXLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbIm2Wuia+lgFy94Ka1j/jB02c2vN1ehdcXvPOcM/8JgPSh9r15z/BAl+wA5dbfy4FN3QDJ608N0AOE+sYnuxFpsoYTEZqgRM80BK8NTJXilSxTrgotCfBWlOt81e/UXqfs011nCu6ADQb1+3wK+flnn9nLJFd2QpsRoLoi0BCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI30o1qA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec58040f39so8868281fa.2;
        Fri, 28 Jun 2024 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719599248; x=1720204048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgGUkmn1jPeeQuMXMcfk1hTstH8mcemeot+l8YFexZY=;
        b=GI30o1qAMbHkJLUO5EW5BTAZ3xJa6KaguK7UJ9zEidYrgO0EI9hEUclEwctgjRPRoB
         Hdzq81WTikfhnJU05GBLg5TOYFBGZqgCyhrsYaQv5pqRQDYQQkF4ykpeZsSqK39bhMVl
         E/B8UeF6PNTyy/00+v06quOEQM/YbrfraevBf1meIdfJWIajrpe47sbFdc55ZU+5IvZm
         q2EVKkdKAVXSCo22gMZuyhZUp48ySdhCFu4prp1RWKEdlJuq7rFLXGZiLj+Tvs9lcYmJ
         ediAf3qorZ/eX1xHBzA0qYeE39YyC14kNhYZL8VYx4+bLjScO5kzyWyd1ojLej3crKlS
         z0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719599248; x=1720204048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgGUkmn1jPeeQuMXMcfk1hTstH8mcemeot+l8YFexZY=;
        b=XZm20R3yE+g3jDkUXza+GwxmMezLCK6WEjPH3uYEVgr1lrkcODl2GixLxyztpHSF4u
         KngAqIA/C1qyQdEGyZ6hNLI72ICQ0n1S/K4mZts1/zM+/tzbOl1TaXwMhXkYpsGt/epm
         s4NK60Q5qf6VJyhlIvqeul9Dsx8zvdL7+L89IyqIHrfvk/4sXAc/hfNBUqC7P6cO8VS8
         JnIHofcsDD5Ju7rG3Y0tQPIB8lil37ucKfX4Hhki5JyDyFoB0LYdhJ/vCRC+hZvHj+F0
         N1YSui13+zkaPFXRvgHpXb2aizSuPHdJc6r/mUpL3cW2OkeSa7ABET5yaCYSpStFP8kN
         JAIA==
X-Forwarded-Encrypted: i=1; AJvYcCW7T4Fg/8a+yJOu7pUigMLsXj63v2W47fAXOHjiS8dHjMyaCYJlTcUxRuMD7E0kBtyrHIF2IT1lszb0ESc81YAqarFl/THD7zekCROMPs/pqmFVpDoNDIKclLTPBErQDwFCrqIZ
X-Gm-Message-State: AOJu0YzTkkUAyIb/wcNWJCvPeB3ZjozvcF0ooIayzkH9+++y83Bsnd8M
	kKrvyES6K6Rm6tPTeQXAv853An5TEACyNk9gexyWd+bwpW8BkJ561mstPKgtSLND0nCMNI8PJoR
	+0ccDr25M3n0HVkfMy50ykwUYTZwWkQ==
X-Google-Smtp-Source: AGHT+IHS2YMlbAwnhePYHqSgke0BKfxRk6YNzoY3zHWvbGGz8ba49/3S2DgaqWbp8u3oQrZOZoMWNMsUfdQVPv11hRU=
X-Received: by 2002:a2e:87d3:0:b0:2ec:500c:b2e0 with SMTP id
 38308e7fff4ca-2ec593e0cc0mr112746701fa.22.1719599247749; Fri, 28 Jun 2024
 11:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627221413.671680-1-yang@os.amperecomputing.com> <Zn5ZmPQCdvHTCwAn@infradead.org>
In-Reply-To: <Zn5ZmPQCdvHTCwAn@infradead.org>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 28 Jun 2024 11:27:15 -0700
Message-ID: <CAHbLzkodRFsBWvZ8zZZVeFTNzrwV0PNpT2XmUwFxL1KygPmd4Q@mail.gmail.com>
Subject: Re: [v2 PATCH] mm: gup: do not call try_grab_folio() in slow path
To: Christoph Hellwig <hch@infradead.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, peterx@redhat.com, yangge1116@126.com, 
	david@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 11:35=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> > +int __must_check try_grab_folio(struct folio *folio, int refs, unsigne=
d int flags)
>
> Overly long line (same for the external declaration)
>
> > +     struct page *page =3D &folio->page;
>
> Page is only used for is_pci_p2pdma_page and is_zero_page, and for
> the latter a is_zero_folio already exist.  Maybe remove the local
> variable, use is_zero_folio and just open code the dereference in the
> is_pci_p2pdma_page call?

Thanks, Christoph. Good point, I think we can use is_zero_folio and
open coeded it in is_pci_p2pdma_page.

And all the format problems will be solved in v3.

>
> > +             ret =3D gup_hugepte(vma, ptep, sz, addr, end, flags, page=
s, nr, fast);
>
> Overly lone line.
>
> > +             folio_ref_add(folio,
> > +                             refs * (GUP_PIN_COUNTING_BIAS - 1));
>
> Nit: this easily fits onto a single line.
>
> >                       if (gup_hugepd(NULL, __hugepd(pmd_val(pmd)), addr=
,
> > -                                    PMD_SHIFT, next, flags, pages, nr)=
 !=3D 1)
> > +                                    PMD_SHIFT, next, flags, pages, nr,=
 true) !=3D 1)
>
> Overly long lin (same in the similar calls below)
>
>

