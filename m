Return-Path: <stable+bounces-187866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59EABEDAB3
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 21:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853C4407C2C
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 19:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2975E2580F9;
	Sat, 18 Oct 2025 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiGi7eDp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4D118DB26
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760816192; cv=none; b=KkiyT4Uk/4vrTzvV06JQmAf7oNWml/FXnANKrAUMrqOPIMfikce56jYXcvSMc4C63d7j9DZjf2Xj6ov4/3Zn8GyfdJCyUuObBpDmuoXqhzoevAIf0ieSWK9A67GeUzhyvM/YIxC9O12Nhyl5o47DOxnQJdPC6CTuEdjuoWYUBQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760816192; c=relaxed/simple;
	bh=SVvD6qO63jbT6fdD9L4BUkF7AiFs7qDHxv2xfEgsHl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pK9vpuKcdHk6oo/NMw7NBjjImED9efsbVjPxXSLxKNm6e6nzXTf4eWQdSiweSbyyK3/IYnssUKxgSqFeXY9GM3IJvKW2Cb1p9HW+BJEMDrI6OC9GSaRumDtvo/gAvwNDXE0KQ+qavZdiXr9KRsJjAhYcQhsTB2m5i/5e+aV6i1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiGi7eDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D064BC4CEF8;
	Sat, 18 Oct 2025 19:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760816191;
	bh=SVvD6qO63jbT6fdD9L4BUkF7AiFs7qDHxv2xfEgsHl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tiGi7eDp6CidN7tM5n5dW2928OxVKFiTYedMiJwOpLP/zN1FvkcxQRSdkgl5pTRMl
	 dY6ScoyEcHbz2rOqxlgt6z4Tw6ci4bo/XtfT4uzv0uZKkpskM922aM6WQ/3p6neD7b
	 gbQTGaPAIL8+Y0qR3mmhneYQMWFd3D6tJvGqTDTETnRmBE0CH8m3cZiOhwyORzVplE
	 p8hY095PGl/KMMyoQ3dKfItWnfDOwS2jHaFLt+/VSsm+GffU9Qr5diJe427BTeqXCC
	 mqjmH8NhYPiC52ZNwV+nOhegNwqoDB7cRK0uZxn6r53yF+b2ykakpyow5d2RWO/wlu
	 QyI8U0jiztZrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huang Xiaojia <huangxiaojia2@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] epoll: Remove ep_scan_ready_list() in comments
Date: Sat, 18 Oct 2025 15:36:27 -0400
Message-ID: <20251018193629.891117-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101614-turbofan-sufferer-957e@gregkh>
References: <2025101614-turbofan-sufferer-957e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Huang Xiaojia <huangxiaojia2@huawei.com>

[ Upstream commit e6f7958042a7b1dc9a4dfc19fca74217bc0c4865 ]

Since commit 443f1a042233 ("lift the calls of ep_send_events_proc()
into the callers"), ep_scan_ready_list() has been removed.
But there are still several in comments. All of them should
be replaced with other caller functions.

Signed-off-by: Huang Xiaojia <huangxiaojia2@huawei.com>
Link: https://lore.kernel.org/r/20240206014353.4191262-1-huangxiaojia2@huawei.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 0c43094f8cc9 ("eventpoll: Replace rwlock with spinlock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 6b2d655c1cefc..0f6107827c6c5 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -206,7 +206,7 @@ struct eventpoll {
 	 */
 	struct epitem *ovflist;
 
-	/* wakeup_source used when ep_scan_ready_list is running */
+	/* wakeup_source used when ep_send_events or __ep_eventpoll_poll is running */
 	struct wakeup_source *ws;
 
 	/* The user that created the eventpoll descriptor */
@@ -1190,7 +1190,7 @@ static inline bool chain_epi_lockless(struct epitem *epi)
  * This callback takes a read lock in order not to contend with concurrent
  * events from another file descriptor, thus all modifications to ->rdllist
  * or ->ovflist are lockless.  Read lock is paired with the write lock from
- * ep_scan_ready_list(), which stops all list modifications and guarantees
+ * ep_start/done_scan(), which stops all list modifications and guarantees
  * that lists state is seen correctly.
  *
  * Another thing worth to mention is that ep_poll_callback() can be called
@@ -1792,7 +1792,7 @@ static int ep_send_events(struct eventpoll *ep,
 			 * availability. At this point, no one can insert
 			 * into ep->rdllist besides us. The epoll_ctl()
 			 * callers are locked out by
-			 * ep_scan_ready_list() holding "mtx" and the
+			 * ep_send_events() holding "mtx" and the
 			 * poll callback will queue them in ep->ovflist.
 			 */
 			list_add_tail(&epi->rdllink, &ep->rdllist);
@@ -1945,7 +1945,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		__set_current_state(TASK_INTERRUPTIBLE);
 
 		/*
-		 * Do the final check under the lock. ep_scan_ready_list()
+		 * Do the final check under the lock. ep_start/done_scan()
 		 * plays with two lists (->rdllist and ->ovflist) and there
 		 * is always a race when both lists are empty for short
 		 * period of time although events are pending, so lock is
-- 
2.51.0


