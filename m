Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC74703A51
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244890AbjEORug (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244832AbjEORuK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D398D06C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4A3B62D28
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C88C433EF;
        Mon, 15 May 2023 17:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172889;
        bh=HxTpez4AvTPhBGrFVc6ecMQA14m6wMPfZjCGYr3B/XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1WjhK/d7RtdGNMmK48LM7JzlAgpDYXN3/iZBgIt/nJk9XvlMOkmjo6k1qoI9tiNOP
         Se/tLhqDqVEA2hEr/xgA3wFvLpPAhNMBLTfiZ0TxJ0pKYS/HTvJF5ZLWMPYCROEHoJ
         BrIGZ6eJ7Md5lA48YrYXO7tnzUPKOKzy0VkdRI8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 300/381] tty: clean include/linux/tty.h up
Date:   Mon, 15 May 2023 18:29:11 +0200
Message-Id: <20230515161750.356864513@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 5ffa6e344a1c92a27c242f500fc74e6eb361a4bc ]

There are a lot of tty-core-only functions that are listed in
include/linux/tty.h.  Move them to drivers/tty/tty.h so that no one else
can accidentally call them or think that they are public functions.

Cc: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20210408125134.3016837-14-gregkh@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 094fb49a2d0d ("tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/n_gsm.c        |  1 +
 drivers/tty/n_hdlc.c       |  1 +
 drivers/tty/tty.h          | 37 +++++++++++++++++++++++++++++++++++++
 drivers/tty/tty_baudrate.c |  1 +
 include/linux/tty.h        | 33 ---------------------------------
 5 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index f5063499f9cf6..23b014b8c9199 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -50,6 +50,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/gsmmux.h>
+#include "tty.h"
 
 static int debug;
 module_param(debug, int, 0600);
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 48c64e68017cd..697199a3ca019 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -100,6 +100,7 @@
 
 #include <asm/termios.h>
 #include <linux/uaccess.h>
+#include "tty.h"
 
 /*
  * Buffers for individual HDLC frames
diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index 9eda9e5f8ad5e..74ed99bc5449a 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -59,6 +59,43 @@ static inline void tty_set_flow_change(struct tty_struct *tty, int val)
 int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout);
 void tty_ldisc_unlock(struct tty_struct *tty);
 
+int __tty_check_change(struct tty_struct *tty, int sig);
+int tty_check_change(struct tty_struct *tty);
+void __stop_tty(struct tty_struct *tty);
+void __start_tty(struct tty_struct *tty);
+void tty_vhangup_session(struct tty_struct *tty);
+void tty_open_proc_set_tty(struct file *filp, struct tty_struct *tty);
+int tty_signal_session_leader(struct tty_struct *tty, int exit_session);
+void session_clear_tty(struct pid *session);
+void tty_buffer_free_all(struct tty_port *port);
+void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld);
+void tty_buffer_init(struct tty_port *port);
+void tty_buffer_set_lock_subclass(struct tty_port *port);
+bool tty_buffer_restart_work(struct tty_port *port);
+bool tty_buffer_cancel_work(struct tty_port *port);
+void tty_buffer_flush_work(struct tty_port *port);
+speed_t tty_termios_input_baud_rate(struct ktermios *termios);
+void tty_ldisc_hangup(struct tty_struct *tty, bool reset);
+int tty_ldisc_reinit(struct tty_struct *tty, int disc);
+long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+long tty_jobctrl_ioctl(struct tty_struct *tty, struct tty_struct *real_tty,
+		       struct file *file, unsigned int cmd, unsigned long arg);
+void tty_default_fops(struct file_operations *fops);
+struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx);
+int tty_alloc_file(struct file *file);
+void tty_add_file(struct tty_struct *tty, struct file *file);
+void tty_free_file(struct file *file);
+int tty_release(struct inode *inode, struct file *filp);
+
+#define tty_is_writelocked(tty)  (mutex_is_locked(&tty->atomic_write_lock))
+
+int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty);
+void tty_ldisc_release(struct tty_struct *tty);
+int __must_check tty_ldisc_init(struct tty_struct *tty);
+void tty_ldisc_deinit(struct tty_struct *tty);
+
+void tty_sysctl_init(void);
+
 /* tty_audit.c */
 #ifdef CONFIG_AUDIT
 void tty_audit_add_data(struct tty_struct *tty, const void *data, size_t size);
diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 84fec3c62d6a4..9d0093d84e085 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -8,6 +8,7 @@
 #include <linux/termios.h>
 #include <linux/tty.h>
 #include <linux/export.h>
+#include "tty.h"
 
 
 /*
diff --git a/include/linux/tty.h b/include/linux/tty.h
index a641fc6a7fa8b..e51d75f5165b5 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -432,11 +432,7 @@ static inline struct tty_struct *tty_kref_get(struct tty_struct *tty)
 
 extern const char *tty_driver_name(const struct tty_struct *tty);
 extern void tty_wait_until_sent(struct tty_struct *tty, long timeout);
-extern int __tty_check_change(struct tty_struct *tty, int sig);
-extern int tty_check_change(struct tty_struct *tty);
-extern void __stop_tty(struct tty_struct *tty);
 extern void stop_tty(struct tty_struct *tty);
-extern void __start_tty(struct tty_struct *tty);
 extern void start_tty(struct tty_struct *tty);
 extern int tty_register_driver(struct tty_driver *driver);
 extern int tty_unregister_driver(struct tty_driver *driver);
@@ -461,23 +457,11 @@ extern int tty_do_resize(struct tty_struct *tty, struct winsize *ws);
 extern int is_current_pgrp_orphaned(void);
 extern void tty_hangup(struct tty_struct *tty);
 extern void tty_vhangup(struct tty_struct *tty);
-extern void tty_vhangup_session(struct tty_struct *tty);
 extern int tty_hung_up_p(struct file *filp);
 extern void do_SAK(struct tty_struct *tty);
 extern void __do_SAK(struct tty_struct *tty);
-extern void tty_open_proc_set_tty(struct file *filp, struct tty_struct *tty);
-extern int tty_signal_session_leader(struct tty_struct *tty, int exit_session);
-extern void session_clear_tty(struct pid *session);
 extern void no_tty(void);
-extern void tty_buffer_free_all(struct tty_port *port);
-extern void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld);
-extern void tty_buffer_init(struct tty_port *port);
-extern void tty_buffer_set_lock_subclass(struct tty_port *port);
-extern bool tty_buffer_restart_work(struct tty_port *port);
-extern bool tty_buffer_cancel_work(struct tty_port *port);
-extern void tty_buffer_flush_work(struct tty_port *port);
 extern speed_t tty_termios_baud_rate(struct ktermios *termios);
-extern speed_t tty_termios_input_baud_rate(struct ktermios *termios);
 extern void tty_termios_encode_baud_rate(struct ktermios *termios,
 						speed_t ibaud, speed_t obaud);
 extern void tty_encode_baud_rate(struct tty_struct *tty,
@@ -505,27 +489,16 @@ extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 extern struct tty_ldisc *tty_ldisc_ref(struct tty_struct *);
 extern void tty_ldisc_deref(struct tty_ldisc *);
 extern struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *);
-extern void tty_ldisc_hangup(struct tty_struct *tty, bool reset);
-extern int tty_ldisc_reinit(struct tty_struct *tty, int disc);
 extern const struct seq_operations tty_ldiscs_seq_ops;
 
 extern void tty_wakeup(struct tty_struct *tty);
 extern void tty_ldisc_flush(struct tty_struct *tty);
 
-extern long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 extern int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
 			unsigned int cmd, unsigned long arg);
-extern long tty_jobctrl_ioctl(struct tty_struct *tty, struct tty_struct *real_tty,
-			      struct file *file, unsigned int cmd, unsigned long arg);
 extern int tty_perform_flush(struct tty_struct *tty, unsigned long arg);
-extern void tty_default_fops(struct file_operations *fops);
-extern struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx);
-extern int tty_alloc_file(struct file *file);
-extern void tty_add_file(struct tty_struct *tty, struct file *file);
-extern void tty_free_file(struct file *file);
 extern struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx);
 extern void tty_release_struct(struct tty_struct *tty, int idx);
-extern int tty_release(struct inode *inode, struct file *filp);
 extern void tty_init_termios(struct tty_struct *tty);
 extern void tty_save_termios(struct tty_struct *tty);
 extern int tty_standard_install(struct tty_driver *driver,
@@ -533,8 +506,6 @@ extern int tty_standard_install(struct tty_driver *driver,
 
 extern struct mutex tty_mutex;
 
-#define tty_is_writelocked(tty)  (mutex_is_locked(&tty->atomic_write_lock))
-
 extern void tty_port_init(struct tty_port *port);
 extern void tty_port_link_device(struct tty_port *port,
 		struct tty_driver *driver, unsigned index);
@@ -672,10 +643,6 @@ static inline int tty_port_users(struct tty_port *port)
 extern int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc);
 extern int tty_unregister_ldisc(int disc);
 extern int tty_set_ldisc(struct tty_struct *tty, int disc);
-extern int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty);
-extern void tty_ldisc_release(struct tty_struct *tty);
-extern int __must_check tty_ldisc_init(struct tty_struct *tty);
-extern void tty_ldisc_deinit(struct tty_struct *tty);
 extern int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 				 char *f, int count);
 
-- 
2.39.2



