Return-Path: <stable+bounces-54648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 697D390F0CE
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 16:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E531F27423
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C0C1482EE;
	Wed, 19 Jun 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="b9O34ENC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933F81422A2
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807701; cv=none; b=Rp0Af08YB2673L0piuBxCdjEOEUDnfg7rl5UoCKTGvoRafx8H4uRKoU3o3VEj+6YU4vqL06o6sDfz2AfNX/dLvdcGFWUFopO7RwvsONHmkGBTMyS3VlWoSKVLYm5wIT0tHOC9HmIiU0Yqtq470EA6E7zm5LzRZvEGHLaGpMkJpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807701; c=relaxed/simple;
	bh=tbtlwvSwL3aX9bxxDynzolT137S68gmPIdL/KYBMujw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nj2pewmnxwV3PqvnZ65A4B8EXIDcZj36BO7efXNL3VwHXTKLQ/p4F0C3RCundcXS0778vNEfPVDebbHBLtTTH+T5tl5vlAH2Co53UL566T0PIgtgRRxcmL4pZYNteKL8xESGAsle3TByqwKNxE758bFDNAS2uyXLlVl97rmNynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=b9O34ENC; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6c5a6151ff8so4764174a12.2
        for <stable@vger.kernel.org>; Wed, 19 Jun 2024 07:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718807699; x=1719412499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iu2kBEJm52y7ucCiR3IOZoS+GHwsfCoaalsy10r4ffs=;
        b=b9O34ENCe9rVPbr43Yn5sP/N1qerS4eUN1wp9bIJoma9F4T8WUaz2TzSwd4pQDzQjo
         hF4G/Blb9Ymu6UFk96aklsenyuHF0ADLSH6FHVN6fPwChh1fpa1MUMOTyl0VCS418riX
         Gzg9E6lsq7H+QZRFJBljNhYOAfLA1452Qu6t/z8qigahnOPYggYREV80mglN4kO2Fn//
         XG71cPbIlf7PT49GXDTzjxK9hsO5GCs3Be3kKAlDM3nWhjkePv/TC295hKsy2KdFQtJe
         l/oj0kdpfJtqx9dNRGolDCxgsqp65JYOR8u83ZVyBaHZsoLdDEsF28LecJ6dQDHz0HJx
         TLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807699; x=1719412499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iu2kBEJm52y7ucCiR3IOZoS+GHwsfCoaalsy10r4ffs=;
        b=w3cNvgUMCjYTMuwRLogEwpsQXvXrDpfLes1e86i15E28wlwW/+KlgK/022fj/UWRyw
         DAOzv3kHd9uL0ru0DJ7Ox7u+QZmGaY9mFaOW61yBKiZk2gNKbTHHZX+Ti4HsamfLwCOM
         DLFYh3MBmdR6AXRzGqTQe2z//VkRAZrJJLiXPuWjqcvGtYEVXX3EXnrz1rsw/HwK6j/b
         a/FeyxnitURo5WTsO2F6ciWiJp3W6Ztna/5Sf+xmdCzhkR/4usI0lp7P2V3i7zWbpc/A
         IyltTi5YUnqvRye/Saw6Er/wYEFBHPRaj56IhZMiOmo1jZH7QNjdvt8LoumGYewAQj4d
         SNfw==
X-Forwarded-Encrypted: i=1; AJvYcCWw05QJWW/JKuTdci87I+HnLUgSIM9sJpy80SvE878zQLaFcpYNPAlhhUmGR+zgFe/3psaBfOrAUMbRttot5LL2GJ37qMU/
X-Gm-Message-State: AOJu0YziUc68GAkrzNoZfahq5psON3UOIX45MrPD/oL6/9z1/kf/WzMY
	LBDGqfLye0uajVwG4D8D2wwJ+i+VzVIt1Qm7H8WXybeDalg8qo8dGi9V8qzIHMwD4qOeXg2qmAO
	B155APSxl2rC3J9xlv2bLLF/v8v0pVtJhbLI1GQ==
X-Google-Smtp-Source: AGHT+IEIdyucDkMb4dp00FdFOGNmZrYK7rBk1lwc8JYDLA6H6z1Y/drDGuijCKNPSi3sxW1+K/gmN2H6UPJ6ePwzQBQ=
X-Received: by 2002:a17:90a:e28e:b0:2c2:f6c1:4d87 with SMTP id
 98e67ed59e1d1-2c7b5cc9ff5mr2731728a91.20.1718807698718; Wed, 19 Jun 2024
 07:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617210205.67311-1-ignat@cloudflare.com> <c9446790-9bac-4541-919b-0af396349c59@linux.alibaba.com>
 <CALrw=nGSf49VnRVy--b5qSM7_rSRyDBUFe_t8taFs2tmRP2QTw@mail.gmail.com>
In-Reply-To: <CALrw=nGSf49VnRVy--b5qSM7_rSRyDBUFe_t8taFs2tmRP2QTw@mail.gmail.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 19 Jun 2024 15:34:47 +0100
Message-ID: <CALrw=nESVt0g4k4AvSkF3yfqDDMDnGGsHavonxHMoEaBrigQPw@mail.gmail.com>
Subject: Re: [PATCH net v3] net: do not leave a dangling sk pointer, when
 socket creation fails
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Florent Revest <revest@chromium.org>, kernel-team@cloudflare.com, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 2:08=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
> On Wed, Jun 19, 2024 at 1:31=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.c=
om> wrote:
> >
> >
> >
> > On 6/18/24 5:02 AM, Ignat Korchagin wrote:
> > > It is possible to trigger a use-after-free by:
> > >    * attaching an fentry probe to __sock_release() and the probe call=
ing the
> > >      bpf_get_socket_cookie() helper
> > >    * running traceroute -I 1.1.1.1 on a freshly booted VM
> > >
> > > A KASAN enabled kernel will log something like below (decoded and str=
ipped):
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KASAN: slab-use-after-free in __sock_gen_cookie (./arch/x86/incl=
ude/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583=
 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
> > > Read of size 8 at addr ffff888007110dd8 by task traceroute/299
> > >
> > > CPU: 2 PID: 299 Comm: traceroute Tainted: G            E      6.10.0-=
rc2+ #2
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-de=
bian-1.16.2-1 04/01/2014
> > > Call Trace:
> > >   <TASK>
> > > dump_stack_lvl (lib/dump_stack.c:117 (discriminator 1))
> > > print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
> > > ? __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./includ=
e/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-in=
strumented.h:1611 net/core/sock_diag.c:29)
> > > kasan_report (mm/kasan/report.c:603)
> > > ? __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./includ=
e/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-in=
strumented.h:1611 net/core/sock_diag.c:29)
> > > kasan_check_range (mm/kasan/generic.c:183 mm/kasan/generic.c:189)
> > > __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/=
linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-inst=
rumented.h:1611 net/core/sock_diag.c:29)
> > > bpf_get_socket_ptr_cookie (./arch/x86/include/asm/preempt.h:94 ./incl=
ude/linux/sock_diag.h:42 net/core/filter.c:5094 net/core/filter.c:5092)
> > > bpf_prog_875642cf11f1d139___sock_release+0x6e/0x8e
> > > bpf_trampoline_6442506592+0x47/0xaf
> > > __sock_release (net/socket.c:652)
> > > __sock_create (net/socket.c:1601)
> > > ...
> > > Allocated by task 299 on cpu 2 at 78.328492s:
> > > kasan_save_stack (mm/kasan/common.c:48)
> > > kasan_save_track (mm/kasan/common.c:68)
> > > __kasan_slab_alloc (mm/kasan/common.c:312 mm/kasan/common.c:338)
> > > kmem_cache_alloc_noprof (mm/slub.c:3941 mm/slub.c:4000 mm/slub.c:4007=
)
> > > sk_prot_alloc (net/core/sock.c:2075)
> > > sk_alloc (net/core/sock.c:2134)
> > > inet_create (net/ipv4/af_inet.c:327 net/ipv4/af_inet.c:252)
> > > __sock_create (net/socket.c:1572)
> > > __sys_socket (net/socket.c:1660 net/socket.c:1644 net/socket.c:1706)
> > > __x64_sys_socket (net/socket.c:1718)
> > > do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> > > entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> > >
> > > Freed by task 299 on cpu 2 at 78.328502s:
> > > kasan_save_stack (mm/kasan/common.c:48)
> > > kasan_save_track (mm/kasan/common.c:68)
> > > kasan_save_free_info (mm/kasan/generic.c:582)
> > > poison_slab_object (mm/kasan/common.c:242)
> > > __kasan_slab_free (mm/kasan/common.c:256)
> > > kmem_cache_free (mm/slub.c:4437 mm/slub.c:4511)
> > > __sk_destruct (net/core/sock.c:2117 net/core/sock.c:2208)
> > > inet_create (net/ipv4/af_inet.c:397 net/ipv4/af_inet.c:252)
> > > __sock_create (net/socket.c:1572)
> > > __sys_socket (net/socket.c:1660 net/socket.c:1644 net/socket.c:1706)
> > > __x64_sys_socket (net/socket.c:1718)
> > > do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> > > entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> > >
> > > Fix this by clearing the struct socket reference in sk_common_release=
() to cover
> > > all protocol families create functions, which may already attached th=
e
> > > reference to the sk object with sock_init_data().
> > >
> > > Fixes: c5dbb89fc2ac ("bpf: Expose bpf_get_socket_cookie to tracing pr=
ograms")
> > > Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> > > Cc: stable@vger.kernel.org
> > > Link: https://lore.kernel.org/netdev/20240613194047.36478-1-kuniyu@am=
azon.com/T/
> > > ---
> > > Changes in v3:
> > >    * re-added KASAN repro steps to the commit message (somehow stripp=
ed in v2)
> > >    * stripped timestamps and thread id from the KASAN splat
> > >    * removed comment from the code (commit message should be enough)
> > >
> > > Changes in v2:
> > >    * moved the NULL-ing of the socket reference to sk_common_release(=
) (as
> > >      suggested by Kuniyuki Iwashima)
> > >    * trimmed down the KASAN report in the commit message to show only=
 relevant
> > >      info
> > >
> > >   net/core/sock.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index 8629f9aecf91..100e975073ca 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -3742,6 +3742,9 @@ void sk_common_release(struct sock *sk)
> > >
> > >       sk->sk_prot->unhash(sk);
> > >
> > > +     if (sk->sk_socket)
> > > +             sk->sk_socket->sk =3D NULL;
> > > +
> > >       /*
> > >        * In this point socket cannot receive new packets, but it is p=
ossible
> > >        * that some packets are in flight because some CPU runs receiv=
er and
> >
> > Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
> >
> >
> > A small tip:
> >
> > It seems that you might have missed CCing some maintainers, using
> > scripts/get_maintainer.pl "Your patch" can help you avoid this issue
> > again.
>
> Thanks. I did scripts/get_maintainer.pl <file I'm modifying>. Not sure
> if it is different.

My bad: it is different or I actually forgot to re-run it, because
v2/v3 modifies a different file.

> >
> > D. Wythe
> >
> >
> >

