Return-Path: <stable+bounces-141093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428ACAAB096
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2BF7B96B4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A8E28FA82;
	Mon,  5 May 2025 23:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDR3WvuD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305FE3C10C0;
	Mon,  5 May 2025 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487439; cv=none; b=TihtJc2l+5126flRKPXswOO2Rgyzx13nuaaYIJF/0P+qB6sJRS5rd5Y1+WnYnV+TJprisOvn0Zdlx6CNjNQfMhchDn0CAFwKkuJ4YRvVa1443Biv4ClaBlLJ/kM1Vwi6vzXdcGKYFuc2CP1PLqxGt3DeUyTGowV7/LeUql8Bqxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487439; c=relaxed/simple;
	bh=qfKV+W5ZhWP6KZDtG+NrFbv8TSB5jQSMsewr3lGVykU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lMBONJ3lCUSPX2Ino1Vk/5fAs/urK4rD7xS36FpAoF5TNgZ6gHJWVwRzEt9oaeyVbX7m3uBz9eDFnDDJYyrFRr2qvgxEpK2Q4GKaVLzkqsHa5TUOoWyvyXEIsDuRyZ+ifozuWs+phGP5AHVcFMaLGlvY4CxyydRr64JwVfEuv8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDR3WvuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C3BC4AF0E;
	Mon,  5 May 2025 23:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487437;
	bh=qfKV+W5ZhWP6KZDtG+NrFbv8TSB5jQSMsewr3lGVykU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QDR3WvuD+WvaakUsbDA2AATH3IqLiglFdCBhyPX2AT4IQsUiZjB8fpcYvFI9GntKw
	 nrVxmYYpyalgPxK0gP2XrjuwNbuAd3n8rSQ7wMdVdriYTBTdmU4gjSxNnDo3qRaYfO
	 G5Y7UVDm7qPgMYgpqeKoXqBKI4ofyA1z2fUgusBjlbbwHgqDJb2yWs0N7/uljJ1ZkE
	 lh2qhESoRPxcRrQ59zxdWwREEsy7Ze2mGT7hfUG9Y/PvYRlY5h167e6r9vfQ4uJlBF
	 5q0lP+GdChQaQ0dFpL9y1av640wt4uy5QdPsbGgGgvw7G9497CC1/UC6EqGr+n57tE
	 uC+MKfkjbWgYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 71/79] rcu: fix header guard for rcu_all_qs()
Date: Mon,  5 May 2025 19:21:43 -0400
Message-Id: <20250505232151.2698893-71-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

[ Upstream commit ad6b5b73ff565e88aca7a7d1286788d80c97ba71 ]

rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
is conditioned on CONFIG_PREEMPTION.

With CONFIG_PREEMPT_LAZY, CONFIG_PREEMPTION=y does not imply
CONFIG_PREEMPT_RCU=y.

Decouple the two.

Cc: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/rcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 18b1ed9864b02..5d39875c6594e 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -53,7 +53,7 @@ void rcu_scheduler_starting(void);
 extern int rcu_scheduler_active __read_mostly;
 void rcu_end_inkernel_boot(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
-- 
2.39.5


