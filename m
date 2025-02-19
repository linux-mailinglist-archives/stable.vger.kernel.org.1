Return-Path: <stable+bounces-118259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15414A3BF65
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 14:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0296C17BE9D
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2701E231E;
	Wed, 19 Feb 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrZQZz+m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AF51CAA6F
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970040; cv=none; b=LuExxBm7bWrwc6VylXs3MgWESpZJAkPrAGQg2n2CQPV0AIqluV72pF5kD4puftAo6vgIoA/AjhIdjAsNGnZYWGoVZx9BFB9iESwUPQBgjZKg8Jjr45dhGOjfkrtvJVpLtlEboKyg8sF8AqBlaqascp5TlwymzjWeCZ9IjdPQ+UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970040; c=relaxed/simple;
	bh=LS63qe6wNoHdlV2bGuG6kytVejypA4SDMFfYpslUWOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqLeB7HYx0XmLBAibOTg1UDWYcaCX4lWyDol/MUXpZ6UnO2NTXpMeVIGWH/YhHIs9TtpLUg+W6FLgYIS1tSm89t+ajdudNwj8z7LLmzhTHiihsH4B08j9ymKQWltDOHPFSNbsYLcV3vTaVblMCnvVjHmARKqEpoISCtbu0tcTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrZQZz+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3A3C4CEDD;
	Wed, 19 Feb 2025 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739970039;
	bh=LS63qe6wNoHdlV2bGuG6kytVejypA4SDMFfYpslUWOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BrZQZz+mWtxQQkU159H+xN/7wssTynWvLWoRKhiA4lRBR/k1+Vw9RkxPOBTRdB5c4
	 MDL0FYQVLvrLI5SJl8dd2ad2pCzSvRHjM+YPzhsED3/eZ+sLk1lwSAlMKHJxuiO3pL
	 E/Xx/ey62iNCcAPOI9gBkxjHVEdhP76BzxhSbFeJUI25fHfUzuAAzjYkmZ4xQDPovs
	 6mftIZO9D+JxkEJc3Kve2E/kthg6tgx6E1AgikBCC6V4CSJm4+tY/4U5Y1XLD1cM7T
	 mSwdTE2fREKkvaiiGGXfeOL9Ox0CSPi3uRZmcEK1y4wHU8hc3kqFM0iQfR0NlbRJ9k
	 IBu2SmKWCmOiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hagar Hemdan <hagarhem@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] block, bfq: split sync bfq_queues on a per-actuator basis
Date: Wed, 19 Feb 2025 08:00:35 -0500
Message-Id: <20250219075548-b15300b0512e10b0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250219090907.30462-1-hagarhem@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 9778369a2d6c5ed2b81a04164c4aa9da1bdb193d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hagar Hemdan<hagarhem@amazon.com>
Commit author: Paolo Valente<paolo.valente@linaro.org>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  9778369a2d6c5 ! 1:  e73e0a774c936 block, bfq: split sync bfq_queues on a per-actuator basis
    @@ Metadata
      ## Commit message ##
         block, bfq: split sync bfq_queues on a per-actuator basis
     
    +    commit 9778369a2d6c5ed2b81a04164c4aa9da1bdb193d upstream.
    +
         Single-LUN multi-actuator SCSI drives, as well as all multi-actuator
         SATA drives appear as a single device to the I/O subsystem [1].  Yet
         they address commands to different actuators internally, as a function
    @@ Commit message
         Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
         Link: https://lore.kernel.org/r/20230103145503.71712-2-paolo.valente@linaro.org
         Signed-off-by: Jens Axboe <axboe@kernel.dk>
    +    Stable-dep-of: e8b8344de398 ("block, bfq: fix bfqq uaf in bfq_limit_depth()")
    +    [Hagar: needed contextual fixes]
    +    Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
     
      ## block/bfq-cgroup.c ##
     @@ block/bfq-cgroup.c: void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
    @@ block/bfq-cgroup.c: void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *
      /**
       * __bfq_bic_change_cgroup - move @bic to @bfqg.
       * @bfqd: the queue descriptor.
    -@@ block/bfq-cgroup.c: static void __bfq_bic_change_cgroup(struct bfq_data *bfqd,
    - 				    struct bfq_io_cq *bic,
    - 				    struct bfq_group *bfqg)
    +@@ block/bfq-cgroup.c: void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
    +  * sure that the reference to cgroup is valid across the call (see
    +  * comments in bfq_bic_update_cgroup on this issue)
    +  */
    +-static void *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
    ++static void __bfq_bic_change_cgroup(struct bfq_data *bfqd,
    + 				     struct bfq_io_cq *bic,
    + 				     struct bfq_group *bfqg)
      {
     -	struct bfq_queue *async_bfqq = bic_to_bfqq(bic, false);
     -	struct bfq_queue *sync_bfqq = bic_to_bfqq(bic, true);
    @@ block/bfq-cgroup.c: static void __bfq_bic_change_cgroup(struct bfq_data *bfqd,
     -				 * request from the old cgroup.
     -				 */
     -				bfq_put_cooperator(sync_bfqq);
    --				bfq_release_process_ref(bfqd, sync_bfqq);
     -				bic_set_bfqq(bic, NULL, true);
    +-				bfq_release_process_ref(bfqd, sync_bfqq);
     -			}
     -		}
     +		if (sync_bfqq)
     +			bfq_sync_bfqq_move(bfqd, sync_bfqq, bic, bfqg, act_idx);
      	}
    +-
    +-	return bfqg;
      }
      
    + void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
     
      ## block/bfq-iosched.c ##
     @@ block/bfq-iosched.c: static const unsigned long bfq_late_stable_merging = 600;
    @@ block/bfq-iosched.c: static bool bfq_bio_merge(struct request_queue *q, struct b
      	} else {
      		bfqd->bio_bfqq = NULL;
      	}
    -@@ block/bfq-iosched.c: bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
    +@@ block/bfq-iosched.c: static struct bfq_queue *bfq_merge_bfqqs(struct bfq_data *bfqd,
      	/*
      	 * Merge queues (that is, let bic redirect its requests to new_bfqq)
      	 */
    @@ block/bfq-iosched.c: static void bfq_check_ioprio_change(struct bfq_io_cq *bic,
     -	bfqq = bic_to_bfqq(bic, false);
     +	bfqq = bic_to_bfqq(bic, false, bfq_actuator_index(bfqd, bio));
      	if (bfqq) {
    - 		bfq_release_process_ref(bfqd, bfqq);
    + 		struct bfq_queue *old_bfqq = bfqq;
    + 
      		bfqq = bfq_get_queue(bfqd, bio, false, bic, true);
     -		bic_set_bfqq(bic, bfqq, false);
     +		bic_set_bfqq(bic, bfqq, false, bfq_actuator_index(bfqd, bio));
    + 		bfq_release_process_ref(bfqd, old_bfqq);
      	}
      
     -	bfqq = bic_to_bfqq(bic, true);
    @@ block/bfq-iosched.c: static bool __bfq_insert_request(struct bfq_data *bfqd, str
      		 * then complete the merge and redirect it to
      		 * new_bfqq.
      		 */
    --		if (bic_to_bfqq(RQ_BIC(rq), 1) == bfqq)
    +-		if (bic_to_bfqq(RQ_BIC(rq), 1) == bfqq) {
     +		if (bic_to_bfqq(RQ_BIC(rq), true,
    -+				bfq_actuator_index(bfqd, rq->bio)) == bfqq)
    - 			bfq_merge_bfqqs(bfqd, RQ_BIC(rq),
    - 					bfqq, new_bfqq);
    - 
    ++				bfq_actuator_index(bfqd, rq->bio)) == bfqq) {
    + 			while (bfqq != new_bfqq)
    + 				bfqq = bfq_merge_bfqqs(bfqd, RQ_BIC(rq), bfqq);
    + 		}
     @@ block/bfq-iosched.c: bfq_split_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq)
      		return bfqq;
      	}
    @@ block/bfq-iosched.h: struct bfq_group {
     +				unsigned int actuator_idx);
      struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic);
      void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq);
    - void bfq_weights_tree_add(struct bfq_queue *bfqq);
    + void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

