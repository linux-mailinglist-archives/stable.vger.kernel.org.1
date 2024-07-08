Return-Path: <stable+bounces-58196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B99929EB6
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 11:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944CE280EB2
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965854DA00;
	Mon,  8 Jul 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwPFU+0x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA0AD31;
	Mon,  8 Jul 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720429920; cv=none; b=hgRDkwm+Ppv3LHzWasQzUYLDDSQVttrlTWuEK2YqEHlxHOms0u/j/FE/Y33ToXiDdqwOiWMQbQHjIqtNe8iAOBFFY++UT27Q66U6R3i0ckIYALpqN47kbA5XjEiuKzMG7sqIUnP9VTISJVWq6ZRVlV7jb7b0B4SDqO5V7ez7sDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720429920; c=relaxed/simple;
	bh=pT2sgtwPB+Rrdne7/SbeMYcVkvH7SkEAyY48lsxW8ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7x4s40A76lrreGiZlnri3JsIlD1QJwajXW6iXG3npjymbHu3pDzoQ/MK0knxH4PifjMFc9hzT1z39yq0PNH8HcNF6pqk77rhMkIz8xo8qvUF6tfCPyp9tW5xNr7oYrGp1WnG6z7wOupWTafDqwZqITGmI0Pmnsji9O2CEtE2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwPFU+0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420DFC4AF0A;
	Mon,  8 Jul 2024 09:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720429919;
	bh=pT2sgtwPB+Rrdne7/SbeMYcVkvH7SkEAyY48lsxW8ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jwPFU+0xi4bvGCirmq/hSMW6Fq3xMw5aXktER/ZZA1J/W1njpVKQouBMKZtsyg6ee
	 vD6SUXAeYbEHeM3+iLM/D5OrQnLa+CajPf8g6Xf7Ux1CzvJNv7yBUOFPpuyGIrZ4Mh
	 6Du3RGQOh04xgOcz3GIipuyjHCq16c7pmV6Fi9Hw+Gdqmq+WtBl61eAneTtAIUHVP6
	 intYC9sgoxZtj/4iB4vqv3uivs4dRUoiZ/dWnRJkPMOe5PKW8p0Ap4qd3OfSCEa5a+
	 gvNehP2MKRX3sik+Rfl8ZqdkbgDsodaIAgDmPWsWKCg0Z6j8EtkzzLL6FdtQAbq2+9
	 Aq4RgPwvpXC/A==
Date: Mon, 8 Jul 2024 10:11:55 +0100
From: Simon Horman <horms@kernel.org>
To: Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@raritan.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] net: ks8851: Fix deadlock with the SPI chip variant
Message-ID: <20240708091155.GI1481495@kernel.org>
References: <20240706101337.854474-1-rwahl@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706101337.854474-1-rwahl@gmx.de>

On Sat, Jul 06, 2024 at 12:13:37PM +0200, Ronald Wahl wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> When SMP is enabled and spinlocks are actually functional then there is
> a deadlock with the 'statelock' spinlock between ks8851_start_xmit_spi
> and ks8851_irq:
> 
>     watchdog: BUG: soft lockup - CPU#0 stuck for 27s!
>     call trace:
>       queued_spin_lock_slowpath+0x100/0x284
>       do_raw_spin_lock+0x34/0x44
>       ks8851_start_xmit_spi+0x30/0xb8
>       ks8851_start_xmit+0x14/0x20
>       netdev_start_xmit+0x40/0x6c
>       dev_hard_start_xmit+0x6c/0xbc
>       sch_direct_xmit+0xa4/0x22c
>       __qdisc_run+0x138/0x3fc
>       qdisc_run+0x24/0x3c
>       net_tx_action+0xf8/0x130
>       handle_softirqs+0x1ac/0x1f0
>       __do_softirq+0x14/0x20
>       ____do_softirq+0x10/0x1c
>       call_on_irq_stack+0x3c/0x58
>       do_softirq_own_stack+0x1c/0x28
>       __irq_exit_rcu+0x54/0x9c
>       irq_exit_rcu+0x10/0x1c
>       el1_interrupt+0x38/0x50
>       el1h_64_irq_handler+0x18/0x24
>       el1h_64_irq+0x64/0x68
>       __netif_schedule+0x6c/0x80
>       netif_tx_wake_queue+0x38/0x48
>       ks8851_irq+0xb8/0x2c8
>       irq_thread_fn+0x2c/0x74
>       irq_thread+0x10c/0x1b0
>       kthread+0xc8/0xd8
>       ret_from_fork+0x10/0x20
> 
> This issue has not been identified earlier because tests were done on
> a device with SMP disabled and so spinlocks were actually NOPs.
> 
> Now use spin_(un)lock_bh for TX queue related locking to avoid execution
> of softirq work synchronously that would lead to a deadlock.
> 
> Fixes: 3dc5d4454545 ("net: ks8851: Fix TX stall caused by TX buffer overrun")
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: stable@vger.kernel.org # 5.10+
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> ---
> V2: - use spin_lock_bh instead of moving netif_wake_queue outside of
>       locked region (doing the same in the start_xmit function)
>     - add missing net: tag
> 
> V3: - spin_lock_bh(ks->statelock) always except in xmit which is in BH
>       already

I agree that this lock is now always either taken _bh,
or in the xmit path which is executed in BH context.

Reviewed-by: Simon Horman <horms@kernel.org>


