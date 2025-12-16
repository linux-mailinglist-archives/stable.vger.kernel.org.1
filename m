Return-Path: <stable+bounces-201600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2835ACC2AEF
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FF6C3019374
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC5C349B11;
	Tue, 16 Dec 2025 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M+zBcJAs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654A349B0D;
	Tue, 16 Dec 2025 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885172; cv=none; b=RtgX8Nh/m4mYp3U9SJV7cvnipmMdtt/KHW3QMPVd8EGkVqkyACrUa7/7jIoXh27ku62XZK1+04oeaJM0KSsRUH95s6tBo9TMm7b9z7qS/FfXfpUARdgJFs52fL3mZ4SDkwBw+gCHk1PmWWbK09hltjQ4jFU/mtKn5Cy7XbL/W5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885172; c=relaxed/simple;
	bh=EkOBMw3++Vo6PiHgu9C/wX35ygd/GT3e6cn4yDkXrG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uanQKif5DwVK9kI4RohdnENiruwT2M7p8AMEEwHJe3PGeUIlRkY9of62HhR4efGOxf/sR0iw91oaixj33ru/ZYJmgRUjiALn/FAG1qdddXFXx1t3epp2qi8s+NmOjU9OUZdEhWOfcR+Y6qq7HPzhYXtnyvcN/9sOC/4HGwKIvDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M+zBcJAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFD4C4CEF1;
	Tue, 16 Dec 2025 11:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765885171;
	bh=EkOBMw3++Vo6PiHgu9C/wX35ygd/GT3e6cn4yDkXrG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+zBcJAssBRwhhp2UB8hdvQk6/hBh8hsrApS3dyQ9QrSGMEW+FJOwXXI83rQWwmBD
	 BmmasUrsRn5SFqnavc/rVCSKywIBdL4xZi9LhL+v5UCahWRNAUWNBMeb47Kcdu2iap
	 EMg5vhbscukFjGRakeIl+SfcF1/Je+rBo/8cfLCE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Yu Kuai <yukuai@kernel.org>,
	chengkaitao <chengkaitao@kylinos.cn>,
	Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 058/507] block/mq-deadline: Introduce dd_start_request()
Date: Tue, 16 Dec 2025 12:08:19 +0100
Message-ID: <20251216111347.644815958@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111345.522190956@linuxfoundation.org>
References: <20251216111345.522190956@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 93a358af59c6e8ab00b57cfdb1c437516a4948ca ]

Prepare for adding a second caller of this function. No functionality
has been changed.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Yu Kuai <yukuai@kernel.org>
Cc: chengkaitao <chengkaitao@kylinos.cn>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: d60055cf5270 ("block/mq-deadline: Switch back to a single dispatch list")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/mq-deadline.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 2e689b2c40213..9d449503613d6 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -310,6 +310,19 @@ static bool started_after(struct deadline_data *dd, struct request *rq,
 	return time_after(start_time, latest_start);
 }
 
+static struct request *dd_start_request(struct deadline_data *dd,
+					enum dd_data_dir data_dir,
+					struct request *rq)
+{
+	u8 ioprio_class = dd_rq_ioclass(rq);
+	enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+
+	dd->per_prio[prio].latest_pos[data_dir] = blk_rq_pos(rq);
+	dd->per_prio[prio].stats.dispatched++;
+	rq->rq_flags |= RQF_STARTED;
+	return rq;
+}
+
 /*
  * deadline_dispatch_requests selects the best request according to
  * read/write expire, fifo_batch, etc and with a start time <= @latest_start.
@@ -320,8 +333,6 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 {
 	struct request *rq, *next_rq;
 	enum dd_data_dir data_dir;
-	enum dd_prio prio;
-	u8 ioprio_class;
 
 	lockdep_assert_held(&dd->lock);
 
@@ -415,12 +426,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	dd->batching++;
 	deadline_move_request(dd, per_prio, rq);
 done:
-	ioprio_class = dd_rq_ioclass(rq);
-	prio = ioprio_class_to_prio[ioprio_class];
-	dd->per_prio[prio].latest_pos[data_dir] = blk_rq_pos(rq);
-	dd->per_prio[prio].stats.dispatched++;
-	rq->rq_flags |= RQF_STARTED;
-	return rq;
+	return dd_start_request(dd, data_dir, rq);
 }
 
 /*
-- 
2.51.0




