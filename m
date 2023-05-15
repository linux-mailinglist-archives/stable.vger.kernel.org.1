Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D40B703C22
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245180AbjEOSKE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245229AbjEOSJt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:09:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0E24C9CF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBE8A630E5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3649C433EF;
        Mon, 15 May 2023 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684174042;
        bh=4y7ee4X9To9ZpxQqssdP/vwVpTLA/zXILV5r8XwmuLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jivYrsJRETm5nWZxBHH22k82T5h1fn56DHSbFxkPTwiBKtRECjYCVSGWYzuG+XSty
         Do97QztkIUHaJwaD2nZu4pST5mFQoknjEaDM/xy90BmdxHedpCVFeKRATA5K90vW94
         IxwNfS3+M2kkXyVzsnsEu5bufS8LygiNT1AJFlzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5.4 268/282] tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH
Date:   Mon, 15 May 2023 18:30:46 +0200
Message-Id: <20230515161730.350354186@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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
@@ -876,13 +876,13 @@ static ssize_t tty_read(struct file *fil
 	return i;
 }
 
-static void tty_write_unlock(struct tty_struct *tty)
+void tty_write_unlock(struct tty_struct *tty)
 {
 	mutex_unlock(&tty->atomic_write_lock);
 	wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
 }
 
-static int tty_write_lock(struct tty_struct *tty, int ndelay)
+int tty_write_lock(struct tty_struct *tty, int ndelay)
 {
 	if (!mutex_trylock(&tty->atomic_write_lock)) {
 		if (ndelay)
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -397,21 +397,42 @@ static int set_termios(struct tty_struct
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
@@ -480,6 +480,8 @@ extern void __stop_tty(struct tty_struct
 extern void stop_tty(struct tty_struct *tty);
 extern void __start_tty(struct tty_struct *tty);
 extern void start_tty(struct tty_struct *tty);
+void tty_write_unlock(struct tty_struct *tty);
+int tty_write_lock(struct tty_struct *tty, int ndelay);
 extern int tty_register_driver(struct tty_driver *driver);
 extern int tty_unregister_driver(struct tty_driver *driver);
 extern struct device *tty_register_device(struct tty_driver *driver,


