Return-Path: <stable+bounces-235850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBZCF4b622mbKAkAu9opvQ
	(envelope-from <stable+bounces-235850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 22:03:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 630143E5D13
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 22:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C70C3002910
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 20:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E551C23D281;
	Sun, 12 Apr 2026 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVwMWTNz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A966C3D994
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776024191; cv=none; b=nNab8H+3WZsGZrUkRxCp9UkT9h51LMPM1/6tNF/TC755lqwiTYtczr0GyiZE8XbgGVXoI/aK/AzTsJxitCMimVmLNSR72IBMf/cOHBXJlkWey4waEtFiUHRR0pT36CCOWso7ZhPGVJRvETNaY5PE2wNONQknVD1SrR9PeD1clGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776024191; c=relaxed/simple;
	bh=JbGP0qDfeQdLmFgeh0rJknznPOIMSRh7RoyWG0O6XMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpOdc03Qdp5DPUmz1VSZZCtspUbUnzos/8vyKB6f13kP5Q42FoQGAUls6FyLfg4M10qU9XmMtwUmSXL7xfM1j5njoxtxkM4PlPcZc1I5i7IUPCBwJJA1bhIZ3+B25t806b6zhU2YgZFdPq1/wJf/Ajwljq/1R9cFivFN1c26CCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVwMWTNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3BBC19424;
	Sun, 12 Apr 2026 20:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776024191;
	bh=JbGP0qDfeQdLmFgeh0rJknznPOIMSRh7RoyWG0O6XMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qVwMWTNzH8MSs9LDQbfQdNjY8/raHz8m65bvJoKU/D/nFqGSRL5vDS/KsJkAKA+Lf
	 FObbPQDdhJSdKlVcNABlKYlBt20nUoFBje7ao0vRN05TGy6I3J7BVwMxO4nW6MDe/i
	 W2Z61VvsVY35RnQuopDZHeMojU7cbYaq9Pe5lfHnLne67sSEBjhTA7JeTGtXjiXs/S
	 DOLcH7TvjcGOp7LPXaUaq2RjA7RPARmbCdFEh8jRe1ppCd+jmJx22fN/PcqyOI8fPD
	 9snbG1EvOUvKtYLq9Ii/nOgvrpoikltjUp8agMHSrWUcSI5H4ACOC5Pwh+nmO82GZ0
	 oVLYXymp8jcVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	stable <stable@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: rfkill: prevent unlimited numbers of rfkill events from being created
Date: Sun, 12 Apr 2026 16:03:08 -0400
Message-ID: <20260412200308.2406071-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041216-ideology-snowplow-e524@gregkh>
References: <2026041216-ideology-snowplow-e524@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,sipsolutions.net,gmail.com,lzu.edu.cn,kernel.org,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235850-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,sipsolutions.net:email,lzu.edu.cn:email,msgid.link:url]
X-Rspamd-Queue-Id: 630143E5D13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit ea245d78dec594372e27d8c79616baf49e98a4a1 ]

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
[ replaced `rfkill_event_ext` with `rfkill_event`, `scoped_guard` with explicit mutex calls, and removed outer `data->mtx` lock in `rfkill_fop_open` to avoid deadlock with new internal locking ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rfkill/core.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 97101c55763d7..7a39454b731a5 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -71,11 +71,14 @@ struct rfkill_int_event {
 	struct rfkill_event	ev;
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
 };
 
@@ -252,9 +255,12 @@ static void rfkill_global_led_trigger_unregister(void)
 }
 #endif /* CONFIG_RFKILL_LEDS */
 
-static void rfkill_fill_event(struct rfkill_event *ev, struct rfkill *rfkill,
-			      enum rfkill_operation op)
+static int rfkill_fill_event(struct rfkill_int_event *int_ev,
+			     struct rfkill *rfkill,
+			     struct rfkill_data *data,
+			     enum rfkill_operation op)
 {
+	struct rfkill_event *ev = &int_ev->ev;
 	unsigned long flags;
 
 	ev->idx = rfkill->idx;
@@ -266,6 +272,16 @@ static void rfkill_fill_event(struct rfkill_event *ev, struct rfkill *rfkill,
 	ev->soft = !!(rfkill->state & (RFKILL_BLOCK_SW |
 					RFKILL_BLOCK_SW_PREV));
 	spin_unlock_irqrestore(&rfkill->lock, flags);
+
+	mutex_lock(&data->mtx);
+	if (data->event_count++ > MAX_RFKILL_EVENT) {
+		data->event_count--;
+		mutex_unlock(&data->mtx);
+		return -ENOSPC;
+	}
+	list_add_tail(&int_ev->list, &data->events);
+	mutex_unlock(&data->mtx);
+	return 0;
 }
 
 static void rfkill_send_events(struct rfkill *rfkill, enum rfkill_operation op)
@@ -277,10 +293,10 @@ static void rfkill_send_events(struct rfkill *rfkill, enum rfkill_operation op)
 		ev = kzalloc(sizeof(*ev), GFP_KERNEL);
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
@@ -1118,21 +1134,19 @@ static int rfkill_fop_open(struct inode *inode, struct file *file)
 	init_waitqueue_head(&data->read_wait);
 
 	mutex_lock(&rfkill_global_mutex);
-	mutex_lock(&data->mtx);
 	/*
-	 * start getting events from elsewhere but hold mtx to get
-	 * startup events added first
+	 * start getting events from elsewhere but hold rfkill_global_mutex
+	 * to get startup events added first
 	 */
 
 	list_for_each_entry(rfkill, &rfkill_list, node) {
 		ev = kzalloc(sizeof(*ev), GFP_KERNEL);
 		if (!ev)
 			goto free;
-		rfkill_fill_event(&ev->ev, rfkill, RFKILL_OP_ADD);
-		list_add_tail(&ev->list, &data->events);
+		if (rfkill_fill_event(ev, rfkill, data, RFKILL_OP_ADD))
+			kfree(ev);
 	}
 	list_add(&data->list, &rfkill_fds);
-	mutex_unlock(&data->mtx);
 	mutex_unlock(&rfkill_global_mutex);
 
 	file->private_data = data;
@@ -1140,7 +1154,6 @@ static int rfkill_fop_open(struct inode *inode, struct file *file)
 	return stream_open(inode, file);
 
  free:
-	mutex_unlock(&data->mtx);
 	mutex_unlock(&rfkill_global_mutex);
 	mutex_destroy(&data->mtx);
 	list_for_each_entry_safe(ev, tmp, &data->events, list)
@@ -1200,6 +1213,7 @@ static ssize_t rfkill_fop_read(struct file *file, char __user *buf,
 		ret = -EFAULT;
 
 	list_del(&ev->list);
+	data->event_count--;
 	kfree(ev);
  out:
 	mutex_unlock(&data->mtx);
-- 
2.53.0


