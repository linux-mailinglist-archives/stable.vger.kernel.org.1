Return-Path: <stable+bounces-132985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797F4A91968
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1378119E3E9B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C9D1FCFDB;
	Thu, 17 Apr 2025 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lbttDD6p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B526289
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885938; cv=none; b=Vk2iIm52riWcsiTAkf6b7tCEo0j1a8W18qL2tMW8Iv7Q5eJIZNCavltdBMxJFPDocl+xANO7ypKPL2yaySLNO6Xc2ghXFG8GmMO7P/6UD6IEVTO4tGQ5Xvvb2usEiUOxodikCqSshrGkanQ685ddPVmBdaUW3d/NiOyTqj5NHhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885938; c=relaxed/simple;
	bh=1dQNrHe+claJqw98KnVsAa15PQl7kH8t2qKWB7KRTww=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bKSK5c6Y1NtX95KWa9eHb6mfnlHdPlcc/Njeblijq7LADcFGoe/KeUDL7dG+KXf96Q+GnezN3DOGK6fTCsXIjCJ3EicVU5Nwke6w8QuMKyBni1MNTo2qO2OhqpafOaK17iDGZfqeEskJGWtjvhLVA8hkFYDEnIpkiAcV9RYIwJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lbttDD6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DC6C4CEE4;
	Thu, 17 Apr 2025 10:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744885938;
	bh=1dQNrHe+claJqw98KnVsAa15PQl7kH8t2qKWB7KRTww=;
	h=Subject:To:Cc:From:Date:From;
	b=lbttDD6pYP2cLHNT+MZ+EEVsah5syAwqeJQY3NOGhzI/86ZcDNWyLKVVv5cjjtd2A
	 l9fZr56T74+KrX4pyZoz9ICWwgzY/AEaWZuFiC9cl7e2rvis9laitv64Za82eqKrcH
	 ezjyyFEnySJLg+TxyhKNresWJrN80SjZ8H0UK5rY=
Subject: FAILED: patch "[PATCH] block: make sure ->nr_integrity_segments is cloned in" failed to apply to 6.12-stable tree
To: ming.lei@redhat.com,axboe@kernel.dk,hch@infradead.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:32:15 +0200
Message-ID: <2025041715-pasty-linked-066f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x fc0e982b8a3a169b1c654d9a1aa45bf292943ef2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041715-pasty-linked-066f@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


