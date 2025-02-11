Return-Path: <stable+bounces-114829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C28A30105
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C801665BA
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE5E26AF09;
	Tue, 11 Feb 2025 01:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEWHAEng"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A5F26AEE4;
	Tue, 11 Feb 2025 01:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237589; cv=none; b=EN4Sii+SCKOS2vX+b+Yns1nvrOyYNrbGFeX4Ubvzjd4lbWR3ekmelkAF3MVSoG3rwh5qGO4+LdVYBBC0AS1duE0xr/deUr/fe8uCts9qxrndc0FXh+7pPLgp574+/x8eLkK3RFPiXodMvg+IhGTYdRMgGPiZWFXDVmCjH5J0G9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237589; c=relaxed/simple;
	bh=oLpeTShy+L4zJ6dosfVi03wh3FpU4+0LgWQ9gE6LZbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mdFEKLc5+ow8tQk3XjF7GpdezNfDRd6R7Sv1ahrxFkGAApRBv2htJWOaey+gpKrpI9sySD+Pn7HaVsVKmIysbczitgJ/E1tYFZfQx6CU9g1XT7B9USYbXtYxY+vRg+n1aXJCelD5H6iJgrTrwxb6oNNhVoHA8jhdHG+IW/+zjKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEWHAEng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31956C4CED1;
	Tue, 11 Feb 2025 01:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237589;
	bh=oLpeTShy+L4zJ6dosfVi03wh3FpU4+0LgWQ9gE6LZbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KEWHAEngRpMmwyuNh0buO+aHEbhh8wTEI7Bzrb+QTZ9Gh1+XYaH3ciXMCuMGY1zjI
	 Fp2TcqGgFFj6pSyivs5BVUXHxu0X7dPvtlLrEeYV/7KzOa8JwvFj92wUK2N4X+P7oE
	 I4XAWcWWrMA3XKi/BUgqyz5aCPNH1kzDDHSDmPPRsUboyQmAg6TFEuBf/U6D3n/bb1
	 fE+HH10QQYPn7aEJ33xp/zrEvT4KmsJQQrI97GgxdfH2KZ5GX8a8Abr1nb0F2YxKb9
	 utSBFNAZjgJny8fTeMkos3jcjSiQ8LYM1Ja9nVcn6ghSXS0MBSzSniXrd9uQ6K+3vr
	 aJAPXFAqPEGsA==
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
Subject: [PATCH AUTOSEL 5.4 2/6] hrtimers: Mark is_migration_base() with __always_inline
Date: Mon, 10 Feb 2025 20:33:01 -0500
Message-Id: <20250211013305.4099014-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013305.4099014-1-sashal@kernel.org>
References: <20250211013305.4099014-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.290
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
index 539bc80787eeb..69713fa32437b 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -140,11 +140,6 @@ static struct hrtimer_cpu_base migration_cpu_base = {
 
 #define migration_base	migration_cpu_base.clock_base[0]
 
-static inline bool is_migration_base(struct hrtimer_clock_base *base)
-{
-	return base == &migration_base;
-}
-
 /*
  * We are using hashed locking: holding per_cpu(hrtimer_bases)[n].lock
  * means that all timers which are tied to this base via timer->base are
@@ -269,11 +264,6 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 
 #else /* CONFIG_SMP */
 
-static inline bool is_migration_base(struct hrtimer_clock_base *base)
-{
-	return false;
-}
-
 static inline struct hrtimer_clock_base *
 lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 {
@@ -1276,6 +1266,18 @@ static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base,
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


