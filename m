Return-Path: <stable+bounces-187230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606EFBEA386
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A05944479
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485DC32C95D;
	Fri, 17 Oct 2025 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q699dWpd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85B330B1D;
	Fri, 17 Oct 2025 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715488; cv=none; b=okKonhhGg8JhTDAdiDxHfkStIdI1FJpUH7zSD4kIQUBvr0H8Vd6T7CzMaIP9Gl4d5yrk6J6fO0SONIx9cWVuX3xbKQTG4u2UBjvrPvxrfOo3AsA+JJV84Ck4qfX0hGIuwxnYYsVZkRZiA22NHqg36HCMacX15a/AKqgEqf5ilAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715488; c=relaxed/simple;
	bh=DfXz6RG/Mx/MWe8nb+6lH7gxjfzduJowkKTAGwfo7W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYiu2CcxwB1P+XUEKHApS0TIWmbjapTnkJrWmJXaChQFrC8FGh1stCzxoz3tLX0mG7PhTZQtHmHdhqIHk2D1I/xN90fMhY1VTGnXntia1hMN+DthQJFa2e4oEIUMOw7TLobEWZxaZMOUG1JRZ3LMghPOnC01Dv3vfTFoGl98GoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q699dWpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20646C4CEE7;
	Fri, 17 Oct 2025 15:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715484;
	bh=DfXz6RG/Mx/MWe8nb+6lH7gxjfzduJowkKTAGwfo7W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q699dWpdHlksFhyybfhYQWeOfpbyPrAYzzFARwzi3lBCnALUGnCCehm0d4TzHwVy8
	 5nfxnT5fS9r+Az4xgj44QRF55nuj7k86hWkAbAsKn46K/g94qKLZ5Px8tK1reWjkW3
	 GdG5umnRIGLCSqK+xYO/i4YgDslrUWvmEOIJP768=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 6.17 231/371] ipmi:msghandler:Change seq_lock to a mutex
Date: Fri, 17 Oct 2025 16:53:26 +0200
Message-ID: <20251017145210.441472612@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <corey@minyard.net>

commit 8fd8ea2869cfafb3b1d6f95ff49561b13a73438d upstream.

Dan Carpenter got a Smatch warning:

	drivers/char/ipmi/ipmi_msghandler.c:5265 ipmi_free_recv_msg()
	warn: sleeping in atomic context

due to the recent rework of the IPMI driver's locking.  I didn't realize
vfree could block.  But there is an easy solution to this, now that
almost everything in the message handler runs in thread context.

I wanted to spend the time earlier to see if seq_lock could be converted
from a spinlock to a mutex, but I wanted the previous changes to go in
and soak before I did that.  So I went ahead and did the analysis and
converting should work.  And solve this problem.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202503240244.LR7pOwyr-lkp@intel.com/
Fixes: 3be997d5a64a ("ipmi:msghandler: Remove srcu from the ipmi user structure")
Cc: <stable@vger.kernel.org> # 6.16
Signed-off-by: Corey Minyard <corey@minyard.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_msghandler.c |   63 ++++++++++++++----------------------
 1 file changed, 26 insertions(+), 37 deletions(-)

--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -466,7 +466,7 @@ struct ipmi_smi {
 	 * interface to match them up with their responses.  A routine
 	 * is called periodically to time the items in this list.
 	 */
-	spinlock_t       seq_lock;
+	struct mutex seq_lock;
 	struct seq_table seq_table[IPMI_IPMB_NUM_SEQ];
 	int curr_seq;
 
@@ -1117,12 +1117,11 @@ static int intf_find_seq(struct ipmi_smi
 			 struct ipmi_recv_msg **recv_msg)
 {
 	int           rv = -ENODEV;
-	unsigned long flags;
 
 	if (seq >= IPMI_IPMB_NUM_SEQ)
 		return -EINVAL;
 
-	spin_lock_irqsave(&intf->seq_lock, flags);
+	mutex_lock(&intf->seq_lock);
 	if (intf->seq_table[seq].inuse) {
 		struct ipmi_recv_msg *msg = intf->seq_table[seq].recv_msg;
 
@@ -1135,7 +1134,7 @@ static int intf_find_seq(struct ipmi_smi
 			rv = 0;
 		}
 	}
-	spin_unlock_irqrestore(&intf->seq_lock, flags);
+	mutex_unlock(&intf->seq_lock);
 
 	return rv;
 }
@@ -1146,14 +1145,13 @@ static int intf_start_seq_timer(struct i
 				long       msgid)
 {
 	int           rv = -ENODEV;
-	unsigned long flags;
 	unsigned char seq;
 	unsigned long seqid;
 
 
 	GET_SEQ_FROM_MSGID(msgid, seq, seqid);
 
-	spin_lock_irqsave(&intf->seq_lock, flags);
+	mutex_lock(&intf->seq_lock);
 	/*
 	 * We do this verification because the user can be deleted
 	 * while a message is outstanding.
@@ -1164,7 +1162,7 @@ static int intf_start_seq_timer(struct i
 		ent->timeout = ent->orig_timeout;
 		rv = 0;
 	}
-	spin_unlock_irqrestore(&intf->seq_lock, flags);
+	mutex_unlock(&intf->seq_lock);
 
 	return rv;
 }
@@ -1175,7 +1173,6 @@ static int intf_err_seq(struct ipmi_smi
 			unsigned int err)
 {
 	int                  rv = -ENODEV;
-	unsigned long        flags;
 	unsigned char        seq;
 	unsigned long        seqid;
 	struct ipmi_recv_msg *msg = NULL;
@@ -1183,7 +1180,7 @@ static int intf_err_seq(struct ipmi_smi
 
 	GET_SEQ_FROM_MSGID(msgid, seq, seqid);
 
-	spin_lock_irqsave(&intf->seq_lock, flags);
+	mutex_lock(&intf->seq_lock);
 	/*
 	 * We do this verification because the user can be deleted
 	 * while a message is outstanding.
@@ -1197,7 +1194,7 @@ static int intf_err_seq(struct ipmi_smi
 		msg = ent->recv_msg;
 		rv = 0;
 	}
-	spin_unlock_irqrestore(&intf->seq_lock, flags);
+	mutex_unlock(&intf->seq_lock);
 
 	if (msg)
 		deliver_err_response(intf, msg, err);
@@ -1210,7 +1207,6 @@ int ipmi_create_user(unsigned int
 		     void                  *handler_data,
 		     struct ipmi_user      **user)
 {
-	unsigned long flags;
 	struct ipmi_user *new_user = NULL;
 	int           rv = 0;
 	struct ipmi_smi *intf;
@@ -1278,9 +1274,9 @@ int ipmi_create_user(unsigned int
 	new_user->gets_events = false;
 
 	mutex_lock(&intf->users_mutex);
-	spin_lock_irqsave(&intf->seq_lock, flags);
+	mutex_lock(&intf->seq_lock);
 	list_add(&new_user->link, &intf->users);
-	spin_unlock_irqrestore(&intf->seq_lock, flags);
+	mutex_unlock(&intf->seq_lock);
 	mutex_unlock(&intf->users_mutex);
 
 	if (handler->ipmi_watchdog_pretimeout)
@@ -1326,7 +1322,6 @@ static void _ipmi_destroy_user(struct ip
 {
 	struct ipmi_smi  *intf = user->intf;
 	int              i;
-	unsigned long    flags;
 	struct cmd_rcvr  *rcvr;
 	struct cmd_rcvr  *rcvrs = NULL;
 	struct ipmi_recv_msg *msg, *msg2;
@@ -1347,7 +1342,7 @@ static void _ipmi_destroy_user(struct ip
 	list_del(&user->link);
 	atomic_dec(&intf->nr_users);
 
-	spin_lock_irqsave(&intf->seq_lock, flags);
+	mutex_lock(&intf->seq_lock);
 	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++) {
 		if (intf->seq_table[i].inuse
 		    && (intf->seq_table[i].recv_msg->user == user)) {
@@ -1356,7 +1351,7 @@ static void _ipmi_destroy_user(struct ip
 			ipmi_free_recv_msg(intf->seq_table[i].recv_msg);
 		}
 	}
-	spin_unlock_irqrestore(&intf->seq_lock, flags);
+	mutex_unlock(&intf->seq_lock);
 
 	/*
 	 * Remove the user from the command receiver's table.  First
@@ -2026,10 +2021,7 @@ static int i_ipmi_req_ipmb(struct ipmi_s
 		 */
 		smi_msg->user_data = recv_msg;
 	} else {
-		/* It's a command, so get a sequence for it. */
-		unsigned long flags;
-
-		spin_lock_irqsave(&intf->seq_lock, flags);
+		mutex_lock(&intf->seq_lock);
 
 		if (is_maintenance_mode_cmd(msg))
 			intf->ipmb_maintenance_mode_timeout =
@@ -2087,7 +2079,7 @@ static int i_ipmi_req_ipmb(struct ipmi_s
 		 * to be correct.
 		 */
 out_err:
-		spin_unlock_irqrestore(&intf->seq_lock, flags);
+		mutex_unlock(&intf->seq_lock);
 	}
 
 	return rv;
@@ -2205,10 +2197,7 @@ static int i_ipmi_req_lan(struct ipmi_sm
 		 */
 		smi_msg->user_data = recv_msg;
 	} else {
-		/* It's a command, so get a sequence for it. */
-		unsigned long flags;
-
-		spin_lock_irqsave(&intf->seq_lock, flags);
+		mutex_lock(&intf->seq_lock);
 
 		/*
 		 * Create a sequence number with a 1 second
@@ -2257,7 +2246,7 @@ static int i_ipmi_req_lan(struct ipmi_sm
 		 * to be correct.
 		 */
 out_err:
-		spin_unlock_irqrestore(&intf->seq_lock, flags);
+		mutex_unlock(&intf->seq_lock);
 	}
 
 	return rv;
@@ -3562,7 +3551,7 @@ int ipmi_add_smi(struct module         *
 	atomic_set(&intf->nr_users, 0);
 	intf->handlers = handlers;
 	intf->send_info = send_info;
-	spin_lock_init(&intf->seq_lock);
+	mutex_init(&intf->seq_lock);
 	for (j = 0; j < IPMI_IPMB_NUM_SEQ; j++) {
 		intf->seq_table[j].inuse = 0;
 		intf->seq_table[j].seqid = 0;
@@ -4487,9 +4476,10 @@ static int handle_one_recv_msg(struct ip
 
 	if (msg->rsp_size < 2) {
 		/* Message is too small to be correct. */
-		dev_warn(intf->si_dev,
-			 "BMC returned too small a message for netfn %x cmd %x, got %d bytes\n",
-			 (msg->data[0] >> 2) | 1, msg->data[1], msg->rsp_size);
+		dev_warn_ratelimited(intf->si_dev,
+				     "BMC returned too small a message for netfn %x cmd %x, got %d bytes\n",
+				     (msg->data[0] >> 2) | 1,
+				     msg->data[1], msg->rsp_size);
 
 return_unspecified:
 		/* Generate an error response for the message. */
@@ -4907,8 +4897,7 @@ smi_from_recv_msg(struct ipmi_smi *intf,
 static void check_msg_timeout(struct ipmi_smi *intf, struct seq_table *ent,
 			      struct list_head *timeouts,
 			      unsigned long timeout_period,
-			      int slot, unsigned long *flags,
-			      bool *need_timer)
+			      int slot, bool *need_timer)
 {
 	struct ipmi_recv_msg *msg;
 
@@ -4960,7 +4949,7 @@ static void check_msg_timeout(struct ipm
 			return;
 		}
 
-		spin_unlock_irqrestore(&intf->seq_lock, *flags);
+		mutex_unlock(&intf->seq_lock);
 
 		/*
 		 * Send the new message.  We send with a zero
@@ -4981,7 +4970,7 @@ static void check_msg_timeout(struct ipm
 		} else
 			ipmi_free_smi_msg(smi_msg);
 
-		spin_lock_irqsave(&intf->seq_lock, *flags);
+		mutex_lock(&intf->seq_lock);
 	}
 }
 
@@ -5008,7 +4997,7 @@ static bool ipmi_timeout_handler(struct
 	 * list.
 	 */
 	INIT_LIST_HEAD(&timeouts);
-	spin_lock_irqsave(&intf->seq_lock, flags);
+	mutex_lock(&intf->seq_lock);
 	if (intf->ipmb_maintenance_mode_timeout) {
 		if (intf->ipmb_maintenance_mode_timeout <= timeout_period)
 			intf->ipmb_maintenance_mode_timeout = 0;
@@ -5018,8 +5007,8 @@ static bool ipmi_timeout_handler(struct
 	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++)
 		check_msg_timeout(intf, &intf->seq_table[i],
 				  &timeouts, timeout_period, i,
-				  &flags, &need_timer);
-	spin_unlock_irqrestore(&intf->seq_lock, flags);
+				  &need_timer);
+	mutex_unlock(&intf->seq_lock);
 
 	list_for_each_entry_safe(msg, msg2, &timeouts, link)
 		deliver_err_response(intf, msg, IPMI_TIMEOUT_COMPLETION_CODE);



