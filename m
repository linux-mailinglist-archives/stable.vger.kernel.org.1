Return-Path: <stable+bounces-25953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC80F870765
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 17:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD00FB209A6
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3704AEEE;
	Mon,  4 Mar 2024 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q9xR03hq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8243D97F;
	Mon,  4 Mar 2024 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570554; cv=none; b=CTECOFmO2KHPeUdjUDRJo9R24EMpS6V7rFMg5Kph02UOFVkuictLttUnR7KmVWWW72Glwc/ZsGAceOJQzJjQx+RKNEiy3LCo0l9prQKlLigsJkpz/dRwzF68ffsAIlWuRi18AvEzwvs+Ys8vVeBLfSpmEzCU2e8jsJM9L+H/YZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570554; c=relaxed/simple;
	bh=9ihm1I1LJuB/KuscarETs6qd10Xfl1+kxlxLjl6cxg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3zHlWoF1cyWQgRce6aNcir21/aoVJiEHJhJXaOdK3VbT1MSPv2SwWcsGG9OcFKy73ue9mfUbKb3M7nJbud11sZM/j/wncheXMTC/WZDI+dWwzMTHUxNBjT0/VB9JaHgDwFmXrhgteW+oM2Zb30qQNxrNBi5jGLOsaSx1yF6YNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q9xR03hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30E6C433C7;
	Mon,  4 Mar 2024 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709570553;
	bh=9ihm1I1LJuB/KuscarETs6qd10Xfl1+kxlxLjl6cxg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q9xR03hqcVdf2qLZB+NQ4f3awPHZO97ftP/OodfPxgSlpEU4D2xGTIZeEynwDCSNZ
	 8SGKRaJNMv674kDLAdM/aD+F/e35YHzzJ6HErMIGVGdu+admiepMBBIM3nSwjNpZps
	 bbfOZ87XV0nK1ngYZG5lvxBbefWBlr8FoqWDRLgI=
Date: Mon, 4 Mar 2024 17:42:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Davide Caratti <dcaratti@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.15.y] mptcp: fix double-free on socket dismantle
Message-ID: <2024030400-perjury-unselect-ac3b@gregkh>
References: <2024030452-appliance-decidable-ccdb@gregkh>
 <20240304162517.2505910-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304162517.2505910-2-matttbe@kernel.org>

On Mon, Mar 04, 2024 at 05:25:18PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Davide Caratti <dcaratti@redhat.com>
> 
> when MPTCP server accepts an incoming connection, it clones its listener
> socket. However, the pointer to 'inet_opt' for the new socket has the same
> value as the original one: as a consequence, on program exit it's possible
> to observe the following splat:
> 
>   BUG: KASAN: double-free in inet_sock_destruct+0x54f/0x8b0
>   Free of addr ffff888485950880 by task swapper/25/0
> 
>   CPU: 25 PID: 0 Comm: swapper/25 Kdump: loaded Not tainted 6.8.0-rc1+ #609
>   Hardware name: Supermicro SYS-6027R-72RF/X9DRH-7TF/7F/iTF/iF, BIOS 3.0  07/26/2013
>   Call Trace:
>    <IRQ>
>    dump_stack_lvl+0x32/0x50
>    print_report+0xca/0x620
>    kasan_report_invalid_free+0x64/0x90
>    __kasan_slab_free+0x1aa/0x1f0
>    kfree+0xed/0x2e0
>    inet_sock_destruct+0x54f/0x8b0
>    __sk_destruct+0x48/0x5b0
>    rcu_do_batch+0x34e/0xd90
>    rcu_core+0x559/0xac0
>    __do_softirq+0x183/0x5a4
>    irq_exit_rcu+0x12d/0x170
>    sysvec_apic_timer_interrupt+0x6b/0x80
>    </IRQ>
>    <TASK>
>    asm_sysvec_apic_timer_interrupt+0x16/0x20
>   RIP: 0010:cpuidle_enter_state+0x175/0x300
>   Code: 30 00 0f 84 1f 01 00 00 83 e8 01 83 f8 ff 75 e5 48 83 c4 18 44 89 e8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc fb 45 85 ed <0f> 89 60 ff ff ff 48 c1 e5 06 48 c7 43 18 00 00 00 00 48 83 44 2b
>   RSP: 0018:ffff888481cf7d90 EFLAGS: 00000202
>   RAX: 0000000000000000 RBX: ffff88887facddc8 RCX: 0000000000000000
>   RDX: 1ffff1110ff588b1 RSI: 0000000000000019 RDI: ffff88887fac4588
>   RBP: 0000000000000004 R08: 0000000000000002 R09: 0000000000043080
>   R10: 0009b02ea273363f R11: ffff88887fabf42b R12: ffffffff932592e0
>   R13: 0000000000000004 R14: 0000000000000000 R15: 00000022c880ec80
>    cpuidle_enter+0x4a/0xa0
>    do_idle+0x310/0x410
>    cpu_startup_entry+0x51/0x60
>    start_secondary+0x211/0x270
>    secondary_startup_64_no_verify+0x184/0x18b
>    </TASK>
> 
>   Allocated by task 6853:
>    kasan_save_stack+0x1c/0x40
>    kasan_save_track+0x10/0x30
>    __kasan_kmalloc+0xa6/0xb0
>    __kmalloc+0x1eb/0x450
>    cipso_v4_sock_setattr+0x96/0x360
>    netlbl_sock_setattr+0x132/0x1f0
>    selinux_netlbl_socket_post_create+0x6c/0x110
>    selinux_socket_post_create+0x37b/0x7f0
>    security_socket_post_create+0x63/0xb0
>    __sock_create+0x305/0x450
>    __sys_socket_create.part.23+0xbd/0x130
>    __sys_socket+0x37/0xb0
>    __x64_sys_socket+0x6f/0xb0
>    do_syscall_64+0x83/0x160
>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
>   Freed by task 6858:
>    kasan_save_stack+0x1c/0x40
>    kasan_save_track+0x10/0x30
>    kasan_save_free_info+0x3b/0x60
>    __kasan_slab_free+0x12c/0x1f0
>    kfree+0xed/0x2e0
>    inet_sock_destruct+0x54f/0x8b0
>    __sk_destruct+0x48/0x5b0
>    subflow_ulp_release+0x1f0/0x250
>    tcp_cleanup_ulp+0x6e/0x110
>    tcp_v4_destroy_sock+0x5a/0x3a0
>    inet_csk_destroy_sock+0x135/0x390
>    tcp_fin+0x416/0x5c0
>    tcp_data_queue+0x1bc8/0x4310
>    tcp_rcv_state_process+0x15a3/0x47b0
>    tcp_v4_do_rcv+0x2c1/0x990
>    tcp_v4_rcv+0x41fb/0x5ed0
>    ip_protocol_deliver_rcu+0x6d/0x9f0
>    ip_local_deliver_finish+0x278/0x360
>    ip_local_deliver+0x182/0x2c0
>    ip_rcv+0xb5/0x1c0
>    __netif_receive_skb_one_core+0x16e/0x1b0
>    process_backlog+0x1e3/0x650
>    __napi_poll+0xa6/0x500
>    net_rx_action+0x740/0xbb0
>    __do_softirq+0x183/0x5a4
> 
>   The buggy address belongs to the object at ffff888485950880
>    which belongs to the cache kmalloc-64 of size 64
>   The buggy address is located 0 bytes inside of
>    64-byte region [ffff888485950880, ffff8884859508c0)
> 
>   The buggy address belongs to the physical page:
>   page:0000000056d1e95e refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888485950700 pfn:0x485950
>   flags: 0x57ffffc0000800(slab|node=1|zone=2|lastcpupid=0x1fffff)
>   page_type: 0xffffffff()
>   raw: 0057ffffc0000800 ffff88810004c640 ffffea00121b8ac0 dead000000000006
>   raw: ffff888485950700 0000000000200019 00000001ffffffff 0000000000000000
>   page dumped because: kasan: bad access detected
> 
>   Memory state around the buggy address:
>    ffff888485950780: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>    ffff888485950800: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>   >ffff888485950880: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>                      ^
>    ffff888485950900: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>    ffff888485950980: 00 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc
> 
> Something similar (a refcount underflow) happens with CALIPSO/IPv6. Fix
> this by duplicating IP / IPv6 options after clone, so that
> ip{,6}_sock_destruct() doesn't end up freeing the same memory area twice.
> 
> Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming connections")
> Cc: stable@vger.kernel.org
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Link: https://lore.kernel.org/r/20240223-upstream-net-20240223-misc-fixes-v1-8-162e87e48497@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> (cherry picked from commit 10048689def7e40a4405acda16fdc6477d4ecc5c)
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - Conflicts in protocol.c because mptcp_sk_clone() has been renamed to
>    mptcp_sk_clone_init() in commit 7e8b88ec35ee ("mptcp: consolidate
>    passive msk socket initialization") which has not been backported to
>    v5.15 due to a too long list of dependences.

Now queued up, thanks!

greg k-h

