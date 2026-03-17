Return-Path: <stable+bounces-226524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJKhAQmKuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:06:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A55D62AEF04
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45213305090E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4313F54DD;
	Tue, 17 Mar 2026 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seyKDkFs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C678A3F54CE
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767076; cv=none; b=CIqvAjy3d6JQxjm+ueBxvj9Lftw+/OMqeoN/TXi7zKU1DtMoSXiVHBwO7EA0fPTfVcDjVw/C2psHqvZ3l8JLKQYTVPr9vO+k8XQ3lRgiKllnbqilt7KBCqhPhSRBxX6s498CPVLMf4ELolmhBuaq/lEyTIPsOIgsRqj5f2AeNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767076; c=relaxed/simple;
	bh=ad2JvG0KTmXupaDTLm8dOz8uOFqoFl6VIH/7UbwvbDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCS3JkxAadNcVuK4iIbQ5rfqk0i0Jzj/E4qba+uGDUKNsrWbt57bOk3MoZ3sAXvW/MnxduQVzWdkYefU0NG6/xytcsPqwPLapMGnB7N5eUBId638jD6P2VLybCnk7WVWjAs6FIrvcYCSYMWC737FFYCQWlSAEBM/mGXrpdoRA0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seyKDkFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FF5C2BCB0;
	Tue, 17 Mar 2026 17:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773767076;
	bh=ad2JvG0KTmXupaDTLm8dOz8uOFqoFl6VIH/7UbwvbDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=seyKDkFs3hBb4+Ia6G/ulh/gIKWIqAmF2/5+ZyWIomYj0kWfAj0MXD33FSkvRepng
	 0ahQw8U5AZAzVcUjEILQI/Pw//0h5oyU+9znYKaNFeQmTFUtgJeh5yLqnjWb5E5hdE
	 yDauCUNoNmlb2Vrd4Ltzm/64pqNlhGSrl27IPLAWBgLxcQfv0u4rIiixWffIpKT7eI
	 bSiYtVLGPT6zGdzKoULNH9jhKFUnoYa63ykjjlsZxAhyM7npDRrTWYiGHwsc4Ft4d+
	 fZDuaeZThnEpkW+2yrb8D5QXdCK9wWqjPq/C+Y9du/NWiemgpuYu7/EJ9vyPupLyxd
	 7S9AYWx0ed4+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ipmi:msghandler: Handle error returns from the SMI sender
Date: Tue, 17 Mar 2026 13:04:32 -0400
Message-ID: <20260317170432.230720-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317170432.230720-1-sashal@kernel.org>
References: <2026031714-symptom-calculate-bec2@gregkh>
 <20260317170432.230720-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226524-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A55D62AEF04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Corey Minyard <corey@minyard.net>

[ Upstream commit 62cd145453d577113f993efd025f258dd86aa183 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_msghandler.c | 100 +++++++++++++++++++---------
 1 file changed, 68 insertions(+), 32 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 44135b3a66435..17f7b3b551d5c 100644
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
-out_err:
-		if (!supplied_smi)
-			ipmi_free_smi_msg(smi_msg);
-		if (!supplied_recv)
-			ipmi_free_recv_msg(recv_msg);
-	} else {
+	if (!rv) {
 		dev_dbg(intf->si_dev, "Send: %*ph\n",
 			smi_msg->data_size, smi_msg->data);
 
-		smi_send(intf, intf->handlers, smi_msg, priority);
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
 	}
+out_err:
 	if (!run_to_completion)
 		mutex_unlock(&intf->users_mutex);
 
+	if (rv) {
+		if (!supplied_smi)
+			ipmi_free_smi_msg(smi_msg);
+		if (!supplied_recv)
+			ipmi_free_recv_msg(recv_msg);
+	}
 	return rv;
 }
 
@@ -3961,12 +3992,12 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_smi *intf,
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
@@ -4040,12 +4071,12 @@ static int handle_ipmb_direct_rcv_cmd(struct ipmi_smi *intf,
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
@@ -4185,7 +4216,7 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
 				  struct ipmi_smi_msg *msg)
 {
 	struct cmd_rcvr          *rcvr;
-	int                      rv = 0;
+	int                      rv = 0; /* Free by default */
 	unsigned char            netfn;
 	unsigned char            cmd;
 	unsigned char            chan;
@@ -4238,12 +4269,12 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
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
@@ -5052,7 +5083,12 @@ static void check_msg_timeout(struct ipmi_smi *intf, struct seq_table *ent,
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
 
-- 
2.51.0


