Return-Path: <stable+bounces-254855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGdCGOglGGqZeQgAu9opvQ
	(envelope-from <stable+bounces-254855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:24:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD40A5F13AC
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF5BA3023311
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EE03E314B;
	Thu, 28 May 2026 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HiDUyNwP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A9537AA91
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779967462; cv=none; b=GuRQfweF3IESXxuK+D8lREOVvlKl+qhYiD/+9ZEgHwE8HG5Jxp1Q3gTpn8NEfBrUGtwj8r7UozO03gGwhbliTS4ZRM3vpg9OtxEy5J6YEf2BgCgeEK5h9yAqtEJcTnhmkk2juW4n3FsahWHsWysyKKsGN5R+w4TmJsa2zzqj5t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779967462; c=relaxed/simple;
	bh=cGHBScj0XMIGwnIcp1RcAH14apu8R/aRb5qF+AmsqfY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QNVYZiHnViEZxc1uRzEUQgPEAcsqfp1Fa/e2shBOhEONdrSQOeOoOJn3hl1fJJazBAhUUXY+Hvs9x/lcYZu8HEYpNSQ/L7tjZJ9wgYt8rsW4lcualgHdggR+Cu8veKWpv+tJxHYlKc0k8lMlkPtWIgioD9PmrpoUxo0ZDX4l6kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HiDUyNwP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC531F000E9;
	Thu, 28 May 2026 11:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779967460;
	bh=kspOfQCbko9H2o19AH5uAPBiyCIbo/8IQjG6fjtqC2o=;
	h=Subject:To:Cc:From:Date;
	b=HiDUyNwPUwZKRrMkaCL9yVUTaKbJsJ1uAoqgJi/XFZ7Vcf7mTCmhPC95PAJuqs0Mc
	 k/CmlIgJ2Z/rqsz1g+i/Vy6ozZl8Mx33j8IQCwmFkQ2CxjpYOPonDgBacu7vRmnMWp
	 p7NkNoRZGpFLhS6QkS2zFx9q9XiooMUBvA6ZZri4=
Subject: FAILED: patch "[PATCH] rbd: eliminate a race in lock_dwork draining on unmap" failed to apply to 5.15-stable tree
To: idryomov@gmail.com,Slava.Dubeyko@ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:23:17 +0200
Message-ID: <2026052817-confront-cadmium-c296@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254855-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,ibm.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: CD40A5F13AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9fc75b71fdd38465c76c6f6a884cdd4ae3c72d90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052817-confront-cadmium-c296@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9fc75b71fdd38465c76c6f6a884cdd4ae3c72d90 Mon Sep 17 00:00:00 2001
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 19 May 2026 23:07:26 +0200
Subject: [PATCH] rbd: eliminate a race in lock_dwork draining on unmap

Given how rbd_lock_add_request() and rbd_img_exclusive_lock() are
written, lock_dwork may be (re)queued more than it's actually needed:
for example in case a new I/O request comes in while we are in the
middle of rbd_acquire_lock() on behalf of another I/O request.  This is
expected and with rbd_release_lock() preemptively canceling lock_dwork
is benign under normal operation.

A more problematic example is maybe_kick_acquire():

    if (have_requests || delayed_work_pending(&rbd_dev->lock_dwork)) {
            dout("%s rbd_dev %p kicking lock_dwork\n", __func__, rbd_dev);
            mod_delayed_work(rbd_dev->task_wq, &rbd_dev->lock_dwork, 0);
    }

It's not unrealistic for lock_dwork to get canceled right after
delayed_work_pending() returns true and for mod_delayed_work() to
requeue it right there anyway.  This is a classic TOCTOU race.

When it comes to unmapping the image, there is an implicit assumption
of no self-initiated exclusive lock activity past the point of return
from rbd_dev_image_unlock() which unlocks the lock if it happens to be
held.  This unlock is assumed to be final and lock_dwork (as well as
all other exclusive lock tasks, really) isn't expected to get queued
again.  However, lock_dwork is canceled only in cancel_tasks_sync()
(i.e. later in the unmap sequence) and on top of that the cancellation
can get in effect nullified by maybe_kick_acquire().  This may result
in rbd_acquire_lock() executing after rbd_dev_device_release() and
rbd_dev_image_release() run and free and/or reset a bunch of things.
One of the possible failure modes then is a violated

    rbd_assert(rbd_image_format_valid(rbd_dev->image_format));

in rbd_dev_header_info() which is called via rbd_dev_refresh() from
rbd_post_acquire_action().

Redo exclusive lock task draining to provide saner semantics and try
to meet the assumptions around rbd_dev_image_unlock().

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4065336ebd1f..6c1e7347e6a7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4565,24 +4565,12 @@ static int rbd_register_watch(struct rbd_device *rbd_dev)
 	return ret;
 }
 
-static void cancel_tasks_sync(struct rbd_device *rbd_dev)
-{
-	dout("%s rbd_dev %p\n", __func__, rbd_dev);
-
-	cancel_work_sync(&rbd_dev->acquired_lock_work);
-	cancel_work_sync(&rbd_dev->released_lock_work);
-	cancel_delayed_work_sync(&rbd_dev->lock_dwork);
-	cancel_work_sync(&rbd_dev->unlock_work);
-}
-
 /*
  * header_rwsem must not be held to avoid a deadlock with
  * rbd_dev_refresh() when flushing notifies.
  */
 static void rbd_unregister_watch(struct rbd_device *rbd_dev)
 {
-	cancel_tasks_sync(rbd_dev);
-
 	mutex_lock(&rbd_dev->watch_mutex);
 	if (rbd_dev->watch_state == RBD_WATCH_STATE_REGISTERED)
 		__rbd_unregister_watch(rbd_dev);
@@ -6548,10 +6536,18 @@ static int rbd_add_parse_args(const char *buf,
 
 static void rbd_dev_image_unlock(struct rbd_device *rbd_dev)
 {
+	dout("%s rbd_dev %p\n", __func__, rbd_dev);
+
+	disable_delayed_work_sync(&rbd_dev->lock_dwork);
+	disable_work_sync(&rbd_dev->unlock_work);
+
 	down_write(&rbd_dev->lock_rwsem);
 	if (__rbd_is_lock_owner(rbd_dev))
 		__rbd_release_lock(rbd_dev);
 	up_write(&rbd_dev->lock_rwsem);
+
+	flush_work(&rbd_dev->acquired_lock_work);
+	flush_work(&rbd_dev->released_lock_work);
 }
 
 /*


