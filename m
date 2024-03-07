Return-Path: <stable+bounces-27036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC688746AD
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 04:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A871F25DEF
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 03:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BEFDDD3;
	Thu,  7 Mar 2024 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiVxm8wN"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A27DDC3
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781624; cv=none; b=P2JkH0kRKcRw7ReD23x1K3+4qS8+gjMeu9odnOQLLODkyUTI/PCeonPBhZseh3LCNKL7Rtw/YdftdkFy/YvZX/BO5xuCUTBLZbvv5U46DiUMNBQgSRzsRfmLXK/YZnl87wQ84uJC0QODnM9W0DeckxLTfhaG7wnXyPWP5MsHPvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781624; c=relaxed/simple;
	bh=wTz9SQRrQyoldf1moOyhd82MW7vMNnXwHw4sIfxImpk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qtLSgz72nK4TIgGdynygSRI+g24XClVvLPDdd7+ajgjHF/SvkD0lUU3VO2229srCyF2bqAdCa6RspStSdZL9S+p6zLXekqWpvAZfcZP1qajHm8rT3ujg6o5JaRZ6as7CPhqRUeulchdHMDv47WwAj7Vee4LA2WxFjYntP+AQGEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiVxm8wN; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c1a2f7e1d2so161558b6e.1
        for <stable@vger.kernel.org>; Wed, 06 Mar 2024 19:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709781621; x=1710386421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c1jvkih2U4k9BuhBY0/Fz/4FIDzcIUMMLDQD8hNmvUE=;
        b=DiVxm8wNfUwd+BvLevlXWXIqLHrbUerN6nPWROUdGq4DcmsZHCR2DbJtRkgXkIOON/
         1Nm0QrmI/1mpcDtcwJDNpLL5mFlCJeQCKiwgEGEjcbAIHSplz5kBXnqKb80jDhkYli92
         7ippLuudIohZcohuZJXLZ/0N0yXvq9pR9AO/oRCmGR36Jd8QfQ+iJMY606eMgcY5XBaF
         zhh4P93qxvNz+l+Sgjv4pWDD4MCUN0bMZDW6+FRl+9yJNZSZ2hLSib1XgtrWEcIKpcfv
         s1nmv1xtX/N4AgJ5wX0oreIovdSwQNjL80Tya/bakYphDci0Xyr6lcQbghNrpbFefQHn
         I2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709781621; x=1710386421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1jvkih2U4k9BuhBY0/Fz/4FIDzcIUMMLDQD8hNmvUE=;
        b=CmNUskhTs2VmoRGY4hQJkXUdLAeFFvqbJV0XrsS/mRcOql3ILTr5jFh0n+WhPeVZfV
         sZBxo9/DnF/FguvfWCSf6NhQkATNv7WyVE/KxNVmkHjL8SkqRlsFxI/+AOR/xoZmNKgP
         Ufuf9RmrM1Bpu/7Dl5fRkz/8ChNGUiLxWV1KP9ilIRCFszB5x30GgkdvVKQ15kUs//q+
         j/8KYdvmSk2YTCFgCzsIMTLZh3UX8BKo4j4K0+wsaVyfLqpaN7b/FExlcC9UcGvwpFMF
         8stkb+D3JkJnqID7Lv+mddhy5xBmiQgaKCyfxpTSXULxDiQAXa44jYGVKs4sce4O96dD
         /5vA==
X-Forwarded-Encrypted: i=1; AJvYcCVCEvdynBoOvtWL/4qCARcGazHl0epEKvjU8o76vKQ4esBJQ+OIQhSX4bDoHSjV2Xms5LaHTHL8+Uwp0S91rQVytCa+bwis
X-Gm-Message-State: AOJu0Yx/WAvWNmiNl4hVxQ5ZF0j2dZPACJRoSETwoObteB+EmOWTN2nA
	s0HFtRerSRX8R7ja/7huX1UJoMsCz0YVVopt8ORxzfqYbaUWUHr+
X-Google-Smtp-Source: AGHT+IFh9KHzJ7ETy6KC4crTv8rbNLfsKcuL6AV0XMw0BLC93LPGYxe2i39LiW/y5IXaIDyezzsdYg==
X-Received: by 2002:a05:6808:2016:b0:3c1:ec24:e4b5 with SMTP id q22-20020a056808201600b003c1ec24e4b5mr8621103oiw.8.1709781621424;
        Wed, 06 Mar 2024 19:20:21 -0800 (PST)
Received: from localhost.localdomain ([39.144.104.165])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7854f000000b006e5a99942c6sm10368678pfn.88.2024.03.06.19.20.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2024 19:20:20 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	yuzhao@google.com
Cc: linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm: mglru: Fix soft lockup attributed to scanning folios
Date: Thu,  7 Mar 2024 11:19:52 +0800
Message-Id: <20240307031952.2123-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After we enabled mglru on our 384C1536GB production servers, we
encountered frequent soft lockups attributed to scanning folios.

The soft lockup as follows,

[Sat Feb 24 02:29:42 2024] watchdog: BUG: soft lockup - CPU#215 stuck for 111s! [kworker/215:0:2200100]
[Sat Feb 24 02:29:42 2024] Call Trace:
[Sat Feb 24 02:29:42 2024]  <IRQ>
[Sat Feb 24 02:29:42 2024]  ? show_regs.cold+0x1a/0x1f
[Sat Feb 24 02:29:42 2024]  ? watchdog_timer_fn+0x1c4/0x220
[Sat Feb 24 02:29:42 2024]  ? softlockup_fn+0x30/0x30
[Sat Feb 24 02:29:42 2024]  ? __hrtimer_run_queues+0xa2/0x2b0
[Sat Feb 24 02:29:42 2024]  ? hrtimer_interrupt+0x109/0x220
[Sat Feb 24 02:29:42 2024]  ? __sysvec_apic_timer_interrupt+0x5e/0x110
[Sat Feb 24 02:29:42 2024]  ? sysvec_apic_timer_interrupt+0x7b/0x90
[Sat Feb 24 02:29:42 2024]  </IRQ>
[Sat Feb 24 02:29:42 2024]  <TASK>
[Sat Feb 24 02:29:42 2024]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[Sat Feb 24 02:29:42 2024]  ? folio_end_writeback+0x73/0xa0
[Sat Feb 24 02:29:42 2024]  ? folio_rotate_reclaimable+0x8c/0x90
[Sat Feb 24 02:29:42 2024]  ? folio_rotate_reclaimable+0x57/0x90
[Sat Feb 24 02:29:42 2024]  ? folio_rotate_reclaimable+0x8c/0x90
[Sat Feb 24 02:29:42 2024]  folio_end_writeback+0x73/0xa0
[Sat Feb 24 02:29:42 2024]  iomap_finish_ioend+0x1d4/0x420
[Sat Feb 24 02:29:42 2024]  iomap_finish_ioends+0x5e/0xe0
[Sat Feb 24 02:29:42 2024]  xfs_end_ioend+0x65/0x150 [xfs]
[Sat Feb 24 02:29:42 2024]  xfs_end_io+0xbc/0xf0 [xfs]
[Sat Feb 24 02:29:42 2024]  process_one_work+0x1ec/0x3c0
[Sat Feb 24 02:29:42 2024]  worker_thread+0x4d/0x390
[Sat Feb 24 02:29:42 2024]  ? process_one_work+0x3c0/0x3c0
[Sat Feb 24 02:29:42 2024]  kthread+0xee/0x120
[Sat Feb 24 02:29:42 2024]  ? kthread_complete_and_exit+0x20/0x20
[Sat Feb 24 02:29:42 2024]  ret_from_fork+0x1f/0x30
[Sat Feb 24 02:29:42 2024]  </TASK>

From our analysis of the vmcore generated by the soft lockup, the thread
was waiting for the spinlock lruvec->lru_lock:

PID: 2200100  TASK: ffff9a221d8b4000  CPU: 215  COMMAND: "kworker/215:0"
 #0 [fffffe000319ae20] crash_nmi_callback at ffffffff8e055419
 #1 [fffffe000319ae58] nmi_handle at ffffffff8e0253c0
 #2 [fffffe000319aea0] default_do_nmi at ffffffff8eae5985
 #3 [fffffe000319aec8] exc_nmi at ffffffff8eae5b78
 #4 [fffffe000319aef0] end_repeat_nmi at ffffffff8ec015f0
    [exception RIP: queued_spin_lock_slowpath+59]
    RIP: ffffffff8eaf9b8b  RSP: ffffb58b01d4fc20  RFLAGS: 00000002
    RAX: 0000000000000001  RBX: ffffb58b01d4fc90  RCX: 0000000000000000
    RDX: 0000000000000001  RSI: 0000000000000001  RDI: ffff99d2b6ff9050
    RBP: ffffb58b01d4fc40   R8: 0000000000035b21   R9: 0000000000000040
    R10: 0000000000035b00  R11: 0000000000000001  R12: ffff99d2b6ff9050
    R13: 0000000000000046  R14: ffffffff8e28bd30  R15: 0000000000000000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
  #5 [ffffb58b01d4fc20] queued_spin_lock_slowpath at ffffffff8eaf9b8b
  #6 [ffffb58b01d4fc48] _raw_spin_lock_irqsave at ffffffff8eaf9b11
  #7 [ffffb58b01d4fc68] folio_lruvec_lock_irqsave at ffffffff8e337a82
  #8 [ffffb58b01d4fc88] folio_batch_move_lru at ffffffff8e28dbcf
  #9 [ffffb58b01d4fcd0] folio_batch_add_and_move at ffffffff8e28dce7
 #10 [ffffb58b01d4fce0] folio_rotate_reclaimable at ffffffff8e28eee7
 #11 [ffffb58b01d4fcf8] folio_end_writeback at ffffffff8e27bfb3
 #12 [ffffb58b01d4fd10] iomap_finish_ioend at ffffffff8e3d9d04
 #13 [ffffb58b01d4fd98] iomap_finish_ioends at ffffffff8e3d9fae
 #14 [ffffb58b01d4fde0] xfs_end_ioend at ffffffffc0fae835 [xfs]
 #15 [ffffb58b01d4fe20] xfs_end_io at ffffffffc0fae9dc [xfs]
 #16 [ffffb58b01d4fe60] process_one_work at ffffffff8e0ae08c
 #17 [ffffb58b01d4feb0] worker_thread at ffffffff8e0ae2ad
 #18 [ffffb58b01d4ff10] kthread at ffffffff8e0b671e
 #19 [ffffb58b01d4ff50] ret_from_fork at ffffffff8e002dcf

While the spinlock (RDI: ffff99d2b6ff9050) was held by a task which was
scanning folios:

PID: 2400713  TASK: ffff996be1d14000  CPU: 50  COMMAND: "chitu_main"
--- <NMI exception stack> ---
  #5 [ffffb58b14ef76e8] __mod_zone_page_state at ffffffff8e2a9c36
  #6 [ffffb58b14ef76f0] folio_inc_gen at ffffffff8e2990bd
  #7 [ffffb58b14ef7740] sort_folio at ffffffff8e29afbb
  #8 [ffffb58b14ef7748] sysvec_apic_timer_interrupt at ffffffff8eae79f0
  #9 [ffffb58b14ef77b0] scan_folios at ffffffff8e29b49b
 #10 [ffffb58b14ef7878] evict_folios at ffffffff8e29bb53
 #11 [ffffb58b14ef7968] lru_gen_shrink_lruvec at ffffffff8e29cb57
 #12 [ffffb58b14ef7a28] shrink_lruvec at ffffffff8e29e135
 #13 [ffffb58b14ef7af0] shrink_node at ffffffff8e29e78c
 #14 [ffffb58b14ef7b88] do_try_to_free_pages at ffffffff8e29ec08
 #15 [ffffb58b14ef7bf8] try_to_free_mem_cgroup_pages at ffffffff8e2a17a6
 #16 [ffffb58b14ef7ca8] try_charge_memcg at ffffffff8e338879
 #17 [ffffb58b14ef7d48] charge_memcg at ffffffff8e3394f8
 #18 [ffffb58b14ef7d70] __mem_cgroup_charge at ffffffff8e33aded
 #19 [ffffb58b14ef7d98] do_anonymous_page at ffffffff8e2c6523
 #20 [ffffb58b14ef7dd8] __handle_mm_fault at ffffffff8e2cc27d
 #21 [ffffb58b14ef7e78] handle_mm_fault at ffffffff8e2cc3ba
 #22 [ffffb58b14ef7eb8] do_user_addr_fault at ffffffff8e073a99
 #23 [ffffb58b14ef7f20] exc_page_fault at ffffffff8eae82f7
 #24 [ffffb58b14ef7f50] asm_exc_page_fault at ffffffff8ec00bb7

There were a total of 22 tasks waiting for this spinlock
(RDI: ffff99d2b6ff9050):

 crash> foreach RU bt | grep -B 8  queued_spin_lock_slowpath |  grep "RDI: ffff99d2b6ff9050" | wc -l
 22

Additionally, two other threads were also engaged in scanning folios, one
with 19 waiters and the other with 15 waiters.

To address this issue under heavy reclaim conditions, we introduced a
hotfix version of the fix, incorporating cond_resched() in scan_folios().
Following the application of this hotfix to our servers, the soft lockup
issue ceased.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: stable@vger.kernel.org # 6.1+
---
 mm/vmscan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4f9c854ce6cc..8f2877285b9a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4367,6 +4367,10 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 
 			if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
 				break;
+
+			spin_unlock_irq(&lruvec->lru_lock);
+			cond_resched();
+			spin_lock_irq(&lruvec->lru_lock);
 		}
 
 		if (skipped_zone) {
-- 
2.30.1 (Apple Git-130)


