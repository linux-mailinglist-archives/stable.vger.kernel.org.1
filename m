Return-Path: <stable+bounces-89447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015D29B841E
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 21:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3425D1C221A2
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 20:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F3D1CC89A;
	Thu, 31 Oct 2024 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MQkQ4vpj"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9083C1CC897
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730405104; cv=none; b=F1yrL09JQasHCwgezf4ov9wKf/vSfHXLbMkY9oOIDhPkYyupWKVTvZAHvsnemCFY9E+fAzFNm2jVJOChGHA5CCszqihqSxlSk+Ds08xj4Rq+kpkdCgMG0CWjpNvCPuh0Yb/gex/4rdBnRDLteDtwhO0IexqlYoaSDPO1stcamWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730405104; c=relaxed/simple;
	bh=fmvdPe7Xqvw35e8475LMA7hTK57Z/W159GPPmX2ajhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EATjnzNBwmlJUSq6WIf6c8CSUyD4bUr5P+y+vk+qzeg8xYXXrr+2wYAHsm9Nm7YihdfZXlydqLXX+dveC3g/YRfIbppX3ZFI5lQHn5iQRjl6nTuIzppVkIGE6CjW/0oB5L4vZ+D9TOc3bDdr3mL5IbVA0M2xX/U1+5elDV/WPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MQkQ4vpj; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730405099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A7L9CUWVM54y7lE4x9OSE5ACsKWIejbvvXMBTey286M=;
	b=MQkQ4vpjYQiUThJMXLRIiylukdNwdyqOgJtdP/0yxAInpg+9AIBY2k4JorbVzqwAoT6r4r
	VzVn7LHW8uqOh/0MxrSCQrZRerwmZ8vY9evfC3VV5jSwLdAsFCT/lXhTIt5nyBcLKwQSjR
	RAQJFloQgjZt5ZvD9VXfH9gopfnDRp0=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Andrei Vagin <avagin@google.com>,
	Kees Cook <kees@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Alexey Gladkov <legion@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] signal: restore the override_rlimit logic
Date: Thu, 31 Oct 2024 20:04:38 +0000
Message-ID: <20241031200438.2951287-1-roman.gushchin@linux.dev>
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

Fixes: d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Co-developed-by: Andrei Vagin <avagin@google.com>
Signed-off-by: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexey Gladkov <legion@kernel.org>
Cc: <stable@vger.kernel.org>
---
 include/linux/user_namespace.h | 3 ++-
 kernel/signal.c                | 3 ++-
 kernel/ucount.c                | 5 +++--
 3 files changed, 7 insertions(+), 4 deletions(-)

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
index 16c0ea1cb432..046b3d57ebb4 100644
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
@@ -316,7 +317,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
 
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
 		long new = atomic_long_add_return(1, &iter->rlimit[type]);
-		if (new < 0 || new > max)
+		if (new < 0 || (!override_rlimit && (new > max)))
 			goto unwind;
 		if (iter == ucounts)
 			ret = new;
-- 
2.47.0.163.g1226f6d8fa-goog


