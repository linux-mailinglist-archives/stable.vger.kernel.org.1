Return-Path: <stable+bounces-233792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IBSKv391Wn4/gcAu9opvQ
	(envelope-from <stable+bounces-233792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:04:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCBC3B7DB8
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0123F3040754
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B14364E88;
	Wed,  8 Apr 2026 07:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CCvInh3d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA393624B0
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 07:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631683; cv=none; b=a079nChqwcLR7BZEqxeI5S6syE/fRept4TszrC7+b0fXxicKffk54+4cvg8qFlLUPs95FnInCj+05z41B47FtFYO4sl7eYwZtCZdaypSf1mc4qZQPG600xAn1e7qne4UTXdPqCVu0IArkQK7XIz15mXRe+62oNARUnoqq0elsHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631683; c=relaxed/simple;
	bh=WCarG9efqnELBSzHSnbJFjTBG1xwn0jfQIgNatI67Q0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=knluO4Q8vlKRF5EZ0fWGVWRq9a7BdvZLi57/sxefjOcog0POerUDEYFc4xcUBN9EDzf7XNwZmMtnaTV2azAYkkgdgfjctOe64OXOOHYAdSdQdU7brGnN9eOQ6WfrnIefig5Sr0tEGV+id5uCG5m7RcJQGn9kYZqZqt0lzyAyMaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CCvInh3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C91C19424;
	Wed,  8 Apr 2026 07:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775631683;
	bh=WCarG9efqnELBSzHSnbJFjTBG1xwn0jfQIgNatI67Q0=;
	h=Subject:To:Cc:From:Date:From;
	b=CCvInh3dhLUQz7Cgtl0WZOPOFttsCYMGvypbqozq4a3UECxXSX1Z5pPMR9NM6VUh3
	 xICumQN/3wUp8sTPUPPGuWEwTLsZW1kRN1JKe9U5dIfCqyeT0pF1mEmmEw9dxvFXe7
	 mhtIPAR3x0FOsO/zVc8RxMytY/J3XIubOlNiOAHM=
Subject: FAILED: patch "[PATCH] thermal: core: Address thermal zone removal races with resume" failed to apply to 6.12-stable tree
To: rafael.j.wysocki@intel.com,lukasz.luba@arm.com,mfo@igalia.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 09:01:20 +0200
Message-ID: <2026040820-overpass-barrette-bf09@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233792-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,msgid.link:url,appspotmail.com:email,syzbot.org:url,igalia.com:email,arm.com:email]
X-Rspamd-Queue-Id: 0FCBC3B7DB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 45b859b0728267a6199ee5002d62e6c6f3e8c89d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040820-overpass-barrette-bf09@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 45b859b0728267a6199ee5002d62e6c6f3e8c89d Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Fri, 27 Mar 2026 10:49:52 +0100
Subject: [PATCH] thermal: core: Address thermal zone removal races with resume

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

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b7d706ed7ed9..5337612e484d 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -41,6 +41,8 @@ static struct thermal_governor *def_governor;
 
 static bool thermal_pm_suspended;
 
+static struct workqueue_struct *thermal_wq __ro_after_init;
+
 /*
  * Governor section: set of functions to handle thermal governors
  *
@@ -313,7 +315,7 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 	if (delay > HZ)
 		delay = round_jiffies_relative(delay);
 
-	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, delay);
+	mod_delayed_work(thermal_wq, &tz->poll_queue, delay);
 }
 
 static void thermal_zone_recheck(struct thermal_zone_device *tz, int error)
@@ -1785,6 +1787,10 @@ static void thermal_zone_device_resume(struct work_struct *work)
 
 	guard(thermal_zone)(tz);
 
+	/* If the thermal zone is going away, there's nothing to do. */
+	if (tz->state & TZ_STATE_FLAG_EXIT)
+		return;
+
 	tz->state &= ~(TZ_STATE_FLAG_SUSPENDED | TZ_STATE_FLAG_RESUMING);
 
 	thermal_debug_tz_resume(tz);
@@ -1811,6 +1817,9 @@ static void thermal_zone_pm_prepare(struct thermal_zone_device *tz)
 	}
 
 	tz->state |= TZ_STATE_FLAG_SUSPENDED;
+
+	/* Prevent new work from getting to the workqueue subsequently. */
+	cancel_delayed_work(&tz->poll_queue);
 }
 
 static void thermal_pm_notify_prepare(void)
@@ -1829,8 +1838,6 @@ static void thermal_zone_pm_complete(struct thermal_zone_device *tz)
 {
 	guard(thermal_zone)(tz);
 
-	cancel_delayed_work(&tz->poll_queue);
-
 	reinit_completion(&tz->resume);
 	tz->state |= TZ_STATE_FLAG_RESUMING;
 
@@ -1840,7 +1847,7 @@ static void thermal_zone_pm_complete(struct thermal_zone_device *tz)
 	 */
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_resume);
 	/* Queue up the work without a delay. */
-	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, 0);
+	mod_delayed_work(thermal_wq, &tz->poll_queue, 0);
 }
 
 static void thermal_pm_notify_complete(void)
@@ -1863,6 +1870,11 @@ static int thermal_pm_notify(struct notifier_block *nb,
 	case PM_RESTORE_PREPARE:
 	case PM_SUSPEND_PREPARE:
 		thermal_pm_notify_prepare();
+		/*
+		 * Allow any leftover thermal work items already on the
+		 * worqueue to complete so they don't get in the way later.
+		 */
+		flush_workqueue(thermal_wq);
 		break;
 	case PM_POST_HIBERNATION:
 	case PM_POST_RESTORE:
@@ -1895,9 +1907,16 @@ static int __init thermal_init(void)
 	if (result)
 		goto error;
 
+	thermal_wq = alloc_workqueue("thermal_events",
+				      WQ_FREEZABLE | WQ_POWER_EFFICIENT | WQ_PERCPU, 0);
+	if (!thermal_wq) {
+		result = -ENOMEM;
+		goto unregister_netlink;
+	}
+
 	result = thermal_register_governors();
 	if (result)
-		goto unregister_netlink;
+		goto destroy_workqueue;
 
 	thermal_class = kzalloc_obj(*thermal_class);
 	if (!thermal_class) {
@@ -1924,6 +1943,8 @@ static int __init thermal_init(void)
 
 unregister_governors:
 	thermal_unregister_governors();
+destroy_workqueue:
+	destroy_workqueue(thermal_wq);
 unregister_netlink:
 	thermal_netlink_exit();
 error:


