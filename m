Return-Path: <stable+bounces-235787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPK9IwAr22kT+AgAu9opvQ
	(envelope-from <stable+bounces-235787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 07:17:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD0B3E2D15
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 07:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E66330179D3
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 05:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472E923F26A;
	Sun, 12 Apr 2026 05:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2kXBf/e2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1A41DE4E0
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 05:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775970987; cv=none; b=ZFNhBrFD0UpIBRWEUQVXqazV5fbxTtxc9o32cshRyx3svcCdJucAqan4uirXtJFghX+kH6FCUjpXek/b7TTkD0g97j1Wgv94k0pIE35PFu2Jiqntw1atpIA7p7727cBOPJBGLEWBURU00QGlTQziaGj4i/InFZ40SX6050USJ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775970987; c=relaxed/simple;
	bh=eVc4DoXQHKSEjpLbhEus7DOrqhqpradNt8bS1eDfA3Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TFblVa51tgmPLxfE/YDOp7iDz+EQsp0eyBttNvD8aS8O7wz3NrKc12PzzGAsZdPG+suGaYYuzmsNjT/Z/qVr6CTLnM43QQ73wEMoBDZSWSUbl3hC5dbGkn9xGZC/94KbUG/saHAATtnlgsD4XqYDo5Wfj5f0zRkCxVogvbqEVmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2kXBf/e2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D97C19424;
	Sun, 12 Apr 2026 05:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775970986;
	bh=eVc4DoXQHKSEjpLbhEus7DOrqhqpradNt8bS1eDfA3Y=;
	h=Subject:To:Cc:From:Date:From;
	b=2kXBf/e2z3RCZ15ie/zBv1EN6wHwnoI6YIs/FfAVagRioTFjPt4kZiAIdBlsa7vK9
	 B/KEL0b9cVz8AFrURjqz93PTIUx8h8kVYsSZHX/DymJA7qXPltaAca3vn6Wh6kQkTL
	 w2AXWPEd/ObmaQtQ3V8KImCW5HB19JCLSdHuNrHo=
Subject: FAILED: patch "[PATCH] net: rfkill: prevent unlimited numbers of rfkill events from" failed to apply to 5.10-stable tree
To: gregkh@linuxfoundation.org,bird@lzu.edu.cn,johannes.berg@intel.com,johannes@sipsolutions.net,stable@kernel.org,tomapufckgml@gmail.com,yifanwucs@gmail.com,yuantan098@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 12 Apr 2026 07:16:16 +0200
Message-ID: <2026041216-ideology-snowplow-e524@gregkh>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235787-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,lzu.edu.cn,intel.com,sipsolutions.net,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,gregkh:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email,sipsolutions.net:email,msgid.link:url]
X-Rspamd-Queue-Id: DDD0B3E2D15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ea245d78dec594372e27d8c79616baf49e98a4a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026041216-ideology-snowplow-e524@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ea245d78dec594372e27d8c79616baf49e98a4a1 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:14:13 +0200
Subject: [PATCH] net: rfkill: prevent unlimited numbers of rfkill events from
 being created

Userspace can create an unlimited number of rfkill events if the system
is so configured, while not consuming them from the rfkill file
descriptor, causing a potential out of memory situation.  Prevent this
from bounding the number of pending rfkill events at a "large" number
(i.e. 1000) to prevent abuses like this.

Cc: Johannes Berg <johannes@sipsolutions.net>
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026033013-disfigure-scroll-e25e@gregkh
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 2444237bc36a..4827e1fb8804 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -73,11 +73,14 @@ struct rfkill_int_event {
 	struct rfkill_event_ext	ev;
 };
 
+/* Max rfkill events that can be "in-flight" for one data source */
+#define MAX_RFKILL_EVENT	1000
 struct rfkill_data {
 	struct list_head	list;
 	struct list_head	events;
 	struct mutex		mtx;
 	wait_queue_head_t	read_wait;
+	u32			event_count;
 	bool			input_handler;
 	u8			max_size;
 };
@@ -255,10 +258,12 @@ static void rfkill_global_led_trigger_unregister(void)
 }
 #endif /* CONFIG_RFKILL_LEDS */
 
-static void rfkill_fill_event(struct rfkill_event_ext *ev,
-			      struct rfkill *rfkill,
-			      enum rfkill_operation op)
+static int rfkill_fill_event(struct rfkill_int_event *int_ev,
+			     struct rfkill *rfkill,
+			     struct rfkill_data *data,
+			     enum rfkill_operation op)
 {
+	struct rfkill_event_ext *ev = &int_ev->ev;
 	unsigned long flags;
 
 	ev->idx = rfkill->idx;
@@ -271,6 +276,15 @@ static void rfkill_fill_event(struct rfkill_event_ext *ev,
 					RFKILL_BLOCK_SW_PREV));
 	ev->hard_block_reasons = rfkill->hard_block_reasons;
 	spin_unlock_irqrestore(&rfkill->lock, flags);
+
+	scoped_guard(mutex, &data->mtx) {
+		if (data->event_count++ > MAX_RFKILL_EVENT) {
+			data->event_count--;
+			return -ENOSPC;
+		}
+		list_add_tail(&int_ev->list, &data->events);
+	}
+	return 0;
 }
 
 static void rfkill_send_events(struct rfkill *rfkill, enum rfkill_operation op)
@@ -282,10 +296,10 @@ static void rfkill_send_events(struct rfkill *rfkill, enum rfkill_operation op)
 		ev = kzalloc_obj(*ev);
 		if (!ev)
 			continue;
-		rfkill_fill_event(&ev->ev, rfkill, op);
-		mutex_lock(&data->mtx);
-		list_add_tail(&ev->list, &data->events);
-		mutex_unlock(&data->mtx);
+		if (rfkill_fill_event(ev, rfkill, data, op)) {
+			kfree(ev);
+			continue;
+		}
 		wake_up_interruptible(&data->read_wait);
 	}
 }
@@ -1186,10 +1200,8 @@ static int rfkill_fop_open(struct inode *inode, struct file *file)
 		if (!ev)
 			goto free;
 		rfkill_sync(rfkill);
-		rfkill_fill_event(&ev->ev, rfkill, RFKILL_OP_ADD);
-		mutex_lock(&data->mtx);
-		list_add_tail(&ev->list, &data->events);
-		mutex_unlock(&data->mtx);
+		if (rfkill_fill_event(ev, rfkill, data, RFKILL_OP_ADD))
+			kfree(ev);
 	}
 	list_add(&data->list, &rfkill_fds);
 	mutex_unlock(&rfkill_global_mutex);
@@ -1259,6 +1271,7 @@ static ssize_t rfkill_fop_read(struct file *file, char __user *buf,
 		ret = -EFAULT;
 
 	list_del(&ev->list);
+	data->event_count--;
 	kfree(ev);
  out:
 	mutex_unlock(&data->mtx);


