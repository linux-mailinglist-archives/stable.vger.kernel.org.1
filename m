Return-Path: <stable+bounces-53855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7DF90EB22
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119A428186D
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242713D625;
	Wed, 19 Jun 2024 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lZxOR0wF"
X-Original-To: stable@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFE7F484;
	Wed, 19 Jun 2024 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718800291; cv=none; b=UPB0VVOXMfkH6EuAom4t+yDE2L7jX1p7vbk44FprnpIdWChRESiRAXJO71+PYUewDLqYf6QwIPR4DPiwfA+Y1AQPAMlPgxqYaNi9oB3HTX5bTg7Ex8dXe+09IPpjj6D8LWG3BgxvDN3C+aOh4Y/bmrkMDgWsq2Z4xp214W96plk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718800291; c=relaxed/simple;
	bh=wpMOkSoPBVIQ3ZosCdP2tRyslpQaJDB9yAagwaWj1xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYCO65GdX4g70xieZs9fovUnfd7EmKSNuXvXF+mH6yli3+4ngv17GINPOA/IZoXWR6gBkj0HDeSpfTHfGM2BH4GnnewPcBhQSuetj5w9QHq/li83413ZaAofedXbVPAPDNZp7Pi1gVr/IQdPv8n2j3iXEPYsfyPi8t7PzTrvODw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lZxOR0wF; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718800285; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=B5RdL+8cB/GSNge3uIMvi0Jzb3nSy+m4P9mjkS+8pFk=;
	b=lZxOR0wFsEHkZPk9z7sYLJwIGZW+Vecin50dwXczyEb3HhMGdFCDbr5LyZQpe4iG2vVkuj8YebDnXrr1ycoWD9/IXcDu6/WEMY2njvrWntJnRuNWKoyJzrQ6eji/1xXJI2P1ZoAcGkfbMcwsEsFTUhYxE1zrQsqA/kNgeUFnKzs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W8oFJ7S_1718800283;
Received: from 30.221.146.77(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W8oFJ7S_1718800283)
          by smtp.aliyun-inc.com;
          Wed, 19 Jun 2024 20:31:24 +0800
Message-ID: <c9446790-9bac-4541-919b-0af396349c59@linux.alibaba.com>
Date: Wed, 19 Jun 2024 20:31:23 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: do not leave a dangling sk pointer, when
 socket creation fails
To: Ignat Korchagin <ignat@cloudflare.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Florent Revest <revest@chromium.org>, kernel-team@cloudflare.com,
 Kuniyuki Iwashima <kuniyu@amazon.com>, stable@vger.kernel.org
References: <20240617210205.67311-1-ignat@cloudflare.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20240617210205.67311-1-ignat@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/24 5:02 AM, Ignat Korchagin wrote:
> It is possible to trigger a use-after-free by:
>    * attaching an fentry probe to __sock_release() and the probe calling the
>      bpf_get_socket_cookie() helper
>    * running traceroute -I 1.1.1.1 on a freshly booted VM
>
> A KASAN enabled kernel will log something like below (decoded and stripped):
> ==================================================================
> BUG: KASAN: slab-use-after-free in __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
> Read of size 8 at addr ffff888007110dd8 by task traceroute/299
>
> CPU: 2 PID: 299 Comm: traceroute Tainted: G            E      6.10.0-rc2+ #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Call Trace:
>   <TASK>
> dump_stack_lvl (lib/dump_stack.c:117 (discriminator 1))
> print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
> ? __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
> kasan_report (mm/kasan/report.c:603)
> ? __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
> kasan_check_range (mm/kasan/generic.c:183 mm/kasan/generic.c:189)
> __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
> bpf_get_socket_ptr_cookie (./arch/x86/include/asm/preempt.h:94 ./include/linux/sock_diag.h:42 net/core/filter.c:5094 net/core/filter.c:5092)
> bpf_prog_875642cf11f1d139___sock_release+0x6e/0x8e
> bpf_trampoline_6442506592+0x47/0xaf
> __sock_release (net/socket.c:652)
> __sock_create (net/socket.c:1601)
> ...
> Allocated by task 299 on cpu 2 at 78.328492s:
> kasan_save_stack (mm/kasan/common.c:48)
> kasan_save_track (mm/kasan/common.c:68)
> __kasan_slab_alloc (mm/kasan/common.c:312 mm/kasan/common.c:338)
> kmem_cache_alloc_noprof (mm/slub.c:3941 mm/slub.c:4000 mm/slub.c:4007)
> sk_prot_alloc (net/core/sock.c:2075)
> sk_alloc (net/core/sock.c:2134)
> inet_create (net/ipv4/af_inet.c:327 net/ipv4/af_inet.c:252)
> __sock_create (net/socket.c:1572)
> __sys_socket (net/socket.c:1660 net/socket.c:1644 net/socket.c:1706)
> __x64_sys_socket (net/socket.c:1718)
> do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>
> Freed by task 299 on cpu 2 at 78.328502s:
> kasan_save_stack (mm/kasan/common.c:48)
> kasan_save_track (mm/kasan/common.c:68)
> kasan_save_free_info (mm/kasan/generic.c:582)
> poison_slab_object (mm/kasan/common.c:242)
> __kasan_slab_free (mm/kasan/common.c:256)
> kmem_cache_free (mm/slub.c:4437 mm/slub.c:4511)
> __sk_destruct (net/core/sock.c:2117 net/core/sock.c:2208)
> inet_create (net/ipv4/af_inet.c:397 net/ipv4/af_inet.c:252)
> __sock_create (net/socket.c:1572)
> __sys_socket (net/socket.c:1660 net/socket.c:1644 net/socket.c:1706)
> __x64_sys_socket (net/socket.c:1718)
> do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>
> Fix this by clearing the struct socket reference in sk_common_release() to cover
> all protocol families create functions, which may already attached the
> reference to the sk object with sock_init_data().
>
> Fixes: c5dbb89fc2ac ("bpf: Expose bpf_get_socket_cookie to tracing programs")
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/netdev/20240613194047.36478-1-kuniyu@amazon.com/T/
> ---
> Changes in v3:
>    * re-added KASAN repro steps to the commit message (somehow stripped in v2)
>    * stripped timestamps and thread id from the KASAN splat
>    * removed comment from the code (commit message should be enough)
>
> Changes in v2:
>    * moved the NULL-ing of the socket reference to sk_common_release() (as
>      suggested by Kuniyuki Iwashima)
>    * trimmed down the KASAN report in the commit message to show only relevant
>      info
>
>   net/core/sock.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 8629f9aecf91..100e975073ca 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3742,6 +3742,9 @@ void sk_common_release(struct sock *sk)
>   
>   	sk->sk_prot->unhash(sk);
>   
> +	if (sk->sk_socket)
> +		sk->sk_socket->sk = NULL;
> +
>   	/*
>   	 * In this point socket cannot receive new packets, but it is possible
>   	 * that some packets are in flight because some CPU runs receiver and

Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>


A small tip:

It seems that you might have missed CCing some maintainers, using
scripts/get_maintainer.pl "Your patch" can help you avoid this issue
again.


D. Wythe




