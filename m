Return-Path: <stable+bounces-94801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD1E9D6F32
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B75C28185C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39031E4924;
	Sun, 24 Nov 2024 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/3Jwbn0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEF11E47DD;
	Sun, 24 Nov 2024 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452459; cv=none; b=gTX49DFerOzmGTne4H9FLze4szNuUrNRZSfuqa/JEmVSioMB3Wk61TlVzDxKu9urIYn6Eb7IIbE/OlzYFimvw5fajKoWZigRGjhsBpH/kZYn+IYwjoDG+tV5VQ/f5w5dV3C6feNF9a0FxAguhgknTPXGXfmKUTcY7IrGMmKOGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452459; c=relaxed/simple;
	bh=ttCOt0jBDmhYRap4VwYAB2ASolDkL1aMpZHI1JEHGlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ky2wSeEJifj/WXSJt9sJ98q/l0QUnQuc+yqbktCfQZyGqCrRX5+kG6EeV5ry9o8rKnLljmfFEbuP+MMae1TKdomg/EIS3OywFuipc1oFZR1kbCgeQSaJR9D9Vpb+ZLXdr3a8x4jrvwn9D17R5lfcxYbMi4JWCQmWIlsbvpv4d78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/3Jwbn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FA6C4CECC;
	Sun, 24 Nov 2024 12:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452459;
	bh=ttCOt0jBDmhYRap4VwYAB2ASolDkL1aMpZHI1JEHGlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/3Jwbn02kgfVUVjghVk1haCdfCtoo6gGlgcMpQ7W09KBAOg3P+WAT/lBABY6ZNji
	 PN5ZnJscVJOLDgOT1s7K5THsWIWx549v8wAODNaVyD2WWSwr0ddX7GLwbLM+QCEuvJ
	 Wv7tH7PnoXg5GVhW0a69glDiZDTjYrqk273KtCZ4nvXuBnih209jm2VmVKeZJHT+Vp
	 vK671xtiePJnso1FV6UF2urN/3YpjD/HPDevQ6+nnpHN9n90uRQnT/nax6udBHyrwo
	 2KIHkD8aI7faie/QX9Ql2HBY3Ta8y9Zq3JVB2Ia9onabsZzv615mrUIpV5BQEaeWOx
	 gJz+eMusY0B3Q==
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
Subject: [PATCH AUTOSEL 5.10 2/2] timekeeping: Always check for negative motion
Date: Sun, 24 Nov 2024 07:47:31 -0500
Message-ID: <20241124124733.3338551-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124733.3338551-1-sashal@kernel.org>
References: <20241124124733.3338551-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index 0c802ade80406..e71101ced756e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -107,7 +107,6 @@ config X86
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
-	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
 	select DCACHE_WORD_ACCESS
 	select EDAC_ATOMIC_SCRUB
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index a09b1d61df6a5..5cbedc0a06efc 100644
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


