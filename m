Return-Path: <stable+bounces-186186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DD7BE51B1
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 20:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D972D1A670E5
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 18:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3924C1C84C0;
	Thu, 16 Oct 2025 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="KxSlGUdj"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9934DDD2
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640616; cv=none; b=NwJeaI26WT9drzHM/G14jZJBbc8k6gQ05oWHg77/uf97pY1kLx3wNuG58K44wK3k3/6LARM2s3fAPSe5RSxeR/jMEjoqCKUYcuCLQAa+D/MtRxnZErylwRWfyJfJ/KiDuvMkca7xb46bGo2CXhyGA7BggYwAYRGlWdXUdwJ0TsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640616; c=relaxed/simple;
	bh=C2ZwzlrKxaCHJFCZAV1DskaT3/bC9DUFmuCRYhvxtFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBeFA8NZ3v2fjouroN7rklDrDHQWT16rRr1pnXaix49TNiMKszb4E57vA9QcFC9wqgb79K6xmgc4sD9GWN7tGK5MTXNhhf7hYA2mgpVbbTtH5nPypOj/WNoUdNphJtKd6dVxlHMK48s6yM0iZfUZCKMIfBZUcEmjh6kG2h3RmOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=KxSlGUdj; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-64e84414cfbso488755eaf.1
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1760640613; x=1761245413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9MYbzgpRdRLKK6vgGi7KuWGGqivIn4IPCDzwdZvVYI=;
        b=KxSlGUdjVmWtNMQSCJDvl1N1M5xNSt6SRIN6FkuRWGGOthBRVch5a6mzZ/RL2bvrnB
         /vnx4LSjITZqzUBTj4jcV+rq5W8d02XzdQdn0MInWi30rTSMFQYXejjMQuDhSI4InCR0
         rMQgH89NfiEgMF7wLL3JVlIsjyzvfY7at2axUvRHT1RF0ID+eKukOBmGvdMWjEKHpfVk
         cClyZoRNNXcBpOfdSZUsvNKgOnZ59oanOtHOgqGBOf9tb5jFWW8MERBnTYYlD7lkISSb
         ZhsQYHN9c20QJhglco/RzO0tR1ZDp1/VXLy5pgGWjnhNVlv+nE4fXR704LBq/84vMSZG
         1n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640613; x=1761245413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9MYbzgpRdRLKK6vgGi7KuWGGqivIn4IPCDzwdZvVYI=;
        b=UbjCkOSC/hv1cqWtIiTUNX59oaGLpWVbCizLFyegAEx6V4I9iB5ePweHoIM/ygDffX
         7wDp/gA9obj3wD4d12K06S1gXrX/zursB44HC+81npiZ99O/bUayKn9ipdOMNzn8/XYS
         9eQFE5/N+iYgNJwTxz9okC0NarNsZAjuWvEp8+5UMtyi5ywO31EIUBZ2X8taNaugkSXn
         q5RIdjPHvk/f4HtZGLPABs+JADoN5USx8I1cv4CSE4xkTIdkVJ31qjPGCZTjrsoG+T5m
         RibxRD/14ANPbq0HiUTkXWJ4X1iASE/TdJT2h/tgbhTpOg6kQbUnb7lFkdQL6i7SmpPb
         sigQ==
X-Gm-Message-State: AOJu0YxumG+ogR4EOyp3LV65YyLnY4uu+ZZtOQvZzfH7QpnOYMzYkP/Y
	addXSV6XPDgTnc7h/7tybVjDAZHN6x/gFyzhpXLEekduGmPcMIjg3Febw/wsrI4+CsqzlqT8s61
	fPk93
X-Gm-Gg: ASbGncu6KsBCh+Y3c/nP3Jj+b0tzXP+Dxu/LmhxjoTvHxLcXEh237KlQGeVg18ukewx
	tfCdrclcoB3o5RyPwmDKO1cHzmrIMJktViUwlsLfALW41qujW6QtlRGd8Xj0FMr0voi/WZCcXXh
	f88rWCq0YkXNuLGxJArWmr7ZQc27k4Eyu13sgf09Uz1MZU24ljk7Fows33xO1BtwvsGQWkIgJmV
	skcWSWrhW9QqhvZ5aDtzvvv5yPjQsGhqSNJowr6/5fhkvFYuJJBP1B95uo1pSNQ9B6nnOOLMNh2
	b6WXpp4khSNmWr4vST7gchZ63NAni4kKKNguRZyvV8sBlMxZghbQruACjkexT/xK8DUng1h5PvI
	f3maFwtHMhdpNdF30kM25XB2uQFRcWtkVFUkkhwLi647vMssDnEMaQfpg5dPWihN3a9vTNxAVzz
	oU5x6p
X-Google-Smtp-Source: AGHT+IGIATW/gkEDXQA2Jvst//LN6R/SpWoTeVwp/i91gXAzfVzJ7iB/PfXOlURlBMecQS9y9ZLY4Q==
X-Received: by 2002:a05:6808:14c5:b0:43f:75e2:af48 with SMTP id 5614622812f47-443a2f1ba5dmr573528b6e.21.1760640612752;
        Thu, 16 Oct 2025 11:50:12 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:fbfe:2b7d:e6e9:975e])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-441c9209c34sm3872802b6e.8.2025.10.16.11.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 11:50:12 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>,
	Gilles BULOZ <gilles.buloz@kontron.com>
Subject: [PATCH 6.6.y 1/2] ipmi: Rework user message limit handling
Date: Thu, 16 Oct 2025 13:50:05 -0500
Message-ID: <20251016185006.1876032-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025101647-undated-train-2b88@gregkh>
References: <2025101647-undated-train-2b88@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit b52da4054ee0bf9ecb44996f2c83236ff50b3812 upstream

This patch required quite a bit of work to backport due to a number
of unrelated changes that do not make sense to backport.  This has
been run against my test suite and passes all tests.

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
---
 drivers/char/ipmi/ipmi_msghandler.c | 415 +++++++++++++---------------
 1 file changed, 198 insertions(+), 217 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 96f175bd6d9f..7ad17c5b8966 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -39,7 +39,9 @@
 
 #define IPMI_DRIVER_VERSION "39.2"
 
-static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
+static struct ipmi_recv_msg *ipmi_alloc_recv_msg(struct ipmi_user *user);
+static void ipmi_set_recv_msg_user(struct ipmi_recv_msg *msg,
+				   struct ipmi_user *user);
 static int ipmi_init_msghandler(void);
 static void smi_recv_tasklet(struct tasklet_struct *t);
 static void handle_new_recv_msgs(struct ipmi_smi *intf);
@@ -939,13 +941,11 @@ static int deliver_response(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
 		 * risk.  At this moment, simply skip it in that case.
 		 */
 		ipmi_free_recv_msg(msg);
-		atomic_dec(&msg->user->nr_msgs);
 	} else {
 		int index;
 		struct ipmi_user *user = acquire_ipmi_user(msg->user, &index);
 
 		if (user) {
-			atomic_dec(&user->nr_msgs);
 			user->handler->ipmi_recv_hndl(msg, user->handler_data);
 			release_ipmi_user(user, index);
 		} else {
@@ -1634,8 +1634,7 @@ int ipmi_set_gets_events(struct ipmi_user *user, bool val)
 		spin_unlock_irqrestore(&intf->events_lock, flags);
 
 		list_for_each_entry_safe(msg, msg2, &msgs, link) {
-			msg->user = user;
-			kref_get(&user->refcount);
+			ipmi_set_recv_msg_user(msg, user);
 			deliver_local_response(intf, msg);
 		}
 
@@ -2309,22 +2308,15 @@ static int i_ipmi_request(struct ipmi_user     *user,
 	struct ipmi_recv_msg *recv_msg;
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
 
@@ -2335,8 +2327,7 @@ static int i_ipmi_request(struct ipmi_user     *user,
 		if (smi_msg == NULL) {
 			if (!supplied_recv)
 				ipmi_free_recv_msg(recv_msg);
-			rv = -ENOMEM;
-			goto out;
+			return -ENOMEM;
 		}
 	}
 
@@ -2346,10 +2337,6 @@ static int i_ipmi_request(struct ipmi_user     *user,
 		goto out_err;
 	}
 
-	recv_msg->user = user;
-	if (user)
-		/* The put happens when the message is freed. */
-		kref_get(&user->refcount);
 	recv_msg->msgid = msgid;
 	/*
 	 * Store the message to send in the receive message so timeout
@@ -2378,8 +2365,10 @@ static int i_ipmi_request(struct ipmi_user     *user,
 
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
@@ -2388,9 +2377,6 @@ static int i_ipmi_request(struct ipmi_user     *user,
 	}
 	rcu_read_unlock();
 
-out:
-	if (rv && user)
-		atomic_dec(&user->nr_msgs);
 	return rv;
 }
 
@@ -3883,7 +3869,7 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_smi *intf,
 	unsigned char            chan;
 	struct ipmi_user         *user = NULL;
 	struct ipmi_ipmb_addr    *ipmb_addr;
-	struct ipmi_recv_msg     *recv_msg;
+	struct ipmi_recv_msg     *recv_msg = NULL;
 
 	if (msg->rsp_size < 10) {
 		/* Message not big enough, just ignore it. */
@@ -3904,9 +3890,8 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_smi *intf,
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
@@ -3941,47 +3926,41 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_smi *intf,
 			rv = -1;
 		}
 		rcu_read_unlock();
-	} else {
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
-			/*
-			 * We couldn't allocate memory for the
-			 * message, so requeue it for handling
-			 * later.
-			 */
-			rv = 1;
-			kref_put(&user->refcount, free_user);
-		} else {
-			/* Extract the source address from the data. */
-			ipmb_addr = (struct ipmi_ipmb_addr *) &recv_msg->addr;
-			ipmb_addr->addr_type = IPMI_IPMB_ADDR_TYPE;
-			ipmb_addr->slave_addr = msg->rsp[6];
-			ipmb_addr->lun = msg->rsp[7] & 3;
-			ipmb_addr->channel = msg->rsp[3] & 0xf;
+	} else if (!IS_ERR(recv_msg)) {
+		/* Extract the source address from the data. */
+		ipmb_addr = (struct ipmi_ipmb_addr *) &recv_msg->addr;
+		ipmb_addr->addr_type = IPMI_IPMB_ADDR_TYPE;
+		ipmb_addr->slave_addr = msg->rsp[6];
+		ipmb_addr->lun = msg->rsp[7] & 3;
+		ipmb_addr->channel = msg->rsp[3] & 0xf;
 
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
+		/*
+		 * Extract the rest of the message information
+		 * from the IPMB header.
+		 */
+		recv_msg->recv_type = IPMI_CMD_RECV_TYPE;
+		recv_msg->msgid = msg->rsp[7] >> 2;
+		recv_msg->msg.netfn = msg->rsp[4] >> 2;
+		recv_msg->msg.cmd = msg->rsp[8];
+		recv_msg->msg.data = recv_msg->msg_data;
 
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
+	} else {
+		/*
+		 * We couldn't allocate memory for the message, so
+		 * requeue it for handling later.
+		 */
+		rv = 1;
 	}
 
 	return rv;
@@ -3994,7 +3973,7 @@ static int handle_ipmb_direct_rcv_cmd(struct ipmi_smi *intf,
 	int                      rv = 0;
 	struct ipmi_user         *user = NULL;
 	struct ipmi_ipmb_direct_addr *daddr;
-	struct ipmi_recv_msg     *recv_msg;
+	struct ipmi_recv_msg     *recv_msg = NULL;
 	unsigned char netfn = msg->rsp[0] >> 2;
 	unsigned char cmd = msg->rsp[3];
 
@@ -4003,9 +3982,8 @@ static int handle_ipmb_direct_rcv_cmd(struct ipmi_smi *intf,
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
@@ -4032,44 +4010,38 @@ static int handle_ipmb_direct_rcv_cmd(struct ipmi_smi *intf,
 			rv = -1;
 		}
 		rcu_read_unlock();
-	} else {
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
-			/*
-			 * We couldn't allocate memory for the
-			 * message, so requeue it for handling
-			 * later.
-			 */
-			rv = 1;
-			kref_put(&user->refcount, free_user);
-		} else {
-			/* Extract the source address from the data. */
-			daddr = (struct ipmi_ipmb_direct_addr *)&recv_msg->addr;
-			daddr->addr_type = IPMI_IPMB_DIRECT_ADDR_TYPE;
-			daddr->channel = 0;
-			daddr->slave_addr = msg->rsp[1];
-			daddr->rs_lun = msg->rsp[0] & 3;
-			daddr->rq_lun = msg->rsp[2] & 3;
+	} else if (!IS_ERR(recv_msg)) {
+		/* Extract the source address from the data. */
+		daddr = (struct ipmi_ipmb_direct_addr *)&recv_msg->addr;
+		daddr->addr_type = IPMI_IPMB_DIRECT_ADDR_TYPE;
+		daddr->channel = 0;
+		daddr->slave_addr = msg->rsp[1];
+		daddr->rs_lun = msg->rsp[0] & 3;
+		daddr->rq_lun = msg->rsp[2] & 3;
 
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
+	} else {
+		/*
+		 * We couldn't allocate memory for the message, so
+		 * requeue it for handling later.
+		 */
+		rv = 1;
 	}
 
 	return rv;
@@ -4183,7 +4155,7 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
 	unsigned char            chan;
 	struct ipmi_user         *user = NULL;
 	struct ipmi_lan_addr     *lan_addr;
-	struct ipmi_recv_msg     *recv_msg;
+	struct ipmi_recv_msg     *recv_msg = NULL;
 
 	if (msg->rsp_size < 12) {
 		/* Message not big enough, just ignore it. */
@@ -4204,9 +4176,8 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
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
@@ -4218,49 +4189,44 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
 		 * them to be freed.
 		 */
 		rv = 0;
-	} else {
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
-			/*
-			 * We couldn't allocate memory for the
-			 * message, so requeue it for handling later.
-			 */
-			rv = 1;
-			kref_put(&user->refcount, free_user);
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
+		/*
+		 * Extract the rest of the message information
+		 * from the IPMB header.
+		 */
+		recv_msg->recv_type = IPMI_CMD_RECV_TYPE;
+		recv_msg->msgid = msg->rsp[9] >> 2;
+		recv_msg->msg.netfn = msg->rsp[6] >> 2;
+		recv_msg->msg.cmd = msg->rsp[10];
+		recv_msg->msg.data = recv_msg->msg_data;
 
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
+	} else {
+		/*
+		 * We couldn't allocate memory for the message, so
+		 * requeue it for handling later.
+		 */
+		rv = 1;
 	}
 
 	return rv;
@@ -4282,7 +4248,7 @@ static int handle_oem_get_msg_cmd(struct ipmi_smi *intf,
 	unsigned char         chan;
 	struct ipmi_user *user = NULL;
 	struct ipmi_system_interface_addr *smi_addr;
-	struct ipmi_recv_msg  *recv_msg;
+	struct ipmi_recv_msg  *recv_msg = NULL;
 
 	/*
 	 * We expect the OEM SW to perform error checking
@@ -4311,9 +4277,8 @@ static int handle_oem_get_msg_cmd(struct ipmi_smi *intf,
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
@@ -4326,48 +4291,42 @@ static int handle_oem_get_msg_cmd(struct ipmi_smi *intf,
 		 */
 
 		rv = 0;
-	} else {
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
-			/*
-			 * We couldn't allocate memory for the
-			 * message, so requeue it for handling
-			 * later.
-			 */
-			rv = 1;
-			kref_put(&user->refcount, free_user);
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
+	} else {
+		/*
+		 * We couldn't allocate memory for the message, so
+		 * requeue it for handling later.
+		 */
+		rv = 1;
 	}
 
 	return rv;
@@ -4426,8 +4385,8 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
 		if (!user->gets_events)
 			continue;
 
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
+		recv_msg = ipmi_alloc_recv_msg(user);
+		if (IS_ERR(recv_msg)) {
 			rcu_read_unlock();
 			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs,
 						 link) {
@@ -4446,8 +4405,6 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
 		deliver_count++;
 
 		copy_event_into_recv_msg(recv_msg, msg);
-		recv_msg->user = user;
-		kref_get(&user->refcount);
 		list_add_tail(&recv_msg->link, &msgs);
 	}
 	srcu_read_unlock(&intf->users_srcu, index);
@@ -4463,8 +4420,8 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
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
@@ -5156,27 +5113,51 @@ static void free_recv_msg(struct ipmi_recv_msg *msg)
 		kfree(msg);
 }
 
-static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void)
+static struct ipmi_recv_msg *ipmi_alloc_recv_msg(struct ipmi_user *user)
 {
 	struct ipmi_recv_msg *rv;
 
+	if (user) {
+		if (atomic_add_return(1, &user->nr_msgs) > max_msgs_per_user) {
+			atomic_dec(&user->nr_msgs);
+			return ERR_PTR(-EBUSY);
+		}
+	}
+
 	rv = kmalloc(sizeof(struct ipmi_recv_msg), GFP_ATOMIC);
-	if (rv) {
-		rv->user = NULL;
-		rv->done = free_recv_msg;
-		atomic_inc(&recv_msg_inuse_count);
+	if (!rv) {
+		if (user)
+			atomic_dec(&user->nr_msgs);
+		return ERR_PTR(-ENOMEM);
 	}
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
 		kref_put(&msg->user->refcount, free_user);
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
-- 
2.43.0


