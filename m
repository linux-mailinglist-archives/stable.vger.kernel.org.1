Return-Path: <stable+bounces-52605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D638690BC34
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 22:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFE9284936
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 20:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294BC18FC6A;
	Mon, 17 Jun 2024 20:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="F/QoPec2"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BF3F9F7;
	Mon, 17 Jun 2024 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656267; cv=none; b=tcJihynhH1FDeHKMK7D72Lw++D77UVnMg/ZQcev/K4nQ4BS7eiXFNzXdfsgh8tpvElHcz8VomKvFIi98w0dVd2hbmpcvzynnWyg2v+khnnKhotKsrg8rQC9DHy++oSIxmg4AMctJ7BU5lwOh0wQGAp7d0GwUqZT3BqlfDsE1ims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656267; c=relaxed/simple;
	bh=WcKrT/rg+wQ0qVdpNz/1++mnHbo87dnDF65GYYAYSNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIg9xJhz7iNJaRnt8CBavP77ijKFkuyLKByXcWUrqE0jQA2twKvTlVxzQv+I7G5hpFtMBCcfAkYlJsNzDSrxswTkgyXkxbzUKKWK8W/qH23W/X5MUm6K8pTQoTVkAmiXDZ8Q43d6b4GDkUszDRGNFLlq1B8YOPsUno8ggjlJACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=F/QoPec2; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718656267; x=1750192267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VlPB0O2dnR3nvk4Kh7euEZXylj1IyW7hKA8b3eERaK8=;
  b=F/QoPec2xaymIpPaUedQ3+yerPiS/tt2Qi+enaqP3Q4jh6zMfjhG81BY
   8rnz+z/FUIAPDDwTStj9MWT/V2uTSQtk6Et7zA25TqH4M4rkj8dUyfI3D
   qTix1at5YTGJYKJqnA0v/zlswe81GSn/ZaHRMDx1ckJbikHs58fSvSgDR
   Q=;
X-IronPort-AV: E=Sophos;i="6.08,245,1712620800"; 
   d="scan'208";a="413945634"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 20:31:03 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:35396]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.128:2525] with esmtp (Farcaster)
 id c6dc14fa-53e4-4974-a338-b2cb36969ba5; Mon, 17 Jun 2024 20:31:01 +0000 (UTC)
X-Farcaster-Flow-ID: c6dc14fa-53e4-4974-a338-b2cb36969ba5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 17 Jun 2024 20:31:01 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 17 Jun 2024 20:30:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ignat@cloudflare.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernel-team@cloudflare.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <revest@chromium.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] net: do not leave a dangling sk pointer, when socket creation fails
Date: Mon, 17 Jun 2024 13:30:50 -0700
Message-ID: <20240617203050.84843-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240617195934.64810-1-ignat@cloudflare.com>
References: <20240617195934.64810-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 17 Jun 2024 20:59:34 +0100
> A KASAN enabled kernel will log something like below (decoded and stripped):
> [   78.328507][  T299] ==================================================================
> [ 78.329018][ T299] BUG: KASAN: slab-use-after-free in __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
> [   78.329366][  T299] Read of size 8 at addr ffff888007110dd8 by task traceroute/299
> [   78.329366][  T299]
> [   78.329366][  T299] CPU: 2 PID: 299 Comm: traceroute Tainted: G            E      6.10.0-rc2+ #2
> [   78.329366][  T299] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   78.329366][  T299] Call Trace:
> [   78.329366][  T299]  <TASK>
> [ 78.329366][ T299] dump_stack_lvl (lib/dump_stack.c:117 (discriminator 1))
> [ 78.329366][ T299] print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
> [ 78.329366][ T299] ? __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
> [ 78.329366][ T299] kasan_report (mm/kasan/report.c:603)
> [ 78.329366][ T299] ? __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
> [ 78.329366][ T299] kasan_check_range (mm/kasan/generic.c:183 mm/kasan/generic.c:189)
> [ 78.329366][ T299] __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
> [ 78.329366][ T299] bpf_get_socket_ptr_cookie (./arch/x86/include/asm/preempt.h:94 ./include/linux/sock_diag.h:42 net/core/filter.c:5094 net/core/filter.c:5092)
> [ 78.329366][ T299] bpf_prog_875642cf11f1d139___sock_release+0x6e/0x8e
> [ 78.329366][ T299] bpf_trampoline_6442506592+0x47/0xaf
> [ 78.329366][ T299] __sock_release (net/socket.c:652)
> [ 78.329366][ T299] __sock_create (net/socket.c:1601)
> ...
> [   78.329366][  T299] Allocated by task 299 on cpu 2 at 78.328492s:
> [ 78.329366][ T299] kasan_save_stack (mm/kasan/common.c:48)
> [ 78.329366][ T299] kasan_save_track (mm/kasan/common.c:68)
> [ 78.329366][ T299] __kasan_slab_alloc (mm/kasan/common.c:312 mm/kasan/common.c:338)
> [ 78.329366][ T299] kmem_cache_alloc_noprof (mm/slub.c:3941 mm/slub.c:4000 mm/slub.c:4007)
> [ 78.329366][ T299] sk_prot_alloc (net/core/sock.c:2075)
> [ 78.329366][ T299] sk_alloc (net/core/sock.c:2134)
> [ 78.329366][ T299] inet_create (net/ipv4/af_inet.c:327 net/ipv4/af_inet.c:252)
> [ 78.329366][ T299] __sock_create (net/socket.c:1572)
> [ 78.329366][ T299] __sys_socket (net/socket.c:1660 net/socket.c:1644 net/socket.c:1706)
> [ 78.329366][ T299] __x64_sys_socket (net/socket.c:1718)
> [ 78.329366][ T299] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> [ 78.329366][ T299] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> [   78.329366][  T299]
> [   78.329366][  T299] Freed by task 299 on cpu 2 at 78.328502s:
> [ 78.329366][ T299] kasan_save_stack (mm/kasan/common.c:48)
> [ 78.329366][ T299] kasan_save_track (mm/kasan/common.c:68)
> [ 78.329366][ T299] kasan_save_free_info (mm/kasan/generic.c:582)
> [ 78.329366][ T299] poison_slab_object (mm/kasan/common.c:242)
> [ 78.329366][ T299] __kasan_slab_free (mm/kasan/common.c:256)
> [ 78.329366][ T299] kmem_cache_free (mm/slub.c:4437 mm/slub.c:4511)
> [ 78.329366][ T299] __sk_destruct (net/core/sock.c:2117 net/core/sock.c:2208)
> [ 78.329366][ T299] inet_create (net/ipv4/af_inet.c:397 net/ipv4/af_inet.c:252)
> [ 78.329366][ T299] __sock_create (net/socket.c:1572)
> [ 78.329366][ T299] __sys_socket (net/socket.c:1660 net/socket.c:1644 net/socket.c:1706)
> [ 78.329366][ T299] __x64_sys_socket (net/socket.c:1718)
> [ 78.329366][ T299] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> [ 78.329366][ T299] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> 
> Fix this by clearing the struct socket reference in sk_common_release() to cover
> all protocol families create functions.
> 
> Fixes: c5dbb89fc2ac ("bpf: Expose bpf_get_socket_cookie to tracing programs")
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/netdev/20240613194047.36478-1-kuniyu@amazon.com/T/
> ---
> Changes in v2:
>   * moved the NULL-ing of the socket reference to sk_common_release() (as
>     suggested by Kuniyuki Iwashima)
>   * trimmed down the KASAN report in the commit message to show only relevant
>     info

It seems the most important repro was lost.  I'd like to keep that
in the commit message so that we can easily understand the Fixes:
tag and how the issue happens.

While at it, could you remove the timestamp and thread id in KASAN
splat ?


> 
>  net/core/sock.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 8629f9aecf91..575af557c46b 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3742,6 +3742,17 @@ void sk_common_release(struct sock *sk)
>  
>  	sk->sk_prot->unhash(sk);
>  
> +	/*
> +	 * struct net_proto_family create functions like inet_create() or

nit: This should be netdev style:

        /* struct net_proto_family ...
	 * ...
	 */

  See: Documentation/process/maintainer-netdev.rst

But I think the comment is not needed here if the commit message has

  * KASAN splat
  * How the problem happens
    * run bpf_get_socket_cookie() in __sock_release()
  * What the problem is
    * UAF happens if pf->create() fails after calling sock_init_data()

, we can just git-blame the change below.

Thanks!


> +	 * inet6_create() have an error path, which call this function. This sk
> +	 * may have already been associated with a struct socket, so ensure to
> +	 * clear this reference not to leave a dangling pointer in the
> +	 * struct socket instance.
> +	 */
> +
> +	if (sk->sk_socket)
> +		sk->sk_socket->sk = NULL;
> +
>  	/*
>  	 * In this point socket cannot receive new packets, but it is possible
>  	 * that some packets are in flight because some CPU runs receiver and
> -- 
> 2.39.2

