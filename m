Return-Path: <stable+bounces-52609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA9990BCB5
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 23:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A900D285667
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 21:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5887B1741D7;
	Mon, 17 Jun 2024 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Q2BHM1va"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728191991DD;
	Mon, 17 Jun 2024 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658931; cv=none; b=iToLhQIrAAhwA6iq3L4U1I5tbEdlS0sAS8SmAeXrkl227IHvdtDqqZm3sGRxa6ObrwUHcOJ+D6cIFa+J/iYfScWPyR+tQRYbF8VM6Trl4t6G7mOSHtQoHl1DLmpkAdtOYJOMKsjfnRZJ1gvAsS8xh3hEayJF/g8sEl7Nf2nhVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658931; c=relaxed/simple;
	bh=TPgwPxxcuXihDS6Fd5kqNYs3tbUpZkERktoUP7ijzLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lm1p17j8LRta3ve6D/2XEyRlcEGaFTukg55AqVHGxdzY21Fqut0R+1g4bmlTW0z7mQkkxk1eXVK0g6rJA+D7DjiyugZfA9n5IzKSGZtSsz4DiQnogMXSTM47dU7UGY9azwnrriDHFOe0T1XMjG3NGlMpiF895yFklGPeOwTJA/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Q2BHM1va; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718658930; x=1750194930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ywO+hwyTv+j8f6emuBiZ+9A/DunuRT51chwUSajyKgU=;
  b=Q2BHM1vaDcksDdv0+OrF7KggixW+J/nlpqsoRcgz8HIKqzpdF/2EMHcS
   oSadV20fwlr1VOwlK769uD9mwBLa/wmqYG/sZo7KdNXuysv8uxEIcW0/D
   n64j8q3wcCq6lxSzi1gh5ediQdARc1br7pGuk6Jawo7EgsSIAIkg8sF0l
   M=;
X-IronPort-AV: E=Sophos;i="6.08,245,1712620800"; 
   d="scan'208";a="426890372"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 21:15:24 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:33573]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.97:2525] with esmtp (Farcaster)
 id 4bb6c7f5-0243-4830-be5b-a3a2332fbbc5; Mon, 17 Jun 2024 21:15:23 +0000 (UTC)
X-Farcaster-Flow-ID: 4bb6c7f5-0243-4830-be5b-a3a2332fbbc5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 17 Jun 2024 21:15:23 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 17 Jun 2024 21:15:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ignat@cloudflare.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernel-team@cloudflare.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <revest@chromium.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v3] net: do not leave a dangling sk pointer, when socket creation fails
Date: Mon, 17 Jun 2024 14:15:04 -0700
Message-ID: <20240617211504.91973-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240617210205.67311-1-ignat@cloudflare.com>
References: <20240617210205.67311-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 17 Jun 2024 22:02:05 +0100
> It is possible to trigger a use-after-free by:
>   * attaching an fentry probe to __sock_release() and the probe calling the
>     bpf_get_socket_cookie() helper
>   * running traceroute -I 1.1.1.1 on a freshly booted VM
> 
> A KASAN enabled kernel will log something like below (decoded and stripped):
> ==================================================================
> BUG: KASAN: slab-use-after-free in __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
> Read of size 8 at addr ffff888007110dd8 by task traceroute/299
> 
> CPU: 2 PID: 299 Comm: traceroute Tainted: G            E      6.10.0-rc2+ #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Call Trace:
>  <TASK>
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

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


P.S. next time, please make sure 24h pass before reposting for netdev.

  See: Documentation/process/maintainer-netdev.rst

