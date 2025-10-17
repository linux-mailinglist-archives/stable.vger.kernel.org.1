Return-Path: <stable+bounces-187703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 448F1BEBD4B
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 23:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E495A4F3564
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 21:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0F9285C88;
	Fri, 17 Oct 2025 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hKOXyaIy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A07527702D
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760737275; cv=none; b=SEKVc/PpOWD3JpGiEQlOXUhgWZn3WM2/M2wZdyf9KLlemBsSXdJfBrqiXpV2bEPMnyUz4CHGtKKq1KQCGPgDf9Q470Ilv+XzD/aRClnu2QMFHicRd1r7qo7DBTHdGZkmT1adZJ5qqXhN3N27VaIcMrf1lax8RH5AXS+joWOUJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760737275; c=relaxed/simple;
	bh=LbSCBi7YHgOBOSv1RkeRxGYjWTCHG9myb35NiATlQ+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Njiu/HaP6f6ULue7z6OhFf240+xPuBn8T5u4MWOb7ARZv1QCv5dsp0WOb1RruW8dZ9PZWo9mXhZB1Sjx38x2yw1bOLlenaSTU5r3zkNs9S7jFJG8NxWU1ds3tRXUFaEB2RU0lPdqkaFLeXTgBRuIjzWiBLckuaERhtBGtlP7W3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hKOXyaIy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27eeafd4882so56875ad.0
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 14:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760737272; x=1761342072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoFe3a+bSPCtOzhTS3PznxfwWfc/KsW4h0kLBShN2vc=;
        b=hKOXyaIy/WuxXytygBPffSQlYQfIN5u9bfhlbfqggjBcFxkuh8RPF8SlYSb/IwQ5pM
         +iagsYX8eWylYI3cGZe2/GM/ezHE5BbwGpUJTBb57ViG12fIEcux96HM/5Ctw/J4NtFn
         N4vq5p8L8bBzROsXmRlPdbQgmHTLX/MF4icqf8CivSBA290zHbXkbabxszkAl5+XIrVE
         kA0B28MwmxSJl5gJBhdxMT08WCE6qDuv+D6y+eiH+hn0EN6r57mZmufkn722LJ2RLadi
         qW+OSiYQ6AWBLy+OOIuoVi5sTsT9uZ2lJevErDJGrkUXGyn/T7rOnS6YhFbft+G2g4jr
         OvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760737272; x=1761342072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoFe3a+bSPCtOzhTS3PznxfwWfc/KsW4h0kLBShN2vc=;
        b=v1qiZAraVLwX1P7fN5m5slbcvwGPBl8f38a2CkODx9ML/5KbZ4MXh88fRqvR8BSkau
         hI46BIwHziAfNc8eZWn/WKvoTEcd4N/tM+F6SpzWsWSN62HYK27fBPyFmwUxASXqVKNy
         g786ukkgc2w1kWbBTs3+R0liBchRMGVFAhemZlCcWr86Xj8+YGb2Zw6eCNs3QSujgFEe
         yiB1kl3Bj/gZ4Rjv8293rN/JjnjoUAb6seFWv9tOX/97Ph4iQhzgI+Rw3hRYj6wiMhic
         kqxPL6tG2l225A8Pji9W4pfTFY+SNxCFv3T21UD2i32Mv3AFzUh8sk4n4N7KvehfkxGV
         1zDw==
X-Forwarded-Encrypted: i=1; AJvYcCX1CBsMVoGq9fzrsbkF3wdCXEuB7E51izGX9BDvKHH/Vea8zVYys7M2J1t4SmLGg8v/sVCibeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqSEjZYejLVbVFcOGQtfrsjjnXJ66T/ICONx0kCVTgSshXAkJD
	nWyP+zoobvf3IBBByu//+W2rcQwzIAiVSOJtEjfRM4CcsA3xPYHh4W/GmgIa//8iV/vtE8TBIJM
	8J1kLsBv3yw963yf6e/v/oovz21LJF+Qnziylt6zy
X-Gm-Gg: ASbGncstoTddIbnRy9tqGVBu62gbG7sjm809XvjMBXBUCVnHu2HaaFkSWkB85ukMiHA
	eE9VuY7VYj7Nn0lcoVRYbQX/AKI3OEU1KldAPs5K71O2gB6av1P7btNF7hw4ejlODHhk5jBHYyy
	FaGj8Gbpmb5imMLV4cvthiBpHwUIzgkHBQBdD7o33YOuvsdOTPkspa9qavvC6Rmnm5oDe2ifqoV
	73ynnT5bz9MRjb4hooOS44/VPOHwTeRrr+9PDA9pRkjDxWOmZpwyNDt6q99Wbo0jO0t4mHK0wF2
	Hi2fOL5CW+Tzb3fokv9+XQdBHg==
X-Google-Smtp-Source: AGHT+IHtptS3qhjfptCTM9UYehBVmfrueMOSL7S+Pfi1w2W7eKNrIq2vjgUpRLWVN0ASJ4z7VbQlA14jLw5KQ0wBFc8=
X-Received: by 2002:a17:903:2ec5:b0:25b:d970:fe45 with SMTP id
 d9443c01a7336-29088aa6b1dmr17839645ad.1.1760737271933; Fri, 17 Oct 2025
 14:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013235259.589015-1-kaleshsingh@google.com>
 <20251013235259.589015-2-kaleshsingh@google.com> <144f3ee6-1a5f-57fc-d5f8-5ce54a3ac139@google.com>
 <098b030b-9d5a-4b1c-ab44-55bad474e70f@lucifer.local>
In-Reply-To: <098b030b-9d5a-4b1c-ab44-55bad474e70f@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Fri, 17 Oct 2025 14:41:00 -0700
X-Gm-Features: AS18NWDP3VNR9bpkGiOrp1S2qwrmystBtCXn8TObSk7Rzzc_acmKsNrgOHKkCec
Message-ID: <CAC_TJvct_KXyUuiO328MgrHnVPwvx995mEucvRPvNBa9zCekqw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm: fix off-by-one error in VMA count limit checks
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org, minchan@kernel.org, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, stable@vger.kernel.org, 
	SeongJae Park <sj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jann Horn <jannh@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 2:00=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Oct 13, 2025 at 11:28:16PM -0700, Hugh Dickins wrote:
> > On Mon, 13 Oct 2025, Kalesh Singh wrote:
> >
> > > The VMA count limit check in do_mmap() and do_brk_flags() uses a
> > > strict inequality (>), which allows a process's VMA count to exceed
> > > the configured sysctl_max_map_count limit by one.
> > >
> > > A process with mm->map_count =3D=3D sysctl_max_map_count will incorre=
ctly
> > > pass this check and then exceed the limit upon allocation of a new VM=
A
> > > when its map_count is incremented.
> > >
> > > Other VMA allocation paths, such as split_vma(), already use the
> > > correct, inclusive (>=3D) comparison.
> > >
> > > Fix this bug by changing the comparison to be inclusive in do_mmap()
> > > and do_brk_flags(), bringing them in line with the correct behavior
> > > of other allocation paths.
> > >
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Cc: <stable@vger.kernel.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Cc: Mike Rapoport <rppt@kernel.org>
> > > Cc: Minchan Kim <minchan@kernel.org>
> > > Cc: Pedro Falcato <pfalcato@suse.de>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> > > Acked-by: SeongJae Park <sj@kernel.org>
> > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > ---
> > >
> > > Changes in v3:
> > >  - Collect Reviewed-by and Acked-by tags.
> > >
> > > Changes in v2:
> > >  - Fix mmap check, per Pedro
> > >
> > >  mm/mmap.c | 2 +-
> > >  mm/vma.c  | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 644f02071a41..da2cbdc0f87b 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned=
 long addr,
> > >             return -EOVERFLOW;
> > >
> > >     /* Too many mappings? */
> > > -   if (mm->map_count > sysctl_max_map_count)
> > > +   if (mm->map_count >=3D sysctl_max_map_count)
> > >             return -ENOMEM;
> > >
> > >     /*
> > > diff --git a/mm/vma.c b/mm/vma.c
> > > index a2e1ae954662..fba68f13e628 100644
> > > --- a/mm/vma.c
> > > +++ b/mm/vma.c
> > > @@ -2797,7 +2797,7 @@ int do_brk_flags(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
> > >     if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
> > >             return -ENOMEM;
> > >
> > > -   if (mm->map_count > sysctl_max_map_count)
> > > +   if (mm->map_count >=3D sysctl_max_map_count)
> > >             return -ENOMEM;
> > >
> > >     if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
> > > --
> > > 2.51.0.760.g7b8bcc2412-goog
> >
> > Sorry for letting you go so far before speaking up (I had to test what
> > I believed to be true, and had hoped that meanwhile one of your many
> > illustrious reviewers would say so first, but no): it's a NAK from me.
> >
> > These are not off-by-ones: at the point of these checks, it is not
> > known whether an additional map/vma will have to be added, or the
> > addition will be merged into an existing map/vma.  So the checks
> > err on the lenient side, letting you get perhaps one more than the
> > sysctl said, but not allowing any more than that.
> >
> > Which is all that matters, isn't it? Limiting unrestrained growth.
> >
> > In this patch you're proposing to change it from erring on the
> > lenient side to erring on the strict side - prohibiting merges
> > at the limit which have been allowed for many years.
> >
> > Whatever one thinks about the merits of erring on the lenient versus
> > erring on the strict side, I see no reason to make this change now,
> > and most certainly not with a Fixes Cc: stable. There is no danger
> > in the current behaviour; there is danger in prohibiting what was
> > allowed before.
>
> Thanks for highlighting this, but this is something that people just 'had
> to know'. If so many maintainers are unaware that this is a requirement,
> this is a sign that this is very unclear.
>
> So as I said to Kalesh elsewhere, this is something we really do need to
> comment very clearly.
>
> Or perhaps have as a helper function to _very explicitly_ show that we're
> making this allowance.
>
> I do agree we should err on the side of caution, though if you're at a
> point where you're _about_ to hit the map count limit you're already
> screwed really.
>
> But for the sake of avoiding breaking people who are doing crazy things (=
or
> perhaps I'm not imaginative enough here :) yes let's leave it as is.
>
> But I really _do not_ want to see this global exported so, I think an
> appropriate helper function or use of the newly introduced one with a
> comment are vital.
>
> >
> > As to the remainder of your series: I have to commend you for doing
> > a thorough and well-presented job, but I cannot myself see the point in
> > changing 21 files for what almost amounts to a max_map_count subsystem.
> > I call it misdirected effort, not at all to my taste, which prefers the
> > straightforward checks already there; but accept that my taste may be
> > out of fashion, so won't stand in the way if others think it worthwhile=
.
>
> I disagree very much, I see value here.
>
> Avoiding referencing an ugly global is a big win in itself, but
> self-documenting code has huge value.
>
> In general mm has had a habit of hiding information as to how things work
> for a long time (when writing the book I really had to decode a _lot_ of
> this kind of thing).
>
> I think it's time we moved away from this, and tried to make the code as
> clear as possible.

Hi all,

Thanks, Lorenzo, for the feedback and support.

The consensus from the discussion appears to be:

- Drop this patch keeping the existing check lenient, but make it more
obvious and clear that this is the intended behavior.
- Keep the vma_count_remaining() or another helper and abstracts away
the direct use of the global sysctl_max_map_count.
- Keep the rename of map_count to vma_count
- Keep the selftest and tracepoint patches, which are important for
documenting the behavior and providing observability.

If there are no objections, I'll plan to send out a new version of the seri=
es.

Thanks,
Kalesh


>
> >
> > Hugh
>
> Cheers, Lorenzo

