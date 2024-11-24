Return-Path: <stable+bounces-94804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 768F19D6F3C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4025160FAE
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E8C1E764E;
	Sun, 24 Nov 2024 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsStMmEC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CF01E6310;
	Sun, 24 Nov 2024 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452467; cv=none; b=JQGE6C1nmZBpME98hRxUDI3RVwVMKEiqWBD/q/FTVLMSUpoMl1eXbVK7s3LBuz3buXFD3gmqLSzOpu9WW7a5tOT1VaIqt4za/rI5Huxz166DkRIXjh3/lDRw7AswZvBCBfHlxwREdShmiKMk7Qs48lqnHQEynnveXbJ+eqdYkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452467; c=relaxed/simple;
	bh=5uggOGrABDxG54VYs5/2delijARElSD2ToZ+R0kTs28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uij+9qLG6k/KcUe//p5OX5H6YdOOHnxaRqpwGtBKlqvBTF0jSVZ8LFr29KldQsF0kS54mZmN7xqmwY8/pQaAIkbV5biNcTGEDtwkDyOqdOpUrN78qDWEmJvtplrrPcLVa1MStSZ1wSWs/5Uk6Yxd+Ss+ksDN6xdE1ECwAaRBvw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsStMmEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB90C4CECC;
	Sun, 24 Nov 2024 12:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452466;
	bh=5uggOGrABDxG54VYs5/2delijARElSD2ToZ+R0kTs28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EsStMmECTFfDzW3bOwWz4peSYMFId61AbGqQHOdviLVeGqoCbg6wM9XhNTiEyPlT3
	 gYGdTyIEaZhaf11Hlx22BDUnycsn1PsmLPOxT88YhnKZsoXNmvSkaeFOtBHoaOdpzr
	 K5P6tJmP1WWjf5wtt5LOAQTBa1w5uSxMSxu/Wen/ih/zBH9V8fS+BFXkVzuk8M3E7Q
	 /tYrqqxxVhMIZ/Z0GvU8gGuHVsCZp8LM3Bhuowb1A6O55/iqR3qqsXFrYpdtJvJH+f
	 flLrKkJQv4ERP5TYMuJFWtzaIiKDqz989W0gCq+4qH8KX8pSqH1Cy8g5Je1AFgmgA5
	 CTU5H1eNIy3fg==
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
Subject: [PATCH AUTOSEL 5.4 2/2] timekeeping: Always check for negative motion
Date: Sun, 24 Nov 2024 07:47:39 -0500
Message-ID: <20241124124741.3338607-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124741.3338607-1-sashal@kernel.org>
References: <20241124124741.3338607-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index df0a3a1b08ae0..a3e7f75a8cfa8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -99,7 +99,6 @@ config X86
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select BUILDTIME_EXTABLE_SORT
 	select CLKEVT_I8253
-	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
 	select DCACHE_WORD_ACCESS
 	select EDAC_ATOMIC_SCRUB
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index fcc42353f1253..4b9a8653a6327 100644
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
index bcbb52db22565..d7f99e69bce4b 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -13,7 +13,6 @@ extern void tk_debug_account_sleep_time(const struct timespec64 *t);
 #define tk_debug_account_sleep_time(x)
 #endif
 
-#ifdef CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE
 static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
 {
 	u64 ret = (now - last) & mask;
@@ -24,11 +23,5 @@ static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
 	 */
 	return ret & ~(mask >> 1) ? 0 : ret;
 }
-#else
-static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
-{
-	return (now - last) & mask;
-}
-#endif
 
 #endif /* _TIMEKEEPING_INTERNAL_H */
-- 
2.43.0


