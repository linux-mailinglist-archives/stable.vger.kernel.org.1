Return-Path: <stable+bounces-116441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FA7A3650B
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 18:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13F016F919
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 17:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3F0268C69;
	Fri, 14 Feb 2025 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWGsl2Q0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8F22686B4
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555679; cv=none; b=sMEBEdGR9FOadYPspq6MmmzUidgjLCuCeG1avoR9S9DKx0nStmHLk8y4dw1hiWfORN7DLaABfK/Evekd3nJgjA0/UH+0pYRKBKuv7qzmfC8M6uBS1WVzo6Z3/4UFuyZyArq/ryVzQ4Ggt85ArvC425sXBMmETjHCpIA4FEUKoEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555679; c=relaxed/simple;
	bh=+UTtonFVjyXct//2d9DL23WeSL31uR1xbzA4czOKY8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phGy9xLzHhyTC4yUdofkrugd4qNfQSI0qnQcGtqbjIjN4vLj0hnYX+vLhB/WjTRcE7SGuHel5I3D2PaxAN+S+YnKIrzWwRBDG1FvMd1I3inOiO7EdzLaAZQ4aI4uuKQZgozR+9+T2bWtRN1erQWkKccTvmdPd9SHMnvBE818OZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWGsl2Q0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739555676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AaILXtpgWEzeMGPsh5AYBvVpFOVzJHJ8cudb3OEQ1c=;
	b=WWGsl2Q0P6dWur6A6NRvdW+NfBeqx1aw6jUDVlUhBqg3RYy4BqxKnWAnnDTNvDm/HeDtK6
	yvSIgdLm3nE4m8/0Hwn9PSEAYsdedVW0AP2IQEz9UAUjQvSkQ9NO2zWwsj76af2C7GT3UB
	62/Tns2AHjpjY0jvyshXJZrxO/m/92U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-BTL1m02tPFad34hC5GTL6Q-1; Fri, 14 Feb 2025 12:54:33 -0500
X-MC-Unique: BTL1m02tPFad34hC5GTL6Q-1
X-Mimecast-MFC-AGG-ID: BTL1m02tPFad34hC5GTL6Q_1739555671
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38ddee833e0so1356787f8f.1
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 09:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555671; x=1740160471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AaILXtpgWEzeMGPsh5AYBvVpFOVzJHJ8cudb3OEQ1c=;
        b=HUcFSDY5uNiS8QiWtvEzTkUarC8lZW+z1mIlmTMoh1gP5CqfcdxgWq4u2xPQ1P8Z3A
         b/Dinj1tProX/q0nAhrtq/eHIqBsOUeax6LDOUOtA5+pFLKBTdQjz5qY5KHbD2uEZFIy
         qaYKRYL/QuRVuGD3KK0ulqjrNmf/fqCpcLBENrT+88QOQ/EWZdFleEwkI+wwpmIvJdm8
         mHlnVNKrCtbE+v7zCZGddGaRsVQEV18QLiBsJ79qt3xRNwa+iAOww4YDaxpCDPWpr31C
         ABzrZk1TOFFLWqAfHk2pjcLBHg+qEBSP2CMXrPb6+aLrlV6/Z78EYsumvE+jLILU2+0I
         91cw==
X-Forwarded-Encrypted: i=1; AJvYcCXWkb0vP4b3HGMLUnYA8RW4uAaD17u4Vp5WX85AG4Srx4wogfbjjOlsmP6HbXRTo7WD6dhuED8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxom9U1LuWcXJY73bfpRZ5oANZeOycTXXERiVyeAxJAmL2m1QtS
	SbBDoRXu3yk4kV2tuJBremrsdEMVNgABfmw4Tj6V3JfFQeX0vdRj/yMnhPhkH9ycjLg+MnZ6bJg
	GdXiI9wb//NiMYiskHBlLAFOK0P2cXssYSG8ral6PaOQ5W8XpvsvtK9qHV6n7NA==
X-Gm-Gg: ASbGncs4p2ldqzagqjn38ofiIn0KREmbIQpM8ZcBIKHPRFFQyD6GxGAPkdezcrvRAyA
	u8vDrSjK5Zve8IG/DqbUpOv75lG9vxjb/TjC9YsRPS/6C3+5AH2j6DNN/7HcrKtTXknzJkyRlw9
	8i+v+YdVpOAChBN0uVI5nfkP1eshRGzgACrH6D9Pf5sEvqWhN10VDAEBz+lHckVpwFA08RnHyH0
	G4sZfvAmYtEtRTP62XKvYBIfOpMtFIBJOw113eIAjBdnOaUkFExfprEbVIcx+iMw9YXxhbZCh+Q
	JVgMg3VeQY+1pLEPj5wV1yJ6pEP3evphXzg=
X-Received: by 2002:a5d:6f19:0:b0:386:374b:e8bc with SMTP id ffacd0b85a97d-38f24d10851mr9796352f8f.15.1739555671061;
        Fri, 14 Feb 2025 09:54:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOJ3csTG5CdBCg7neirElka8zk1rB2SfMFAh92T28rasxtTvvcynKVw0EHIsep04ZI0BbNBQ==
X-Received: by 2002:a5d:6f19:0:b0:386:374b:e8bc with SMTP id ffacd0b85a97d-38f24d10851mr9796330f8f.15.1739555670674;
        Fri, 14 Feb 2025 09:54:30 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961884e88sm49418365e9.26.2025.02.14.09.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:54:30 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Fri, 14 Feb 2025 18:53:55 +0100
Subject: [PATCH 1/2] vsock: Keep the binding until socket destruction
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-linux-rolling-stable-v1-1-d39dc6251d2f@redhat.com>
References: <20250214-linux-rolling-stable-v1-0-d39dc6251d2f@redhat.com>
In-Reply-To: <20250214-linux-rolling-stable-v1-0-d39dc6251d2f@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>, 
 stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>
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
---
 net/vmw_vsock/af_vsock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f5d116a1bdea1a0b1a80488a27ce71ee636a65fa..ec4c1fbbcec7418d2e715bad30845cd95a9b270f 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -337,7 +337,10 @@ EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
 
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
@@ -821,12 +824,13 @@ static void __vsock_release(struct sock *sk, int level)
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


