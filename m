Return-Path: <stable+bounces-114768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F29A2A3005D
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE5A1887A6A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FB81D7E57;
	Tue, 11 Feb 2025 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRx2VJlG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1BB1EF0B6;
	Tue, 11 Feb 2025 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237453; cv=none; b=e17rgBffr9BgF1A2ySmRHSNa9dteHyc2l5udRjpHR88zubDgUDiMh2C0Z5ZBYlFVpLMTCApMhPBT1bX6qFWdvc1xWxRmTnpEhuLHB/buxF3wlh1K5NQ4ZpKqFeRjawD+p5LpHB6AjSs6mXf/EEPf7y4eJ48pzIU0aOQZXbZqt/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237453; c=relaxed/simple;
	bh=h+MX/w88KSHxw+4uEAbqjzp2aa5dH4olIjIBEjKu+wU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uh0xh3WzXuYlBi2oCiZvHJ0O7MoWQVfEL/DR87Nj710ZmfnBHVkbPOgc0qdL8Vo5SEmz5sS2HSPgFt0F3rSbwKJvLSTw8ckeLH6yxM0Wjz5c75tNqCG6DqZXFZ54hxqtI01D751LC+cbwk3k8GULgt3KEzSy3BbC1F3YT06jt0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRx2VJlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34021C4CEDF;
	Tue, 11 Feb 2025 01:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237453;
	bh=h+MX/w88KSHxw+4uEAbqjzp2aa5dH4olIjIBEjKu+wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRx2VJlGu5ecjKPmQNqVj/pQtfO5mfew8/q/7q1Z6h+1BsCyUWy8ziMdmWFxx/JY9
	 w5yv+uSIj5NtRPHPzW1K+3+8ILsYKkGHH8ULH8x4JV6sD9s414h+59sPA/n/tLgR0W
	 BqsiPdSQ+aCqP75gK10KedcQoFdDJ+unYBMZrB9KTxw8U/JiAVZj30fjL6h5v6Kw1Y
	 omsq4LhNqPGbKWgAGW/jo0gwEMT91wqBvGR8wORfrgm1kb0DMAdqhkbhtPmB8mH4Ff
	 7P283RX4d5qIadzhElZUGjaCuAebiPX9xVo8U25YutzzRbOWiNdxqUUUtNoX3fRFO9
	 0Gn3DbAZSK0Jg==
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
Subject: [PATCH AUTOSEL 6.12 03/19] hrtimers: Mark is_migration_base() with __always_inline
Date: Mon, 10 Feb 2025 20:30:31 -0500
Message-Id: <20250211013047.4096767-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013047.4096767-1-sashal@kernel.org>
References: <20250211013047.4096767-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.13
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
index ee20f5032a036..97275d006be10 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -145,11 +145,6 @@ static struct hrtimer_cpu_base migration_cpu_base = {
 
 #define migration_base	migration_cpu_base.clock_base[0]
 
-static inline bool is_migration_base(struct hrtimer_clock_base *base)
-{
-	return base == &migration_base;
-}
-
 /*
  * We are using hashed locking: holding per_cpu(hrtimer_bases)[n].lock
  * means that all timers which are tied to this base via timer->base are
@@ -275,11 +270,6 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 
 #else /* CONFIG_SMP */
 
-static inline bool is_migration_base(struct hrtimer_clock_base *base)
-{
-	return false;
-}
-
 static inline struct hrtimer_clock_base *
 lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 	__acquires(&timer->base->cpu_base->lock)
@@ -1380,6 +1370,18 @@ static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base,
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


