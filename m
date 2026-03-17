Return-Path: <stable+bounces-225833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFSuNKI9uWkowQEAu9opvQ
	(envelope-from <stable+bounces-225833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:40:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC6C2A9103
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBCF93032AA1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193C83AE6F6;
	Tue, 17 Mar 2026 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IrqiLU1J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12F43AB280
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747266; cv=none; b=L5mQx+hHZY479alx/GGnHH4dihedvHqPQotX+mQFfYxrmTKkw2lsZl6pPxPlf121lTdXLX51G8Ks3wn2I59APzNjP6ZuHB1/QljjAEn+HzycakT0QzJKEm7BkKazMgZat8vafgyc60MMHqr7k6eA9l9nurr2lAMfXPf/y1MMrH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747266; c=relaxed/simple;
	bh=RRn4gqJ4+C/wiiSvAtMtuJY73BMpIn/CEAuR0wgi8bg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bFsMQ70IEcJAteXu3b4HNzOGf3T5LgFhK7xT+QdekwwPb74gryWG81CuVqOE1/oJcw9mKhGm7ws2JfjEQ7XQDxHwxi6eapaFS24envU3iMCKaiS0NacyLnBqYGjoO2JiENhSgRfChQqPfsZLGDQseEogJQtqpCmvSRd1X/7+zR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IrqiLU1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A1AC4CEF7;
	Tue, 17 Mar 2026 11:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773747266;
	bh=RRn4gqJ4+C/wiiSvAtMtuJY73BMpIn/CEAuR0wgi8bg=;
	h=Subject:To:Cc:From:Date:From;
	b=IrqiLU1JO4gCOS3TobcJuH16msG1mfOv9aUos46Yp9TV5fZBBlQVbcaSOWdkyJJWw
	 iTWqxVm67j6JLT+e3da7k5wcsKGJc43Mc6OwwzAnIvDMRfwPJlJ+xndGo7BF6J/Qem
	 hSiWqF5WhNjN1UeT1U7THjAGROfJsu8U7Devj1qQ=
Subject: FAILED: patch "[PATCH] ipmi:msghandler: Handle error returns from the SMI sender" failed to apply to 6.18-stable tree
To: corey@minyard.net,rafael@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 12:34:14 +0100
Message-ID: <2026031714-symptom-calculate-bec2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225833-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gregkh:email,minyard.net:email]
X-Rspamd-Queue-Id: DDC6C2A9103
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 62cd145453d577113f993efd025f258dd86aa183
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031714-symptom-calculate-bec2@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 62cd145453d577113f993efd025f258dd86aa183 Mon Sep 17 00:00:00 2001
From: Corey Minyard <corey@minyard.net>
Date: Thu, 12 Feb 2026 21:56:54 -0600
Subject: [PATCH] ipmi:msghandler: Handle error returns from the SMI sender

It used to be, until recently, that the sender operation on the low
level interfaces would not fail.  That's not the case any more with
recent changes.

So check the return value from the sender operation, and propagate it
back up from there and handle the errors in all places.

Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Fixes: bc3a9d217755 ("ipmi:si: Gracefully handle if the BMC is non-functional")
Cc: stable@vger.kernel.org # 4.18
Signed-off-by: Corey Minyard <corey@minyard.net>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index a042b1596933..f8c3c1e44520 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -1887,19 +1887,32 @@ static struct ipmi_smi_msg *smi_add_send_msg(struct ipmi_smi *intf,
 	return smi_msg;
 }
 
-static void smi_send(struct ipmi_smi *intf,
+static int smi_send(struct ipmi_smi *intf,
 		     const struct ipmi_smi_handlers *handlers,
 		     struct ipmi_smi_msg *smi_msg, int priority)
 {
 	int run_to_completion = READ_ONCE(intf->run_to_completion);
 	unsigned long flags = 0;
+	int rv = 0;
 
 	ipmi_lock_xmit_msgs(intf, run_to_completion, &flags);
 	smi_msg = smi_add_send_msg(intf, smi_msg, priority);
 	ipmi_unlock_xmit_msgs(intf, run_to_completion, &flags);
 
-	if (smi_msg)
-		handlers->sender(intf->send_info, smi_msg);
+	if (smi_msg) {
+		rv = handlers->sender(intf->send_info, smi_msg);
+		if (rv) {
+			ipmi_lock_xmit_msgs(intf, run_to_completion, &flags);
+			intf->curr_msg = NULL;
+			ipmi_unlock_xmit_msgs(intf, run_to_completion, &flags);
+			/*
+			 * Something may have been added to the transmit
+			 * queue, so schedule a check for that.
+			 */
+			queue_work(system_wq, &intf->smi_work);
+		}
+	}
+	return rv;
 }
 
 static bool is_maintenance_mode_cmd(struct kernel_ipmi_msg *msg)
@@ -2312,6 +2325,7 @@ static int i_ipmi_request(struct ipmi_user     *user,
 	struct ipmi_recv_msg *recv_msg;
 	int run_to_completion = READ_ONCE(intf->run_to_completion);
 	int rv = 0;
+	bool in_seq_table = false;
 
 	if (supplied_recv) {
 		recv_msg = supplied_recv;
@@ -2365,33 +2379,50 @@ static int i_ipmi_request(struct ipmi_user     *user,
 		rv = i_ipmi_req_ipmb(intf, addr, msgid, msg, smi_msg, recv_msg,
 				     source_address, source_lun,
 				     retries, retry_time_ms);
+		in_seq_table = true;
 	} else if (is_ipmb_direct_addr(addr)) {
 		rv = i_ipmi_req_ipmb_direct(intf, addr, msgid, msg, smi_msg,
 					    recv_msg, source_lun);
 	} else if (is_lan_addr(addr)) {
 		rv = i_ipmi_req_lan(intf, addr, msgid, msg, smi_msg, recv_msg,
 				    source_lun, retries, retry_time_ms);
+		in_seq_table = true;
 	} else {
-	    /* Unknown address type. */
+		/* Unknown address type. */
 		ipmi_inc_stat(intf, sent_invalid_commands);
 		rv = -EINVAL;
 	}
 
-	if (rv) {
+	if (!rv) {
+		dev_dbg(intf->si_dev, "Send: %*ph\n",
+			smi_msg->data_size, smi_msg->data);
+
+		rv = smi_send(intf, intf->handlers, smi_msg, priority);
+		if (rv != IPMI_CC_NO_ERROR)
+			/* smi_send() returns an IPMI err, return a Linux one. */
+			rv = -EIO;
+		if (rv && in_seq_table) {
+			/*
+			 * If it's in the sequence table, it will be
+			 * retried later, so ignore errors.
+			 */
+			rv = 0;
+			/* But we need to fix the timeout. */
+			intf_start_seq_timer(intf, smi_msg->msgid);
+			ipmi_free_smi_msg(smi_msg);
+			smi_msg = NULL;
+		}
+	}
 out_err:
+	if (!run_to_completion)
+		mutex_unlock(&intf->users_mutex);
+
+	if (rv) {
 		if (!supplied_smi)
 			ipmi_free_smi_msg(smi_msg);
 		if (!supplied_recv)
 			ipmi_free_recv_msg(recv_msg);
-	} else {
-		dev_dbg(intf->si_dev, "Send: %*ph\n",
-			smi_msg->data_size, smi_msg->data);
-
-		smi_send(intf, intf->handlers, smi_msg, priority);
 	}
-	if (!run_to_completion)
-		mutex_unlock(&intf->users_mutex);
-
 	return rv;
 }
 
@@ -3965,12 +3996,12 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_smi *intf,
 		dev_dbg(intf->si_dev, "Invalid command: %*ph\n",
 			msg->data_size, msg->data);
 
-		smi_send(intf, intf->handlers, msg, 0);
-		/*
-		 * We used the message, so return the value that
-		 * causes it to not be freed or queued.
-		 */
-		rv = -1;
+		if (smi_send(intf, intf->handlers, msg, 0) == IPMI_CC_NO_ERROR)
+			/*
+			 * We used the message, so return the value that
+			 * causes it to not be freed or queued.
+			 */
+			rv = -1;
 	} else if (!IS_ERR(recv_msg)) {
 		/* Extract the source address from the data. */
 		ipmb_addr = (struct ipmi_ipmb_addr *) &recv_msg->addr;
@@ -4044,12 +4075,12 @@ static int handle_ipmb_direct_rcv_cmd(struct ipmi_smi *intf,
 		msg->data[4] = IPMI_INVALID_CMD_COMPLETION_CODE;
 		msg->data_size = 5;
 
-		smi_send(intf, intf->handlers, msg, 0);
-		/*
-		 * We used the message, so return the value that
-		 * causes it to not be freed or queued.
-		 */
-		rv = -1;
+		if (smi_send(intf, intf->handlers, msg, 0) == IPMI_CC_NO_ERROR)
+			/*
+			 * We used the message, so return the value that
+			 * causes it to not be freed or queued.
+			 */
+			rv = -1;
 	} else if (!IS_ERR(recv_msg)) {
 		/* Extract the source address from the data. */
 		daddr = (struct ipmi_ipmb_direct_addr *)&recv_msg->addr;
@@ -4189,7 +4220,7 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
 				  struct ipmi_smi_msg *msg)
 {
 	struct cmd_rcvr          *rcvr;
-	int                      rv = 0;
+	int                      rv = 0; /* Free by default */
 	unsigned char            netfn;
 	unsigned char            cmd;
 	unsigned char            chan;
@@ -4242,12 +4273,12 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
 		dev_dbg(intf->si_dev, "Invalid command: %*ph\n",
 			msg->data_size, msg->data);
 
-		smi_send(intf, intf->handlers, msg, 0);
-		/*
-		 * We used the message, so return the value that
-		 * causes it to not be freed or queued.
-		 */
-		rv = -1;
+		if (smi_send(intf, intf->handlers, msg, 0) == IPMI_CC_NO_ERROR)
+			/*
+			 * We used the message, so return the value that
+			 * causes it to not be freed or queued.
+			 */
+			rv = -1;
 	} else if (!IS_ERR(recv_msg)) {
 		/* Extract the source address from the data. */
 		lan_addr = (struct ipmi_lan_addr *) &recv_msg->addr;
@@ -5056,7 +5087,12 @@ static void check_msg_timeout(struct ipmi_smi *intf, struct seq_table *ent,
 				ipmi_inc_stat(intf,
 					      retransmitted_ipmb_commands);
 
-			smi_send(intf, intf->handlers, smi_msg, 0);
+			/* If this fails we'll retry later or timeout. */
+			if (smi_send(intf, intf->handlers, smi_msg, 0) != IPMI_CC_NO_ERROR) {
+				/* But fix the timeout. */
+				intf_start_seq_timer(intf, smi_msg->msgid);
+				ipmi_free_smi_msg(smi_msg);
+			}
 		} else
 			ipmi_free_smi_msg(smi_msg);
 


