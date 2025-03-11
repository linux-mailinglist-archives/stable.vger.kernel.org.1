Return-Path: <stable+bounces-124103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 761BBA5D0D0
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 21:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A728B17B7BD
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 20:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A98262D10;
	Tue, 11 Mar 2025 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BcMMOEHB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sSyHpxrb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BcMMOEHB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sSyHpxrb"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3313A3FD1
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741725223; cv=none; b=lK8PDcZIrU4VtlVBJrkLqMWGnSlXuUJeOJkS6sE6k7qihwgqhbvRrjNlivaHOs3dLInyjbU3vad6EgSc7DPWnBG7i8FsjywKWlsMETqoAW7hlhmL332fgJIzYG0sDolxSYGE/0MPg8ZSO2hhekk4j0SN7hFVPtpGNrNgeddeqd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741725223; c=relaxed/simple;
	bh=9TsvDHmZmvc1Ygvtzszo+OQhWEs8hLy2JQik//MYJFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPFh/NWiNLSpzI4GndH8BPlITDSNuVRgkQFtsiynoDPR5ma/gswPJyQYoGFAGxQoTc3e3HSMJKIrLSPvBQPMjWlbdtZW7O19I2pJ/YbCqe3LECn/RjSAgJLYBWxLOCalLm0jVfvBcXbp1Y7NUndameOoVOPNEoeHLDSWIEysdBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BcMMOEHB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sSyHpxrb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BcMMOEHB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sSyHpxrb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BC052111F;
	Tue, 11 Mar 2025 20:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741725219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pZCCQVBns7UtiRf06sGLeq1R5UiV8+AoaRWqx8lKCM=;
	b=BcMMOEHBDu46LFAVjZcTLAN/1fTREWKOkloAtdBIobPrDWYuV3FRR38hUhjFzkL200K+Pb
	f+27b5d29hAb5pHW3Yy8pN4MdAPx9KKhuO45jZ/cJutKPqetoQPxpNrNk4a1bwvXTxQcvB
	eISRoI8MAWmeb9Tj52dfXjRsCINVGAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741725219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pZCCQVBns7UtiRf06sGLeq1R5UiV8+AoaRWqx8lKCM=;
	b=sSyHpxrbU59cbQFWB8eAccPLhwD8F6M7PNyKxMcQnwlIvYBrDso+P3DBFEr4kfvncmBIFd
	oDUvxJ/4tvQNwMCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741725219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pZCCQVBns7UtiRf06sGLeq1R5UiV8+AoaRWqx8lKCM=;
	b=BcMMOEHBDu46LFAVjZcTLAN/1fTREWKOkloAtdBIobPrDWYuV3FRR38hUhjFzkL200K+Pb
	f+27b5d29hAb5pHW3Yy8pN4MdAPx9KKhuO45jZ/cJutKPqetoQPxpNrNk4a1bwvXTxQcvB
	eISRoI8MAWmeb9Tj52dfXjRsCINVGAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741725219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pZCCQVBns7UtiRf06sGLeq1R5UiV8+AoaRWqx8lKCM=;
	b=sSyHpxrbU59cbQFWB8eAccPLhwD8F6M7PNyKxMcQnwlIvYBrDso+P3DBFEr4kfvncmBIFd
	oDUvxJ/4tvQNwMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CBEC132CB;
	Tue, 11 Mar 2025 20:33:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uwWRCiOe0GdERgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 11 Mar 2025 20:33:39 +0000
Message-ID: <96e93e70-0d60-4ec4-a111-9eab58e8b3f9@suse.cz>
Date: Tue, 11 Mar 2025 21:33:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13.y] mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
Content-Language: en-US
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, stable@vger.kernel.org
Cc: Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
 Keith Busch <kbusch@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>
References: <20250311165944.151883-1-urezki@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250311165944.151883-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,nvidia.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/11/25 17:59, Uladzislau Rezki (Sony) wrote:

The first line of the changelog needs to say:

commit dfd3df31c9db752234d7d2e09bef2aeabb643ce4 upstream.

I think Greg prefers if you resend with that fixed rather than fixing up
locally.
If the same backport applies to both 6.12 and 6.13 (it seems to me it does?)
I guess a single mail with [PATCH 6.12.y 6.13.y] could be enough.

> Apart of that, since kvfree_rcu() does reclaim memory it is worth
> to go with WQ_MEM_RECLAIM type of wq because it is designed for
> this purpose.
> 
> Fixes: 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> Reported-by: Keith Busch <kbusch@kernel.org>
> Closes: https://lore.kernel.org/all/Z7iqJtCjHKfo8Kho@kbusch-mbp/
> Cc: stable@vger.kernel.org
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

I don't know if you need to add another
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

opinions on that differ and not sure where stable stands...
(does "git commit -s" add it or detects your previous one?)

Thanks!

> ---
>  kernel/rcu/tree.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ff98233d4aa5..4703b08fb882 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3191,6 +3191,8 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  }
>  EXPORT_SYMBOL_GPL(call_rcu);
>  
> +static struct workqueue_struct *rcu_reclaim_wq;
> +
>  /* Maximum number of jiffies to wait before draining a batch. */
>  #define KFREE_DRAIN_JIFFIES (5 * HZ)
>  #define KFREE_N_BATCHES 2
> @@ -3519,10 +3521,10 @@ __schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
>  	if (delayed_work_pending(&krcp->monitor_work)) {
>  		delay_left = krcp->monitor_work.timer.expires - jiffies;
>  		if (delay < delay_left)
> -			mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
> +			mod_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
>  		return;
>  	}
> -	queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
> +	queue_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
>  }
>  
>  static void
> @@ -3620,7 +3622,7 @@ kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
>  			// "free channels", the batch can handle. Break
>  			// the loop since it is done with this CPU thus
>  			// queuing an RCU work is _always_ success here.
> -			queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
> +			queued = queue_rcu_work(rcu_reclaim_wq, &krwp->rcu_work);
>  			WARN_ON_ONCE(!queued);
>  			break;
>  		}
> @@ -3708,7 +3710,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>  			!atomic_xchg(&krcp->work_in_progress, 1)) {
>  		if (atomic_read(&krcp->backoff_page_cache_fill)) {
> -			queue_delayed_work(system_unbound_wq,
> +			queue_delayed_work(rcu_reclaim_wq,
>  				&krcp->page_cache_work,
>  					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
>  		} else {
> @@ -5654,6 +5656,10 @@ static void __init kfree_rcu_batch_init(void)
>  	int i, j;
>  	struct shrinker *kfree_rcu_shrinker;
>  
> +	rcu_reclaim_wq = alloc_workqueue("kvfree_rcu_reclaim",
> +			WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
> +	WARN_ON(!rcu_reclaim_wq);
> +
>  	/* Clamp it to [0:100] seconds interval. */
>  	if (rcu_delay_page_cache_fill_msec < 0 ||
>  		rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {


