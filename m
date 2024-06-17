Return-Path: <stable+bounces-52608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ECA90BC83
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 23:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415501C23B9A
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 21:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95B61991A4;
	Mon, 17 Jun 2024 21:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CXcw69Bt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D41279CE
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 21:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658134; cv=none; b=OUv2PjlJUeYYW9pQGi2s4Ozqk7ihJkcEtU6StMM3iFPrJ0bUvuLPmvNwzwfrS7QhC2YTml4s+DQUj+LlqFr1+GWkBkkUq/HhI8xtKfdk3J/AwRiRF0SIZCHVCO94qaT9hX5rNZBviAp/JBQvDNGv27kdAT4RfSbKwsgQnjmpXHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658134; c=relaxed/simple;
	bh=B1gm5DdSgfQg0HYANDyrQqb7o+BBNjtrye8Q7TCAO24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=roqLQ4fVZCj0H35nLJUwftB7oUsNnAJdpeNAVXhBVvSqBTnLaaM1/RQZZqbjz1nILXJqrRHDS/gQXbRTdN1pBzvrhR1sw5kHV1613OnNP37VW9kjn+xs7a5lHJS1p2s+smL/25r5XQRv3Rym3JTIr7jW5jogH3ftjAzgf/xX+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CXcw69Bt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421cd1e5f93so34123715e9.0
        for <stable@vger.kernel.org>; Mon, 17 Jun 2024 14:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718658130; x=1719262930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oPx3c/l3RFVX5AVFhiQ8z+HSbtAyDh/1YQdyx0NkN2c=;
        b=CXcw69Bth/r9P4uVi64ZM1nz53o12g2Ezky2/5rbcrWQBsrViVwpWgscwEJ6S3k7/+
         1pVGLiE2xTsx/J7cdsPKFGX83u75+MRzW1zLplRabd4IcdMd3k7M4k3JUmWUlIx3IItA
         QohzS9xuJep1Bi46qLJxOO5Lllc/SjaPDTJRzS/bzsMMx3vim6i5Rqdx/R3tfSUl8qgL
         iRQssf2C+fVQBZJwEunfalPMysK4r7LXFOP8Xx5GMrwnIGibXUevU2lYSxIfeulbdL7x
         nWhGL5aL3eDWvT5wCJQuzO7R/UNG02R3cu0sSDBpmnqen2UFYXGugbX0H8Dit1STAzEp
         lScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718658130; x=1719262930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPx3c/l3RFVX5AVFhiQ8z+HSbtAyDh/1YQdyx0NkN2c=;
        b=BEfj/YAB+35CBs1Aib281x83ZAyQ5GXtyYgSyNttTykwfkrLTWkt4Gcwdf6miZfDZj
         6E3YzPcZ14Z21+R23MpLpW2+kjTvGsCa2kpgkdMin9vBsylHvnpGTFrcLl7DKYsE7UNp
         af4+DFBLdEWtYZ4+Uv2KrZrOF6uK9fwvaDxwHFXGJoLqG3BLmx4DAsMpojLveJLHyouZ
         +RcT7OSnHXjesIh3m0Iu+epLMpNEGqY2wU+S/UeFO5LrUUA55aJLdh67Q/Ivwy9DltgD
         u+VKFrkrAhozudDJxBrUAwr4HJsUu7pqUGbc7ia+CU8NmuI8JNq8XBcwnJTkvZOfN2uJ
         Zw8g==
X-Forwarded-Encrypted: i=1; AJvYcCWNiwQkzHwevEXBv5aFoa4EQGtsiRxYug9TSgTbOpoi1iSsPvHnKo9mOhYm/8kThiCYDoa/6OwasxHILgErNQxIxQU2gSme
X-Gm-Message-State: AOJu0Yxxtd8mIIlx8jsU/qE0TVLyJtWmsi3XPhXdrnkbZDN6Skby25fS
	T9ofQ495GmH+izytuNUY7lEa7Q57zyxr31JWh02P0OWdvV2oiL2IVD+S/n9v42I=
X-Google-Smtp-Source: AGHT+IGcxuXyC2SdGVAFBszcVrgGgRvP+9b1oJO0U/ENeuHdki+g5WhfdCkuP0boUryoDWn93EsGNA==
X-Received: by 2002:a05:600c:138b:b0:421:7c20:a263 with SMTP id 5b1f17b1804b1-42304824084mr97239765e9.11.1718658130377;
        Mon, 17 Jun 2024 14:02:10 -0700 (PDT)
Received: from localhost.localdomain ([104.28.231.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de618sm207988465e9.37.2024.06.17.14.02.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Jun 2024 14:02:09 -0700 (PDT)
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
Subject: [PATCH net v3] net: do not leave a dangling sk pointer, when socket creation fails
Date: Mon, 17 Jun 2024 22:02:05 +0100
Message-Id: <20240617210205.67311-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
Changes in v3:
  * re-added KASAN repro steps to the commit message (somehow stripped in v2)
  * stripped timestamps and thread id from the KASAN splat
  * removed comment from the code (commit message should be enough)

Changes in v2:
  * moved the NULL-ing of the socket reference to sk_common_release() (as
    suggested by Kuniyuki Iwashima)
  * trimmed down the KASAN report in the commit message to show only relevant
    info

 net/core/sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 8629f9aecf91..100e975073ca 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3742,6 +3742,9 @@ void sk_common_release(struct sock *sk)
 
 	sk->sk_prot->unhash(sk);
 
+	if (sk->sk_socket)
+		sk->sk_socket->sk = NULL;
+
 	/*
 	 * In this point socket cannot receive new packets, but it is possible
 	 * that some packets are in flight because some CPU runs receiver and
-- 
2.39.2


