Return-Path: <stable+bounces-43448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE16F8BF98D
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 11:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3E51F23C07
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F63E71753;
	Wed,  8 May 2024 09:30:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20395338A;
	Wed,  8 May 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715160616; cv=none; b=BOGlZMnvMep3GH0nnKka1woQX4+z5vzxOcrEWEo1pFwfcr3Cw9/lqik0Um7Ydh8n1tIzGyO1b+TnIgJFC+G9ssGcgNCuPeOykQ11hxL/qJDOMWGr/u0bQbnnSELee350EONbe/mXSXwyesa3pSDj/3wHw3+3AadE0OONj56p/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715160616; c=relaxed/simple;
	bh=c4hP47PEyo99rjBVhRg7TCURkjQeGtkuWHONiZoyZqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O6gTOCqoENuc0sMqkVOVPhmyUfNpYtcasdKCxWJrnbSppqx2NjKhFyXyraacUcD0DK0ENo1PyCzgDLHdjrS7pDNt3556YsxbtJLgJmsymp7Jc632sFCAg+cNc77rgkl9ACiLWjilov7zXJv01iKiPLewMov+dbYlXRovLGyP1wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 4FA662F20247; Wed,  8 May 2024 09:30:08 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id DB0C82F20242;
	Wed,  8 May 2024 09:30:07 +0000 (UTC)
From: kovalev@altlinux.org
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: lvc-project@linuxtesting.org,
	dutyrok@altlinux.org,
	oficerovas@altlinux.org,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	stable@vger.kernel.org
Subject: [PATCH] tty: Fix possible deadlock in tty_buffer_flush
Date: Wed,  8 May 2024 12:30:05 +0300
Message-Id: <20240508093005.1044815-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

A possible scenario in which a deadlock may occur is as follows:

flush_to_ldisc() {

  mutex_lock(&buf->lock);

  tty_port_default_receive_buf() {
    tty_ldisc_receive_buf() {
      n_tty_receive_buf2() {
	n_tty_receive_buf_common() {
	  n_tty_receive_char_special() {
	    isig() {
	      tty_driver_flush_buffer() {
		pty_flush_buffer() {
		  tty_buffer_flush() {

		    mutex_lock(&buf->lock); (DEADLOCK)

flush_to_ldisc() and tty_buffer_flush() functions they use the same mutex
(&buf->lock), but not necessarily the same struct tty_bufhead object.
However, you should probably use a separate mutex for the
tty_buffer_flush() function to exclude such a situation.

Found by Syzkaller:
======================================================
WARNING: possible circular locking dependency detected
5.10.213-std-def-alt1 #1 Not tainted
------------------------------------------------------
kworker/u6:8/428 is trying to acquire lock:
ffff88810c3498b8 (&buf->lock){+.+.}-{3:3},
        at: tty_buffer_flush+0x7b/0x2b0 drivers/tty/tty_buffer.c:228

but task is already holding lock:
ffff888114dca2e8 (&o_tty->termios_rwsem/1){++++}-{3:3},
        at: isig+0xef/0x440 drivers/tty/n_tty.c:1127

which lock already depends on the new lock.

Chain exists of:
  &buf->lock --> &port->buf.lock/1 --> &o_tty->termios_rwsem/1

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&o_tty->termios_rwsem/1);
                               lock(&port->buf.lock/1);
                               lock(&o_tty->termios_rwsem/1);
  lock(&buf->lock);

stack backtrace:
CPU: 0 PID: 428 Comm: kworker/u6:8 Not tainted 5.10.213-std-def-alt1 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
                BIOS 1.16.0-alt1 04/01/2014
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x19b/0x203 lib/dump_stack.c:118
 print_circular_bug.cold+0x162/0x171 kernel/locking/lockdep.c:2002
 check_noncircular+0x263/0x2e0 kernel/locking/lockdep.c:2123
 check_prev_add kernel/locking/lockdep.c:2988 [inline]
 check_prevs_add kernel/locking/lockdep.c:3113 [inline]
 validate_chain kernel/locking/lockdep.c:3729 [inline]
 __lock_acquire+0x298f/0x5500 kernel/locking/lockdep.c:4955
 lock_acquire kernel/locking/lockdep.c:5566 [inline]
 lock_acquire+0x1fe/0x550 kernel/locking/lockdep.c:5531
 __mutex_lock_common kernel/locking/mutex.c:968 [inline]
 __mutex_lock+0x142/0x10c0 kernel/locking/mutex.c:1109
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:1124
 tty_buffer_flush+0x7b/0x2b0 drivers/tty/tty_buffer.c:228
 pty_flush_buffer+0x4e/0x170 drivers/tty/pty.c:222
 tty_driver_flush_buffer+0x65/0x80 drivers/tty/tty_ioctl.c:96
 isig+0x1e4/0x440 drivers/tty/n_tty.c:1138
 n_tty_receive_signal_char+0x24/0x160 drivers/tty/n_tty.c:1239
 n_tty_receive_char_special+0x1261/0x2a70 drivers/tty/n_tty.c:1285
 n_tty_receive_buf_fast drivers/tty/n_tty.c:1606 [inline]
 __receive_buf drivers/tty/n_tty.c:1640 [inline]
 n_tty_receive_buf_common+0x1e76/0x2b60 drivers/tty/n_tty.c:1738
 n_tty_receive_buf2+0x34/0x40 drivers/tty/n_tty.c:1773
 tty_ldisc_receive_buf+0xb1/0x1a0 drivers/tty/tty_buffer.c:441
 tty_port_default_receive_buf+0x73/0xa0 drivers/tty/tty_port.c:39
 receive_buf drivers/tty/tty_buffer.c:461 [inline]
 flush_to_ldisc+0x21c/0x400 drivers/tty/tty_buffer.c:513
 process_one_work+0x9ae/0x14b0 kernel/workqueue.c:2282
 worker_thread+0x622/0x1320 kernel/workqueue.c:2428
 kthread+0x396/0x470 kernel/kthread.c:313
 ret_from_fork+0x22/0x30 arch/x86/entry/entry_64.S:299

Cc: stable@vger.kernel.org
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/tty/tty_buffer.c   | 5 +++--
 include/linux/tty_buffer.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 79f0ff94ce00da..e777bd5f3a2fca 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -226,7 +226,7 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
 
 	atomic_inc(&buf->priority);
 
-	mutex_lock(&buf->lock);
+	mutex_lock(&buf->flush_mtx);
 	/* paired w/ release in __tty_buffer_request_room; ensures there are
 	 * no pending memory accesses to the freed buffer
 	 */
@@ -241,7 +241,7 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
 		ld->ops->flush_buffer(tty);
 
 	atomic_dec(&buf->priority);
-	mutex_unlock(&buf->lock);
+	mutex_unlock(&buf->flush_mtx);
 }
 
 /**
@@ -577,6 +577,7 @@ void tty_buffer_init(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
 
+	mutex_init(&buf->flush_mtx);
 	mutex_init(&buf->lock);
 	tty_buffer_reset(&buf->sentinel, 0);
 	buf->head = &buf->sentinel;
diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
index 31125e3be3c55e..cea4eacc3b70d3 100644
--- a/include/linux/tty_buffer.h
+++ b/include/linux/tty_buffer.h
@@ -35,6 +35,7 @@ static inline u8 *flag_buf_ptr(struct tty_buffer *b, unsigned int ofs)
 struct tty_bufhead {
 	struct tty_buffer *head;	/* Queue head */
 	struct work_struct work;
+	struct mutex	   flush_mtx;	/* For use in tty_buffer_flush() */
 	struct mutex	   lock;
 	atomic_t	   priority;
 	struct tty_buffer sentinel;
-- 
2.33.8


