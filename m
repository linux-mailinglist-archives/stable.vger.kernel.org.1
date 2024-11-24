Return-Path: <stable+bounces-94799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3B59D6F33
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8B9161F93
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EF21E47B3;
	Sun, 24 Nov 2024 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKvh1DtG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29501E47AC;
	Sun, 24 Nov 2024 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452451; cv=none; b=SQSl8EInXbC1+/oy7Xhilu8cNddSU+nlauXyKrNsEjNlNwQPn5OU76iXKEodXuhM+Vs3LaRzncB1amGdNF0XuFvCNpWu0wX3FvILrjTG9xObEvZIooLslhcqKiSthaif8qLbNglHrvM2wXEZw0dhv+6DIl4j/f7Fk/iN9dkeZFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452451; c=relaxed/simple;
	bh=ursMpZsRqCoSwV3YqfH654yZnUHf34LeoxAYVmozTzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mf7aqfR6ew6PiYQFpKoBqlHV7QxatJGh+OXA3LIC8+yQJ6BIXngorhh8WM4D96rj5EpL5vT0+Onc6UCDtQrPuUgNG7HLht0YWTt91xNNYb6tu8VeNXqBjHQ2UTBhAm0v5l3p1elase9M4fbEZtZ3P0p32mg4BXrbfPaY0m274x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKvh1DtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592EDC4CECC;
	Sun, 24 Nov 2024 12:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452451;
	bh=ursMpZsRqCoSwV3YqfH654yZnUHf34LeoxAYVmozTzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKvh1DtGyvqviuY6MSj6DWtt0/zjishOdsfxnZEErdJwd9z3riiMY5RkdOwpnoNSN
	 gvzJ9BXzrwATFxa0W7bdYSlV7ThuOEicmFY/BnVIZUBc/0PQmLnaeZWQfirAOl88e8
	 XIL52yykKqme1oiWdEPMiLQUhsoe9aGayxynifP4pv+DkxLarVkxuENeP0faAKhIY+
	 DRPAuZNu7HBLxYBgPa2YnfqSRXklmL3y0JML9x5R9TS25qCkonpcsYFCx+meJnfpgs
	 6tZVBOHS6d1zIxzZw5iEU2nUaEBC61gEp2LMTI9q0SNtD9RMyQ20zsgTGFkWo87xHF
	 t/L2O2/0+7kBA==
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
	rdunlap@infradead.org,
	paulmck@kernel.org
Subject: [PATCH AUTOSEL 5.15 2/2] timekeeping: Always check for negative motion
Date: Sun, 24 Nov 2024 07:47:24 -0500
Message-ID: <20241124124726.3338494-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124726.3338494-1-sashal@kernel.org>
References: <20241124124726.3338494-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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
index 2f6312e7ce81f..8bb3cb5d655ff 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -124,7 +124,6 @@ config X86
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
-	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
 	select DCACHE_WORD_ACCESS
 	select EDAC_ATOMIC_SCRUB
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 04bfd62f5e5ca..d9eb6892367e5 100644
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


