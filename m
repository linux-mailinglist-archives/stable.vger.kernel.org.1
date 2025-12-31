Return-Path: <stable+bounces-204307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA07CEAFDE
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 02:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3F4B300B984
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 01:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C591F875A;
	Wed, 31 Dec 2025 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZDr5Mdb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E2486352;
	Wed, 31 Dec 2025 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767144207; cv=none; b=rH6z0tqXOIZ3ZOv3BVEkavaX+BtTG+DnFYNCWLVcZa94M8Rai2bM0UD1Ag/WoP8wheQa2xd0M9m0Rn/SHp9XDvSjMt8hCkZpYnexPabxpLCGqhzhOYOSwnwOdTDpPHfhtz4prMVXWM633AkuyDncuJHtjtezEMP4w/1Mcx7ENqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767144207; c=relaxed/simple;
	bh=cPr24yWOpwCHZ2PhwbQIiSeRK6rZY21txfdeinfKsqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWCtHjcb6gKVz+C8iC366mq2YYu/VFffNhpDRt+0kr6Tb+2YcdFVP02z0hFwUKieOyO5qIJkgTWgSaOxRYp+FKNbB/yugDGyeQJkMpLtmTYVbxibEwHmBMpDgwkEFIIeWBSzXOsI8lLCYWofeF/F7crqnNBO4ss0B8M6d8TQFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZDr5Mdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EA8C116C6;
	Wed, 31 Dec 2025 01:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767144207;
	bh=cPr24yWOpwCHZ2PhwbQIiSeRK6rZY21txfdeinfKsqU=;
	h=From:To:Cc:Subject:Date:From;
	b=kZDr5MdblqulROIXEsXlQbW0pIPFGnBEA2MovS3Lfru3y0iOhCe5PGKUMSxEtzBm9
	 z1B14uGovfWVsR3U088Mc+EJMA5ng5RF7LFBW9+DaJ7XW+TkyYV0Q02MaYmuL8ayN/
	 KMAGeD4drI0mTSdFNbY2DcbaObvw91GTjnQ7A2QKwZJ8RJ4V1s6ozJhnKEae8uUOY8
	 uM+Io4ZaG9ttvN8WuUiE6Uo32xJ+tUrJQiA03sR3kbwlN0I4imJme3xSDZLpLYot8S
	 Mc6Y/wtmLwLFLScKBVAUFf//31runMxSQXZoV9y1H1kSh2ql0CEuJW7NfoXf+4rniT
	 bqJlOlufbPDYA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	JaeJoon Jung <rgbi3307@gmail.com>
Subject: [PATCH v2] mm/damon/core: remove call_control in inactive contexts
Date: Tue, 30 Dec 2025 17:23:13 -0800
Message-ID: <20251231012315.75835-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If damon_call() is executed against a DAMON context that is not running,
the function returns error while keeping the damon_call_control object
linked to the context's call_controls list.  Let's suppose the object is
deallocated after the damon_call(), and yet another damon_call() is
executed against the same context.  The function tries to add the new
damon_call_control object to the call_controls list, which still has the
pointer to the previous damon_call_control object, which is deallocated.
As a result, use-after-free happens.

This can actually be triggered using the DAMON sysfs interface.  It is not
easily exploitable since it requires the sysfs write permission and making
a definitely weird file writes, though.  Please refer to the report for
more details about the issue reproduction steps.

Fix the issue by making two changes.  Firstly, move the final
kdamond_call() for cancelling all existing damon_call() requests from
terminating DAMON context to be done before the ctx->kdamond reset.
This makes any code that sees NULL ctx->kdamond can safely assume the
context may not access damon_call() requests anymore.  Secondly, let
damon_call() to cleanup the damon_call_control objects that were added
to the already-terminated DAMON context, before returning the error.

Fixes: 004ded6bee11 ("mm/damon: accept parallel damon_call() requests")
Reported-by: JaeJoon Jung <rgbi3307@gmail.com>
Closes: https://lore.kernel.org/20251224094401.20384-1-rgbi3307@gmail.com
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v1
(https://lkml.kernel.org/r/20251228183105.289441-1-sj@kernel.org):
- Do final kdamond_call() before ctx->kdamond reset.
- Fix Fixes: tag.

 mm/damon/core.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2d3e8006db50..199529dd7c66 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1442,6 +1442,35 @@ bool damon_is_running(struct damon_ctx *ctx)
 	return running;
 }
 
+/*
+ * damon_call_handle_inactive_ctx() - handle DAMON call request that added to
+ *				      an inactive context.
+ * @ctx:	The inactive DAMON context.
+ * @control:	Control variable of the call request.
+ *
+ * This function is called in a case that @control is added to @ctx but @ctx is
+ * not running (inactive).  See if @ctx handled @control or not, and cleanup
+ * @control if it was not handled.
+ *
+ * Returns 0 if @control was handled by @ctx, negative error code otherwise.
+ */
+static int damon_call_handle_inactive_ctx(
+		struct damon_ctx *ctx, struct damon_call_control *control)
+{
+	struct damon_call_control *c;
+
+	mutex_lock(&ctx->call_controls_lock);
+	list_for_each_entry(c, &ctx->call_controls, list) {
+		if (c == control) {
+			list_del(&control->list);
+			mutex_unlock(&ctx->call_controls_lock);
+			return -EINVAL;
+		}
+	}
+	mutex_unlock(&ctx->call_controls_lock);
+	return 0;
+}
+
 /**
  * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
  * @ctx:	DAMON context to call the function for.
@@ -1472,7 +1501,7 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 	list_add_tail(&control->list, &ctx->call_controls);
 	mutex_unlock(&ctx->call_controls_lock);
 	if (!damon_is_running(ctx))
-		return -EINVAL;
+		return damon_call_handle_inactive_ctx(ctx, control);
 	if (control->repeat)
 		return 0;
 	wait_for_completion(&control->completion);
@@ -2797,13 +2826,13 @@ static int kdamond_fn(void *data)
 	if (ctx->ops.cleanup)
 		ctx->ops.cleanup(ctx);
 	kfree(ctx->regions_score_histogram);
+	kdamond_call(ctx, true);
 
 	pr_debug("kdamond (%d) finishes\n", current->pid);
 	mutex_lock(&ctx->kdamond_lock);
 	ctx->kdamond = NULL;
 	mutex_unlock(&ctx->kdamond_lock);
 
-	kdamond_call(ctx, true);
 	damos_walk_cancel(ctx);
 
 	mutex_lock(&damon_lock);

base-commit: 40fd05d807b3a7678e3284b8a9a6cb89a32fa8ce
-- 
2.47.3

