Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30038703375
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbjEOQhU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242723AbjEOQhS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:37:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1A219B2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:37:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D404662831
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0118C433EF;
        Mon, 15 May 2023 16:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168636;
        bh=T8au94eHrWZYEQx1/WIYlFxAIfJfkGx5hyBMO3b35V8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qv1qDE27hGQaBWyjWoG1TJAevsgsdyDOfE2SIyDcikNaaa3B7xJ7XN0OHx1oHJD3b
         V+sTIkj/PstJ1/vjD9/WdoTI8B46P3ilk7aO01hHnAN5lReZwW0aHfVW4gW6VBtjZp
         Hd2wD2VmZ/zqHKztpFO6B0lzdnliwHHD/bjsMwz8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4.14 112/116] tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH
Date:   Mon, 15 May 2023 18:26:49 +0200
Message-Id: <20230515161701.958491406@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: "Ilpo J�rvinen" <ilpo.jarvinen@linux.intel.com>

If userspace races tcsetattr() with a write, the drained condition
might not be guaranteed by the kernel. There is a race window after
checking Tx is empty before tty_set_termios() takes termios_rwsem for
write. During that race window, more characters can be queued by a
racing writer.

Any ongoing transmission might produce garbage during HW's
->set_termios() call. The intent of TCSADRAIN/FLUSH seems to be
preventing such a character corruption. If those flags are set, take
tty's write lock to stop any writer before performing the lower layer
Tx empty check and wait for the pending characters to be sent (if any).

The initial wait for all-writers-done must be placed outside of tty's
write lock to avoid deadlock which makes it impossible to use
tty_wait_until_sent(). The write lock is retried if a racing write is
detected.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20230317113318.31327-2-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 094fb49a2d0d6827c86d2e0840873e6db0c491d2)
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty_io.c    |    4 ++--
 drivers/tty/tty_ioctl.c |   45 +++++++++++++++++++++++++++++++++------------
 include/linux/tty.h     |    2 ++
 3 files changed, 37 insertions(+), 14 deletions(-)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -874,13 +874,13 @@ static ssize_t tty_read(struct file *fil
 	return i;
 }
 
-static void tty_write_unlock(struct tty_struct *tty)
+void tty_write_unlock(struct tty_struct *tty)
 {
 	mutex_unlock(&tty->atomic_write_lock);
 	wake_up_interruptible_poll(&tty->write_wait, POLLOUT);
 }
 
-static int tty_write_lock(struct tty_struct *tty, int ndelay)
+int tty_write_lock(struct tty_struct *tty, int ndelay)
 {
 	if (!mutex_trylock(&tty->atomic_write_lock)) {
 		if (ndelay)
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -396,21 +396,42 @@ static int set_termios(struct tty_struct
 	tmp_termios.c_ispeed = tty_termios_input_baud_rate(&tmp_termios);
 	tmp_termios.c_ospeed = tty_termios_baud_rate(&tmp_termios);
 
-	ld = tty_ldisc_ref(tty);
+	if (opt & (TERMIOS_FLUSH|TERMIOS_WAIT)) {
+retry_write_wait:
+		retval = wait_event_interruptible(tty->write_wait, !tty_chars_in_buffer(tty));
+		if (retval < 0)
+			return retval;
 
-	if (ld != NULL) {
-		if ((opt & TERMIOS_FLUSH) && ld->ops->flush_buffer)
-			ld->ops->flush_buffer(tty);
-		tty_ldisc_deref(ld);
-	}
+		if (tty_write_lock(tty, 0) < 0)
+			goto retry_write_wait;
 
-	if (opt & TERMIOS_WAIT) {
-		tty_wait_until_sent(tty, 0);
-		if (signal_pending(current))
-			return -ERESTARTSYS;
-	}
+		/* Racing writer? */
+		if (tty_chars_in_buffer(tty)) {
+			tty_write_unlock(tty);
+			goto retry_write_wait;
+		}
+
+		ld = tty_ldisc_ref(tty);
+		if (ld != NULL) {
+			if ((opt & TERMIOS_FLUSH) && ld->ops->flush_buffer)
+				ld->ops->flush_buffer(tty);
+			tty_ldisc_deref(ld);
+		}
 
-	tty_set_termios(tty, &tmp_termios);
+		if ((opt & TERMIOS_WAIT) && tty->ops->wait_until_sent) {
+			tty->ops->wait_until_sent(tty, 0);
+			if (signal_pending(current)) {
+				tty_write_unlock(tty);
+				return -ERESTARTSYS;
+			}
+		}
+
+		tty_set_termios(tty, &tmp_termios);
+
+		tty_write_unlock(tty);
+	} else {
+		tty_set_termios(tty, &tmp_termios);
+	}
 
 	/* FIXME: Arguably if tmp_termios == tty->termios AND the
 	   actual requested termios was not tmp_termios then we may
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -479,6 +479,8 @@ extern void __stop_tty(struct tty_struct
 extern void stop_tty(struct tty_struct *tty);
 extern void __start_tty(struct tty_struct *tty);
 extern void start_tty(struct tty_struct *tty);
+void tty_write_unlock(struct tty_struct *tty);
+int tty_write_lock(struct tty_struct *tty, int ndelay);
 extern int tty_register_driver(struct tty_driver *driver);
 extern int tty_unregister_driver(struct tty_driver *driver);
 extern struct device *tty_register_device(struct tty_driver *driver,


