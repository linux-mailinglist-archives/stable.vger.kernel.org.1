Return-Path: <stable+bounces-130976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A7FA80707
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188F31B85279
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C44269894;
	Tue,  8 Apr 2025 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y8BRsQnA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337CF2063FD;
	Tue,  8 Apr 2025 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115159; cv=none; b=JfCDnA8ib8IoiRduupPAcEh0VsRpOfWjDhqxSSR54KxPmuVRHxkISn+P2N2IN23WivFu3s4JUcDUYZaby9uDlENVroLAPgL6W+SKuzlA6aq5KAH0kmoz+pBwcbVTvlt8Gvi8MFlTjp7+lOitflANd7kVk/IXcD22mQziaxP8Q5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115159; c=relaxed/simple;
	bh=0uy79wHUvskig8vb4prYolfYXVVT3GechvsQWQ+nefI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KM+5nTQXQKodsR2JW3vdhzyambxAvBeYCVW1DynROVnqWnV1qzIs6JPgJIhUk15ezx17lU0nfZxgEhDFqj8bC9nmuzYvce0j8ups4cwTrxDpsFFdvBCpm0oBYezuifaH3m5T7glvJ/SWkp/wJq7sB6fSMgsSw+9455IKtLg/Zwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y8BRsQnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C626C4CEE5;
	Tue,  8 Apr 2025 12:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115158;
	bh=0uy79wHUvskig8vb4prYolfYXVVT3GechvsQWQ+nefI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y8BRsQnAFhz/+6TR97yax86pkdkYkaEW7f+UNWgWwwCw41uA3pAAM9p+CtHc+dHov
	 KuZK4tFoRkHj353sPMH337pVBnwtYpxwy83u7zibkxyrLGxY+yDf+qHpGDvJxElH4b
	 SZYbqBOBZyq797CxuF2yLut+gHLbDVhpVVEHVM8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 370/499] ublk: make sure ubq->canceling is set when queue is frozen
Date: Tue,  8 Apr 2025 12:49:42 +0200
Message-ID: <20250408104900.456711837@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 8741d0737921ec1c03cf59aebf4d01400c2b461a ]

Now ublk driver depends on `ubq->canceling` for deciding if the request
can be dispatched via uring_cmd & io_uring_cmd_complete_in_task().

Once ubq->canceling is set, the uring_cmd can be done via ublk_cancel_cmd()
and io_uring_cmd_done().

So set ubq->canceling when queue is frozen, this way makes sure that the
flag can be observed from ublk_queue_rq() reliably, and avoids
use-after-free on uring_cmd.

Fixes: 216c8f5ef0f2 ("ublk: replace monitor with cancelable uring_cmd")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250327095123.179113-2-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d9e8bf9f5e5a8..65badf9ebecf8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1452,17 +1452,27 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 	}
 }
 
+/* Must be called when queue is frozen */
+static bool ublk_mark_queue_canceling(struct ublk_queue *ubq)
+{
+	bool canceled;
+
+	spin_lock(&ubq->cancel_lock);
+	canceled = ubq->canceling;
+	if (!canceled)
+		ubq->canceling = true;
+	spin_unlock(&ubq->cancel_lock);
+
+	return canceled;
+}
+
 static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
 {
+	bool was_canceled = ubq->canceling;
 	struct gendisk *disk;
 
-	spin_lock(&ubq->cancel_lock);
-	if (ubq->canceling) {
-		spin_unlock(&ubq->cancel_lock);
+	if (was_canceled)
 		return false;
-	}
-	ubq->canceling = true;
-	spin_unlock(&ubq->cancel_lock);
 
 	spin_lock(&ub->lock);
 	disk = ub->ub_disk;
@@ -1474,14 +1484,23 @@ static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
 	if (!disk)
 		return false;
 
-	/* Now we are serialized with ublk_queue_rq() */
+	/*
+	 * Now we are serialized with ublk_queue_rq()
+	 *
+	 * Make sure that ubq->canceling is set when queue is frozen,
+	 * because ublk_queue_rq() has to rely on this flag for avoiding to
+	 * touch completed uring_cmd
+	 */
 	blk_mq_quiesce_queue(disk->queue);
-	/* abort queue is for making forward progress */
-	ublk_abort_queue(ub, ubq);
+	was_canceled = ublk_mark_queue_canceling(ubq);
+	if (!was_canceled) {
+		/* abort queue is for making forward progress */
+		ublk_abort_queue(ub, ubq);
+	}
 	blk_mq_unquiesce_queue(disk->queue);
 	put_device(disk_to_dev(disk));
 
-	return true;
+	return !was_canceled;
 }
 
 static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
-- 
2.39.5




