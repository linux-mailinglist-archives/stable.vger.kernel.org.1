Return-Path: <stable+bounces-166715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC48CB1C93D
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 17:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A046A18C5C62
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 15:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2DE26E16C;
	Wed,  6 Aug 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qi026Le9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AC1291873
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495225; cv=none; b=eKCrivPgbvGrXj8mlzZspQ0L2e1Uu6vWemJtDTeXJ9ls+NdB4oIWU4c4wwoLiXDqISZbBJwzdnZc1GdcpJnvAtYrVpy1+PoHC6+PY01Xj4F4ssD9hqFWXvblKnXLJfHTSKmuTmH0LN7J4IzwvlrMHnMJL4JjkU2HQBm6ANrLeew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495225; c=relaxed/simple;
	bh=ZOGLQloafQdasXE+Cb5fdsgJ7PDLQAaGSaDVrlJWJd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMKiBu6OCetY+jsljaWbgLJQYBUoN7o6tTLn4N8rBq2Th5XtFrBiMy5wMXGABTh4+WDQmdH1lNeayKm73ftnAVGBuT5MHRz91X7tZcVpbDehNe0KMolPR94AfPp1gjusgUMjwJkJKMinEyctRX6kckZxBwPlrNSmxCk7ETJGXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qi026Le9; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b099118fedso235171cf.1
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754495223; x=1755100023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzR5hZORzLK1MdSlqmP/wfvTXuXPRKmGcAHBnX2kHxc=;
        b=qi026Le93K5Hywx/WGAE4oVWpXJ7qjMmFUqwZeAnz80XOhxS+JIEetTD1Z2VfXLhqE
         XAIGhKO8uJrzb4uqlyJ7RkfwYwH+KAYMFlooUDc8kvwbDUI4RSxFzRGUOUlMRzrT6yZd
         6u1raGlIT0EI2lZIR+uPrFAYI9hE8IKAzZ7iO70JT43IcuYBNCSpkEY/lpXnqyP8/4/d
         Fa1ampir+0dJGu1tkGxLsWwDiVhlNCkyd2DEfrPRAxf5pZpI7S0O7q4bef9dXJrYbM2c
         1c5dxuLzKFyJu97KLdmsuJtTbjyVN+rrlVQ3zT0/8LWZxPcdFhGSw+CrugpHGTQ3sqNk
         +hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754495223; x=1755100023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzR5hZORzLK1MdSlqmP/wfvTXuXPRKmGcAHBnX2kHxc=;
        b=GB9cTa7BRutIg8nWovH03fgbDC0EqkkdYUrlM+Ah6Cw3CaQhZ8lWJur6pMv74GRiv4
         RERkaRxCgBp75eep4t1blXcXlNoU2Qnh0TO0n1nKVrjLZUbqCZh4YOBYWIvISPgLkWXT
         ygfYx43sDp7Kj2gw+NBATXB3SDWQo8TrsLCFfzLXlPuoseY07txnQvQhU1VBsfl0FHcn
         2p8BI6OMkgWgHkDsXWvdJzHBZdPKWwaixV2Vhu83xFqFfXT86k0d+8m2P+w2CnDT8Mom
         o7NAQ6t1GsMIhafLA3TRS0KMrCCfQ6Xbx1rWw7u27VkuYVOin+S+bzzvLeb8W8uS+UYw
         H0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWa22w6FBe6IiNH6wAGk2ZU8qnqLPuAG3/tFHizZpQx3zJ/GzGZdXkRSdwh/scvGpqS1FU9z+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYY19PjRWIy3U30KrDsdEGKRRfKhrPacFC2FTEGcrYqWGqXSIq
	8ftrXvEZwLW2wF1hPi36xGUdzjTEy0ngnRvgd0CRaAcsQM+kc2Z1EZhhorO3WSKLaKLS1F4z70O
	WOJso5qhytYXTbNelzz6pKADpuQon12/0Ovpc7ALu
X-Gm-Gg: ASbGncva6Fns2/wcpH25zRkijhUVCRQ3ZCQo71XfeAgKID62Dfy3cKi6AoRQLvpQh0E
	sCITiRVKWDVRaqVz/NZ+zLK6WrsBtd9/fEcdf26i4On5m10L6EvUhRoUFgLjzOFiL2cNqqwDmsT
	TULgj+gPvZuHwyGehxJ3l3yFLl6VCP6KFBH4HBPbtMumuNmStmBSbsfnJVYbVMI9RthIiA+MzgN
	j0ylibr92Spdt7LtKSqC9r4gBsmPNhb8jW+kg==
X-Google-Smtp-Source: AGHT+IEYh053v3QF4PQwxhsLJXp/FIJIxdvbBIzUpxM1WEijiLmhfG9OEz0K75yz2Pw4+euNot61Qt8yZuFDMeSfSC8=
X-Received: by 2002:ac8:5894:0:b0:4a5:a83d:f50d with SMTP id
 d75a77b69052e-4b09276bd9fmr4745741cf.11.1754495222647; Wed, 06 Aug 2025
 08:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIz1xrzBc2Spa2OH@x1.local> <CAJuCfpFJGaDaFyNLa3JsVh19NWLGNGo1ebC_ijGTgPGNyfUFig@mail.gmail.com>
 <aI0Ffc9WXeU2X71O@x1.local> <CAJuCfpFSY3fDH36dabS=nGzasZJ6FtQ_jv79eFWVZrEWRMMTiQ@mail.gmail.com>
 <aI1ckD3KhNvoMtlv@x1.local> <CAJuCfpHcScutgGi3imYTJVXBqs=jcqZ5CkKKe=sfVHjUg0Y6RQ@mail.gmail.com>
 <aJIXlN-ZD_soWdP0@x1.local> <CAJuCfpFzP_W8i8pwL+-Uv-n+2LixgFrzqn2HsY_h-1kbP=g3JQ@mail.gmail.com>
 <CAJuCfpFEf92gTR+Jw+1wcCcT0fEt-SP193NHzpyxVXJA=VAwng@mail.gmail.com>
 <CAJuCfpFeSVq+hq4JRJStLgFfQgmS6SQ7zoFsj4=SeQT89r3TTw@mail.gmail.com>
 <aJKkjEYmeq93w35-@x1.local> <CAJuCfpGpEOaKdqpqTpfbw1cdHEEWhiu6KRFQFWaM-AKODiDFcg@mail.gmail.com>
In-Reply-To: <CAJuCfpGpEOaKdqpqTpfbw1cdHEEWhiu6KRFQFWaM-AKODiDFcg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 6 Aug 2025 08:46:49 -0700
X-Gm-Features: Ac12FXyLuMHK7bomXAcy0jhshEgEmzN6kvzy2ZCVRN5POfKeFAP3qWtXtAqAj14
Message-ID: <CAJuCfpE1y_bN9_8c-5mBsSQrFjAz69R8L3+w4GPYPPa0M_2z6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 8:06=E2=80=AFAM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Tue, Aug 5, 2025 at 5:41=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
> >
> > On Tue, Aug 05, 2025 at 04:41:18PM -0700, Suren Baghdasaryan wrote:
> > > Ok, I let the reproducer run for half a day and it did not hit this
> > > case, so I must have done something wrong during my initial
> > > investigation. Sorry for the confusion. I could have sworn that I saw
> > > this case but now it just does not happen.
> >
> > I'm wildly guessing you might have hit the numa balancing bug I mention=
ed,
> > that might explain what you mentioned previously on the testing results=
.
> > It might just be tricky to reproduce:
> >
> >   - We'll need a valid THP (pmd) first in the MOVE source region
> >
> >   - THP needs to be selected by numa balancing for a check (marking
> >     prot_none)
> >
> >   - (before any further access..) UFFDIO_MOVE needs to happen on top tr=
ying
> >     to move the whole THP being marked as prot_none.
> >
> > AFAICT, task_numa_work() is the only place that can mark the THP, and w=
hen
> > it happens, should see change_huge_pmd(cp_flags=3DMM_CP_PROT_NUMA) and =
then
> > returns with HPAGE_PMD_NR.
> >
> > [sorry I am still pretty occupied with other things.  I can try to repr=
oduce
> >  together with you after I get more time back]
> >
> > > With migration entry being the only case that leads to that
> > > pmd_folio(), the only check we need to add is the "if
> > > (pmd_present(*src_pmd))" before pmd_folio(). Would you like me to
> > > check anything else or should I go ahead and post that fix?
> >
> > We could fix the migration entry first, then if any of us can reproduce=
 the
> > above numa balancing issue then it can be a 2nd patch on top.
> >
> > After all, so far we didn't yet prove it, either some unreproduceable t=
est,
> > or pure code analysis.  Meanwhile it might also be cleaner if we have o=
ne
> > patch fix one issue, rather than having one patch fix two bugs.
> >
> > What do you think?
>
> Agree, that seems reasonable. I'll post the new fix today.

v3 is posted at
https://lore.kernel.org/all/20250806154015.769024-1-surenb@google.com/

> Thanks,
> Suren.
>
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >

