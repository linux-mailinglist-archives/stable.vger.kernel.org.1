Return-Path: <stable+bounces-158426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F20C1AE6BA5
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 17:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5731C23A10
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06C63074B8;
	Tue, 24 Jun 2025 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6bsenxM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E3A274B27
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779501; cv=none; b=eDRH5Hby7fZecCVmXIdD3k1CvHuM8EJdN1YTNbeL8lCcXrnC/OWftUEwBw1Y/ZKe2Kdm+cSOA43/19V+274n7SFl+o8CS/70cmiczPDzY/mRU9tLd36fnkitROhP+C0yZIWaMj0AA6mmRJ+rJyVdUuhlykh/z7hpW3SRtPP+dLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779501; c=relaxed/simple;
	bh=J87JnLK8pJaBItcf6vx+C1/Pv98OeDLbGnI30SgOefM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNoEHnLiUKVv9XBH9e9/nfwQWZkUg6SqWpfJU2ODgERSN+3cribGohQWvd/1qKNVOAvaI8D4odAFsrtdZlMY05G1xdapsqevfR/KROqaBoz/C7L+xPM0tjT5k5OQvO4z5hXmGD09R8fU/I+BGm9G6RZ8/R5IE033f2DQc8MRt+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j6bsenxM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a58197794eso191561cf.1
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750779498; x=1751384298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cq//EZtJtX/3kG7Q6lYMli8iIFmWk2rlPi0wEzAHGhI=;
        b=j6bsenxML4dCrGiYn7aw/tN+QYu3STFvgE9xi5Khh76E6qKZ/4g95OOxmU4tIIeTAX
         aIXZCL1bnrKH9ob/FmU0I5MiuRADyso3FdoDotGLUdypD2QgHFl6YfBtlwUD0LHMfGnl
         RKCRmAyALUqiryj+cP2W/QfYBxgWFJNL1VaM8RqOqoX82iAaui2fqWXkeJcvceiHaB6B
         FkCAA3YbF69uNPCG9YEgMAXTmjKxx/M+3hgzmO39+8QKcTdrUYDCSPM7PmY4wAubMAZL
         t9MMKPR0GCH3RHFRdk3CfvzryT38I6tL+AxBwz1S8OUD/v9L6mFJTGZLDyPZjFwLDH+Q
         +9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750779498; x=1751384298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cq//EZtJtX/3kG7Q6lYMli8iIFmWk2rlPi0wEzAHGhI=;
        b=eKLNJVW9NoaAeTbEsCSc7AXeLxUBpiGrA4vYPV+ozyj9+3IlMFCdPDxx6EwdqTdirF
         fxli8FnVC3AzE/D2pClvjtC1bllC7UCWuVafAFTdB7L5Y+DmKpKeOwczUnovMiuiQQH1
         D/pdePKLZfeX90iT/ptxUFLOeGpluUxzQ8ZU4qFRwZUTv/CCW5HSMqcr1arVauMt/MFe
         5cMwhUOE14RFkfXjKYy2h25OUvwS8GBb5wngeDYyxtkfKG8zZT+F0AAyrvN7PzfG/AKo
         9q0UKyL6nOFTKhIpx4C4pt7N/J2wdpkCJBymCBJuNoonbLSanZgvkKplIoNHQRO+XTvD
         QsyA==
X-Forwarded-Encrypted: i=1; AJvYcCW8I01PYLG1mWiE0EKo3lHtw84G1LaFAtshF17z2lmUpIVlCzfA1Tcwbx9hDIM8qgm736YuKhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjmquwR/xcn8kVPV43YZa++QkI4d9NjvilFu3ulczK24lFTIiB
	/xz+6Z1/buyk2gzUDx6AVCCf8+SaeiCB8UkQwwG9anN+mewN064BxQ4XioRcm0vgLCu7nY85yj7
	MDf/TrGRP1ynYmewQLMfpcW2Cb6UKb+Wpk+49zgxK
X-Gm-Gg: ASbGnct52HFkEhodYzlP47TTGvrsfV8b36nefq5TFecDNBmvflYcz4tIPjEH2LT4qjR
	skqUKTsEF8ojQQzxOz7TA5bb7+loRTU78HLtdZ2r+lyRqeXCi8QBlNszsl6zQyZLM6/1Y3JB1x7
	YOxuBRFiGEIfoJNuW8knKTrUnCb9cW9tx/tsEP15FNUSCO5KQV6gixkuEbiwHYBv4q5/RFcz977
	Q==
X-Google-Smtp-Source: AGHT+IHqGEoyCIb1kL6lCMHniFW2jNWsQ0MDjwjsbUEUDfZx7ba1RHnCsgxlTPT2lF8ldtmvuCceUKiyaAMBnv0QXWg=
X-Received: by 2002:a05:622a:7a8e:b0:498:e884:7ca9 with SMTP id
 d75a77b69052e-4a7b16ec589mr3514991cf.13.1750779497561; Tue, 24 Jun 2025
 08:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624072513.84219-1-harry.yoo@oracle.com> <7f2f180f.a643.197a21de68c.Coremail.00107082@163.com>
 <aFqtCoz1t359Kjp1@hyeyoo> <2dba37c6.b15a.197a23dcce2.Coremail.00107082@163.com>
 <aFqynd6CyJiq8NNF@hyeyoo> <3942323b.b31d.197a2572832.Coremail.00107082@163.com>
 <CAJuCfpGd+jHoCdyuEbk5h-dbQ7_wqgX=S4azyb6Aou8spzv0=w@mail.gmail.com> <aFrAwJEkjYFAuVOa@hyeyoo>
In-Reply-To: <aFrAwJEkjYFAuVOa@hyeyoo>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 24 Jun 2025 08:38:05 -0700
X-Gm-Features: Ac12FXzTGdsWvqL0LrY5iFd5379W7uqXNVh49LPmxI4wKUIDJuIADKSM0EDsg-w
Message-ID: <CAJuCfpEXAX5BJiA94pYYAqe22uo-Ngfw-+ZFZkt57SnHPMsY5w@mail.gmail.com>
Subject: Re: [PATCH v3] lib/alloc_tag: do not acquire non-existent lock in alloc_tag_top_users()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: David Wang <00107082@163.com>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	oliver.sang@intel.com, cachen@purestorage.com, linux-mm@kvack.org, 
	oe-lkp@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 8:14=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Tue, Jun 24, 2025 at 07:57:40AM -0700, Suren Baghdasaryan wrote:
> > On Tue, Jun 24, 2025 at 7:28=E2=80=AFAM David Wang <00107082@163.com> w=
rote:
> > >
> > >
> > > At 2025-06-24 22:13:49, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> > > >On Tue, Jun 24, 2025 at 10:00:48PM +0800, David Wang wrote:
> > > >>
> > > >> At 2025-06-24 21:50:02, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> > > >> >On Tue, Jun 24, 2025 at 09:25:58PM +0800, David Wang wrote:
> > > >> >>
> > > >> >> At 2025-06-24 15:25:13, "Harry Yoo" <harry.yoo@oracle.com> wrot=
e:
> > > >> >> >alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_l=
ock
> > > >> >> >even when the alloc_tag_cttype is not allocated because:
> > > >> >> >
> > > >> >> >  1) alloc tagging is disabled because mem profiling is disabl=
ed
> > > >> >> >     (!alloc_tag_cttype)
> > > >> >> >  2) alloc tagging is enabled, but not yet initialized (!alloc=
_tag_cttype)
> > > >> >> >  3) alloc tagging is enabled, but failed initialization
> > > >> >> >     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))
> > > >> >> >
> > > >> >> >In all cases, alloc_tag_cttype is not allocated, and therefore
> > > >> >> >alloc_tag_top_users() should not attempt to acquire the semaph=
ore.
> > > >> >> >
> > > >> >> >This leads to a crash on memory allocation failure by attempti=
ng to
> > > >> >> >acquire a non-existent semaphore:
> > > >> >> >
> > > >> >> >  Oops: general protection fault, probably for non-canonical a=
ddress 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
> > > >> >> >  KASAN: null-ptr-deref in range [0x00000000000000d8-0x0000000=
0000000df]
> > > >> >> >  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D        =
     6.16.0-rc2 #1 VOLUNTARY
> > > >> >> >  Tainted: [D]=3DDIE
> > > >> >> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-debian-1.16.2-1 04/01/2014
> > > >> >> >  RIP: 0010:down_read_trylock+0xaa/0x3b0
> > > >> >> >  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 =
c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80=
> 3c 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
> > > >> >> >  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
> > > >> >> >  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 00000000000=
00000
> > > >> >> >  RDX: 000000000000001b RSI: 000000000000000a RDI: 00000000000=
00070
> > > >> >> >  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dd=
e49d1
> > > >> >> >  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff110200=
59d37
> > > >> >> >  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc00000=
00000
> > > >> >> >  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:=
0000000000000000
> > > >> >> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >> >> >  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 00000000003=
50ef0
> > > >> >> >  Call Trace:
> > > >> >> >   <TASK>
> > > >> >> >   codetag_trylock_module_list+0xd/0x20
> > > >> >> >   alloc_tag_top_users+0x369/0x4b0
> > > >> >> >   __show_mem+0x1cd/0x6e0
> > > >> >> >   warn_alloc+0x2b1/0x390
> > > >> >> >   __alloc_frozen_pages_noprof+0x12b9/0x21a0
> > > >> >> >   alloc_pages_mpol+0x135/0x3e0
> > > >> >> >   alloc_slab_page+0x82/0xe0
> > > >> >> >   new_slab+0x212/0x240
> > > >> >> >   ___slab_alloc+0x82a/0xe00
> > > >> >> >   </TASK>
> > > >> >> >
> > > >> >> >As David Wang points out, this issue became easier to trigger =
after commit
> > > >> >> >780138b12381 ("alloc_tag: check mem_profiling_support in alloc=
_tag_init").
> > > >> >> >
> > > >> >> >Before the commit, the issue occurred only when it failed to a=
llocate
> > > >> >> >and initialize alloc_tag_cttype or if a memory allocation fail=
s before
> > > >> >> >alloc_tag_init() is called. After the commit, it can be easily=
 triggered
> > > >> >> >when memory profiling is compiled but disabled at boot.
> > > >> >> >
> > > >> >> >To properly determine whether alloc_tag_init() has been called=
 and
> > > >> >> >its data structures initialized, verify that alloc_tag_cttype =
is a valid
> > > >> >> >pointer before acquiring the semaphore. If the variable is NUL=
L or an error
> > > >> >> >value, it has not been properly initialized. In such a case, j=
ust skip
> > > >> >> >and do not attempt to acquire the semaphore.
> > > >> >> >
> > > >> >> >Reported-by: kernel test robot <oliver.sang@intel.com>
> > > >> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe=
-lkp/202506181351.bba867dd-lkp@intel.com__;!!ACWV5N9M2RV99hQ!MADvGKtvTvlLXN=
xlrJ4BdOSnbsJlyrSroPUGJ3JQHs_IF-gxxqfQ89OTZ21aN96DbmjG9qH3Wi1MlgtiSA$
> > > >> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe=
-lkp/202506131711.5b41931c-lkp@intel.com__;!!ACWV5N9M2RV99hQ!MADvGKtvTvlLXN=
xlrJ4BdOSnbsJlyrSroPUGJ3JQHs_IF-gxxqfQ89OTZ21aN96DbmjG9qH3Wi0o2OoynA$
> > > >> >> >Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support i=
n alloc_tag_init")
> > > >> >> >Fixes: 1438d349d16b ("lib: add memory allocations report in sh=
ow_mem()")
> > > >> >> >Cc: stable@vger.kernel.org
> > > >> >> >Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > > >> >> >---
> > > >> >> >
> > > >> >> >@Suren: I did not add another pr_warn() because every error pa=
th in
> > > >> >> >alloc_tag_init() already has pr_err().
> > > >> >> >
> > > >> >> >v2 -> v3:
> > > >> >> >- Added another Closes: tag (David)
> > > >> >> >- Moved the condition into a standalone if block for better re=
adability
> > > >> >> >  (Suren)
> > > >> >> >- Typo fix (Suren)
> > > >> >> >
> > > >> >> > lib/alloc_tag.c | 3 +++
> > > >> >> > 1 file changed, 3 insertions(+)
> > > >> >> >
> > > >> >> >diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > > >> >> >index 41ccfb035b7b..e9b33848700a 100644
> > > >> >> >--- a/lib/alloc_tag.c
> > > >> >> >+++ b/lib/alloc_tag.c
> > > >> >> >@@ -127,6 +127,9 @@ size_t alloc_tag_top_users(struct codetag_=
bytes *tags, size_t count, bool can_sl
> > > >> >> >         struct codetag_bytes n;
> > > >> >> >         unsigned int i, nr =3D 0;
> > > >> >> >
> > > >> >> >+        if (IS_ERR_OR_NULL(alloc_tag_cttype))
> > > >> >> >+                return 0;
> > > >> >>
> > > >> >> What about mem_profiling_support set to 0 after alloc_tag_init,=
 in this case:
> > > >> >> alloc_tag_cttype !=3D NULL && mem_profiling_support=3D=3D0
> > > >> >>
> > > >> >> I kind of think alloc_tag_top_users should return 0 in this cas=
e....and  both mem_profiling_support and alloc_tag_cttype should be checked=
....
> > > >> >
> > > >> >After commit 780138b12381, alloc_tag_cttype is not allocated if
> > > >> >!mem_profiling_support. (And that's  why this bug showed up)
> > > >>
> > > >> There is a sysctl(/proc/sys/vm/mem_profiling) which can override m=
em_profiling_support and set it to 0, after alloc_tag_init with mem_profili=
ng_support=3D1
> >
> > Wait, /proc/sys/vm/mem_profiling is changing mem_alloc_profiling_key,
> > not mem_profiling_support. Am I missing something?
>
> Feels like it should call shutdown_mem_profiling() instead of
> proc_do_static_key() (and also remove /proc/allocinfo)?

No, we should be able to re-enable it later on. You can't do that if
you call shutdown_mem_profiling().
mem_profiling_support is very different from mem_alloc_profiling_key.
mem_profiling_support means memory profiling is not supported while
mem_alloc_profiling_key means it's enabled or disabled and can be
changed later.

>
> > > >
> > > >Ok. Maybe it shouldn't report memory allocation information that is
> > > >collected before mem profiling was disabled. (I'm not sure why it di=
sabling
> > > >at runtime is allowed, though)
> > > >
> > > >That's a good thing to have, but I think that's a behavioral change =
in
> > > >mem profiling, irrelevant to this bug and not a -stable thing.
> > > >
> > > >Maybe as a follow-up patch?
> > >
> > > Only a little more changes needed, I was suggesting:
> > >
> > > @@ -134,6 +122,14 @@ size_t alloc_tag_top_users(struct codetag_bytes =
*tags, size_t count, bool can_sl
> > >         struct codetag_bytes n;
> > >         unsigned int i, nr =3D 0;
> > >
> > > +       if (!mem_profiling_support)
> > > +               return 0;
> >
> > David is right that with /proc/sys/vm/mem_profiling memory profiling
> > can be turned off at runtime but the above condition should be:
> > if (!mem_alloc_profiling_enabled())
> >         return 0;
>
> I agree that this change is a useful addition, but adding it to the patch
> doesn't look right. It's doing two different things.

You might be right, calling alloc_tag_top_users() while
!mem_alloc_profiling_enabled() will print older data but it won't lead
to UAF.

>
> > > +
> > > +       if (IS_ERR_OR_NULL(alloc_tag_cttype)) {
> > > +               pr_warn("alloctag module is not ready yet.\n");
> >
> > I don't think spitting out this warning on every show_mem() is useful.
> > If alloc_tag_cttype is invalid because codetag_register_type() failed
> > then we already print an error here:
> > https://elixir.bootlin.com/linux/v6.16-rc3/source/lib/alloc_tag.c#L829,
> > so user has the logs to track this down.
> > If show_mem() is called so early that alloc_tag_init() hasn't been
> > called yet then missing allocation tag information would not be
> > surprising I think, considering it's early boot. I don't think it's
> > worth detecting and reporting such a state.
> >
> > > +               return 0;
> > > +       }
> > > +
>
> --
> Cheers,
> Harry / Hyeonggon

