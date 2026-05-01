Return-Path: <stable+bounces-242285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FHNChuI9Gl3CAIAu9opvQ
	(envelope-from <stable+bounces-242285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:01:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B764ABD09
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95D70300D317
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17845394483;
	Fri,  1 May 2026 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ARXC4MCM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB5035A38C
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633303; cv=none; b=eG+86sB9ahxbbZsz/J7GMSNvi/zqh+MuifjkyKrn3M9NrvD7Iy5X7qL6zIFWK8hfgA3mHSWaeUWuu1Fz2ljrvzi1GXW0+4d0z9z55bSLjfgaVwbLXmAuoUmwKRxjt8JCIrlGxGnr9DFdQjROjcmia66easKQIPJr5LEiAUM1Q6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633303; c=relaxed/simple;
	bh=Ulfat3p/LEnQTOLXpNx1N73FOujzK1KI3fphlz4Xais=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PST/ZOisTDKJ4hPZkWfqLjNL34IvKlyUXK+czAtrSE4BAb6iGd5u4oJplf/ZCA+R02F7Y/OrRH+fA4Gc7QZslEaJEQz0vmiMWfj2XpRSAxeRVnnLTDU7gcCyDl/r4rzShpfqT5XjWf1U9n+UcgSkz9ycx9iyc52V44TnJRUrMGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ARXC4MCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C266C2BCB4;
	Fri,  1 May 2026 11:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777633303;
	bh=Ulfat3p/LEnQTOLXpNx1N73FOujzK1KI3fphlz4Xais=;
	h=Subject:To:Cc:From:Date:From;
	b=ARXC4MCMZeCBjlVGC3PDv6vT/b+EVO6xuFAjxm/FLSewN8cV7pNKWr6p/Pl5Jkb4K
	 jbW9oMPH+I1vNuc83SxcnJUApT7NFBQfRhp7+BkrbcjVJ/5iyDuBI9M7b17+h0kWe9
	 Waa4535rxrBQu36rAvb3IGDL94ub8lHt9bBdOxqQ=
Subject: FAILED: patch "[PATCH] mm/damon/core: fix damos_walk() vs kdamond_fn() exit race" failed to apply to 6.18-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 13:01:41 +0200
Message-ID: <2026050141-likewise-trapeze-f1cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 16B764ABD09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242285-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 33c3f6c2b48cd84b441dba1ee3e62290e53930f4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050141-likewise-trapeze-f1cc@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 33c3f6c2b48cd84b441dba1ee3e62290e53930f4 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Fri, 27 Mar 2026 16:33:15 -0700
Subject: [PATCH] mm/damon/core: fix damos_walk() vs kdamond_fn() exit race

When kdamond_fn() main loop is finished, the function cancels remaining
damos_walk() request and unset the damon_ctx->kdamond so that API callers
and API functions themselves can show the context is terminated.
damos_walk() adds the caller's request to the queue first.  After that, it
shows if the kdamond of the damon_ctx is still running (damon_ctx->kdamond
is set).  Only if the kdamond is running, damos_walk() starts waiting for
the kdamond's handling of the newly added request.

The damos_walk() requests registration and damon_ctx->kdamond unset are
protected by different mutexes, though.  Hence, damos_walk() could race
with damon_ctx->kdamond unset, and result in deadlocks.

For example, let's suppose kdamond successfully finished the damow_walk()
request cancelling.  Right after that, damos_walk() is called for the
context.  It registers the new request, and shows the context is still
running, because damon_ctx->kdamond unset is not yet done.  Hence the
damos_walk() caller starts waiting for the handling of the request.
However, the kdamond is already on the termination steps, so it never
handles the new request.  As a result, the damos_walk() caller thread
infinitely waits.

Fix this by introducing another damon_ctx field, namely
walk_control_obsolete.  It is protected by the
damon_ctx->walk_control_lock, which protects damos_walk() request
registration.  Initialize (unset) it in kdamond_fn() before letting
damon_start() returns and set it just before the cancelling of the
remaining damos_walk() request is executed.  damos_walk() reads the
obsolete field under the lock and avoids adding a new request.

After this change, only requests that are guaranteed to be handled or
cancelled are registered.  Hence the after-registration DAMON context
termination check is no longer needed.  Remove it together.

The issue is found by sashiko [1].


Link: https://lore.kernel.org/20260327233319.3528-3-sj@kernel.org
Link: https://lore.kernel.org/20260325141956.87144-1-sj@kernel.org [1]
Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5129de70e7b7..f2cdb7c3f5e6 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -822,6 +822,7 @@ struct damon_ctx {
 	struct mutex call_controls_lock;
 
 	struct damos_walk_control *walk_control;
+	bool walk_control_obsolete;
 	struct mutex walk_control_lock;
 
 	/*
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9bcda2765ac9..ddabb93f2377 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1637,6 +1637,10 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
  * passed at least one &damos->apply_interval_us, kdamond marks the request as
  * completed so that damos_walk() can wakeup and return.
  *
+ * Note that this function should be called only after damon_start() with the
+ * @ctx has succeeded.  Otherwise, this function could fall into an indefinite
+ * wait.
+ *
  * Return: 0 on success, negative error code otherwise.
  */
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
@@ -1644,19 +1648,16 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
 	init_completion(&control->completion);
 	control->canceled = false;
 	mutex_lock(&ctx->walk_control_lock);
+	if (ctx->walk_control_obsolete) {
+		mutex_unlock(&ctx->walk_control_lock);
+		return -ECANCELED;
+	}
 	if (ctx->walk_control) {
 		mutex_unlock(&ctx->walk_control_lock);
 		return -EBUSY;
 	}
 	ctx->walk_control = control;
 	mutex_unlock(&ctx->walk_control_lock);
-	if (!damon_is_running(ctx)) {
-		mutex_lock(&ctx->walk_control_lock);
-		if (ctx->walk_control == control)
-			ctx->walk_control = NULL;
-		mutex_unlock(&ctx->walk_control_lock);
-		return -EINVAL;
-	}
 	wait_for_completion(&control->completion);
 	if (control->canceled)
 		return -ECANCELED;
@@ -2932,6 +2933,9 @@ static int kdamond_fn(void *data)
 	mutex_lock(&ctx->call_controls_lock);
 	ctx->call_controls_obsolete = false;
 	mutex_unlock(&ctx->call_controls_lock);
+	mutex_lock(&ctx->walk_control_lock);
+	ctx->walk_control_obsolete = false;
+	mutex_unlock(&ctx->walk_control_lock);
 	complete(&ctx->kdamond_started);
 	kdamond_init_ctx(ctx);
 
@@ -3046,6 +3050,9 @@ static int kdamond_fn(void *data)
 	ctx->call_controls_obsolete = true;
 	mutex_unlock(&ctx->call_controls_lock);
 	kdamond_call(ctx, true);
+	mutex_lock(&ctx->walk_control_lock);
+	ctx->walk_control_obsolete = true;
+	mutex_unlock(&ctx->walk_control_lock);
 	damos_walk_cancel(ctx);
 
 	pr_debug("kdamond (%d) finishes\n", current->pid);


