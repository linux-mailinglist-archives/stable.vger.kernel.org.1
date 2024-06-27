Return-Path: <stable+bounces-56018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE991B2F5
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 01:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 605841C21C18
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 23:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566DE1A2549;
	Thu, 27 Jun 2024 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIwpHbD+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831AB13E04F;
	Thu, 27 Jun 2024 23:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532332; cv=none; b=HMdfRF2L9rOobcGRDEX7eoraXKnzurt9zVTJEHp/mThI56BhfMA8AXzgSXP18mNi/6JPpnW1E+FXxJoQQCnIlPFALJTHaMd+XVB+zAyngKJKvcNiZSKDuKG/YBa9H7umBHxIYF8QpkP/nYpQCRVQVCcej5Ujgc6UPrnr2dOi4eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532332; c=relaxed/simple;
	bh=u38JLSHzD1+j6hw07Aux9vRUyRiyqV13h4plh5RUfJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8rvYgALwXSCWSZAEuLhK/WvE1H/Wn+UbTBvrLnBkbE7XYk0HIxQbP8J6ANA+NxftCGm9HaWRnCefjh5gqbIF367LM3ooVj3/JKqG4rCiDbrTgj0J4ERRvaKOidk7Lt0OysYokeqDaLRKsZ3vPqlUDKh4u7877cGXGE8LCNbMys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIwpHbD+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6fdd947967so4016566b.2;
        Thu, 27 Jun 2024 16:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719532329; x=1720137129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ks8Ee873v/YWDfaAZSbPbf4GZ92SmbzoFMAWI2lsj4Q=;
        b=KIwpHbD+RU8d0/pa8ZSiOYA3ByFU+dNaO6mwNDrfTH6/BYswKUT09oEJImOXvli4wY
         YtWgOSBbsaVtkEosDuts9Qd4OU9jZ0KfSS7q8ndDWGTMfal9gOZiSdbrJY0sfv97FCDd
         YMaVJ+1v7e2Y7VKcXSGAu6Y+XBV3d/TVZilH6nJUh5/6mq2xAiqPFZqqVxB1Q+4zXYqf
         rLkyWNMKulS4nEsHXUyiid8wSWs3R7B6moSMVYuPZSK8DL8mFU0wGJFluUSd1poi3r6v
         J555pnOvxNRc3dp9v/SVnBp+a9F7vwtm8glvhrrNa7n5BMc4LDnx1FBPAgHxIx1+ACFd
         c1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719532329; x=1720137129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ks8Ee873v/YWDfaAZSbPbf4GZ92SmbzoFMAWI2lsj4Q=;
        b=IX2OXyMWIKdMq2XvoZpJAsjUyl8WfVrwPQc5SYm403ITuI0XDIs3SoejC5eu8UWVBQ
         cG8SZD5Dvr/1iZ9RU7ivgsC5vZZzfN3wWqx7ol6+E0AXfU61Q7sNxUl+qw7uvZS5oRe3
         L2YYjjsHDi/vjnGPJtcBALkFPer6jJ28wmHN4iV0XY0uK3PGtnas6Rr25P4ZVDcHV2X3
         DyzpXLCG7TRNU2FJna8rCGRZP1JNSSUWTK+VitVBEoEzmDOXgNy7U+f/2VZxCNnZlD9C
         bVxpROraDe4xiz0OuM4tfrN7PN2YFufBeHblQdjbsAMzQrx0q3InswCUqnDFoN4hafhm
         YsYA==
X-Forwarded-Encrypted: i=1; AJvYcCWWf4n+aLqH4asPPStD9U3Yh9K6/2ey2/gKvcy4brgjhb5wCKWxHTfE3+DWamSxwXxvUmOSJchM6ZrwD2YFt6UzfxvunRCxWlayEwxUIsWI1nggRTDcHjlRiGkfBptPqbzZr3Zs
X-Gm-Message-State: AOJu0Yy78g+XVMhTFt/FbJIkEniF94bYfDfievPo/p2ilVlx6AYPBXt9
	Up2CoFnEVgftHv8WeGmg2Oufe03gNdzdGsEiCCXQii6jc+1l7jlfMTZolD6l2sAhDtW49DIlP2t
	VaU8Bm/3P1PRDAuJIrofBvswxgQM=
X-Google-Smtp-Source: AGHT+IEIbNWJLrlBds5DDA5KvyeLOgGoa5YaIEliXBuL3Tt1oSxXNhF1Ocn8nV8jTme0NtiwPywLvN7eTEdQ4CUuh2w=
X-Received: by 2002:a17:907:cbc7:b0:a72:44d8:3051 with SMTP id
 a640c23a62f3a-a727f6678a5mr625278966b.16.1719532328655; Thu, 27 Jun 2024
 16:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627231601.1713119-1-yang@os.amperecomputing.com> <20240627164240.47ae4e1d0e7b1ddb11aedaf3@linux-foundation.org>
In-Reply-To: <20240627164240.47ae4e1d0e7b1ddb11aedaf3@linux-foundation.org>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 27 Jun 2024 16:51:56 -0700
Message-ID: <CAHbLzkqy-jyMHp6w96H5mVw4mWf=wQ6f4FNd+3o4O8JBzMSnfA@mail.gmail.com>
Subject: Re: [v2 linus-tree PATCH] mm: gup: do not call try_grab_folio() in
 slow path
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, peterx@redhat.com, yangge1116@126.com, 
	david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 4:42=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 27 Jun 2024 16:16:01 -0700 Yang Shi <yang@os.amperecomputing.com>=
 wrote:
>
> > The try_grab_folio() is supposed to be used in fast path and it elevate=
s
> > folio refcount by using add ref unless zero.  We are guaranteed to have
> > at least one stable reference in slow path, so the simple atomic add
> > could be used.  The performance difference should be trivial, but the
> > misuse may be confusing and misleading.
> >
> > In another thread [1] a kernel warning was reported when pinning folio
> > in CMA memory when launching SEV virtual machine.  The splat looks like=
:
> >
> > [  464.325306] WARNING: CPU: 13 PID: 6734 at mm/gup.c:1313 __get_user_p=
ages+0x423/0x520
> > [  464.325464] CPU: 13 PID: 6734 Comm: qemu-kvm Kdump: loaded Not taint=
ed 6.6.33+ #6
> > [  464.325477] RIP: 0010:__get_user_pages+0x423/0x520
> > [  464.325515] Call Trace:
> > [  464.325520]  <TASK>
> > [  464.325523]  ? __get_user_pages+0x423/0x520
> > [  464.325528]  ? __warn+0x81/0x130
> > [  464.325536]  ? __get_user_pages+0x423/0x520
> > [  464.325541]  ? report_bug+0x171/0x1a0
> > [  464.325549]  ? handle_bug+0x3c/0x70
> > [  464.325554]  ? exc_invalid_op+0x17/0x70
> > [  464.325558]  ? asm_exc_invalid_op+0x1a/0x20
> > [  464.325567]  ? __get_user_pages+0x423/0x520
> > [  464.325575]  __gup_longterm_locked+0x212/0x7a0
> > [  464.325583]  internal_get_user_pages_fast+0xfb/0x190
> > [  464.325590]  pin_user_pages_fast+0x47/0x60
> > [  464.325598]  sev_pin_memory+0xca/0x170 [kvm_amd]
> > [  464.325616]  sev_mem_enc_register_region+0x81/0x130 [kvm_amd]
> >
> > Per the analysis done by yangge, when starting the SEV virtual machine,
> > it will call pin_user_pages_fast(..., FOLL_LONGTERM, ...) to pin the
> > memory.  But the page is in CMA area, so fast GUP will fail then
> > fallback to the slow path due to the longterm pinnalbe check in
> > try_grab_folio().
> > The slow path will try to pin the pages then migrate them out of CMA
> > area.  But the slow path also uses try_grab_folio() to pin the page,
> > it will also fail due to the same check then the above warning
> > is triggered.
> >
>
> The remainder of mm-unstable actually applies OK on top of this.
>
> I applied the below as a fixup to Vivek's "mm/gup: introduce
> memfd_pin_folios() for pinning memfd folios".  After this, your v1
> patch reverts cleanly.

Thanks for taking care of this. Yeah, it is not bad. I actually
removed the memfd hunk then the patch can be applied to Linus's tree
cleanly.

>
> --- a/mm/gup.c~mm-gup-introduce-memfd_pin_folios-for-pinning-memfd-folios=
-fix
> +++ a/mm/gup.c
> @@ -3856,14 +3856,15 @@ long memfd_pin_folios(struct file *memfd
>                                     next_idx !=3D folio_index(fbatch.foli=
os[i]))
>                                         continue;
>
> -                               folio =3D try_grab_folio(&fbatch.folios[i=
]->page,
> -                                                      1, FOLL_PIN);
> -                               if (!folio) {
> +                               if (try_grab_folio(fbatch.folios[i],
> +                                                      1, FOLL_PIN)) {
>                                         folio_batch_release(&fbatch);
>                                         ret =3D -EINVAL;
>                                         goto err;
>                                 }
>
> +                               folio =3D fbatch.folios[i];
> +
>                                 if (nr_folios =3D=3D 0)
>                                         *offset =3D offset_in_folio(folio=
, start);
>
> _
>
>
>

