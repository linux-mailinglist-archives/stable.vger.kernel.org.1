Return-Path: <stable+bounces-119523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D22BA442C7
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 15:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1371717B397
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23D426A095;
	Tue, 25 Feb 2025 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLna9HLK"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D59D269CE0
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493608; cv=none; b=hoztsatdT7qoXp1uxRLqW+5lVQnKG4HH/mngGCBMp2gUu0EuGXWYjFHOYhPvqlrnXOADs28vI+RXPOaH8mL/Ko84l4YO1b7cMZPM/yXLY33NoqNcg2e+Yipmh6Y7D5UE66WqgBOu2ZmxjKRMj2aGP5c2LyoWfmaw1QnaxggPPOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493608; c=relaxed/simple;
	bh=bq0wuvkMjDRBmWovb6ZR+41uGk+aBo1vMC1+5yTVyhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eIiQqF0uCkIA9BlB81ckVAGniePMEg4O3Ac04gXl8SnU/G2k/ZvA7tj/uzUpsxEXrfSl9vNlyUYHc5k/ZWzYX/kaAjhdVSDxTAZI12buHzzQE8v/HbxjkETIuSyKfzZBuCw4IkORgiSQb06oCuU/NBWVgw68K7Me6NsybaFtcW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cLna9HLK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740493605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gikjitOr7IvsiU2DeGQqw6gpCOi8MN20/lBIio2fFUM=;
	b=cLna9HLKHcLlepRsqEA/kuplhO7Czh6aL+97CWvtcXBeQjmFr6kofJn7qlVeG4Hq0qeS01
	Hv+43kA6fBrk7WjfrluWeD5diCzfF7+hb8vjYYHy6etyosERBmA4yGvEHwltd9zLxww0PV
	ywcJF4AYt3HeOh+XN9daqQGcnNAxlYA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-SSfwu94LPYePqbh1z-c6hg-1; Tue, 25 Feb 2025 09:26:44 -0500
X-MC-Unique: SSfwu94LPYePqbh1z-c6hg-1
X-Mimecast-MFC-AGG-ID: SSfwu94LPYePqbh1z-c6hg_1740493603
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f4cce15c8so2704520f8f.2
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 06:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493603; x=1741098403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gikjitOr7IvsiU2DeGQqw6gpCOi8MN20/lBIio2fFUM=;
        b=SIpAixc5KPL4Pe8KyVvvRDU+f56+nDijgJD22QzTZMV4mJSjy1jbnnIbj4olIR/834
         6CgC3Kmm2AOOlmgPs7VbmRLMAQHVClVidnVd3/+vCNn8M7sUmkmSNfyE6Uua0Og/Jqhq
         WH1ZcjqsxAtGoJV1JZSdLG0/9IjdIqronv2UoK9w5aVIdFR/Y8hS4kDxZD34AFujjQYn
         uASX21Zq5QO/CqdRCUgCw038TRHtYfSP+aVBXaTDcoa7WL5oBq9sQuq7tbYPaAwfgOoC
         EwlVemnWXoEQy+Hrkxm/B5yB1DRdi1zxoY25pUAmTBwjJsFgyaAHZ1iaels+ZJy4EmR3
         xjbA==
X-Forwarded-Encrypted: i=1; AJvYcCW/iZ6GTRnL+7Q9MNMhbfxrRho2G4J8H4BHKbQVYQdLCdjzs6hbtmJ7vnlaHhrm5W3VvFqsEGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOKDIIt6OQMFcLSbkG9E+0wP2A5QoDGNKz118fJZVcFoBF9hSi
	5h1EWtTmGEUItgnTIX39pfb07LuK11unmf9yn6/wesMfq/QPNr7MrtITunslAV3o8Dkh7HteFsJ
	WggcpPJzS65Xm18dlMtfxMhNdwma3k2XjXIH+je+WM2uXSAzg3v6rAQ==
X-Gm-Gg: ASbGnctVYpptE7S6BdwAPstkaUc7ZsSv13FWp8829PXzgwdOZd0RXUkgy48myZ3QYgd
	Ffu9cisNkcIpbB8/KT3BFcuqqSXOS0oAL2zdWcco3jOzeqIpSPiaJl3pGZgZSAQ9sYijw9ndLK3
	CyD9htZvPmWA/V73Y3R2ixrSwFeYRgQqzKSWs8tMTRdeStqVPN37NPwU6rhQ0E70i+aUDK5cwea
	9rHoR98nf3KVL+eCjK4qGEkxKIHdMFvWjAEq7mDaQrIBPm8pnaQ6mrimwE6cJk/x0A/qttKtL/W
	V8RyLhqJXHTq0jKbBKU3SkCebKxNu5QrRgEMWZMP45g8k3EqhltBJGm2A57Ey7XQDGSzi70=
X-Received: by 2002:adf:ffc8:0:b0:38f:4d91:c123 with SMTP id ffacd0b85a97d-390cc60cf53mr2179608f8f.32.1740493603141;
        Tue, 25 Feb 2025 06:26:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgvx+6y51qOq/Lc7QzYwUF9QfpVnfVs7+AnBfLjhodTp9ZLHWZ0z9MohCUNSh/XU2sglufbQ==
X-Received: by 2002:adf:ffc8:0:b0:38f:4d91:c123 with SMTP id ffacd0b85a97d-390cc60cf53mr2179587f8f.32.1740493602745;
        Tue, 25 Feb 2025 06:26:42 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e7108sm2494009f8f.69.2025.02.25.06.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:26:42 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 25 Feb 2025 15:26:29 +0100
Subject: [PATCH 5.10.y 2/3] vsock: Keep the binding until socket
 destruction
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-backport_fix_5_10-v1-2-055dfd7be521@redhat.com>
References: <20250225-backport_fix_5_10-v1-0-055dfd7be521@redhat.com>
In-Reply-To: <20250225-backport_fix_5_10-v1-0-055dfd7be521@redhat.com>
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
index f80b28934c4b5af11765074da8d3f6f3d92ce6ff..f3e520e127bc271810ce80152d1e05a9ed1bea42 100644
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
@@ -782,12 +785,13 @@ static void __vsock_release(struct sock *sk, int level)
 	 */
 	lock_sock_nested(sk, level);
 
+	sock_orphan(sk);
+
 	if (vsk->transport)
 		vsk->transport->release(vsk);
 	else if (sk->sk_type == SOCK_STREAM)
 		vsock_remove_sock(vsk);
 
-	sock_orphan(sk);
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
 	skb_queue_purge(&sk->sk_receive_queue);

-- 
2.48.1


