Return-Path: <stable+bounces-200987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B914CCBC2DD
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 02:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40DEE3008E8A
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 01:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378F526E175;
	Mon, 15 Dec 2025 01:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V82Wphhh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0841EEAB;
	Mon, 15 Dec 2025 01:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765761497; cv=none; b=Rjuf8vbnOK5BCGV04d9O5f+W/uH2IMzBAZBJvJPLFQX6bG/94u6rGyw/JIOpDsEsn1HIlZv+cgDcEmdU0+V14QM+exppqN0BgNv/f4zsqeNV4NJnh24Jve8ReepvfG9th03jRYcHXdCUdJETDpDLfLL2XWTtrSzG8tnnKn/io9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765761497; c=relaxed/simple;
	bh=afMaP1c+hPjYNrH4otO95vgmECj3GpHkiJmcBDgZTOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTejt8dMKrc2yGnJ062ynjxmWCj4RJVCuJX8F5CHq3sQgZKaVu07xwuNunDm5gnEDaSugVQNqTSpQ9lqa6AalXnpoqLzK1pYegBBMGNoNo7x4RBwTs5mNMODUafbwvvkXAFYnBo4LMg3Mx1X2qwK9grzBRgJgicfmII3sQ4DxnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V82Wphhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708ADC4CEF1;
	Mon, 15 Dec 2025 01:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765761496;
	bh=afMaP1c+hPjYNrH4otO95vgmECj3GpHkiJmcBDgZTOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V82Wphhh++I7FVXhRxtomAQ5eqXItxUrcY8RlknaafcI5jtYEtOzVbv7CLfL7b4wH
	 m7/BeYgO0wcvCCCqplwCMF1u+BtcsUPqrMh16XlVCFMny88/hTVGY1RP+xn6pKrMqd
	 0eeqsd/O/nW/JWR3j+3lgHjQ3zX9Tma8Ma62hn2dwJmKF87WewWMUEehJlQkCiZpKB
	 RjqBEqDl+XA/fM8sQg7Y5TKr6y0ASgpEmRklbu/hRZ8l68a4+JUK2bdBqTVVlo1wZe
	 bNYV+bCMwtdrZqDz46sVlqouudp/ydQBwqi+tiHyvexrN6mkpGGijYepz8oGLuYFSN
	 qhFE0YcKkyzOA==
Message-ID: <040e3a90-9817-4f67-b385-68ef986cb49c@kernel.org>
Date: Mon, 15 Dec 2025 10:18:13 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "block: mq-deadline: Remove support for zone write locking"
 has been added to the 6.6-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251213110931.4186945-1-sashal@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251213110931.4186945-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/25 20:09, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     block: mq-deadline: Remove support for zone write locking
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      block-mq-deadline-remove-support-for-zone-write-lock.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Sasha,

Zone write locking in the mq-deadline scheduler was replaced with the generic
zone write plugging in the block layer in 6.10. That was not backported as that
is a new feature. So removing zone write locking in 6.6 will break support for
SMR drives and other zoned block devices. Removing it from 6.6 is thus not OK.
Please undo this.

> commit bf2022eaa2291ad1243b0711d5bd03ba4105ffbb
> Author: Damien Le Moal <dlemoal@kernel.org>
> Date:   Mon Apr 8 10:41:21 2024 +0900
> 
>     block: mq-deadline: Remove support for zone write locking
>     
>     [ Upstream commit fde02699c242e88a71286677d27cc890a959b67f ]
>     
>     With the block layer generic plugging of write operations for zoned
>     block devices, mq-deadline, or any other scheduler, can only ever
>     see at most one write operation per zone at any time. There is thus no
>     sequentiality requirements for these writes and thus no need to tightly
>     control the dispatching of write requests using zone write locking.
>     
>     Remove all the code that implement this control in the mq-deadline
>     scheduler and remove advertizing support for the
>     ELEVATOR_F_ZBD_SEQ_WRITE elevator feature.
>     
>     Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>     Reviewed-by: Hannes Reinecke <hare@suse.de>
>     Reviewed-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>     Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
>     Tested-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
>     Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>     Link: https://lore.kernel.org/r/20240408014128.205141-22-dlemoal@kernel.org
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>     Stable-dep-of: d60055cf5270 ("block/mq-deadline: Switch back to a single dispatch list")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 78a8aa204c156..23638b03d7b3d 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -102,7 +102,6 @@ struct deadline_data {
>  	int prio_aging_expire;
>  
>  	spinlock_t lock;
> -	spinlock_t zone_lock;
>  };
>  
>  /* Maps an I/O priority class to a deadline scheduler priority. */
> @@ -157,8 +156,7 @@ deadline_latter_request(struct request *rq)
>  }
>  
>  /*
> - * Return the first request for which blk_rq_pos() >= @pos. For zoned devices,
> - * return the first request after the start of the zone containing @pos.
> + * Return the first request for which blk_rq_pos() >= @pos.
>   */
>  static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
>  				enum dd_data_dir data_dir, sector_t pos)
> @@ -170,14 +168,6 @@ static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
>  		return NULL;
>  
>  	rq = rb_entry_rq(node);
> -	/*
> -	 * A zoned write may have been requeued with a starting position that
> -	 * is below that of the most recently dispatched request. Hence, for
> -	 * zoned writes, start searching from the start of a zone.
> -	 */
> -	if (blk_rq_is_seq_zoned_write(rq))
> -		pos = round_down(pos, rq->q->limits.chunk_sectors);
> -
>  	while (node) {
>  		rq = rb_entry_rq(node);
>  		if (blk_rq_pos(rq) >= pos) {
> @@ -308,36 +298,6 @@ static inline bool deadline_check_fifo(struct dd_per_prio *per_prio,
>  	return time_is_before_eq_jiffies((unsigned long)rq->fifo_time);
>  }
>  
> -/*
> - * Check if rq has a sequential request preceding it.
> - */
> -static bool deadline_is_seq_write(struct deadline_data *dd, struct request *rq)
> -{
> -	struct request *prev = deadline_earlier_request(rq);
> -
> -	if (!prev)
> -		return false;
> -
> -	return blk_rq_pos(prev) + blk_rq_sectors(prev) == blk_rq_pos(rq);
> -}
> -
> -/*
> - * Skip all write requests that are sequential from @rq, even if we cross
> - * a zone boundary.
> - */
> -static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
> -						struct request *rq)
> -{
> -	sector_t pos = blk_rq_pos(rq);
> -
> -	do {
> -		pos += blk_rq_sectors(rq);
> -		rq = deadline_latter_request(rq);
> -	} while (rq && blk_rq_pos(rq) == pos);
> -
> -	return rq;
> -}
> -
>  /*
>   * For the specified data direction, return the next request to
>   * dispatch using arrival ordered lists.
> @@ -346,40 +306,10 @@ static struct request *
>  deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  		      enum dd_data_dir data_dir)
>  {
> -	struct request *rq, *rb_rq, *next;
> -	unsigned long flags;
> -
>  	if (list_empty(&per_prio->fifo_list[data_dir]))
>  		return NULL;
>  
> -	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
> -		return rq;
> -
> -	/*
> -	 * Look for a write request that can be dispatched, that is one with
> -	 * an unlocked target zone. For some HDDs, breaking a sequential
> -	 * write stream can lead to lower throughput, so make sure to preserve
> -	 * sequential write streams, even if that stream crosses into the next
> -	 * zones and these zones are unlocked.
> -	 */
> -	spin_lock_irqsave(&dd->zone_lock, flags);
> -	list_for_each_entry_safe(rq, next, &per_prio->fifo_list[DD_WRITE],
> -				 queuelist) {
> -		/* Check whether a prior request exists for the same zone. */
> -		rb_rq = deadline_from_pos(per_prio, data_dir, blk_rq_pos(rq));
> -		if (rb_rq && blk_rq_pos(rb_rq) < blk_rq_pos(rq))
> -			rq = rb_rq;
> -		if (blk_req_can_dispatch_to_zone(rq) &&
> -		    (blk_queue_nonrot(rq->q) ||
> -		     !deadline_is_seq_write(dd, rq)))
> -			goto out;
> -	}
> -	rq = NULL;
> -out:
> -	spin_unlock_irqrestore(&dd->zone_lock, flags);
> -
> -	return rq;
> +	return rq_entry_fifo(per_prio->fifo_list[data_dir].next);
>  }
>  
>  /*
> @@ -390,36 +320,8 @@ static struct request *
>  deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  		      enum dd_data_dir data_dir)
>  {
> -	struct request *rq;
> -	unsigned long flags;
> -
> -	rq = deadline_from_pos(per_prio, data_dir,
> -			       per_prio->latest_pos[data_dir]);
> -	if (!rq)
> -		return NULL;
> -
> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
> -		return rq;
> -
> -	/*
> -	 * Look for a write request that can be dispatched, that is one with
> -	 * an unlocked target zone. For some HDDs, breaking a sequential
> -	 * write stream can lead to lower throughput, so make sure to preserve
> -	 * sequential write streams, even if that stream crosses into the next
> -	 * zones and these zones are unlocked.
> -	 */
> -	spin_lock_irqsave(&dd->zone_lock, flags);
> -	while (rq) {
> -		if (blk_req_can_dispatch_to_zone(rq))
> -			break;
> -		if (blk_queue_nonrot(rq->q))
> -			rq = deadline_latter_request(rq);
> -		else
> -			rq = deadline_skip_seq_writes(dd, rq);
> -	}
> -	spin_unlock_irqrestore(&dd->zone_lock, flags);
> -
> -	return rq;
> +	return deadline_from_pos(per_prio, data_dir,
> +				 per_prio->latest_pos[data_dir]);
>  }
>  
>  /*
> @@ -525,10 +427,6 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>  		rq = next_rq;
>  	}
>  
> -	/*
> -	 * For a zoned block device, if we only have writes queued and none of
> -	 * them can be dispatched, rq will be NULL.
> -	 */
>  	if (!rq)
>  		return NULL;
>  
> @@ -549,10 +447,6 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>  	prio = ioprio_class_to_prio[ioprio_class];
>  	dd->per_prio[prio].latest_pos[data_dir] = blk_rq_pos(rq);
>  	dd->per_prio[prio].stats.dispatched++;
> -	/*
> -	 * If the request needs its target zone locked, do it.
> -	 */
> -	blk_req_zone_write_lock(rq);
>  	rq->rq_flags |= RQF_STARTED;
>  	return rq;
>  }
> @@ -736,7 +630,6 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
>  	dd->fifo_batch = fifo_batch;
>  	dd->prio_aging_expire = prio_aging_expire;
>  	spin_lock_init(&dd->lock);
> -	spin_lock_init(&dd->zone_lock);
>  
>  	/* We dispatch from request queue wide instead of hw queue */
>  	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
> @@ -818,12 +711,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	lockdep_assert_held(&dd->lock);
>  
> -	/*
> -	 * This may be a requeue of a write request that has locked its
> -	 * target zone. If it is the case, this releases the zone lock.
> -	 */
> -	blk_req_zone_write_unlock(rq);
> -
>  	prio = ioprio_class_to_prio[ioprio_class];
>  	per_prio = &dd->per_prio[prio];
>  	if (!rq->elv.priv[0]) {
> @@ -855,18 +742,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  		 */
>  		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
>  		insert_before = &per_prio->fifo_list[data_dir];
> -#ifdef CONFIG_BLK_DEV_ZONED
> -		/*
> -		 * Insert zoned writes such that requests are sorted by
> -		 * position per zone.
> -		 */
> -		if (blk_rq_is_seq_zoned_write(rq)) {
> -			struct request *rq2 = deadline_latter_request(rq);
> -
> -			if (rq2 && blk_rq_zone_no(rq2) == blk_rq_zone_no(rq))
> -				insert_before = &rq2->queuelist;
> -		}
> -#endif
>  		list_add_tail(&rq->queuelist, insert_before);
>  	}
>  }
> @@ -901,33 +776,8 @@ static void dd_prepare_request(struct request *rq)
>  	rq->elv.priv[0] = NULL;
>  }
>  
> -static bool dd_has_write_work(struct blk_mq_hw_ctx *hctx)
> -{
> -	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
> -	enum dd_prio p;
> -
> -	for (p = 0; p <= DD_PRIO_MAX; p++)
> -		if (!list_empty_careful(&dd->per_prio[p].fifo_list[DD_WRITE]))
> -			return true;
> -
> -	return false;
> -}
> -
>  /*
>   * Callback from inside blk_mq_free_request().
> - *
> - * For zoned block devices, write unlock the target zone of
> - * completed write requests. Do this while holding the zone lock
> - * spinlock so that the zone is never unlocked while deadline_fifo_request()
> - * or deadline_next_request() are executing. This function is called for
> - * all requests, whether or not these requests complete successfully.
> - *
> - * For a zoned block device, __dd_dispatch_request() may have stopped
> - * dispatching requests if all the queued requests are write requests directed
> - * at zones that are already locked due to on-going write requests. To ensure
> - * write request dispatch progress in this case, mark the queue as needing a
> - * restart to ensure that the queue is run again after completion of the
> - * request and zones being unlocked.
>   */
>  static void dd_finish_request(struct request *rq)
>  {
> @@ -942,21 +792,8 @@ static void dd_finish_request(struct request *rq)
>  	 * called dd_insert_requests(). Skip requests that bypassed I/O
>  	 * scheduling. See also blk_mq_request_bypass_insert().
>  	 */
> -	if (!rq->elv.priv[0])
> -		return;
> -
> -	atomic_inc(&per_prio->stats.completed);
> -
> -	if (blk_queue_is_zoned(q)) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&dd->zone_lock, flags);
> -		blk_req_zone_write_unlock(rq);
> -		spin_unlock_irqrestore(&dd->zone_lock, flags);
> -
> -		if (dd_has_write_work(rq->mq_hctx))
> -			blk_mq_sched_mark_restart_hctx(rq->mq_hctx);
> -	}
> +	if (rq->elv.priv[0])
> +		atomic_inc(&per_prio->stats.completed);
>  }
>  
>  static bool dd_has_work_for_prio(struct dd_per_prio *per_prio)
> @@ -1280,7 +1117,6 @@ static struct elevator_type mq_deadline = {
>  	.elevator_attrs = deadline_attrs,
>  	.elevator_name = "mq-deadline",
>  	.elevator_alias = "deadline",
> -	.elevator_features = ELEVATOR_F_ZBD_SEQ_WRITE,
>  	.elevator_owner = THIS_MODULE,
>  };
>  MODULE_ALIAS("mq-deadline-iosched");


-- 
Damien Le Moal
Western Digital Research

