Return-Path: <stable+bounces-62021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA8D93E20E
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 02:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6BF1F21A3F
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 00:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5682A1482F5;
	Sun, 28 Jul 2024 00:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loQTUp7I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318A1482E6;
	Sun, 28 Jul 2024 00:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127747; cv=none; b=T6pxC7/L0wSya3BYt8lnzSoSNmfkbLkY25qe7UxGarGBNA/KCB5sMnvt96LrFtAAlZ0Z7UTDFFdOPUlg8jougJIgJridvwL+6nsYSnsgkhRW6RQXLDCRgo2PKBLeMGwNejhq95n0WZ8vwRID75aKQKbkxQEjbLLEzElj6KpbBbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127747; c=relaxed/simple;
	bh=DQ3EGMYH3xEK71gRrN+2pTzCzyUMW+9aupaJNbPi4vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfE4apUVe5kcqwg9VDJ1aVwRv06z5MTipHfumg6WV882YDj4r5f6JbvGEyxwQcE2HjLFplJ4A50tEcIT0LEiIIrmkn/i/Bu7sirTT4zTAiB4ehSmBBaxmwD89F04Y8eRe/Tg0WgBGViVL9ahpF3GOsk1/KUfvcm2GlizTn9XKQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loQTUp7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89E8C4AF07;
	Sun, 28 Jul 2024 00:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127746;
	bh=DQ3EGMYH3xEK71gRrN+2pTzCzyUMW+9aupaJNbPi4vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=loQTUp7I6rRegQ8slmO+nABJ72fDmTDNcxBnR841Pf8fZvSNp5f4L8EiWSTwdk2cr
	 qpO4egM1h+CjlQuOMcA2T74DSH+k4MctF4J0nZrp24AGWmmLrcboGCO6SO1aq6gnSV
	 5gn0ENZDXM/ccLg48niVjm8kyamJYj1y3L2QGSPTATbSmrqm5PZ+YMQUpWQe53n5Qr
	 j51dQ540kndpkZIg8WRtB/PqYekbu435Pjh9Zsb5+/3zPYrklMSPyQZ3VK7z2Shx9Q
	 NXmoY6Pe8+HUjxWx96DYvjzus0mNdEb8tOEKnukgNzU/eZpX8Q8pVXUYO1SS42HDRq
	 CcvdSQSiHhlaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	kasan-dev@googlegroups.com,
	Sasha Levin <sashal@kernel.org>,
	dave@stgolabs.net,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/6] rcutorture: Fix rcu_torture_fwd_cb_cr() data race
Date: Sat, 27 Jul 2024 20:48:55 -0400
Message-ID: <20240728004901.1704470-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004901.1704470-1-sashal@kernel.org>
References: <20240728004901.1704470-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 6040072f4774a575fa67b912efe7722874be337b ]

On powerpc systems, spinlock acquisition does not order prior stores
against later loads.  This means that this statement:

	rfcp->rfc_next = NULL;

Can be reordered to follow this statement:

	WRITE_ONCE(*rfcpp, rfcp);

Which is then a data race with rcu_torture_fwd_prog_cr(), specifically,
this statement:

	rfcpn = READ_ONCE(rfcp->rfc_next)

KCSAN located this data race, which represents a real failure on powerpc.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: <kasan-dev@googlegroups.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9f505688291e5..5c4bdbe76df04 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1867,7 +1867,7 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
 	spin_lock_irqsave(&rfp->rcu_fwd_lock, flags);
 	rfcpp = rfp->rcu_fwd_cb_tail;
 	rfp->rcu_fwd_cb_tail = &rfcp->rfc_next;
-	WRITE_ONCE(*rfcpp, rfcp);
+	smp_store_release(rfcpp, rfcp);
 	WRITE_ONCE(rfp->n_launders_cb, rfp->n_launders_cb + 1);
 	i = ((jiffies - rfp->rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
 	if (i >= ARRAY_SIZE(rfp->n_launders_hist))
-- 
2.43.0


