Return-Path: <stable+bounces-158033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 108D7AE56FF
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E0F3AD1B6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D9722370A;
	Mon, 23 Jun 2025 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s626Xl35"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E5A2192EC;
	Mon, 23 Jun 2025 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717319; cv=none; b=rH21vD6W9tF4MQLaUT9x++U4pzP8IvhKPvslAnHzEGbnmHcoJUMDi0i96yXGozZKlfw45Yk1p6jTroWgnJK0UoLY1OkS9zJxp6tyjgpeDDZOVSQn16UbCV2TPkueVdKwSHxQLKGL3AeduAm4lW+5bESNd9ZxmiQ6K1DfC803Z2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717319; c=relaxed/simple;
	bh=uVTuyiQuPwe9etGrICXKt4zXdgKTK3MJsHKnRxwqJzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/m5520NgJbZaz3pTOuzWHuFRqSbyKNmXNNiq8hURvRtc5kAjNQ6u1eZZb8t7EHOMrnQn8IzVR6JARD/8eMHiRGf/zv3w/ejzZ8Clf9Sk3BNReou9A6jEA1J55u7l9j5Bbe8cCuVVJ88CDzNCc0EgUpo2ZLKcP1wDmS5cHjDjyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s626Xl35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D057C4CEEA;
	Mon, 23 Jun 2025 22:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717318;
	bh=uVTuyiQuPwe9etGrICXKt4zXdgKTK3MJsHKnRxwqJzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s626Xl35KDW3SPWaLiSdRkmo4DdE0EVKcwaQWHuhwKM5YXsq43YBlMY0uUOUv9y9Q
	 MmcKsLUsAT31JVmvGLG93UOZcPFCN7tk503uGgzNRhrIpw2k7zQct/DDpaY4bKtdjF
	 bEXYS6/6bl83BQceyz5X+WRIWMGnZOa6T6dpIF+Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Sanders <jsanders.devel@gmail.com>,
	Valentin Kleibel <valentin@vrvis.at>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 365/414] aoe: clean device rq_list in aoedev_downdev()
Date: Mon, 23 Jun 2025 15:08:22 +0200
Message-ID: <20250623130651.088647050@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Sanders <jsanders.devel@gmail.com>

[ Upstream commit 7f90d45e57cb2ef1f0adcaf925ddffdfc5e680ca ]

An aoe device's rq_list contains accepted block requests that are
waiting to be transmitted to the aoe target. This queue was added as
part of the conversion to blk_mq. However, the queue was not cleaned out
when an aoe device is downed which caused blk_mq_freeze_queue() to sleep
indefinitely waiting for those requests to complete, causing a hang. This
fix cleans out the queue before calling blk_mq_freeze_queue().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=212665
Fixes: 3582dd291788 ("aoe: convert aoeblk to blk-mq")
Signed-off-by: Justin Sanders <jsanders.devel@gmail.com>
Link: https://lore.kernel.org/r/20250610170600.869-1-jsanders.devel@gmail.com
Tested-By: Valentin Kleibel <valentin@vrvis.at>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/aoe/aoedev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 3523dd82d7a00..280679bde3a50 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -198,6 +198,7 @@ aoedev_downdev(struct aoedev *d)
 {
 	struct aoetgt *t, **tt, **te;
 	struct list_head *head, *pos, *nx;
+	struct request *rq, *rqnext;
 	int i;
 
 	d->flags &= ~DEVFL_UP;
@@ -223,6 +224,13 @@ aoedev_downdev(struct aoedev *d)
 	/* clean out the in-process request (if any) */
 	aoe_failip(d);
 
+	/* clean out any queued block requests */
+	list_for_each_entry_safe(rq, rqnext, &d->rq_list, queuelist) {
+		list_del_init(&rq->queuelist);
+		blk_mq_start_request(rq);
+		blk_mq_end_request(rq, BLK_STS_IOERR);
+	}
+
 	/* fast fail all pending I/O */
 	if (d->blkq) {
 		/* UP is cleared, freeze+quiesce to insure all are errored */
-- 
2.39.5




