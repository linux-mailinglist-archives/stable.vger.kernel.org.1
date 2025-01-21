Return-Path: <stable+bounces-109628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9E2A18085
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 15:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B94168187
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 14:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE1B1F3FD6;
	Tue, 21 Jan 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DpA6i2sy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5993254F81
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737471249; cv=none; b=HDm/2yJOIAI25Dgrlcl0uiUebxZus++YaITpbKeFcGQy0ZUvARqD6JapwSZYx+gZS2Bj/4g3W6KUkqjJ8xnqbKQlqewurlo9FWMNY8zueqqRCxwhDXt3vv3KOixgK8JnxhLGc1ap+a5n1xUDS3IuB0N+dnkkUPsI7eCqMF48QOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737471249; c=relaxed/simple;
	bh=OQh0OuRT7E/Oc027pUy8V3DuO7TBJZWl50+TXp7+Lio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0wW0NUMr/P8Ofy8fpbvfrC02WLEot30tngg0WMKPzjMiLwj+7AHnfnbLDeTvnnB7/oZCOwq/HpeaQtXnYnNtjMQpsEPcl4mlqkFu0KeHt9ANPT27O++Wph19GrgHHIzDe42N/JMwXaaR8/wNvRs+6jfjtEt+LQz2JtSh5F+RAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DpA6i2sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B82C4CEDF;
	Tue, 21 Jan 2025 14:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737471248;
	bh=OQh0OuRT7E/Oc027pUy8V3DuO7TBJZWl50+TXp7+Lio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpA6i2syhHM5gs25cbw4W2z08CjpfRjB35ymxP/C7clmLr2ucU9PMFt0nMsyp4x3b
	 DoH33sc4rSNs/qjnj1Sap0GL0y923mNK9grS05+Ie9a/gG3RwKLKgXf6V92ogyWWc8
	 t4oHnG3CW3Km78etgU0tOCyEi+FDzGSK/V7QVCSU=
Date: Tue, 21 Jan 2025 15:54:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: alvalan9@foxmail.com
Cc: stable@vger.kernel.org, Wang Liang <wangliang74@huawei.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] net: fix data-races around sk->sk_forward_alloc
Message-ID: <2025012102-zero-tidiness-4632@gregkh>
References: <tencent_D660CC1BB869156A7C3EBA24B5ACF371BA09@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_D660CC1BB869156A7C3EBA24B5ACF371BA09@qq.com>

On Tue, Jan 21, 2025 at 10:22:43PM +0800, alvalan9@foxmail.com wrote:
> From: Wang Liang <wangliang74@huawei.com>
> 
> commit 073d89808c065ac4c672c0a613a71b27a80691cb upstream.
> 
> Syzkaller reported this warning:
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 16 at net/ipv4/af_inet.c:156 inet_sock_destruct+0x1c5/0x1e0
>  Modules linked in:
>  CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc5 #26
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>  RIP: 0010:inet_sock_destruct+0x1c5/0x1e0
>  Code: 24 12 4c 89 e2 5b 48 c7 c7 98 ec bb 82 41 5c e9 d1 18 17 ff 4c 89 e6 5b 48 c7 c7 d0 ec bb 82 41 5c e9 bf 18 17 ff 0f 0b eb 83 <0f> 0b eb 97 0f 0b eb 87 0f 0b e9 68 ff ff ff 66 66 2e 0f 1f 84 00
>  RSP: 0018:ffffc9000008bd90 EFLAGS: 00010206
>  RAX: 0000000000000300 RBX: ffff88810b172a90 RCX: 0000000000000007
>  RDX: 0000000000000002 RSI: 0000000000000300 RDI: ffff88810b172a00
>  RBP: ffff88810b172a00 R08: ffff888104273c00 R09: 0000000000100007
>  R10: 0000000000020000 R11: 0000000000000006 R12: ffff88810b172a00
>  R13: 0000000000000004 R14: 0000000000000000 R15: ffff888237c31f78
>  FS:  0000000000000000(0000) GS:ffff888237c00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007ffc63fecac8 CR3: 000000000342e000 CR4: 00000000000006f0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   ? __warn+0x88/0x130
>   ? inet_sock_destruct+0x1c5/0x1e0
>   ? report_bug+0x18e/0x1a0
>   ? handle_bug+0x53/0x90
>   ? exc_invalid_op+0x18/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? inet_sock_destruct+0x1c5/0x1e0
>   __sk_destruct+0x2a/0x200
>   rcu_do_batch+0x1aa/0x530
>   ? rcu_do_batch+0x13b/0x530
>   rcu_core+0x159/0x2f0
>   handle_softirqs+0xd3/0x2b0
>   ? __pfx_smpboot_thread_fn+0x10/0x10
>   run_ksoftirqd+0x25/0x30
>   smpboot_thread_fn+0xdd/0x1d0
>   kthread+0xd3/0x100
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x34/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  ---[ end trace 0000000000000000 ]---
> 
> Its possible that two threads call tcp_v6_do_rcv()/sk_forward_alloc_add()
> concurrently when sk->sk_state == TCP_LISTEN with sk->sk_lock unlocked,
> which triggers a data-race around sk->sk_forward_alloc:
> tcp_v6_rcv
>     tcp_v6_do_rcv
>         skb_clone_and_charge_r
>             sk_rmem_schedule
>                 __sk_mem_schedule
>                     sk_forward_alloc_add()
>             skb_set_owner_r
>                 sk_mem_charge
>                     sk_forward_alloc_add()
>         __kfree_skb
>             skb_release_all
>                 skb_release_head_state
>                     sock_rfree
>                         sk_mem_uncharge
>                             sk_forward_alloc_add()
>                             sk_mem_reclaim
>                                 // set local var reclaimable
>                                 __sk_mem_reclaim
>                                     sk_forward_alloc_add()
> 
> In this syzkaller testcase, two threads call
> tcp_v6_do_rcv() with skb->truesize=768, the sk_forward_alloc changes like
> this:
>  (cpu 1)             | (cpu 2)             | sk_forward_alloc
>  ...                 | ...                 | 0
>  __sk_mem_schedule() |                     | +4096 = 4096
>                      | __sk_mem_schedule() | +4096 = 8192
>  sk_mem_charge()     |                     | -768  = 7424
>                      | sk_mem_charge()     | -768  = 6656
>  ...                 |    ...              |
>  sk_mem_uncharge()   |                     | +768  = 7424
>  reclaimable=7424    |                     |
>                      | sk_mem_uncharge()   | +768  = 8192
>                      | reclaimable=8192    |
>  __sk_mem_reclaim()  |                     | -4096 = 4096
>                      | __sk_mem_reclaim()  | -8192 = -4096 != 0
> 
> The skb_clone_and_charge_r() should not be called in tcp_v6_do_rcv() when
> sk->sk_state is TCP_LISTEN, it happens later in tcp_v6_syn_recv_sock().
> Fix the same issue in dccp_v6_do_rcv().
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> Link: https://patch.msgid.link/20241107023405.889239-1-wangliang74@huawei.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Alva Lan <alvalan9@foxmail.com>
> ---

You sent this twice, which one is correct?  I'll drop both from my inbox
just to be sure :)

> Backport to fix CVE-2024-53124.
> Link: https://nvd.nist.gov/vuln/detail/CVE-2024-53124

Please don't point to random cve "enhancers" with unknown ways that they
have modified our original cve record.  Just point at the cve.org record
if you really want to link to something.

thanks,

greg k-h

