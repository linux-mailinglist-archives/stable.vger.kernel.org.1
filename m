Return-Path: <stable+bounces-77327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1DC985BD8
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04EAF2888C0
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515AC1C6F54;
	Wed, 25 Sep 2024 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GroY/WoG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF201C6F4E;
	Wed, 25 Sep 2024 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265189; cv=none; b=QlQ7cgJa9DJJ+OhlFR+RbtZi+ZN+WmdVt/V3VdVUk9vLO60iIaWxFIxIH3k/+C9u2HDhuvouCijKE2Gmtffz1hL7hA/9pitBFyWt/jZ/CoLRRD/NDaHHFXirJAyWBkYD6xhgnlpt72KvZSXSTrLRSKYY4ruqN2wk6YHCJYeB41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265189; c=relaxed/simple;
	bh=WXg0ymZZOk9PSTRvOkHmnxqWkiu8JFWKiKXodVZa+/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYMXav5VMRwlcvcFwUM/VJKRsGFDF9bYWBxCG6MCSc306JZR3j1eYgfYukLVEWg0Y4vcKd1X+xVIi67nFl5kOZS+q2BweV8LsHUoQn4uNLZHYu2vpaGQQDtVIGN0WfQ4IBKxTUW4iFpifFDhqhTFZ4gerEY8L09b0bXYJ/OUZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GroY/WoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DBFC4CEC7;
	Wed, 25 Sep 2024 11:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265188;
	bh=WXg0ymZZOk9PSTRvOkHmnxqWkiu8JFWKiKXodVZa+/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GroY/WoG2LWJ0MpIbNSdvpTm1nmFsxiEc0qj9/3PeI1gRaOYHHMQrw8lcxh4xlGAo
	 kQxbYwWhz5N42AH2+r7NtUmQ5yc7BdpWauuMjR1xyT4cn+IeOr0rriydSZwGbgmd2x
	 jXoEUOu6Q5cDw0XPpc816MxFWEVeL7czlA7hnpQuhKc/oQL9QcLbrSaHtg7HTLM9aL
	 2/9Sa8ZkptGvfd7P4SIRtpEXF1uDMnE7P3cHPd764TNHpj7+bkYAV2kJZ17HnfFIno
	 xycQu8kUQMOCewkyHfMNdpdTWKj7Z/AZ/UdMFXn5i7sX1atOlex63ctYQM/f4fvRJF
	 Ljx/cZlxd1ctw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Sasha Levin <sashal@kernel.org>,
	tytso@mit.edu,
	luto@kernel.org,
	vincenzo.frascino@arm.com
Subject: [PATCH AUTOSEL 6.11 229/244] random: vDSO: don't use 64-bit atomics on 32-bit architectures
Date: Wed, 25 Sep 2024 07:27:30 -0400
Message-ID: <20240925113641.1297102-229-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 81c6896049b6ca69a9e737656ac33b3fd96a277c ]

Performing SMP atomic operations on u64 fails on powerpc32:

    CC      drivers/char/random.o
  In file included from <command-line>:
  drivers/char/random.c: In function 'crng_reseed':
  ././include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_391' declared with attribute error: Need native word sized stores/loads for atomicity.
    510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |                                             ^
  ././include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
    491 |                         prefix ## suffix();                             \
        |                         ^~~~~~
  ././include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
    510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |         ^~~~~~~~~~~~~~~~~~~
  ././include/linux/compiler_types.h:513:9: note: in expansion of macro 'compiletime_assert'
    513 |         compiletime_assert(__native_word(t),                            \
        |         ^~~~~~~~~~~~~~~~~~
  ./arch/powerpc/include/asm/barrier.h:74:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     74 |         compiletime_assert_atomic_type(*p);                             \
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/asm-generic/barrier.h:172:55: note: in expansion of macro '__smp_store_release'
    172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
        |                                                       ^~~~~~~~~~~~~~~~~~~
  drivers/char/random.c:286:9: note: in expansion of macro 'smp_store_release'
    286 |         smp_store_release(&__arch_get_k_vdso_rng_data()->generation, next_gen + 1);
        |         ^~~~~~~~~~~~~~~~~

The kernel-side generation counter in the random driver is handled as an
unsigned long, not as a u64, in base_crng and struct crng.

But on the vDSO side, it needs to be an u64, not just an unsigned long,
in order to support a 32-bit vDSO atop a 64-bit kernel.

On kernel side, however, it is an unsigned long, hence a 32-bit value on
32-bit architectures, so just cast it to unsigned long for the
smp_store_release(). A side effect is that on big endian architectures
the store will be performed in the upper 32 bits. It is not an issue on
its own because the vDSO site doesn't mind the value, as it only checks
differences. Just make sure that the vDSO side checks the full 64 bits.
For that, the local current_generation has to be u64 as well.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/random.c | 9 ++++++++-
 lib/vdso/getrandom.c  | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 87fe61295ea1f..c12f906e05d61 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -281,8 +281,15 @@ static void crng_reseed(struct work_struct *work)
 	 * former to arrive at the latter. Use smp_store_release so that this
 	 * is ordered with the write above to base_crng.generation. Pairs with
 	 * the smp_rmb() before the syscall in the vDSO code.
+	 *
+	 * Cast to unsigned long for 32-bit architectures, since atomic 64-bit
+	 * operations are not supported on those architectures. This is safe
+	 * because base_crng.generation is a 32-bit value. On big-endian
+	 * architectures it will be stored in the upper 32 bits, but that's okay
+	 * because the vDSO side only checks whether the value changed, without
+	 * actually using or interpreting the value.
 	 */
-	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
+	smp_store_release((unsigned long *)&_vdso_rng_data.generation, next_gen + 1);
 #endif
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init = CRNG_READY;
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index e1db228bc4f0d..bacf19dbb6a11 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -68,8 +68,8 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
 	struct vgetrandom_state *state = opaque_state;
 	size_t batch_len, nblocks, orig_len = len;
 	bool in_use, have_retried = false;
-	unsigned long current_generation;
 	void *orig_buffer = buffer;
+	u64 current_generation;
 	u32 counter[2] = { 0 };
 
 	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags)) {
-- 
2.43.0


