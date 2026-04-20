Return-Path: <stable+bounces-238700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJvMN3XC5WmnnwEAu9opvQ
	(envelope-from <stable+bounces-238700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 08:06:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E59642702C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 08:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87677300C5B7
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 06:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B846037EFEE;
	Mon, 20 Apr 2026 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="k2SKip8x"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2895F25D53B
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 06:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665202; cv=none; b=uSTGIUJtpkSByGlIQ3vpNHNSI8ssHNmKf+m36ZNBJ/gEMp5GIgzMljI/snwuW+GTEpTvc5fKXfF59tJrrtYVw+NWUtyF6SptS0AekT2bFHprJR1r7xyep+itujHWvl3KHAdXD45I3GKpSP23kOkUuc31yt7umfSyIwq4h/G3050=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665202; c=relaxed/simple;
	bh=o9VyHHljdlNryQxgGpX/rIFtgqHL6AXLc8VCdQZtJUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eRsRh478xI1cXTw5VoskKFsPkI4lhZlkhPCs1qLgsrt6E9FQzVUdQObnxuhtHq0bwJYAet0+cuJ3HPufVbwSMwhG9tf3wU1o55fHY/E9RsJetWzawc224KCLoQfnXOYl+xCy4MTerUbPB9beSGpDooU7vT39e3Yj8iaFepj/Ds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=k2SKip8x; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35e563b0ee7so1196029a91.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 23:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1776665199; x=1777269999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sbHCUNdavsi9m4FkYItkV2uwfkFJaRWF7u5PuSyGeu8=;
        b=k2SKip8xU1lDGEOVv9gHsepsT/agF+sar6U9mGEnC7datNI8gbFlifYZK3c5+DEpLL
         Yq3lgPs6uCO5FUbYM2CF3AwmDD4LrDKmO+PQh1V0BmzAdYb9c848zoSVPOnjDFDR+UEp
         BvbTiu4D7xnNPIH9+TYPy6S6cIevgCYkgEtzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776665199; x=1777269999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbHCUNdavsi9m4FkYItkV2uwfkFJaRWF7u5PuSyGeu8=;
        b=mtzn8vKm81YT2OPFcvExfdSA8JgDinUChoz+pHqAQJDXK5Pel9f/Uc2gMZzhEJPLPG
         YvococtVN5j3nDIkhqmqxClUuiiSj6Iq3SbxVK6ynF6qa7lVB9o1UT/H8saMI7kr7uH4
         gASYK2mjyQXl9h6SlnXT8iMCaGpZpToYx3fQ+qBCzLoKGBvG8aJaCODbdRtpoRy3e8jG
         GhM79FGrJ8QyK55tByM69G4RTvwRmH+yDuZMfb8Jdg3G58pbw4ZJLOZPjUX5n7Anhl5e
         /7MGHBfOMrwBzfIWWIFx375UvkpjhOJo0OyJWb27rI2//Bh3ebRC93jLOPQ4r5dIM7uV
         KhAg==
X-Forwarded-Encrypted: i=1; AFNElJ+kag3NL9EhDg/7LgmjQ23a52c6KH34MEuIZa88pkgHVcNlRrB3xJY2+FdBniheKUQ06ehLExs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/UBPKTexFOwZlh7+SF9+DiwV7wed2raYqbSyX/h2SzBfrNUO5
	vAq+tGnbH9qgjdG+/noGhSnNUhWPV9OTPB3shIHY06+gfWEsDRTnu1S0j3eMY64XDCRzHOPfS58
	3zDFv3aw=
X-Gm-Gg: AeBDiev7x96Kf7tsC6VhgE4CIfT+pUJqMg8VKCXEr3oP3n8J04TxQab6OuGpbYUD2Yw
	wzO7PAom5Jg85QO9Oi6KO+iYnF+Ql883LU5PC+yqvnNqgC4Ur9YrGa0GQP352b/dx6cIgKU4dlJ
	BtEM9YbW5NbshYeb77rwEqgO5VFJWNqZ1CUSkznkHPwJJhiFJW4S9b4hnmMcHpsahLcka2dSa2H
	T0G8zM00sG4cknt8qqlBcQXUoLi7clYYI6PgirDPNCHHxk1dICDc/Q7vTNSkkkpHbpYVyhPlqW/
	5/OpTHlQToWLDk7I/Z377RFakd7AwCgdyVegCB3H7vYLZDxfFFdMwM523BOCMYLvCcs/Ca8k8eZ
	E+CiEujwRuBN/pr3mBC9MJo0N7myQ4EFoQZ9YYE4XX5GRvYjNln8wWeqjaD2xgYQUo0nWmO8TlP
	bWJb10zPb0uxGJE/SyDgWIf3DCMI8eUI1orJIeKAatB1VLCx3g39rgaPf+rYCFT4FOCpnNsA==
X-Received: by 2002:a17:90b:1e10:b0:35f:c6bf:2bba with SMTP id 98e67ed59e1d1-36140299a0dmr12086964a91.11.1776665199511;
        Sun, 19 Apr 2026 23:06:39 -0700 (PDT)
Received: from nunu.. (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a8f0sm9082277a91.12.2026.04.19.23.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 23:06:39 -0700 (PDT)
From: Sangyun Kim <sangyun.kim@snu.ac.kr>
To: Mike Isely <isely@pobox.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Edward Adam Davis <eadavis@qq.com>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: pvrusb2: fix disconnect and teardown races
Date: Mon, 20 Apr 2026 15:06:21 +0900
Message-Id: <20260420060621.1627352-1-sangyun.kim@snu.ac.kr>
X-Mailer: git-send-email 2.34.1
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
	DMARC_POLICY_ALLOW(-0.50)[snu.ac.kr,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[snu.ac.kr:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238700-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[pobox.com,kernel.org,qq.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sangyun.kim@snu.ac.kr,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[snu.ac.kr:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3E59642702C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pvr2_context_disconnect() queues a notification to the pvrusb2-context
kthread before it stores mp->disconnect_flag:

    pvr2_hdw_disconnect(mp->hdw);
    if (!pvr2_context_shutok())
        pvr2_context_notify(mp);
    mp->disconnect_flag = !0;

The context thread only destroys a context when disconnect_flag is set
and mc_first is NULL. If the notification wakes the thread before the
flag store becomes visible, the thread dequeues the context, runs
pvr2_context_check() with disconnect_flag still observed as 0, decides
that the destroy condition is not met yet, and goes back to sleep.
Nothing wakes the thread again once the flag is finally stored, so the
context stays on the global exist list forever and
pvr2_context_global_done() blocks module unload. commit 0a0b79ea55de
("media: pvrusb2: fix uaf in pvr2_context_set_notify") made this
liveness failure easier to hit by moving the notify earlier in the
disconnect path.

The same teardown sequence still contains a use-after-free.
pvr2_context_exit() inspects disconnect_flag after releasing mp->mutex
and may then call pvr2_context_notify(mp) after the context thread has
already freed the object via pvr2_context_destroy()/kfree(). The hdw
completion callback registered through pvr2_hdw_initialize() can race
the same way. Reordering the disconnect path alone closes the unload
hang, but it still leaves late notifiers able to touch freed memory.

Fix both problems together:

- Split pvr2_context_set_notify() into a locked helper
  (pvr2_context_set_notify_locked()) and a wrapper that acquires
  pvr2_context_mutex. This lets callers update several pieces of
  related state inside a single critical section without relocking.

- In pvr2_context_disconnect(), set disconnect_flag and enqueue the
  thread notification under pvr2_context_mutex. The context thread
  manipulates the notify list under the same mutex, so when it observes
  the queued entry it is guaranteed to observe disconnect_flag = 1 as
  well and the destroy condition evaluates correctly. This eliminates
  the original notify-before-flag liveness hole.

- Add a per-context refcount_t. pvr2_context_create() initialises it to
  1 (creator reference). pvr2_channel_init() and pvr2_channel_done()
  take and drop a reference around each channel's lifetime.
  pvr2_context_disconnect() takes a temporary reference across its body
  so the context cannot be freed while disconnect is still touching it.
  pvr2_context_destroy() no longer calls kfree() directly; it drops its
  reference via pvr2_context_put(), and whichever caller drops the last
  reference performs the actual kfree. This keeps the object alive
  until disconnect and the final channel teardown finish, regardless of
  how the context thread, channel close, and USB disconnect paths
  interleave.

- Add a destroying_flag that pvr2_context_destroy() sets under
  pvr2_context_mutex before unlinking the context from the notify and
  exist lists. pvr2_context_set_notify_locked() refuses to re-enqueue a
  context whose destroying_flag is set, so a late notifier arriving
  after destroy has started cannot resurrect the context on the notify
  list. The dequeue path (fl == 0) still proceeds unconditionally
  because destroy itself must be able to remove any still-queued entry.

- Update pvr2_context_exit() to enqueue through
  pvr2_context_set_notify_locked() after releasing mp->mutex. The
  caller (channel close or disconnect) always holds a reference, so the
  object is stable across the mp->mutex / pvr2_context_mutex hand-off
  and a concurrent destroy cannot free it under us. If destroy has
  already won the race, destroying_flag short-circuits the enqueue into
  a no-op.

Lock ordering: pvr2_context_mutex is only acquired after mp->mutex is
released; no path holds pvr2_context_mutex while acquiring mp->mutex,
so no AB/BA deadlock is introduced. wake_up() on
pvr2_context_sync_data is moved outside pvr2_context_mutex in every
path that grew a new locked section, matching the existing style.

Fixes: 0a0b79ea55de ("media: pvrusb2: fix uaf in pvr2_context_set_notify")
Cc: stable@vger.kernel.org
Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
---
 drivers/media/usb/pvrusb2/pvrusb2-context.c | 56 ++++++++++++++++++---
 drivers/media/usb/pvrusb2/pvrusb2-context.h |  3 ++
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
index 93f5da65ead9..fb9bdbf5c886 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
@@ -27,11 +27,19 @@ static int pvr2_context_cleaned_flag;
 static struct task_struct *pvr2_context_thread_ptr;
 
 
-static void pvr2_context_set_notify(struct pvr2_context *mp, int fl)
+static void pvr2_context_put(struct pvr2_context *mp)
+{
+	if (refcount_dec_and_test(&mp->refcount))
+		kfree(mp);
+}
+
+static int pvr2_context_set_notify_locked(struct pvr2_context *mp, int fl)
 {
 	int signal_flag = 0;
-	mutex_lock(&pvr2_context_mutex);
+
 	if (fl) {
+		if (mp->destroying_flag)
+			return 0;
 		if (!mp->notify_flag) {
 			signal_flag = (pvr2_context_notify_first == NULL);
 			mp->notify_prev = pvr2_context_notify_last;
@@ -59,6 +67,15 @@ static void pvr2_context_set_notify(struct pvr2_context *mp, int fl)
 			}
 		}
 	}
+	return signal_flag;
+}
+
+static void pvr2_context_set_notify(struct pvr2_context *mp, int fl)
+{
+	int signal_flag = 0;
+
+	mutex_lock(&pvr2_context_mutex);
+	signal_flag = pvr2_context_set_notify_locked(mp, fl);
 	mutex_unlock(&pvr2_context_mutex);
 	if (signal_flag) wake_up(&pvr2_context_sync_data);
 }
@@ -66,10 +83,13 @@ static void pvr2_context_set_notify(struct pvr2_context *mp, int fl)
 
 static void pvr2_context_destroy(struct pvr2_context *mp)
 {
+	int signal_flag = 0;
+
 	pvr2_trace(PVR2_TRACE_CTXT,"pvr2_context %p (destroy)",mp);
 	pvr2_hdw_destroy(mp->hdw);
-	pvr2_context_set_notify(mp, 0);
 	mutex_lock(&pvr2_context_mutex);
+	mp->destroying_flag = !0;
+	pvr2_context_set_notify_locked(mp, 0);
 	if (mp->exist_next) {
 		mp->exist_next->exist_prev = mp->exist_prev;
 	} else {
@@ -83,10 +103,12 @@ static void pvr2_context_destroy(struct pvr2_context *mp)
 	if (!pvr2_context_exist_first) {
 		/* Trigger wakeup on control thread in case it is waiting
 		   for an exit condition. */
-		wake_up(&pvr2_context_sync_data);
+		signal_flag = !0;
 	}
 	mutex_unlock(&pvr2_context_mutex);
-	kfree(mp);
+	if (signal_flag)
+		wake_up(&pvr2_context_sync_data);
+	pvr2_context_put(mp);
 }
 
 
@@ -209,6 +231,7 @@ struct pvr2_context *pvr2_context_create(
 	pvr2_trace(PVR2_TRACE_CTXT,"pvr2_context %p (create)",mp);
 	mp->setup_func = setup_func;
 	mutex_init(&mp->mutex);
+	refcount_set(&mp->refcount, 1);
 	mutex_lock(&pvr2_context_mutex);
 	mp->exist_prev = pvr2_context_exist_last;
 	mp->exist_next = NULL;
@@ -256,25 +279,41 @@ static void pvr2_context_enter(struct pvr2_context *mp)
 static void pvr2_context_exit(struct pvr2_context *mp)
 {
 	int destroy_flag = 0;
+	int signal_flag = 0;
 	if (!(mp->mc_first || !mp->disconnect_flag)) {
 		destroy_flag = !0;
 	}
 	mutex_unlock(&mp->mutex);
-	if (destroy_flag) pvr2_context_notify(mp);
+	if (destroy_flag) {
+		mutex_lock(&pvr2_context_mutex);
+		signal_flag = pvr2_context_set_notify_locked(mp, !0);
+		mutex_unlock(&pvr2_context_mutex);
+		if (signal_flag)
+			wake_up(&pvr2_context_sync_data);
+	}
 }
 
 
 void pvr2_context_disconnect(struct pvr2_context *mp)
 {
+	int signal_flag = 0;
+
+	refcount_inc(&mp->refcount);
 	pvr2_hdw_disconnect(mp->hdw);
-	if (!pvr2_context_shutok())
-		pvr2_context_notify(mp);
+	mutex_lock(&pvr2_context_mutex);
 	mp->disconnect_flag = !0;
+	if (!pvr2_context_shutok())
+		signal_flag = pvr2_context_set_notify_locked(mp, !0);
+	mutex_unlock(&pvr2_context_mutex);
+	if (signal_flag)
+		wake_up(&pvr2_context_sync_data);
+	pvr2_context_put(mp);
 }
 
 
 void pvr2_channel_init(struct pvr2_channel *cp,struct pvr2_context *mp)
 {
+	refcount_inc(&mp->refcount);
 	pvr2_context_enter(mp);
 	cp->hdw = mp->hdw;
 	cp->mc_head = mp;
@@ -318,6 +357,7 @@ void pvr2_channel_done(struct pvr2_channel *cp)
 	}
 	cp->hdw = NULL;
 	pvr2_context_exit(mp);
+	pvr2_context_put(mp);
 }
 
 
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.h b/drivers/media/usb/pvrusb2/pvrusb2-context.h
index 5840b2ce8f1e..4e06530eccb8 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-context.h
+++ b/drivers/media/usb/pvrusb2/pvrusb2-context.h
@@ -7,6 +7,7 @@
 #define __PVRUSB2_CONTEXT_H
 
 #include <linux/mutex.h>
+#include <linux/refcount.h>
 #include <linux/usb.h>
 #include <linux/workqueue.h>
 
@@ -33,9 +34,11 @@ struct pvr2_context {
 	struct pvr2_hdw *hdw;
 	struct pvr2_context_stream video_stream;
 	struct mutex mutex;
+	refcount_t refcount;
 	int notify_flag;
 	int initialized_flag;
 	int disconnect_flag;
+	int destroying_flag;
 
 	/* Called after pvr2_context initialization is complete */
 	void (*setup_func)(struct pvr2_context *);
-- 
2.34.1


