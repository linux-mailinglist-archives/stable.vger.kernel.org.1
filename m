Return-Path: <stable+bounces-119513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A57A441AB
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 15:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426903BB9F8
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 13:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FF026E651;
	Tue, 25 Feb 2025 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDCVxhBS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED39126E153
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491785; cv=none; b=tFNI4o5XjrH2Dt61nLt8ET/SqeZ85wkxO63QAG82uN/goAjiKhux9VfDtdlDvvp+Gn+vctq79i7oaEWj5QIG07P2M2XO6RcEEN57lNV28/ctU2QzH+31IQTjTAGlQBCx5IUbJyjgbLag3KFcQBQtEWKMtTbMJa3nuDXRsN04eKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491785; c=relaxed/simple;
	bh=+e6wIKFE9qh1fgrAZWD6kkCgVtOpvQ3AQoYdWo6IllI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hrD+mdkX5u1f0i37oUezMdKCprd8C17BTV0c986LCwi8/SuH1ckWSk9AQC3FSwzJud6/yY9+6crbzI9+/9ZNuxDhTo0Ny5KVH3y3k8UAClu8gFQgOdAMGHDXZDaUYjclYlw3SrznUtZmOYy+WS1STUKO8dT7syDEMke7TDlFnQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDCVxhBS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740491782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfaFJc1h7b8kfn/CK4Z1hSL8B+dBJghps2lHgeAsVOc=;
	b=GDCVxhBSeWlB6bnbKOZr+VrNlC5rLKTLZ/JOqSU9gDPgmupFzrKx+5MLcEsywY44dK40LQ
	9bUd4nH6LrvaEVjV4bh6c5nl7O1RrtcI6rcnCsBJOh4TklgJ4S5F/5leYrdtnPEi9xWy0G
	k6rHwHwGg6l27Dfah3rUYFggsuFtkn8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-N-Qsag9jN9e1bWlGi4uxtg-1; Tue, 25 Feb 2025 08:56:21 -0500
X-MC-Unique: N-Qsag9jN9e1bWlGi4uxtg-1
X-Mimecast-MFC-AGG-ID: N-Qsag9jN9e1bWlGi4uxtg_1740491780
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f4e47d0b2so2588844f8f.2
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 05:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491780; x=1741096580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfaFJc1h7b8kfn/CK4Z1hSL8B+dBJghps2lHgeAsVOc=;
        b=QmqX5GiRHO07olaFKEZrrcFVJimUK8zF4VYKTftQOGoidCCLxNyMrdoHimCiLWPzU8
         Ju6QtMGOoGc/3gEQpzr+YHsxfcRCz7eG9mwpeAImoRvnDnB1UkE9Wz6dRmhRlfU48N9f
         ONe2ngW8ix18ip39qj7sq0lma6kCKnaMA2YeRy//wyPlzdnNc4H4f9wYtc/9gXzh1btj
         XLaudW4qeMdBqf/Hnb2E6gO3tebRD9jScmsqu7+f5kqARwg0D2kQlPbaiiiwf8KeEgHD
         XH+OotiN9M/HhEq+D1K6LDrMHQ0mcD8YZwO9+4LulC7bc5kkQkLoetoNbKXN7H1VprRG
         aSQA==
X-Forwarded-Encrypted: i=1; AJvYcCUHWu/12urB46jJ3h5G8FIBBb42NFuL1rA2YCmd/rtApkVXTZhbhhmUc0WF8QnIuxqI3YCNCMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3YUMR9DMuJfugMhkJBqbHBxVAyKv6b7JS7c7w1RLtpLinye8a
	lhgxMOcTKMgwJjAW5Y0VZGAAtpp7sf2qu+fgcUUMnYqgfQjscJl+L3PSQGh2aByfAZu77eqpVUx
	sW/9f3YTcD4y8koC+p2/yc4GtyIDieXw5EQdaseoVOMawIXOt7bc5fHtegQIFrPBA
X-Gm-Gg: ASbGncsn+ItEBjw1W36TM6a0KIJauIRvAGxVzOp2nrXg2IytvWSmP7FcKVPkWFOzux1
	BLaecs/mF1ZIpSEsj6vONGOM+LVdH8N2w1yTw1A5gyBQUQN1w9AR4VTnEBg2Pm+PT+noj4v8+9D
	t0Sb3KTIWL/zo5ODnj3WpozbCeCMlz/qpNJp4l6HYtxZsJJMMQ7wtcVTpxKM9aZVk3RzSyfDqm7
	VOdkF/N1lU2eIprRc7W5zPPPhkNzDw9O62zEH4HR8GR+RZEFmruLjgK5jthA2vpi7xSjZNmHlFK
	dstBCbQ/I5jNS53Mjp32owHkRRfhC7Kcl3utor5lsFp2fkz38BFbOvC5Ng5H8e+SvmoanU0=
X-Received: by 2002:a05:6000:2c6:b0:38f:4fa6:e641 with SMTP id ffacd0b85a97d-38f6f0b17f8mr14974158f8f.43.1740491780038;
        Tue, 25 Feb 2025 05:56:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzYpCGQmuOkoM5zQstYQ3q3aZJ2lDv658vEpSktr3q2jv31ztQD60iLgmR01b9j5zoLwUQWw==
X-Received: by 2002:a05:6000:2c6:b0:38f:4fa6:e641 with SMTP id ffacd0b85a97d-38f6f0b17f8mr14974136f8f.43.1740491779652;
        Tue, 25 Feb 2025 05:56:19 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86cd10sm2424181f8f.37.2025.02.25.05.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:56:19 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 25 Feb 2025 14:56:14 +0100
Subject: [PATCH PATCH 6.1.y 2/3] vsock: Keep the binding until socket
 destruction
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-backport_fix-v1-2-71243c63da05@redhat.com>
References: <20250225-backport_fix-v1-0-71243c63da05@redhat.com>
In-Reply-To: <20250225-backport_fix-v1-0-71243c63da05@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>, 
 stable@vger.kernel.org
Cc: Luigi Leonardi <leonardi@redhat.com>, Jakub Kicinski <kuba@kernel.org>
X-Mailer: b4 0.14.2

From: Michal Luczaj <mhal@rbox.co>

commit fcdd2242c0231032fc84e1404315c245ae56322a upstream.

Preserve sockets bindings; this includes both resulting from an explicit
bind() and those implicitly bound through autobind during connect().

Prevents socket unbinding during a transport reassignment, which fixes a
use-after-free:

    1. vsock_create() (refcnt=1) calls vsock_insert_unbound() (refcnt=2)
    2. transport->release() calls vsock_remove_bound() without checking if
       sk was bound and moved to bound list (refcnt=1)
    3. vsock_bind() assumes sk is in unbound list and before
       __vsock_insert_bound(vsock_bound_sockets()) calls
       __vsock_remove_bound() which does:
           list_del_init(&vsk->bound_table); // nop
           sock_put(&vsk->sk);               // refcnt=0

BUG: KASAN: slab-use-after-free in __vsock_bind+0x62e/0x730
Read of size 4 at addr ffff88816b46a74c by task a.out/2057
 dump_stack_lvl+0x68/0x90
 print_report+0x174/0x4f6
 kasan_report+0xb9/0x190
 __vsock_bind+0x62e/0x730
 vsock_bind+0x97/0xe0
 __sys_bind+0x154/0x1f0
 __x64_sys_bind+0x6e/0xb0
 do_syscall_64+0x93/0x1b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Allocated by task 2057:
 kasan_save_stack+0x1e/0x40
 kasan_save_track+0x10/0x30
 __kasan_slab_alloc+0x85/0x90
 kmem_cache_alloc_noprof+0x131/0x450
 sk_prot_alloc+0x5b/0x220
 sk_alloc+0x2c/0x870
 __vsock_create.constprop.0+0x2e/0xb60
 vsock_create+0xe4/0x420
 __sock_create+0x241/0x650
 __sys_socket+0xf2/0x1a0
 __x64_sys_socket+0x6e/0xb0
 do_syscall_64+0x93/0x1b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 2057:
 kasan_save_stack+0x1e/0x40
 kasan_save_track+0x10/0x30
 kasan_save_free_info+0x37/0x60
 __kasan_slab_free+0x4b/0x70
 kmem_cache_free+0x1a1/0x590
 __sk_destruct+0x388/0x5a0
 __vsock_bind+0x5e1/0x730
 vsock_bind+0x97/0xe0
 __sys_bind+0x154/0x1f0
 __x64_sys_bind+0x6e/0xb0
 do_syscall_64+0x93/0x1b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 7 PID: 2057 at lib/refcount.c:25 refcount_warn_saturate+0xce/0x150
RIP: 0010:refcount_warn_saturate+0xce/0x150
 __vsock_bind+0x66d/0x730
 vsock_bind+0x97/0xe0
 __sys_bind+0x154/0x1f0
 __x64_sys_bind+0x6e/0xb0
 do_syscall_64+0x93/0x1b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

refcount_t: underflow; use-after-free.
WARNING: CPU: 7 PID: 2057 at lib/refcount.c:28 refcount_warn_saturate+0xee/0x150
RIP: 0010:refcount_warn_saturate+0xee/0x150
 vsock_remove_bound+0x187/0x1e0
 __vsock_release+0x383/0x4a0
 vsock_release+0x90/0x120
 __sock_release+0xa3/0x250
 sock_close+0x14/0x20
 __fput+0x359/0xa80
 task_work_run+0x107/0x1d0
 do_exit+0x847/0x2560
 do_group_exit+0xb8/0x250
 __x64_sys_exit_group+0x3a/0x50
 x64_sys_call+0xfec/0x14f0
 do_syscall_64+0x93/0x1b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Link: https://patch.msgid.link/20250128-vsock-transport-vs-autobind-v3-1-1cf57065b770@rbox.co
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 32bc7fcb31165f9500e44b9629549f0e24305ca9..b43aabf905f6ea24e4fb0ebc211ccff954ea0b13 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -333,7 +333,10 @@ EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
 
 void vsock_remove_sock(struct vsock_sock *vsk)
 {
-	vsock_remove_bound(vsk);
+	/* Transport reassignment must not remove the binding. */
+	if (sock_flag(sk_vsock(vsk), SOCK_DEAD))
+		vsock_remove_bound(vsk);
+
 	vsock_remove_connected(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_remove_sock);
@@ -818,12 +821,13 @@ static void __vsock_release(struct sock *sk, int level)
 	 */
 	lock_sock_nested(sk, level);
 
+	sock_orphan(sk);
+
 	if (vsk->transport)
 		vsk->transport->release(vsk);
 	else if (sock_type_connectible(sk->sk_type))
 		vsock_remove_sock(vsk);
 
-	sock_orphan(sk);
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
 	skb_queue_purge(&sk->sk_receive_queue);

-- 
2.48.1


