Return-Path: <stable+bounces-164768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D361FB1252E
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 22:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B4656794C
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 20:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1436B2586E0;
	Fri, 25 Jul 2025 20:15:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432923FC42;
	Fri, 25 Jul 2025 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753474551; cv=none; b=d4u8EjPbCHmTGo3r8MMF1dXTqsthIubnNMcS6XOgIbkixmTo44nIaDPAgvYyA0DSPgAdphyf/oGZ1xj9F80d/zNu70Y+ez5E8cyxxceuBIPOej9y7lnJj+59WVT9lV6wg/sg84PtXBenpKW6vubspf3urrNLUypB5EgC2BWoxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753474551; c=relaxed/simple;
	bh=/F/JVr3SNg41VeueRzHG4AAT+V7CIIpptHyNH6dHFVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IcUB28tLEinLSwWu7HCbfAA55whyFTwwfOu6Mfy24E1m/wOf5mSfxS4GCTxIXFBIGkNWH5+TeKpP7WNFHgrFhHsSkvpmAMtPOFmyEJ/YxAgqShL270rwebjy5XA5vN8LwasTJWFMo9gkzp+XoQis+4AGWtDpf8Ax/KOc+li1GxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-312a806f002so189977a91.3;
        Fri, 25 Jul 2025 13:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753474548; x=1754079348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDxcanwU1JbetZe9oiUEN/n+YFfsJR7sLnCsAScdPD4=;
        b=GWzYuI81eY1X72eJgxyvXx2sQpAsSrzUQmSYdEpnc4DpDX0/0kldu9BwO+nKlsz7BN
         dtsfCKGJtiVOaeRLhr3ZV4M1KLJweYOqRrgntJmyjOypQY/8JgM0+8kg66hANcr/e6rT
         Id75/1qCRWsi44PUQlK+xKkGKihg42nhZhBtcSSCVT8fV9Ml4EL3A/2eAv+CxaxcUpoR
         Qnxh29L6n8wx7ZjxdUQLY4OAjBKQUWTlV9eXH0zXhKG7LU/epBpCSMx44vZOvKuuxyBu
         CXgMZuBGLQqnP4QNTv+iiVEsNISdlnE5gth/WYieCZtTeYfaP00ZsBHlozmUTWpZ5KCM
         Tb1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUE9TNv9E1PdFB72RQ9PJfP8rmK1knEi5NpCN9lGrzfmFhlcwkKHuns99k6kd2twl0taiuPFx0hlALa@vger.kernel.org, AJvYcCVUWFCr8gxRzLkLql9Mn7MuLkOGDxoFVbzFq8hm6tjpj5y75QWHtxp4D78oBFov/m6bmgQ8y4yQRNGoFB4=@vger.kernel.org, AJvYcCXvhE5FElbLxh1xQL6uHKK4XclU36kK4A7bCCW51KqtgpaBWQa5ZorEI+CKNTu5unejExBkvpa4@vger.kernel.org
X-Gm-Message-State: AOJu0YxMmu+vHvTt8CTtIOsWSIAngtIbxGX725m3gUASpqPEfgpQxI37
	eHJ6eh+m4XJhhWCq2e/DyTib2vQauVh+3HH9/0WNayO3WrVmuNgnhwcoUre87Kob
X-Gm-Gg: ASbGncukmV4XUjeBfGC/c1T0lXEcLWclaouQChU2YlGUlkUuFeNzDmST7RE2ydeBRng
	kKSBIY212oqBDORIL8Gp83LulYAR88rvgFmXNdfAiPD78PaKkxxKPZy+V3rgpprgcm6Vui0m22P
	jWJmNBnpQZVkUePqjaWEheblwpv0/bcfkIYSDfGDefZ0UPmAxOjowIN4C122IV01mknnqJyB/mO
	R67+0pdBVhid8wUavOX7IgjGPDQyKFHeJqLarEgCNdY8sXSkeeGxgs19/JDOhQ6R1DEfrUZsos1
	/ectSayzMA3LMBCNSYMUysn6tv2YBS4su8SmVrEJVWV4gZmVw5znX5gciVVAP3UdSFkvLMlQR2U
	14t4xEjBkEFg6
X-Google-Smtp-Source: AGHT+IFWfq/YuZlLKXEbKR6CH+4VjCjJlJjC/Hbgbn/0EjkusqP9d4OK3YW1DW7j/4gOzB0opFCTOA==
X-Received: by 2002:a17:90b:4ad2:b0:313:f9fc:7214 with SMTP id 98e67ed59e1d1-31e77873f60mr1854586a91.1.1753474548387;
        Fri, 25 Jul 2025 13:15:48 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fb798sm346993a91.8.2025.07.25.13.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 13:15:47 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>,
	max.byungchul.park@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Michelle Jin <shjy180909@gmail.com>,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	stable@vger.kernel.org,
	kasan-dev@googlegroups.com,
	syzkaller@googlegroups.com,
	linux-usb@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH] kcov, usb: Fix invalid context sleep in softirq path on PREEMPT_RT
Date: Fri, 25 Jul 2025 20:14:01 +0000
Message-ID: <20250725201400.1078395-2-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fuzzing USB with syzkaller on a PREEMPT_RT enabled kernel, following
bug is triggered in the ksoftirqd context.

| BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
| in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 30, name: ksoftirqd/1
| preempt_count: 0, expected: 0
| RCU nest depth: 2, expected: 2
| CPU: 1 UID: 0 PID: 30 Comm: ksoftirqd/1 Tainted: G        W           6.16.0-rc1-rt1 #11 PREEMPT_RT
| Tainted: [W]=WARN
| Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
| Call trace:
|  show_stack+0x2c/0x3c (C)
|  __dump_stack+0x30/0x40
|  dump_stack_lvl+0x148/0x1d8
|  dump_stack+0x1c/0x3c
|  __might_resched+0x2e4/0x52c
|  rt_spin_lock+0xa8/0x1bc
|  kcov_remote_start+0xb0/0x490
|  __usb_hcd_giveback_urb+0x2d0/0x5e8
|  usb_giveback_urb_bh+0x234/0x3c4
|  process_scheduled_works+0x678/0xd18
|  bh_worker+0x2f0/0x59c
|  workqueue_softirq_action+0x104/0x14c
|  tasklet_action+0x18/0x8c
|  handle_softirqs+0x208/0x63c
|  run_ksoftirqd+0x64/0x264
|  smpboot_thread_fn+0x4ac/0x908
|  kthread+0x5e8/0x734
|  ret_from_fork+0x10/0x20

To reproduce on PREEMPT_RT kernel:

 $ git remote add rt-devel git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
 $ git fetch rt-devel
 $ git checkout -b v6.16-rc1-rt1 v6.16-rc1-rt1

I have attached the syzlang and the C source code converted by syz-prog2c:

Link: https://gist.github.com/kzall0c/9455aaa246f4aa1135353a51753adbbe

Then, run with a PREEMPT_RT config.

This issue was introduced by commit
f85d39dd7ed8 ("kcov, usb: disable interrupts in kcov_remote_start_usb_softirq").

However, this creates a conflict on PREEMPT_RT kernels. The local_irq_save()
call establishes an atomic context where sleeping is forbidden. Inside this
context, kcov_remote_start() is called, which on PREEMPT_RT uses sleeping
locks (spinlock_t and local_lock_t are mapped to rt_mutex). This results in
a sleeping function called from invalid context.

On PREEMPT_RT, interrupt handlers are threaded, so the re-entrancy scenario
is already safely handled by the existing local_lock_t and the global
kcov_remote_lock within kcov_remote_start(). Therefore, the outer
local_irq_save() is not necessary.

This preserves the intended re-entrancy protection for non-RT kernels while
resolving the locking violation on PREEMPT_RT kernels.

After making this modification and testing it, syzkaller fuzzing the
PREEMPT_RT kernel is now running without stopping on latest announced
Real-time Linux.

Link: https://lore.kernel.org/linux-rt-devel/20250610080307.LMm1hleC@linutronix.de/
Fixes: f85d39dd7ed8 ("kcov, usb: disable interrupts in kcov_remote_start_usb_softirq")
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Byungchul Park <byungchul@sk.com>
Cc: stable@vger.kernel.org
Cc: kasan-dev@googlegroups.com
Cc: syzkaller@googlegroups.com
Cc: linux-usb@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev
Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 include/linux/kcov.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index 75a2fb8b16c3..c5e1b2dd0bb7 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -85,7 +85,9 @@ static inline unsigned long kcov_remote_start_usb_softirq(u64 id)
 	unsigned long flags = 0;
 
 	if (in_serving_softirq()) {
+#ifndef CONFIG_PREEMPT_RT
 		local_irq_save(flags);
+#endif
 		kcov_remote_start_usb(id);
 	}
 
@@ -96,7 +98,9 @@ static inline void kcov_remote_stop_softirq(unsigned long flags)
 {
 	if (in_serving_softirq()) {
 		kcov_remote_stop();
+#ifndef CONFIG_PREEMPT_RT
 		local_irq_restore(flags);
+#endif
 	}
 }
 
-- 
2.50.0


