Return-Path: <stable+bounces-108020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A46A0619B
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 17:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBDC188964A
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 16:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258C51FF1C3;
	Wed,  8 Jan 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGA7Pty5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692141FF1A7
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353113; cv=none; b=iJVCDSTclD8NaztnI0Y00UMpdl5uX+aL8AhykL+2NDumveHNdd05UZCyWf+rhHRhfp1x5HdERFatRtmGZ4T1taGr+XdERTW6NnyGGwmGawGwkBTg3QCH4mu88syprPu7fziKkLFi+yUiQntMpRAxYY12k7/VOZy4OqSpYjsr8/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353113; c=relaxed/simple;
	bh=l8nciXZdCXWkMHkwYtKNlWzhpUvPgx0ToMN/za6GYRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/VVyRUJGscbo2cFyr9M10vFJcjZNu2+uMqRyBpcRuHLpxuhEmO+RM+fgHI+Mw0HwYD0RAcrOYi7cBzAQCeDruhpLA/ZENnLmXjJVr+FCzL74SC6Qxi9Z0yBcdPjlY8rl6bv3WLL/61G5yazmzIj7FkDFM4T06U1GuOTXaHSelY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGA7Pty5; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d8f65ef5abso142562576d6.3
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 08:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736353111; x=1736957911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8nciXZdCXWkMHkwYtKNlWzhpUvPgx0ToMN/za6GYRE=;
        b=OGA7Pty5qk5KbjQ1YpkFmdVxLtwSeoH5PPtD9LA7HWCdlF4ncNWp4c37nBfSyeEyiD
         DzXSPoQRXLbLhdWoHpK5xwz1+L4NM6J8LlQ8qdlNQe5AERFVZDXw/AFNlRxj4DYrMCXL
         l6Le20YySOsbR+wGZgU59b0OkbzjGpG4ELPvCTIgwabR7vUprlBc4cBfCeQly4BS4qXY
         YtdYKa5Ds+idLlo84mO4HHj0sOLfHjnuMY1tFIGExZ9dPeyHAY9bwTIo04IHhw8DA16E
         uKyR0QkxGQaotqgP+i6JtXhCITEeevSQaJNGwV7AGQ5RjW5/lWYJ4Qqy1fZFmhSqzN5S
         u/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736353111; x=1736957911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8nciXZdCXWkMHkwYtKNlWzhpUvPgx0ToMN/za6GYRE=;
        b=ZWyvUfiH6aAV1iGOIHulopa5HYcp8jBmC5KSbgP5He06l7HjANn8/qluayR5B9VzpX
         evf/1qkkXLxqen8Tq6VwCrkeUhEdiwhLgTRP7p+FRUje1HUFbX3oeTtD8UpnmcTZlowl
         VyCgMLwZEZZfvPenKGWJXAYRSpzhDjelbM+1K8GfKwbk0zrsuoU7MIKpB2ZBE9r71x+4
         MEw99qlw/hfFiXi+TbWPEXWzzGVCDm9TDLrQmPz/wmBnzPRSDVdtbMnoFpfjnI/GMRBc
         gbjNTsr8UssikvEKa6tDImkJy5CmXQod5PgHSE5K5eJ8k+vOBQHEfnBgOpwtzbsl/Rra
         oSMw==
X-Forwarded-Encrypted: i=1; AJvYcCXD26dPTMc7Yf+oW+BpNd/Gu//BIdbM1/5sC8wSLKy/09UbaMdeeO9d0XdkmGy586QYgms86Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2A/W+X1FKyc5ugdIXN21r++QamSAiAxUv7z5N4h8/gG1TtbSR
	cOI18auhAF08ABxIrQwkOCUx2KPngiA5l4kyP5aMiKdy8W6wUUJMpB964fvKHUy8uqVCyuR9IlJ
	Dpy/gjVdtSJXiVZDjQkYhhidePQOHkpKQxn37
X-Gm-Gg: ASbGncu9mdUwcr2f1JmtIMk6QuFQqJYTgcFuFB9/3+fpNXLp/cej8T+ne+tnXpE12JZ
	cmYzvvLJTO79TtQzxnkTG74BNDX/A0fObkKM=
X-Google-Smtp-Source: AGHT+IG6TTmlND8nxCYVI9A3hNW0ShEnYrGsKYvA2J0EtQ0zHWAy66bALQi35JzUxDBvIbCjB1whsbOxtnNoUgNtoKU=
X-Received: by 2002:a05:6214:458e:b0:6d8:8b9d:1502 with SMTP id
 6a1803df08f44-6df9b2ddacamr55646176d6.30.1736353111271; Wed, 08 Jan 2025
 08:18:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107222236.2715883-1-yosryahmed@google.com>
 <20250107222236.2715883-2-yosryahmed@google.com> <DM8PR11MB567100328F56886B9F179271C9122@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkYqv9oA4V_Ga8KZ_uV1kUnaRYBzHwwd72iEQPO2PKnSiw@mail.gmail.com>
 <SJ0PR11MB5678847E829448EF36A3961FC9122@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYV_pFGCwpzMD_WiBd+46oVHu946M_ARA8tP79zqkJsDA@mail.gmail.com>
 <CAJD7tkYpNNsbTZZqFoRh-FkXDgxONZEUPKk1YQv7-TFMWWQRzQ@mail.gmail.com>
 <CAKEwX=OHcZB8Uy5zj8Dhq-ieiwpJFcqRXN_7=mbM1FD_h_uOOA@mail.gmail.com>
 <857acdc4-c4b7-44ea-a67d-2df83ca245ed@linux.dev> <CAJD7tkZ+UeXXvFc+M9JssooW_0rW-GVgUMo3GVcSMCxQhndZuA@mail.gmail.com>
 <CAJD7tkbb1W_de-8nFfNif8LrkDsw6VnZyPowAt67xBpV5mL3sg@mail.gmail.com>
 <CAGsJ_4y=kP1yhnpDmpTgs-6Dj1OEHJYOOuHo7ia3TjNq+JRYSw@mail.gmail.com>
 <CAJD7tkadoYEvCPx6wARTBDseWmroym=H8L60MPgbF5JJX+9OSg@mail.gmail.com> <CAKEwX=MWotmH2YOC-Sdb5Krzt43ogCy8kqJnCLDRm7Db=evDOg@mail.gmail.com>
In-Reply-To: <CAKEwX=MWotmH2YOC-Sdb5Krzt43ogCy8kqJnCLDRm7Db=evDOg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 8 Jan 2025 08:17:54 -0800
X-Gm-Features: AbW1kvYYIyqw2HhqcgWYVlUmfH9U2gZ9ZkW-Er8K65RxoPEAMwfExHefA843shc
Message-ID: <CAJD7tkaiGYSRXkG8eYRTkm_BBkPSHi2VAVzTsTHNgHydAzPZNQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: Nhat Pham <nphamcs@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vitaly Wool <vitalywool@gmail.com>, Sam Sun <samsun1006219@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 7:50=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Wed, Jan 8, 2025 at 10:36=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> >
> > Oh, I was not talking about my proposed diff, but the existing logic
> > that allocates the requests and buffers in the hotplug callbacks
> > instead of just using alloc_percpu() to allocate them once for each
> > possible CPU. I was wondering if there are actual setups where this
> > matters and a significant amount of memory is being saved. Otherwise
> > we should simplify things and just rip out the hotplug callbacks.
>
> My vote is for ripping the hotplug callbacks (eventually) :) In
> addition to the discrepancy in the number of possible and online CPUs,
> we also need a relatively smaller memory size for the discrepancy to
> matter, no? Systems with hundreds of CPUs (hopefully) should have
> hundreds of GBs worth of memory available (if not more).
>
> Anyhow, we can just go with the diff you sent for now (and for past
> kernels). Seems simple enough, and wouldn't get in the way of the
> eventual hotplug logic removal (if you decide to pursue it).

Yeah I sent that out just now:
https://lore.kernel.org/lkml/20250108161529.3193825-1-yosryahmed@google.com=
/

I will look into sending an RFC to rip out the hotplug callbacks later.

