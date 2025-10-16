Return-Path: <stable+bounces-186012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F78BE337B
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E0954EC792
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FAC31AF06;
	Thu, 16 Oct 2025 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v9JSHjYo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEED2727F5
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616249; cv=none; b=Ryf05Xvttw0dhdfGwqpSVWwNGcHzO1tFvS/oOXKbaYgfzkwYY5leJvu7HwJbl07Iy2K85dz1fox7vu3ha7pIZ1VcQoE+fkDXPY12sg2bjv9FT0x+XpzzWPcqqcsmrR0LumrNb4fU9CNfxhh0Pn+/IJt8tHP3MiLL+xwIB2bZVQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616249; c=relaxed/simple;
	bh=avAF7ONePVphKehKvITNnTUodOhke9P1IV/rZRLgVbI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nRiD8PhzRCA0tNs2IWXshtuHO1OMzDDq6isU2FdJhbM5RT4RF4ODZj/MMZ3Z7X29s4X/STb0Cj9kHHs1f41KLjtQ8lP7Csk8pnjeKcrGoGvafI8O3xlfxWRB7UFS4wR4rtTTQD6BOjpcqlXmqzFplECdH1BnGgGcZQjKtV2nqRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v9JSHjYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC0AC4CEF1;
	Thu, 16 Oct 2025 12:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760616248;
	bh=avAF7ONePVphKehKvITNnTUodOhke9P1IV/rZRLgVbI=;
	h=Subject:To:Cc:From:Date:From;
	b=v9JSHjYoge6S+1gM5aA6QuEyYgLdiU1M+fvCxB8SlPR/wCUbKY7GXu3c2wsrDUUyN
	 YWiSH7wJSkL98vUBx2XwMFxUH8xMlNfJgCqbYoUnppzUva6bpAyxo/mBahCcT+mTNm
	 rmzwNMrjkX8vg6J8vd8lcdJxlkuubDORgb4HOf7E=
Subject: FAILED: patch "[PATCH] blk-crypto: fix missing blktrace bio split events" failed to apply to 5.10-stable tree
To: yukuai3@huawei.com,axboe@kernel.dk,bvanassche@acm.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:03:57 +0200
Message-ID: <2025101657-rule-straw-2a51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 06d712d297649f48ebf1381d19bd24e942813b37
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101657-rule-straw-2a51@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 06d712d297649f48ebf1381d19bd24e942813b37 Mon Sep 17 00:00:00 2001
From: Yu Kuai <yukuai3@huawei.com>
Date: Wed, 10 Sep 2025 14:30:45 +0800
Subject: [PATCH] blk-crypto: fix missing blktrace bio split events

trace_block_split() is missing, resulting in blktrace inability to catch
BIO split events and making it harder to analyze the BIO sequence.

Cc: stable@vger.kernel.org
Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index dbc2d8784dab..27fa1ec4b264 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/scatterlist.h>
+#include <trace/events/block.h>
 
 #include "blk-cgroup.h"
 #include "blk-crypto-internal.h"
@@ -230,7 +231,9 @@ static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
 			bio->bi_status = BLK_STS_RESOURCE;
 			return false;
 		}
+
 		bio_chain(split_bio, bio);
+		trace_block_split(split_bio, bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 		*bio_ptr = split_bio;
 	}


