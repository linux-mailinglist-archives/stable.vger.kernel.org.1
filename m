Return-Path: <stable+bounces-160723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC617AFD188
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C805165F25
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8F82E5423;
	Tue,  8 Jul 2025 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/QU+qW7"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F062E542C
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992502; cv=none; b=ApM+m8gnCCGZBKq08n6EhIy4ZBsmSv5JtS0A6E+2UVFHY4ozVZHJ0I5EdoWh2aHC4HAzsbWFURxHYt9//I7o59g4vidRwOWZ+mTWKrvZGaz29ulp8rSW6vWEDnA+zVp9DQHfUUEv3F4/LAE8ANpPI92RRTSpCIGWXuu57LFHDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992502; c=relaxed/simple;
	bh=LOh1uVyuOGC3cLQ5Hyqg/PyFMIWeI77AdXpS9ZiQd8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bqpd8CJQFWzP/jbehWVrptCsEpiCToi99WlSU6lcQ50PynK6JB6fe1g+Kyfhv4dZiwj7OpMlVy7MiuBJimnXnil+utTW3jKNoQ/LONgaYjRqmUWIXaIAoMc5bZ3LbsM+vw7Yw2aBecYgpK1SR70+/z0RTAVpnUM8/YLgAlTFod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/QU+qW7; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a5ac8fae12so4511cf.0
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 09:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751992499; x=1752597299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyPVyPZ7g8sae8dggze/O0X+T0IkRpg9KIq+ZglFhHY=;
        b=s/QU+qW7MfJD+eyrgW0/3u0WW40CcqWg4ZPngbE8cfTlAFhuH+IDICeLo87qNV/Aqr
         x9z+Bim1Jd8rXM33+wynCpLxCual0zZKML32+ml+CGs3CYPJ0ZMapVXG2YKwGwyDFucj
         zvM7+bLGnljIwZGiQJbI5TgGQK4TgA8snENVM52Vbep9XR5VKycvomGbS4dn78oAkymV
         qU7AEfFFJMQndARUdnSynwy2S89x+Xak6/GiiyI5wZ//GGUEvj+XIHZQOR79racl8Fkf
         Ku+8WnDPTBw7fBt/k421sUF6c7IUMAaAORcruxpp5U9gu8iSi8uTiyAY84p+KK2ABzIA
         FLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751992499; x=1752597299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyPVyPZ7g8sae8dggze/O0X+T0IkRpg9KIq+ZglFhHY=;
        b=n8NE9CUNkC+Bry2LyvISPlB+LeQK/ewcj9HOKMg1z5yf5FHrnupCjh5DN0qXfcw0Ie
         V2XB42ih+XRfLxJ2ENQ211Dp92LsZ34ixMr050RJfQJpZ95PchlwgSnDyHiUr6ncHy9V
         u6KS7OWEtGrQ1pg0asNzCpj0u+elCho6I5BNq5Iz1uDsd70+YhagZ79LikAS4FtC/zwf
         GU1Y7CavqY0Py/YBO3WkpLi+RLIVjDWQ2646XJFGO8+1zpyFoyLGG9oUgC67vkrbjJxq
         NUYsXhukRoPCs2aJikfpCIIZ5rUA/xg7Vi2InC1qUAK9QiNCYWHV999cJHXHINL1lOPq
         pgOw==
X-Forwarded-Encrypted: i=1; AJvYcCX2VqJM++h5R1eYpxRO+XwvSxy7mKkCihW7wFTMdu26akhMs7NaTgsUDf8QG8p3SickQJoru3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpiLf9pk9tfaGAl9LFhAOG3/KawbZ5CY5JDtxpLg8/76EktqeX
	lkRC2smO1R+qH5tQpWmJEGVt8gALPVKF3/YqDHKp2GMdmN6Wxzo/4w2pu7vzOOGl2kGQty7O7Fm
	91/nLjSKKMn4ApX7RxFRvLFSG+bZoDmWC8CqJQb9R
X-Gm-Gg: ASbGnctn4u3e4njeogYp6m5H4wEWdkdJYf3cJGSGwBy5CdhyIY9DtweZNGEnlhfilvm
	rPO+xoMzgpuu/3avyV4HUdjC2tl6u0TrxAZ4a0LWOsBy5voDM4r8i+qCooZ9UcnFDKxkCv+InMz
	AA5NrimWjt1z4uD4hZNae4EIXGGKnbiaz88RCWPjLkyTRgVe+D3y0887A9J6FrNsJtZX6LoikD0
	Q==
X-Google-Smtp-Source: AGHT+IEh67BPddDPTFD/tfb4fSwiCqr0a9Zn5VVe9gpDL/kfIfnog3VmVjGUueJWQ9mX4X2FFYYG425DMTQCtZmeDdo=
X-Received: by 2002:a05:622a:738b:b0:4a9:a4ef:35d3 with SMTP id
 d75a77b69052e-4a9d4701facmr2137511cf.7.1751992499047; Tue, 08 Jul 2025
 09:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630031958.1225651-1-sashal@kernel.org> <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
 <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com> <aG06QBVeBJgluSqP@lappy>
 <CAJuCfpH5NQBJMqs9U2VjyA_f6Fho2VAcQq=ORw-iW8qhVCDSuA@mail.gmail.com> <aG0_-79QiMEk3N-R@lappy>
In-Reply-To: <aG0_-79QiMEk3N-R@lappy>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 8 Jul 2025 09:34:48 -0700
X-Gm-Features: Ac12FXzzSrrvF71LQqsCA0KSGYduhbXVbeZdy5-T37l-FdsQQhzkvZIbKhxe_qE
Message-ID: <CAJuCfpF3K49Z8uevF6M9FZX-tFgJDCkCi54iL=xwDuQB2RMqoA@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration entries
To: Sasha Levin <sashal@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com, 
	aarcange@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 8:57=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> On Tue, Jul 08, 2025 at 08:39:47AM -0700, Suren Baghdasaryan wrote:
> >On Tue, Jul 8, 2025 at 8:33=E2=80=AFAM Sasha Levin <sashal@kernel.org> w=
rote:
> >>
> >> On Tue, Jul 08, 2025 at 05:10:44PM +0200, David Hildenbrand wrote:
> >> >On 01.07.25 02:57, Andrew Morton wrote:
> >> >>On Sun, 29 Jun 2025 23:19:58 -0400 Sasha Levin <sashal@kernel.org> w=
rote:
> >> >>
> >> >>>When handling non-swap entries in move_pages_pte(), the error handl=
ing
> >> >>>for entries that are NOT migration entries fails to unmap the page =
table
> >> >>>entries before jumping to the error handling label.
> >> >>>
> >> >>>This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE sys=
tems
> >> >>>triggers a WARNING in kunmap_local_indexed() because the kmap stack=
 is
> >> >>>corrupted.
> >> >>>
> >> >>>Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
> >> >>>   WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_indexe=
d+0x178/0x17c
> >> >>>   Call trace:
> >> >>>     kunmap_local_indexed from move_pages+0x964/0x19f4
> >> >>>     move_pages from userfaultfd_ioctl+0x129c/0x2144
> >> >>>     userfaultfd_ioctl from sys_ioctl+0x558/0xd24
> >> >>>
> >> >>>The issue was introduced with the UFFDIO_MOVE feature but became mo=
re
> >> >>>frequent with the addition of guard pages (commit 7c53dfbdb024 ("mm=
: add
> >> >>>PTE_MARKER_GUARD PTE marker")) which made the non-migration entry c=
ode
> >> >>>path more commonly executed during userfaultfd operations.
> >> >>>
> >> >>>Fix this by ensuring PTEs are properly unmapped in all non-swap ent=
ry
> >> >>>paths before jumping to the error handling label, not just for migr=
ation
> >> >>>entries.
> >> >>
> >> >>I don't get it.
> >> >>
> >> >>>--- a/mm/userfaultfd.c
> >> >>>+++ b/mm/userfaultfd.c
> >> >>>@@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct =
*mm, pmd_t *dst_pmd, pmd_t *src_pmd,
> >> >>>             entry =3D pte_to_swp_entry(orig_src_pte);
> >> >>>             if (non_swap_entry(entry)) {
> >> >>>+                    pte_unmap(src_pte);
> >> >>>+                    pte_unmap(dst_pte);
> >> >>>+                    src_pte =3D dst_pte =3D NULL;
> >> >>>                     if (is_migration_entry(entry)) {
> >> >>>-                            pte_unmap(src_pte);
> >> >>>-                            pte_unmap(dst_pte);
> >> >>>-                            src_pte =3D dst_pte =3D NULL;
> >> >>>                             migration_entry_wait(mm, src_pmd, src_=
addr);
> >> >>>                             err =3D -EAGAIN;
> >> >>>-                    } else
> >> >>>+                    } else {
> >> >>>                             err =3D -EFAULT;
> >> >>>+                    }
> >> >>>                     goto out;
> >> >>
> >> >>where we have
> >> >>
> >> >>out:
> >> >>      ...
> >> >>      if (dst_pte)
> >> >>              pte_unmap(dst_pte);
> >> >>      if (src_pte)
> >> >>              pte_unmap(src_pte);
> >> >
> >> >AI slop?
> >>
> >> Nah, this one is sadly all me :(
> >>
> >> I was trying to resolve some of the issues found with linus-next on
> >> LKFT, and misunderstood the code. Funny enough, I thought that the
> >> change above "fixed" it by making the warnings go away, but clearly is
> >> the wrong thing to do so I went back to the drawing table...
> >>
> >> If you're curious, here's the issue: https://qa-reports.linaro.org/lkf=
t/sashal-linus-next/build/v6.13-rc7-43418-g558c6dd4d863/testrun/29030370/su=
ite/log-parser-test/test/exception-warning-cpu-pid-at-mmhighmem-kunmap_loca=
l_indexed/details/
> >
> >Any way to symbolize that Call trace? I can't find build artefacts to
> >extract vmlinux image...
>
> The build artifacts are at
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2zSrTao2x4P640QKIx=
18JUuFdc1/
> but I couldn't get it to do the right thing. I'm guessing that I need
> some magical arm32 toolchain bits that I don't carry:
>
> cat tr.txt | ./scripts/decode_stacktrace.sh vmlinux
> <4>[   38.566145] ------------[ cut here ]------------
> <4>[ 38.566392] WARNING: CPU: 1 PID: 637 at mm/highmem.c:622 kunmap_local=
_indexed+0x198/0x1a4
> <4>[   38.569398] Modules linked in: nfnetlink ip_tables x_tables
> <4>[   38.570481] CPU: 1 UID: 0 PID: 637 Comm: uffd-unit-tests Not tainte=
d 6.16.0-rc4 #1 NONE
> <4>[   38.570815] Hardware name: Generic DT based system
> <4>[   38.571073] Call trace:
> <4>[ 38.571239] unwind_backtrace from show_stack (arch/arm64/kernel/stack=
trace.c:465)
> <4>[ 38.571602] show_stack from dump_stack_lvl (lib/dump_stack.c:118 (dis=
criminator 1))
> <4>[ 38.571805] dump_stack_lvl from __warn (kernel/panic.c:791)
> <4>[ 38.572002] __warn from warn_slowpath_fmt+0xa8/0x174
> <4>[ 38.572290] warn_slowpath_fmt from kunmap_local_indexed+0x198/0x1a4
> <4>[ 38.572520] kunmap_local_indexed from move_pages_pte+0xc40/0xf48
> <4>[ 38.572970] move_pages_pte from move_pages+0x428/0x5bc
> <4>[ 38.573189] move_pages from userfaultfd_ioctl+0x900/0x1ec0
> <4>[ 38.573376] userfaultfd_ioctl from sys_ioctl+0xd24/0xd90
> <4>[ 38.573581] sys_ioctl from ret_fast_syscall+0x0/0x5c
> <4>[   38.573810] Exception stack(0xf9d69fa8 to 0xf9d69ff0)
> <4>[   38.574546] 9fa0:                   00001000 00000005 00000005 c028=
aa05 b2d3ecd8 b2d3ecc8
> <4>[   38.574919] 9fc0: 00001000 00000005 b2d3ece0 00000036 b2d3ed84 b2d3=
ed50 b2d3ed7c b2d3ed58
> <4>[   38.575131] 9fe0: 00000036 b2d3ecb0 b6df1861 b6d5f736
> <4>[   38.575511] ---[ end trace 0000000000000000 ]---

Ah, I know what's going on. 6.13.rc7 which is used in this test does
not have my fix 927e926d72d9 ("userfaultfd: fix PTE unmapping
stack-allocated PTE copies") (see
https://elixir.bootlin.com/linux/v6.13.7/source/mm/userfaultfd.c#L1284).
It was backported into 6.13.rc8. So, it tries to unmap a copy of a
mapped PTE, which will fail when CONFIG_HIGHPTE is enabled. So, it
makes sense that it is failing on arm32.

>
> --
> Thanks,
> Sasha

