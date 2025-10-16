Return-Path: <stable+bounces-186049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D45BE3710
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F7AC4F73D6
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ADB32C30B;
	Thu, 16 Oct 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AqePM3X9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB6326D50
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618338; cv=none; b=kZ63btEV2juhU1yJU5Nyn7M6M9hTFEN+BFZzSUqAEkB/YkBMajZOYZ+UBHjsqU0K2PHgkjpP2/fR9MBSMGWli5ELPyW15HfhYY215m2DWMIuWhittmlNAT8jxz0lCym79VQi81g+8YGCCsRJ1akwR3gND80BVRd9XRFtHNoJwL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618338; c=relaxed/simple;
	bh=RuSn1QPAO/LxycaTLh55sPkURq17vUoyolU26EBz7Ig=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XasPpHGf0xN188pgtnU92pUOUf8sH9YDrx4f3PLtqK5RrR4ZKktAyhakNTA42MUsSifp9SOjOrrESQOKPLmfG8oO0kQEFzmDZcK3f5Nxin3ZkfZh0cq99Jf/Vq9aCHFpxxjsFxipxvqbqYQUTgxoPMzYHiwRIqdzkBk0QFpg19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AqePM3X9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D971C4CEF1;
	Thu, 16 Oct 2025 12:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760618338;
	bh=RuSn1QPAO/LxycaTLh55sPkURq17vUoyolU26EBz7Ig=;
	h=Subject:To:Cc:From:Date:From;
	b=AqePM3X9jksgYnndYL8ijrnz5iSUgz7VkyUjFERr9XrhLwd8jYS0Z8BF7gL3fFGg9
	 3EHzmBTx341YMrrOck5B9gCiFXwVTXO4+7GYXC4TnBn+D27e8VJNwKF7AACWkV/q0h
	 ggy0nMxpmUHjSEgmgTzW1+AYGbqh1zfA4c8de508=
Subject: FAILED: patch "[PATCH] ipmi: Rework user message limit handling" failed to apply to 6.1-stable tree
To: corey@minyard.net,gilles.buloz@kontron.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:38:47 +0200
Message-ID: <2025101647-unsteady-antitrust-ef9e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b52da4054ee0bf9ecb44996f2c83236ff50b3812
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101647-unsteady-antitrust-ef9e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b52da4054ee0bf9ecb44996f2c83236ff50b3812 Mon Sep 17 00:00:00 2001
From: Corey Minyard <corey@minyard.net>
Date: Fri, 5 Sep 2025 11:33:39 -0500
Subject: [PATCH] ipmi: Rework user message limit handling

The limit on the number of user messages had a number of issues,
improper counting in some cases and a use after free.

Restructure how this is all done to handle more in the receive message
allocation routine, so all refcouting and user message limit counts
are done in that routine.  It's a lot cleaner and safer.

Reported-by: Gilles BULOZ <gilles.buloz@kontron.com>
Closes: https://lore.kernel.org/lkml/aLsw6G0GyqfpKs2S@mail.minyard.net/
Fixes: 8e76741c3d8b ("ipmi: Add a limit on the number of users that may use IPMI")
Cc: <stable@vger.kernel.org> # 4.19
Signed-off-by: Corey Minyard <corey@minyard.net>
Tested-by: Gilles BULOZ <gilles.buloz@kontron.com>

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index b78cc359534d..d2fbf2203bd2 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -38,7 +38,9 @@
 
 #define IPMI_DRIVER_VERSION "39.2"
 
-static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
+static struct ipmi_recv_msg *ipmi_alloc_recv_msg(struct ipmi_user *user);
+static void ipmi_set_recv_msg_user(struct ipmi_recv_msg *msg,
+				   struct ipmi_user *user);
 static int ipmi_init_msghandler(void);
 static void smi_work(struct work_struct *t);
 static void handle_new_recv_msgs(struct ipmi_smi *intf);
@@ -955,7 +957,6 @@ static int deliver_response(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
 		 * risk.  At this moment, simply skip it in that case.
 		 */
 		ipmi_free_recv_msg(msg);
-		atomic_dec(&msg->user->nr_msgs);
 	} else {
 		/*
 		 * Deliver it in smi_work.  The message will hold a
@@ -1611,8 +1612,7 @@ int ipmi_set_gets_events(struct ipmi_user *user, bool val)
 		}
 
 		list_for_each_entry_safe(msg, msg2, &msgs, link) {
-			msg->user = user;
-			kref_get(&user->refcount);
+			ipmi_set_recv_msg_user(msg, user);
 			deliver_local_response(intf, msg);
 		}
 	}
@@ -2277,22 +2277,15 @@ static int i_ipmi_request(struct ipmi_user     *user,
 	int run_to_completion = READ_ONCE(intf->run_to_completion);
 	int rv = 0;
 
-	if (user) {
-		if (atomic_add_return(1, &user->nr_msgs) > max_msgs_per_user) {
-			/* Decrement will happen at the end of the routine. */
-			rv = -EBUSY;
-			goto out;
-		}
-	}
-
-	if (supplied_recv)
+	if (supplied_recv) {
 		recv_msg = supplied_recv;
-	else {
-		recv_msg = ipmi_alloc_recv_msg();
-		if (recv_msg == NULL) {
-			rv = -ENOMEM;
-			goto out;
-		}
+		recv_msg->user = user;
+		if (user)
+			atomic_inc(&user->nr_msgs);
+	} else {
+		recv_msg = ipmi_alloc_recv_msg(user);
+		if (IS_ERR(recv_msg))
+			return PTR_ERR(recv_msg);
 	}
 	recv_msg->user_msg_data = user_msg_data;
 
@@ -2303,8 +2296,7 @@ static int i_ipmi_request(struct ipmi_user     *user,
 		if (smi_msg == NULL) {
 			if (!supplied_recv)
 				ipmi_free_recv_msg(recv_msg);
-			rv = -ENOMEM;
-			goto out;
+			return -ENOMEM;
 		}
 	}
 
@@ -2315,10 +2307,6 @@ static int i_ipmi_request(struct ipmi_user     *user,
 		goto out_err;
 	}
 
-	recv_msg->user = user;
-	if (user)
-		/* The put happens when the message is freed. */
-		kref_get(&user->refcount);
 	recv_msg->msgid = msgid;
 	/*
 	 * Store the message to send in the receive message so timeout
@@ -2347,8 +2335,10 @@ static int i_ipmi_request(struct ipmi_user     *user,
 
 	if (rv) {
 out_err:
-		ipmi_free_smi_msg(smi_msg);
-		ipmi_free_recv_msg(recv_msg);
+		if (!supplied_smi)
+			ipmi_free_smi_msg(smi_msg);
+		if (!supplied_recv)
+			ipmi_free_recv_msg(recv_msg);
 	} else {
 		dev_dbg(intf->si_dev, "Send: %*ph\n",
 			smi_msg->data_size, smi_msg->data);
@@ -2358,9 +2348,6 @@ static int i_ipmi_request(struct ipmi_user     *user,
 	if (!run_to_completion)
 		mutex_unlock(&intf->users_mutex);
 
-out:
-	if (rv && user)
-		atomic_dec(&user->nr_msgs);
 	return rv;
 }
 
@@ -3851,7 +3838,7 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_smi *intf,
 	unsigned char            chan;
 	struct ipmi_user         *user = NULL;
 	struct ipmi_ipmb_addr    *ipmb_addr;
-	struct ipmi_recv_msg     *recv_msg;
+	struct ipmi_recv_msg     *recv_msg = NULL;
 
 	if (msg->rsp_size < 10) {
 		/* Message not big enough, just ignore it. */
@@ -3872,9 +3859,8 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_smi *intf,
 	rcvr = find_cmd_rcvr(intf, netfn, cmd, chan);
 	if (rcvr) {
 		user = rcvr->user;
-		kref_get(&user->refcount);
-	} else
-		user = NULL;
+		recv_msg = ipmi_alloc_recv_msg(user);
+	}
 	rcu_read_unlock();
 
 	if (user == NULL) {
@@ -3904,47 +3890,41 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_smi *intf,
 		 * causes it to not be freed or queued.
 		 */
 		rv = -1;
+	} else if (!IS_ERR(recv_msg)) {
+		/* Extract the source address from the data. */
+		ipmb_addr = (struct ipmi_ipmb_addr *) &recv_msg->addr;
+		ipmb_addr->addr_type = IPMI_IPMB_ADDR_TYPE;
+		ipmb_addr->slave_addr = msg->rsp[6];
+		ipmb_addr->lun = msg->rsp[7] & 3;
+		ipmb_addr->channel = msg->rsp[3] & 0xf;
+
+		/*
+		 * Extract the rest of the message information
+		 * from the IPMB header.
+		 */
+		recv_msg->recv_type = IPMI_CMD_RECV_TYPE;
+		recv_msg->msgid = msg->rsp[7] >> 2;
+		recv_msg->msg.netfn = msg->rsp[4] >> 2;
+		recv_msg->msg.cmd = msg->rsp[8];
+		recv_msg->msg.data = recv_msg->msg_data;
+
+		/*
+		 * We chop off 10, not 9 bytes because the checksum
+		 * at the end also needs to be removed.
+		 */
+		recv_msg->msg.data_len = msg->rsp_size - 10;
+		memcpy(recv_msg->msg_data, &msg->rsp[9],
+		       msg->rsp_size - 10);
+		if (deliver_response(intf, recv_msg))
+			ipmi_inc_stat(intf, unhandled_commands);
+		else
+			ipmi_inc_stat(intf, handled_commands);
 	} else {
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
-			/*
-			 * We couldn't allocate memory for the
-			 * message, so requeue it for handling
-			 * later.
-			 */
-			rv = 1;
-			kref_put(&user->refcount, free_ipmi_user);
-		} else {
-			/* Extract the source address from the data. */
-			ipmb_addr = (struct ipmi_ipmb_addr *) &recv_msg->addr;
-			ipmb_addr->addr_type = IPMI_IPMB_ADDR_TYPE;
-			ipmb_addr->slave_addr = msg->rsp[6];
-			ipmb_addr->lun = msg->rsp[7] & 3;
-			ipmb_addr->channel = msg->rsp[3] & 0xf;
-
-			/*
-			 * Extract the rest of the message information
-			 * from the IPMB header.
-			 */
-			recv_msg->user = user;
-			recv_msg->recv_type = IPMI_CMD_RECV_TYPE;
-			recv_msg->msgid = msg->rsp[7] >> 2;
-			recv_msg->msg.netfn = msg->rsp[4] >> 2;
-			recv_msg->msg.cmd = msg->rsp[8];
-			recv_msg->msg.data = recv_msg->msg_data;
-
-			/*
-			 * We chop off 10, not 9 bytes because the checksum
-			 * at the end also needs to be removed.
-			 */
-			recv_msg->msg.data_len = msg->rsp_size - 10;
-			memcpy(recv_msg->msg_data, &msg->rsp[9],
-			       msg->rsp_size - 10);
-			if (deliver_response(intf, recv_msg))
-				ipmi_inc_stat(intf, unhandled_commands);
-			else
-				ipmi_inc_stat(intf, handled_commands);
-		}
+		/*
+		 * We couldn't allocate memory for the message, so
+		 * requeue it for handling later.
+		 */
+		rv = 1;
 	}
 
 	return rv;
@@ -3957,7 +3937,7 @@ static int handle_ipmb_direct_rcv_cmd(struct ipmi_smi *intf,
 	int                      rv = 0;
 	struct ipmi_user         *user = NULL;
 	struct ipmi_ipmb_direct_addr *daddr;
-	struct ipmi_recv_msg     *recv_msg;
+	struct ipmi_recv_msg     *recv_msg = NULL;
 	unsigned char netfn = msg->rsp[0] >> 2;
 	unsigned char cmd = msg->rsp[3];
 
@@ -3966,9 +3946,8 @@ static int handle_ipmb_direct_rcv_cmd(struct ipmi_smi *intf,
 	rcvr = find_cmd_rcvr(intf, netfn, cmd, 0);
 	if (rcvr) {
 		user = rcvr->user;
-		kref_get(&user->refcount);
-	} else
-		user = NULL;
+		recv_msg = ipmi_alloc_recv_msg(user);
+	}
 	rcu_read_unlock();
 
 	if (user == NULL) {
@@ -3990,44 +3969,38 @@ static int handle_ipmb_direct_rcv_cmd(struct ipmi_smi *intf,
 		 * causes it to not be freed or queued.
 		 */
 		rv = -1;
+	} else if (!IS_ERR(recv_msg)) {
+		/* Extract the source address from the data. */
+		daddr = (struct ipmi_ipmb_direct_addr *)&recv_msg->addr;
+		daddr->addr_type = IPMI_IPMB_DIRECT_ADDR_TYPE;
+		daddr->channel = 0;
+		daddr->slave_addr = msg->rsp[1];
+		daddr->rs_lun = msg->rsp[0] & 3;
+		daddr->rq_lun = msg->rsp[2] & 3;
+
+		/*
+		 * Extract the rest of the message information
+		 * from the IPMB header.
+		 */
+		recv_msg->recv_type = IPMI_CMD_RECV_TYPE;
+		recv_msg->msgid = (msg->rsp[2] >> 2);
+		recv_msg->msg.netfn = msg->rsp[0] >> 2;
+		recv_msg->msg.cmd = msg->rsp[3];
+		recv_msg->msg.data = recv_msg->msg_data;
+
+		recv_msg->msg.data_len = msg->rsp_size - 4;
+		memcpy(recv_msg->msg_data, msg->rsp + 4,
+		       msg->rsp_size - 4);
+		if (deliver_response(intf, recv_msg))
+			ipmi_inc_stat(intf, unhandled_commands);
+		else
+			ipmi_inc_stat(intf, handled_commands);
 	} else {
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
-			/*
-			 * We couldn't allocate memory for the
-			 * message, so requeue it for handling
-			 * later.
-			 */
-			rv = 1;
-			kref_put(&user->refcount, free_ipmi_user);
-		} else {
-			/* Extract the source address from the data. */
-			daddr = (struct ipmi_ipmb_direct_addr *)&recv_msg->addr;
-			daddr->addr_type = IPMI_IPMB_DIRECT_ADDR_TYPE;
-			daddr->channel = 0;
-			daddr->slave_addr = msg->rsp[1];
-			daddr->rs_lun = msg->rsp[0] & 3;
-			daddr->rq_lun = msg->rsp[2] & 3;
-
-			/*
-			 * Extract the rest of the message information
-			 * from the IPMB header.
-			 */
-			recv_msg->user = user;
-			recv_msg->recv_type = IPMI_CMD_RECV_TYPE;
-			recv_msg->msgid = (msg->rsp[2] >> 2);
-			recv_msg->msg.netfn = msg->rsp[0] >> 2;
-			recv_msg->msg.cmd = msg->rsp[3];
-			recv_msg->msg.data = recv_msg->msg_data;
-
-			recv_msg->msg.data_len = msg->rsp_size - 4;
-			memcpy(recv_msg->msg_data, msg->rsp + 4,
-			       msg->rsp_size - 4);
-			if (deliver_response(intf, recv_msg))
-				ipmi_inc_stat(intf, unhandled_commands);
-			else
-				ipmi_inc_stat(intf, handled_commands);
-		}
+		/*
+		 * We couldn't allocate memory for the message, so
+		 * requeue it for handling later.
+		 */
+		rv = 1;
 	}
 
 	return rv;
@@ -4141,7 +4114,7 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
 	unsigned char            chan;
 	struct ipmi_user         *user = NULL;
 	struct ipmi_lan_addr     *lan_addr;
-	struct ipmi_recv_msg     *recv_msg;
+	struct ipmi_recv_msg     *recv_msg = NULL;
 
 	if (msg->rsp_size < 12) {
 		/* Message not big enough, just ignore it. */
@@ -4162,9 +4135,8 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
 	rcvr = find_cmd_rcvr(intf, netfn, cmd, chan);
 	if (rcvr) {
 		user = rcvr->user;
-		kref_get(&user->refcount);
-	} else
-		user = NULL;
+		recv_msg = ipmi_alloc_recv_msg(user);
+	}
 	rcu_read_unlock();
 
 	if (user == NULL) {
@@ -4195,49 +4167,44 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
 		 * causes it to not be freed or queued.
 		 */
 		rv = -1;
+	} else if (!IS_ERR(recv_msg)) {
+		/* Extract the source address from the data. */
+		lan_addr = (struct ipmi_lan_addr *) &recv_msg->addr;
+		lan_addr->addr_type = IPMI_LAN_ADDR_TYPE;
+		lan_addr->session_handle = msg->rsp[4];
+		lan_addr->remote_SWID = msg->rsp[8];
+		lan_addr->local_SWID = msg->rsp[5];
+		lan_addr->lun = msg->rsp[9] & 3;
+		lan_addr->channel = msg->rsp[3] & 0xf;
+		lan_addr->privilege = msg->rsp[3] >> 4;
+
+		/*
+		 * Extract the rest of the message information
+		 * from the IPMB header.
+		 */
+		recv_msg->recv_type = IPMI_CMD_RECV_TYPE;
+		recv_msg->msgid = msg->rsp[9] >> 2;
+		recv_msg->msg.netfn = msg->rsp[6] >> 2;
+		recv_msg->msg.cmd = msg->rsp[10];
+		recv_msg->msg.data = recv_msg->msg_data;
+
+		/*
+		 * We chop off 12, not 11 bytes because the checksum
+		 * at the end also needs to be removed.
+		 */
+		recv_msg->msg.data_len = msg->rsp_size - 12;
+		memcpy(recv_msg->msg_data, &msg->rsp[11],
+		       msg->rsp_size - 12);
+		if (deliver_response(intf, recv_msg))
+			ipmi_inc_stat(intf, unhandled_commands);
+		else
+			ipmi_inc_stat(intf, handled_commands);
 	} else {
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
-			/*
-			 * We couldn't allocate memory for the
-			 * message, so requeue it for handling later.
-			 */
-			rv = 1;
-			kref_put(&user->refcount, free_ipmi_user);
-		} else {
-			/* Extract the source address from the data. */
-			lan_addr = (struct ipmi_lan_addr *) &recv_msg->addr;
-			lan_addr->addr_type = IPMI_LAN_ADDR_TYPE;
-			lan_addr->session_handle = msg->rsp[4];
-			lan_addr->remote_SWID = msg->rsp[8];
-			lan_addr->local_SWID = msg->rsp[5];
-			lan_addr->lun = msg->rsp[9] & 3;
-			lan_addr->channel = msg->rsp[3] & 0xf;
-			lan_addr->privilege = msg->rsp[3] >> 4;
-
-			/*
-			 * Extract the rest of the message information
-			 * from the IPMB header.
-			 */
-			recv_msg->user = user;
-			recv_msg->recv_type = IPMI_CMD_RECV_TYPE;
-			recv_msg->msgid = msg->rsp[9] >> 2;
-			recv_msg->msg.netfn = msg->rsp[6] >> 2;
-			recv_msg->msg.cmd = msg->rsp[10];
-			recv_msg->msg.data = recv_msg->msg_data;
-
-			/*
-			 * We chop off 12, not 11 bytes because the checksum
-			 * at the end also needs to be removed.
-			 */
-			recv_msg->msg.data_len = msg->rsp_size - 12;
-			memcpy(recv_msg->msg_data, &msg->rsp[11],
-			       msg->rsp_size - 12);
-			if (deliver_response(intf, recv_msg))
-				ipmi_inc_stat(intf, unhandled_commands);
-			else
-				ipmi_inc_stat(intf, handled_commands);
-		}
+		/*
+		 * We couldn't allocate memory for the message, so
+		 * requeue it for handling later.
+		 */
+		rv = 1;
 	}
 
 	return rv;
@@ -4259,7 +4226,7 @@ static int handle_oem_get_msg_cmd(struct ipmi_smi *intf,
 	unsigned char         chan;
 	struct ipmi_user *user = NULL;
 	struct ipmi_system_interface_addr *smi_addr;
-	struct ipmi_recv_msg  *recv_msg;
+	struct ipmi_recv_msg  *recv_msg = NULL;
 
 	/*
 	 * We expect the OEM SW to perform error checking
@@ -4288,9 +4255,8 @@ static int handle_oem_get_msg_cmd(struct ipmi_smi *intf,
 	rcvr = find_cmd_rcvr(intf, netfn, cmd, chan);
 	if (rcvr) {
 		user = rcvr->user;
-		kref_get(&user->refcount);
-	} else
-		user = NULL;
+		recv_msg = ipmi_alloc_recv_msg(user);
+	}
 	rcu_read_unlock();
 
 	if (user == NULL) {
@@ -4303,48 +4269,42 @@ static int handle_oem_get_msg_cmd(struct ipmi_smi *intf,
 		 */
 
 		rv = 0;
+	} else if (!IS_ERR(recv_msg)) {
+		/*
+		 * OEM Messages are expected to be delivered via
+		 * the system interface to SMS software.  We might
+		 * need to visit this again depending on OEM
+		 * requirements
+		 */
+		smi_addr = ((struct ipmi_system_interface_addr *)
+			    &recv_msg->addr);
+		smi_addr->addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+		smi_addr->channel = IPMI_BMC_CHANNEL;
+		smi_addr->lun = msg->rsp[0] & 3;
+
+		recv_msg->user_msg_data = NULL;
+		recv_msg->recv_type = IPMI_OEM_RECV_TYPE;
+		recv_msg->msg.netfn = msg->rsp[0] >> 2;
+		recv_msg->msg.cmd = msg->rsp[1];
+		recv_msg->msg.data = recv_msg->msg_data;
+
+		/*
+		 * The message starts at byte 4 which follows the
+		 * Channel Byte in the "GET MESSAGE" command
+		 */
+		recv_msg->msg.data_len = msg->rsp_size - 4;
+		memcpy(recv_msg->msg_data, &msg->rsp[4],
+		       msg->rsp_size - 4);
+		if (deliver_response(intf, recv_msg))
+			ipmi_inc_stat(intf, unhandled_commands);
+		else
+			ipmi_inc_stat(intf, handled_commands);
 	} else {
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
-			/*
-			 * We couldn't allocate memory for the
-			 * message, so requeue it for handling
-			 * later.
-			 */
-			rv = 1;
-			kref_put(&user->refcount, free_ipmi_user);
-		} else {
-			/*
-			 * OEM Messages are expected to be delivered via
-			 * the system interface to SMS software.  We might
-			 * need to visit this again depending on OEM
-			 * requirements
-			 */
-			smi_addr = ((struct ipmi_system_interface_addr *)
-				    &recv_msg->addr);
-			smi_addr->addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
-			smi_addr->channel = IPMI_BMC_CHANNEL;
-			smi_addr->lun = msg->rsp[0] & 3;
-
-			recv_msg->user = user;
-			recv_msg->user_msg_data = NULL;
-			recv_msg->recv_type = IPMI_OEM_RECV_TYPE;
-			recv_msg->msg.netfn = msg->rsp[0] >> 2;
-			recv_msg->msg.cmd = msg->rsp[1];
-			recv_msg->msg.data = recv_msg->msg_data;
-
-			/*
-			 * The message starts at byte 4 which follows the
-			 * Channel Byte in the "GET MESSAGE" command
-			 */
-			recv_msg->msg.data_len = msg->rsp_size - 4;
-			memcpy(recv_msg->msg_data, &msg->rsp[4],
-			       msg->rsp_size - 4);
-			if (deliver_response(intf, recv_msg))
-				ipmi_inc_stat(intf, unhandled_commands);
-			else
-				ipmi_inc_stat(intf, handled_commands);
-		}
+		/*
+		 * We couldn't allocate memory for the message, so
+		 * requeue it for handling later.
+		 */
+		rv = 1;
 	}
 
 	return rv;
@@ -4402,8 +4362,8 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
 		if (!user->gets_events)
 			continue;
 
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
+		recv_msg = ipmi_alloc_recv_msg(user);
+		if (IS_ERR(recv_msg)) {
 			mutex_unlock(&intf->users_mutex);
 			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs,
 						 link) {
@@ -4424,8 +4384,6 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
 		deliver_count++;
 
 		copy_event_into_recv_msg(recv_msg, msg);
-		recv_msg->user = user;
-		kref_get(&user->refcount);
 		list_add_tail(&recv_msg->link, &msgs);
 	}
 	mutex_unlock(&intf->users_mutex);
@@ -4441,8 +4399,8 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
 		 * No one to receive the message, put it in queue if there's
 		 * not already too many things in the queue.
 		 */
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
+		recv_msg = ipmi_alloc_recv_msg(NULL);
+		if (IS_ERR(recv_msg)) {
 			/*
 			 * We couldn't allocate memory for the
 			 * message, so requeue it for handling
@@ -4858,12 +4816,10 @@ static void smi_work(struct work_struct *t)
 
 		list_del(&msg->link);
 
-		if (refcount_read(&user->destroyed) == 0) {
+		if (refcount_read(&user->destroyed) == 0)
 			ipmi_free_recv_msg(msg);
-		} else {
-			atomic_dec(&user->nr_msgs);
+		else
 			user->handler->ipmi_recv_hndl(msg, user->handler_data);
-		}
 	}
 	mutex_unlock(&intf->user_msgs_mutex);
 
@@ -5179,27 +5135,51 @@ static void free_recv_msg(struct ipmi_recv_msg *msg)
 		kfree(msg);
 }
 
-static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void)
+static struct ipmi_recv_msg *ipmi_alloc_recv_msg(struct ipmi_user *user)
 {
 	struct ipmi_recv_msg *rv;
 
-	rv = kmalloc(sizeof(struct ipmi_recv_msg), GFP_ATOMIC);
-	if (rv) {
-		rv->user = NULL;
-		rv->done = free_recv_msg;
-		atomic_inc(&recv_msg_inuse_count);
+	if (user) {
+		if (atomic_add_return(1, &user->nr_msgs) > max_msgs_per_user) {
+			atomic_dec(&user->nr_msgs);
+			return ERR_PTR(-EBUSY);
+		}
 	}
+
+	rv = kmalloc(sizeof(struct ipmi_recv_msg), GFP_ATOMIC);
+	if (!rv) {
+		if (user)
+			atomic_dec(&user->nr_msgs);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	rv->user = user;
+	rv->done = free_recv_msg;
+	if (user)
+		kref_get(&user->refcount);
+	atomic_inc(&recv_msg_inuse_count);
 	return rv;
 }
 
 void ipmi_free_recv_msg(struct ipmi_recv_msg *msg)
 {
-	if (msg->user && !oops_in_progress)
+	if (msg->user && !oops_in_progress) {
+		atomic_dec(&msg->user->nr_msgs);
 		kref_put(&msg->user->refcount, free_ipmi_user);
+	}
 	msg->done(msg);
 }
 EXPORT_SYMBOL(ipmi_free_recv_msg);
 
+static void ipmi_set_recv_msg_user(struct ipmi_recv_msg *msg,
+				   struct ipmi_user *user)
+{
+	WARN_ON_ONCE(msg->user); /* User should not be set. */
+	msg->user = user;
+	atomic_inc(&user->nr_msgs);
+	kref_get(&user->refcount);
+}
+
 static atomic_t panic_done_count = ATOMIC_INIT(0);
 
 static void dummy_smi_done_handler(struct ipmi_smi_msg *msg)


