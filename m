Return-Path: <stable+bounces-124040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E262FA5CA61
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1283B0A23
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8049825B68E;
	Tue, 11 Mar 2025 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vmF/Q4f1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YdlE6pWo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vmF/Q4f1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YdlE6pWo"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51B1917F4
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709394; cv=none; b=nacM5pnF58iGyngKiP1frEPxOiicTdSAWlzzpK0GTxqxwSM1lqdEOeUo8cFGbvuocOnvTG/PfKWBMnabdCMcPGLSr6JBZc8Njl2CKMta7q6DBDzjtFdpbbLST+9bIs6gAZeEm46vJaT8FGVLqg4dO0IHm3SiO27YTeFgM0ogb8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709394; c=relaxed/simple;
	bh=/rx+xChyNLok1wjk2Dawul8K5RytW7b38dmMeLL22HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmWM4O16MaGoIlIohR7T9f95HHc+Wmh1mSp3CcVEns+dXLKWTtnc3kTz3gj0ckcneOf/B8031CjMlAKL7CWk/7829YUS7Z2nsyJLkSNrzcG9A7VR3nRY32sVpvDydxVTSUtXNsEDotsDRyRoui0t/WAWSqk5l1RN4zL1PzQNZ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vmF/Q4f1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YdlE6pWo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vmF/Q4f1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YdlE6pWo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA01F1F38F;
	Tue, 11 Mar 2025 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741709390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRueIo77ZiVJ+5E8JzGhV+iNQQKg5omvZK+He5/bB0g=;
	b=vmF/Q4f1n0rDrd7eXxJvdGAO37HwPLDRW+s/49xfC7QB2VDAMqyMyFtCrZSRF0UbNgp5x/
	ozPvqPVZ6tgqJWJpVLiUKQkiYEniaIm+c0DphVUyK1BJENPInBji9Sv2MaU9cJ00AyIrLc
	EnH+MaF49sb+zEWX5KJfgnES7aEV60w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741709390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRueIo77ZiVJ+5E8JzGhV+iNQQKg5omvZK+He5/bB0g=;
	b=YdlE6pWoSGFrw03Sy0j7+8KwKseBJwxX8Iyf8RIHacuVILIQmENdoxxDJlE0fe9iUS9c0d
	s+TGQi8+EtGN/SDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741709390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRueIo77ZiVJ+5E8JzGhV+iNQQKg5omvZK+He5/bB0g=;
	b=vmF/Q4f1n0rDrd7eXxJvdGAO37HwPLDRW+s/49xfC7QB2VDAMqyMyFtCrZSRF0UbNgp5x/
	ozPvqPVZ6tgqJWJpVLiUKQkiYEniaIm+c0DphVUyK1BJENPInBji9Sv2MaU9cJ00AyIrLc
	EnH+MaF49sb+zEWX5KJfgnES7aEV60w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741709390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRueIo77ZiVJ+5E8JzGhV+iNQQKg5omvZK+He5/bB0g=;
	b=YdlE6pWoSGFrw03Sy0j7+8KwKseBJwxX8Iyf8RIHacuVILIQmENdoxxDJlE0fe9iUS9c0d
	s+TGQi8+EtGN/SDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACCE9134A0;
	Tue, 11 Mar 2025 16:09:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NLfsKU5g0GdGegAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 11 Mar 2025 16:09:50 +0000
Message-ID: <5ba8803f-4208-4f84-b24c-ea2cc8539849@suse.cz>
Date: Tue, 11 Mar 2025 17:11:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] mm/slab/kvfree_rcu: Switch to
 WQ_MEM_RECLAIM wq" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, urezki@gmail.com, joelagnelf@nvidia.com,
 kbusch@kernel.org
Cc: stable@vger.kernel.org
References: <2025030914-turtle-tattered-27c6@gregkh>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <2025030914-turtle-tattered-27c6@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com,nvidia.com,kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,imap1.dmz-prg2.suse.org:helo,linuxfoundation.org:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 3/9/25 7:16 PM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Must be the code move from rcu to slab. Ulad, will you handle this, or
should I? Thanks.

Vlastimil

> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x dfd3df31c9db752234d7d2e09bef2aeabb643ce4
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030914-turtle-tattered-27c6@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From dfd3df31c9db752234d7d2e09bef2aeabb643ce4 Mon Sep 17 00:00:00 2001
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> Date: Fri, 28 Feb 2025 13:13:56 +0100
> Subject: [PATCH] mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
> 
> Currently kvfree_rcu() APIs use a system workqueue which is
> "system_unbound_wq" to driver RCU machinery to reclaim a memory.
> 
> Recently, it has been noted that the following kernel warning can
> be observed:
> 
> <snip>
> workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
>   WARNING: CPU: 21 PID: 330 at kernel/workqueue.c:3719 check_flush_dependency+0x112/0x120
>   Modules linked in: intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) ...
>   CPU: 21 UID: 0 PID: 330 Comm: kworker/u144:6 Tainted: G            E      6.13.2-0_g925d379822da #1
>   Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM20 02/01/2023
>   Workqueue: nvme-wq nvme_scan_work
>   RIP: 0010:check_flush_dependency+0x112/0x120
>   Code: 05 9a 40 14 02 01 48 81 c6 c0 00 00 00 48 8b 50 18 48 81 c7 c0 00 00 00 48 89 f9 48 ...
>   RSP: 0018:ffffc90000df7bd8 EFLAGS: 00010082
>   RAX: 000000000000006a RBX: ffffffff81622390 RCX: 0000000000000027
>   RDX: 00000000fffeffff RSI: 000000000057ffa8 RDI: ffff88907f960c88
>   RBP: 0000000000000000 R08: ffffffff83068e50 R09: 000000000002fffd
>   R10: 0000000000000004 R11: 0000000000000000 R12: ffff8881001a4400
>   R13: 0000000000000000 R14: ffff88907f420fb8 R15: 0000000000000000
>   FS:  0000000000000000(0000) GS:ffff88907f940000(0000) knlGS:0000000000000000
>   CR2: 00007f60c3001000 CR3: 000000107d010005 CR4: 00000000007726f0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    ? __warn+0xa4/0x140
>    ? check_flush_dependency+0x112/0x120
>    ? report_bug+0xe1/0x140
>    ? check_flush_dependency+0x112/0x120
>    ? handle_bug+0x5e/0x90
>    ? exc_invalid_op+0x16/0x40
>    ? asm_exc_invalid_op+0x16/0x20
>    ? timer_recalc_next_expiry+0x190/0x190
>    ? check_flush_dependency+0x112/0x120
>    ? check_flush_dependency+0x112/0x120
>    __flush_work.llvm.1643880146586177030+0x174/0x2c0
>    flush_rcu_work+0x28/0x30
>    kvfree_rcu_barrier+0x12f/0x160
>    kmem_cache_destroy+0x18/0x120
>    bioset_exit+0x10c/0x150
>    disk_release.llvm.6740012984264378178+0x61/0xd0
>    device_release+0x4f/0x90
>    kobject_put+0x95/0x180
>    nvme_put_ns+0x23/0xc0
>    nvme_remove_invalid_namespaces+0xb3/0xd0
>    nvme_scan_work+0x342/0x490
>    process_scheduled_works+0x1a2/0x370
>    worker_thread+0x2ff/0x390
>    ? pwq_release_workfn+0x1e0/0x1e0
>    kthread+0xb1/0xe0
>    ? __kthread_parkme+0x70/0x70
>    ret_from_fork+0x30/0x40
>    ? __kthread_parkme+0x70/0x70
>    ret_from_fork_asm+0x11/0x20
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
> <snip>
> 
> To address this switch to use of independent WQ_MEM_RECLAIM
> workqueue, so the rules are not violated from workqueue framework
> point of view.
> 
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
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 4030907b6b7d..4c9f0a87f733 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1304,6 +1304,8 @@ module_param(rcu_min_cached_objs, int, 0444);
>  static int rcu_delay_page_cache_fill_msec = 5000;
>  module_param(rcu_delay_page_cache_fill_msec, int, 0444);
>  
> +static struct workqueue_struct *rcu_reclaim_wq;
> +
>  /* Maximum number of jiffies to wait before draining a batch. */
>  #define KFREE_DRAIN_JIFFIES (5 * HZ)
>  #define KFREE_N_BATCHES 2
> @@ -1632,10 +1634,10 @@ __schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
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
> @@ -1733,7 +1735,7 @@ kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
>  			// "free channels", the batch can handle. Break
>  			// the loop since it is done with this CPU thus
>  			// queuing an RCU work is _always_ success here.
> -			queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
> +			queued = queue_rcu_work(rcu_reclaim_wq, &krwp->rcu_work);
>  			WARN_ON_ONCE(!queued);
>  			break;
>  		}
> @@ -1883,7 +1885,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>  			!atomic_xchg(&krcp->work_in_progress, 1)) {
>  		if (atomic_read(&krcp->backoff_page_cache_fill)) {
> -			queue_delayed_work(system_unbound_wq,
> +			queue_delayed_work(rcu_reclaim_wq,
>  				&krcp->page_cache_work,
>  					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
>  		} else {
> @@ -2120,6 +2122,10 @@ void __init kvfree_rcu_init(void)
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
> 


