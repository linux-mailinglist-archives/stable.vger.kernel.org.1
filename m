Return-Path: <stable+bounces-165812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8338AB192F3
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 09:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BABD17581D
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 07:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A976323D2A3;
	Sun,  3 Aug 2025 07:21:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869081D5ABA;
	Sun,  3 Aug 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754205713; cv=none; b=Fymkp65blm+Z2//1BVmTQGcJr1DzzOT/zxrrIgIP2rl6p3laC2snmGQND8xAiQvnoYoKQNvX6OszxNnSlIUmfbWZ9ltljd8X9EOqNloqFXS7MPPQepP5lHOY0GIuCanPjvqsmJXp9cW87zULMLJz89AhR/RrFGuHXdcVICOt2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754205713; c=relaxed/simple;
	bh=bcY2L+w2W3FD7OVys+ViD2p8bbkemX9jfFW7WXsVmns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6hCHvQnZO3MkVCOaROf70PR0SCVZavuTYo3NB+yNHcrK2v72liFJ59A64lZ/klR6pIdwd9ocsa5y05KTi7Ow5zyQDBft4aqjXVfvz4c/QCYMe7jDY8SlxWoV/fs/mKREpAT9+XcCbW4i8p3jDsJKr/+qJIsljN448vZmb0784o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32130f6cfbbso39978a91.0;
        Sun, 03 Aug 2025 00:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754205711; x=1754810511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFUScgwG+xBWsWyWWaKRGCTrL7i264F4pYGwsVBK3Co=;
        b=FMCiEV3JI81pOdyT1TAddg4IeNdB3cQhijjyJLJtprQbLc8UhHstBjKFUA12CiZIlb
         e0N9+P6C3/VmFfqVSapcYkpJZlooH3HNXPGqMgqHeaFkWLpnjTwRgeo8tlHQJjkueEIZ
         8RlVc5056ZUQRPt21dX8gNtmLn0WW4HWKzJH7Rl8szBP2ar9P1moNB36E1R9C9aCMCCh
         Qt+Kce4r6ocP0ZWL91XYt4vryPO8n8Vg7Pep8SwVqvRwp3ta3SvAFSlaEz93lCKHzlBt
         K5352OpSooAR1/WdhjjWVFxPpv6txIrvxc6nWPZarllMlRaWDE2ZYQ21Gi7mRX3BYOxB
         5FGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJW4xDBU+eyzETFy1i2tUqoB7dyJ4MWRv3W/S447lZw4ZvzoaPjsyCyw65aNjecpoH1iDdt4kKjAQ0hHc=@vger.kernel.org, AJvYcCX3Vbplg/71dBCZ4HLnaYeggzMptL5d5HqnyuLiN86kmaTlXK4ZlyIlMyn9NnxexSSC0Oyuhxo/@vger.kernel.org, AJvYcCXRSzBUHuKKMVgVgxKh15wYL1K9eERWVbfkJ6UZJs3UaVofVNfey58RRl3XTiK+ofCcAphINl51kQOU@vger.kernel.org
X-Gm-Message-State: AOJu0YxJCKo+5eYbGEfy3vmNlKm8hFcdB/INgycvfWIqgnQJ3TQImc4o
	ZeNEmcfHOWOeR8093LxfFov5hAEA402FycbeN+3fSDHSAy7NgAfL4vp9
X-Gm-Gg: ASbGncvvz9rHCd9GQenUlbeexyfPiaO1uPyEwWa+c823pD+CYVsXuYHRRD5jW+xAYa1
	6kPGR+vUNZv9BLKRQZKAdUXifllPIWgDshxJ4t7H6iuBlbhzzEOf8ER1UYA7aIzJp0G865Ldr3m
	zny2LzUzy2HgCKyPPvRIKY10w8FF37hbd6dRJGoR/qEQN//rIqgB8hbneB4Z5XKzWeuPa7VeyDK
	37Nnm1oSjzk7n/L1lhEPIgsElFehHiO5tn/G4uJdFe7Ukj1VnZjqbrbrI6I4Ps8HsXPPxOOWeGu
	fAEokTN2KoHYwS/szMTNMgWW4FuR7i2sC376ZyT9hUIXR/9RNXCgrDFRRogUjQLFPYo1nJCSrAh
	baYQhbUv+ld6b
X-Google-Smtp-Source: AGHT+IHAx1g1rmU3WmTPsV4DTQv66chU6qy6HWfVYFxspZDp1m7ON0mbZQ/tEfo0w0NjbV8mHzECfA==
X-Received: by 2002:a05:6a20:5484:b0:203:cb2e:7a08 with SMTP id adf61e73a8af0-23df90a2a4bmr3470080637.5.1754205710800;
        Sun, 03 Aug 2025 00:21:50 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b423d2f4fcesm4517004a12.33.2025.08.03.00.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 00:21:50 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Byungchul Park <byungchul@sk.com>,
	max.byungchul.park@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	ppbuk5246@gmail.com,
	linux-usb@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	syzkaller@googlegroups.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [PATCH v3 0/4] kcov, usb: Fix invalid context sleep in softirq path on PREEMPT_RT
Date: Sun,  3 Aug 2025 07:20:41 +0000
Message-ID: <20250803072044.572733-2-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series resolves a sleeping function called from invalid context
bug that occurs when fuzzing USB with syzkaller on a PREEMPT_RT kernel.

The regression was introduced by the interaction of two separate patches:
one that made kcov's internal locks sleep on PREEMPT_RT for better latency
(d5d2c51f1e5f), and another that wrapped a kcov call in the USB softirq
path with local_irq_save() to prevent re-entrancy (f85d39dd7ed8).
This combination resulted in an attempt to acquire a sleeping lock from
within an atomic context, causing a kernel BUG.

To resolve this, this series makes the kcov remote path fully compatible
with atomic contexts by converting all its internal locking primitives to
non-sleeping variants. This approach is more robust than conditional
compilation as it creates a single, unified codebase that works correctly
on both RT and non-RT kernels.

The series is structured as follows:

Patch 1 converts the global kcov locks (kcov->lock and kcov_remote_lock)
to use the non-sleeping raw_spinlock_t.

Patch 2 replace the PREEMPT_RT-specific per-CPU local_lock_t back to the
original local_irq_save/restore primitives, making the per-CPU protection
non-sleeping as well.

Patches 3 and 4 are preparatory refactoring. They move the memory
allocation for remote handles out of the locked sections in the
KCOV_REMOTE_ENABLE ioctl path, which is a prerequisite for safely
using raw_spinlock_t as it forbids sleeping functions like kmalloc
within its critical section.

With these changes, I have been able to run syzkaller fuzzing on a
PREEMPT_RT kernel for a full day with no issues reported.

Reproduction details in here.
Link: https://lore.kernel.org/all/20250725201400.1078395-2-ysk@kzalloc.com/t/#u

Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---

Changes from v2:

	1. Updated kcov_remote_reset() to use raw_spin_lock_irqsave() /
	   raw_spin_unlock_irqrestore() instead of raw_spin_lock() /
	   raw_spin_unlock(), following the interrupt disabling pattern
	   used in the original function that guard kcov_remote_lock.

Changes from v1:

	1. Dropped the #ifdef-based PREEMPT_RT branching.

	2. Convert kcov->lock and kcov_remote_lock from spinlock_t to
	   raw_spinlock_t. This ensures they remain true, non-sleeping
	   spinlocks even on PREEMPT_RT kernels.

	3. Remove the local_lock_t protection for kcov_percpu_data in
	   kcov_remote_start/stop(). Since local_lock_t can also sleep under
	   RT, and the required protection is against local interrupts when
	   accessing per-CPU data, it is replaced with explicit
	   local_irq_save/restore().

	4. Refactor the KCOV_REMOTE_ENABLE path to move memory allocations
	   out of the critical section.

	5. Modify the ioctl handling logic to utilize these pre-allocated
	   structures within the critical section. kcov_remote_add() is
	   modified to accept a pre-allocated structure instead of allocating
	   one internally. All necessary struct kcov_remote structures are now
	   pre-allocated individually in kcov_ioctl() using GFP_KERNEL
	   (allowing sleep) before acquiring the raw spinlocks.

Changes from v0:

	1. On PREEMPT_RT, separated the handling of
	   kcov_remote_start_usb_softirq() and kcov_remote_stop_usb_softirq()
	   to allow sleeping when entering kcov_remote_start_usb() /
	   kcov_remote_stop().

Yunseong Kim (4):
  kcov: Use raw_spinlock_t for kcov->lock and kcov_remote_lock
  kcov: Replace per-CPU local_lock with local_irq_save/restore
  kcov: Separate KCOV_REMOTE_ENABLE ioctl helper function
  kcov: move remote handle allocation outside raw spinlock

 kernel/kcov.c | 248 +++++++++++++++++++++++++++-----------------------
 1 file changed, 134 insertions(+), 114 deletions(-)

base-commit: 186f3edfdd41f2ae87fc40a9ccba52a3bf930994

-- 
2.50.0


