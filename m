Return-Path: <stable+bounces-230152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJWTEpqEwmkAegQAu9opvQ
	(envelope-from <stable+bounces-230152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:33:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DADBA3084DF
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4888F31231B0
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE283F7AB4;
	Tue, 24 Mar 2026 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlJAFM9n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5553F54BD;
	Tue, 24 Mar 2026 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355417; cv=none; b=TKYehYvWfmS6NQ+454QulzRXoQIk2267mA4Fbqth0yEQXGYbz45Nz1N6XtBEYhzR3Ybx/dBbJH6yw6+hjX734myy6DOxnb+1Z///YIZz7kRDk5Z/aLYyfeUYDsPMREyTccD2mvxmqmzMu7f6/FCWBIDy07hFeH6MZnOBb1luadg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355417; c=relaxed/simple;
	bh=wJMzw7NgQ7d909biU6hPqGwcQ0xKglJLaKqrUAt3glI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SVmQAxQRyQe3f9ztwvDp0BBOzjXW0CdOL0kjkpBLWvZJd6aJNf3dJ/+/GSlnLaISyQcwmx42Hj8MQYTj/8ISGQXkUXi6D63ccefGvd9s5siQDUbVzoqA6Jk3T1XPix6zEbd1LLLAEOwXX34kLQMeJr966PZkrLpgj8eycVmXjao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlJAFM9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF419C19424;
	Tue, 24 Mar 2026 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774355416;
	bh=wJMzw7NgQ7d909biU6hPqGwcQ0xKglJLaKqrUAt3glI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UlJAFM9nKl9lolIe376yx7IeB2OEUNFolkxhPxNf/6PMMHlr2rx4ChTcTSLmMym4t
	 WZSewer2WMw+7Hm0AELYRNTTc/6TJ41y8NXYe8eMuPFl5SvvFq0sawUMZKPn2pF7Sm
	 WLi/v4HEgOoK7arllqy2+qRNax6k5dC6mKDIT9N1yF534JhwQWOxukxZplHF1wwCtg
	 DFvwUolL4sSQmLtJl2R5lypk/e/bHee3JpemoYRtHjO1RyPS9HMlFcbdh1ml1gh1cN
	 WuDCOG0yhnQZFrl/vpkEXpNY08QnTio001F/F4XpmqUm6RQtrrH/X8SKlCyCvBQIf4
	 9o2baClIqzZkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D8A8D3808200;
	Tue, 24 Mar 2026 12:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: macb: Use dev_consume_skb_any() to free TX SKBs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177435540464.657925.5877144884946970494.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 12:30:04 +0000
References: <20260321-macb-tx-v1-1-b383a58dd4e6@gmail.com>
In-Reply-To: <20260321-macb-tx-v1-1-b383a58dd4e6@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sean.anderson@linux.dev,
 netdev@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230152-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DADBA3084DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 21 Mar 2026 22:04:41 +0800 you wrote:
> The napi_consume_skb() function is not intended to be called in an IRQ
> disabled context. However, after commit 6bc8a5098bf4 ("net: macb: Fix
> tx_ptr_lock locking"), the freeing of TX SKBs is performed with IRQs
> disabled. To resolve the following call trace, use dev_consume_skb_any()
> for freeing TX SKBs:
>    WARNING: kernel/softirq.c:430 at __local_bh_enable_ip+0x174/0x188, CPU#0: ksoftirqd/0/15
>    Modules linked in:
>    CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 7.0.0-rc4-next-20260319-yocto-standard-dirty #37 PREEMPT
>    Hardware name: ZynqMP ZCU102 Rev1.1 (DT)
>    pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>    pc : __local_bh_enable_ip+0x174/0x188
>    lr : local_bh_enable+0x24/0x38
>    sp : ffff800082b3bb10
>    x29: ffff800082b3bb10 x28: ffff0008031f3c00 x27: 000000000011ede0
>    x26: ffff000800a7ff00 x25: ffff800083937ce8 x24: 0000000000017a80
>    x23: ffff000803243a78 x22: 0000000000000040 x21: 0000000000000000
>    x20: ffff000800394c80 x19: 0000000000000200 x18: 0000000000000001
>    x17: 0000000000000001 x16: ffff000803240000 x15: 0000000000000000
>    x14: ffffffffffffffff x13: 0000000000000028 x12: ffff000800395650
>    x11: ffff8000821d1528 x10: ffff800081c2bc08 x9 : ffff800081c1e258
>    x8 : 0000000100000301 x7 : ffff8000810426ec x6 : 0000000000000000
>    x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
>    x2 : 0000000000000008 x1 : 0000000000000200 x0 : ffff8000810428dc
>    Call trace:
>     __local_bh_enable_ip+0x174/0x188 (P)
>     local_bh_enable+0x24/0x38
>     skb_attempt_defer_free+0x190/0x1d8
>     napi_consume_skb+0x58/0x108
>     macb_tx_poll+0x1a4/0x558
>     __napi_poll+0x50/0x198
>     net_rx_action+0x1f4/0x3d8
>     handle_softirqs+0x16c/0x560
>     run_ksoftirqd+0x44/0x80
>     smpboot_thread_fn+0x1d8/0x338
>     kthread+0x120/0x150
>     ret_from_fork+0x10/0x20
>    irq event stamp: 29751
>    hardirqs last  enabled at (29750): [<ffff8000813be184>] _raw_spin_unlock_irqrestore+0x44/0x88
>    hardirqs last disabled at (29751): [<ffff8000813bdf60>] _raw_spin_lock_irqsave+0x38/0x98
>    softirqs last  enabled at (29150): [<ffff8000800f1aec>] handle_softirqs+0x504/0x560
>    softirqs last disabled at (29153): [<ffff8000800f2fec>] run_ksoftirqd+0x44/0x80
> 
> [...]

Here is the summary with links:
  - [net] net: macb: Use dev_consume_skb_any() to free TX SKBs
    https://git.kernel.org/netdev/net/c/647b8a2fe474

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



