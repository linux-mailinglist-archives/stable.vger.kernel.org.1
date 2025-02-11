Return-Path: <stable+bounces-114812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F3BA300D4
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7C4C7A31E6
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016AA263897;
	Tue, 11 Feb 2025 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHLxqCtV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4026388E;
	Tue, 11 Feb 2025 01:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237554; cv=none; b=f10edjJmIJIUf6526e1Lol6cM04CpI57sE5B5s2gjVnZUGQA9+IOgS73KGI1dOmFx4LSUaNsyl/815HnSYrVJpCX6x5xvzrU4MT2CnrFyNN6BZOA1h5zBfu54D2smUG2NhllcT8YZB+m+d3X5ZStbo9PcAKqY/lWFMacXFDiWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237554; c=relaxed/simple;
	bh=iJM/BkHOOiDUwVk/pi5I+xr39ipAd/ueIcBanvIMLsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QAOngI0qSAB/mW4z/pasa+4JAJGiUPmfwjV4DMOl9BgbVv79msAyn6Rn4yYYn7DMjIvDDfD1y2A+wH9tskrSyYnrAeUV7UvRfKKYr+0uje/ny6+iU8PDIRyPtLpdno8hATWa0zhuIXYgAgGb7v1D3NsIWhplJG5dFT7a5+Jce7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHLxqCtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F3CC4CEE9;
	Tue, 11 Feb 2025 01:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237554;
	bh=iJM/BkHOOiDUwVk/pi5I+xr39ipAd/ueIcBanvIMLsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHLxqCtVAaNUIbWW5/01oRo7zYRsrj9qc8jSofBThMtlA7i4W4bQ0JaYhARQ8Dk49
	 37iwiIlsvlt756zT9cRACri+XAF5L9LKU2eN/LroR3WgJXL9Dem8osO393mhe+uGFP
	 BcUfO9J7LJSMSz5BiwCQaZJAIOYv7gyRY65qUUEJdieJNMmpTYNtGiHVxRawf14YQQ
	 tCVrOgLHLQJvyUkWrFfefGQGrQ65CL4+z5xXBgVnPehFkftHsI2gLNeo9EbPAWGoWM
	 hS5IxdipKC5neRbscrlJvEeuK7Yp75JCOKxiJtjmXMG2DUMii5HscsMPpbvoSs+pB8
	 SOgzgPADgQ3Hw==
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
Subject: [PATCH AUTOSEL 5.15 2/9] hrtimers: Mark is_migration_base() with __always_inline
Date: Mon, 10 Feb 2025 20:32:23 -0500
Message-Id: <20250211013230.4098681-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013230.4098681-1-sashal@kernel.org>
References: <20250211013230.4098681-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
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
index 9e91f69012a73..2e4b63f3c6dda 100644
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
@@ -1377,6 +1367,18 @@ static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base,
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


