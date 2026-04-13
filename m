Return-Path: <stable+bounces-237680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH4LHwh53WnbegkAu9opvQ
	(envelope-from <stable+bounces-237680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 01:15:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5DE3F4384
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 01:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDD363037924
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA1738F252;
	Mon, 13 Apr 2026 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="snCHToem"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE51E39BFEE
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 23:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776122105; cv=none; b=U6dZMZ2GaxP17BYbVyJ/sMWloaZZwCPsiw9+w1TQbPUfHdq24lVr+megpeDHi87hDjkJOSxHBORJ/t8IWPZweAFvM9i1dhi6m/WCUsJRP7U27CwUWMWFBPQyzyvRNByylK+WNw0ymZZOBJzZ6c2qlllRHeDbgez4KTzsMAAj0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776122105; c=relaxed/simple;
	bh=odUwFKZqVkmaHYeZHMJZwMcjHgpBX3ifthapjPgmdAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7DJ0COj03mdysvpm95JdMkf0AOrozaU/kdszIO5rIMM1Bu3GDP8UaHH0lbHTW4YWF1JCyoFUpHrIEupyrAvfE8tfCW2N/FEEE3Xp3qpx3mT04BcokPYX79tF74U9ZFH2TG9n8nMcJPPhCL0BaBUKRpJSSktbVHgESgO1og/B54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=snCHToem; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vQojenoEU6gPMeLrURhoL0JfwoF17OC42y2WrR7rzjs=; b=snCHToemVPuzzY+KMshaoBaaiq
	DsnwpbXDoiZSk5FLSKFSOv7a7cJFe7EVPD7ZYeNrMz6PMdbNj+dxFJJmOcyFDOaO27bS3QX7Q5ygw
	s5yuTfYRVm0ABpk5qcfvv6lQt8WG+nYrvaUJGVuZD40rv6KvZMb1QqcbsvEzywF71+Bn/JN6BIDB1
	nBi/9KsEmBEdklQs21bnucySnFxvBgtAuWf3f9heLaKyyEKwXvrDzGMTMcE1ct77YbpJcshL9RQeK
	a6IIkaVTQS7WbiETpap1OdPGsNjQ+lNR2ImI0cp0Z51lIaHYxTlPOmBo1VayuAOHFHOvpPkib+q1k
	MWIcp6lw==;
Received: from 186-249-145-49.shared.desktop.com.br ([186.249.145.49] helo=t470)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wCQUf-00Fdt7-5y; Tue, 14 Apr 2026 01:15:01 +0200
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH 6.12.y 2/2] thermal: core: Address thermal zone removal races with resume
Date: Mon, 13 Apr 2026 20:14:51 -0300
Message-ID: <20260413231451.357918-3-mfo@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413231451.357918-1-mfo@igalia.com>
References: <2026040820-overpass-barrette-bf09@gregkh>
 <20260413231451.357918-1-mfo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237680-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mfo@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-0.149];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,arm.com:email,msgid.link:url,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzbot.org:url]
X-Rspamd-Queue-Id: EE5DE3F4384
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 45b859b0728267a6199ee5002d62e6c6f3e8c89d ]

Since thermal_zone_pm_complete() and thermal_zone_device_resume()
re-initialize the poll_queue delayed work for the given thermal zone,
the cancel_delayed_work_sync() in thermal_zone_device_unregister()
may miss some already running work items and the thermal zone may
be freed prematurely [1].

There are two failing scenarios that both start with
running thermal_pm_notify_complete() right before invoking
thermal_zone_device_unregister() for one of the thermal zones.

In the first scenario, there is a work item already running for
the given thermal zone when thermal_pm_notify_complete() calls
thermal_zone_pm_complete() for that thermal zone and it continues to
run when thermal_zone_device_unregister() starts.  Since the poll_queue
delayed work has been re-initialized by thermal_pm_notify_complete(), the
running work item will be missed by the cancel_delayed_work_sync() in
thermal_zone_device_unregister() and if it continues to run past the
freeing of the thermal zone object, a use-after-free will occur.

In the second scenario, thermal_zone_device_resume() queued up by
thermal_pm_notify_complete() runs right after the thermal_zone_exit()
called by thermal_zone_device_unregister() has returned.  The poll_queue
delayed work is re-initialized by it before cancel_delayed_work_sync() is
called by thermal_zone_device_unregister(), so it may continue to run
after the freeing of the thermal zone object, which also leads to a
use-after-free.

Address the first failing scenario by ensuring that no thermal work
items will be running when thermal_pm_notify_complete() is called.
For this purpose, first move the cancel_delayed_work() call from
thermal_zone_pm_complete() to thermal_zone_pm_prepare() to prevent
new work from entering the workqueue going forward.  Next, switch
over to using a dedicated workqueue for thermal events and update
the code in thermal_pm_notify() to flush that workqueue after
thermal_pm_notify_prepare() has returned which will take care of
all leftover thermal work already on the workqueue (that leftover
work would do nothing useful anyway because all of the thermal zones
have been flagged as suspended).

The second failing scenario is addressed by adding a tz->state check
to thermal_zone_device_resume() to prevent it from re-initializing
the poll_queue delayed work if the thermal zone is going away.

Note that the above changes will also facilitate relocating the suspend
and resume of thermal zones closer to the suspend and resume of devices,
respectively.

Fixes: 5a5efdaffda5 ("thermal: core: Resume thermal zones asynchronously")
Reported-by: syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=3b3852c6031d0f30dfaf
Reported-by: Mauricio Faria de Oliveira <mfo@igalia.com>
Closes: https://lore.kernel.org/linux-pm/20260324-thermal-core-uaf-init_delayed_work-v1-1-6611ae76a8a1@igalia.com/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mauricio Faria de Oliveira <mfo@igalia.com>
Tested-by: Mauricio Faria de Oliveira <mfo@igalia.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Cc: All applicable <stable@vger.kernel.org>
Link: https://patch.msgid.link/6267615.lOV4Wx5bFT@rafael.j.wysocki
[ mfo: backport for 6.12.y:
  - No guard() or thermal_pm_notify_{prepare,complete}() for the lack of
    commit d1c8aa2a5c5c ("thermal: core: Manage thermal_list_lock using a mutex guard")
    - thermal_zone_device_resume() calls mutex_unlock() to return;
    - thermal_pm_notify() has thermal_pm_notify_prepare() in *_PREPARE;
  - No WQ_PERCPU flag in alloc_workqueue(), introduced in v6.17. ]
Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 drivers/thermal/thermal_core.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4663ca7a587c..8ce1134e15e5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -42,6 +42,8 @@ static struct thermal_governor *def_governor;
 
 static bool thermal_pm_suspended;
 
+static struct workqueue_struct *thermal_wq __ro_after_init;
+
 /*
  * Governor section: set of functions to handle thermal governors
  *
@@ -328,7 +330,7 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 	if (delay > HZ)
 		delay = round_jiffies_relative(delay);
 
-	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, delay);
+	mod_delayed_work(thermal_wq, &tz->poll_queue, delay);
 }
 
 static void thermal_zone_recheck(struct thermal_zone_device *tz, int error)
@@ -1691,6 +1693,12 @@ static void thermal_zone_device_resume(struct work_struct *work)
 
 	mutex_lock(&tz->lock);
 
+	/* If the thermal zone is going away, there's nothing to do. */
+	if (tz->state & TZ_STATE_FLAG_EXIT) {
+		mutex_unlock(&tz->lock);
+		return;
+	}
+
 	tz->state &= ~(TZ_STATE_FLAG_SUSPENDED | TZ_STATE_FLAG_RESUMING);
 
 	thermal_debug_tz_resume(tz);
@@ -1722,6 +1730,9 @@ static void thermal_zone_pm_prepare(struct thermal_zone_device *tz)
 
 	tz->state |= TZ_STATE_FLAG_SUSPENDED;
 
+	/* Prevent new work from getting to the workqueue subsequently. */
+	cancel_delayed_work(&tz->poll_queue);
+
 	mutex_unlock(&tz->lock);
 }
 
@@ -1729,8 +1740,6 @@ static void thermal_zone_pm_complete(struct thermal_zone_device *tz)
 {
 	mutex_lock(&tz->lock);
 
-	cancel_delayed_work(&tz->poll_queue);
-
 	reinit_completion(&tz->resume);
 	tz->state |= TZ_STATE_FLAG_RESUMING;
 
@@ -1740,7 +1749,7 @@ static void thermal_zone_pm_complete(struct thermal_zone_device *tz)
 	 */
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_resume);
 	/* Queue up the work without a delay. */
-	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, 0);
+	mod_delayed_work(thermal_wq, &tz->poll_queue, 0);
 
 	mutex_unlock(&tz->lock);
 }
@@ -1762,6 +1771,11 @@ static int thermal_pm_notify(struct notifier_block *nb,
 			thermal_zone_pm_prepare(tz);
 
 		mutex_unlock(&thermal_list_lock);
+		/*
+		 * Allow any leftover thermal work items already on the
+		 * worqueue to complete so they don't get in the way later.
+		 */
+		flush_workqueue(thermal_wq);
 		break;
 	case PM_POST_HIBERNATION:
 	case PM_POST_RESTORE:
@@ -1801,9 +1815,16 @@ static int __init thermal_init(void)
 	if (result)
 		goto error;
 
+	thermal_wq = alloc_workqueue("thermal_events",
+				      WQ_FREEZABLE | WQ_POWER_EFFICIENT, 0);
+	if (!thermal_wq) {
+		result = -ENOMEM;
+		goto unregister_netlink;
+	}
+
 	result = thermal_register_governors();
 	if (result)
-		goto unregister_netlink;
+		goto destroy_workqueue;
 
 	thermal_class = kzalloc(sizeof(*thermal_class), GFP_KERNEL);
 	if (!thermal_class) {
@@ -1830,6 +1851,8 @@ static int __init thermal_init(void)
 
 unregister_governors:
 	thermal_unregister_governors();
+destroy_workqueue:
+	destroy_workqueue(thermal_wq);
 unregister_netlink:
 	thermal_netlink_exit();
 error:
-- 
2.51.0


