Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322A377AD14
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjHMVsD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjHMVrJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:47:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869762D69
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:47:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CBD460B9D
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33249C433C7;
        Sun, 13 Aug 2023 21:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963227;
        bh=z+TgCt2axHOi0JD/b9ihB+dAfLjnZYAkQdaoXqs9HZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNySc7HVIgsAlhHypEQlXy32r/dKodgPEhLnlNpyd2fqwf0tnbW5RDL842WlINnrM
         R1Wqg9sVCNcB8xQwLHQYLaOqSm5t+zjGuOfbsSgnHOsDaqfv46g0P5Svj8ohJIkvKc
         bR/p8DVqAwmESXWKsj/Y1h0JJQ0KPvWuw6vGL1Ho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alan Stern <stern@rowland.harvard.edu>,
        syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com
Subject: [PATCH 5.4 10/39] usb-storage: alauda: Fix uninit-value in alauda_check_media()
Date:   Sun, 13 Aug 2023 23:20:01 +0200
Message-ID: <20230813211705.181710768@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211704.796906808@linuxfoundation.org>
References: <20230813211704.796906808@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit a6ff6e7a9dd69364547751db0f626a10a6d628d2 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/alauda.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -318,7 +318,8 @@ static int alauda_get_media_status(struc
 	rc = usb_stor_ctrl_transfer(us, us->recv_ctrl_pipe,
 		command, 0xc0, 0, 1, data, 2);
 
-	usb_stor_dbg(us, "Media status %02X %02X\n", data[0], data[1]);
+	if (rc == USB_STOR_XFER_GOOD)
+		usb_stor_dbg(us, "Media status %02X %02X\n", data[0], data[1]);
 
 	return rc;
 }
@@ -454,10 +455,14 @@ static int alauda_init_media(struct us_d
 static int alauda_check_media(struct us_data *us)
 {
 	struct alauda_info *info = (struct alauda_info *) us->extra;
-	unsigned char status[2];
+	unsigned char *status = us->iobuf;
 	int rc;
 
 	rc = alauda_get_media_status(us, status);
+	if (rc != USB_STOR_XFER_GOOD) {
+		status[0] = 0xF0;	/* Pretend there's no media */
+		status[1] = 0;
+	}
 
 	/* Check for no media or door open */
 	if ((status[0] & 0x80) || ((status[0] & 0x1F) == 0x10)


