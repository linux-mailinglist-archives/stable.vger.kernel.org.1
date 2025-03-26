Return-Path: <stable+bounces-126653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39359A70E57
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815E63A4AA8
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 01:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E67F1F94A;
	Wed, 26 Mar 2025 01:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="k3yXd/TA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241E6323D
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 01:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742951248; cv=none; b=LhCDBkucR7Bu9nfRTaHu8Tz60BVkZSk7nW08tcKc1s6gHfFlX30KYOBJ7szmR7s19eiDZNQlr9tQAzy2NJbiXcFAYvFdJ23H3IcIFXWqWwEwPmCR3RWZS8u93CKZa//Ry4E2OBELGPDwWLI3WFJEYt3VgJ4T5YUyutyn8GcOqLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742951248; c=relaxed/simple;
	bh=GB7EpVcR6NEX2lBOtj62/LJ/2M9DQsTZoztmOUYMKyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHbKKTG8Y7L4DU89KSkmYNq4SIimBcx4wvkyvm/G6ZefzM/igAQGb2liFpy+lTxim9u/Kbdl6+rcNIeUSRYbtr0hQpiDWQxIVkKUlqaJCZGeGGzfZLjPMNav2D1GCeoULFX5Orh8gU4BuDRgnSlAv38C7cZP/jCyNLrFRfEiMBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=k3yXd/TA; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54ac9b3ddf6so6260990e87.1
        for <stable@vger.kernel.org>; Tue, 25 Mar 2025 18:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1742951244; x=1743556044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebWObAEjDwTa1ZALP9z9XN5mnKCveRcG/gIaI1Y+RbU=;
        b=k3yXd/TAWtGzh+qyy6x9v72uxzUAZZWa5JFrg/SSglVWogakFQC9FScVGqoIcq3804
         kSgRyu2AhrPvUxgBPCA2OjSlVZMW2PeYlZmbE22J5qqKaHAspAP7sXbUM2bhmtd9PenV
         r9XsIUavf7YQyCK0q58303N1sZP8mJczhamHyZzdxB69Ir7UH0WkS9dyJcqTXO3xCnC/
         fNK/lnJEfmkxuQ0nUTWvXbH/n08Y9O1G0yx1K6/SgFlfvExgzlmbs7aJJL3sg78wSkIn
         CN0MRTXqdGF0Es1fjiEQCGYkpgppvVQM9NHPWBGJIGH6Cq59f/ypY5REyhsJ01waQ88W
         7JnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742951244; x=1743556044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebWObAEjDwTa1ZALP9z9XN5mnKCveRcG/gIaI1Y+RbU=;
        b=kPgUdpUCFvzf6LvChZZXaQbrdQb2tuf++eTzoo2MU4ByRQPoToFLhiI/hQd8Tvku36
         9oIOlk/tedk4zekZKA+tmw4zeIYfNFgtSxXgBn3Z7NU/Dq3QHpkN1w45LrZxUnbQezYt
         u3gbErjWOHVeiw0jCJJbik1mYBxfNfABApG+FdBbcvaCDZ1YV2VcB6RKiNtrX/1w3qBz
         yOX+nW3UoloLYXMUV6LGKRK+5H4cTTd6tO+PKai3flWkp8PvKZz7uPf4zBEW29sRe2Q0
         n7meJopcDAHjXnAedQb/MhSCfoG0k8Q2BcTsp1+zmZ2XA8XuXJDN0wOuzNpnD1EU+9ry
         2Iaw==
X-Forwarded-Encrypted: i=1; AJvYcCXaqHgTBys8Ka42q9e6uovI9NsNFBwCrL5/FyBUlZRM5eKcTB3ih1il6Poh8gAPt/YR8Q6z4hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDmrMLZoltBHnmip+SSKMj3qfxtTWg/r9H7HfSVP7V6h7u99Y0
	/G9ilgxGMpvRs+jVIggUzYGktP33qd0WpPORNxs+kLmk1CvVJM/EfSYmKPZwDvSUMmnz8RKkVdf
	6fVOQDtCp3qwRA5TtecORZL+GXylHVRreihRV
X-Gm-Gg: ASbGncv0TpDURVi6331oMx7lu6ElUZl/tEFRuazZN9SOZg/uct0wTu114AcH277ADLS
	dHHt66ziGI7VZKyqwvOZ3YTsfaLKv1W2pnlePAJP7TldCygQLlFMN6V0iRQExoVtRQ/GwyKIock
	+EZzLEpcD++12queOdKyANgopZhES0VFUBxK48XElZ7tnPeRez1Zekj0NOYreG
X-Google-Smtp-Source: AGHT+IH7TM3F7jlmDsLKgKzqrF23j/7sETlcRtQxbTMm204UEDEJhjFOyrdMaWA1XVoAAzd5aqRVszwqj2x01XHjlF8=
X-Received: by 2002:a05:6512:ea2:b0:544:ffbe:cd22 with SMTP id
 2adb3069b0e04-54ad6500d8fmr6121822e87.46.1742951244095; Tue, 25 Mar 2025
 18:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABEuK17=Y8LsLhiHXgcr7jOp2UF3YCGkQoAyQu8gTVJ5DHPN0w@mail.gmail.com>
 <20250326001122.421996-2-s.gupta@arista.com> <2025032553-celibacy-underpaid-faeb@gregkh>
 <20250325203236.3c6a19f4@batman.local.home> <20250325203723.53d3afde@batman.local.home>
 <2025032554-compile-unlivable-0fb4@gregkh> <20250325204731.24f26003@batman.local.home>
In-Reply-To: <20250325204731.24f26003@batman.local.home>
From: Sahil Gupta <s.gupta@arista.com>
Date: Tue, 25 Mar 2025 20:07:11 -0500
X-Gm-Features: AQ5f1JotQJGJL-wOpQ-ndkNWku8ztpt_4hyBcJOSYGJ9gDDIUlBux6XX0Yi5PWc
Message-ID: <CABEuK16RdmvpbK5CpcuYrzdo_1GK-8eUkmb5x1BKk9bPcw3weA@mail.gmail.com>
Subject: Re: [PATCH 6.1 6.6 6.12 6.13] scripts/sorttable: fix ELF64 mcount_loc
 address parsing when compiling on 32-bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>, 
	Kevin Mitchell <kevmitch@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Works for me. At least from our previous discussion, it seemed like
backporting would be laborious, which is why I offered this
alternative patch. But if we can just backport the series, then
there's no reason to not do so.

Thanks,
Sahil

On Tue, Mar 25, 2025 at 7:47=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 25 Mar 2025 20:45:00 -0400
> Greg KH <gregkh@linuxfoundation.org> wrote:
>
> > On Tue, Mar 25, 2025 at 08:37:23PM -0400, Steven Rostedt wrote:
> > > On Tue, 25 Mar 2025 20:32:36 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > > I guess it is loosely based on 4acda8edefa1 ("scripts/sorttable: Ge=
t
> > > > start/stop_mcount_loc from ELF file directly"), which may take a bi=
t of
> > > > work to backport (or we just add everything that this commit depend=
s on).
> > >
> > > And looking at what was done, it was my rewrite of the sorttable.c co=
de.
> > >
> > > If it's OK to backport a rewrite, then we could just do that.
> > >
> > > See commits:
> > >
> > >   4f48a28b37d5 scripts/sorttable: Remove unused write functions
> > >   7ffc0d0819f4 scripts/sorttable: Make compare_extable() into two fun=
ctions
> > >   157fb5b3cfd2 scripts/sorttable: Convert Elf_Ehdr to union
> > >   545f6cf8f4c9 scripts/sorttable: Replace Elf_Shdr Macro with a union
> > >   200d015e73b4 scripts/sorttable: Convert Elf_Sym MACRO over to a uni=
on
> > >   1dfb59a228dd scripts/sorttable: Add helper functions for Elf_Ehdr
> > >   67afb7f50440 scripts/sorttable: Add helper functions for Elf_Shdr
> > >   17bed33ac12f scripts/sorttable: Add helper functions for Elf_Sym
> > >   58d87678a0f4 scripts/sorttable: Move code from sorttable.h into sor=
ttable.c
> >
> > Backport away!
>
> Actually, I only did a git log on scripts/sorttable.c. I left out
> sorttable.h which gives me this list:
>
> $ git log --pretty=3Doneline --abbrev-commit --reverse v6.12..4acda8edefa=
1ce66d3de845f1c12745721cd14c3 scripts/sorttable.[ch]
>
> 0210d251162f scripts/sorttable: fix orc_sort_cmp() to maintain symmetry a=
nd transitivity
> 28b24394c6e9 scripts/sorttable: Remove unused macro defines
> 4f48a28b37d5 scripts/sorttable: Remove unused write functions
> 6f2c2f93a190 scripts/sorttable: Remove unneeded Elf_Rel
> 66990c003306 scripts/sorttable: Have the ORC code use the _r() functions =
to read
> 7ffc0d0819f4 scripts/sorttable: Make compare_extable() into two functions
> 157fb5b3cfd2 scripts/sorttable: Convert Elf_Ehdr to union
> 545f6cf8f4c9 scripts/sorttable: Replace Elf_Shdr Macro with a union
> 200d015e73b4 scripts/sorttable: Convert Elf_Sym MACRO over to a union
> 1dfb59a228dd scripts/sorttable: Add helper functions for Elf_Ehdr
> 67afb7f50440 scripts/sorttable: Add helper functions for Elf_Shdr
> 17bed33ac12f scripts/sorttable: Add helper functions for Elf_Sym
> 1b649e6ab8dc scripts/sorttable: Use uint64_t for mcount sorting
> 58d87678a0f4 scripts/sorttable: Move code from sorttable.h into sorttable=
.c
> 4acda8edefa1 scripts/sorttable: Get start/stop_mcount_loc from ELF file d=
irectly
>
> -- Steve

