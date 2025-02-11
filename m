Return-Path: <stable+bounces-114821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCECA300ED
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7DD1887D3A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B040253B43;
	Tue, 11 Feb 2025 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuXggJYH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9912638B2;
	Tue, 11 Feb 2025 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237572; cv=none; b=a2bYgFnJc4IMz8KvBOpJd1xMOsM0oc00fnMGqrROhA7+wI5jqu5gaPjjk7OEbZ3EjV8Ste3FVDc6uUa8LkXu0TvFIb+JYKgLlZL+R0VJCskMGfKiFaV0gpgARkyMW6iWTAw0NQV1NCZf8nNxBzhXpr27GkhVlairBMECjlQkOI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237572; c=relaxed/simple;
	bh=cLtRJnDZFOfI/+RVHSMPiXwMeY16TknHn0hFWvnDLjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nLxGKESVMaPyCTDA//cvsjKNTYmH9+uNz4X8Bi14GOaSOaIzsD8iIL2eyA/DgsQ1KvlohRg5DJArvDL72kc0tc5YNixqhrHZ6KqqFhIrHLS8Ynd7ShDZp3i+BCuf4N371M3/5vsSz7WSwLFhHkRix4ByjKo2fk86aq1WAAeoBDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuXggJYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30C4C4CEDF;
	Tue, 11 Feb 2025 01:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237572;
	bh=cLtRJnDZFOfI/+RVHSMPiXwMeY16TknHn0hFWvnDLjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HuXggJYHnmGgIQjrHXgjzpKNgXHBM5ZlCmy7uyd61ck9BJWWKWycb2hsJwKU7VotE
	 b9Mfn4hIfQRC4h9EGDY3Rw1wvh0QD6cnYy5w7piUyuj2wSL/71RFHfVw2Z9DofrsdR
	 vAYpYAZbUJxikOQneYbry2H2lBqptJIEh4x9maeSvN3Jqzktmr0BK8iHEARO/4jWrI
	 ERxPgVBSepadDERcQKi7wE2D+qAQcTQiMa3HBNB/snLN9UEKrYLL9FXVi0Eu1G6GHG
	 KGj1LraNZm+DosEyQ31zPlcIsUV6VfnwVckNmKtg8p2WWG5bql++fGmkDAY9oPuo0z
	 OLQ7LkII9tRMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	nathan@kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 2/8] hrtimers: Mark is_migration_base() with __always_inline
Date: Mon, 10 Feb 2025 20:32:42 -0500
Message-Id: <20250211013248.4098848-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013248.4098848-1-sashal@kernel.org>
References: <20250211013248.4098848-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 27af31e44949fa85550176520ef7086a0d00fd7b ]

When is_migration_base() is unused, it prevents kernel builds
with clang, `make W=1` and CONFIG_WERROR=y:

kernel/time/hrtimer.c:156:20: error: unused function 'is_migration_base' [-Werror,-Wunused-function]
  156 | static inline bool is_migration_base(struct hrtimer_clock_base *base)
      |                    ^~~~~~~~~~~~~~~~~

Fix this by marking it with __always_inline.

[ tglx: Use __always_inline instead of __maybe_unused and move it into the
  	usage sites conditional ]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250116160745.243358-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/hrtimer.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 7f9f2fc183fe3..c202488695c46 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -144,11 +144,6 @@ static struct hrtimer_cpu_base migration_cpu_base = {
 
 #define migration_base	migration_cpu_base.clock_base[0]
 
-static inline bool is_migration_base(struct hrtimer_clock_base *base)
-{
-	return base == &migration_base;
-}
-
 /*
  * We are using hashed locking: holding per_cpu(hrtimer_bases)[n].lock
  * means that all timers which are tied to this base via timer->base are
@@ -273,11 +268,6 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 
 #else /* CONFIG_SMP */
 
-static inline bool is_migration_base(struct hrtimer_clock_base *base)
-{
-	return false;
-}
-
 static inline struct hrtimer_clock_base *
 lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 {
@@ -1275,6 +1265,18 @@ static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base,
 	}
 }
 
+#ifdef CONFIG_SMP
+static __always_inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return base == &migration_base;
+}
+#else
+static __always_inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return false;
+}
+#endif
+
 /*
  * This function is called on PREEMPT_RT kernels when the fast path
  * deletion of a timer failed because the timer callback function was
-- 
2.39.5


