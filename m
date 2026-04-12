Return-Path: <stable+bounces-235831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id K1O7IRLP22kaHAkAu9opvQ
	(envelope-from <stable+bounces-235831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 18:57:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D393E4F44
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 18:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDD203014110
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D382F12CF;
	Sun, 12 Apr 2026 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVugMQqt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B192C11D6
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776013069; cv=none; b=FJkxmtNNpggNtH5ez2iXuqHmWCvYIpp6euqqaWR6+A904bYdb+xgniSiwavqNs2z/fogOEPMOnU12MhNXeb0Ujl2D3LJx2eyqd9Bbr21CrSBs6FKsY9iv4sbgQTkxR3qTl4DBAaTZTjVTI+Jr64RNIPBM4uWH4y6j+BSO+0JnA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776013069; c=relaxed/simple;
	bh=Qhknvl29n/MlucxgPim0Q+U/iID37WHLextIcOSIVVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oj62N4zQwi68+9aQKiQF3AWFBqx+JyRKtbOjqJBuMXQLSCD7ni+Nj222OPYI+SDo+yLWUh+bd1yGqx1gjaXL/lv03PDIcnSMittkrBMkh9CdUd7bZyd5c4wKVFP6CsDFBMEQThxYv20SfYZIA+F2WGExLe3X/PWvzUTJ2anLtQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVugMQqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46577C19424;
	Sun, 12 Apr 2026 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776013069;
	bh=Qhknvl29n/MlucxgPim0Q+U/iID37WHLextIcOSIVVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YVugMQqtDJ1HAeq34txYKw9314I23a7GEiSO6jtiTnHvGYMhLHMZNfgH1aZf5og3a
	 JRPJ/BiknEkbvOoJAB/plS4rFozeENOvZKYiSj8jdPqd+KAODka2y9QBhBqhRh4rhX
	 iGOuMbMN4x/IAb4AueTHeJQlsSEFb7gp1K1ab36shfQIrkJ+KOYXlnTZ3YtM0BqWt/
	 dK06B9Cf36t/C6dqZOrcDntu//8XKLLuUDWw6Ikjw7FCRlVVrw9/7jbrvPpXEy/Vbz
	 4KA/083kqGUVBpfjmNPOhXLCTcQm6HJsLFatWHGN1RExp2vuqHCV6I0Wp6XqgRqtzV
	 ilaSIfjH/KkAQ==
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
Subject: [PATCH 5.15.y] net: rfkill: prevent unlimited numbers of rfkill events from being created
Date: Sun, 12 Apr 2026 12:57:46 -0400
Message-ID: <20260412165746.2348467-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041216-voltage-rewrap-e053@gregkh>
References: <2026041216-voltage-rewrap-e053@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,sipsolutions.net,gmail.com,lzu.edu.cn,kernel.org,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235831-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 96D393E4F44
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
[ replaced `scoped_guard()` with explicit `mutex_lock()`/`mutex_unlock()` calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rfkill/core.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 068c7bcd30c94..7bcb7a9c1fcfd 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -72,11 +72,14 @@ struct rfkill_int_event {
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
@@ -254,10 +257,12 @@ static void rfkill_global_led_trigger_unregister(void)
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
@@ -270,6 +275,16 @@ static void rfkill_fill_event(struct rfkill_event_ext *ev,
 					RFKILL_BLOCK_SW_PREV));
 	ev->hard_block_reasons = rfkill->hard_block_reasons;
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
@@ -281,10 +296,10 @@ static void rfkill_send_events(struct rfkill *rfkill, enum rfkill_operation op)
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
@@ -1149,7 +1164,6 @@ static int rfkill_fop_open(struct inode *inode, struct file *file)
 	init_waitqueue_head(&data->read_wait);
 
 	mutex_lock(&rfkill_global_mutex);
-	mutex_lock(&data->mtx);
 	/*
 	 * start getting events from elsewhere but hold mtx to get
 	 * startup events added first
@@ -1159,11 +1173,10 @@ static int rfkill_fop_open(struct inode *inode, struct file *file)
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
@@ -1171,7 +1184,6 @@ static int rfkill_fop_open(struct inode *inode, struct file *file)
 	return stream_open(inode, file);
 
  free:
-	mutex_unlock(&data->mtx);
 	mutex_unlock(&rfkill_global_mutex);
 	mutex_destroy(&data->mtx);
 	list_for_each_entry_safe(ev, tmp, &data->events, list)
@@ -1232,6 +1244,7 @@ static ssize_t rfkill_fop_read(struct file *file, char __user *buf,
 		ret = -EFAULT;
 
 	list_del(&ev->list);
+	data->event_count--;
 	kfree(ev);
  out:
 	mutex_unlock(&data->mtx);
-- 
2.53.0


