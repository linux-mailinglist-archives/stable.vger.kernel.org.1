Return-Path: <stable+bounces-120249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36364A4E296
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F3A881CAD
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0982066DA;
	Tue,  4 Mar 2025 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fde/bJwf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6463025FA2C;
	Tue,  4 Mar 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100134; cv=none; b=HQjKGuJpWg9X3T6jOJ+cCQ+ousf4Izqi4RTF7k7qLxPR09lyzVwv65oMz555FvNdfy26u97ZUgoa6sx+FRB1/Yh6gR5QBbvFdtxHCE24KO6+gHVMho0VMkd6//ZuvP9dPCSqkj46QCfuyvT0UQJlIO9QK2sxYJs7cVgSsipXn9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100134; c=relaxed/simple;
	bh=21/+tTReVZYvj3YaSc8NqoDvZVmfhekN36NcOLoxLwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDiCdsqW9t/ZEr8DlEJboarYtfSxKlpsRVwdntLNH+HVMkw4w70LAhcxl7LStFVd5XS32+VUgWNMibMIz+Cttn9vp2DbNkhwuFErWVBCxs2xR6+1qtuAZzmcjziwG7dc/IP0imsDOqxpkHNEKMgMGDPc0rSRn9Bfi5CFg1cUdNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fde/bJwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D395EC4CEE5;
	Tue,  4 Mar 2025 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741100133;
	bh=21/+tTReVZYvj3YaSc8NqoDvZVmfhekN36NcOLoxLwk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fde/bJwfid4Bvg9Rf1K+unyrTTS4ahPqPaVQaw+O4gR7RTjOtx0kHnb+w7XhwNI/0
	 2uJzM4oX/4e811tBSQlgF+KA+VQjZpsVRfZQwbEQSfQEX6J0vF01yDmwt+dAg6XvSA
	 cNIe+c5DcIFY1cgk5zn/c4dFhlQgSJyo80hrDtiHlQH1fw8bw4yhBNtijapcp6B4zK
	 cTweeFAgoSbbJAvXmispCWHDG3muyms8yoEuQ+7qO4Xj2sW5AJbfFOFrbIoR/YemZF
	 ntNuJmSlcG/rWGWgFTXsoh1WKKrRExceq+iZfsPojEf6iQiWt6dUtxC+lllxido3bQ
	 dPNhqrHpanUkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 70480CE12E4; Tue,  4 Mar 2025 06:55:33 -0800 (PST)
Date: Tue, 4 Mar 2025 06:55:33 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v1 2/2] mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
Message-ID: <14b61981-35ae-4f87-8341-b8d484123e56@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250228121356.336871-1-urezki@gmail.com>
 <20250228121356.336871-2-urezki@gmail.com>
 <20250303160824.GA22541@joelnvbox>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303160824.GA22541@joelnvbox>

On Mon, Mar 03, 2025 at 11:08:24AM -0500, Joel Fernandes wrote:
> On Fri, Feb 28, 2025 at 01:13:56PM +0100, Uladzislau Rezki (Sony) wrote:
> > Currently kvfree_rcu() APIs use a system workqueue which is
> > "system_unbound_wq" to driver RCU machinery to reclaim a memory.
> > 
> > Recently, it has been noted that the following kernel warning can
> > be observed:
> > 
> > <snip>
> > workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
> >   WARNING: CPU: 21 PID: 330 at kernel/workqueue.c:3719 check_flush_dependency+0x112/0x120
> >   Modules linked in: intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) ...
> >   CPU: 21 UID: 0 PID: 330 Comm: kworker/u144:6 Tainted: G            E      6.13.2-0_g925d379822da #1
> >   Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM20 02/01/2023
> >   Workqueue: nvme-wq nvme_scan_work
> >   RIP: 0010:check_flush_dependency+0x112/0x120
> >   Code: 05 9a 40 14 02 01 48 81 c6 c0 00 00 00 48 8b 50 18 48 81 c7 c0 00 00 00 48 89 f9 48 ...
> >   RSP: 0018:ffffc90000df7bd8 EFLAGS: 00010082
> >   RAX: 000000000000006a RBX: ffffffff81622390 RCX: 0000000000000027
> >   RDX: 00000000fffeffff RSI: 000000000057ffa8 RDI: ffff88907f960c88
> >   RBP: 0000000000000000 R08: ffffffff83068e50 R09: 000000000002fffd
> >   R10: 0000000000000004 R11: 0000000000000000 R12: ffff8881001a4400
> >   R13: 0000000000000000 R14: ffff88907f420fb8 R15: 0000000000000000
> >   FS:  0000000000000000(0000) GS:ffff88907f940000(0000) knlGS:0000000000000000
> >   CR2: 00007f60c3001000 CR3: 000000107d010005 CR4: 00000000007726f0
> >   PKRU: 55555554
> >   Call Trace:
> >    <TASK>
> >    ? __warn+0xa4/0x140
> >    ? check_flush_dependency+0x112/0x120
> >    ? report_bug+0xe1/0x140
> >    ? check_flush_dependency+0x112/0x120
> >    ? handle_bug+0x5e/0x90
> >    ? exc_invalid_op+0x16/0x40
> >    ? asm_exc_invalid_op+0x16/0x20
> >    ? timer_recalc_next_expiry+0x190/0x190
> >    ? check_flush_dependency+0x112/0x120
> >    ? check_flush_dependency+0x112/0x120
> >    __flush_work.llvm.1643880146586177030+0x174/0x2c0
> >    flush_rcu_work+0x28/0x30
> >    kvfree_rcu_barrier+0x12f/0x160
> >    kmem_cache_destroy+0x18/0x120
> >    bioset_exit+0x10c/0x150
> >    disk_release.llvm.6740012984264378178+0x61/0xd0
> >    device_release+0x4f/0x90
> >    kobject_put+0x95/0x180
> >    nvme_put_ns+0x23/0xc0
> >    nvme_remove_invalid_namespaces+0xb3/0xd0
> >    nvme_scan_work+0x342/0x490
> >    process_scheduled_works+0x1a2/0x370
> >    worker_thread+0x2ff/0x390
> >    ? pwq_release_workfn+0x1e0/0x1e0
> >    kthread+0xb1/0xe0
> >    ? __kthread_parkme+0x70/0x70
> >    ret_from_fork+0x30/0x40
> >    ? __kthread_parkme+0x70/0x70
> >    ret_from_fork_asm+0x11/0x20
> >    </TASK>
> >   ---[ end trace 0000000000000000 ]---
> > <snip>
> > 
> > To address this switch to use of independent WQ_MEM_RECLAIM
> > workqueue, so the rules are not violated from workqueue framework
> > point of view.
> > 
> > Apart of that, since kvfree_rcu() does reclaim memory it is worth
> > to go with WQ_MEM_RECLAIM type of wq because it is designed for
> > this purpose.
> > 
> > Cc: <stable@vger.kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Keith Busch <kbusch@kernel.org>
> > Closes: https://www.spinics.net/lists/kernel/msg5563270.html
> > Fixes: 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> > Reported-by: Keith Busch <kbusch@kernel.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> BTW, there is a path in RCU-tasks that involves queuing work on system_wq
> which is !WQ_RECLAIM. While I don't anticipate an issue such as the one fixed
> by this patch, I am wondering if we should move these to their own WQ_RECLAIM
> queues for added robustness since otherwise that will result in CB invocation
> (And thus memory freeing delays). Paul?

For RCU Tasks, the memory traffic has been much lower.  But maybe someday
someone will drop a million trampolines all at once.  But let's see that
problem before we fix some random problem that we believe will happen,
but which proves to be only slightly related to the problem that actually
does happen.  ;-)

							Thanx, Paul

> kernel/rcu/tasks.h:       queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
> kernel/rcu/tasks.h:       queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
> 
> For this patch:
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> thanks,
> 
>  - Joel
> 
> 
> > ---
> >  mm/slab_common.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 4030907b6b7d..4c9f0a87f733 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1304,6 +1304,8 @@ module_param(rcu_min_cached_objs, int, 0444);
> >  static int rcu_delay_page_cache_fill_msec = 5000;
> >  module_param(rcu_delay_page_cache_fill_msec, int, 0444);
> >  
> > +static struct workqueue_struct *rcu_reclaim_wq;
> > +
> >  /* Maximum number of jiffies to wait before draining a batch. */
> >  #define KFREE_DRAIN_JIFFIES (5 * HZ)
> >  #define KFREE_N_BATCHES 2
> > @@ -1632,10 +1634,10 @@ __schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
> >  	if (delayed_work_pending(&krcp->monitor_work)) {
> >  		delay_left = krcp->monitor_work.timer.expires - jiffies;
> >  		if (delay < delay_left)
> > -			mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
> > +			mod_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
> >  		return;
> >  	}
> > -	queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
> > +	queue_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
> >  }
> >  
> >  static void
> > @@ -1733,7 +1735,7 @@ kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
> >  			// "free channels", the batch can handle. Break
> >  			// the loop since it is done with this CPU thus
> >  			// queuing an RCU work is _always_ success here.
> > -			queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
> > +			queued = queue_rcu_work(rcu_reclaim_wq, &krwp->rcu_work);
> >  			WARN_ON_ONCE(!queued);
> >  			break;
> >  		}
> > @@ -1883,7 +1885,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
> >  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> >  			!atomic_xchg(&krcp->work_in_progress, 1)) {
> >  		if (atomic_read(&krcp->backoff_page_cache_fill)) {
> > -			queue_delayed_work(system_unbound_wq,
> > +			queue_delayed_work(rcu_reclaim_wq,
> >  				&krcp->page_cache_work,
> >  					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
> >  		} else {
> > @@ -2120,6 +2122,10 @@ void __init kvfree_rcu_init(void)
> >  	int i, j;
> >  	struct shrinker *kfree_rcu_shrinker;
> >  
> > +	rcu_reclaim_wq = alloc_workqueue("kvfree_rcu_reclaim",
> > +			WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
> > +	WARN_ON(!rcu_reclaim_wq);
> > +
> >  	/* Clamp it to [0:100] seconds interval. */
> >  	if (rcu_delay_page_cache_fill_msec < 0 ||
> >  		rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
> > -- 
> > 2.39.5
> > 
> 

