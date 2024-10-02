Return-Path: <stable+bounces-79667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948D598D99D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFFF28937D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376271D0BB1;
	Wed,  2 Oct 2024 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TJ5Y1Rs3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2841D0787;
	Wed,  2 Oct 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878112; cv=none; b=B1BvDUGd7J2A7RuAAEffdEPLeuLXbBy7OArdHEz7Ja3T3zk+cQb8qXTW+7kYderLmuSkSlSDQuDVdfgLeJ/NRTor3J1tdwP0IYMxqCAOrXTCxjd24pk4amVFUQxcbGMzpZjxFtZNMeE3/R/k2P3eN5PVB7MPc/yOmQNazyYcLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878112; c=relaxed/simple;
	bh=OBq02CpbuiMIphaBXCNDERm5v7QSKiR9NB1xe25WzNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BO6rxLcNxTCHXdKzjqBEqz8WSy9mPweV2ska1fLEqBGIydO8DJGdq9I61Fd/TY3Yx93Rq9fRibJPvCyTWKYygocvb2xv/Is4QuJmQnCNbGW8YDx2M7b1LgvQikErJC8iFBK7gaBQSpSUaQ8iriRgjalBfYYpDqrRxEfIXCchnnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TJ5Y1Rs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752AEC4CEC2;
	Wed,  2 Oct 2024 14:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878111;
	bh=OBq02CpbuiMIphaBXCNDERm5v7QSKiR9NB1xe25WzNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TJ5Y1Rs3rd5QbMpet1eFu2z96Db5GJQmarJ3IXTrl+5uKZMryaJngSIE163QBrxV8
	 fL8XUfGpc8HTmVes5ROEV06/3Rjw89aYY6hYC+/LF2CfjZdPg2kbzxmEfy2e+UzwDn
	 oBhrmb3cYPX1ihJM/287ZnE+mdkFmX9coegjBQTk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huang Shijie <shijie@os.amperecomputing.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 275/634] sched/deadline: Fix schedstats vs deadline servers
Date: Wed,  2 Oct 2024 14:56:15 +0200
Message-ID: <20241002125821.956726152@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huang Shijie <shijie@os.amperecomputing.com>

[ Upstream commit 9c602adb799e72ee537c0c7ca7e828c3fe2acad6 ]

In dl_server_start(), when schedstats is enabled, the following
happens:

  dl_server_start()
    dl_se->dl_server = 1;
    enqueue_dl_entity()
      update_stats_enqueue_dl()
        __schedstats_from_dl_se()
          dl_task_of()
            BUG_ON(dl_server(dl_se));

Since only tasks have schedstats and internal entries do not, avoid
trying to update stats in this case.

Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20240829031111.12142-1-shijie@os.amperecomputing.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/deadline.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9bedd148f0075..09faca47e90fb 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1599,46 +1599,40 @@ static inline bool __dl_less(struct rb_node *a, const struct rb_node *b)
 	return dl_time_before(__node_2_dle(a)->deadline, __node_2_dle(b)->deadline);
 }
 
-static inline struct sched_statistics *
+static __always_inline struct sched_statistics *
 __schedstats_from_dl_se(struct sched_dl_entity *dl_se)
 {
+	if (!schedstat_enabled())
+		return NULL;
+
+	if (dl_server(dl_se))
+		return NULL;
+
 	return &dl_task_of(dl_se)->stats;
 }
 
 static inline void
 update_stats_wait_start_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 {
-	struct sched_statistics *stats;
-
-	if (!schedstat_enabled())
-		return;
-
-	stats = __schedstats_from_dl_se(dl_se);
-	__update_stats_wait_start(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+	struct sched_statistics *stats = __schedstats_from_dl_se(dl_se);
+	if (stats)
+		__update_stats_wait_start(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
 }
 
 static inline void
 update_stats_wait_end_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 {
-	struct sched_statistics *stats;
-
-	if (!schedstat_enabled())
-		return;
-
-	stats = __schedstats_from_dl_se(dl_se);
-	__update_stats_wait_end(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+	struct sched_statistics *stats = __schedstats_from_dl_se(dl_se);
+	if (stats)
+		__update_stats_wait_end(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
 }
 
 static inline void
 update_stats_enqueue_sleeper_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 {
-	struct sched_statistics *stats;
-
-	if (!schedstat_enabled())
-		return;
-
-	stats = __schedstats_from_dl_se(dl_se);
-	__update_stats_enqueue_sleeper(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+	struct sched_statistics *stats = __schedstats_from_dl_se(dl_se);
+	if (stats)
+		__update_stats_enqueue_sleeper(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
 }
 
 static inline void
-- 
2.43.0




