Return-Path: <stable+bounces-1200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157297F7E7D
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB0FAB216DA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29BC2E40E;
	Fri, 24 Nov 2023 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZaSji5iR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743CB364BA;
	Fri, 24 Nov 2023 18:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED7EC433C8;
	Fri, 24 Nov 2023 18:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850808;
	bh=3DnbFNRZiVQMSRBbkKYvh9t/MbTh2hD8uVjCreWvDuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZaSji5iRyzeWmEQxX4tJl2Uijf023J1q9mBMI6m0oL+vVeceCuhKISD2UPg5RrEKz
	 Hyh7+VOlzqm3dhOHFJrGGUpsKMoRzg/npl3/7+3+Osl2DkfeBR7oNJYkqujfR965Og
	 P4T0fc1WcvmBCKLsE9TKePPtoNEt8BjibbRzVOSE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 189/491] ptp: annotate data-race around q->head and q->tail
Date: Fri, 24 Nov 2023 17:47:05 +0000
Message-ID: <20231124172030.157436146@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 73bde5a3294853947252cd9092a3517c7cb0cd2d ]

As I was working on a syzbot report, I found that KCSAN would
probably complain that reading q->head or q->tail without
barriers could lead to invalid results.

Add corresponding READ_ONCE() and WRITE_ONCE() to avoid
load-store tearing.

Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Link: https://lore.kernel.org/r/20231109174859.3995880-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ptp/ptp_chardev.c | 3 ++-
 drivers/ptp/ptp_clock.c   | 5 +++--
 drivers/ptp/ptp_private.h | 8 ++++++--
 drivers/ptp/ptp_sysfs.c   | 3 ++-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 362bf756e6b78..5a3a4cc0bec82 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -490,7 +490,8 @@ ssize_t ptp_read(struct posix_clock *pc,
 
 	for (i = 0; i < cnt; i++) {
 		event[i] = queue->buf[queue->head];
-		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
+		/* Paired with READ_ONCE() in queue_cnt() */
+		WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
 	}
 
 	spin_unlock_irqrestore(&queue->lock, flags);
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 80f74e38c2da4..9a50bfb56453c 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -56,10 +56,11 @@ static void enqueue_external_timestamp(struct timestamp_event_queue *queue,
 	dst->t.sec = seconds;
 	dst->t.nsec = remainder;
 
+	/* Both WRITE_ONCE() are paired with READ_ONCE() in queue_cnt() */
 	if (!queue_free(queue))
-		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
+		WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
 
-	queue->tail = (queue->tail + 1) % PTP_MAX_TIMESTAMPS;
+	WRITE_ONCE(queue->tail, (queue->tail + 1) % PTP_MAX_TIMESTAMPS);
 
 	spin_unlock_irqrestore(&queue->lock, flags);
 }
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 75f58fc468a71..b8d4f61f14be4 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -76,9 +76,13 @@ struct ptp_vclock {
  * that a writer might concurrently increment the tail does not
  * matter, since the queue remains nonempty nonetheless.
  */
-static inline int queue_cnt(struct timestamp_event_queue *q)
+static inline int queue_cnt(const struct timestamp_event_queue *q)
 {
-	int cnt = q->tail - q->head;
+	/*
+	 * Paired with WRITE_ONCE() in enqueue_external_timestamp(),
+	 * ptp_read(), extts_fifo_show().
+	 */
+	int cnt = READ_ONCE(q->tail) - READ_ONCE(q->head);
 	return cnt < 0 ? PTP_MAX_TIMESTAMPS + cnt : cnt;
 }
 
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 6e4d5456a8851..34ea5c16123a1 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -90,7 +90,8 @@ static ssize_t extts_fifo_show(struct device *dev,
 	qcnt = queue_cnt(queue);
 	if (qcnt) {
 		event = queue->buf[queue->head];
-		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
+		/* Paired with READ_ONCE() in queue_cnt() */
+		WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
 	}
 	spin_unlock_irqrestore(&queue->lock, flags);
 
-- 
2.42.0




