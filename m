Return-Path: <stable+bounces-230667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC0wMdOTxmkyMAUAu9opvQ
	(envelope-from <stable+bounces-230667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:27:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6783F3460B0
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EE4D3059727
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817C73F23D1;
	Fri, 27 Mar 2026 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMthvpE8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409E63F167C;
	Fri, 27 Mar 2026 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621569; cv=none; b=L+EaUV3nOW2/tWTg2i5KQqbCL/U9JiMTOvTJFhj7kSY3OREw0EqQSmxTuEMbU/Q1xq7AOmebT3lEhZ76I2uEsBBWeKs1I3k7xR9edHpIjdJWEf0GNg1gORXBrgsal4mxvY4EpK7aAu9++sAdohQMVi0W7xg36W6qDTZoqJUqsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621569; c=relaxed/simple;
	bh=fLYAA+7Gdn0tj+igffgyllVKYLdoyYaeXXtFfb6nSaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ew/GpA5eSBONiizcWgq6bYdj+MoTDWDvH/Sw7E233FzGokKJhhpnlbo+paFUs6Dy4DgPf1cN+FVpT12/tGMP7cf/8JVeSOjtjFRTjW4sTXJLkHfDHz3B3u68kILrDY9X1WoFLzYg/o/rivlPp7zsQMusDOc/f9ieBplCqJGaPOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMthvpE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8905C2BC87;
	Fri, 27 Mar 2026 14:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774621569;
	bh=fLYAA+7Gdn0tj+igffgyllVKYLdoyYaeXXtFfb6nSaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NMthvpE85U9ktoGypO5aXgVOvsiNnQJg6BI9xr8TjMrL4ZuOIQTDaAf4iEJeC8VaK
	 0HHSl+CT3tltOR8TSbcX0OhUQodvndaalZDPLP7PckFy1dHsIU3jUG/wMgBdcWA+bn
	 oBJiRV2jCeRmFCL7xMqo/Rjq0cJGtS7b8H+ydOWSUfEN6/Rr/WwUmjSvwqoVigVjUE
	 OUS8o8eZS50uvpGHQZIng7zUIk7o2ZDVHShxrZr/04q47nPVcVCA+ooLJ89c9PXqvl
	 Nm9xZZ6bcjcfxKdGuAgu9DxcJc8t+sB6VGnt7kR0qtjzpgEOERS9KyA08EG0YERP5/
	 amwTIbJxOsY7A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 1/2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
Date: Fri, 27 Mar 2026 07:26:03 -0700
Message-ID: <20260327142605.4834-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327142605.4834-1-sj@kernel.org>
References: <20260327142605.4834-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230667-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6783F3460B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When kdamond_fn() main loop is finished, the function cancels all
remaining damon_call() requests and unset the damon_ctx->kdamond so that
API callers can show the context is terminated.  damon_call() adds the
caller's request to the queue first.  After that, it shows if the
kdamond of the damon_ctx is still running (damon_ctx->kdamond is set).
Only if the kdamond is running, damon_call() starts waiting for the
kdamond's handling of the newly added request.

The damon_call() requests registration and damon_ctx->kdamond unset are
protected by different mutexes, though.  Hence, damon_call() could race
with damon_ctx->kdamond unset, and result in deadlocks.

For example, let's suppose kdamond successfully finished the
damon_call() requests cancelling.  Right after that, damon_call() is
called for the context.  It registers the new request, and shows the
context is still running, because damon_ctx->kdamond unset is not yet
done.  Hence the damon_call() caller starts waiting for the handling of
the request.  However, the kdamond is already on the termination steps,
so it never handles the new request.  As a result, the damon_call()
caller threads infinitely waits.

Fix this by introducing another damon_ctx field, namely
call_controls_obsolete.  It is protected by the
damon_ctx->call_controls_lock, which protects damon_call() requests
registration.  Initialize (unset) it in kdamond_fn() before letting
damon_start() returns and set it just before the cancelling of remaining
damon_call() requests is executed.  damon_call() reads the obsolete
field under the lock and avoids adding a new request.

After this change, only requests that are guaranteed to be handled or
cancelled are registered.  Hence the after-registration DAMON context
termination check is no longer needed.  Remove it together.

Note that the deadlock will not happen when damon_call() is called for
repeat mode request.  In tis case, damon_call() returns instead of
waiting for the handling when the request registration succeeds and it
shows the kdamond is running.  However, if the request also has
dealloc_on_cancel, the request memory would be leaked.

The issue is found by sashiko [1].

[1] https://lore.kernel.org/20260325141956.87144-1-sj@kernel.org

Fixes: 42b7491af14c ("mm/damon/core: introduce damon_call()")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       | 45 ++++++++++++++-----------------------------
 2 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d9a3babbafc1..5129de70e7b7 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -818,6 +818,7 @@ struct damon_ctx {
 
 	/* lists of &struct damon_call_control */
 	struct list_head call_controls;
+	bool call_controls_obsolete;
 	struct mutex call_controls_lock;
 
 	struct damos_walk_control *walk_control;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index db6c67e52d2b..9bcda2765ac9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1573,35 +1573,6 @@ int damon_kdamond_pid(struct damon_ctx *ctx)
 	return pid;
 }
 
-/*
- * damon_call_handle_inactive_ctx() - handle DAMON call request that added to
- *				      an inactive context.
- * @ctx:	The inactive DAMON context.
- * @control:	Control variable of the call request.
- *
- * This function is called in a case that @control is added to @ctx but @ctx is
- * not running (inactive).  See if @ctx handled @control or not, and cleanup
- * @control if it was not handled.
- *
- * Returns 0 if @control was handled by @ctx, negative error code otherwise.
- */
-static int damon_call_handle_inactive_ctx(
-		struct damon_ctx *ctx, struct damon_call_control *control)
-{
-	struct damon_call_control *c;
-
-	mutex_lock(&ctx->call_controls_lock);
-	list_for_each_entry(c, &ctx->call_controls, list) {
-		if (c == control) {
-			list_del(&control->list);
-			mutex_unlock(&ctx->call_controls_lock);
-			return -EINVAL;
-		}
-	}
-	mutex_unlock(&ctx->call_controls_lock);
-	return 0;
-}
-
 /**
  * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
  * @ctx:	DAMON context to call the function for.
@@ -1619,6 +1590,10 @@ static int damon_call_handle_inactive_ctx(
  * synchronization.  The return value of the function will be saved in
  * &damon_call_control->return_code.
  *
+ * Note that this function should be called only after damon_start() with the
+ * @ctx has succeeded.  Otherwise, this function could fall into an indefinite
+ * wait.
+ *
  * Return: 0 on success, negative error code otherwise.
  */
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
@@ -1629,10 +1604,12 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 	INIT_LIST_HEAD(&control->list);
 
 	mutex_lock(&ctx->call_controls_lock);
+	if (ctx->call_controls_obsolete) {
+		mutex_unlock(&ctx->call_controls_lock);
+		return -ECANCELED;
+	}
 	list_add_tail(&control->list, &ctx->call_controls);
 	mutex_unlock(&ctx->call_controls_lock);
-	if (!damon_is_running(ctx))
-		return damon_call_handle_inactive_ctx(ctx, control);
 	if (control->repeat)
 		return 0;
 	wait_for_completion(&control->completion);
@@ -2952,6 +2929,9 @@ static int kdamond_fn(void *data)
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
 
+	mutex_lock(&ctx->call_controls_lock);
+	ctx->call_controls_obsolete = false;
+	mutex_unlock(&ctx->call_controls_lock);
 	complete(&ctx->kdamond_started);
 	kdamond_init_ctx(ctx);
 
@@ -3062,6 +3042,9 @@ static int kdamond_fn(void *data)
 	damon_destroy_targets(ctx);
 
 	kfree(ctx->regions_score_histogram);
+	mutex_lock(&ctx->call_controls_lock);
+	ctx->call_controls_obsolete = true;
+	mutex_unlock(&ctx->call_controls_lock);
 	kdamond_call(ctx, true);
 	damos_walk_cancel(ctx);
 
-- 
2.47.3

