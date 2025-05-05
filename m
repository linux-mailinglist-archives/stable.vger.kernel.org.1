Return-Path: <stable+bounces-140150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9172AAA5A5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01256188BE1B
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51059313CBD;
	Mon,  5 May 2025 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOu3/4hC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85D313CB1;
	Mon,  5 May 2025 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484237; cv=none; b=iwJ2v9E5WEFhAqHnKCQ56MGFCaIL2tN7FUdp7B5SG2Nh9Z6hUZ1H+eRxLd0Wc/ooPV1W0NpOGd+O1JHqFN2q6hNeMsOe+Izrx0KfYGXkum/LcenHDkaBKTS0ElnYvlIKoqyPYE42+sTUVMg4WEHa3w9Ta2akmHEHnzMaUsWGvbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484237; c=relaxed/simple;
	bh=m4ZVMVdY4a4HMDkk2RGYkepM0RUcYxp1FAQSAG5tuFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIJUrDMsDIfCdTvcKAhOKUPpgBz1EWkOk5JPY5ZmVuvOsBMtTiInTRk9dUs8AHuoRPXcAxLIjPawXxBMPkJ1vPIhn7y5YFxy7ehS0elTvqYJatwhNjzf3qJE9HU0agD/dCXvNn9m0InLK3khodU7UUEYjUqDZRwDM3OZkLufnIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOu3/4hC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D1FC4CEED;
	Mon,  5 May 2025 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484236;
	bh=m4ZVMVdY4a4HMDkk2RGYkepM0RUcYxp1FAQSAG5tuFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fOu3/4hCoSbj/nnSvLnPPvRXiugZXnPSHqFP0rHiBNHg7djESE1G0a6DiFEVIKLRs
	 fwYPYnepx2NC4QK54tzKdPW2vtaOWmUUkUKA/lst2fcVZBkgiPnXX1kZlrDZRFxHzO
	 0vOdOUNyXVqwTp8VifWWs27FYNUpCmIy6hXAP4LMyg2fLDqJFB+mfcDLVr0LSwyWc3
	 y0Hd6EEOLfphlWkQ0nLJZ0HgKbPtACbVMQexgkVIDVT5VioqvYWjTPdQLWibj67U+a
	 x4M7wlLjzHjU4DHcMFpjCvLaDIDsH0N2NAN3v0SJioaB3fben1XVCv+PN/4lzXmOVz
	 4Imct8KGaC5/Q==
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
Subject: [PATCH AUTOSEL 6.14 403/642] hrtimers: Replace hrtimer_clock_to_base_table with switch-case
Date: Mon,  5 May 2025 18:10:19 -0400
Message-Id: <20250505221419.2672473-403-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index deb1aa32814e3..453dc76c93484 100644
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
@@ -1587,14 +1577,19 @@ u64 hrtimer_next_event_without(const struct hrtimer *exclude)
 
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
 
 static enum hrtimer_restart hrtimer_dummy_timeout(struct hrtimer *unused)
-- 
2.39.5


