Return-Path: <stable+bounces-186011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 266ADBE3378
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E113A91EA
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473412727F5;
	Thu, 16 Oct 2025 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BS/2W+wX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393130FC1B
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616240; cv=none; b=tXcS+RX/JdLUrffoNEcYLJKsqSLymS9Pi/VpKroIawWLN3DdS4h2yfe4/e61NEnVu9aS0MlLYY8TvZsbLoc5ylw5BzVqIYm2Bqusp8R8Tr7SxCia/TTfF8l/EOHc2Cv80OW4gimbaxxhOOIgC0EjTr1L9HcVNzbPEEY+U1IepVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616240; c=relaxed/simple;
	bh=bBd534dvH7+XuO3ViPcGjruYsxqWiRF4PkqzqAmkgzo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Xolo2AJWfuOqI7KSFg/xJCT21LUJypQMj7DjJ2se9vJDJOQ2GTE0pN/wilo5LA0UxQiU29ZVWNeXclJfQPv99iRzmwpdmfOC4FFHm5jr8YEkghSF4U2ucDfeySG07SMC50e37t5F2jRjPs5sg/bGTsScOgAXAci0xFaCxHd57dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BS/2W+wX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B0BC4CEF1;
	Thu, 16 Oct 2025 12:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760616239;
	bh=bBd534dvH7+XuO3ViPcGjruYsxqWiRF4PkqzqAmkgzo=;
	h=Subject:To:Cc:From:Date:From;
	b=BS/2W+wXuEXkmqGnvUPfI3LUkYXMlEr077kkCsUCilYEKJWW0hdepcWXRLnbT6+0X
	 YLSLXM8JiDdgvxr+JenHtOERiH1jdlKGtGwK2WGPHWfofUhF6zunTkZ2cq0aCBFn63
	 6YH6z5uCFU0KAVo+J66n/zZbsPsDqpYmp6TMoWK0=
Subject: FAILED: patch "[PATCH] blk-crypto: fix missing blktrace bio split events" failed to apply to 5.15-stable tree
To: yukuai3@huawei.com,axboe@kernel.dk,bvanassche@acm.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:03:56 +0200
Message-ID: <2025101656-curdle-duration-949d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 06d712d297649f48ebf1381d19bd24e942813b37
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101656-curdle-duration-949d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


