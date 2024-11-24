Return-Path: <stable+bounces-94785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2179D6F11
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7404C281812
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F5A1917ED;
	Sun, 24 Nov 2024 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSYhaMbI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E061E2039;
	Sun, 24 Nov 2024 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452398; cv=none; b=AA2zyPea/7g7m0zVQOvN4gfJJjSBXZB27NXaILcHbj+aVZhbKyYlTMzAgw1hxyO8o3BeYQ85boz+x1B4ybe0k9eKef8DVBGmyYDMiHehovBzIHdVCRlLKZhfmuCS/1vlGAyXYAa9qiGMdramp2H5Y1iyU79K425L++GQFyn+ALU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452398; c=relaxed/simple;
	bh=avy8Ko/HFA85hVi0V0aNqe0BratBVFdkgsMZUcyFfZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOV2XwoOovSGA5mnW03Z5Dk438qSB86d1IOviIvxhEAU5Xtlm255bSF4QK4qNDd4s9DUU3vYmeb+v1RUpIPGOYj35V7D9yR3XHmh3y4hdkPkETvmFAULYMEKVJRCKjxMjAGN/ulpahzzATGF65QZZ9Z+Xkw24KhRGqF5m+TWmTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSYhaMbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823B8C4CECC;
	Sun, 24 Nov 2024 12:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452397;
	bh=avy8Ko/HFA85hVi0V0aNqe0BratBVFdkgsMZUcyFfZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GSYhaMbIR7xnNQuRKm09tpwMSIkcMjS2skBabYecn0bzkhYRFRBLVYWsRjPUIPOqk
	 J5OywifSocz/rnGsQ2D1tTMBe6Fgn69BO7sdcCHg73B6srOSrqugXrYbZwZiOGh4f/
	 6/mwWvgDMktUWZUhS46TICoLvbUOKlBst42Uwg/SCCFnss0Img3I1qjDgt/QJrFUiZ
	 WExpxNykr3C2v6tUCpdWRGaoqMRGE0ptypqgNkxr6rG3DR1BJgoTrpUkcvARfQ7rDU
	 u2cYdlwKLLNBNqX7lSMPluPjuKWFunHklp1eRNmIPAR+63w5D0psqb1MaTk2vsHHCz
	 l+e1eDQLX1MWQ==
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
Subject: [PATCH AUTOSEL 6.12 5/5] timekeeping: Always check for negative motion
Date: Sun, 24 Nov 2024 07:46:17 -0500
Message-ID: <20241124124623.3337983-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124623.3337983-1-sashal@kernel.org>
References: <20241124124623.3337983-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 7b9a7e8f39acc..171be04eca1f5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -145,7 +145,6 @@ config X86
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
-	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
 	# Word-size accesses may read uninitialized data past the trailing \0
 	# in strings and cause false KMSAN reports.
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 8ebb6d5a106be..b0b97a60aaa6f 100644
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


