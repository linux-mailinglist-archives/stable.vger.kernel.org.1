Return-Path: <stable+bounces-220548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFQvGO88o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:07:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BFF1C69F8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F46B3400D06
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0900B3D2452;
	Sat, 28 Feb 2026 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/VKSl4l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2053D47FB;
	Sat, 28 Feb 2026 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300430; cv=none; b=CRpGfwZ8OHXyJ1Dg1EGS43i77vgMMLa8FZ2boZwXAfaBE+tjwBUuaZFIDZ2zO5gjiKEeLvusExrXCDrR5W8jo+w9Dpm2oVDWLXMGmZsdOt9BwzkIOPwU9DQvCzOQKQSMyGQ95fU/qQRtyuBy8mzqduJdkylTaKUJzNGd4DNABVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300430; c=relaxed/simple;
	bh=baLELUhdSxS/P2kMWgbDYgUhWZDPxAux4hCEsjWRBz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cF+tW/sBpnoJwF9NpfkEilA2JmPVjUMBGHNvAL9QUNRBx3Q+5pQ3oMJT6YA0CRhfrDwAW0K7bEChbk0l1jFmEWjdt0U7FuYvFkcM3ZVNJzcZWPQzdri0YfjK+9/j/dEjXY5PulrcOsGVgyrwgU+Z/VpBd6hE4YjGmLOCr9kP4rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/VKSl4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B16C19423;
	Sat, 28 Feb 2026 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300430;
	bh=baLELUhdSxS/P2kMWgbDYgUhWZDPxAux4hCEsjWRBz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/VKSl4lCD2bTFH0S/IHP4sTvqPSOXVRNBBfSUyBnCCsqA98lYgWWAkzZMKLGMvFZ
	 PNKO+3D2+KSoG9+rKsh6858f2wOIQCecbV7Of8aPsQMKHExSJNNNeMjIhD2vGe+nkh
	 V6eLXqyswxh3XArYx10M/H1oJkHr3eG/Igo4ssGLC55RcuzGcgPQDlMUNqUOlKthUo
	 8/KEk6QNpVQaPreN+R/4fdpiY8CqPO68L/JQuIONohSXJ+/NP3H+Aq/Vb54UvAtF1r
	 7wB5awQgVXx/rwf5+pMZPzQTqtxQDX2/xLVh00JBGJHoAcVnWwBpTZm/F5LsaEy+ft
	 XrSyvlxb+Rr/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jason Donenfeld <Jason@zx2c4.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 469/844] Remove WARN_ALL_UNSEEDED_RANDOM kernel config option
Date: Sat, 28 Feb 2026 12:26:22 -0500
Message-ID: <20260228173244.1509663-470-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220548-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,zx2c4.com:email]
X-Rspamd-Queue-Id: 98BFF1C69F8
X-Rspamd-Action: no action

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 7dff99b354601dd01829e1511711846e04340a69 ]

This config option goes way back - it used to be an internal debug
option to random.c (at that point called DEBUG_RANDOM_BOOT), then was
renamed and exposed as a config option as CONFIG_WARN_UNSEEDED_RANDOM,
and then further renamed to the current CONFIG_WARN_ALL_UNSEEDED_RANDOM.

It was all done with the best of intentions: the more limited
rate-limited reports were reporting some cases, but if you wanted to see
all the gory details, you'd enable this "ALL" option.

However, it turns out - perhaps not surprisingly - that when people
don't care about and fix the first rate-limited cases, they most
certainly don't care about any others either, and so warning about all
of them isn't actually helping anything.

And the non-ratelimited reporting causes problems, where well-meaning
people enable debug options, but the excessive flood of messages that
nobody cares about will hide actual real information when things go
wrong.

I just got a kernel bug report (which had nothing to do with randomness)
where two thirds of the the truncated dmesg was just variations of

   random: get_random_u32 called from __get_random_u32_below+0x10/0x70 with crng_init=0

and in the process early boot messages had been lost (in addition to
making the messages that _hadn't_ been lost harder to read).

The proper way to find these things for the hypothetical developer that
cares - if such a person exists - is almost certainly with boot time
tracing.  That gives you the option to get call graphs etc too, which is
likely a requirement for fixing any problems anyway.

See Documentation/trace/boottime-trace.rst for that option.

And if we for some reason do want to re-introduce actual printing of
these things, it will need to have some uniqueness filtering rather than
this "just print it all" model.

Fixes: cc1e127bfa95 ("random: remove ratelimiting for in-kernel unseeded randomness")
Acked-by: Jason Donenfeld <Jason@zx2c4.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/random.c       | 12 +-----------
 kernel/configs/debug.config |  1 -
 lib/Kconfig.debug           | 27 ---------------------------
 3 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index bab03c7c4194a..c36c76c2e88e0 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -96,8 +96,7 @@ static ATOMIC_NOTIFIER_HEAD(random_ready_notifier);
 /* Control how we warn userspace. */
 static struct ratelimit_state urandom_warning =
 	RATELIMIT_STATE_INIT_FLAGS("urandom_warning", HZ, 3, RATELIMIT_MSG_ON_RELEASE);
-static int ratelimit_disable __read_mostly =
-	IS_ENABLED(CONFIG_WARN_ALL_UNSEEDED_RANDOM);
+static int ratelimit_disable __read_mostly = 0;
 module_param_named(ratelimit_disable, ratelimit_disable, int, 0644);
 MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
 
@@ -168,12 +167,6 @@ int __cold execute_with_initialized_rng(struct notifier_block *nb)
 	return ret;
 }
 
-#define warn_unseeded_randomness() \
-	if (IS_ENABLED(CONFIG_WARN_ALL_UNSEEDED_RANDOM) && !crng_ready()) \
-		printk_deferred(KERN_NOTICE "random: %s called from %pS with crng_init=%d\n", \
-				__func__, (void *)_RET_IP_, crng_init)
-
-
 /*********************************************************************
  *
  * Fast key erasure RNG, the "crng".
@@ -434,7 +427,6 @@ static void _get_random_bytes(void *buf, size_t len)
  */
 void get_random_bytes(void *buf, size_t len)
 {
-	warn_unseeded_randomness();
 	_get_random_bytes(buf, len);
 }
 EXPORT_SYMBOL(get_random_bytes);
@@ -523,8 +515,6 @@ type get_random_ ##type(void)							\
 	struct batch_ ##type *batch;						\
 	unsigned long next_gen;							\
 										\
-	warn_unseeded_randomness();						\
-										\
 	if  (!crng_ready()) {							\
 		_get_random_bytes(&ret, sizeof(ret));				\
 		return ret;							\
diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
index 9f6ab7dabf672..0a6c1763d976e 100644
--- a/kernel/configs/debug.config
+++ b/kernel/configs/debug.config
@@ -29,7 +29,6 @@ CONFIG_SECTION_MISMATCH_WARN_ONLY=y
 # CONFIG_UBSAN_ALIGNMENT is not set
 # CONFIG_UBSAN_DIV_ZERO is not set
 # CONFIG_UBSAN_TRAP is not set
-# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_FS_ALLOW_ALL=y
 CONFIG_DEBUG_IRQFLAGS=y
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cda3cf1fa302c..4bae3b389a9c5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1687,33 +1687,6 @@ config STACKTRACE
 	  It is also used by various kernel debugging features that require
 	  stack trace generation.
 
-config WARN_ALL_UNSEEDED_RANDOM
-	bool "Warn for all uses of unseeded randomness"
-	default n
-	help
-	  Some parts of the kernel contain bugs relating to their use of
-	  cryptographically secure random numbers before it's actually possible
-	  to generate those numbers securely. This setting ensures that these
-	  flaws don't go unnoticed, by enabling a message, should this ever
-	  occur. This will allow people with obscure setups to know when things
-	  are going wrong, so that they might contact developers about fixing
-	  it.
-
-	  Unfortunately, on some models of some architectures getting
-	  a fully seeded CRNG is extremely difficult, and so this can
-	  result in dmesg getting spammed for a surprisingly long
-	  time.  This is really bad from a security perspective, and
-	  so architecture maintainers really need to do what they can
-	  to get the CRNG seeded sooner after the system is booted.
-	  However, since users cannot do anything actionable to
-	  address this, by default this option is disabled.
-
-	  Say Y here if you want to receive warnings for all uses of
-	  unseeded randomness.  This will be of use primarily for
-	  those developers interested in improving the security of
-	  Linux kernels running on their architecture (or
-	  subarchitecture).
-
 config DEBUG_KOBJECT
 	bool "kobject debugging"
 	depends on DEBUG_KERNEL
-- 
2.51.0


