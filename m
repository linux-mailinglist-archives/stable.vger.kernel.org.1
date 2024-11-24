Return-Path: <stable+bounces-94797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11969D6F29
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967B1280F58
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ECE1E3DEA;
	Sun, 24 Nov 2024 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2weku4F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242B21E3DE6;
	Sun, 24 Nov 2024 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452444; cv=none; b=nhZXLVOLjQ4d+cEqn2/x00M3FkBgabQV9m9fn0BtfBRVe0E8wFtlZTE5a7ymxVGKsUvfk6lUDcagjyK67GSbDCpRuCWd7nRQ0fdCv6W95VD4Rs0dkF5PJnv/aFDd+NLZQST7P5ovZMuMjUZYwuE6MLLWYbF0/r3+OpKooQ9Ovxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452444; c=relaxed/simple;
	bh=a2yY7BB1bsSU9ULkO/ssgmRLofsLG7VpYsJV0zstodc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeaRFxbp7tfgjky/MHVZRlVLUY43m9S2Otc23vL/PvSRNDwGmdx2XXzj/Ps3kOfgv84i5io0dGD5KAIxDkMLgcN6sW5loTL5uKReAb3jey8jL7LyP3nDXTQFWFOJ8B//euW3jT5nJGA2rZ7XN04BUkDO2n4STE24tklkF0LXqc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2weku4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FEBC4CECC;
	Sun, 24 Nov 2024 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452443;
	bh=a2yY7BB1bsSU9ULkO/ssgmRLofsLG7VpYsJV0zstodc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N2weku4FLqjq/Ap998I7JD5YW0L/JONnkjJrEzZp9ClRvveKRJ+13nxzKVS4HBKTH
	 HsWF2CFrxPXzLDkn3nKRkTO39R5fj089JQEKJ5NHRNTMMieJO5idx0CPauqV/uLUE8
	 ijVyOEBIdkp+deNKY8Ku/xCrY1CC4PVPd7buUPaYKYk27AvOshrNAWp8q55E9biysi
	 pMwBzY8mkhNSAWGxrUXT4nSwq1/d/NCDa1qpaZwOCIVu/xTzmvoy3RinrKe/lKLQ77
	 DhAUTvRj81+fXO93J+/Dy98KY/Iis69D4Fy9OoMe5gQ5DQfZaHhTaUhgAA71zpOPXL
	 CSZlr9FFBH3Ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	paulmck@kernel.org,
	rdunlap@infradead.org
Subject: [PATCH AUTOSEL 6.1 3/3] timekeeping: Always check for negative motion
Date: Sun, 24 Nov 2024 07:47:13 -0500
Message-ID: <20241124124715.3338418-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124715.3338418-1-sashal@kernel.org>
References: <20241124124715.3338418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit c163e40af9b2331b2c629fd4ec8b703ed4d4ae39 ]

clocksource_delta() has two variants. One with a check for negative motion,
which is only selected by x86. This is a historic leftover as this function
was previously used in the time getter hot paths.

Since 135225a363ae timekeeping_cycles_to_ns() has unconditional protection
against this as a by-product of the protection against 64bit math overflow.

clocksource_delta() is only used in the clocksource watchdog and in
timekeeping_advance(). The extra conditional there is not hurting anyone.

Remove the config option and unconditionally prevent negative motion of the
readout.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241031120328.599430157@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Kconfig                   | 1 -
 kernel/time/Kconfig                | 5 -----
 kernel/time/timekeeping_internal.h | 7 -------
 3 files changed, 13 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 49cea5b81649d..c75e18346c89b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -131,7 +131,6 @@ config X86
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
-	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
 	# Word-size accesses may read uninitialized data past the trailing \0
 	# in strings and cause false KMSAN reports.
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index a41753be1a2bf..6ce5b66643f0b 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -17,11 +17,6 @@ config ARCH_CLOCKSOURCE_DATA
 config ARCH_CLOCKSOURCE_INIT
 	bool
 
-# Clocksources require validation of the clocksource against the last
-# cycle update - x86/TSC misfeature
-config CLOCKSOURCE_VALIDATE_LAST_CYCLE
-	bool
-
 # Timekeeping vsyscall support
 config GENERIC_TIME_VSYSCALL
 	bool
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index 4ca2787d1642e..1d4854d5c386e 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -15,7 +15,6 @@ extern void tk_debug_account_sleep_time(const struct timespec64 *t);
 #define tk_debug_account_sleep_time(x)
 #endif
 
-#ifdef CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE
 static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
 {
 	u64 ret = (now - last) & mask;
@@ -26,12 +25,6 @@ static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
 	 */
 	return ret & ~(mask >> 1) ? 0 : ret;
 }
-#else
-static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
-{
-	return (now - last) & mask;
-}
-#endif
 
 /* Semi public for serialization of non timekeeper VDSO updates. */
 extern raw_spinlock_t timekeeper_lock;
-- 
2.43.0


