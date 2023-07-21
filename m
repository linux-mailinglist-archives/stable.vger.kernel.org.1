Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD475BFF2
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjGUHj0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjGUHjQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:39:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8716B30E1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B868D6155B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05EEC433C9;
        Fri, 21 Jul 2023 07:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689925152;
        bh=ioPEc5RscgORJw2/x9Qml0WmmFBfNjhN1Kqglwh1UrE=;
        h=Subject:To:Cc:From:Date:From;
        b=mNVrtcc1p7yRUYgpcvnkBqim6Lqws8sw0iSurmR/vCMHprVUgRkgZk4LER/j572qZ
         kTC7UKb9pHe2XkFlmk92Rztx3QWZifG0lmBq1+aDDVAxJd+eti/3VK9NG33LlUBkMK
         +0mUUQZrUKFwPmD8vSrAwlWNbZB6C9SX3U+U4pV0=
Subject: FAILED: patch "[PATCH] tty: fix hang on tty device with no_room set" failed to apply to 5.15-stable tree
To:     caelli@tencent.com, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:39:07 +0200
Message-ID: <2023072107-washbowl-exporter-0ed3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4903fde8047a28299d1fc79c1a0dcc255e928f12
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072107-washbowl-exporter-0ed3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

4903fde8047a ("tty: fix hang on tty device with no_room set")
947d66b68f3c ("n_tty: Rename tail to old_tail in n_tty_read()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4903fde8047a28299d1fc79c1a0dcc255e928f12 Mon Sep 17 00:00:00 2001
From: Hui Li <caelli@tencent.com>
Date: Thu, 6 Apr 2023 10:44:50 +0800
Subject: [PATCH] tty: fix hang on tty device with no_room set
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It is possible to hang pty devices in this case, the reader was
blocking at epoll on master side, the writer was sleeping at
wait_woken inside n_tty_write on slave side, and the write buffer
on tty_port was full, we found that the reader and writer would
never be woken again and blocked forever.

The problem was caused by a race between reader and kworker:
n_tty_read(reader):  n_tty_receive_buf_common(kworker):
copy_from_read_buf()|
                    |room = N_TTY_BUF_SIZE - (ldata->read_head - tail)
                    |room <= 0
n_tty_kick_worker() |
                    |ldata->no_room = true

After writing to slave device, writer wakes up kworker to flush
data on tty_port to reader, and the kworker finds that reader
has no room to store data so room <= 0 is met. At this moment,
reader consumes all the data on reader buffer and calls
n_tty_kick_worker to check ldata->no_room which is false and
reader quits reading. Then kworker sets ldata->no_room=true
and quits too.

If write buffer is not full, writer will wake kworker to flush data
again after following writes, but if write buffer is full and writer
goes to sleep, kworker will never be woken again and tty device is
blocked.

This problem can be solved with a check for read buffer size inside
n_tty_receive_buf_common, if read buffer is empty and ldata->no_room
is true, a call to n_tty_kick_worker is necessary to keep flushing
data to reader.

Cc: <stable@vger.kernel.org>
Fixes: 42458f41d08f ("n_tty: Ensure reader restarts worker for next reader")
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Hui Li <caelli@tencent.com>
Message-ID: <1680749090-14106-1-git-send-email-caelli@tencent.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 1c9e5d2ea7de..552e8a741562 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -203,8 +203,8 @@ static void n_tty_kick_worker(struct tty_struct *tty)
 	struct n_tty_data *ldata = tty->disc_data;
 
 	/* Did the input worker stop? Restart it */
-	if (unlikely(ldata->no_room)) {
-		ldata->no_room = 0;
+	if (unlikely(READ_ONCE(ldata->no_room))) {
+		WRITE_ONCE(ldata->no_room, 0);
 
 		WARN_RATELIMIT(tty->port->itty == NULL,
 				"scheduling with invalid itty\n");
@@ -1697,7 +1697,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 			if (overflow && room < 0)
 				ldata->read_head--;
 			room = overflow;
-			ldata->no_room = flow && !room;
+			WRITE_ONCE(ldata->no_room, flow && !room);
 		} else
 			overflow = 0;
 
@@ -1728,6 +1728,17 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 	} else
 		n_tty_check_throttle(tty);
 
+	if (unlikely(ldata->no_room)) {
+		/*
+		 * Barrier here is to ensure to read the latest read_tail in
+		 * chars_in_buffer() and to make sure that read_tail is not loaded
+		 * before ldata->no_room is set.
+		 */
+		smp_mb();
+		if (!chars_in_buffer(tty))
+			n_tty_kick_worker(tty);
+	}
+
 	up_read(&tty->termios_rwsem);
 
 	return rcvd;
@@ -2281,8 +2292,14 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 		if (time)
 			timeout = time;
 	}
-	if (old_tail != ldata->read_tail)
+	if (old_tail != ldata->read_tail) {
+		/*
+		 * Make sure no_room is not read in n_tty_kick_worker()
+		 * before setting ldata->read_tail in copy_from_read_buf().
+		 */
+		smp_mb();
 		n_tty_kick_worker(tty);
+	}
 	up_read(&tty->termios_rwsem);
 
 	remove_wait_queue(&tty->read_wait, &wait);

