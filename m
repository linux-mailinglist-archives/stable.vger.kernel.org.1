Return-Path: <stable+bounces-230869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CPLAPzTyGlTrQUAu9opvQ
	(envelope-from <stable+bounces-230869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:25:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F713510CD
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 584F3301DADB
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 07:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606CD2D3A93;
	Sun, 29 Mar 2026 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="siYtw5Ae"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186622D3733
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774769137; cv=none; b=PgVAFZPLJW5TWmBW8P16vXoAuxAyXm74rS8XUTxv0XTn4h0heX16q+pKWaOV+MOOdNUfl+C1vBTOQdZxoSZ8nuJumqwCrKlKGUvGUgcsMNr5eDhs9cjFd9xXU55sRd65qJxbzEeJWh5wNW94sGpR92CBEp2H32rtjqCyKka8d+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774769137; c=relaxed/simple;
	bh=8FvN+lWYG1QNQYpfOsCP1+lcXDqsOKA87qImLDcs1Cw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FMwEzgbHy/aSXU1SLb7SVKHSYiRDtxXaURfXh5fKd/6Bo80gCDNhLdWH/W2DleYOqiakAWWg6i+JfV/1HxLqI9lwcw9fVFipojgTbqVcLBh4kftA5mcuPyBp1KaWacpeWTeFtk6jyqgndX/I6P8pMa+olsa7N38fyAtQn9jtVg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=siYtw5Ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24616C116C6;
	Sun, 29 Mar 2026 07:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774769136;
	bh=8FvN+lWYG1QNQYpfOsCP1+lcXDqsOKA87qImLDcs1Cw=;
	h=Subject:To:Cc:From:Date:From;
	b=siYtw5AedMeMi+GDY9brRgUIqrYJjkATjv9EqY5HvzuS5MXQclrkLriYvL3KhPRLK
	 hTDQ0ro9kaAPFWZvoNee6YKGmBV9qQ5ypOwdGFjQED340gT1Fsrfl5l5sXKv92A6eq
	 Oe0Xd4N6kr3bV/3Yi2n007mjJiDY4gmekDjPwOCg=
Subject: FAILED: patch "[PATCH] mm/damon/core: avoid use of half-online-committed context" failed to apply to 6.18-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 09:25:25 +0200
Message-ID: <2026032925-frosted-jogger-2ba0@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230869-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 54F713510CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 26f775a054c3cda86ad465a64141894a90a9e145
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032925-frosted-jogger-2ba0@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26f775a054c3cda86ad465a64141894a90a9e145 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Thu, 19 Mar 2026 07:52:17 -0700
Subject: [PATCH] mm/damon/core: avoid use of half-online-committed context

One major usage of damon_call() is online DAMON parameters update.  It is
done by calling damon_commit_ctx() inside the damon_call() callback
function.  damon_commit_ctx() can fail for two reasons: 1) invalid
parameters and 2) internal memory allocation failures.  In case of
failures, the damon_ctx that attempted to be updated (commit destination)
can be partially updated (or, corrupted from a perspective), and therefore
shouldn't be used anymore.  The function only ensures the damon_ctx object
can safely deallocated using damon_destroy_ctx().

The API callers are, however, calling damon_commit_ctx() only after
asserting the parameters are valid, to avoid damon_commit_ctx() fails due
to invalid input parameters.  But it can still theoretically fail if the
internal memory allocation fails.  In the case, DAMON may run with the
partially updated damon_ctx.  This can result in unexpected behaviors
including even NULL pointer dereference in case of damos_commit_dests()
failure [1].  Such allocation failure is arguably too small to fail, so
the real world impact would be rare.  But, given the bad consequence, this
needs to be fixed.

Avoid such partially-committed (maybe-corrupted) damon_ctx use by saving
the damon_commit_ctx() failure on the damon_ctx object.  For this,
introduce damon_ctx->maybe_corrupted field.  damon_commit_ctx() sets it
when it is failed.  kdamond_call() checks if the field is set after each
damon_call_control->fn() is executed.  If it is set, ignore remaining
callback requests and return.  All kdamond_call() callers including
kdamond_fn() also check the maybe_corrupted field right after
kdamond_call() invocations.  If the field is set, break the kdamond_fn()
main loop so that DAMON sill doesn't use the context that might be
corrupted.

[sj@kernel.org: let kdamond_call() with cancel regardless of maybe_corrupted]
  Link: https://lkml.kernel.org/r/20260320031553.2479-1-sj@kernel.org
  Link: https://sashiko.dev/#/patchset/20260319145218.86197-1-sj%40kernel.org
Link: https://lkml.kernel.org/r/20260319145218.86197-1-sj@kernel.org
Link: https://lore.kernel.org/20260319043309.97966-1-sj@kernel.org [1]
Fixes: 3301f1861d34 ("mm/damon/sysfs: handle commit command using damon_call()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[6.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a4fea23da857..be3d198043ff 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -810,6 +810,12 @@ struct damon_ctx {
 	struct damos_walk_control *walk_control;
 	struct mutex walk_control_lock;
 
+	/*
+	 * indicate if this may be corrupted.  Currentonly this is set only for
+	 * damon_commit_ctx() failure.
+	 */
+	bool maybe_corrupted;
+
 	/* Working thread of the given DAMON context */
 	struct task_struct *kdamond;
 	/* Protects @kdamond field access */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index c1d1091d307e..3e1890d64d06 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1252,6 +1252,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 {
 	int err;
 
+	dst->maybe_corrupted = true;
 	if (!is_power_of_2(src->min_region_sz))
 		return -EINVAL;
 
@@ -1277,6 +1278,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	dst->addr_unit = src->addr_unit;
 	dst->min_region_sz = src->min_region_sz;
 
+	dst->maybe_corrupted = false;
 	return 0;
 }
 
@@ -2678,6 +2680,8 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 			complete(&control->completion);
 		else if (control->canceled && control->dealloc_on_cancel)
 			kfree(control);
+		if (!cancel && ctx->maybe_corrupted)
+			break;
 	}
 
 	mutex_lock(&ctx->call_controls_lock);
@@ -2707,6 +2711,8 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 		kdamond_usleep(min_wait_time);
 
 		kdamond_call(ctx, false);
+		if (ctx->maybe_corrupted)
+			return -EINVAL;
 		damos_walk_cancel(ctx);
 	}
 	return -EBUSY;
@@ -2790,6 +2796,8 @@ static int kdamond_fn(void *data)
 		 * kdamond_merge_regions() if possible, to reduce overhead
 		 */
 		kdamond_call(ctx, false);
+		if (ctx->maybe_corrupted)
+			break;
 		if (!list_empty(&ctx->schemes))
 			kdamond_apply_schemes(ctx);
 		else


