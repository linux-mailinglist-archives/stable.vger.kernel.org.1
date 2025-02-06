Return-Path: <stable+bounces-114067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E309A2A648
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 11:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B559F3A10C7
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 10:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD7222756B;
	Thu,  6 Feb 2025 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="He4VA3ps"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72200227574
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738838670; cv=none; b=B7WoBGGzZvku9fV14o5KbLu0VgyFtekZ6VC9adq/nKgEAqpdccwASsbOe5/ODIzj/fy6MI6w+FDEIBs3yTQLovXLmcRo5Vd76cAZqJlv8/6ETrlnGbHGZgGTZjB9/eMXTB0TSTTXzobCunjPVlgmN5rFJOGtSxyw7kdRgG1eehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738838670; c=relaxed/simple;
	bh=f37BnzEPHuD3q6LNoCsTVykNqjhPkvQh1TItpe9Tlyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia1Ep4kZ99GS49gmZIdJgCbhSnwO9MsjPzXjg5QJiOaxXFtXZdAsFBARvwhGCfkP1FLmxFAulsLH6LPQbgmk1ckcrGTfBBR/s5UaAvXwTrvjC7b0kSoxGxVFB6tdsjO3wQ5CzcT6xhK+e2BlGUKuygX1xBwKmBH2DjbEf7ZP/cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=He4VA3ps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738838667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HDEhcSzIaU3DG7M8y+7dvBfsTnpuOC4vgxNOj/3w94g=;
	b=He4VA3pssHzRoxjazWn3lRq+hz+OleB2OG6jVt7FDeYBbZG+SdUlJQ5667RI4qalnNiQxI
	gW8dzD1U3vrZ/8HxCbLNRPNtMntQ+DcdwGzTILOrwYywblSNxqSZXEOBWvabwax8xu+vSC
	f/9phQz1yncMNO/pHG6eHdHxLP/gvSU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-JVALYF7tPGWhA47srs0bLA-1; Thu, 06 Feb 2025 05:44:26 -0500
X-MC-Unique: JVALYF7tPGWhA47srs0bLA-1
X-Mimecast-MFC-AGG-ID: JVALYF7tPGWhA47srs0bLA
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5dcd443254fso926782a12.1
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 02:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738838665; x=1739443465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDEhcSzIaU3DG7M8y+7dvBfsTnpuOC4vgxNOj/3w94g=;
        b=fiVC6BatXqzdgXq04BVIN9TsMzIU8Rhydefv6iAIIhaH8KU/OwNqLlBJHGaOMIq4Nz
         E8kbnKhy94kUCeEErNbVUQOwYB8dq3b91s36o+WYFsX+Vauomsc+DkAkk8nf9vu531Id
         Cu4AWuS5YaDFKNebQLz5R4gL8aTLMz4uYT77hPRbfSXxtAFVuZzLjsmxcuuWenwf6jw+
         V+YAOOQpFWr/6eMDpPkZCvGJ2w8nDjyAbhquxY95KPAoa9SwsDQqsdRVQixx7c1c6HRe
         3HDv/a6RGXpuQRyVBVrB2OczWo6GGSLH8gKxEMU2sHIP9VndQ3C3+JG/OFIFgLtSNhQU
         kVpg==
X-Gm-Message-State: AOJu0YzMzcwL5uRYz5Wuj0dOYlJyBJAwA8GF3KwCrvrQDkcneoY3Licu
	bUx6K92Y1eo2joBZzSTCVEJqIOkdZ7thPFRCbOr1i9CYHLmVWUlQBQrkR+MhVV83pAUfmkpMDJK
	Y0yl4KrlkIkgjgonH6xc9L+WVkz87gRBBdpJTWgt6S8oAWnArmrHsuw==
X-Gm-Gg: ASbGncsFfn9eJEqPkDTfWWx5khpWbOW+qummLpt6GMR7Ob+PMloO549GEspJRX//lwE
	2TVxsfP0/i3ZTS2/mqhveWEmRJ8oabaXRJOUGfk77KAIRKfuHzDD0d26Qm2Ni/2JA/rTJEBKfHs
	M46HDzP1fYu9N1baLfsgS3QWYyaaUUuujBmoIiBz7xSn6jn93VNzFFhXrNDShKeJHhQ/OPfVpie
	pzDRhIjVQiBBcM23aZa0dfgotgArZmLBc5DD/5owvJ/PeGjsZKZES8tSTGDjl/GICQz1AqSLw27
	8lgIORlU
X-Received: by 2002:a05:6402:321e:b0:5dc:80d5:ff23 with SMTP id 4fb4d7f45d1cf-5dcdb7329famr7048687a12.15.1738838664690;
        Thu, 06 Feb 2025 02:44:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsHL4KMLwQD8Ukq7qwErKnsWOkez8Dkt+YWoh8rTcRjdUUJLoqtF/HNoTYY1+JI0vvCRSesA==
X-Received: by 2002:a05:6402:321e:b0:5dc:80d5:ff23 with SMTP id 4fb4d7f45d1cf-5dcdb7329famr7048661a12.15.1738838664269;
        Thu, 06 Feb 2025 02:44:24 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de379cedc6sm37086a12.44.2025.02.06.02.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:44:23 -0800 (PST)
Date: Thu, 6 Feb 2025 11:44:21 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 544/623] vsock: Keep the binding until socket
 destruction
Message-ID: <xv4vulunzu47uszjgzjhjzf6jetbvzy4c4uotkfh6t3ns74is4@mcpi3jj5iy4z>
References: <20250205134456.221272033@linuxfoundation.org>
 <20250205134517.034256003@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250205134517.034256003@linuxfoundation.org>

On Wed, Feb 05, 2025 at 02:44:46PM +0100, Greg Kroah-Hartman wrote:
>6.13-stable review patch.  If anyone has any objections, please let me know.
>
>------------------
>
>From: Michal Luczaj <mhal@rbox.co>
>
>[ Upstream commit fcdd2242c0231032fc84e1404315c245ae56322a ]
>
Hi Greg,

This patch introduced a bug[1], Michal has already sent a patch to fix 
it [2], but has not been merged yet. Should we wait and merge them 
together? WDYT?

Thanks,
Luigi

[1]https://lore.kernel.org/all/67a09300.050a0220.d7c5a.008b.GAE@google.com/
[2]https://lore.kernel.org/all/20250206-vsock-linger-nullderef-v2-0-f8a1f19146f8@rbox.co/

>Preserve sockets bindings; this includes both resulting from an 
>explicit
>bind() and those implicitly bound through autobind during connect().
>
>Prevents socket unbinding during a transport reassignment, which fixes a
>use-after-free:
>
>    1. vsock_create() (refcnt=1) calls vsock_insert_unbound() (refcnt=2)
>    2. transport->release() calls vsock_remove_bound() without checking if
>       sk was bound and moved to bound list (refcnt=1)
>    3. vsock_bind() assumes sk is in unbound list and before
>       __vsock_insert_bound(vsock_bound_sockets()) calls
>       __vsock_remove_bound() which does:
>           list_del_init(&vsk->bound_table); // nop
>           sock_put(&vsk->sk);               // refcnt=0
>
>BUG: KASAN: slab-use-after-free in __vsock_bind+0x62e/0x730
>Read of size 4 at addr ffff88816b46a74c by task a.out/2057
> dump_stack_lvl+0x68/0x90
> print_report+0x174/0x4f6
> kasan_report+0xb9/0x190
> __vsock_bind+0x62e/0x730
> vsock_bind+0x97/0xe0
> __sys_bind+0x154/0x1f0
> __x64_sys_bind+0x6e/0xb0
> do_syscall_64+0x93/0x1b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>Allocated by task 2057:
> kasan_save_stack+0x1e/0x40
> kasan_save_track+0x10/0x30
> __kasan_slab_alloc+0x85/0x90
> kmem_cache_alloc_noprof+0x131/0x450
> sk_prot_alloc+0x5b/0x220
> sk_alloc+0x2c/0x870
> __vsock_create.constprop.0+0x2e/0xb60
> vsock_create+0xe4/0x420
> __sock_create+0x241/0x650
> __sys_socket+0xf2/0x1a0
> __x64_sys_socket+0x6e/0xb0
> do_syscall_64+0x93/0x1b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>Freed by task 2057:
> kasan_save_stack+0x1e/0x40
> kasan_save_track+0x10/0x30
> kasan_save_free_info+0x37/0x60
> __kasan_slab_free+0x4b/0x70
> kmem_cache_free+0x1a1/0x590
> __sk_destruct+0x388/0x5a0
> __vsock_bind+0x5e1/0x730
> vsock_bind+0x97/0xe0
> __sys_bind+0x154/0x1f0
> __x64_sys_bind+0x6e/0xb0
> do_syscall_64+0x93/0x1b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>refcount_t: addition on 0; use-after-free.
>WARNING: CPU: 7 PID: 2057 at lib/refcount.c:25 refcount_warn_saturate+0xce/0x150
>RIP: 0010:refcount_warn_saturate+0xce/0x150
> __vsock_bind+0x66d/0x730
> vsock_bind+0x97/0xe0
> __sys_bind+0x154/0x1f0
> __x64_sys_bind+0x6e/0xb0
> do_syscall_64+0x93/0x1b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>refcount_t: underflow; use-after-free.
>WARNING: CPU: 7 PID: 2057 at lib/refcount.c:28 refcount_warn_saturate+0xee/0x150
>RIP: 0010:refcount_warn_saturate+0xee/0x150
> vsock_remove_bound+0x187/0x1e0
> __vsock_release+0x383/0x4a0
> vsock_release+0x90/0x120
> __sock_release+0xa3/0x250
> sock_close+0x14/0x20
> __fput+0x359/0xa80
> task_work_run+0x107/0x1d0
> do_exit+0x847/0x2560
> do_group_exit+0xb8/0x250
> __x64_sys_exit_group+0x3a/0x50
> x64_sys_call+0xfec/0x14f0
> do_syscall_64+0x93/0x1b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>Link: https://patch.msgid.link/20250128-vsock-transport-vs-autobind-v3-1-1cf57065b770@rbox.co
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>Signed-off-by: Sasha Levin <sashal@kernel.org>
>---
> net/vmw_vsock/af_vsock.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index fa9d1b49599bf..cfe18bc8fdbe7 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -337,7 +337,10 @@ EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
>
> void vsock_remove_sock(struct vsock_sock *vsk)
> {
>-	vsock_remove_bound(vsk);
>+	/* Transport reassignment must not remove the binding. */
>+	if (sock_flag(sk_vsock(vsk), SOCK_DEAD))
>+		vsock_remove_bound(vsk);
>+
> 	vsock_remove_connected(vsk);
> }
> EXPORT_SYMBOL_GPL(vsock_remove_sock);
>@@ -821,12 +824,13 @@ static void __vsock_release(struct sock *sk, int level)
> 	 */
> 	lock_sock_nested(sk, level);
>
>+	sock_orphan(sk);
>+
> 	if (vsk->transport)
> 		vsk->transport->release(vsk);
> 	else if (sock_type_connectible(sk->sk_type))
> 		vsock_remove_sock(vsk);
>
>-	sock_orphan(sk);
> 	sk->sk_shutdown = SHUTDOWN_MASK;
>
> 	skb_queue_purge(&sk->sk_receive_queue);
>-- 
>2.39.5
>
>
>


