Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EAA77009E
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 14:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjHDM6B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 08:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjHDM57 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 08:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04E711B
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 05:57:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4362961FDA
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 12:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5455DC433C7;
        Fri,  4 Aug 2023 12:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691153877;
        bh=khpARjLIPLEgJtfNGggyOLA5LB4PX6FRf87HruevRu8=;
        h=Subject:To:From:Date:From;
        b=orDyhdiSC5OLENdK/y1YdidM7BVNH7Hh/6zk7FAzx26WiDc3cBhquwtiVTccsqdrN
         9M/21Y7S4G0A04a8M6h7rAEUGkgqx2rz39oyd54QlKE+7+OBkpUfsjON0AlJPJrHDL
         m6rbAWC+vfpQ47oJ3j/MMzAYmUH9Mj7LKzfaEN8o=
Subject: patch "usb-storage: alauda: Fix uninit-value in alauda_check_media()" added to usb-linus
To:     stern@rowland.harvard.edu, christophe.jaillet@wanadoo.fr,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 04 Aug 2023 14:57:41 +0200
Message-ID: <2023080441-vaseline-unlawful-68b1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    usb-storage: alauda: Fix uninit-value in alauda_check_media()

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From a6ff6e7a9dd69364547751db0f626a10a6d628d2 Mon Sep 17 00:00:00 2001
From: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 2 Aug 2023 13:49:02 -0400
Subject: usb-storage: alauda: Fix uninit-value in alauda_check_media()

Syzbot got KMSAN to complain about access to an uninitialized value in
the alauda subdriver of usb-storage:

BUG: KMSAN: uninit-value in alauda_transport+0x462/0x57f0
drivers/usb/storage/alauda.c:1137
CPU: 0 PID: 12279 Comm: usb-storage Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x13a/0x2b0 mm/kmsan/kmsan_report.c:108
  __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:250
  alauda_check_media+0x344/0x3310 drivers/usb/storage/alauda.c:460

The problem is that alauda_check_media() doesn't verify that its USB
transfer succeeded before trying to use the received data.  What
should happen if the transfer fails isn't entirely clear, but a
reasonably conservative approach is to pretend that no media is
present.

A similar problem exists in a usb_stor_dbg() call in
alauda_get_media_status().  In this case, when an error occurs the
call is redundant, because usb_stor_ctrl_transfer() already will print
a debugging message.

Finally, unrelated to the uninitialized memory access, is the fact
that alauda_check_media() performs DMA to a buffer on the stack.
Fortunately usb-storage provides a general purpose DMA-able buffer for
uses like this.  We'll use it instead.

Reported-and-tested-by: syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000007d25ff059457342d@google.com/T/
Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Fixes: e80b0fade09e ("[PATCH] USB Storage: add alauda support")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/693d5d5e-f09b-42d0-8ed9-1f96cd30bcce@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/alauda.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 5e912dd29b4c..115f05a6201a 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -318,7 +318,8 @@ static int alauda_get_media_status(struct us_data *us, unsigned char *data)
 	rc = usb_stor_ctrl_transfer(us, us->recv_ctrl_pipe,
 		command, 0xc0, 0, 1, data, 2);
 
-	usb_stor_dbg(us, "Media status %02X %02X\n", data[0], data[1]);
+	if (rc == USB_STOR_XFER_GOOD)
+		usb_stor_dbg(us, "Media status %02X %02X\n", data[0], data[1]);
 
 	return rc;
 }
@@ -454,9 +455,14 @@ static int alauda_init_media(struct us_data *us)
 static int alauda_check_media(struct us_data *us)
 {
 	struct alauda_info *info = (struct alauda_info *) us->extra;
-	unsigned char status[2];
+	unsigned char *status = us->iobuf;
+	int rc;
 
-	alauda_get_media_status(us, status);
+	rc = alauda_get_media_status(us, status);
+	if (rc != USB_STOR_XFER_GOOD) {
+		status[0] = 0xF0;	/* Pretend there's no media */
+		status[1] = 0;
+	}
 
 	/* Check for no media or door open */
 	if ((status[0] & 0x80) || ((status[0] & 0x1F) == 0x10)
-- 
2.41.0


