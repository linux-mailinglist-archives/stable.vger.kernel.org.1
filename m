Return-Path: <stable+bounces-50178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3269043F3
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 20:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E286B22079
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 18:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D688440856;
	Tue, 11 Jun 2024 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DQdPiYbB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59886101E2
	for <stable@vger.kernel.org>; Tue, 11 Jun 2024 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131671; cv=none; b=GhQZ+ughiNko7A9ehJ8/LvDt6fvPrHsBSgUnLLNJ0LoKHz3i8a/tAF5ZHgsYQR1dc8DE+WdSWcbeGbQhD8jDlVzdf1g9cKZj1fJGtkkZ2DKRCGKgCylCG6a0JZ9sqtZhwEsqvD3SZqVy9zvk0OKNc3tFUeUsuS//9WYuNn0GmMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131671; c=relaxed/simple;
	bh=8JcIoVSqsdFltRrabzGQLMzteEgVc04AKhzTNzWU6ms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ahp30rmP0HIC09KlpMTUrhfkAlNWjpxw6HRQav+ZXz+24DRhSFJRWOnAhumEbE50gP9ecC2EQmd6oB+XJmcJqW3MMIk0Rjna+sq6zokRlzi/h1SCWkElZDPGrJuO6Rv1xKBbkewbqSBXX0OvESfLyWLIiEXm5VWgMKX00BD3y/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DQdPiYbB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4210aa00c94so50642545e9.1
        for <stable@vger.kernel.org>; Tue, 11 Jun 2024 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718131667; x=1718736467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qS3p140RgzPlNtJAaXKtk5xoCv3F7llLb83MyA85290=;
        b=DQdPiYbBm25nDpeez1XtF5TfSiB0evnB1aad24k1I4BU4UrdugqDYeEDFp+6Nzh2Ra
         MhKfy8QYeo57qKN4OMWnfBWW8Fof09P5wOdkeY9JHbf7l0xabF7/yU6/GtpMBfOH0ae3
         8s4iQTABXYJK6Dn2ecvN8FHG456fbEMAeQuRLGVZCf4M+WcSMbaqTq+sRekNBSf9F5Yb
         5OgrTKUGkE+5Yt6dI2AGYL+GADoHA9IgZFoWNg5UDxS/AgpoF7egtneOrx952+Yc+NCb
         4WamxCuYzPJSi6E04fG6Kh1eaH53VbjJ0aELb1uOs0njOunbZHkmFZYNkIWNNthVNXV1
         x/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718131667; x=1718736467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qS3p140RgzPlNtJAaXKtk5xoCv3F7llLb83MyA85290=;
        b=LDRo0sdjMZir2ItoIJ/aSBin7n9PyLSIL3NjTkBmBhUj+slcB3Qda7HxKGsGO1EJPR
         OcdcdE042R2n9BwH0BKWU8KAqps7YqIraua7Toz8uZsrGYk8bC5dMKxvnInjyKpFFYem
         OiyoqyyEmks/5/ZLExnlOPT2MwyP/KM8RhtO/nyykzVypnrPpoGLqtUYrFil6L6ot2kf
         kDMSY3PnbXIfWTPjau11J0jy+wojTdQ+RRYrodGUP4jTNx26eKLgnUMYsUgCCbPpzOgk
         LmfoFkOCrAFXbYA24100wUxENAckFcS+ZHDFKymsLm5PGVDqtZWzev+K2ImeKWXzeu0y
         hatw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ8tjHoesAkJIdVI5tl7VnJynzKE080oE0PgrXeV0+8Cdpcr9Vrr6wheTW+npaqnZ/W0XEoLLqXFT93gehY2OFMxeWMxFg
X-Gm-Message-State: AOJu0Yyx2eTP7Vz+akRyVfdbLZzNjrgUc7hw/x3BBYiEnwxiCB8AVY5/
	hCKmo78Wpn2OaS/aKxQ2UHc8mMpkJrK4JHaWHs9OPz0KpA+xgAOi/vAq5EXBm3A=
X-Google-Smtp-Source: AGHT+IHJu3ca3aPJywuAJOmnIxneOlAKjhti/ISSwcLCsdjglt6Fd7fpc5Kaco5BMWuF2Dv0R+hDFQ==
X-Received: by 2002:a05:600c:1c93:b0:421:a575:99c9 with SMTP id 5b1f17b1804b1-421a5759c67mr57386785e9.20.1718131666624;
        Tue, 11 Jun 2024 11:47:46 -0700 (PDT)
Received: from localhost.localdomain ([104.28.224.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f22d980e6sm6779401f8f.4.2024.06.11.11.47.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Jun 2024 11:47:45 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Ahern <dsa@cumulusnetworks.com>,
	Craig Gallek <kraig@google.com>,
	kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: do not leave dangling sk pointer in inet_create()/inet6_create()
Date: Tue, 11 Jun 2024 19:47:16 +0100
Message-Id: <20240611184716.72113-1-ignat@cloudflare.com>
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

A KASAN enabled kernel will log something like below (decoded):
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
[ 78.329366][ T299] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[ 78.329366][ T299] __sys_socket (net/socket.c:1660 net/socket.c:1644 net/socket.c:1706)
[ 78.329366][ T299] ? __pfx___sys_socket (net/socket.c:1702)
[ 78.329366][ T299] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[ 78.329366][ T299] ? up_read (./arch/x86/include/asm/atomic64_64.h:79 ./include/linux/atomic/atomic-arch-fallback.h:2749 ./include/linux/atomic/atomic-long.h:184 ./include/linux/atomic/atomic-instrumented.h:3317 kernel/locking/rwsem.c:1347 kernel/locking/rwsem.c:1622)
[ 78.329366][ T299] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[ 78.329366][ T299] ? do_user_addr_fault (arch/x86/mm/fault.c:1419)
[ 78.329366][ T299] __x64_sys_socket (net/socket.c:1718)
[ 78.329366][ T299] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[ 78.329366][ T299] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
[ 78.329366][ T299] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   78.329366][  T299] RIP: 0033:0x7f4022818ca7
[ 78.329366][ T299] Code: 73 01 c3 48 8b 0d 59 71 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 29 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 29 71 0c 00 f7 d8 64 89 01 48
All code
========
   0:	73 01                	jae    0x3
   2:	c3                   	ret
   3:	48 8b 0d 59 71 0c 00 	mov    0xc7159(%rip),%rcx        # 0xc7163
   a:	f7 d8                	neg    %eax
   c:	64 89 01             	mov    %eax,%fs:(%rcx)
   f:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  13:	c3                   	ret
  14:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  1b:	00 00 00
  1e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  23:	b8 29 00 00 00       	mov    $0x29,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 29 71 0c 00 	mov    0xc7129(%rip),%rcx        # 0xc7163
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 29 71 0c 00 	mov    0xc7129(%rip),%rcx        # 0xc7139
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[   78.329366][  T299] RSP: 002b:00007ffd57e63db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
[   78.329366][  T299] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f4022818ca7
[   78.329366][  T299] RDX: 0000000000000001 RSI: 0000000000000002 RDI: 0000000000000002
[   78.329366][  T299] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000564be3dc8ec0
[   78.329366][  T299] R10: 0c41e8ba3f6107df R11: 0000000000000246 R12: 0000564bbab801e0
[   78.329366][  T299] R13: 0000000000000000 R14: 0000564bbab7db18 R15: 00007f4022934020
[   78.329366][  T299]  </TASK>
[   78.329366][  T299]
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
[   78.329366][  T299]
[   78.329366][  T299] The buggy address belongs to the object at ffff888007110d80
[   78.329366][  T299]  which belongs to the cache PING of size 976
[   78.329366][  T299] The buggy address is located 88 bytes inside of
[   78.329366][  T299]  freed 976-byte region [ffff888007110d80, ffff888007111150)
[   78.329366][  T299]
[   78.329366][  T299] The buggy address belongs to the physical page:
[   78.329366][  T299] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7110
[   78.329366][  T299] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   78.329366][  T299] flags: 0x1ffff800000040(head|node=0|zone=1|lastcpupid=0x1ffff)
[   78.329366][  T299] page_type: 0xffffefff(slab)
[   78.329366][  T299] raw: 001ffff800000040 ffff888002f328c0 dead000000000122 0000000000000000
[   78.329366][  T299] raw: 0000000000000000 00000000801c001c 00000001ffffefff 0000000000000000
[   78.329366][  T299] head: 001ffff800000040 ffff888002f328c0 dead000000000122 0000000000000000
[   78.329366][  T299] head: 0000000000000000 00000000801c001c 00000001ffffefff 0000000000000000
[   78.329366][  T299] head: 001ffff800000003 ffffea00001c4401 ffffffffffffffff 0000000000000000
[   78.329366][  T299] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
[   78.329366][  T299] page dumped because: kasan: bad access detected
[   78.329366][  T299]
[   78.329366][  T299] Memory state around the buggy address:
[   78.329366][  T299]  ffff888007110c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   78.329366][  T299]  ffff888007110d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   78.329366][  T299] >ffff888007110d80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   78.329366][  T299]                                                     ^
[   78.329366][  T299]  ffff888007110e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   78.329366][  T299]  ffff888007110e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   78.329366][  T299] ==================================================================
[   78.366431][  T299] Disabling lock debugging due to kernel taint

Fix this by ensuring the error path of inet_create()/inet6_create do not leave
a dangling sk pointer after sk was released.

Fixes: 086c653f5862 ("sock: struct proto hash function may error")
Fixes: 610236587600 ("bpf: Add new cgroup attach type to enable sock modifications")
Cc: stable@vger.kernel.org
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/ipv4/af_inet.c  | 3 +++
 net/ipv6/af_inet6.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index b24d74616637..db53701db29e 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -378,6 +378,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 		err = sk->sk_prot->hash(sk);
 		if (err) {
 			sk_common_release(sk);
+			sock->sk = NULL;
 			goto out;
 		}
 	}
@@ -386,6 +387,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 		err = sk->sk_prot->init(sk);
 		if (err) {
 			sk_common_release(sk);
+			sock->sk = NULL;
 			goto out;
 		}
 	}
@@ -394,6 +396,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 		err = BPF_CGROUP_RUN_PROG_INET_SOCK(sk);
 		if (err) {
 			sk_common_release(sk);
+			sock->sk = NULL;
 			goto out;
 		}
 	}
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 8041dc181bd4..6d5ebb2af928 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -254,6 +254,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 		err = sk->sk_prot->hash(sk);
 		if (err) {
 			sk_common_release(sk);
+			sock->sk = NULL;
 			goto out;
 		}
 	}
@@ -261,6 +262,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 		err = sk->sk_prot->init(sk);
 		if (err) {
 			sk_common_release(sk);
+			sock->sk = NULL;
 			goto out;
 		}
 	}
@@ -269,6 +271,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 		err = BPF_CGROUP_RUN_PROG_INET_SOCK(sk);
 		if (err) {
 			sk_common_release(sk);
+			sock->sk = NULL;
 			goto out;
 		}
 	}
-- 
2.39.2


