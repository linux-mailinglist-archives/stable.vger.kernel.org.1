Return-Path: <stable+bounces-158467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1C1AE73F7
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 02:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12EB13B753A
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 00:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FE07E0E8;
	Wed, 25 Jun 2025 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4cqvTY8"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27CC1C69D
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 00:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750812751; cv=none; b=WR1al9xhVRSv1awVvqnI0xRNscjPz4XjXqfnmuvIXG9C7NhCuieyMk1kD8Ea7FjBR+7kfSDA4WDByCqpUAZwbWBJmA2GUfMyc2MlFZVCYS31SDgFlkfYJ5Vr9FYHx1kAhYrLteLkamhLr+an2Uz/dQ9BszkYfxuBGLK8fPeMm6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750812751; c=relaxed/simple;
	bh=mb7Xuz7qvrtEcnx8SzYze1NDi9Ly8GnpsrNre7WHoDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWQArMXVJf7MBhFxKFOhvxlMCG8Fx/Loi/KaGW5Zx60XMv7V3aKXHBrOpI/sKW/fCpmzxI+ZJo4o34FqRN2SDF3y0aoCJbEcaU+vrAUiNA6u4E4PQCYmJzxdwDGhf9AOhRodCZaYtvC36PAA7EJ2QU0LZ1X6X+JAM8B3vADJYUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4cqvTY8; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a58197794eso52191cf.1
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 17:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750812749; x=1751417549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSwW+xIhvHfP2n82ypS/Wn9Qq6NX23eYFIUnCLJFSpw=;
        b=a4cqvTY83YXXJg91D1aT7tM3EBp34DpI7HzanqigRiI6366lpm36+NqCvZLJbIrBTE
         AYGcNPrj6H2jh5AfJ4vUnC43pWypK9Vmu+529k6CFHywZWHcCTydEB3/34Gekr7RthAo
         tHxJSVWAfI1WzsLFbDXL6edUJ3+Yw5iVAilZ2XIGd0lNR1LKn1xkEz3R5IhOBraBHAZX
         vwZNnIAr01nUrcMEAbZvuaVozUkalCPYWw1zw3h6h34OwJ1B/yUc63E81smb2anajvb4
         2mfcCWiUk28ziGHcK/alTqVC3fbSMUL9LXzHZN5JUzhkkGcoPhQHTbiZbg4V+H5ciS3X
         AQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750812749; x=1751417549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSwW+xIhvHfP2n82ypS/Wn9Qq6NX23eYFIUnCLJFSpw=;
        b=Bx4bsbBkfCnL2gBzpPRPl9GjWaBcVy5Cxqge2nzINA99fVxs3nvQYa7uswniqNpjfj
         Ou1JP+lXpIvdAFOXbDDaJnnxQpDlsxgRUmeQGsoIje2ws2zIucR3ji5U+sS3+cLTYTmv
         wD53L53dFUr6CxbOaCwE/Q1YYn6GMqXSEQw9wmjJHnP/5z03AiEQWdTxKeN0d4F9ks0o
         3TO7Am40l3lmY5quJQQOoVYt+UiLdtF7QIaQJOhU+77VSI/EW67jsym0PuMYDkGFfZRl
         /Dc2T51ZdlrwzN9HL/pOPXfuQIKq9wScuFdh1hcP8qd7mfMWritZNA3C03g2w1TaXg4o
         L2fA==
X-Forwarded-Encrypted: i=1; AJvYcCU1UVJ0aN83+hqfRyqg4Hfm+2nVxizGJ7s5iDRM6ryMf24vrPjtQyF7oqZKJzYt4kFD242riV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGDBAFPH/xfwvtkkXsPKwhaeQztZb4rinkorXMj+4tHqC/42bj
	bU6HRkvyVN250/ZEMGj0fJqgGJ0mJ5CotOZSy2MI2gpZ9QgxE4/v1Sszi1w16UhVQ9niHqkAxar
	kUxNB1I+QOd/HDT2ZJSB+/8PjcLir75lbfs58dg+S
X-Gm-Gg: ASbGncuWRXECriu3zbk40RI+5HzmI4iLLC7IkQyG/pyjGv+kPRjEcOhtlOtO8e1x+bc
	m5k/XxgrT0qEKy0wXHfJ99wBBqVnF1+JPsPmXSzT5yuV9I4kaw7U8LpeDeAXxmHZuuU+I3OCrvD
	1RSp27vLN9p4W/lZMDoP40b8ztYBKFyo86iDZWdliD+6Mc30+PAMEO
X-Google-Smtp-Source: AGHT+IGW0s3Z21zLhutKE3Q2yJQO+RbEUgzPYht2EC0rHYCJKwd1wxOQmJduNe16htpPIhpza8ZyjWrC924RETnjIpU=
X-Received: by 2002:a05:622a:1917:b0:479:1958:d81a with SMTP id
 d75a77b69052e-4a7c231bc81mr688391cf.6.1750812748318; Tue, 24 Jun 2025
 17:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624072513.84219-1-harry.yoo@oracle.com> <7f2f180f.a643.197a21de68c.Coremail.00107082@163.com>
 <aFqtCoz1t359Kjp1@hyeyoo> <2dba37c6.b15a.197a23dcce2.Coremail.00107082@163.com>
 <aFqynd6CyJiq8NNF@hyeyoo> <3942323b.b31d.197a2572832.Coremail.00107082@163.com>
 <CAJuCfpGd+jHoCdyuEbk5h-dbQ7_wqgX=S4azyb6Aou8spzv0=w@mail.gmail.com>
 <aFrAwJEkjYFAuVOa@hyeyoo> <CAJuCfpEXAX5BJiA94pYYAqe22uo-Ngfw-+ZFZkt57SnHPMsY5w@mail.gmail.com>
 <aFrn1pZJ09N7xNOb@hyeyoo>
In-Reply-To: <aFrn1pZJ09N7xNOb@hyeyoo>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 24 Jun 2025 17:52:17 -0700
X-Gm-Features: Ac12FXzl7cdhs3-J3HO9jp1NRd-686pg1FYiAY_L-CUy2cf6uWBIJvEKOSvtC-M
Message-ID: <CAJuCfpHKCAkw73t=Dbu_6w1cCMVS=6owJVjD5OhtbM755skA_A@mail.gmail.com>
Subject: Re: [PATCH v3] lib/alloc_tag: do not acquire non-existent lock in alloc_tag_top_users()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: David Wang <00107082@163.com>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	oliver.sang@intel.com, cachen@purestorage.com, linux-mm@kvack.org, 
	oe-lkp@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 11:01=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> w=
rote:
>
> On Tue, Jun 24, 2025 at 08:38:05AM -0700, Suren Baghdasaryan wrote:
> > On Tue, Jun 24, 2025 at 8:14=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com=
> wrote:
> > >
> > > On Tue, Jun 24, 2025 at 07:57:40AM -0700, Suren Baghdasaryan wrote:
> > > > On Tue, Jun 24, 2025 at 7:28=E2=80=AFAM David Wang <00107082@163.co=
m> wrote:
> > > > >
> > > > >
> > > > > At 2025-06-24 22:13:49, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> > > > > >On Tue, Jun 24, 2025 at 10:00:48PM +0800, David Wang wrote:
> > > > > >>
> > > > > >> At 2025-06-24 21:50:02, "Harry Yoo" <harry.yoo@oracle.com> wro=
te:
> > > > > >> >On Tue, Jun 24, 2025 at 09:25:58PM +0800, David Wang wrote:
> > > > > >> >>
> > > > > >> >> At 2025-06-24 15:25:13, "Harry Yoo" <harry.yoo@oracle.com> =
wrote:
> > > > > >> >> >alloc_tag_top_users() attempts to lock alloc_tag_cttype->m=
od_lock
> > > > > >> >> >even when the alloc_tag_cttype is not allocated because:
> > > > > >> >> >
> > > > > >> >> >  1) alloc tagging is disabled because mem profiling is di=
sabled
> > > > > >> >> >     (!alloc_tag_cttype)
> > > > > >> >> >  2) alloc tagging is enabled, but not yet initialized (!a=
lloc_tag_cttype)
> > > > > >> >> >  3) alloc tagging is enabled, but failed initialization
> > > > > >> >> >     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))
> > > > > >> >> >
> > > > > >> >> >In all cases, alloc_tag_cttype is not allocated, and there=
fore
> > > > > >> >> >alloc_tag_top_users() should not attempt to acquire the se=
maphore.
> > > > > >> >> >
> > > > > >> >> >This leads to a crash on memory allocation failure by atte=
mpting to
> > > > > >> >> >acquire a non-existent semaphore:
> > > > > >> >> >
> > > > > >> >> >  Oops: general protection fault, probably for non-canonic=
al address 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
> > > > > >> >> >  KASAN: null-ptr-deref in range [0x00000000000000d8-0x000=
00000000000df]
> > > > > >> >> >  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D    =
         6.16.0-rc2 #1 VOLUNTARY
> > > > > >> >> >  Tainted: [D]=3DDIE
> > > > > >> >> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > > > >> >> >  RIP: 0010:down_read_trylock+0xaa/0x3b0
> > > > > >> >> >  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04=
 85 c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03=
 <80> 3c 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
> > > > > >> >> >  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
> > > > > >> >> >  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 0000000=
000000000
> > > > > >> >> >  RDX: 000000000000001b RSI: 000000000000000a RDI: 0000000=
000000070
> > > > > >> >> >  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed1=
07dde49d1
> > > > > >> >> >  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff11=
020059d37
> > > > > >> >> >  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc0=
000000000
> > > > > >> >> >  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) kn=
lGS:0000000000000000
> > > > > >> >> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > >> >> >  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 0000000=
000350ef0
> > > > > >> >> >  Call Trace:
> > > > > >> >> >   <TASK>
> > > > > >> >> >   codetag_trylock_module_list+0xd/0x20
> > > > > >> >> >   alloc_tag_top_users+0x369/0x4b0
> > > > > >> >> >   __show_mem+0x1cd/0x6e0
> > > > > >> >> >   warn_alloc+0x2b1/0x390
> > > > > >> >> >   __alloc_frozen_pages_noprof+0x12b9/0x21a0
> > > > > >> >> >   alloc_pages_mpol+0x135/0x3e0
> > > > > >> >> >   alloc_slab_page+0x82/0xe0
> > > > > >> >> >   new_slab+0x212/0x240
> > > > > >> >> >   ___slab_alloc+0x82a/0xe00
> > > > > >> >> >   </TASK>
> > > > > >> >> >
> > > > > >> >> >As David Wang points out, this issue became easier to trig=
ger after commit
> > > > > >> >> >780138b12381 ("alloc_tag: check mem_profiling_support in a=
lloc_tag_init").
> > > > > >> >> >
> > > > > >> >> >Before the commit, the issue occurred only when it failed =
to allocate
> > > > > >> >> >and initialize alloc_tag_cttype or if a memory allocation =
fails before
> > > > > >> >> >alloc_tag_init() is called. After the commit, it can be ea=
sily triggered
> > > > > >> >> >when memory profiling is compiled but disabled at boot.
> > > > > >> >> >
> > > > > >> >> >To properly determine whether alloc_tag_init() has been ca=
lled and
> > > > > >> >> >its data structures initialized, verify that alloc_tag_ctt=
ype is a valid
> > > > > >> >> >pointer before acquiring the semaphore. If the variable is=
 NULL or an error
> > > > > >> >> >value, it has not been properly initialized. In such a cas=
e, just skip
> > > > > >> >> >and do not attempt to acquire the semaphore.
> > > > > >> >> >
> > > > > >> >> >Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > >> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.or=
g/oe-lkp/202506181351.bba867dd-lkp@intel.com__;!!ACWV5N9M2RV99hQ!MADvGKtvTv=
lLXNxlrJ4BdOSnbsJlyrSroPUGJ3JQHs_IF-gxxqfQ89OTZ21aN96DbmjG9qH3Wi1MlgtiSA$
> > > > > >> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.or=
g/oe-lkp/202506131711.5b41931c-lkp@intel.com__;!!ACWV5N9M2RV99hQ!MADvGKtvTv=
lLXNxlrJ4BdOSnbsJlyrSroPUGJ3JQHs_IF-gxxqfQ89OTZ21aN96DbmjG9qH3Wi0o2OoynA$
> > > > > >> >> >Fixes: 780138b12381 ("alloc_tag: check mem_profiling_suppo=
rt in alloc_tag_init")
> > > > > >> >> >Fixes: 1438d349d16b ("lib: add memory allocations report i=
n show_mem()")
> > > > > >> >> >Cc: stable@vger.kernel.org
> > > > > >> >> >Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > > > > >> >> >---
> > > > > >> >> >
> > > > > >> >> >@Suren: I did not add another pr_warn() because every erro=
r path in
> > > > > >> >> >alloc_tag_init() already has pr_err().
> > > > > >> >> >
> > > > > >> >> >v2 -> v3:
> > > > > >> >> >- Added another Closes: tag (David)
> > > > > >> >> >- Moved the condition into a standalone if block for bette=
r readability
> > > > > >> >> >  (Suren)
> > > > > >> >> >- Typo fix (Suren)
> > > > > >> >> >
> > > > > >> >> > lib/alloc_tag.c | 3 +++
> > > > > >> >> > 1 file changed, 3 insertions(+)
> > > > > >> >> >
> > > > > >> >> >diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > > > > >> >> >index 41ccfb035b7b..e9b33848700a 100644
> > > > > >> >> >--- a/lib/alloc_tag.c
> > > > > >> >> >+++ b/lib/alloc_tag.c
> > > > > >> >> >@@ -127,6 +127,9 @@ size_t alloc_tag_top_users(struct code=
tag_bytes *tags, size_t count, bool can_sl
> > > > > >> >> >         struct codetag_bytes n;
> > > > > >> >> >         unsigned int i, nr =3D 0;
> > > > > >> >> >
> > > > > >> >> >+        if (IS_ERR_OR_NULL(alloc_tag_cttype))
> > > > > >> >> >+                return 0;
> > > > > >> >>
> > > > > >> >> What about mem_profiling_support set to 0 after alloc_tag_i=
nit, in this case:
> > > > > >> >> alloc_tag_cttype !=3D NULL && mem_profiling_support=3D=3D0
> > > > > >> >>
> > > > > >> >> I kind of think alloc_tag_top_users should return 0 in this=
 case....and  both mem_profiling_support and alloc_tag_cttype should be che=
cked....
> > > > > >> >
> > > > > >> >After commit 780138b12381, alloc_tag_cttype is not allocated =
if
> > > > > >> >!mem_profiling_support. (And that's  why this bug showed up)
> > > > > >>
> > > > > >> There is a sysctl(/proc/sys/vm/mem_profiling) which can overri=
de mem_profiling_support and set it to 0, after alloc_tag_init with mem_pro=
filing_support=3D1
> > > >
> > > > Wait, /proc/sys/vm/mem_profiling is changing mem_alloc_profiling_ke=
y,
> > > > not mem_profiling_support. Am I missing something?
> > >
> > > Feels like it should call shutdown_mem_profiling() instead of
> > > proc_do_static_key() (and also remove /proc/allocinfo)?
> >
> > No, we should be able to re-enable it later on.
>
> A few questions that came up while reading this,
> please feel free to ignore :)
>
> - What is the expected output of /proc/allocinfo when it's disabled?
>   Should it print old data or nothing? I think it should be consistent
>   with the behavior of alloc_tag_top_users().
>
> - When it's disabled and re-enabled again, can we see inconsistent
>   data if some memory has been freed in the meantime?
>
> > You can't do that if you call shutdown_mem_profiling().
>
> Because setting mem_profiling_support =3D false mean it's not supported.
> And you can't re-enable if it's not supported. Gotcha!
>
> > mem_profiling_support is very different from mem_alloc_profiling_key.
> > mem_profiling_support means memory profiling is not supported while
> > mem_alloc_profiling_key means it's enabled or disabled and can be
> > changed later.
>
> Okay. Now I see why I was confused. Perhaps I should have guessed that
> from the name, but I was not 100% sure about the meaning.
>
> > > > > >
> > > > > >Ok. Maybe it shouldn't report memory allocation information that=
 is
> > > > > >collected before mem profiling was disabled. (I'm not sure why i=
t disabling
> > > > > >at runtime is allowed, though)
> > > > > >
> > > > > >That's a good thing to have, but I think that's a behavioral cha=
nge in
> > > > > >mem profiling, irrelevant to this bug and not a -stable thing.
> > > > > >
> > > > > >Maybe as a follow-up patch?
> > > > >
> > > > > Only a little more changes needed, I was suggesting:
> > > > >
> > > > > @@ -134,6 +122,14 @@ size_t alloc_tag_top_users(struct codetag_by=
tes *tags, size_t count, bool can_sl
> > > > >         struct codetag_bytes n;
> > > > >         unsigned int i, nr =3D 0;
> > > > >
> > > > > +       if (!mem_profiling_support)
> > > > > +               return 0;
> > > >
> > > > David is right that with /proc/sys/vm/mem_profiling memory profilin=
g
> > > > can be turned off at runtime but the above condition should be:
> > > > if (!mem_alloc_profiling_enabled())
> > > >         return 0;
> > >
> > > I agree that this change is a useful addition, but adding it to the p=
atch
> > > doesn't look right. It's doing two different things.
> >
> > You might be right, calling alloc_tag_top_users() while
> > !mem_alloc_profiling_enabled() will print older data but it won't lead
> > to UAF.
>
> Yes and I think it'll be great if David could post it after the fix lands
> maineline.
>
> Aside from that, any feedback on the v3 of the patch?
>
> If yes, I'll adjust it.
> If not, please consider an ack ;)

LGTM.
Acked-by: Suren Baghdasaryan <surenb@google.com>

>
> > > > > +
> > > > > +       if (IS_ERR_OR_NULL(alloc_tag_cttype)) {
> > > > > +               pr_warn("alloctag module is not ready yet.\n");
> > > >
> > > > I don't think spitting out this warning on every show_mem() is usef=
ul.
> > > > If alloc_tag_cttype is invalid because codetag_register_type() fail=
ed
> > > > then we already print an error here:
> > > > https://elixir.bootlin.com/linux/v6.16-rc3/source/lib/alloc_tag.c#L=
829,
> > > > so user has the logs to track this down.
> > > > If show_mem() is called so early that alloc_tag_init() hasn't been
> > > > called yet then missing allocation tag information would not be
> > > > surprising I think, considering it's early boot. I don't think it's
> > > > worth detecting and reporting such a state.
> > > >
> > > > > +               return 0;
> > > > > +       }
> > > > > +
> > >
> > > --
> > > Cheers,
> > > Harry / Hyeonggon
> >
>
> --
> Cheers,
> Harry / Hyeonggon

