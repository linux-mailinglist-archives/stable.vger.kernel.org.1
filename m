Return-Path: <stable+bounces-85558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC8399E7D6
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511A41C20C1F
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F081E6339;
	Tue, 15 Oct 2024 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PyIJ2Mze"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE1F19B3FF;
	Tue, 15 Oct 2024 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993517; cv=none; b=U8CW6BTGe/N6bXISFiScW1C74wLQ7i6SAU9Pr7RRbaCp6QD9jgUkY++g7WFK2s7vJQFh5Ee46udOJtkR/G0yTNeKnaf+8zefXDKPFhKy3NceVE0N73g/f9fIWpwnR0Jm816fBbjP7jfAUBoiSVVtE03sFaNW97THO+Q2od9c1K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993517; c=relaxed/simple;
	bh=8aGa9EN4w0hLGEKp+TWcmsqEqJ7lyK/4W8VO2dGSrR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMRp6dClph5YNWlWZFEPkeTQUcOt2nu2FMZTq86nwc1YpP5A45rWF7lTuk0t4fVU4/cFYaK5Xc/MJNO8FhFkXBxEMc/CFnUf0/8ug+dtfYY7wd6Ik6y1EzMEZNqMqxwQi3FW+2LQ/OjbeT9L3pBszvQbQNhXfj6HNKzsjn3mEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PyIJ2Mze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BC5C4CEC6;
	Tue, 15 Oct 2024 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993517;
	bh=8aGa9EN4w0hLGEKp+TWcmsqEqJ7lyK/4W8VO2dGSrR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PyIJ2Mze0R5WopCRbE0d58o6njBrmfoCm6BwMlgUNKtjDBr/8VwJYOD4Jdzol8M5U
	 W9X7iROTFrdk+mTyLyyR7UH4EM9Ks/oC3MP/qK3YpCEMOYqb/VtzUaDGZH5kg6QSPR
	 C7QzpH54YvS02dNGOr7ms8ix3HsiS0pE4Q09mE+0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 435/691] signal: Replace BUG_ON()s
Date: Tue, 15 Oct 2024 13:26:23 +0200
Message-ID: <20241015112457.606410210@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 7f8af7bac5380f2d95a63a6f19964e22437166e1 ]

These really can be handled gracefully without killing the machine.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/signal.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 08bccdbb1b463..8fc1da382448e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1932,10 +1932,11 @@ struct sigqueue *sigqueue_alloc(void)
 
 void sigqueue_free(struct sigqueue *q)
 {
-	unsigned long flags;
 	spinlock_t *lock = &current->sighand->siglock;
+	unsigned long flags;
 
-	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
+	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
+		return;
 	/*
 	 * We must hold ->siglock while testing q->list
 	 * to serialize with collect_signal() or with
@@ -1963,7 +1964,10 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	unsigned long flags;
 	int ret, result;
 
-	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
+	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
+		return 0;
+	if (WARN_ON_ONCE(q->info.si_code != SI_TIMER))
+		return 0;
 
 	ret = -1;
 	rcu_read_lock();
@@ -1982,7 +1986,6 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 		 * If an SI_TIMER entry is already queue just increment
 		 * the overrun count.
 		 */
-		BUG_ON(q->info.si_code != SI_TIMER);
 		q->info.si_overrun++;
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;
-- 
2.43.0




