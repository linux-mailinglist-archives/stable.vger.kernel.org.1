Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0293573E887
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjFZS0n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjFZS01 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:26:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DAE269A
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:25:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E361B60F30
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED297C433C8;
        Mon, 26 Jun 2023 18:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803951;
        bh=IMWnkiftWDCc7LySE5aPmKhQXRqKJ9T1jVb/jVcAjXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y0mBysmcIwnu7mIY1lLKezgXtrjokaHj+gq1qf6tCD7tR4/QioFUAEFlr0zPvc9Ex
         4Ta+CUfwrzfO6K+3orsmD4H0eFD98/fgld8L+NoE5uVetQSjVm5GXXnP7A3MuOzozq
         x6xMEsEiD3BweFpqJKOeZQt5rHfLBwbUVGlXjNPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Corey Minyard <cminyard@mvista.com>,
        Kamlakant Patel <kamlakant.patel@cavium.com>
Subject: [PATCH 4.19 07/41] ipmi: Make the smi watcher be disabled immediately when not needed
Date:   Mon, 26 Jun 2023 20:11:30 +0200
Message-ID: <20230626180736.543863048@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180736.243379844@linuxfoundation.org>
References: <20230626180736.243379844@linuxfoundation.org>
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

From: Corey Minyard <cminyard@mvista.com>

commit e1891cffd4c4896a899337a243273f0e23c028df upstream.

The code to tell the lower layer to enable or disable watching for
certain things was lazy in disabling, it waited until a timer tick
to see if a disable was necessary.  Not a really big deal, but it
could be improved.

Modify the code to enable and disable watching immediately and don't
do it from the background timer any more.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Kamlakant Patel <kamlakant.patel@cavium.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_msghandler.c |  164 +++++++++++++++++++-----------------
 drivers/char/ipmi/ipmi_si_intf.c    |    2 
 drivers/char/ipmi/ipmi_ssif.c       |    2 
 include/linux/ipmi_smi.h            |   17 ---
 4 files changed, 96 insertions(+), 89 deletions(-)

--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -541,15 +541,20 @@ struct ipmi_smi {
 	atomic_t         event_waiters;
 	unsigned int     ticks_to_req_ev;
 
+	spinlock_t       watch_lock; /* For dealing with watch stuff below. */
+
 	/* How many users are waiting for commands? */
-	atomic_t         command_waiters;
+	unsigned int     command_waiters;
 
 	/* How many users are waiting for watchdogs? */
-	atomic_t         watchdog_waiters;
+	unsigned int     watchdog_waiters;
+
+	/* How many users are waiting for message responses? */
+	unsigned int     response_waiters;
 
 	/*
 	 * Tells what the lower layer has last been asked to watch for,
-	 * messages and/or watchdogs.  Protected by xmit_msgs_lock.
+	 * messages and/or watchdogs.  Protected by watch_lock.
 	 */
 	unsigned int     last_watch_mask;
 
@@ -945,6 +950,64 @@ static void deliver_err_response(struct
 	deliver_local_response(intf, msg);
 }
 
+static void smi_add_watch(struct ipmi_smi *intf, unsigned int flags)
+{
+	unsigned long iflags;
+
+	if (!intf->handlers->set_need_watch)
+		return;
+
+	spin_lock_irqsave(&intf->watch_lock, iflags);
+	if (flags & IPMI_WATCH_MASK_CHECK_MESSAGES)
+		intf->response_waiters++;
+
+	if (flags & IPMI_WATCH_MASK_CHECK_WATCHDOG)
+		intf->watchdog_waiters++;
+
+	if (flags & IPMI_WATCH_MASK_CHECK_COMMANDS)
+		intf->command_waiters++;
+
+	if ((intf->last_watch_mask & flags) != flags) {
+		intf->last_watch_mask |= flags;
+		intf->handlers->set_need_watch(intf->send_info,
+					       intf->last_watch_mask);
+	}
+	spin_unlock_irqrestore(&intf->watch_lock, iflags);
+}
+
+static void smi_remove_watch(struct ipmi_smi *intf, unsigned int flags)
+{
+	unsigned long iflags;
+
+	if (!intf->handlers->set_need_watch)
+		return;
+
+	spin_lock_irqsave(&intf->watch_lock, iflags);
+	if (flags & IPMI_WATCH_MASK_CHECK_MESSAGES)
+		intf->response_waiters--;
+
+	if (flags & IPMI_WATCH_MASK_CHECK_WATCHDOG)
+		intf->watchdog_waiters--;
+
+	if (flags & IPMI_WATCH_MASK_CHECK_COMMANDS)
+		intf->command_waiters--;
+
+	flags = 0;
+	if (intf->response_waiters)
+		flags |= IPMI_WATCH_MASK_CHECK_MESSAGES;
+	if (intf->watchdog_waiters)
+		flags |= IPMI_WATCH_MASK_CHECK_WATCHDOG;
+	if (intf->command_waiters)
+		flags |= IPMI_WATCH_MASK_CHECK_COMMANDS;
+
+	if (intf->last_watch_mask != flags) {
+		intf->last_watch_mask = flags;
+		intf->handlers->set_need_watch(intf->send_info,
+					       intf->last_watch_mask);
+	}
+	spin_unlock_irqrestore(&intf->watch_lock, iflags);
+}
+
 /*
  * Find the next sequence number not being used and add the given
  * message with the given timeout to the sequence table.  This must be
@@ -988,6 +1051,7 @@ static int intf_next_seq(struct ipmi_smi
 		*seq = i;
 		*seqid = intf->seq_table[i].seqid;
 		intf->curr_seq = (i+1)%IPMI_IPMB_NUM_SEQ;
+		smi_add_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES);
 		need_waiter(intf);
 	} else {
 		rv = -EAGAIN;
@@ -1026,6 +1090,7 @@ static int intf_find_seq(struct ipmi_smi
 				&& (ipmi_addr_equal(addr, &msg->addr))) {
 			*recv_msg = msg;
 			intf->seq_table[seq].inuse = 0;
+			smi_remove_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES);
 			rv = 0;
 		}
 	}
@@ -1087,6 +1152,7 @@ static int intf_err_seq(struct ipmi_smi
 		struct seq_table *ent = &intf->seq_table[seq];
 
 		ent->inuse = 0;
+		smi_remove_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES);
 		msg = ent->recv_msg;
 		rv = 0;
 	}
@@ -1098,30 +1164,6 @@ static int intf_err_seq(struct ipmi_smi
 	return rv;
 }
 
-/* Must be called with xmit_msgs_lock held. */
-static void smi_tell_to_watch(struct ipmi_smi *intf,
-			      unsigned int flags,
-			      struct ipmi_smi_msg *smi_msg)
-{
-	if (flags & IPMI_WATCH_MASK_CHECK_MESSAGES) {
-		if (!smi_msg)
-			return;
-
-		if (!smi_msg->needs_response)
-			return;
-	}
-
-	if (!intf->handlers->set_need_watch)
-		return;
-
-	if ((intf->last_watch_mask & flags) == flags)
-		return;
-
-	intf->last_watch_mask |= flags;
-	intf->handlers->set_need_watch(intf->send_info,
-				       intf->last_watch_mask);
-}
-
 static void free_user_work(struct work_struct *work)
 {
 	struct ipmi_user *user = container_of(work, struct ipmi_user,
@@ -1198,12 +1240,9 @@ int ipmi_create_user(unsigned int
 	spin_lock_irqsave(&intf->seq_lock, flags);
 	list_add_rcu(&new_user->link, &intf->users);
 	spin_unlock_irqrestore(&intf->seq_lock, flags);
-	if (handler->ipmi_watchdog_pretimeout) {
+	if (handler->ipmi_watchdog_pretimeout)
 		/* User wants pretimeouts, so make sure to watch for them. */
-		if (atomic_inc_return(&intf->watchdog_waiters) == 1)
-			smi_tell_to_watch(intf, IPMI_WATCH_MASK_CHECK_WATCHDOG,
-					  NULL);
-	}
+		smi_add_watch(intf, IPMI_WATCH_MASK_CHECK_WATCHDOG);
 	srcu_read_unlock(&ipmi_interfaces_srcu, index);
 	*user = new_user;
 	return 0;
@@ -1276,7 +1315,7 @@ static void _ipmi_destroy_user(struct ip
 		user->handler->shutdown(user->handler_data);
 
 	if (user->handler->ipmi_watchdog_pretimeout)
-		atomic_dec(&intf->watchdog_waiters);
+		smi_remove_watch(intf, IPMI_WATCH_MASK_CHECK_WATCHDOG);
 
 	if (user->gets_events)
 		atomic_dec(&intf->event_waiters);
@@ -1289,6 +1328,7 @@ static void _ipmi_destroy_user(struct ip
 		if (intf->seq_table[i].inuse
 		    && (intf->seq_table[i].recv_msg->user == user)) {
 			intf->seq_table[i].inuse = 0;
+			smi_remove_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES);
 			ipmi_free_recv_msg(intf->seq_table[i].recv_msg);
 		}
 	}
@@ -1634,8 +1674,7 @@ int ipmi_register_for_cmd(struct ipmi_us
 		goto out_unlock;
 	}
 
-	if (atomic_inc_return(&intf->command_waiters) == 1)
-		smi_tell_to_watch(intf, IPMI_WATCH_MASK_CHECK_COMMANDS, NULL);
+	smi_add_watch(intf, IPMI_WATCH_MASK_CHECK_COMMANDS);
 
 	list_add_rcu(&rcvr->link, &intf->cmd_rcvrs);
 
@@ -1685,7 +1724,7 @@ int ipmi_unregister_for_cmd(struct ipmi_
 	synchronize_rcu();
 	release_ipmi_user(user, index);
 	while (rcvrs) {
-		atomic_dec(&intf->command_waiters);
+		smi_remove_watch(intf, IPMI_WATCH_MASK_CHECK_COMMANDS);
 		rcvr = rcvrs;
 		rcvrs = rcvr->next;
 		kfree(rcvr);
@@ -1813,8 +1852,6 @@ static void smi_send(struct ipmi_smi *in
 		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
 	smi_msg = smi_add_send_msg(intf, smi_msg, priority);
 
-	smi_tell_to_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES, smi_msg);
-
 	if (!run_to_completion)
 		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
 
@@ -2014,9 +2051,6 @@ static int i_ipmi_req_ipmb(struct ipmi_s
 				ipmb_seq, broadcast,
 				source_address, source_lun);
 
-		/* We will be getting a response in the BMC message queue. */
-		smi_msg->needs_response = true;
-
 		/*
 		 * Copy the message into the recv message data, so we
 		 * can retransmit it later if necessary.
@@ -2204,7 +2238,6 @@ static int i_ipmi_request(struct ipmi_us
 			goto out;
 		}
 	}
-	smi_msg->needs_response = false;
 
 	rcu_read_lock();
 	if (intf->in_shutdown) {
@@ -3425,9 +3458,8 @@ int ipmi_add_smi(struct module         *
 	INIT_LIST_HEAD(&intf->xmit_msgs);
 	INIT_LIST_HEAD(&intf->hp_xmit_msgs);
 	spin_lock_init(&intf->events_lock);
+	spin_lock_init(&intf->watch_lock);
 	atomic_set(&intf->event_waiters, 0);
-	atomic_set(&intf->watchdog_waiters, 0);
-	atomic_set(&intf->command_waiters, 0);
 	intf->ticks_to_req_ev = IPMI_REQUEST_EV_TIME;
 	INIT_LIST_HEAD(&intf->waiting_events);
 	intf->waiting_events_count = 0;
@@ -4447,8 +4479,6 @@ static void smi_recv_tasklet(unsigned lo
 		}
 	}
 
-	smi_tell_to_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES, newmsg);
-
 	if (!run_to_completion)
 		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
 	if (newmsg)
@@ -4576,7 +4606,7 @@ static void check_msg_timeout(struct ipm
 			      struct list_head *timeouts,
 			      unsigned long timeout_period,
 			      int slot, unsigned long *flags,
-			      unsigned int *watch_mask)
+			      bool *need_timer)
 {
 	struct ipmi_recv_msg *msg;
 
@@ -4588,13 +4618,14 @@ static void check_msg_timeout(struct ipm
 
 	if (timeout_period < ent->timeout) {
 		ent->timeout -= timeout_period;
-		*watch_mask |= IPMI_WATCH_MASK_CHECK_MESSAGES;
+		*need_timer = true;
 		return;
 	}
 
 	if (ent->retries_left == 0) {
 		/* The message has used all its retries. */
 		ent->inuse = 0;
+		smi_remove_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES);
 		msg = ent->recv_msg;
 		list_add_tail(&msg->link, timeouts);
 		if (ent->broadcast)
@@ -4607,7 +4638,7 @@ static void check_msg_timeout(struct ipm
 		struct ipmi_smi_msg *smi_msg;
 		/* More retries, send again. */
 
-		*watch_mask |= IPMI_WATCH_MASK_CHECK_MESSAGES;
+		*need_timer = true;
 
 		/*
 		 * Start with the max timer, set to normal timer after
@@ -4652,20 +4683,20 @@ static void check_msg_timeout(struct ipm
 	}
 }
 
-static unsigned int ipmi_timeout_handler(struct ipmi_smi *intf,
-					 unsigned long timeout_period)
+static bool ipmi_timeout_handler(struct ipmi_smi *intf,
+				 unsigned long timeout_period)
 {
 	struct list_head     timeouts;
 	struct ipmi_recv_msg *msg, *msg2;
 	unsigned long        flags;
 	int                  i;
-	unsigned int         watch_mask = 0;
+	bool                 need_timer = false;
 
 	if (!intf->bmc_registered) {
 		kref_get(&intf->refcount);
 		if (!schedule_work(&intf->bmc_reg_work)) {
 			kref_put(&intf->refcount, intf_free);
-			watch_mask |= IPMI_WATCH_MASK_INTERNAL;
+			need_timer = true;
 		}
 	}
 
@@ -4685,7 +4716,7 @@ static unsigned int ipmi_timeout_handler
 	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++)
 		check_msg_timeout(intf, &intf->seq_table[i],
 				  &timeouts, timeout_period, i,
-				  &flags, &watch_mask);
+				  &flags, &need_timer);
 	spin_unlock_irqrestore(&intf->seq_lock, flags);
 
 	list_for_each_entry_safe(msg, msg2, &timeouts, link)
@@ -4716,7 +4747,7 @@ static unsigned int ipmi_timeout_handler
 
 	tasklet_schedule(&intf->recv_tasklet);
 
-	return watch_mask;
+	return need_timer;
 }
 
 static void ipmi_request_event(struct ipmi_smi *intf)
@@ -4736,9 +4767,8 @@ static atomic_t stop_operation;
 static void ipmi_timeout(struct timer_list *unused)
 {
 	struct ipmi_smi *intf;
-	unsigned int watch_mask = 0;
+	bool need_timer = false;
 	int index;
-	unsigned long flags;
 
 	if (atomic_read(&stop_operation))
 		return;
@@ -4751,28 +4781,14 @@ static void ipmi_timeout(struct timer_li
 				ipmi_request_event(intf);
 				intf->ticks_to_req_ev = IPMI_REQUEST_EV_TIME;
 			}
-			watch_mask |= IPMI_WATCH_MASK_INTERNAL;
+			need_timer = true;
 		}
 
-		if (atomic_read(&intf->watchdog_waiters))
-			watch_mask |= IPMI_WATCH_MASK_CHECK_WATCHDOG;
-
-		if (atomic_read(&intf->command_waiters))
-			watch_mask |= IPMI_WATCH_MASK_CHECK_COMMANDS;
-
-		watch_mask |= ipmi_timeout_handler(intf, IPMI_TIMEOUT_TIME);
-
-		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
-		if (watch_mask != intf->last_watch_mask &&
-					intf->handlers->set_need_watch)
-			intf->handlers->set_need_watch(intf->send_info,
-						       watch_mask);
-		intf->last_watch_mask = watch_mask;
-		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
+		need_timer |= ipmi_timeout_handler(intf, IPMI_TIMEOUT_TIME);
 	}
 	srcu_read_unlock(&ipmi_interfaces_srcu, index);
 
-	if (watch_mask)
+	if (need_timer)
 		mod_timer(&ipmi_timer, jiffies + IPMI_TIMEOUT_JIFFIES);
 }
 
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1079,7 +1079,7 @@ static void set_need_watch(void *send_in
 	unsigned long flags;
 	int enable;
 
-	enable = !!(watch_mask & ~IPMI_WATCH_MASK_INTERNAL);
+	enable = !!watch_mask;
 
 	atomic_set(&smi_info->need_watch, enable);
 	spin_lock_irqsave(&smi_info->si_lock, flags);
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1159,7 +1159,7 @@ static void ssif_set_need_watch(void *se
 
 	if (watch_mask & IPMI_WATCH_MASK_CHECK_MESSAGES)
 		timeout = SSIF_WATCH_MSG_TIMEOUT;
-	else if (watch_mask & ~IPMI_WATCH_MASK_INTERNAL)
+	else if (watch_mask)
 		timeout = SSIF_WATCH_WATCHDOG_TIMEOUT;
 
 	flags = ipmi_ssif_lock_cond(ssif_info, &oflags);
--- a/include/linux/ipmi_smi.h
+++ b/include/linux/ipmi_smi.h
@@ -32,14 +32,11 @@ typedef struct ipmi_smi *ipmi_smi_t;
 
 /*
  * Flags for set_check_watch() below.  Tells if the SMI should be
- * waiting for watchdog timeouts, commands and/or messages.  There is
- * also an internal flag for the message handler, SMIs should ignore
- * it.
+ * waiting for watchdog timeouts, commands and/or messages.
  */
-#define IPMI_WATCH_MASK_INTERNAL	(1 << 0)
-#define IPMI_WATCH_MASK_CHECK_MESSAGES	(1 << 1)
-#define IPMI_WATCH_MASK_CHECK_WATCHDOG	(1 << 2)
-#define IPMI_WATCH_MASK_CHECK_COMMANDS	(1 << 3)
+#define IPMI_WATCH_MASK_CHECK_MESSAGES	(1 << 0)
+#define IPMI_WATCH_MASK_CHECK_WATCHDOG	(1 << 1)
+#define IPMI_WATCH_MASK_CHECK_COMMANDS	(1 << 2)
 
 /*
  * Messages to/from the lower layer.  The smi interface will take one
@@ -67,12 +64,6 @@ struct ipmi_smi_msg {
 	unsigned char rsp[IPMI_MAX_MSG_LENGTH];
 
 	/*
-	 * There should be a response message coming back in the BMC
-	 * message queue.
-	 */
-	bool needs_response;
-
-	/*
 	 * Will be called when the system is done with the message
 	 * (presumably to free it).
 	 */


