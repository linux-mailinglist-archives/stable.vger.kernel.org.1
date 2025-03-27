Return-Path: <stable+bounces-126829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DF1A72A93
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 08:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E617618947C5
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 07:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662E91F4C99;
	Thu, 27 Mar 2025 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XVH+7Azp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dCMw+44a"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2565A1F4C84;
	Thu, 27 Mar 2025 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743060580; cv=none; b=Z68eazVQj0pLYIO5u/s5mwJt2NC/q1vfNZAZq7UsSXiRGi7e9ard0XISPkWowJqXA2zi8NEhkU5RauktzaAIwAmB7kV7JAG3/dmMO8zBAmC8ncEjF0lsnfQ2tU9ETcNIg3yjRBjSjbjwQ0IAjUOBMgoR8SOy0nFjQjcHIoYLqx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743060580; c=relaxed/simple;
	bh=3IxE9eOQMfi7kEhpK35vuO2kbQmb/e1Ie+KL3VDxl8c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oqRCC+CrdJpihufG0WN1AObrSjymnjnJjIWvFOvDOPU6XudjsHrXaMFcvyn4eTJloa5Qct8SUhVi7hcUK+m7Y+rayO1LCH4OgClLGlAM5/A2ILicxu0mpWuXpDJLhUFR2OegvW6sACpUTMdtHHPehOqJ5gwP1Hwl9Yo6hR72fwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XVH+7Azp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dCMw+44a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Mar 2025 07:29:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743060575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQ9s+vlxdp0zs18EJ6/ldypBQXUY54t96roc7c4NIOA=;
	b=XVH+7AzpToqVeEhD5LA7DpK0KLNZp88y5k/2MJTFuJ6a5M5KR3lvtV0ZYsY5s7zvkZjcLA
	T57M6q4MSQPPlFgAVCTG3f4x5ipwj2xF20DS1ADOveC472JYTxpPPcgcEYkc4OgI2nY14u
	KufhKdelnnXX5mq6IXnuChEweFYttqe/aI7rfxVS2CBE8uroscBXlwlm6JmuD2T/sXRNAn
	J0nYomDzu0pVqEId1fqkNyEKJxSVIjmlLLg2IqI2V0MhdJ1X6HKcnzWAP9DqtAuzXJKVVU
	Wl6OikTn88ctUvcqT4H2k4u8URTo6CQnfFCLzIAf6+8NofAmXCPq651HzKJ7RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743060575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQ9s+vlxdp0zs18EJ6/ldypBQXUY54t96roc7c4NIOA=;
	b=dCMw+44ax/RBvMafWEcCGvj5a7AFaOrLxv/SqwDOz2suBWHToM63BCPvFN9muWJCNXccZk
	03SqXo8SKgl2cyCQ==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/lockdep: Decrease nr_unused_locks if
 lock unused in zap_class()
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Waiman Long <longman@redhat.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250326180831.510348-1-boqun.feng@gmail.com>
References: <20250326180831.510348-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174306057203.14745.17035425599679029480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     495f53d5cca0f939eaed9dca90b67e7e6fb0e30c
Gitweb:        https://git.kernel.org/tip/495f53d5cca0f939eaed9dca90b67e7e6fb0e30c
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Wed, 26 Mar 2025 11:08:30 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Mar 2025 08:23:17 +01:00

locking/lockdep: Decrease nr_unused_locks if lock unused in zap_class()

Currently, when a lock class is allocated, nr_unused_locks will be
increased by 1, until it gets used: nr_unused_locks will be decreased by
1 in mark_lock(). However, one scenario is missed: a lock class may be
zapped without even being used once. This could result into a situation
that nr_unused_locks != 0 but no unused lock class is active in the
system, and when `cat /proc/lockdep_stats`, a WARN_ON() will
be triggered in a CONFIG_DEBUG_LOCKDEP=y kernel:

  [...] DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) != nr_unused)
  [...] WARNING: CPU: 41 PID: 1121 at kernel/locking/lockdep_proc.c:283 lockdep_stats_show+0xba9/0xbd0

And as a result, lockdep will be disabled after this.

Therefore, nr_unused_locks needs to be accounted correctly at
zap_class() time.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250326180831.510348-1-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b15757e..58d78a3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6264,6 +6264,9 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 		hlist_del_rcu(&class->hash_entry);
 		WRITE_ONCE(class->key, NULL);
 		WRITE_ONCE(class->name, NULL);
+		/* Class allocated but not used, -1 in nr_unused_locks */
+		if (class->usage_mask == 0)
+			debug_atomic_dec(nr_unused_locks);
 		nr_lock_classes--;
 		__clear_bit(class - lock_classes, lock_classes_in_use);
 		if (class - lock_classes == max_lock_class_idx)

