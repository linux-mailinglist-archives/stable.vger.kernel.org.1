Return-Path: <stable+bounces-114272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACC7A2C843
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 17:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111E118819C9
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BA718E351;
	Fri,  7 Feb 2025 16:04:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [195.16.41.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A00B23C8BA;
	Fri,  7 Feb 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.16.41.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738944282; cv=none; b=DkMZO+dGe5b1g89DK5mPhhGuxpf+18pwzeIVtWmg9/Ts53t9M273qq6RNCrEfTnb0gUNzTHUtc9n3ZneVI/YqHty3vhSYAzaw8eF2+QPeB1YYYa9IvJ/Te1SDHo4UVr2IwZ58cYA0XjVDVPzk1U3LdoH1IQB0uJgoZYD/Ur09BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738944282; c=relaxed/simple;
	bh=Pv8A6iEtT1eR45rzq+djtWH/jruBfbbOZ+gmhFwJyyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMCxo0UG2CzdDcWR6sH1w8RZawNk/8qZdRDxZEhw1iyq7g9bXodlq5DmiWnIULdTketAlRvqkhxm7CNO/yYEv06s3cF6no6ChSmivN3o+FQrP6YcjamXPIx9Zs+qDlgLGYBAM+nWIlaXa6PbF1I8P/xkiXs9XXCk71kGFER7RJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=195.16.41.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 8A8361F9C8;
	Fri,  7 Feb 2025 19:04:29 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail03.astralinux.ru [10.177.185.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Fri,  7 Feb 2025 19:04:27 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.177.20.117])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4YqJgt2BpGz1gyXY;
	Fri,  7 Feb 2025 19:04:26 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Longlong Xia <xialonglong@kylinos.cn>,
	stable <stable@kernel.org>
Subject: [PATCH v2 5.10/5.15] tty: n_gsm: Fix use-after-free in gsm_cleanup_mux
Date: Fri,  7 Feb 2025 19:03:37 +0300
Message-Id: <20250207160337.13479-1-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250207153651.7115-1-apanov@astralinux.ru>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/02/07 14:10:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 50 0.3.50 df4aeb250ed63fd3baa80a493fa6caee5dd9e10f, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 190876 [Feb 07 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/02/07 12:24:00 #27143140
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/02/07 14:13:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Longlong Xia <xialonglong@kylinos.cn>

commit 9462f4ca56e7d2430fdb6dcc8498244acbfc4489 upstream.

BUG: KASAN: slab-use-after-free in gsm_cleanup_mux+0x77b/0x7b0
drivers/tty/n_gsm.c:3160 [n_gsm]
Read of size 8 at addr ffff88815fe99c00 by task poc/3379
CPU: 0 UID: 0 PID: 3379 Comm: poc Not tainted 6.11.0+ #56
Hardware name: VMware, Inc. VMware Virtual Platform/440BX
Desktop Reference Platform, BIOS 6.00 11/12/2020
Call Trace:
 <TASK>
 gsm_cleanup_mux+0x77b/0x7b0 drivers/tty/n_gsm.c:3160 [n_gsm]
 __pfx_gsm_cleanup_mux+0x10/0x10 drivers/tty/n_gsm.c:3124 [n_gsm]
 __pfx_sched_clock_cpu+0x10/0x10 kernel/sched/clock.c:389
 update_load_avg+0x1c1/0x27b0 kernel/sched/fair.c:4500
 __pfx_min_vruntime_cb_rotate+0x10/0x10 kernel/sched/fair.c:846
 __rb_insert_augmented+0x492/0xbf0 lib/rbtree.c:161
 gsmld_ioctl+0x395/0x1450 drivers/tty/n_gsm.c:3408 [n_gsm]
 _raw_spin_lock_irqsave+0x92/0xf0 arch/x86/include/asm/atomic.h:107
 __pfx_gsmld_ioctl+0x10/0x10 drivers/tty/n_gsm.c:3822 [n_gsm]
 ktime_get+0x5e/0x140 kernel/time/timekeeping.c:195
 ldsem_down_read+0x94/0x4e0 arch/x86/include/asm/atomic64_64.h:79
 __pfx_ldsem_down_read+0x10/0x10 drivers/tty/tty_ldsem.c:338
 __pfx_do_vfs_ioctl+0x10/0x10 fs/ioctl.c:805
 tty_ioctl+0x643/0x1100 drivers/tty/tty_io.c:2818

Allocated by task 65:
 gsm_data_alloc.constprop.0+0x27/0x190 drivers/tty/n_gsm.c:926 [n_gsm]
 gsm_send+0x2c/0x580 drivers/tty/n_gsm.c:819 [n_gsm]
 gsm1_receive+0x547/0xad0 drivers/tty/n_gsm.c:3038 [n_gsm]
 gsmld_receive_buf+0x176/0x280 drivers/tty/n_gsm.c:3609 [n_gsm]
 tty_ldisc_receive_buf+0x101/0x1e0 drivers/tty/tty_buffer.c:391
 tty_port_default_receive_buf+0x61/0xa0 drivers/tty/tty_port.c:39
 flush_to_ldisc+0x1b0/0x750 drivers/tty/tty_buffer.c:445
 process_scheduled_works+0x2b0/0x10d0 kernel/workqueue.c:3229
 worker_thread+0x3dc/0x950 kernel/workqueue.c:3391
 kthread+0x2a3/0x370 kernel/kthread.c:389
 ret_from_fork+0x2d/0x70 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:257

Freed by task 3367:
 kfree+0x126/0x420 mm/slub.c:4580
 gsm_cleanup_mux+0x36c/0x7b0 drivers/tty/n_gsm.c:3160 [n_gsm]
 gsmld_ioctl+0x395/0x1450 drivers/tty/n_gsm.c:3408 [n_gsm]
 tty_ioctl+0x643/0x1100 drivers/tty/tty_io.c:2818

[Analysis]
gsm_msg on the tx_ctrl_list or tx_data_list of gsm_mux
can be freed by multi threads through ioctl,which leads
to the occurrence of uaf. Protect it by gsm tx lock.

Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
Cc: stable <stable@kernel.org>
Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20240926130213.531959-1-xialonglong@kylinos.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Alexey: Replace guard macro with spin_lock_irqsave due to its unavailability
in pre-6.1 kernels. Based on a v1 patch from Longlong Xia [1]. ]
Link: https://lore.kernel.org/all/20240924093519.767036-1-xialonglong@kylinos.cn/ [1]
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
v1->v2: update patch author information
 drivers/tty/n_gsm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index aae9f73585bd..1becbdf7c470 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2443,6 +2443,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	int i;
 	struct gsm_dlci *dlci;
 	struct gsm_msg *txq, *ntxq;
+	unsigned long flags;
 
 	gsm->dead = true;
 	mutex_lock(&gsm->mutex);
@@ -2471,9 +2472,12 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	mutex_unlock(&gsm->mutex);
 	/* Now wipe the queues */
 	tty_ldisc_flush(gsm->tty);
+
+	spin_lock_irqsave(&gsm->tx_lock, flags);
 	list_for_each_entry_safe(txq, ntxq, &gsm->tx_list, list)
 		kfree(txq);
 	INIT_LIST_HEAD(&gsm->tx_list);
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
 }
 
 /**
-- 
2.30.2


