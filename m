Return-Path: <stable+bounces-155269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E68AAE32C6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 00:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A83188FD75
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 22:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B8021A433;
	Sun, 22 Jun 2025 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pXnwWnuS"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3421862A
	for <stable@vger.kernel.org>; Sun, 22 Jun 2025 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750631063; cv=none; b=tvCkcP1H+aURGZ2y9Su1Xen1WIi0MwC2+x2OKl4Za+mh91Ac++Xlxo86ecVfeNlYlL7PGaprg/BUYO/2kD1gmzoLQWQkJr1ttZ+j9uxGCF275SUp2Ikor6GKkYOQGVNRYtb8BWiDuzXxCLhuokhYXX6AjwHne6bmGrFp6nmva84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750631063; c=relaxed/simple;
	bh=mr0vzL6f4v2foHwwXLma3LkzpJdNCBXCnJoa983E1Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngbqqBd+1sA8wz1yQh+ot9PXZuErrAvzAG1XgK6lc4KIlMeaBPGHmvkFLYKFbpveJOUXohbtp4oRaUFbCeJfaXEa1XGHVwzbKIem1jEtsUF+TgoPPyf9j2JUjIufzMiKeREdAXIbVRWu158jylPQlDoR4XWVbmtx96NS/q+chyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pXnwWnuS; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a58197794eso238831cf.1
        for <stable@vger.kernel.org>; Sun, 22 Jun 2025 15:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750631060; x=1751235860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2GI2494rUC/2TZW0ywCzgu9F19ggR5YUviGIVZ+qfY=;
        b=pXnwWnuS/BZnsgWgNahJddA1o0fSH2VvmG3zPXsm08fVnITT0z3PXPUwVRlgANULmQ
         pUjIo7YXZZkHECgNCa4T2cl3W4kUq4Idimk91KFSzNBwCuejxzLOekDY27Mk46H7altt
         W2Zeay+0HVYw8eDKbJgh6nNh/xg/Gb2Vus/IhM9ql3cqRfwVFNNwPob+yHCy5A8TYwY4
         5IDTU3RKdnly5uSSq1QyEp30asDId9IT6GTsB1RN2lJ3wrXjjqXcXf/7i3USKBOcuTUj
         51q54rQRfnHS1fzn/j1gMJBq1cl4aYc+FFuH/VlN/mZ8uGMjUbYpFWBCeEvl0HaDkzTN
         pYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750631060; x=1751235860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2GI2494rUC/2TZW0ywCzgu9F19ggR5YUviGIVZ+qfY=;
        b=f4X8GtLmPO5ss+vja2sUpMweTI2IZg9tjYoTFmK9hOrm2bVuDkImguf0Dudic1+G11
         NfyCF36ifOgH/KrYn/xFH2fBqpOT6hLGH4sXvziFiyLsnAg4Q+dSDAp5FYYYsuIK+6i4
         rEpyMKkZAd1BZEBPUzMS+RjS5yiqcawv5zQp5Iha8JlkT8Onqgzzjg7IjkzBIUUqwnCj
         WMu/Q5g5GjNXlc0V2l985z1jLnW++WzShfASvv941mGnPqVV6J30aZGK2WMdlqUM5p7G
         2Mb4eGufT9fAgZq5F9mY/3KPvLhF0zWczR4pJfPb+VlbIGL9gUPfekuKmCYP+InjDDPm
         tA5g==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZxTXtGng+9XmjxaBNxOv/VSoG89EcPfA3YtI5yPJ2pr4dz+qFkjm+dWfW9zR17lhFsvIxF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuWUjI3NX7I7CqPt7VE9olm5Xv+KYr5jQteofmHJ++MrbTPHHF
	as8fgIv8HS/+B1/R1FxmTXTbpe8EpWkLCEVg3p3SFiyxa0F4/DVTak4m9+B0ohmqyx52mCCthC2
	j2HIlJzJtwNtpNcjFyrdfFwCUx8AYU0X9qxwJCCM0
X-Gm-Gg: ASbGncsxKZLMG5dHB25hxFMiwMOGx9srP/V+KqoFrRnJ3XrFRfddHXXWkM5NI4grl2c
	6j/aEPpNQpfXx3oP1UvysoOoJ4zfSRsK0AbBJc7nmkzm6nrydx/zmUCdFaOXrcb+jMXl+MDva3V
	CxbVr2pg5NwofaL236oDdnUjMLYKF+52XGM9fE5UjLpw==
X-Google-Smtp-Source: AGHT+IFXpfw+xB4qC+6F0GtwYxkvSjZPT2sqzoTBpbCRyfAg/E0SGXmExBTMb8qlx3auQmultRnj8mhUyA+FgakccdY=
X-Received: by 2002:a05:622a:11ca:b0:48a:42fa:78fa with SMTP id
 d75a77b69052e-4a7852dba43mr5237071cf.2.1750631059676; Sun, 22 Jun 2025
 15:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620195305.1115151-1-harry.yoo@oracle.com> <7935cfb1.1432.19790952566.Coremail.00107082@163.com>
In-Reply-To: <7935cfb1.1432.19790952566.Coremail.00107082@163.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 22 Jun 2025 15:24:08 -0700
X-Gm-Features: Ac12FXxuGqxZZyKQhgH0eqA4IJBrgYI4hYeartJ-8Oj8skCpD3dIFoo0_U2Xlwc
Message-ID: <CAJuCfpG3=0MCac2jTVM9LiJWDwWdLE3vrcJp52x4ZX5XdSEv1A@mail.gmail.com>
Subject: Re: [PATCH v2] lib/alloc_tag: do not acquire non-existent lock in alloc_tag_top_users()
To: David Wang <00107082@163.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, oliver.sang@intel.com, cachen@purestorage.com, 
	linux-mm@kvack.org, oe-lkp@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 8:43=E2=80=AFPM David Wang <00107082@163.com> wrote=
:
>
>
> At 2025-06-21 03:53:05, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_lock
> >even when the alloc_tag_cttype is not allocated because:
> >
> >  1) alloc tagging is disabled because mem profiling is disabled
> >     (!alloc_tag_cttype)
> >  2) alloc tagging is enabled, but not yet initialized (!alloc_tag_cttyp=
e)
> >  3) alloc tagging is enabled, but failed initialization
> >     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))
> >
> >In all cases, alloc_tag_cttype is not allocated, and therefore
> >alloc_tag_top_users() should not attempt to acquire the semaphore.
> >
> >This leads to a crash on memory allocation failure by attempting to
> >acquire a non-existent semaphore:
> >
> >  Oops: general protection fault, probably for non-canonical address 0xd=
ffffc000000001b: 0000 [#3] SMP KASAN NOPTI
> >  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> >  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D             6.16.=
0-rc2 #1 VOLUNTARY
> >  Tainted: [D]=3DDIE
> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-deb=
ian-1.16.2-1 04/01/2014
> >  RIP: 0010:down_read_trylock+0xaa/0x3b0
> >  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 c9 75 29 4=
8 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80> 3c 02 00=
 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
> >  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
> >  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 0000000000000000
> >  RDX: 000000000000001b RSI: 000000000000000a RDI: 0000000000000070
> >  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dde49d1
> >  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff11020059d37
> >  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc0000000000
> >  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:0000000000=
000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 0000000000350ef0
> >  Call Trace:
> >   <TASK>
> >   codetag_trylock_module_list+0xd/0x20
> >   alloc_tag_top_users+0x369/0x4b0
> >   __show_mem+0x1cd/0x6e0
> >   warn_alloc+0x2b1/0x390
> >   __alloc_frozen_pages_noprof+0x12b9/0x21a0
> >   alloc_pages_mpol+0x135/0x3e0
> >   alloc_slab_page+0x82/0xe0
> >   new_slab+0x212/0x240
> >   ___slab_alloc+0x82a/0xe00
> >   </TASK>
> >
> >As David Wang points out, this issue became easier to trigger after comm=
it
> >780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init"=
).
> >
> >Before the commit, the issue occurred only when it failed to allocate
> >and initialize alloc_tag_cttype or if a memory allocation fails before
> >alloc_tag_init() is called. After the commit, it can be easily triggered
> >when memory profiling is compiled but disabled at boot.

Thanks for the fix and sorry about the delay with reviewing it.

> >
> >To properly determine whether alloc_tag_init() has been called and
> >its data structures initialized, verify that alloc_tag_cttype is a valid
> >pointer before acquiring the semaphore. If the variable is NULL or an er=
ror
> >value, it has not been properly initialized. In such a case, just skip
> >and do not attempt acquire the semaphore.

nit: s/attempt acquire/attempt to acquire

> >
> >Reported-by: kernel test robot <oliver.sang@intel.com>
> >Closes: https://lore.kernel.org/oe-lkp/202506181351.bba867dd-lkp@intel.c=
om
> >Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support in alloc_ta=
g_init")
> >Fixes: 1438d349d16b ("lib: add memory allocations report in show_mem()")
> >Cc: stable@vger.kernel.org
> >Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
>
> Just notice another thread can be closed as well:
> https://lore.kernel.org/all/202506131711.5b41931c-lkp@intel.com/
> This coincide with scenario #1, where OOM happened with
> CONFIG_MEM_ALLOC_PROFILING=3Dy
> # CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT is not set
> # CONFIG_MEM_ALLOC_PROFILING_DEBUG is not set
>
> >---
> >
> >v1 -> v2:
> >
> >- v1 fixed the bug only when MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=3Dn.
> >
> >  v2 now fixes the bug even when MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=
=3Dy.
> >  I didn't expect alloc_tag_cttype to be NULL when
> >  mem_profiling_support is true, but as David points out (Thanks David!)
> >  if a memory allocation fails before alloc_tag_init(), it can be NULL.
> >
> >  So instead of indirectly checking mem_profiling_support, just directly
> >  check if alloc_tag_cttype is allocated.
> >
> >- Closes: https://lore.kernel.org/oe-lkp/202505071555.e757f1e0-lkp@intel=
.com
> >  tag was removed because it was not a crash and not relevant to this
> >  patch.
> >
> >- Added Cc: stable because, if an allocation fails before
> >  alloc_tag_init(), it can be triggered even prior-780138b12381.
> >  I verified that the bug can be triggered in v6.12 and fixed by this
> >  patch.
> >
> >  It should be quite difficult to trigger in practice, though.
> >  Maybe I'm a bit paranoid?
> >
> > lib/alloc_tag.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> >diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> >index 66a4628185f7..d8ec4c03b7d2 100644
> >--- a/lib/alloc_tag.c
> >+++ b/lib/alloc_tag.c
> >@@ -124,7 +124,9 @@ size_t alloc_tag_top_users(struct codetag_bytes *tag=
s, size_t count, bool can_sl
> >       struct codetag_bytes n;
> >       unsigned int i, nr =3D 0;
> >
> >-      if (can_sleep)
> >+      if (IS_ERR_OR_NULL(alloc_tag_cttype))
> >+              return 0;

So, AFAIKT alloc_tag_cttype will be NULL when memory profiling is
disabled and it will be ENOMEM if codetag_register_type() fails. I
think it would be good to add a pr_warn() in the alloc_tag_init() when
codetag_register_type() fails so that the user can determine the
reason why show_mem() report is missing allocation tag information.

> >+      else if (can_sleep)

nit: the above extra "else" is not really needed. The following should
work just fine, is more readable and produces less churn:

+      if (IS_ERR_OR_NULL(alloc_tag_cttype))
+              return 0;
+
      if (can_sleep)
               codetag_lock_module_list(alloc_tag_cttype, true);
       else if (!codetag_trylock_module_list(alloc_tag_cttype))
               return 0;

> >               codetag_lock_module_list(alloc_tag_cttype, true);
> >       else if (!codetag_trylock_module_list(alloc_tag_cttype))
> >               return 0;
> >--
> >2.43.0

