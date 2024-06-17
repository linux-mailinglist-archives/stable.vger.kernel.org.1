Return-Path: <stable+bounces-52599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7546990BB9C
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 21:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA140B231C3
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 19:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4792918F2CA;
	Mon, 17 Jun 2024 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MPUPtlA7"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D99188CAE
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654385; cv=none; b=mXqygyBl9en3TDris7qSUd0F+aKcdypoL07aClqJ+dvh4PY47RxCjX65vsmzfxZ1ClMbmXbkR1/VwZ9/a5ShEY1Z6JZjHSkgTgYRuXIy9qNTswAAQSDlqtmWGY61MWGGyifxQBBtNv6jhzUOJK4GLOk5ssHb7bs9aQGYiBVOnc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654385; c=relaxed/simple;
	bh=08Im5tTtgDtaXbg/OAZrWCIVoI5T9qmWGX+gu7QrY6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XGh4IKnEuPMVP6HZRpxYxZgse+1KVUJgymEImIk/UstKYOyBQKBhlbNIys6kwlYpWVbL8GqYCPfELg0vtR7Zqj91q/fInQUcdTqZQZ9LGLHU/AKLBkpp+JV/EKPHjvGtgXbvH2MB8MKGS1k0cIGwwOvGX8R42ZT6OZWNkkblIWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MPUPtlA7; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso63765831fa.0
        for <stable@vger.kernel.org>; Mon, 17 Jun 2024 12:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718654381; x=1719259181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EyLxAVnNatw43iRM4OrcutPI3eZaU5xCt0a5Bh/nUZ8=;
        b=MPUPtlA744BKBCUnEGeOw+Sok3XcRGyhgqo5gezsnIWarE8eYcNTWJPr5L7YvN8NXl
         G4tqe0tuVAXBR2wW86XL0lm8bttsNc9WcxYoBXsAsvxS4uLcxy1edL7E3bawgrFFhrSn
         43jSHpqnfOJApdcydmahI1Hm/Y6YY4jh72rb3CQsb5PkTQnBU9p49E03+IvtGlIT7Qcn
         RPkaMQ4+df15eio/0CBKtnpw0JiB7VrMRGJkAtM5wYKXjyJsXQWf//A0FcubNT6iIVQP
         gCJp7vzbze0Ro0iR6xaqC0Eka9S9/YuSCDLqwX/xOvQXszygwR+O/vYi+DUBZ1Hd6k9m
         bQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718654381; x=1719259181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyLxAVnNatw43iRM4OrcutPI3eZaU5xCt0a5Bh/nUZ8=;
        b=daSszMs3hywr54bL9qowNuMZn2HlR+zO4x7KflGSHEryjb2yx+BA4FY1zHh54XrhTN
         GaEjJx4uTHe6/nfB06i8W3OX6goMbk2LSRO+D8EqQy4C5Jv6mf2XCu/6RUJgiZC33ivF
         ZAu/AjU0AKKo2Clqf1eMEbplY8fc9N/9+xW4wadjIvtgugpzc4Iy4bC6aXaMpcgjj/H4
         cVyg2lzvFg8EnHtzvML/SDJP5gzwrOxIsCImO4385+C+3DFthGYDOCPVFcbmBWfKjnJ8
         pKxryYnSenVjqIi0YCp6c3sVovnrDW4nu95ANWawWQCLM7lt4q/dfTB4yHuapJO1SxpM
         zhSw==
X-Forwarded-Encrypted: i=1; AJvYcCVP7hX/VGRNjnM8fIvl092dTPKoMcl8FM00f6eno3j/m6pUEjVqIjGWJ0mocf2TJqBxaZzeDKURDSdQ94yReUybvmXTDp6j
X-Gm-Message-State: AOJu0Yx957IwMg1aCRW62pm9uD2uogThTFLLc0J8X4m4/dlZ6BF+V9Pp
	3C5aKmWDFYprOqxgW9ec9jUisw1a1qWbFSSmny1iQhZFBoPhE1ZP0FIkKsrC01V3CgOUXbj/iaD
	rs3I=
X-Google-Smtp-Source: AGHT+IH4U5vzLeiz8hkqcYJKHqjJ00u0IYrLAWlmG3iRs3wJv+s+wvbGOotZo0aQPKNGhmClr2ICTA==
X-Received: by 2002:a2e:300f:0:b0:2eb:d87f:7d71 with SMTP id 38308e7fff4ca-2ec0e5b5f69mr73029701fa.8.1718654381332;
        Mon, 17 Jun 2024 12:59:41 -0700 (PDT)
Received: from localhost.localdomain ([104.28.231.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e73e8sm205545885e9.43.2024.06.17.12.59.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Jun 2024 12:59:40 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Florent Revest <revest@chromium.org>,
	kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: do not leave a dangling sk pointer, when socket creation fails
Date: Mon, 17 Jun 2024 20:59:34 +0100
Message-Id: <20240617195934.64810-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A KASAN enabled kernel will log something like below (decoded and stripped):
[   78.328507][  T299] ==================================================================
[ 78.329018][ T299] BUG: KASAN: slab-use-after-free in __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
[   78.329366][  T299] Read of size 8 at addr ffff888007110dd8 by task traceroute/299
[   78.329366][  T299]
[   78.329366][  T299] CPU: 2 PID: 299 Comm: traceroute Tainted: G            E      6.10.0-rc2+ #2
[   78.329366][  T299] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   78.329366][  T299] Call Trace:
[   78.329366][  T299]  <TASK>
[ 78.329366][ T299] dump_stack_lvl (lib/dump_stack.c:117 (discriminator 1))
[ 78.329366][ T299] print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
[ 78.329366][ T299] ? __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
[ 78.329366][ T299] kasan_report (mm/kasan/report.c:603)
[ 78.329366][ T299] ? __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
[ 78.329366][ T299] kasan_check_range (mm/kasan/generic.c:183 mm/kasan/generic.c:189)
[ 78.329366][ T299] __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
[ 78.329366][ T299] bpf_get_socket_ptr_cookie (./arch/x86/include/asm/preempt.h:94 ./include/linux/sock_diag.h:42 net/core/filter.c:5094 net/core/filter.c:5092)
[ 78.329366][ T299] bpf_prog_875642cf11f1d139___sock_release+0x6e/0x8e
[ 78.329366][ T299] bpf_trampoline_6442506592+0x47/0xaf
[ 78.329366][ T299] __sock_release (net/socket.c:652)
[ 78.329366][ T299] __sock_create (net/socket.c:1601)
...
[   78.329366][  T299] Allocated by task 299 on cpu 2 at 78.328492s:
[ 78.329366][ T299] kasan_save_stack (mm/kasan/common.c:48)
[ 78.329366][ T299] kasan_save_track (mm/kasan/common.c:68)
[ 78.329366][ T299] __kasan_slab_alloc (mm/kasan/common.c:312 mm/kasan/common.c:338)
[ 78.329366][ T299] kmem_cache_alloc_noprof (mm/slub.c:3941 mm/slub.c:4000 mm/slub.c:4007)
[ 78.329366][ T299] sk_prot_alloc (net/core/sock.c:2075)
[ 78.329366][ T299] sk_alloc (net/core/sock.c:2134)
[ 78.329366][ T299] inet_create (net/ipv4/af_inet.c:327 net/ipv4/af_inet.c:252)
[ 78.329366][ T299] __sock_create (net/socket.c:1572)
[ 78.329366][ T299] __sys_socket (net/socket.c:1660 net/socket.c:1644 net/socket.c:1706)
[ 78.329366][ T299] __x64_sys_socket (net/socket.c:1718)
[ 78.329366][ T299] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
[ 78.329366][ T299] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   78.329366][  T299]
[   78.329366][  T299] Freed by task 299 on cpu 2 at 78.328502s:
[ 78.329366][ T299] kasan_save_stack (mm/kasan/common.c:48)
[ 78.329366][ T299] kasan_save_track (mm/kasan/common.c:68)
[ 78.329366][ T299] kasan_save_free_info (mm/kasan/generic.c:582)
[ 78.329366][ T299] poison_slab_object (mm/kasan/common.c:242)
[ 78.329366][ T299] __kasan_slab_free (mm/kasan/common.c:256)
[ 78.329366][ T299] kmem_cache_free (mm/slub.c:4437 mm/slub.c:4511)
[ 78.329366][ T299] __sk_destruct (net/core/sock.c:2117 net/core/sock.c:2208)
[ 78.329366][ T299] inet_create (net/ipv4/af_inet.c:397 net/ipv4/af_inet.c:252)
[ 78.329366][ T299] __sock_create (net/socket.c:1572)
[ 78.329366][ T299] __sys_socket (net/socket.c:1660 net/socket.c:1644 net/socket.c:1706)
[ 78.329366][ T299] __x64_sys_socket (net/socket.c:1718)
[ 78.329366][ T299] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
[ 78.329366][ T299] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Fix this by clearing the struct socket reference in sk_common_release() to cover
all protocol families create functions.

Fixes: c5dbb89fc2ac ("bpf: Expose bpf_get_socket_cookie to tracing programs")
Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/20240613194047.36478-1-kuniyu@amazon.com/T/
---
Changes in v2:
  * moved the NULL-ing of the socket reference to sk_common_release() (as
    suggested by Kuniyuki Iwashima)
  * trimmed down the KASAN report in the commit message to show only relevant
    info

 net/core/sock.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 8629f9aecf91..575af557c46b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3742,6 +3742,17 @@ void sk_common_release(struct sock *sk)
 
 	sk->sk_prot->unhash(sk);
 
+	/*
+	 * struct net_proto_family create functions like inet_create() or
+	 * inet6_create() have an error path, which call this function. This sk
+	 * may have already been associated with a struct socket, so ensure to
+	 * clear this reference not to leave a dangling pointer in the
+	 * struct socket instance.
+	 */
+
+	if (sk->sk_socket)
+		sk->sk_socket->sk = NULL;
+
 	/*
 	 * In this point socket cannot receive new packets, but it is possible
 	 * that some packets are in flight because some CPU runs receiver and
-- 
2.39.2


