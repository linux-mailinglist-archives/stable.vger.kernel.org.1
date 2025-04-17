Return-Path: <stable+bounces-132986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E55EA91969
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AEEE461696
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069B9229B32;
	Thu, 17 Apr 2025 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u39IjakL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91B71E521A
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885947; cv=none; b=h3dK6tYw8IZacDYcQghnSnxh66U/wWJRaq8SEWH9RrnGJBUWK3xdU9xQcrIEcl2LnRwHCqC1RoYIXSAEHt9cozBwJtqGaeb3Ft0AQbRFEpdEgSJzuytzraHnt7GtryQYYzJurOl2P7QfDcJ+lPKTgmhUR1L8Nc0mo+gh05daAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885947; c=relaxed/simple;
	bh=Bb/5aAgtb9pqR7buXXLjiLK78Dmum/FVKHOS5oPfcPE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UcDvt4D7v5/ZMr6kITl0J8IcdgzWMWpK2GPQlm66VCe9H2hRkaI5Qz9O68MHQRCbgGoIzYtxZu7oFjp3Daj7kSAZq8k2bWIjaq1F7VypgB/GgkgMYs2JZIDvGW586C+PDhzql12i8eOtcFyH+po0P3mNSDU7kAHrxZcX7yPslcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u39IjakL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B839AC4CEE4;
	Thu, 17 Apr 2025 10:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744885947;
	bh=Bb/5aAgtb9pqR7buXXLjiLK78Dmum/FVKHOS5oPfcPE=;
	h=Subject:To:Cc:From:Date:From;
	b=u39IjakLzkuhReslRnhPJYVDfB0YR6JrIE9kTdd7ZlThnxoucUtQzwn8BoI19QH4f
	 pAImURLq5Es5oPRWiz2SNoY/MC/gvKH0ysEWqu3MWIX6DJHa1AWbiswI+CLYyMJCkh
	 o3iF8RoiKCmm41Cgm7B+aB8NPTE1PnRLoQhE+Ke0=
Subject: FAILED: patch "[PATCH] block: make sure ->nr_integrity_segments is cloned in" failed to apply to 6.1-stable tree
To: ming.lei@redhat.com,axboe@kernel.dk,hch@infradead.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:32:16 +0200
Message-ID: <2025041716-pull-skydiver-6b13@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fc0e982b8a3a169b1c654d9a1aa45bf292943ef2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041716-pull-skydiver-6b13@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fc0e982b8a3a169b1c654d9a1aa45bf292943ef2 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 10 Mar 2025 19:54:53 +0800
Subject: [PATCH] block: make sure ->nr_integrity_segments is cloned in
 blk_rq_prep_clone

Make sure ->nr_integrity_segments is cloned in blk_rq_prep_clone(),
otherwise requests cloned by device-mapper multipath will not have the
proper nr_integrity_segments values set, then BUG() is hit from
sg_alloc_table_chained().

Fixes: b0fd271d5fba ("block: add request clone interface (v2)")
Cc: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20250310115453.2271109-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b9550a127c8e..f1030d589a1b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3314,6 +3314,7 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 		rq->special_vec = rq_src->special_vec;
 	}
 	rq->nr_phys_segments = rq_src->nr_phys_segments;
+	rq->nr_integrity_segments = rq_src->nr_integrity_segments;
 
 	if (rq->bio && blk_crypto_rq_bio_prep(rq, rq->bio, gfp_mask) < 0)
 		goto free_and_out;


