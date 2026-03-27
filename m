Return-Path: <stable+bounces-230734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKQcN/kUx2mWSgUAu9opvQ
	(envelope-from <stable+bounces-230734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 00:38:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5B434C623
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 00:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 006BF305E9AC
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 23:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CB739BFEC;
	Fri, 27 Mar 2026 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+JFfCfT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A420F392C56;
	Fri, 27 Mar 2026 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774654403; cv=none; b=dgfAw5YXSFP0kYizbLlzFtQDPvJlnFnQ+3Y0BUQkpWhZ6wakdAgyCIDf6wbxIe1y0ptQl3W7w6m4CbY3qfRcIXfntU9K21GF6GVllx+PqxmZdnVXDpBGKFnygHFXYcif/RotihmGnd+9KThuXKUGq2Nn0pjbTpEjzZXgbcQHrYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774654403; c=relaxed/simple;
	bh=VSUrozLJroKMWrM7KxSMyE5+mSLHT7kOcYr4qKbQQJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiSWYZ206VWQ5kL2BaHgHYzxkqqTiQ6xwX+ymQYvCmwzV1YmXWhMs3BKseMllkZU4MpgPNxoZ7Z2OqZWpzwIZHG2CpFj5caFKVaFNAtz2zDDSLfI/Qx5Tw1oG7A7VhmWodwn05NjR5+UVX3jPQVRTZ7fu4TciglsOZFPmVKKRJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+JFfCfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6012FC2BCB2;
	Fri, 27 Mar 2026 23:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774654403;
	bh=VSUrozLJroKMWrM7KxSMyE5+mSLHT7kOcYr4qKbQQJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+JFfCfT8CQ1EDMB6mu7gzb95mcb7qRbck02Q3vj3/Lh68f4nC1bboFOG+E9lhZIv
	 qq6L/zMDCxZPvKxQazRGe37Fir+fOObkSDqQ0hD7LHG3jRfYkGQ3M+2t6l4tkLWlnw
	 RruNY4xhMhTe8pu6GSBALQbqs468VASuNIbkKxs1AzLPLcBR5EEuf5ly6OmmDbApsu
	 /s7V/LaQt+aCH/GGpB5p+1lzYp3Guq4Sz8kV25XgjcqYRlrRvfVKrJnmNuyzMr8HXk
	 rcVQ6wvCvlfKXilvPLPW+oZNCrAjzY+qUPu7u1m9HwaA30L3dg8fXMXRdxBR7SvoOP
	 7YrcBI2upyjkg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] mm/damon/core: fix damos_walk() vs kdamond_fn() exit race
Date: Fri, 27 Mar 2026 16:33:15 -0700
Message-ID: <20260327233319.3528-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327233319.3528-1-sj@kernel.org>
References: <20260327233319.3528-1-sj@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230734-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4B5B434C623
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When kdamond_fn() main loop is finished, the function cancels remaining
damos_walk() request and unset the damon_ctx->kdamond so that API
callers and API functions themselves can show the context is terminated.
damos_walk() adds the caller's request to the queue first.  After that,
it shows if the kdamond of the damon_ctx is still running
(damon_ctx->kdamond is set).  Only if the kdamond is running,
damos_walk() starts waiting for the kdamond's handling of the newly
added request.

The damos_walk() requests registration and damon_ctx->kdamond unset are
protected by different mutexes, though.  Hence, damos_walk() could race
with damon_ctx->kdamond unset, and result in deadlocks.

For example, let's suppose kdamond successfully finished the
damow_walk() request cancelling.  Right after that, damos_walk() is
called for the context.  It registers the new request, and shows the
context is still running, because damon_ctx->kdamond unset is not yet
done.  Hence the damos_walk() caller starts waiting for the handling of
the request.  However, the kdamond is already on the termination steps,
so it never handles the new request.  As a result, the damos_walk()
caller thread infinitely waits.

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

[1] https://lore.kernel.org/20260325141956.87144-1-sj@kernel.org

Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

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
-- 
2.47.3

