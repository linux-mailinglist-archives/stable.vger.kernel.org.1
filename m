Return-Path: <stable+bounces-54083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A2090EC96
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41721C22C15
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D481E143C4A;
	Wed, 19 Jun 2024 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dMDtwO8D"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2120C146016
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802538; cv=none; b=rouVgj0OSQCzKj0me3vf1VHxqVIpbvlGTcSWQgt704DqedmRGbZwJAB/nC2gSg1QeHkMbe+wtZ5M6IuPkL2Dfx0mFqw3UaLa9NkrmGS7eTDAEhQwWop2SKgBEXKqQRAJ7nZq2OylG7mkXRBn/tIeN8fC4vVR/diYuzZBGkqy79A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802538; c=relaxed/simple;
	bh=5/ZgA8zhLrdVDYchq6/Y99NUFdbXaCiUTPCiwdCmYYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYNUTdIK5bn5lJxDWYviLsQZJmMDPmKTZOz8QZp/xUY6F3ldOBJy3jjjA+0U0gl0BbImEKTiHTo6l3VMt9WoxFw6NClYa34ymwV/J+o3cpAZrNtkXg8PZAkh/c3CG4k74fPCOiWp6zqWzF0tMbs23S+TUaaCoxQi54ftVgLu9vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dMDtwO8D; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so5122754a12.0
        for <stable@vger.kernel.org>; Wed, 19 Jun 2024 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718802536; x=1719407336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7QBxRjX6bK4nfQFtvwlMhqO1YN0X8hSMyp1M5GJNSs=;
        b=dMDtwO8D4rRZpxE+ZilOMCvkuFWoxd4wuZH1TLWWmsHrWGhQiBLL7pgZmlMF/Hi/ix
         jKXx+NGuNJGTgB0PnFO4OS1MW2wVJLbg4P+GVA8wW/ZL42ziX5fyceoEQByaKOrniZUx
         TGY1olKRSVSqDlAAm4qcGWj9e7CKNC9oq5TwBioL144/cr6k7ylufN5VVkD+fIEBLwyp
         jp2U6x6sUfG+QOiYrYHANmG0r2bt76P6rHSPgm3pXXeGsuJ5ntgP77/p6e1oMNCMHH6I
         cDqOmX3E4B3A+ckxF0Rb6qJQUgiQGibpDMT+Oi+572A0MYDetADXmFuV1rBW96QlcE/x
         15jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718802536; x=1719407336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7QBxRjX6bK4nfQFtvwlMhqO1YN0X8hSMyp1M5GJNSs=;
        b=AUuCEvnvUlBbt4DgoJQIXg7w80P7ihuPif6PXUQs3bsKiVXUIDDgR2NtTAWPvRlPU1
         vY43vweBqA+C+93tp4CTWUxyWSlriCxt8X6KEgLRgHIgehk0KbRnoKPJkDkxauWWuJAr
         06OrITBr3JgYE/RmoQyFod07uwgyyniWERBUC64RisOrd7nO485itnIOr39IKLa67fnW
         lfueMqkdScF74q/C10oY77hFlBEnPOBEJhvnRiJr3amfRQO9Dc65D8q3yKUvMVJZXmht
         uyrpsoSes8YBA4XMGxjH7bcFB4Uv0lc7b4sqcXJHn1Zt7kYmjFunDLVGJhT2ECMtRdj2
         VC3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDh/N2+WhdOsDT8EVHKMBcc6vCBi+6qQdGaxbnoNIWdpWKea28u+tgYIIkSJilNC9F6twtkWt1FjU8G2dGmB3Z3py3R/fD
X-Gm-Message-State: AOJu0Yy+Kax2NYbjGEiBxAHApui0qGKEnEP2goQBw2qdlcbeVpojT2Lq
	8hvzKkzLORzVh/JH2vAsWfwfmBtACBixRtt8GuBQjDYVtpn6sSlIjyxprN6qxHAzxRpOruODEsz
	8yWQynBkM3XFfSPPC0diGm/orloT0USrtUOTuEa9zwPZ0tUnHYH1Vnw==
X-Google-Smtp-Source: AGHT+IE0FPXNumij9mjrz3O1ImHZTXZjz3dyjeywqSnPUCIu/Ng38CP6z8Kvps/xrN0z7q87QtndEIlgt/vVLUqsO7E=
X-Received: by 2002:a17:90a:f0d4:b0:2c2:fa5e:106a with SMTP id
 98e67ed59e1d1-2c7b5db2a3fmr2356670a91.48.1718802536199; Wed, 19 Jun 2024
 06:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617210205.67311-1-ignat@cloudflare.com> <c9446790-9bac-4541-919b-0af396349c59@linux.alibaba.com>
In-Reply-To: <c9446790-9bac-4541-919b-0af396349c59@linux.alibaba.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 19 Jun 2024 14:08:45 +0100
Message-ID: <CALrw=nGSf49VnRVy--b5qSM7_rSRyDBUFe_t8taFs2tmRP2QTw@mail.gmail.com>
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

On Wed, Jun 19, 2024 at 1:31=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
>
>
> On 6/18/24 5:02 AM, Ignat Korchagin wrote:
> > It is possible to trigger a use-after-free by:
> >    * attaching an fentry probe to __sock_release() and the probe callin=
g the
> >      bpf_get_socket_cookie() helper
> >    * running traceroute -I 1.1.1.1 on a freshly booted VM
> >
> > A KASAN enabled kernel will log something like below (decoded and strip=
ped):
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in __sock_gen_cookie (./arch/x86/includ=
e/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 .=
/include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
> > Read of size 8 at addr ffff888007110dd8 by task traceroute/299
> >
> > CPU: 2 PID: 299 Comm: traceroute Tainted: G            E      6.10.0-rc=
2+ #2
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debi=
an-1.16.2-1 04/01/2014
> > Call Trace:
> >   <TASK>
> > dump_stack_lvl (lib/dump_stack.c:117 (discriminator 1))
> > print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
> > ? __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/=
linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-inst=
rumented.h:1611 net/core/sock_diag.c:29)
> > kasan_report (mm/kasan/report.c:603)
> > ? __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/=
linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-inst=
rumented.h:1611 net/core/sock_diag.c:29)
> > kasan_check_range (mm/kasan/generic.c:183 mm/kasan/generic.c:189)
> > __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/li=
nux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instru=
mented.h:1611 net/core/sock_diag.c:29)
> > bpf_get_socket_ptr_cookie (./arch/x86/include/asm/preempt.h:94 ./includ=
e/linux/sock_diag.h:42 net/core/filter.c:5094 net/core/filter.c:5092)
> > bpf_prog_875642cf11f1d139___sock_release+0x6e/0x8e
> > bpf_trampoline_6442506592+0x47/0xaf
> > __sock_release (net/socket.c:652)
> > __sock_create (net/socket.c:1601)
> > ...
> > Allocated by task 299 on cpu 2 at 78.328492s:
> > kasan_save_stack (mm/kasan/common.c:48)
> > kasan_save_track (mm/kasan/common.c:68)
> > __kasan_slab_alloc (mm/kasan/common.c:312 mm/kasan/common.c:338)
> > kmem_cache_alloc_noprof (mm/slub.c:3941 mm/slub.c:4000 mm/slub.c:4007)
> > sk_prot_alloc (net/core/sock.c:2075)
> > sk_alloc (net/core/sock.c:2134)
> > inet_create (net/ipv4/af_inet.c:327 net/ipv4/af_inet.c:252)
> > __sock_create (net/socket.c:1572)
> > __sys_socket (net/socket.c:1660 net/socket.c:1644 net/socket.c:1706)
> > __x64_sys_socket (net/socket.c:1718)
> > do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> > entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> >
> > Freed by task 299 on cpu 2 at 78.328502s:
> > kasan_save_stack (mm/kasan/common.c:48)
> > kasan_save_track (mm/kasan/common.c:68)
> > kasan_save_free_info (mm/kasan/generic.c:582)
> > poison_slab_object (mm/kasan/common.c:242)
> > __kasan_slab_free (mm/kasan/common.c:256)
> > kmem_cache_free (mm/slub.c:4437 mm/slub.c:4511)
> > __sk_destruct (net/core/sock.c:2117 net/core/sock.c:2208)
> > inet_create (net/ipv4/af_inet.c:397 net/ipv4/af_inet.c:252)
> > __sock_create (net/socket.c:1572)
> > __sys_socket (net/socket.c:1660 net/socket.c:1644 net/socket.c:1706)
> > __x64_sys_socket (net/socket.c:1718)
> > do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> > entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> >
> > Fix this by clearing the struct socket reference in sk_common_release()=
 to cover
> > all protocol families create functions, which may already attached the
> > reference to the sk object with sock_init_data().
> >
> > Fixes: c5dbb89fc2ac ("bpf: Expose bpf_get_socket_cookie to tracing prog=
rams")
> > Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/netdev/20240613194047.36478-1-kuniyu@amaz=
on.com/T/
> > ---
> > Changes in v3:
> >    * re-added KASAN repro steps to the commit message (somehow stripped=
 in v2)
> >    * stripped timestamps and thread id from the KASAN splat
> >    * removed comment from the code (commit message should be enough)
> >
> > Changes in v2:
> >    * moved the NULL-ing of the socket reference to sk_common_release() =
(as
> >      suggested by Kuniyuki Iwashima)
> >    * trimmed down the KASAN report in the commit message to show only r=
elevant
> >      info
> >
> >   net/core/sock.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 8629f9aecf91..100e975073ca 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -3742,6 +3742,9 @@ void sk_common_release(struct sock *sk)
> >
> >       sk->sk_prot->unhash(sk);
> >
> > +     if (sk->sk_socket)
> > +             sk->sk_socket->sk =3D NULL;
> > +
> >       /*
> >        * In this point socket cannot receive new packets, but it is pos=
sible
> >        * that some packets are in flight because some CPU runs receiver=
 and
>
> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
>
>
> A small tip:
>
> It seems that you might have missed CCing some maintainers, using
> scripts/get_maintainer.pl "Your patch" can help you avoid this issue
> again.

Thanks. I did scripts/get_maintainer.pl <file I'm modifying>. Not sure
if it is different.

>
> D. Wythe
>
>
>

