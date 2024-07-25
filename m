Return-Path: <stable+bounces-61375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD0993BF14
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 11:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96BF2810F6
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 09:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3DA171E5D;
	Thu, 25 Jul 2024 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IwtDcj9C"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F2F13A884
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721899596; cv=none; b=r+H3D0avpty67WxJMENjip3LszKOtEh3uJO1D3yVxjRp9G11NCjpq+3Ok8xWjPAJP79FyeRTGgDdjuYNSGp5v1CitPqdyGMr9lEF1ND/u6eh3aK4949dRJgwYliWyehTyP6ExcjpYCQ5ufNNTFvTKvdjL0amVJLuU4u5TibvUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721899596; c=relaxed/simple;
	bh=nqyPDXL3RaKkGEzYzy+S7I5qflCBm77t+XBO0uW1O4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXfLx2CtjZp1zv19Tmdf6PEhsyluT6QztuBGuOLcG/MZkSq1/1aO9syi+Sk7uMxDLpXFgUdyTZtc9K33YNcAlmIwtOGKV008wdj8CwuzqZ23MvAQfzko5QwodqDjVi2Bd6TKmtZbvyGdj+WCYv9v9qId4zKAOUldckOCr7ILXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IwtDcj9C; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428078ebeb9so14685e9.0
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 02:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721899593; x=1722504393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG6GqzuTDE+Czd1mvBKHFNZcPazYjLPjOFP0pRrelfY=;
        b=IwtDcj9Ce7DJnq0NUZ1WKQ5nFBTsNxwTsWg0DCer2sVepIYdrJPhWKtzVw6RIL/BWv
         +ZqfpbnQUFNWuYsWphpbeCIljN2biQAsa+ktIeV/klIPbDaK5XiiMjtuOw4dRzRadQ9C
         QqPNOCK3/NrcN4Ky8Dz2N+Hto17FCCmAyk24REvREuJe3Gu0Yfgdbk88ymvmwk4BwOs1
         djiUxueFWByAmYdPjx1VMzPjCjPP8oEagdE4pILxN0yIP9cPR2NKc2y4NsUldUQgLwoy
         KIWIhSv2yAW2YzUqBuD/fL+HnaWdXL5QHBa3jqdbOHUi6z/hjgu2PPeLOvnvy9xmixBC
         biaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721899593; x=1722504393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nG6GqzuTDE+Czd1mvBKHFNZcPazYjLPjOFP0pRrelfY=;
        b=oKvqlr5asSPT/TIF2ktGKYU2V/xx9OvoaqET/8gwKawGPt9X+jD87ORyKLxMh0MuxY
         HFRROl63yHBuMLyZtdldwLnl4gBFS/QIymzaamU0w32i/zVXy3PbMmFVitNqcKwRfhCW
         ffkG5s9BmcnkaQf9WKn/a3rRtKqLhGnGm2Tr0gl94ZQA1lDodtl8c2YE3rrjZYL9ht3Z
         ny50ivGl1p+FDgOG8wnYW+2k7NH2S+axbCV6XjY0GkU0OGXldpBniNR5wS2nYlkBqTr9
         eO+CoI+N+pToO7waHXLYSe66mL4k2oGdSVCG/LFQZVo66mgaq5gh19IEUHNEKlkATdex
         UKHw==
X-Gm-Message-State: AOJu0Yw32STZS8YOKq/V2M738QzltYM0PD9Wiyn9jKHwddesX8jTUiXK
	XRXlQyPq08E9dmpoF4B54pqHCjEhSt7mpCQonzFjb20b1/E+mKbh00ZfztvpYV4O7zOzAUw1Cfp
	wSMC2UftMuco61WbLp1wv4YY+jkXAeCoU5QbT
X-Google-Smtp-Source: AGHT+IEWF3qs1Qtmb7LabRTk3uvb6ShyDXISQJPMPDnUovpe3+aQ8qa9gwTXgv0P9mrhSVbgzMzyWVzGNPUFuzxONmQ=
X-Received: by 2002:a05:600c:350f:b0:424:898b:522b with SMTP id
 5b1f17b1804b1-42803ff9e85mr1161215e9.1.1721899592899; Thu, 25 Jul 2024
 02:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725091502.2808792-1-kniv@yandex-team.ru>
In-Reply-To: <20240725091502.2808792-1-kniv@yandex-team.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jul 2024 11:26:18 +0200
Message-ID: <CANn89iKreKLrA=PEwkX4wt34Z=FumJy-hNEn9jtYfypS+9PaWA@mail.gmail.com>
Subject: Re: [PATCH 4.19 5.4 5.10 5.15] net: relax socket state check at
 accept time.
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>, 
	Christoph Paasch <cpaasch@apple.com>, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 11:15=E2=80=AFAM Nikolay Kuratov <kniv@yandex-team.=
ru> wrote:
>
> [ Upstream commit 26afda78cda3da974fd4c287962c169e9462c495 ]
>
> Christoph reported the following splat:
>
> WARNING: CPU: 1 PID: 772 at net/ipv4/af_inet.c:761 __inet_accept+0x1f4/0x=
4a0
> Modules linked in:
> CPU: 1 PID: 772 Comm: syz-executor510 Not tainted 6.9.0-rc7-g7da7119fe22b=
 #56
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 =
04/01/2014
> RIP: 0010:__inet_accept+0x1f4/0x4a0 net/ipv4/af_inet.c:759
> Code: 04 38 84 c0 0f 85 87 00 00 00 41 c7 04 24 03 00 00 00 48 83 c4 10 5=
b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 ec b7 da fd <0f> 0b e9 7f fe=
 ff ff e8 e0 b7 da fd 0f 0b e9 fe fe ff ff 89 d9 80
> RSP: 0018:ffffc90000c2fc58 EFLAGS: 00010293
> RAX: ffffffff836bdd14 RBX: 0000000000000000 RCX: ffff888104668000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: dffffc0000000000 R08: ffffffff836bdb89 R09: fffff52000185f64
> R10: dffffc0000000000 R11: fffff52000185f64 R12: dffffc0000000000
> R13: 1ffff92000185f98 R14: ffff88810754d880 R15: ffff8881007b7800
> FS:  000000001c772880(0000) GS:ffff88811b280000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb9fcf2e178 CR3: 00000001045d2002 CR4: 0000000000770ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  inet_accept+0x138/0x1d0 net/ipv4/af_inet.c:786
>  do_accept+0x435/0x620 net/socket.c:1929
>  __sys_accept4_file net/socket.c:1969 [inline]
>  __sys_accept4+0x9b/0x110 net/socket.c:1999
>  __do_sys_accept net/socket.c:2016 [inline]
>  __se_sys_accept net/socket.c:2013 [inline]
>  __x64_sys_accept+0x7d/0x90 net/socket.c:2013
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x58/0x100 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x4315f9
> Code: fd ff 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 0f 83 ab b4 fd ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffdb26d9c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002b
> RAX: ffffffffffffffda RBX: 0000000000400300 RCX: 00000000004315f9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 00000000006e1018 R08: 0000000000400300 R09: 0000000000400300
> R10: 0000000000400300 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000040cdf0 R14: 000000000040ce80 R15: 0000000000000055
>  </TASK>
>
> The reproducer invokes shutdown() before entering the listener status.
> After commit 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) for
> TCP_SYN_RECV sockets"), the above causes the child to reach the accept
> syscall in FIN_WAIT1 status.
>
> Eric noted we can relax the existing assertion in __inet_accept()
>
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/490
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Fixes: 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV=
 sockets")
> Link: https://lore.kernel.org/r/23ab880a44d8cfd967e84de8b93dbf48848e3d8c.=
1716299669.git.pabeni@redhat.com
> Link: https://lore.kernel.org/linux-cve-announce/2024062136-CVE-2024-3648=
4-375b@gregkh

Missing the original author ?

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> ---
>  net/ipv4/af_inet.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 475a19db3713..ce42626663de 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -758,7 +758,9 @@ int inet_accept(struct socket *sock, struct socket *n=
ewsock, int flags,
>         sock_rps_record_flow(sk2);
>         WARN_ON(!((1 << sk2->sk_state) &
>                   (TCPF_ESTABLISHED | TCPF_SYN_RECV |
> -                 TCPF_CLOSE_WAIT | TCPF_CLOSE)));
> +                  TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 |
> +                  TCPF_CLOSING | TCPF_CLOSE_WAIT |
> +                  TCPF_CLOSE)));
>
>         sock_graft(sk2, newsock);
>
> --
> 2.34.1
>

