Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C1573E888
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjFZS0n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjFZS02 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:26:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93F826A0
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E2F060EFC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6836DC433C0;
        Mon, 26 Jun 2023 18:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803954;
        bh=O1TeodQpXH7fpQHjOF/TDpot2qKNrnaRjiIfccIIj6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjXoU28eSukLhEcu+BNoBNke7JO8KjKuep8GcrUMLnZpzqBIgUF2o6H5vv/KuYGlF
         ejqEq7CVJp8f/hO5am7hzSfEoVMcxBbhAIx8rAC42kPmbezcTYFIHPxEcqX9qD45zj
         GNQrUMVC8crgnjxISbIUOM7+sH+eEOMLxt2DgoMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tony Camuso <tcamuso@redhat.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 4.19 08/41] ipmi: move message error checking to avoid deadlock
Date:   Mon, 26 Jun 2023 20:11:31 +0200
Message-ID: <20230626180736.594497623@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180736.243379844@linuxfoundation.org>
References: <20230626180736.243379844@linuxfoundation.org>
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

From: Tony Camuso <tcamuso@redhat.com>

commit 383035211c79d4d98481a09ad429b31c7dbf22bd upstream.

V1->V2: in handle_one_rcv_msg, if data_size > 2, set requeue to zero and
        goto out instead of calling ipmi_free_msg.
        Kosuke Tatsukawa <tatsu@ab.jp.nec.com>

In the source stack trace below, function set_need_watch tries to
take out the same si_lock that was taken earlier by ipmi_thread.

ipmi_thread() [drivers/char/ipmi/ipmi_si_intf.c:995]
 smi_event_handler() [drivers/char/ipmi/ipmi_si_intf.c:765]
  handle_transaction_done() [drivers/char/ipmi/ipmi_si_intf.c:555]
   deliver_recv_msg() [drivers/char/ipmi/ipmi_si_intf.c:283]
    ipmi_smi_msg_received() [drivers/char/ipmi/ipmi_msghandler.c:4503]
     intf_err_seq() [drivers/char/ipmi/ipmi_msghandler.c:1149]
      smi_remove_watch() [drivers/char/ipmi/ipmi_msghandler.c:999]
       set_need_watch() [drivers/char/ipmi/ipmi_si_intf.c:1066]

Upstream commit e1891cffd4c4896a899337a243273f0e23c028df adds code to
ipmi_smi_msg_received() to call smi_remove_watch() via intf_err_seq()
and this seems to be causing the deadlock.

commit e1891cffd4c4896a899337a243273f0e23c028df
Author: Corey Minyard <cminyard@mvista.com>
Date:   Wed Oct 24 15:17:04 2018 -0500
    ipmi: Make the smi watcher be disabled immediately when not needed

The fix is to put all messages in the queue and move the message
checking code out of ipmi_smi_msg_received and into handle_one_recv_msg,
which processes the message checking after ipmi_thread releases its
locks.

Additionally,Kosuke Tatsukawa <tatsu@ab.jp.nec.com> reported that
handle_new_recv_msgs calls ipmi_free_msg when handle_one_rcv_msg returns
zero, so that the call to ipmi_free_msg in handle_one_rcv_msg introduced
another panic when "ipmitool sensor list" was run in a loop. He
submitted this part of the patch.

+free_msg:
+               requeue = 0;
+               goto out;

Reported by: Osamu Samukawa <osa-samukawa@tg.jp.nec.com>
Characterized by: Kosuke Tatsukawa <tatsu@ab.jp.nec.com>
Signed-off-by: Tony Camuso <tcamuso@redhat.com>
Fixes: e1891cffd4c4 ("ipmi: Make the smi watcher be disabled immediately when not needed")
Cc: stable@vger.kernel.org # 5.1
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_msghandler.c |  114 ++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 57 deletions(-)

--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4239,7 +4239,53 @@ static int handle_one_recv_msg(struct ip
 	int chan;
 
 	ipmi_debug_msg("Recv:", msg->rsp, msg->rsp_size);
-	if (msg->rsp_size < 2) {
+
+	if ((msg->data_size >= 2)
+	    && (msg->data[0] == (IPMI_NETFN_APP_REQUEST << 2))
+	    && (msg->data[1] == IPMI_SEND_MSG_CMD)
+	    && (msg->user_data == NULL)) {
+
+		if (intf->in_shutdown)
+			goto free_msg;
+
+		/*
+		 * This is the local response to a command send, start
+		 * the timer for these.  The user_data will not be
+		 * NULL if this is a response send, and we will let
+		 * response sends just go through.
+		 */
+
+		/*
+		 * Check for errors, if we get certain errors (ones
+		 * that mean basically we can try again later), we
+		 * ignore them and start the timer.  Otherwise we
+		 * report the error immediately.
+		 */
+		if ((msg->rsp_size >= 3) && (msg->rsp[2] != 0)
+		    && (msg->rsp[2] != IPMI_NODE_BUSY_ERR)
+		    && (msg->rsp[2] != IPMI_LOST_ARBITRATION_ERR)
+		    && (msg->rsp[2] != IPMI_BUS_ERR)
+		    && (msg->rsp[2] != IPMI_NAK_ON_WRITE_ERR)) {
+			int ch = msg->rsp[3] & 0xf;
+			struct ipmi_channel *chans;
+
+			/* Got an error sending the message, handle it. */
+
+			chans = READ_ONCE(intf->channel_list)->c;
+			if ((chans[ch].medium == IPMI_CHANNEL_MEDIUM_8023LAN)
+			    || (chans[ch].medium == IPMI_CHANNEL_MEDIUM_ASYNC))
+				ipmi_inc_stat(intf, sent_lan_command_errs);
+			else
+				ipmi_inc_stat(intf, sent_ipmb_command_errs);
+			intf_err_seq(intf, msg->msgid, msg->rsp[2]);
+		} else
+			/* The message was sent, start the timer. */
+			intf_start_seq_timer(intf, msg->msgid);
+free_msg:
+		requeue = 0;
+		goto out;
+
+	} else if (msg->rsp_size < 2) {
 		/* Message is too small to be correct. */
 		dev_warn(intf->si_dev,
 			 PFX "BMC returned to small a message for netfn %x cmd %x, got %d bytes\n",
@@ -4496,62 +4542,16 @@ void ipmi_smi_msg_received(struct ipmi_s
 	unsigned long flags = 0; /* keep us warning-free. */
 	int run_to_completion = intf->run_to_completion;
 
-	if ((msg->data_size >= 2)
-	    && (msg->data[0] == (IPMI_NETFN_APP_REQUEST << 2))
-	    && (msg->data[1] == IPMI_SEND_MSG_CMD)
-	    && (msg->user_data == NULL)) {
-
-		if (intf->in_shutdown)
-			goto free_msg;
-
-		/*
-		 * This is the local response to a command send, start
-		 * the timer for these.  The user_data will not be
-		 * NULL if this is a response send, and we will let
-		 * response sends just go through.
-		 */
-
-		/*
-		 * Check for errors, if we get certain errors (ones
-		 * that mean basically we can try again later), we
-		 * ignore them and start the timer.  Otherwise we
-		 * report the error immediately.
-		 */
-		if ((msg->rsp_size >= 3) && (msg->rsp[2] != 0)
-		    && (msg->rsp[2] != IPMI_NODE_BUSY_ERR)
-		    && (msg->rsp[2] != IPMI_LOST_ARBITRATION_ERR)
-		    && (msg->rsp[2] != IPMI_BUS_ERR)
-		    && (msg->rsp[2] != IPMI_NAK_ON_WRITE_ERR)) {
-			int ch = msg->rsp[3] & 0xf;
-			struct ipmi_channel *chans;
-
-			/* Got an error sending the message, handle it. */
-
-			chans = READ_ONCE(intf->channel_list)->c;
-			if ((chans[ch].medium == IPMI_CHANNEL_MEDIUM_8023LAN)
-			    || (chans[ch].medium == IPMI_CHANNEL_MEDIUM_ASYNC))
-				ipmi_inc_stat(intf, sent_lan_command_errs);
-			else
-				ipmi_inc_stat(intf, sent_ipmb_command_errs);
-			intf_err_seq(intf, msg->msgid, msg->rsp[2]);
-		} else
-			/* The message was sent, start the timer. */
-			intf_start_seq_timer(intf, msg->msgid);
-
-free_msg:
-		ipmi_free_smi_msg(msg);
-	} else {
-		/*
-		 * To preserve message order, we keep a queue and deliver from
-		 * a tasklet.
-		 */
-		if (!run_to_completion)
-			spin_lock_irqsave(&intf->waiting_rcv_msgs_lock, flags);
-		list_add_tail(&msg->link, &intf->waiting_rcv_msgs);
-		if (!run_to_completion)
-			spin_unlock_irqrestore(&intf->waiting_rcv_msgs_lock,
-					       flags);
-	}
+	/*
+	 * To preserve message order, we keep a queue and deliver from
+	 * a tasklet.
+	 */
+	if (!run_to_completion)
+		spin_lock_irqsave(&intf->waiting_rcv_msgs_lock, flags);
+	list_add_tail(&msg->link, &intf->waiting_rcv_msgs);
+	if (!run_to_completion)
+		spin_unlock_irqrestore(&intf->waiting_rcv_msgs_lock,
+				       flags);
 
 	if (!run_to_completion)
 		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);


