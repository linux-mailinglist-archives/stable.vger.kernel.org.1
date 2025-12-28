Return-Path: <stable+bounces-203449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BBACE55BB
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 19:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 870F830036C9
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 18:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90F0238150;
	Sun, 28 Dec 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYnZ8Xo9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815CF21B9C5;
	Sun, 28 Dec 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766946676; cv=none; b=lPgq0dmpKuAeX8ubvj55z88tSsDN2Mwu/rwhdot4Fow27y4H2koS/Zc8SHmrOHiZQn1R7Ciy7DESfw3eGIttgPjVxsooVX/9cr9I3UpA7nI//AXymcW20foyV0DpAijD2MJNQeWesV1uRf8hneO84GHg/YDBoDMYfAUgJ+18EZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766946676; c=relaxed/simple;
	bh=Nl0zExVnGcv+a6pnsdYADQIl//NbnM0mSNK2Npcc274=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gB396pe7TLfWppJrvbSD6nD5i9uzp7NWyoy8r64gfJVb8MWW53uwSSUuR2ZhjFMtA3Pu34Y+GCdoVAeblmKrNL7tdsZRcCsQPcA6LkmyXj0gfO32j72+DJ1akNbktEo2iVmXPC/sup0HI44f4JnygKzwDe+jqxwvwvYgKn0gT9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYnZ8Xo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2152C4CEFB;
	Sun, 28 Dec 2025 18:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766946676;
	bh=Nl0zExVnGcv+a6pnsdYADQIl//NbnM0mSNK2Npcc274=;
	h=From:To:Cc:Subject:Date:From;
	b=DYnZ8Xo98Bp2Z6dXet8yKsrCR2Erlm2v2pr7WNLZeGlYXUjXF1TqK/dv4vH7nBE9q
	 4kudQE8gdhcLigBS2AjF4K2/Q2yCRbphFe4wW1UuBjpeSy5p4DyetWylA/DLGmBoCg
	 lWkdtl0FARxcNKg75U0fO1Ssz+CB8vpSvQUYJ8wRWYPLPNe0VILMCPB/rflOgXTmon
	 xePXxLN72myp/SxUo4UjOwfmVZyHwGuuwO5vQAIFRAKv2h2mPNwOKq1Ql8Qok1y9P2
	 ewl5MrwUrN7uAZpaVecbOzRi2fly51VlXgher4q4/2KyqwUT8146c/uGn/TITFFw7I
	 MWvuMwVfsqanw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	JaeJoon Jung <rgbi3307@gmail.com>
Subject: [PATCH] mm/damon/core: remove call_control in inactive contexts
Date: Sun, 28 Dec 2025 10:31:01 -0800
Message-ID: <20251228183105.289441-1-sj@kernel.org>
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

This can actually be triggered using the DAMON sysfs interface.  It is
not easily exploitable since it requires the sysfs write permission and
making a definitely weird file writes, though.  Please refer to the
report for more details about the issue reproduction steps.

Fix the issue by making damon_call() to cleanup the damon_call_control
object before returning the error.

Reported-by: JaeJoon Jung <rgbi3307@gmail.com>
Closes: https://lore.kernel.org/20251224094401.20384-1-rgbi3307@gmail.com
Fixes: 42b7491af14c ("mm/damon/core: introduce damon_call()")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2d3e8006db50..65482a0ce20b 100644
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

base-commit: a100272b3541cb00a5e29fdc16e428234ebfddd1
-- 
2.47.3

