Return-Path: <stable+bounces-256069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKgHD9uqGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:51:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF3C5F9B6C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 469E33056995
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883222EF652;
	Thu, 28 May 2026 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JYy3+Vej"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6D332909;
	Thu, 28 May 2026 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000668; cv=none; b=VvHxUw9Pm/0vWjcRMw2V5+0xu66UatclvalduEBtYzdEtTFDlX0r6PRKIqJ9TtzIC7itO7efhRfqWlZa0bV4+a4tSLkwGdx0QB4//sKrsYSZaKdiWuxpk8p9wBPD0mDuOA67HnY8a6Lx4j9A9Pvhcd+Ea/p2gCXhHG0mFP/X4ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000668; c=relaxed/simple;
	bh=pBM7C3O9ZyeK2cDdLd40JY/QlnnfVc5UirCa8/1i2uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKoelC0KNgLd0ptnZFQuA5upUwB3x6E2Ck/U6tWZcc/vsIR6I9WLsJXX+bYE034KKkqmYT9dq441SF2abWseom680E5XsOFvz8vRw7Y4UktcivrvmPepwCfcj4sz/GDk6Y8EpoE5uko7+YeourNk/yYiHxjckfHmq91yRkmKiik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JYy3+Vej; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B4E1F000E9;
	Thu, 28 May 2026 20:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000667;
	bh=kOsXlw1F0pdMw4hgLRHnClsfcNS+i87VMipWFVyWEyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JYy3+Vejea55wK6BOk141wfyXvsMHo6yaoc83g5DP3EY98QpATeJ487QIkk/wolIe
	 4Sg3mpM6J3hJd/XnPnlB7rs3TCiQdnNnW7+rYDkCgFJuYO3RP+umY+AHtjnnpiZDM6
	 oo29Z+TiVWRI0EUvyd8mcd3xoxo2SAF6QHqEldCA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: [PATCH 6.12 090/272] rbd: eliminate a race in lock_dwork draining on unmap
Date: Thu, 28 May 2026 21:47:44 +0200
Message-ID: <20260528194631.900058331@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256069-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,ibm.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6EF3C5F9B6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit 9fc75b71fdd38465c76c6f6a884cdd4ae3c72d90 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/rbd.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4565,24 +4565,12 @@ out:
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
@@ -6549,10 +6537,18 @@ out_err:
 
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



