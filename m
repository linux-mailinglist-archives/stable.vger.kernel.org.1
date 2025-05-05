Return-Path: <stable+bounces-140625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A68AAAA4D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F14F3B4CB0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75DF381EBE;
	Mon,  5 May 2025 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPwtUfwv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753D62D0AD2;
	Mon,  5 May 2025 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485453; cv=none; b=hdyBesMNxlLNEEnlPuApZXZP0a7bwbUHd2GP6TJ2pyY719WYJH/aEFhDsxIdt1ZWDG+l55OtjJyq8yTxmJfvadWI2m/63uicRPX6GuPzVIPe7TDS8PoYKNJkSTbo/k6yBQBs8a6isecOKUpTzTE+jfC4DDwqVLhWz74vrqxfbEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485453; c=relaxed/simple;
	bh=af6rOhANjnb0Paoo1pZ8H+1cHjwxV6bm3QUYbbdQ8AU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bK40+7N820iLuNmt5FwrlV4C/V7FZ4pksfjDY+mPpm6H9BjtjS/oUTkKpwavOzkKwbx74ZSe9QgTshQsCC30TlqaAOkCiyVNz/0iGmmUUlmk6hFWr6B5QogmyS7O/pff9oGXiTMvmR/L0viBsCkgxPUQbTkAMCBgoP38qMVdkac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPwtUfwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC49C4CEEF;
	Mon,  5 May 2025 22:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485451;
	bh=af6rOhANjnb0Paoo1pZ8H+1cHjwxV6bm3QUYbbdQ8AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cPwtUfwv70OyZ8b/Iq4Yx7XEe3mgHt4Q4vqK7TceSOjI+Yv6VfRPRg1yh67/nVmqJ
	 lYzcBbj2lX0XfeYXgvBid+Z1S34aNURDu089/q5/AHRtdfPv6il+7Cwxx5cCY9Vk2K
	 Hl89sl0bNBACWsgq3Zkl9xGL47r58ncHIfKLRMPpa7KNCthYNhKogNm6n6RLrXPDQd
	 Un+b5Lsd+GeReQeUhlQ0VoHitq1x7T2+g55P5bVMwuH5f5vthwjuTIesGMHYqhHtaa
	 ffL8B4v+oWRmIH/BjyS74LUTcaIOG/TYjFbc9SF2SiEnQ/DA2EGf48sQqBlxtrLZOQ
	 UiZhjPYc/k1Ug==
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
Subject: [PATCH AUTOSEL 6.12 318/486] hrtimers: Replace hrtimer_clock_to_base_table with switch-case
Date: Mon,  5 May 2025 18:36:34 -0400
Message-Id: <20250505223922.2682012-318-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 4441b976dfeff0d3579e8da3c0283300c618a553 ]

Clang and GCC complain about overlapped initialisers in the
hrtimer_clock_to_base_table definition. With `make W=1` and CONFIG_WERROR=y
(which is default nowadays) this breaks the build:

  CC      kernel/time/hrtimer.o
kernel/time/hrtimer.c:124:21: error: initializer overrides prior initialization of this subobject [-Werror,-Winitializer-overrides]
  124 |         [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,

kernel/time/hrtimer.c:122:27: note: previous initialization is here
  122 |         [0 ... MAX_CLOCKS - 1]  = HRTIMER_MAX_CLOCK_BASES,

(and similar for CLOCK_MONOTONIC, CLOCK_BOOTTIME, and CLOCK_TAI).

hrtimer_clockid_to_base(), which uses the table, is only used in
__hrtimer_init(), which is not a hotpath.

Therefore replace the table lookup with a switch case in
hrtimer_clockid_to_base() to avoid this warning.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250214134424.3367619-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/hrtimer.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index db9c06bb23116..06fbc226341fd 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -117,16 +117,6 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
 	.csd = CSD_INIT(retrigger_next_event, NULL)
 };
 
-static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
-	/* Make sure we catch unsupported clockids */
-	[0 ... MAX_CLOCKS - 1]	= HRTIMER_MAX_CLOCK_BASES,
-
-	[CLOCK_REALTIME]	= HRTIMER_BASE_REALTIME,
-	[CLOCK_MONOTONIC]	= HRTIMER_BASE_MONOTONIC,
-	[CLOCK_BOOTTIME]	= HRTIMER_BASE_BOOTTIME,
-	[CLOCK_TAI]		= HRTIMER_BASE_TAI,
-};
-
 static inline bool hrtimer_base_is_online(struct hrtimer_cpu_base *base)
 {
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
@@ -1597,14 +1587,19 @@ u64 hrtimer_next_event_without(const struct hrtimer *exclude)
 
 static inline int hrtimer_clockid_to_base(clockid_t clock_id)
 {
-	if (likely(clock_id < MAX_CLOCKS)) {
-		int base = hrtimer_clock_to_base_table[clock_id];
-
-		if (likely(base != HRTIMER_MAX_CLOCK_BASES))
-			return base;
+	switch (clock_id) {
+	case CLOCK_REALTIME:
+		return HRTIMER_BASE_REALTIME;
+	case CLOCK_MONOTONIC:
+		return HRTIMER_BASE_MONOTONIC;
+	case CLOCK_BOOTTIME:
+		return HRTIMER_BASE_BOOTTIME;
+	case CLOCK_TAI:
+		return HRTIMER_BASE_TAI;
+	default:
+		WARN(1, "Invalid clockid %d. Using MONOTONIC\n", clock_id);
+		return HRTIMER_BASE_MONOTONIC;
 	}
-	WARN(1, "Invalid clockid %d. Using MONOTONIC\n", clock_id);
-	return HRTIMER_BASE_MONOTONIC;
 }
 
 static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
-- 
2.39.5


