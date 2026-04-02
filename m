Return-Path: <stable+bounces-232881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAKTI5C3zWkLgAYAu9opvQ
	(envelope-from <stable+bounces-232881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 02:25:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 284F4381FAB
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 02:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0C493028EFD
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 00:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29B21A681B;
	Thu,  2 Apr 2026 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEZ7Hc1/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E0C19F40A
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089404; cv=none; b=V0qfDAEj+BqWWcnVqnLHzAGN6KwXjqn3SfcroqGaHDPZV52qaKr7n6077nBjG2m/j696G9XvfJFMMsvC4WTZnu3jHM4VNKhMlmyV84PiPkMq7Iiljz8qr61lbud3iWvbwpZckwJEmIXEDGekRgu7bNxsdKW1SKB7MpmD2x3gGrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089404; c=relaxed/simple;
	bh=CGT/imRWMLayIP/DpPFhdVRKaQAZWTTpuLFwoDPD3AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjhydAc4nJlZksOEGGKeX+wUDC53kNQCZlaV5IbfuOGwN7yjju6Ud8hE31zYrwMC9si8oW97ZwxW0ukjHZK78hilfJFjbfN3YlKnHpNlpPy3ELuKw5/rl8HnJsv1LujOaw6s3352f8A8v4yp/A5Y4/2Z67glJ1Vo8RdvbLYlCj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEZ7Hc1/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775089402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PzNZ1nRlwt+/i/wv4JFJx6Vf7hfHjWTodzEqkmNDe40=;
	b=iEZ7Hc1/e0iIYdIU+5xt4Yszds7yYoh5cyIxyoUDJSMNRw2JF/VlFp73u393zMjDRBCrvx
	p4bLZu+sE94G+O7ou/y7W5Ipfu2SynKOkDYALZ0RoHdZsh5cUXa7f8JPD4F5iceLXaYt01
	L/luXab94cEWuDXou/VJoQ8NR/TF9uU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-BfNY1WboPXSfQepN6-Eqwg-1; Wed,
 01 Apr 2026 20:23:18 -0400
X-MC-Unique: BfNY1WboPXSfQepN6-Eqwg-1
X-Mimecast-MFC-AGG-ID: BfNY1WboPXSfQepN6-Eqwg_1775089397
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EFA1180035C;
	Thu,  2 Apr 2026 00:23:17 +0000 (UTC)
Received: from localhost (unknown [10.72.112.46])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C46431800361;
	Thu,  2 Apr 2026 00:23:15 +0000 (UTC)
Date: Thu, 2 Apr 2026 08:23:10 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
	lirongqing <lirongqing@baidu.com>
Subject: Re: [PATCH v3] mm/vmalloc: Use dedicated unbound workqueues for vmap
 drain
Message-ID: <ac227uLhjH8pETb5@fedora>
References: <20260331202352.879718-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331202352.879718-1-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-232881-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhe@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.955];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 284F4381FAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/31/26 at 10:23pm, Uladzislau Rezki (Sony) wrote:
> drain_vmap_area_work() function can take >10ms to complete
> when there are many accumulated vmap areas in a system with
> high CPU count, causing workqueue watchdog warnings when run
> via schedule_work():
> 
>   workqueue: drain_vmap_area_work hogged CPU for >10000us
> 
> Move the top-level drain work to a dedicated WQ_UNBOUND
> workqueue so the scheduler can run this background work
> on any available CPU, improving responsiveness. Use the
> WQ_MEM_RECLAIM to ensure forward progress under memory
> pressure.
> 
> Move purge helpers to separate WQ_UNBOUND | WQ_MEM_RECLAIM
> workqueue. This allows drain_vmap_work to wait for helpers
> completion without creating dependency on the same rescuer
> thread and avoid a potential parent/child deadlock.
> 
> Simplify purge helper scheduling by removing cpumask-based
> iteration to iterating directly over vmap nodes checking
> work_queued state.
> 
> Cc: stable@vger.kernel.org
> Cc: lirongqing <lirongqing@baidu.com>
> Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
> Link: https://lore.kernel.org/all/20260319074307.2325-1-lirongqing@baidu.com/
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 79 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 52 insertions(+), 27 deletions(-)

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 61caa55a4402..0fa1208a910b 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -949,6 +949,7 @@ static struct vmap_node {
>  	struct list_head purge_list;
>  	struct work_struct purge_work;
>  	unsigned long nr_purged;
> +	bool work_queued;
>  } single;
>  
>  /*
> @@ -1067,6 +1068,8 @@ static void reclaim_and_purge_vmap_areas(void);
>  static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
>  static void drain_vmap_area_work(struct work_struct *work);
>  static DECLARE_WORK(drain_vmap_work, drain_vmap_area_work);
> +static struct workqueue_struct *drain_vmap_helpers_wq;
> +static struct workqueue_struct *drain_vmap_wq;
>  
>  static __cacheline_aligned_in_smp atomic_long_t nr_vmalloc_pages;
>  static __cacheline_aligned_in_smp atomic_long_t vmap_lazy_nr;
> @@ -2335,6 +2338,16 @@ static void purge_vmap_node(struct work_struct *work)
>  	reclaim_list_global(&local_list);
>  }
>  
> +static bool
> +schedule_drain_vmap_work(struct workqueue_struct *wq,
> +		struct work_struct *work)
> +{
> +	if (wq)
> +		return queue_work(wq, work);
> +
> +	return false;
> +}
> +
>  /*
>   * Purges all lazily-freed vmap areas.
>   */
> @@ -2342,19 +2355,12 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
>  		bool full_pool_decay)
>  {
>  	unsigned long nr_purged_areas = 0;
> +	unsigned int nr_purge_nodes = 0;
>  	unsigned int nr_purge_helpers;
> -	static cpumask_t purge_nodes;
> -	unsigned int nr_purge_nodes;
>  	struct vmap_node *vn;
> -	int i;
>  
>  	lockdep_assert_held(&vmap_purge_lock);
>  
> -	/*
> -	 * Use cpumask to mark which node has to be processed.
> -	 */
> -	purge_nodes = CPU_MASK_NONE;
> -
>  	for_each_vmap_node(vn) {
>  		INIT_LIST_HEAD(&vn->purge_list);
>  		vn->skip_populate = full_pool_decay;
> @@ -2374,10 +2380,9 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
>  		end = max(end, list_last_entry(&vn->purge_list,
>  			struct vmap_area, list)->va_end);
>  
> -		cpumask_set_cpu(node_to_id(vn), &purge_nodes);
> +		nr_purge_nodes++;
>  	}
>  
> -	nr_purge_nodes = cpumask_weight(&purge_nodes);
>  	if (nr_purge_nodes > 0) {
>  		flush_tlb_kernel_range(start, end);
>  
> @@ -2385,29 +2390,31 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
>  		nr_purge_helpers = atomic_long_read(&vmap_lazy_nr) / lazy_max_pages();
>  		nr_purge_helpers = clamp(nr_purge_helpers, 1U, nr_purge_nodes) - 1;
>  
> -		for_each_cpu(i, &purge_nodes) {
> -			vn = &vmap_nodes[i];
> +		for_each_vmap_node(vn) {
> +			vn->work_queued = false;
> +
> +			if (list_empty(&vn->purge_list))
> +				continue;
>  
>  			if (nr_purge_helpers > 0) {
>  				INIT_WORK(&vn->purge_work, purge_vmap_node);
> +				vn->work_queued = schedule_drain_vmap_work(
> +					READ_ONCE(drain_vmap_helpers_wq), &vn->purge_work);
>  
> -				if (cpumask_test_cpu(i, cpu_online_mask))
> -					schedule_work_on(i, &vn->purge_work);
> -				else
> -					schedule_work(&vn->purge_work);
> -
> -				nr_purge_helpers--;
> -			} else {
> -				vn->purge_work.func = NULL;
> -				purge_vmap_node(&vn->purge_work);
> -				nr_purged_areas += vn->nr_purged;
> +				if (vn->work_queued) {
> +					nr_purge_helpers--;
> +					continue;
> +				}
>  			}
> -		}
>  
> -		for_each_cpu(i, &purge_nodes) {
> -			vn = &vmap_nodes[i];
> +			/* Sync path. Process locally. */
> +			purge_vmap_node(&vn->purge_work);
> +			nr_purged_areas += vn->nr_purged;
> +		}
>  
> -			if (vn->purge_work.func) {
> +		/* Wait for completion if queued any. */
> +		for_each_vmap_node(vn) {
> +			if (vn->work_queued) {
>  				flush_work(&vn->purge_work);
>  				nr_purged_areas += vn->nr_purged;
>  			}
> @@ -2471,7 +2478,8 @@ static void free_vmap_area_noflush(struct vmap_area *va)
>  
>  	/* After this point, we may free va at any time */
>  	if (unlikely(nr_lazy > nr_lazy_max))
> -		schedule_work(&drain_vmap_work);
> +		schedule_drain_vmap_work(READ_ONCE(drain_vmap_wq),
> +			&drain_vmap_work);
>  }
>  
>  /*
> @@ -5483,3 +5491,20 @@ void __init vmalloc_init(void)
>  	vmap_node_shrinker->scan_objects = vmap_node_shrink_scan;
>  	shrinker_register(vmap_node_shrinker);
>  }
> +
> +static int __init vmalloc_init_workqueue(void)
> +{
> +	struct workqueue_struct *drain_wq, *helpers_wq;
> +	unsigned int flags = WQ_UNBOUND | WQ_MEM_RECLAIM;
> +
> +	drain_wq = alloc_workqueue("vmap_drain", flags, 0);
> +	WARN_ON_ONCE(drain_wq == NULL);
> +	WRITE_ONCE(drain_vmap_wq, drain_wq);
> +
> +	helpers_wq = alloc_workqueue("vmap_drain_helpers", flags, 0);
> +	WARN_ON_ONCE(helpers_wq == NULL);
> +	WRITE_ONCE(drain_vmap_helpers_wq, helpers_wq);
> +
> +	return 0;
> +}
> +early_initcall(vmalloc_init_workqueue);
> -- 
> 2.47.3
> 


