Return-Path: <stable+bounces-236482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBoxHG4a3WknaAkAu9opvQ
	(envelope-from <stable+bounces-236482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:31:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E193EF27E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6728230A7FF1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9712F8BC3;
	Mon, 13 Apr 2026 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KXbX3rSZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52E227280A;
	Mon, 13 Apr 2026 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097018; cv=none; b=kbf5hkZhZf4YF7hxdgCcwMRQNjtVBad4QiatZCt3sSfAygLu5dmfsn32Ot3ccHEpicC3bMu+LdxLqvuNs6Z6irp+wEHPTqcl/l20zlSMK4IxrjFMJN7gf9Fx8DKswDzAd8t/W1Ix0Gdw2D3WWdya0O5jYiTa3U6isz/IysdR2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097018; c=relaxed/simple;
	bh=mS/0s83RQ6odr6pcGZeiHHG2EV9CXBdcgiSEczftOWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ixp7G6Gy7IqQDn+kpKMabT/WbI3RkWHNgzkuYxCJX2PFMsGa714fERi7tDYLFIEfO20RXq+c8Av/AQBA5jS4bFmaGcohbYkixNGjNI7zooEKxxTy413aQFu0128FUCioF9RzYMeMEM+ApOlVmmWwPK/tOJp7712t7UWJChfdH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KXbX3rSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB4CC2BCAF;
	Mon, 13 Apr 2026 16:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097018;
	bh=mS/0s83RQ6odr6pcGZeiHHG2EV9CXBdcgiSEczftOWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXbX3rSZPKXxcWAARb460dRiwUXGqIeB3kFu9/Toq9x5IrevVL911gEDJ7wqVKCAH
	 qKb6xbCGufvXxTcgck/Z1laJieksRFT0UdGGZhhmQwusAxkpOXBvBl49jQ8JsGYW8m
	 NoGEymbk49sCupuuswLRpTgAnysJb6PJANeoXk24=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	stable <stable@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 31/55] net: rfkill: prevent unlimited numbers of rfkill events from being created
Date: Mon, 13 Apr 2026 18:01:05 +0200
Message-ID: <20260413155725.997369348@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155724.820472494@linuxfoundation.org>
References: <20260413155724.820472494@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,sipsolutions.net,gmail.com,lzu.edu.cn,kernel.org,intel.com];
	TAGGED_FROM(0.00)[bounces-236482-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,lzu.edu.cn:email]
X-Rspamd-Queue-Id: E6E193EF27E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rfkill/core.c |   35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

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
@@ -255,10 +258,12 @@ static void rfkill_global_led_trigger_un
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
@@ -271,6 +276,15 @@ static void rfkill_fill_event(struct rfk
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
@@ -282,10 +296,10 @@ static void rfkill_send_events(struct rf
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
@@ -1190,10 +1204,8 @@ static int rfkill_fop_open(struct inode
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
@@ -1263,6 +1275,7 @@ static ssize_t rfkill_fop_read(struct fi
 		ret = -EFAULT;
 
 	list_del(&ev->list);
+	data->event_count--;
 	kfree(ev);
  out:
 	mutex_unlock(&data->mtx);



