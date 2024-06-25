Return-Path: <stable+bounces-55343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017A091632F
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3831280FFD
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB55149E03;
	Tue, 25 Jun 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="whyip48t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948412EBEA;
	Tue, 25 Jun 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308624; cv=none; b=Ok39fODuA46Upj335x3ixxQAwNz0Bl/ZpzFHRwMgQY34J7ZbrrXON3KlT3o5YbOBQYbS01AYlH3Q7Nx9Q1O3XUyST6dF9kT5q03SYluo2alU1vHndsDJxNGm80x83Qdr15Q5DVnXymxztHo2/EMzCZJ2ig5jUdpogLAbCb1+9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308624; c=relaxed/simple;
	bh=G64Oy6nUlsBtFtD9NsOihC/AwKZeVsUg+yH5odiMpKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFG0xTkHFILm60/ncE1EdH40rq2KlQu2ZJCoWjtipayLykLIdaTfeWwlT+ZXg4kz5QpeZjSpAqPSuoQ6n1Zkc4isscxZHpOeZxFfaVxn439lJriFVhhBIDgXfU2t68giUIFb3akRhqEZXRDohbkBBk3vb1hOiSEJXVRnJSoFPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=whyip48t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11F6C32781;
	Tue, 25 Jun 2024 09:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308624;
	bh=G64Oy6nUlsBtFtD9NsOihC/AwKZeVsUg+yH5odiMpKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=whyip48tt7K6Lp1pIpUt33V+333IqWoiBkTNjvnN4gKzd74+VZAS017IBgxpBWlSM
	 9yxxlVkDoMFo2/vB2oSZuIr2o3C0yO1FX6ISdtGxFwPMM8/CvrVePPVITglU5SZSdV
	 hBFcaG41bXN/K9W5bB9eJr/GOE4eKEdQzczrJsik=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ignat Korchagin <ignat@cloudflare.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.9 184/250] net: do not leave a dangling sk pointer, when socket creation fails
Date: Tue, 25 Jun 2024 11:32:22 +0200
Message-ID: <20240625085555.113737904@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ignat Korchagin <ignat@cloudflare.com>

commit 6cd4a78d962bebbaf8beb7d2ead3f34120e3f7b2 upstream.

It is possible to trigger a use-after-free by:
  * attaching an fentry probe to __sock_release() and the probe calling the
    bpf_get_socket_cookie() helper
  * running traceroute -I 1.1.1.1 on a freshly booted VM

A KASAN enabled kernel will log something like below (decoded and stripped):
==================================================================
BUG: KASAN: slab-use-after-free in __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
Read of size 8 at addr ffff888007110dd8 by task traceroute/299

CPU: 2 PID: 299 Comm: traceroute Tainted: G            E      6.10.0-rc2+ #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
dump_stack_lvl (lib/dump_stack.c:117 (discriminator 1))
print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
? __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
kasan_report (mm/kasan/report.c:603)
? __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
kasan_check_range (mm/kasan/generic.c:183 mm/kasan/generic.c:189)
__sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
bpf_get_socket_ptr_cookie (./arch/x86/include/asm/preempt.h:94 ./include/linux/sock_diag.h:42 net/core/filter.c:5094 net/core/filter.c:5092)
bpf_prog_875642cf11f1d139___sock_release+0x6e/0x8e
bpf_trampoline_6442506592+0x47/0xaf
__sock_release (net/socket.c:652)
__sock_create (net/socket.c:1601)
...
Allocated by task 299 on cpu 2 at 78.328492s:
kasan_save_stack (mm/kasan/common.c:48)
kasan_save_track (mm/kasan/common.c:68)
__kasan_slab_alloc (mm/kasan/common.c:312 mm/kasan/common.c:338)
kmem_cache_alloc_noprof (mm/slub.c:3941 mm/slub.c:4000 mm/slub.c:4007)
sk_prot_alloc (net/core/sock.c:2075)
sk_alloc (net/core/sock.c:2134)
inet_create (net/ipv4/af_inet.c:327 net/ipv4/af_inet.c:252)
__sock_create (net/socket.c:1572)
__sys_socket (net/socket.c:1660 net/socket.c:1644 net/socket.c:1706)
__x64_sys_socket (net/socket.c:1718)
do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Freed by task 299 on cpu 2 at 78.328502s:
kasan_save_stack (mm/kasan/common.c:48)
kasan_save_track (mm/kasan/common.c:68)
kasan_save_free_info (mm/kasan/generic.c:582)
poison_slab_object (mm/kasan/common.c:242)
__kasan_slab_free (mm/kasan/common.c:256)
kmem_cache_free (mm/slub.c:4437 mm/slub.c:4511)
__sk_destruct (net/core/sock.c:2117 net/core/sock.c:2208)
inet_create (net/ipv4/af_inet.c:397 net/ipv4/af_inet.c:252)
__sock_create (net/socket.c:1572)
__sys_socket (net/socket.c:1660 net/socket.c:1644 net/socket.c:1706)
__x64_sys_socket (net/socket.c:1718)
do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Fix this by clearing the struct socket reference in sk_common_release() to cover
all protocol families create functions, which may already attached the
reference to the sk object with sock_init_data().

Fixes: c5dbb89fc2ac ("bpf: Expose bpf_get_socket_cookie to tracing programs")
Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/20240613194047.36478-1-kuniyu@amazon.com/T/
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
Link: https://lore.kernel.org/r/20240617210205.67311-1-ignat@cloudflare.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/sock.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3743,6 +3743,9 @@ void sk_common_release(struct sock *sk)
 
 	sk->sk_prot->unhash(sk);
 
+	if (sk->sk_socket)
+		sk->sk_socket->sk = NULL;
+
 	/*
 	 * In this point socket cannot receive new packets, but it is possible
 	 * that some packets are in flight because some CPU runs receiver and



