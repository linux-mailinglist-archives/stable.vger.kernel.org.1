Return-Path: <stable+bounces-119509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0ABA44173
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1D53BDBB1
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7885A26A0F1;
	Tue, 25 Feb 2025 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5towRUc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A326B08C
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491615; cv=none; b=clkqDDJf6lSWKhMlhmLfNIIRt6l1yNkdClYqoYZB06UlYm4IFZUzkD7mh+V6n94O6OfmYLYEeqUe/Rn3WJTjstpXZm4dlBaTp+iCcJrtWknvRa1R6FXA0qXtbkGJ0kEOrwdEEcf3wdv/p5oariL4yxyJpjAiCw9iLhlwJPI3tuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491615; c=relaxed/simple;
	bh=8zEi33RXfYP0HhWqJFTJ6Tlu12/ujgIsgVPx2Gh/YyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VjTgY1s9tSD78p2dnNiP+6C/782P3xUfWm8VAUVQRlNVFvMicCrLBlrOd1mMS6b4Pk6DkeEaOuy1x34IoKgvFu3lPgbOzzL5ZGCWwy16rZqTN4XyupT9y+94rrJCSMlE72UrPTfBw79Et4jtIzVWSaxYK/3gmsS98DlTjHB9uKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5towRUc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740491611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7vU3VhhoMgC9nQunbGAAKfjutxoGbUF5vj7yk2CWAI=;
	b=O5towRUcf0cgmMZea7yEHTKSksdTFoe0t6cnGKSy+AMf04X0SRVQT9KVRfLIaKP+dMF4Ti
	LXLsThZfprHWpIk2b3YqYH4eLRjchrbFeftkk6GDoivXuoDA2WZZjIub1pUukpkuzwrJ9U
	G6EZluiV+MDLBKaKRi7SFpObkW8OFa0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-n6gFskU6MFOv_SNLngS5bA-1; Tue, 25 Feb 2025 08:53:30 -0500
X-MC-Unique: n6gFskU6MFOv_SNLngS5bA-1
X-Mimecast-MFC-AGG-ID: n6gFskU6MFOv_SNLngS5bA_1740491609
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f45a86efdso2889393f8f.2
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 05:53:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491609; x=1741096409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7vU3VhhoMgC9nQunbGAAKfjutxoGbUF5vj7yk2CWAI=;
        b=vhZT13nvAmPNj5SCUKpf+LmY7bZ1Hd94SWFvHs+df8hySFUocgqn8++neKSWdXTuhx
         RW/Se8WtiTPpncIBQEeu4yubABZZGPTFaL8Mw3vTGfbPhX+45XX+LWLGSFpc7lrhN6vm
         eUyp1e6GVZLVaqUQNuITyb0M/XsSNUWJZVsrnSrsvW7A8gYtDKy3IEF+V7D7HXLZCTfQ
         unQg3vsLiW4JILx+LPVdGKJGO9cls8B0UjS2tKEnrHU4OdotwMkOob0bBIDKUki+0uGd
         gygXaJiRlJrK/41IpfczGxYib8DlDlnhxGV+pK4BJTnxMnkJFM2gmx56zJTvWBI98x4/
         WZwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqajyq1ID2PneVTtF/r7v65Gh7aMhrBCxezJcM2mRjEj6+V6KDJaMBzMesgywfH3+0vUvmyVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC3wloK0lzyXE2h612hK/P8d3HcrSgxWTDXr/jmYhUNv6DMW3I
	+YcO5rY/kVD/aDi6p3jJxxo38q+I6kHyz963bSJlsa/t+emrmFHoJELQ45rid8GTmXv2P7Nsskn
	X5ePyaXZ99GCCoIG9EwaQJKY9fvZGWw5cSGot37vbmB0fzn3NKu6QNw==
X-Gm-Gg: ASbGncuP1TxXzXvOT00OmFuvQTQzNbkh13qjxsjRieIdPsBjIxRnfYGVt4oDGbS+oST
	Vj+RG8lSx10p1WsBSmd47QSAjK22r5YpfkQ1JfJ/YNhCwHE8MRrpmGvMJYBpIW7GQ9GLG/n0/Ms
	inPahp4WcJqhRJy5EjK7oj5tWqotT22CY6+RIk3KmNCScBkJsYx0Z+w+rVRCCVBfH0TsYS9oHdz
	c7no4yb0m01ttIIP0NG47528V/enUTVFqXIm1ELju5bQEpnXqV4mzVGb1/b/d7i2K1sNeqNebIg
	BcTXWM6eSiAnEdtELPFrwqwhDad7sOkKRlgH/KOY4BYenJIVQmoMID8kHvZpSmEr4W352E8=
X-Received: by 2002:a5d:6d0a:0:b0:38d:dd70:d70d with SMTP id ffacd0b85a97d-38f6e947399mr16386837f8f.18.1740491607632;
        Tue, 25 Feb 2025 05:53:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE0hz+LKA/haja8pKaprGKWKdGy/Wlzx4irRIbGpJPs+xk+gUHSZ8ipl87Yyg96z4+tcagMg==
X-Received: by 2002:a5d:6d0a:0:b0:38d:dd70:d70d with SMTP id ffacd0b85a97d-38f6e947399mr16386818f8f.18.1740491607238;
        Tue, 25 Feb 2025 05:53:27 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86ca9csm2362323f8f.22.2025.02.25.05.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:53:26 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 25 Feb 2025 14:53:16 +0100
Subject: [PATCH PATCH 5.15.y 2/3] vsock: Keep the binding until socket
 destruction
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-backport_fix_5_15-v1-2-479a1cce11a8@redhat.com>
References: <20250225-backport_fix_5_15-v1-0-479a1cce11a8@redhat.com>
In-Reply-To: <20250225-backport_fix_5_15-v1-0-479a1cce11a8@redhat.com>
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
index 4fae775ce8a05714d5224ad0b13679f36dbbf0cc..f922c4681dd9075ab01d1783178f1fe4f491260c 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -330,7 +330,10 @@ EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
 
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
@@ -815,12 +818,13 @@ static void __vsock_release(struct sock *sk, int level)
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


