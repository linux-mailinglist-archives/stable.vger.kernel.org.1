Return-Path: <stable+bounces-132990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8811BA91970
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 179A97AC5A1
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E724822DFA9;
	Thu, 17 Apr 2025 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QwvB9mf9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72E122DF81
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885961; cv=none; b=rCvInBG8+b3pq4AeSvnNxuf2xMCHbZ99ueXia6RvGiDwQZen5NVZsSmkJhOLBNXB+44fRNhhSd4aEzs+4kPsSZwCEBvDU+e9e8sQhYmwWheLAtj8bLnkgda9lgN9N/jbWtlQqEYu1+ZPEZsX1EAX7+sAJlq8TlZuH8jkfCY7sIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885961; c=relaxed/simple;
	bh=RoIeIzQ+FxfFUUbuoe9rU/SaWeGhcFsNbA1WShtL0KE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y82M99qJ6ZFx5zCMOX18KtcVZpQvriP65P71+qpjFLTdBqAzpGz1Xmu6XkAOu/1OTRsIEa8Ip8hOtba5mRgAVF3iI8qJtkkF1r91QE9d8OE5pyDtR4OAxQJp1cjlBQsSp0NceYGzEgLHnmO8Cfio/JTXp31Izn+qLayT/mZcygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QwvB9mf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D12C4CEE4;
	Thu, 17 Apr 2025 10:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744885961;
	bh=RoIeIzQ+FxfFUUbuoe9rU/SaWeGhcFsNbA1WShtL0KE=;
	h=Subject:To:Cc:From:Date:From;
	b=QwvB9mf9tt37J9i9Ml3c2CaIOwicavAXFhpyIUMv4RZz1vun6O09vLz2f9CRs//ob
	 EfK7bKKED5na2mBTFhtNVDf4vL0vVk9iOW8uvK9QgbuvgwLKWtz2y9qeXcGi1KAbFK
	 LcicVUCRpUPQ2W9Y/PuZLJ2/bp7kh/Yxy33pIoUg=
Subject: FAILED: patch "[PATCH] block: make sure ->nr_integrity_segments is cloned in" failed to apply to 5.4-stable tree
To: ming.lei@redhat.com,axboe@kernel.dk,hch@infradead.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:32:18 +0200
Message-ID: <2025041718-sycamore-obituary-4684@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x fc0e982b8a3a169b1c654d9a1aa45bf292943ef2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041718-sycamore-obituary-4684@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


