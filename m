Return-Path: <stable+bounces-211317-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFS+FeSdcmkFnAAAu9opvQ
	(envelope-from <stable+bounces-211317-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 23:00:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 870456E005
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 23:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78253301B168
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 22:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F248212548;
	Thu, 22 Jan 2026 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GqmdQDdW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6789930DD1D;
	Thu, 22 Jan 2026 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119194; cv=none; b=hJD20mNRKPN2R/cXHU7aKKkj02M9UhGJHbipQN+kno7rFD5LxB39jeTb7pD2UrazGVUSe61RA00pf5PxW3PoD58a0wRyIO3mT4wsehmbCN9tIOlaRZEXlzwmv7F6ktXZae9zg6mbznLmbwRLmC0FJzVoK+t/8YHe93Spv/7rGHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119194; c=relaxed/simple;
	bh=t8y7aUQcU/qiqgYFpCKSJRRYf13Se/dbEuith7oxcEk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IyZVp41yuPl0ZQduUVR8NehcWjrbD8vpXZA4iXSOKaDZQEoUkzg1BQUddbSrfFtdT9XcQ2k+ZgeCCqSEdEk4OKNAeKSanpZKFDrOXWQRr6pow0J+Ce/pZ7f6Z1Xa7ZXBqdgmxOfVFTEpoKQj1PySDOFW7A/i1ArBuiSXA80KN2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GqmdQDdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849FFC116D0;
	Thu, 22 Jan 2026 21:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769119193;
	bh=t8y7aUQcU/qiqgYFpCKSJRRYf13Se/dbEuith7oxcEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GqmdQDdWpUV1+NT/kFUTO7fq9v+oatrAe0T1+aQUisPlqvNiSXIWP6557agpcvHBV
	 74polR+JjBtuzM+yPqkyF2KK4mhM4uyG7N3eQUBjD3zoKnLU5toVqPs8IpV8Kc4eob
	 uX5lAEjvz/8e69dKGQSd9ICkCiH+DJOTUSWB020k=
Date: Thu, 22 Jan 2026 13:59:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: lihuafei1@huawei.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
 sunshx@chinatelecom.cn, thorsten.blum@linux.dev, wangjinchao600@gmail.com,
 yangyicong@hisilicon.com, yuanql9@chinatelecom.cn,
 zhangjn11@chinatelecom.cn, stable@vger.kernel.org, Song Liu
 <song@kernel.org>, Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] watchdog/hardlockup: Fix UAF in perf event cleanup
 due to migration race
Message-Id: <20260122135951.68ca60cf6ca3d90314306552@linux-foundation.org>
In-Reply-To: <20260122052442.667394-1-realwujing@gmail.com>
References: <20260122042717.657231-1-realwujing@gmail.com>
	<20260122052442.667394-1-realwujing@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-211317-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,kernel.org,vger.kernel.org,chinatelecom.cn,linux.dev,gmail.com,hisilicon.com,chromium.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:mid,linux-foundation.org:dkim,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 870456E005
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 00:24:42 -0500 Qiliang Yuan <realwujing@gmail.com> wrote:

> During the early initialization of the hardlockup detector, the
> hardlockup_detector_perf_init() function probes for PMU hardware availability.
> It originally used hardlockup_detector_event_create(), which interacts with
> the per-cpu 'watchdog_ev' variable.

Thanks.

For a -stable backport it's desirable to have a Fixes: target.  But it
appears this is very old code?

Also, I'm not sure who best to ask to help review this change.  I'll
add a few cc's here.

[full email retained...]

> If the initializing task migrates to another CPU during this probe phase,
> two issues arise:
> 1. The 'watchdog_ev' pointer on the original CPU is set but not cleared,
>    leaving a stale pointer to a freed perf event.
> 2. The 'watchdog_ev' pointer on the new CPU might be incorrectly cleared.
> 
> This race condition was observed in console logs (captured by adding debug printks):
> 
> [23.038376] hardlockup_detector_perf_init 313 cur_cpu=2
> ...
> [23.076385] hardlockup_detector_event_create 203 cpu(cur)=2 set watchdog_ev
> ...
> [23.095788] perf_event_release_kernel 4623 cur_cpu=2
> ...
> [23.116963] lockup_detector_reconfigure 577 cur_cpu=3
> 
> The log shows the task started on CPU 2, set watchdog_ev on CPU 2,
> released the event on CPU 2, but then migrated to CPU 3 before the
> cleanup logic (which would clear watchdog_ev) could run. This left
> watchdog_ev on CPU 2 pointing to a freed event.
> 
> Later, when the watchdog is enabled/disabled on CPU 2, this stale pointer
> leads to a Use-After-Free (UAF) in perf_event_disable(), as detected by KASAN:
> [26.539140] ==================================================================
> [26.540732] BUG: KASAN: use-after-free in perf_event_ctx_lock_nested.isra.72+0x6b/0x140
> [26.542442] Read of size 8 at addr ff110006b360d718 by task kworker/2:1/94
> [26.543954]
> [26.544744] CPU: 2 PID: 94 Comm: kworker/2:1 Not tainted 4.19.90-debugkasan #11
> [26.546505] Hardware name: GoStack Foundation OpenStack Nova, BIOS 1.16.3-3.ctl3 04/01/2014
> [26.548256] Workqueue: events smp_call_on_cpu_callback
> [26.549267] Call Trace:
> [26.549936]  dump_stack+0x8b/0xbb
> [26.550731]  print_address_description+0x6a/0x270
> [26.551688]  kasan_report+0x179/0x2c0
> [26.552519]  ? perf_event_ctx_lock_nested.isra.72+0x6b/0x140
> [26.553654]  ? watchdog_disable+0x80/0x80
> [26.553657]  perf_event_ctx_lock_nested.isra.72+0x6b/0x140
> [26.556951]  ? dump_stack+0xa0/0xbb
> [26.564006]  ? watchdog_disable+0x80/0x80
> [26.564886]  perf_event_disable+0xa/0x30
> [26.565746]  hardlockup_detector_perf_disable+0x1b/0x60
> [26.566776]  watchdog_disable+0x51/0x80
> [26.567624]  softlockup_stop_fn+0x11/0x20
> [26.568499]  smp_call_on_cpu_callback+0x5b/0xb0
> [26.569443]  process_one_work+0x389/0x770
> [26.570311]  worker_thread+0x57/0x5a0
> [26.571124]  ? process_one_work+0x770/0x770
> [26.572031]  kthread+0x1ae/0x1d0
> [26.572810]  ? kthread_create_worker_on_cpu+0xc0/0xc0
> [26.573821]  ret_from_fork+0x1f/0x40
> [26.574638]
> [26.575178] Allocated by task 1:
> [26.575990]  kasan_kmalloc+0xa0/0xd0
> [26.576814]  kmem_cache_alloc_trace+0xf3/0x1e0
> [26.577732]  perf_event_alloc.part.89+0xb5/0x12b0
> [26.578700]  perf_event_create_kernel_counter+0x1e/0x1d0
> [26.579728]  hardlockup_detector_event_create+0x4e/0xc0
> [26.580744]  hardlockup_detector_perf_init+0x2f/0x60
> [26.581746]  lockup_detector_init+0x85/0xdc
> [26.582645]  kernel_init_freeable+0x34d/0x40e
> [26.583568]  kernel_init+0xf/0x130
> [26.584428]  ret_from_fork+0x1f/0x40
> [26.584429]
> [26.584430] Freed by task 0:
> [26.584433]  __kasan_slab_free+0x130/0x180
> [26.584436]  kfree+0x90/0x1a0
> [26.589641]  rcu_process_callbacks+0x2cb/0x6e0
> [26.590935]  __do_softirq+0x119/0x3a2
> [26.591965]
> [26.592630] The buggy address belongs to the object at ff110006b360d500
> [26.592630]  which belongs to the cache kmalloc-2048 of size 2048
> [26.592633] The buggy address is located 536 bytes inside of
> [26.592633]  2048-byte region [ff110006b360d500, ff110006b360dd00)
> [26.592634] The buggy address belongs to the page:
> [26.592637] page:ffd400001acd8200 count:1 mapcount:0 mapping:ff11000107c0e800 index:0x0 compound_mapcount: 0
> [26.600959] flags: 0x17ffffc0010200(slab|head)
> [26.601891] raw: 0017ffffc0010200 dead000000000100 dead000000000200 ff11000107c0e800
> [26.603541] raw: 0000000000000000 00000000800f000f 00000001ffffffff 0000000000000000
> [26.605546] page dumped because: kasan: bad access detected
> [26.606788]
> [26.607351] Memory state around the buggy address:
> [26.608556]  ff110006b360d600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [26.610565]  ff110006b360d680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [26.610567] >ff110006b360d700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [26.610568]                             ^
> [26.610570]  ff110006b360d780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [26.610573]  ff110006b360d800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [26.618955] ==================================================================
> 
> Fix this by making the probe logic stateless. Use a local variable for the
> perf event and avoid accessing the per-cpu 'watchdog_ev' during initialization.
> This ensures that the probe event is always properly released regardless of
> task migration, and no stale global state is left behind.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Shouxin Sun <sunshx@chinatelecom.cn>
> Signed-off-by: Junnan Zhang <zhangjn11@chinatelecom.cn>
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> ---
> v2:
> - Add Cc: stable@vger.kernel.org tag.
> ---
>  kernel/watchdog_perf.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
> index d3ca70e3c256..5066be7bba03 100644
> --- a/kernel/watchdog_perf.c
> +++ b/kernel/watchdog_perf.c
> @@ -264,18 +264,38 @@ bool __weak __init arch_perf_nmi_is_available(void)
>  int __init watchdog_hardlockup_probe(void)
>  {
>  	int ret;
> +	struct perf_event_attr *wd_attr = &wd_hw_attr;
> +	struct perf_event *evt;
> +	unsigned int cpu;
>  
>  	if (!arch_perf_nmi_is_available())
>  		return -ENODEV;
>  
> -	ret = hardlockup_detector_event_create();
> +	/*
> +	 * Test hardware PMU availability. Avoid using
> +	 * hardlockup_detector_event_create() to prevent migration-related
> +	 * stale pointers in the per-cpu watchdog_ev during early probe.
> +	 */
> +	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
> +	if (!wd_attr->sample_period)
> +		return -EINVAL;
>  
> -	if (ret) {
> +	/*
> +	 * Use raw_smp_processor_id() for probing in preemptible init code.
> +	 * Migration after reading ID is acceptable as counter creation on
> +	 * the old CPU is sufficient for the probe.
> +	 */
> +	cpu = raw_smp_processor_id();
> +	evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
> +					       watchdog_overflow_callback, NULL);
> +	if (IS_ERR(evt)) {
>  		pr_info("Perf NMI watchdog permanently disabled\n");
> +		ret = PTR_ERR(evt);
>  	} else {
> -		perf_event_release_kernel(this_cpu_read(watchdog_ev));
> -		this_cpu_write(watchdog_ev, NULL);
> +		perf_event_release_kernel(evt);
> +		ret = 0;
>  	}
> +
>  	return ret;
>  }
>  
> -- 
> 2.51.0

