Return-Path: <stable+bounces-166707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB40CB1C851
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 17:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7BA4723B69
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CA02918EB;
	Wed,  6 Aug 2025 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uk9ZeFMv"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0029AAF5
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492780; cv=none; b=PXj4K4C0CC5Afb+N1auKGGVF0gDTm6Nksp0Gn9tmMznEFGJ0Xg57YhnQApoGknX8AWnP+Al7la5v+kGOmsgZm9evCI3FJ4jvrdMU9MDFIWfHd7/bZ2+sfFI6ifQCEh144e7wqV3mIU1Be96+aXaBW6MShE5NvB4FYyVKWVQt5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492780; c=relaxed/simple;
	bh=1etKNrE0vlDHhfFeOKLaDNQ1jROjCc/S5wBeTrc5uNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmSyOQkXbaAIscSgmGEUxXMpsF4P0EK/Wh8UZmuYNI/99XBFEg3Fic00V6xHqfFAr+RZJM/jj/FRTeSqRafJjGd9DCszZUeu9fIstYqW2njQ6s8TLOk9avHtep6mbzqKWjJlvepau2Gu67iCPVZQqv/uOQIYtbrhBTj5xqQ1oV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uk9ZeFMv; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b07a5e9f9fso474731cf.0
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 08:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754492777; x=1755097577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMkdALPxV5bI1ddOoCXO/TX3xqYimqA7Ocq/kfBYHfw=;
        b=uk9ZeFMvMsilObK61ab9Jl1Io8oULrrCTX5SI8y2qbYsiy7dx8pt1PMOynd6lcyT+2
         XXHdMl12Of+NgByIo7DiJYGyhtm9tltnTy3AlI8tNupflqzAL9gYJXKJNhU1GJeKk8Ta
         /5Pvird8Syf4Z8K559jplU13anj4ebXW/YPeulnN5OdAsZdyhZ0MMhDajNCCwzZFJRGJ
         PMRViLOFhY1INFWJgDVwv8PkokNoV1e5TZtXmSC2O0h9AbhFhlRDuOrgMyz8OTuI8dUi
         F5n1F2tmtCabGGnPQVDZqdKOwwjm4qSySHocwNROKH6Itxp9Fq3Wp/xMiv5I1ZuRrePy
         gRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754492777; x=1755097577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMkdALPxV5bI1ddOoCXO/TX3xqYimqA7Ocq/kfBYHfw=;
        b=VX15O3JmnfFTF4ayLrDg00HLiQEUYNvdKDnREeNmT7GNrrGhM/WdXL3/pUkUMuUu5m
         OCvpFy8J18595NzUHvHO8RCDUjwNeUMNrV+lM3Ez/y64NldUSdx9QxHzT2xNZR+EDIpR
         jB9HQPGS+6hGgm1LRy2dx6HCsBfTyZU5XuHOw3m4JDwRt+8hYEgdICrugSqTQY48DdSE
         nC23JdyNpuAHR8YI5xpIYjlsl6OVjJUIYwJK7tSGGLxU7vC8zYp0CngmQrm2RKumXG+G
         b4HqZ5iQj6SrB6CZeG/J3PX0MbEGY/gpo23g41T8cZiAiaIMd0iQfQW7gUXxU9EK4C+Q
         e/4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZjZ7cMumpZtw1G/UDVBY0m8jlib+uZ0l6Zg/yKrcXzKkfKl1KZ+gYhEgkeh0JTmtoalfnECI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cfpevIbagpa21NA6fUaVDAclFPNJo8dbPqRr9aIXh4sv+10h
	IURCkXmZsEYO32CuAfVlrKt4sSFBp1pEOFxfx2HVoIkpq76cXLcvw7Y9Cwe9ftoqdQFdru9O5Wa
	8Z36mXR4qDQr4nIZZiPKEHfFtUSD2l9F3Er+htfjB
X-Gm-Gg: ASbGncvVAOG9i+pCzVvSsU7LznL3BtA0aarz/1ZEw9CxOw7eKqbKXzTLcSSWSD2gV3F
	uFU4sztfSY/+okCDXCBxvJR4X2poBLlhC3FLadkZHE52sazf4/PH3zdlBU7o3UBpn18euKSrZvS
	aRjuSkHddnG7qkoXid3ao5vdjCHWocfMYqaC9J8LPu2fRTXyICDCb1LjOMiNHitn7LRMxVGKZCO
	HzBuKXB39xxBTE4V7eVnR3XnC5yuh5Mqi+jeQ==
X-Google-Smtp-Source: AGHT+IFxjgJYfLtCzxTqC2qd/VGsYO0V9QbHxfH3kUKXYt+WP9H5eIIUksOBWWr2ADiUXznJbKHJFYhIUDbkwryBSWk=
X-Received: by 2002:a05:622a:38b:b0:4b0:8318:a95 with SMTP id
 d75a77b69052e-4b0904dbb54mr5571461cf.8.1754492776656; Wed, 06 Aug 2025
 08:06:16 -0700 (PDT)
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
 <CAJuCfpFeSVq+hq4JRJStLgFfQgmS6SQ7zoFsj4=SeQT89r3TTw@mail.gmail.com> <aJKkjEYmeq93w35-@x1.local>
In-Reply-To: <aJKkjEYmeq93w35-@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 6 Aug 2025 08:06:04 -0700
X-Gm-Features: Ac12FXyjlXEiW5mf5x6iYKFmYX_DWMhNB6rnZ5RUsIFipgSWRnXVMmPjiayC93I
Message-ID: <CAJuCfpGpEOaKdqpqTpfbw1cdHEEWhiu6KRFQFWaM-AKODiDFcg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 5:41=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Aug 05, 2025 at 04:41:18PM -0700, Suren Baghdasaryan wrote:
> > Ok, I let the reproducer run for half a day and it did not hit this
> > case, so I must have done something wrong during my initial
> > investigation. Sorry for the confusion. I could have sworn that I saw
> > this case but now it just does not happen.
>
> I'm wildly guessing you might have hit the numa balancing bug I mentioned=
,
> that might explain what you mentioned previously on the testing results.
> It might just be tricky to reproduce:
>
>   - We'll need a valid THP (pmd) first in the MOVE source region
>
>   - THP needs to be selected by numa balancing for a check (marking
>     prot_none)
>
>   - (before any further access..) UFFDIO_MOVE needs to happen on top tryi=
ng
>     to move the whole THP being marked as prot_none.
>
> AFAICT, task_numa_work() is the only place that can mark the THP, and whe=
n
> it happens, should see change_huge_pmd(cp_flags=3DMM_CP_PROT_NUMA) and th=
en
> returns with HPAGE_PMD_NR.
>
> [sorry I am still pretty occupied with other things.  I can try to reprod=
uce
>  together with you after I get more time back]
>
> > With migration entry being the only case that leads to that
> > pmd_folio(), the only check we need to add is the "if
> > (pmd_present(*src_pmd))" before pmd_folio(). Would you like me to
> > check anything else or should I go ahead and post that fix?
>
> We could fix the migration entry first, then if any of us can reproduce t=
he
> above numa balancing issue then it can be a 2nd patch on top.
>
> After all, so far we didn't yet prove it, either some unreproduceable tes=
t,
> or pure code analysis.  Meanwhile it might also be cleaner if we have one
> patch fix one issue, rather than having one patch fix two bugs.
>
> What do you think?

Agree, that seems reasonable. I'll post the new fix today.
Thanks,
Suren.

>
> Thanks,
>
> --
> Peter Xu
>

