Return-Path: <stable+bounces-50179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA68A904672
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 23:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0276A1C22E1E
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 21:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54504153828;
	Tue, 11 Jun 2024 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dO50FHMy"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0BB3A8E4;
	Tue, 11 Jun 2024 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142915; cv=none; b=CV1IMhCgSAlJzn8N28+WT2Snv8sTGYgRVGHaXYMV1668IBhP/lqJJ1WiXj1boa1NoCQjygSeEZbNObwKiEztIb33TgcsiKKbM7opuO/weNn+KASPeWI7Lszc5kuM+PS1qmuJZkhTeKd5OwZK730DWD25fTHDb22xGqeUT0+XeYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142915; c=relaxed/simple;
	bh=TZk/B+Ox0N/GvpZ4dnBEu5GUQuXrO/D/UOTlsflWZkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AClAtiKdWWLmb7xvF9A4dLGlfg5WOvKZTFBaO8PAlkr9ycUW/vGOQbLcCt1QyR+nOQfbdPxquPihcLhkfeeQT/voYXzkZAOZ1vNo6AbXRLIrMNVpY6GsIayUFuCYHy3jYZ+aDIRb4xtf2/3mabYc8LVzo831hBvre4ozi/RqqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dO50FHMy; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718142913; x=1749678913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MPNuboNLzkPHklEZo6KpyfzpLs5e/J3FmAbgdqKG60I=;
  b=dO50FHMySHXt2tjBtk72KhEpfmXW5zk75ucQgGHatRa2492VPJG8reho
   lPXIpBKw06oKm9ws46fLkNZHhPft4aTCBUAHf5cL64W0en4Weod3r7/I6
   FHMAQqK7+b+5bbe8T/uK5rS03qnrzSON1bTCfLt6BU4XVwnr2RKJK01x/
   k=;
X-IronPort-AV: E=Sophos;i="6.08,231,1712620800"; 
   d="scan'208";a="412816594"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 21:55:10 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:36657]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.14:2525] with esmtp (Farcaster)
 id b91b42e6-0532-49ed-8263-5b55b9dfc8dc; Tue, 11 Jun 2024 21:55:09 +0000 (UTC)
X-Farcaster-Flow-ID: b91b42e6-0532-49ed-8263-5b55b9dfc8dc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 21:55:08 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 21:55:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ignat@cloudflare.com>
CC: <davem@davemloft.net>, <dsa@cumulusnetworks.com>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kernel-team@cloudflare.com>, <kraig@google.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <stable@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH] net: do not leave dangling sk pointer in inet_create()/inet6_create()
Date: Tue, 11 Jun 2024 14:54:57 -0700
Message-ID: <20240611215457.30251-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240611184716.72113-1-ignat@cloudflare.com>
References: <20240611184716.72113-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 11 Jun 2024 19:47:16 +0100
> It is possible to trigger a use-after-free by:
>   * attaching an fentry probe to __sock_release() and the probe calling the
>     bpf_get_socket_cookie() helper
>   * running traceroute -I 1.1.1.1 on a freshly booted VM
> 
> A KASAN enabled kernel will log something like below (decoded):
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
> [ 78.329366][ T299] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
> [ 78.329366][ T299] __sys_socket (net/socket.c:1660 net/socket.c:1644 net/socket.c:1706)
> [ 78.329366][ T299] ? __pfx___sys_socket (net/socket.c:1702)
> [ 78.329366][ T299] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
> [ 78.329366][ T299] ? up_read (./arch/x86/include/asm/atomic64_64.h:79 ./include/linux/atomic/atomic-arch-fallback.h:2749 ./include/linux/atomic/atomic-long.h:184 ./include/linux/atomic/atomic-instrumented.h:3317 kernel/locking/rwsem.c:1347 kernel/locking/rwsem.c:1622)
> [ 78.329366][ T299] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
> [ 78.329366][ T299] ? do_user_addr_fault (arch/x86/mm/fault.c:1419)
> [ 78.329366][ T299] __x64_sys_socket (net/socket.c:1718)
> [ 78.329366][ T299] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
> [ 78.329366][ T299] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> [ 78.329366][ T299] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> [   78.329366][  T299] RIP: 0033:0x7f4022818ca7
> [ 78.329366][ T299] Code: 73 01 c3 48 8b 0d 59 71 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 29 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 29 71 0c 00 f7 d8 64 89 01 48
> All code
> ========
>    0:	73 01                	jae    0x3
>    2:	c3                   	ret
>    3:	48 8b 0d 59 71 0c 00 	mov    0xc7159(%rip),%rcx        # 0xc7163
>    a:	f7 d8                	neg    %eax
>    c:	64 89 01             	mov    %eax,%fs:(%rcx)
>    f:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
>   13:	c3                   	ret
>   14:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
>   1b:	00 00 00
>   1e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>   23:	b8 29 00 00 00       	mov    $0x29,%eax
>   28:	0f 05                	syscall
>   2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
>   30:	73 01                	jae    0x33
>   32:	c3                   	ret
>   33:	48 8b 0d 29 71 0c 00 	mov    0xc7129(%rip),%rcx        # 0xc7163
>   3a:	f7 d8                	neg    %eax
>   3c:	64 89 01             	mov    %eax,%fs:(%rcx)
>   3f:	48                   	rex.W
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
>    6:	73 01                	jae    0x9
>    8:	c3                   	ret
>    9:	48 8b 0d 29 71 0c 00 	mov    0xc7129(%rip),%rcx        # 0xc7139
>   10:	f7 d8                	neg    %eax
>   12:	64 89 01             	mov    %eax,%fs:(%rcx)
>   15:	48                   	rex.W
> [   78.329366][  T299] RSP: 002b:00007ffd57e63db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
> [   78.329366][  T299] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f4022818ca7
> [   78.329366][  T299] RDX: 0000000000000001 RSI: 0000000000000002 RDI: 0000000000000002
> [   78.329366][  T299] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000564be3dc8ec0
> [   78.329366][  T299] R10: 0c41e8ba3f6107df R11: 0000000000000246 R12: 0000564bbab801e0
> [   78.329366][  T299] R13: 0000000000000000 R14: 0000564bbab7db18 R15: 00007f4022934020
> [   78.329366][  T299]  </TASK>
> [   78.329366][  T299]
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
> [   78.329366][  T299]
> [   78.329366][  T299] The buggy address belongs to the object at ffff888007110d80
> [   78.329366][  T299]  which belongs to the cache PING of size 976
> [   78.329366][  T299] The buggy address is located 88 bytes inside of
> [   78.329366][  T299]  freed 976-byte region [ffff888007110d80, ffff888007111150)
> [   78.329366][  T299]
> [   78.329366][  T299] The buggy address belongs to the physical page:
> [   78.329366][  T299] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7110
> [   78.329366][  T299] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [   78.329366][  T299] flags: 0x1ffff800000040(head|node=0|zone=1|lastcpupid=0x1ffff)
> [   78.329366][  T299] page_type: 0xffffefff(slab)
> [   78.329366][  T299] raw: 001ffff800000040 ffff888002f328c0 dead000000000122 0000000000000000
> [   78.329366][  T299] raw: 0000000000000000 00000000801c001c 00000001ffffefff 0000000000000000
> [   78.329366][  T299] head: 001ffff800000040 ffff888002f328c0 dead000000000122 0000000000000000
> [   78.329366][  T299] head: 0000000000000000 00000000801c001c 00000001ffffefff 0000000000000000
> [   78.329366][  T299] head: 001ffff800000003 ffffea00001c4401 ffffffffffffffff 0000000000000000
> [   78.329366][  T299] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> [   78.329366][  T299] page dumped because: kasan: bad access detected
> [   78.329366][  T299]
> [   78.329366][  T299] Memory state around the buggy address:
> [   78.329366][  T299]  ffff888007110c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   78.329366][  T299]  ffff888007110d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   78.329366][  T299] >ffff888007110d80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   78.329366][  T299]                                                     ^
> [   78.329366][  T299]  ffff888007110e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   78.329366][  T299]  ffff888007110e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   78.329366][  T299] ==================================================================
> [   78.366431][  T299] Disabling lock debugging due to kernel taint
> 
> Fix this by ensuring the error path of inet_create()/inet6_create do not leave
> a dangling sk pointer after sk was released.
> 
> Fixes: 086c653f5862 ("sock: struct proto hash function may error")

I think this tag is wrong as bpf_get_socket_cookie() does not exist at
that time.


> Fixes: 610236587600 ("bpf: Add new cgroup attach type to enable sock modifications")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---
>  net/ipv4/af_inet.c  | 3 +++
>  net/ipv6/af_inet6.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index b24d74616637..db53701db29e 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -378,6 +378,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
>  		err = sk->sk_prot->hash(sk);
>  		if (err) {
>  			sk_common_release(sk);
> +			sock->sk = NULL;
>  			goto out;
>  		}
>  	}

You can add a new label and call sk_common_release() and set
NULL to sock->sk there, then reuse it for other two places.

Same for IPv6.

And curious if bpf_get_socket_cookie() can be called any socket
family to trigger the splat.  e.g. ieee802154_create() seems to
have the same bug.

If so, how about clearing sock->sk in sk_common_release() ?

---8<---
diff --git a/net/core/sock.c b/net/core/sock.c
index 8629f9aecf91..bbc94954d9bf 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3754,6 +3754,9 @@ void sk_common_release(struct sock *sk)
 	 * until the last reference will be released.
 	 */
 
+	if (sk->sk_socket)
+		sk->sk_socket->sk = NULL;
+
 	sock_orphan(sk);
 
 	xfrm_sk_free_policy(sk);
---8<---

