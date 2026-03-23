Return-Path: <stable+bounces-229972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG0aAMp6wWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:39:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 047342FA1FE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CAD0730FC746
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10683C140F;
	Mon, 23 Mar 2026 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAlQleMo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B1D3B8BDA;
	Mon, 23 Mar 2026 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284204; cv=none; b=oWJcNw+ZRqHxb/ftGEq1cfH7cMPpyVp2hReB7s8+6e+pu4RSKes6/Ofmv+Wp7T1bV3nCWjZM7yyFk+MlOvP1s12SrpzB9kssqO0gS5dRsmhbhFY7+l36r53pSmtsl6lyd9jRCjAI5sta9iE7ZL6EEbk7gOKKoRqcg440GgqXYPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284204; c=relaxed/simple;
	bh=a44fNAaP9MPxuRmmu90d2vb0g4JLqJQMJqEsd/cg0mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDawDArciyOMAUBDW3YOHQPMgGvns41R4njzq/qnDZGlNP3diy66NpYF30Lc9ea7hwXEBijt3dE0qhZCiscQrRuWNoDK5Ru1jA6mxJop/KPbV547Z/TxCUx2VgoprD4UmZXtxxfalENaPo29cMeL0ky4JwQfcd8BTFEdKqHPFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAlQleMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3E7C4CEF7;
	Mon, 23 Mar 2026 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774284204;
	bh=a44fNAaP9MPxuRmmu90d2vb0g4JLqJQMJqEsd/cg0mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAlQleMoxMZzIGjU/JcoSl8ZTlAGa1C4pAseHPB/mCBzG1eXEsbp8F0UN/ZfGEV4i
	 Q/xbx0sjNRajzYrH45DdF6oyWLnrJtu2qs2QuAEsXVqPgzk6cNbGj9AEnkEey7nQoB
	 t9NX8mkGUnmH/F5WrNzczUPWNlKA0K/XDrGHID1N51SL4AUSfjiFkUfqn/cy5bgVfQ
	 UvHdorsl7mdeaXw/JD2mFWACGpvY0hpKdOGs6v3aeC00aNNEOsd45LKb2CTz+LBbvW
	 IO9k+Ed1403/WbaxlGT6fL/tQW/IlZLRE8TU0QnUWwpTpATDznJxxinQ93fSTQKaQ5
	 jG7JRyVeFpVOw==
Date: Mon, 23 Mar 2026 16:43:19 +0000
From: Simon Horman <horms@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: macb: Use dev_consume_skb_any() to free TX SKBs
Message-ID: <20260323164319.GA135222@horms.kernel.org>
References: <20260321-macb-tx-v1-1-b383a58dd4e6@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321-macb-tx-v1-1-b383a58dd4e6@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229972-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 047342FA1FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 10:04:41PM +0800, Kevin Hao wrote:
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
> Fixes: 6bc8a5098bf4 ("net: macb: Fix tx_ptr_lock locking")
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>


