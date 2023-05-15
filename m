Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F19070341F
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242921AbjEOQpG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242917AbjEOQpE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB23E4C3D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43CCF628E1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEC3C433EF;
        Mon, 15 May 2023 16:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169101;
        bh=Q7yCNEvgtNcBFUTF4jwhznexh1azwXCyNMKGiag13IM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qeHolWUHmvpCNykN/hAJ6npEFovml2q80pBKgPKpLCvjhFEU4G+YnFwvkyoYZAJE4
         oeCIoXrbITJcXcV6Y+J/1ryzUD+oqExjmf7yRjs9axrWOk83yGRR7cxLq+Xn83sbKd
         R5QJmFc6DPmkRl8nUUjQ3NZmIRVF6TGM+YSRtxJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Corey Minyard <cminyard@mvista.com>,
        Kamlakant Patel <kamlakant.patel@cavium.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 142/191] ipmi: Fix how the lower layers are told to watch for messages
Date:   Mon, 15 May 2023 18:26:19 +0200
Message-Id: <20230515161712.554997125@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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

From: Corey Minyard <cminyard@mvista.com>

[ Upstream commit c65ea996595005be470fbfa16711deba414fd33b ]

The IPMI driver has a mechanism to tell the lower layers it needs
to watch for messages, commands, and watchdogs (so it doesn't
needlessly poll).  However, it needed some extensions, it needed
a way to tell what is being waited for so it could set the timeout
appropriately.

The update to the lower layer was also being done once a second
at best because it was done in the main timeout handler.  However,
if a command is sent and a response message is coming back,
it needed to be started immediately.  So modify the code to
update immediately if it needs to be enabled.  Disable is still
lazy.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Kamlakant Patel <kamlakant.patel@cavium.com>
Stable-dep-of: 6d2555cde291 ("ipmi: fix SSIF not responding under certain cond.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_msghandler.c | 119 ++++++++++++++++++++--------
 drivers/char/ipmi/ipmi_si_intf.c    |   5 +-
 drivers/char/ipmi/ipmi_ssif.c       |  26 +++---
 include/linux/ipmi_smi.h            |  36 +++++++--
 4 files changed, 134 insertions(+), 52 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 4265e8d3e71c5..31cfa47d24984 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -536,9 +536,22 @@ struct ipmi_smi {
 	unsigned int     waiting_events_count; /* How many events in queue? */
 	char             delivering_events;
 	char             event_msg_printed;
+
+	/* How many users are waiting for events? */
 	atomic_t         event_waiters;
 	unsigned int     ticks_to_req_ev;
-	int              last_needs_timer;
+
+	/* How many users are waiting for commands? */
+	atomic_t         command_waiters;
+
+	/* How many users are waiting for watchdogs? */
+	atomic_t         watchdog_waiters;
+
+	/*
+	 * Tells what the lower layer has last been asked to watch for,
+	 * messages and/or watchdogs.  Protected by xmit_msgs_lock.
+	 */
+	unsigned int     last_watch_mask;
 
 	/*
 	 * The event receiver for my BMC, only really used at panic
@@ -1085,6 +1098,29 @@ static int intf_err_seq(struct ipmi_smi *intf,
 	return rv;
 }
 
+/* Must be called with xmit_msgs_lock held. */
+static void smi_tell_to_watch(struct ipmi_smi *intf,
+			      unsigned int flags,
+			      struct ipmi_smi_msg *smi_msg)
+{
+	if (flags & IPMI_WATCH_MASK_CHECK_MESSAGES) {
+		if (!smi_msg)
+			return;
+
+		if (!smi_msg->needs_response)
+			return;
+	}
+
+	if (!intf->handlers->set_need_watch)
+		return;
+
+	if ((intf->last_watch_mask & flags) == flags)
+		return;
+
+	intf->last_watch_mask |= flags;
+	intf->handlers->set_need_watch(intf->send_info,
+				       intf->last_watch_mask);
+}
 
 static void free_user_work(struct work_struct *work)
 {
@@ -1164,8 +1200,9 @@ int ipmi_create_user(unsigned int          if_num,
 	spin_unlock_irqrestore(&intf->seq_lock, flags);
 	if (handler->ipmi_watchdog_pretimeout) {
 		/* User wants pretimeouts, so make sure to watch for them. */
-		if (atomic_inc_return(&intf->event_waiters) == 1)
-			need_waiter(intf);
+		if (atomic_inc_return(&intf->watchdog_waiters) == 1)
+			smi_tell_to_watch(intf, IPMI_WATCH_MASK_CHECK_WATCHDOG,
+					  NULL);
 	}
 	srcu_read_unlock(&ipmi_interfaces_srcu, index);
 	*user = new_user;
@@ -1239,7 +1276,7 @@ static void _ipmi_destroy_user(struct ipmi_user *user)
 		user->handler->shutdown(user->handler_data);
 
 	if (user->handler->ipmi_watchdog_pretimeout)
-		atomic_dec(&intf->event_waiters);
+		atomic_dec(&intf->watchdog_waiters);
 
 	if (user->gets_events)
 		atomic_dec(&intf->event_waiters);
@@ -1597,8 +1634,8 @@ int ipmi_register_for_cmd(struct ipmi_user *user,
 		goto out_unlock;
 	}
 
-	if (atomic_inc_return(&intf->event_waiters) == 1)
-		need_waiter(intf);
+	if (atomic_inc_return(&intf->command_waiters) == 1)
+		smi_tell_to_watch(intf, IPMI_WATCH_MASK_CHECK_COMMANDS, NULL);
 
 	list_add_rcu(&rcvr->link, &intf->cmd_rcvrs);
 
@@ -1648,7 +1685,7 @@ int ipmi_unregister_for_cmd(struct ipmi_user *user,
 	synchronize_rcu();
 	release_ipmi_user(user, index);
 	while (rcvrs) {
-		atomic_dec(&intf->event_waiters);
+		atomic_dec(&intf->command_waiters);
 		rcvr = rcvrs;
 		rcvrs = rcvr->next;
 		kfree(rcvr);
@@ -1765,22 +1802,21 @@ static struct ipmi_smi_msg *smi_add_send_msg(struct ipmi_smi *intf,
 	return smi_msg;
 }
 
-
 static void smi_send(struct ipmi_smi *intf,
 		     const struct ipmi_smi_handlers *handlers,
 		     struct ipmi_smi_msg *smi_msg, int priority)
 {
 	int run_to_completion = intf->run_to_completion;
+	unsigned long flags = 0;
 
-	if (run_to_completion) {
-		smi_msg = smi_add_send_msg(intf, smi_msg, priority);
-	} else {
-		unsigned long flags;
-
+	if (!run_to_completion)
 		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
-		smi_msg = smi_add_send_msg(intf, smi_msg, priority);
+	smi_msg = smi_add_send_msg(intf, smi_msg, priority);
+
+	smi_tell_to_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES, smi_msg);
+
+	if (!run_to_completion)
 		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
-	}
 
 	if (smi_msg)
 		handlers->sender(intf->send_info, smi_msg);
@@ -1978,6 +2014,9 @@ static int i_ipmi_req_ipmb(struct ipmi_smi        *intf,
 				ipmb_seq, broadcast,
 				source_address, source_lun);
 
+		/* We will be getting a response in the BMC message queue. */
+		smi_msg->needs_response = true;
+
 		/*
 		 * Copy the message into the recv message data, so we
 		 * can retransmit it later if necessary.
@@ -2165,6 +2204,7 @@ static int i_ipmi_request(struct ipmi_user     *user,
 			goto out;
 		}
 	}
+	smi_msg->needs_response = false;
 
 	rcu_read_lock();
 	if (intf->in_shutdown) {
@@ -3386,6 +3426,8 @@ int ipmi_add_smi(struct module         *owner,
 	INIT_LIST_HEAD(&intf->hp_xmit_msgs);
 	spin_lock_init(&intf->events_lock);
 	atomic_set(&intf->event_waiters, 0);
+	atomic_set(&intf->watchdog_waiters, 0);
+	atomic_set(&intf->command_waiters, 0);
 	intf->ticks_to_req_ev = IPMI_REQUEST_EV_TIME;
 	INIT_LIST_HEAD(&intf->waiting_events);
 	intf->waiting_events_count = 0;
@@ -4404,6 +4446,9 @@ static void smi_recv_tasklet(unsigned long val)
 			intf->curr_msg = newmsg;
 		}
 	}
+
+	smi_tell_to_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES, newmsg);
+
 	if (!run_to_completion)
 		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
 	if (newmsg)
@@ -4531,7 +4576,7 @@ static void check_msg_timeout(struct ipmi_smi *intf, struct seq_table *ent,
 			      struct list_head *timeouts,
 			      unsigned long timeout_period,
 			      int slot, unsigned long *flags,
-			      unsigned int *waiting_msgs)
+			      unsigned int *watch_mask)
 {
 	struct ipmi_recv_msg *msg;
 
@@ -4543,7 +4588,7 @@ static void check_msg_timeout(struct ipmi_smi *intf, struct seq_table *ent,
 
 	if (timeout_period < ent->timeout) {
 		ent->timeout -= timeout_period;
-		(*waiting_msgs)++;
+		*watch_mask |= IPMI_WATCH_MASK_CHECK_MESSAGES;
 		return;
 	}
 
@@ -4562,7 +4607,7 @@ static void check_msg_timeout(struct ipmi_smi *intf, struct seq_table *ent,
 		struct ipmi_smi_msg *smi_msg;
 		/* More retries, send again. */
 
-		(*waiting_msgs)++;
+		*watch_mask |= IPMI_WATCH_MASK_CHECK_MESSAGES;
 
 		/*
 		 * Start with the max timer, set to normal timer after
@@ -4614,13 +4659,13 @@ static unsigned int ipmi_timeout_handler(struct ipmi_smi *intf,
 	struct ipmi_recv_msg *msg, *msg2;
 	unsigned long        flags;
 	int                  i;
-	unsigned int         waiting_msgs = 0;
+	unsigned int         watch_mask = 0;
 
 	if (!intf->bmc_registered) {
 		kref_get(&intf->refcount);
 		if (!schedule_work(&intf->bmc_reg_work)) {
 			kref_put(&intf->refcount, intf_free);
-			waiting_msgs++;
+			watch_mask |= IPMI_WATCH_MASK_INTERNAL;
 		}
 	}
 
@@ -4640,7 +4685,7 @@ static unsigned int ipmi_timeout_handler(struct ipmi_smi *intf,
 	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++)
 		check_msg_timeout(intf, &intf->seq_table[i],
 				  &timeouts, timeout_period, i,
-				  &flags, &waiting_msgs);
+				  &flags, &watch_mask);
 	spin_unlock_irqrestore(&intf->seq_lock, flags);
 
 	list_for_each_entry_safe(msg, msg2, &timeouts, link)
@@ -4671,7 +4716,7 @@ static unsigned int ipmi_timeout_handler(struct ipmi_smi *intf,
 
 	tasklet_schedule(&intf->recv_tasklet);
 
-	return waiting_msgs;
+	return watch_mask;
 }
 
 static void ipmi_request_event(struct ipmi_smi *intf)
@@ -4691,37 +4736,43 @@ static atomic_t stop_operation;
 static void ipmi_timeout(struct timer_list *unused)
 {
 	struct ipmi_smi *intf;
-	int nt = 0, index;
+	unsigned int watch_mask = 0;
+	int index;
+	unsigned long flags;
 
 	if (atomic_read(&stop_operation))
 		return;
 
 	index = srcu_read_lock(&ipmi_interfaces_srcu);
 	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
-		int lnt = 0;
-
 		if (atomic_read(&intf->event_waiters)) {
 			intf->ticks_to_req_ev--;
 			if (intf->ticks_to_req_ev == 0) {
 				ipmi_request_event(intf);
 				intf->ticks_to_req_ev = IPMI_REQUEST_EV_TIME;
 			}
-			lnt++;
+			watch_mask |= IPMI_WATCH_MASK_INTERNAL;
 		}
 
-		lnt += ipmi_timeout_handler(intf, IPMI_TIMEOUT_TIME);
+		if (atomic_read(&intf->watchdog_waiters))
+			watch_mask |= IPMI_WATCH_MASK_CHECK_WATCHDOG;
 
-		lnt = !!lnt;
-		if (lnt != intf->last_needs_timer &&
-					intf->handlers->set_need_watch)
-			intf->handlers->set_need_watch(intf->send_info, lnt);
-		intf->last_needs_timer = lnt;
+		if (atomic_read(&intf->command_waiters))
+			watch_mask |= IPMI_WATCH_MASK_CHECK_COMMANDS;
+
+		watch_mask |= ipmi_timeout_handler(intf, IPMI_TIMEOUT_TIME);
 
-		nt += lnt;
+		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
+		if (watch_mask != intf->last_watch_mask &&
+					intf->handlers->set_need_watch)
+			intf->handlers->set_need_watch(intf->send_info,
+						       watch_mask);
+		intf->last_watch_mask = watch_mask;
+		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
 	}
 	srcu_read_unlock(&ipmi_interfaces_srcu, index);
 
-	if (nt)
+	if (watch_mask)
 		mod_timer(&ipmi_timer, jiffies + IPMI_TIMEOUT_JIFFIES);
 }
 
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index a5e1dce042e8e..429fe063e33ff 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1073,10 +1073,13 @@ static void request_events(void *send_info)
 	atomic_set(&smi_info->req_events, 1);
 }
 
-static void set_need_watch(void *send_info, bool enable)
+static void set_need_watch(void *send_info, unsigned int watch_mask)
 {
 	struct smi_info *smi_info = send_info;
 	unsigned long flags;
+	int enable;
+
+	enable = !!(watch_mask & ~IPMI_WATCH_MASK_INTERNAL);
 
 	atomic_set(&smi_info->need_watch, enable);
 	spin_lock_irqsave(&smi_info->si_lock, flags);
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 469da2290c2a0..e760501e50b20 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -91,8 +91,8 @@
 /*
  * Timeout for the watch, only used for get flag timer.
  */
-#define SSIF_WATCH_TIMEOUT_MSEC	   100
-#define SSIF_WATCH_TIMEOUT_JIFFIES msecs_to_jiffies(SSIF_WATCH_TIMEOUT_MSEC)
+#define SSIF_WATCH_MSG_TIMEOUT		msecs_to_jiffies(10)
+#define SSIF_WATCH_WATCHDOG_TIMEOUT	msecs_to_jiffies(250)
 
 enum ssif_intf_state {
 	SSIF_NORMAL,
@@ -274,7 +274,7 @@ struct ssif_info {
 	struct timer_list retry_timer;
 	int retries_left;
 
-	bool need_watch;		/* Need to look for flags? */
+	long watch_timeout;		/* Timeout for flags check, 0 if off. */
 	struct timer_list watch_timer;	/* Flag fetch timer. */
 
 	/* Info from SSIF cmd */
@@ -576,9 +576,9 @@ static void watch_timeout(struct timer_list *t)
 		return;
 
 	flags = ipmi_ssif_lock_cond(ssif_info, &oflags);
-	if (ssif_info->need_watch) {
+	if (ssif_info->watch_timeout) {
 		mod_timer(&ssif_info->watch_timer,
-			  jiffies + SSIF_WATCH_TIMEOUT_JIFFIES);
+			  jiffies + ssif_info->watch_timeout);
 		if (SSIF_IDLE(ssif_info)) {
 			start_flag_fetch(ssif_info, flags); /* Releases lock */
 			return;
@@ -1151,17 +1151,23 @@ static void request_events(void *send_info)
  * Upper layer is changing the flag saying whether we need to request
  * flags periodically or not.
  */
-static void ssif_set_need_watch(void *send_info, bool enable)
+static void ssif_set_need_watch(void *send_info, unsigned int watch_mask)
 {
 	struct ssif_info *ssif_info = (struct ssif_info *) send_info;
 	unsigned long oflags, *flags;
+	long timeout = 0;
+
+	if (watch_mask & IPMI_WATCH_MASK_CHECK_MESSAGES)
+		timeout = SSIF_WATCH_MSG_TIMEOUT;
+	else if (watch_mask & ~IPMI_WATCH_MASK_INTERNAL)
+		timeout = SSIF_WATCH_WATCHDOG_TIMEOUT;
 
 	flags = ipmi_ssif_lock_cond(ssif_info, &oflags);
-	if (enable != ssif_info->need_watch) {
-		ssif_info->need_watch = enable;
-		if (ssif_info->need_watch)
+	if (timeout != ssif_info->watch_timeout) {
+		ssif_info->watch_timeout = timeout;
+		if (ssif_info->watch_timeout)
 			mod_timer(&ssif_info->watch_timer,
-				  jiffies + SSIF_WATCH_TIMEOUT_JIFFIES);
+				  jiffies + ssif_info->watch_timeout);
 	}
 	ipmi_ssif_unlock_cond(ssif_info, flags);
 }
diff --git a/include/linux/ipmi_smi.h b/include/linux/ipmi_smi.h
index 1995ce1467890..86b119400f301 100644
--- a/include/linux/ipmi_smi.h
+++ b/include/linux/ipmi_smi.h
@@ -30,6 +30,17 @@ struct device;
 /* Structure for the low-level drivers. */
 typedef struct ipmi_smi *ipmi_smi_t;
 
+/*
+ * Flags for set_check_watch() below.  Tells if the SMI should be
+ * waiting for watchdog timeouts, commands and/or messages.  There is
+ * also an internal flag for the message handler, SMIs should ignore
+ * it.
+ */
+#define IPMI_WATCH_MASK_INTERNAL	(1 << 0)
+#define IPMI_WATCH_MASK_CHECK_MESSAGES	(1 << 1)
+#define IPMI_WATCH_MASK_CHECK_WATCHDOG	(1 << 2)
+#define IPMI_WATCH_MASK_CHECK_COMMANDS	(1 << 3)
+
 /*
  * Messages to/from the lower layer.  The smi interface will take one
  * of these to send. After the send has occurred and a response has
@@ -55,8 +66,16 @@ struct ipmi_smi_msg {
 	int           rsp_size;
 	unsigned char rsp[IPMI_MAX_MSG_LENGTH];
 
-	/* Will be called when the system is done with the message
-	   (presumably to free it). */
+	/*
+	 * There should be a response message coming back in the BMC
+	 * message queue.
+	 */
+	bool needs_response;
+
+	/*
+	 * Will be called when the system is done with the message
+	 * (presumably to free it).
+	 */
 	void (*done)(struct ipmi_smi_msg *msg);
 };
 
@@ -105,12 +124,15 @@ struct ipmi_smi_handlers {
 
 	/*
 	 * Called by the upper layer when some user requires that the
-	 * interface watch for events, received messages, watchdog
-	 * pretimeouts, or not.  Used by the SMI to know if it should
-	 * watch for these.  This may be NULL if the SMI does not
-	 * implement it.
+	 * interface watch for received messages and watchdog
+	 * pretimeouts (basically do a "Get Flags", or not.  Used by
+	 * the SMI to know if it should watch for these.  This may be
+	 * NULL if the SMI does not implement it.  watch_mask is from
+	 * IPMI_WATCH_MASK_xxx above.  The interface should run slower
+	 * timeouts for just watchdog checking or faster timeouts when
+	 * waiting for the message queue.
 	 */
-	void (*set_need_watch)(void *send_info, bool enable);
+	void (*set_need_watch)(void *send_info, unsigned int watch_mask);
 
 	/*
 	 * Called when flushing all pending messages.
-- 
2.39.2



