Return-Path: <stable+bounces-89749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 596C59BBE4B
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 20:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D211C20D08
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 19:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902071CCB44;
	Mon,  4 Nov 2024 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T5BCM6uy"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8081CBA1B;
	Mon,  4 Nov 2024 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750077; cv=none; b=XVZThmh2Shijuh5GCDYfmrSt1YHYVlUYDWSQ2Hl4aZlDQJcw9RgqdpbTV5y0gzLcw24MpmWjgBrT5VP+8hsmukct6Tfr0hWgRgifgbRH+Z4n4QqzTcBUHuueA+c9evXic5/DXgqFtuAjNBiWdz/AZPkgTKvmHZidAg0g4YXMyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750077; c=relaxed/simple;
	bh=bUHxveBeRivLpx35ZHbUy8KNqWJ45SG6g4FgI31Ccik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U6d/RVYt/C4DxQYx7nfPge0gYNCc3EWaY/a2j5pj8kvUQDyCLQJq040MPnDOKA6yT6kTluL2BKbWJedI1fVdSSnwwxX2VNkpt3s3aK5Rf3wHOb8GENKx3UJ9TGf4MJd5BV8IupUHBi2f0qlgKdH46/3RL7GUXrWJojF3YRdov98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T5BCM6uy; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730750073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xUwadZKGltAbqzkspqGKUFSXPyFFcPTvrmzdfG7uL9A=;
	b=T5BCM6uyYdId1euzQtmUJLZNa3H8N9S4jgH/dTNgQlDC3rJlpkpy/1KFewzBQhZ8yzSLDK
	DJE3EwgtrmpVLVhf7tJpbkPXgkU/y0iKhs1Ybao8HtP1Et2/4YRECHdFRVk2nRETENSJxx
	EBtZYQ9lw+h0ANjTEudzPs4qfAGAGcQ=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrei Vagin <avagin@google.com>,
	Kees Cook <kees@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Alexey Gladkov <legion@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] signal: restore the override_rlimit logic
Date: Mon,  4 Nov 2024 19:54:19 +0000
Message-ID: <20241104195419.3962584-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Prior to commit d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of
ucounts") UCOUNT_RLIMIT_SIGPENDING rlimit was not enforced for a class
of signals. However now it's enforced unconditionally, even if
override_rlimit is set. This behavior change caused production issues.

For example, if the limit is reached and a process receives a SIGSEGV
signal, sigqueue_alloc fails to allocate the necessary resources for the
signal delivery, preventing the signal from being delivered with
siginfo. This prevents the process from correctly identifying the fault
address and handling the error. From the user-space perspective,
applications are unaware that the limit has been reached and that the
siginfo is effectively 'corrupted'. This can lead to unpredictable
behavior and crashes, as we observed with java applications.

Fix this by passing override_rlimit into inc_rlimit_get_ucounts() and
skip the comparison to max there if override_rlimit is set. This
effectively restores the old behavior.

v2: refactor to make the logic simpler (Eric, Oleg, Alexey)

Fixes: d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Co-developed-by: Andrei Vagin <avagin@google.com>
Signed-off-by: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexey Gladkov <legion@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/user_namespace.h | 3 ++-
 kernel/signal.c                | 3 ++-
 kernel/ucount.c                | 6 ++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 3625096d5f85..7183e5aca282 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -141,7 +141,8 @@ static inline long get_rlimit_value(struct ucounts *ucounts, enum rlimit_type ty
 
 long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
 bool dec_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
-long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type);
+long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,
+			    bool override_rlimit);
 void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type);
 bool is_rlimit_overlimit(struct ucounts *ucounts, enum rlimit_type type, unsigned long max);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 4344860ffcac..cbabb2d05e0a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -419,7 +419,8 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
 	 */
 	rcu_read_lock();
 	ucounts = task_ucounts(t);
-	sigpending = inc_rlimit_get_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
+	sigpending = inc_rlimit_get_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING,
+					    override_rlimit);
 	rcu_read_unlock();
 	if (!sigpending)
 		return NULL;
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 16c0ea1cb432..49fcec41e5b4 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -307,7 +307,8 @@ void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type)
 	do_dec_rlimit_put_ucounts(ucounts, NULL, type);
 }
 
-long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
+long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,
+			    bool override_rlimit)
 {
 	/* Caller must hold a reference to ucounts */
 	struct ucounts *iter;
@@ -320,7 +321,8 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
 			goto unwind;
 		if (iter == ucounts)
 			ret = new;
-		max = get_userns_rlimit_max(iter->ns, type);
+		if (!override_rlimit)
+			max = get_userns_rlimit_max(iter->ns, type);
 		/*
 		 * Grab an extra ucount reference for the caller when
 		 * the rlimit count was previously 0.
-- 
2.47.0.199.ga7371fff76-goog


