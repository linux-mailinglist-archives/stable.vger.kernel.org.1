Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7244703A4D
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244881AbjEORuc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244813AbjEORuF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACF57DA5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88ACF62F28
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D7EC4339E;
        Mon, 15 May 2023 17:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172882;
        bh=hSekKEvTBJng/c62VCDV7wKoBVtfTzjKOvaVkyEumAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXzwEVxKPDyu6vdCn7JODK5faXcVwl5dQCeDCTxdnqbvTs5RNbauLjM3TMsFtudxI
         B47/1yP72snsIFXjAbG2rHxB9BPrwz87quxtEQ3kxczyDMJEnoEzAV4mONQk2/3Gu/
         ckdi/XkvpHHHViSQ1WQ0hZFP3PjQvMxOJETRQPIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 298/381] tty: move some internal tty lock enums and functions out of tty.h
Date:   Mon, 15 May 2023 18:29:09 +0200
Message-Id: <20230515161750.258256410@linuxfoundation.org>
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

[ Upstream commit 6c80c0b94b94192d9a34b400f8237703c6475f4d ]

Move the TTY_LOCK_* enums and tty_ldisc lock functions out of the global
tty.h into the local header file to clean things up.

Cc: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20210408125134.3016837-10-gregkh@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 094fb49a2d0d ("tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty.h        | 26 ++++++++++++++++++++++++++
 drivers/tty/tty_buffer.c |  2 +-
 drivers/tty/tty_mutex.c  |  1 +
 include/linux/tty.h      | 26 --------------------------
 4 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index f131d538b62b9..552e263e02dfb 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -18,6 +18,32 @@
 #define tty_info_ratelimited(tty, f, ...) \
 		tty_msg(pr_info_ratelimited, tty, f, ##__VA_ARGS__)
 
+/*
+ * Lock subclasses for tty locks
+ *
+ * TTY_LOCK_NORMAL is for normal ttys and master ptys.
+ * TTY_LOCK_SLAVE is for slave ptys only.
+ *
+ * Lock subclasses are necessary for handling nested locking with pty pairs.
+ * tty locks which use nested locking:
+ *
+ * legacy_mutex - Nested tty locks are necessary for releasing pty pairs.
+ *		  The stable lock order is master pty first, then slave pty.
+ * termios_rwsem - The stable lock order is tty_buffer lock->termios_rwsem.
+ *		   Subclassing this lock enables the slave pty to hold its
+ *		   termios_rwsem when claiming the master tty_buffer lock.
+ * tty_buffer lock - slave ptys can claim nested buffer lock when handling
+ *		     signal chars. The stable lock order is slave pty, then
+ *		     master.
+ */
+enum {
+	TTY_LOCK_NORMAL = 0,
+	TTY_LOCK_SLAVE,
+};
+
+int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout);
+void tty_ldisc_unlock(struct tty_struct *tty);
+
 /* tty_audit.c */
 #ifdef CONFIG_AUDIT
 void tty_audit_add_data(struct tty_struct *tty, const void *data, size_t size);
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 5bbc2e010b483..9f23798155573 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -17,7 +17,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/ratelimit.h>
-
+#include "tty.h"
 
 #define MIN_TTYB_SIZE	256
 #define TTYB_ALIGN_MASK	255
diff --git a/drivers/tty/tty_mutex.c b/drivers/tty/tty_mutex.c
index 2640635ee177d..393518a24cfe2 100644
--- a/drivers/tty/tty_mutex.c
+++ b/drivers/tty/tty_mutex.c
@@ -4,6 +4,7 @@
 #include <linux/kallsyms.h>
 #include <linux/semaphore.h>
 #include <linux/sched.h>
+#include "tty.h"
 
 /* Legacy tty mutex glue */
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index a1a9c4b8210ea..af398d0aa9fdc 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -16,30 +16,6 @@
 #include <linux/llist.h>
 
 
-/*
- * Lock subclasses for tty locks
- *
- * TTY_LOCK_NORMAL is for normal ttys and master ptys.
- * TTY_LOCK_SLAVE is for slave ptys only.
- *
- * Lock subclasses are necessary for handling nested locking with pty pairs.
- * tty locks which use nested locking:
- *
- * legacy_mutex - Nested tty locks are necessary for releasing pty pairs.
- *		  The stable lock order is master pty first, then slave pty.
- * termios_rwsem - The stable lock order is tty_buffer lock->termios_rwsem.
- *		   Subclassing this lock enables the slave pty to hold its
- *		   termios_rwsem when claiming the master tty_buffer lock.
- * tty_buffer lock - slave ptys can claim nested buffer lock when handling
- *		     signal chars. The stable lock order is slave pty, then
- *		     master.
- */
-
-enum {
-	TTY_LOCK_NORMAL = 0,
-	TTY_LOCK_SLAVE,
-};
-
 /*
  * (Note: the *_driver.minor_start values 1, 64, 128, 192 are
  * hardcoded at present.)
@@ -419,8 +395,6 @@ extern const char *tty_name(const struct tty_struct *tty);
 extern struct tty_struct *tty_kopen(dev_t device);
 extern void tty_kclose(struct tty_struct *tty);
 extern int tty_dev_name_to_number(const char *name, dev_t *number);
-extern int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout);
-extern void tty_ldisc_unlock(struct tty_struct *tty);
 extern ssize_t redirected_tty_write(struct kiocb *, struct iov_iter *);
 #else
 static inline void tty_kref_put(struct tty_struct *tty)
-- 
2.39.2



