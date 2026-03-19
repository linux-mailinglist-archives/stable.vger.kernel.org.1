Return-Path: <stable+bounces-227319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPxwFLANvGkirwIAu9opvQ
	(envelope-from <stable+bounces-227319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:52:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E33CC2CD368
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 458F33013DF5
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9C33D5676;
	Thu, 19 Mar 2026 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIZuhkS5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D83D9DD2;
	Thu, 19 Mar 2026 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931946; cv=none; b=uoV9fs1bkTibY8HaIjxlyDwfPzQnRYytPqBPNanodAvVp9H9rPDP6fwgh96AoqwBqZZHhvf4ov5BM/zzgs0MBm20A5BVr5sFwHsYmWUIMWxOxTQv60Yml688NdHgjk5+ihemUF3hyEgPxJCUqa6rfVHnt7MyftXQzOi+A51UfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931946; c=relaxed/simple;
	bh=S/gZgyTYvC4CrssFFtYDNp0SzgwSfvUoAiAAW+9FERk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzWvT4gyq6/pGZQEfQxZoJEgLd6AT7gvNGvZPBSl+K/t9701L969zQH5pjbOC0Yx4uHAzEEnncVRSyDHIOB2Bzbec17WRwuF+9sMoakOpGiJQLH9lesi19zasb2R6VhtgFPnQEPVTxtepUyvI+tOFTqiLLUUFjeBORBNp8L+PDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIZuhkS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E24C19424;
	Thu, 19 Mar 2026 14:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773931946;
	bh=S/gZgyTYvC4CrssFFtYDNp0SzgwSfvUoAiAAW+9FERk=;
	h=From:To:Cc:Subject:Date:From;
	b=UIZuhkS5OM2LEW/JmKTVfUX8UjkKQTrQFW8hsHgEEJV0gCH0Fb2K2a673mH23Z7VI
	 4Jkfk37aCLhl7GyqfJU5vZw80pZx+26w/+SEDwDZ5LeGH5RkneDc5EbX+a4g8kT3k2
	 /E9vfJCdHoJTBpEtdzZojTxtF61UiIrmcLdo0parYaLkkqz2Nkj/qINgIgiW8N/puF
	 o5SVOAgjMDC1lT47MMaBXigGcG2fRAdKKRBN0O7tv62rEuHDpXGxohAgawdy9N16tt
	 GUplp8P9qVS5GpnYaRbfGQn6FsI+g2M/tkTcxYGt5ofQ55iiBI0CAUnzsbwBIyb5Nw
	 YPEJ5mh2MXhDA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 15 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/core: avoid use of half-online-committed context
Date: Thu, 19 Mar 2026 07:52:17 -0700
Message-ID: <20260319145218.86197-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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
	TAGGED_FROM(0.00)[bounces-227319-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E33CC2CD368
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

One major usage of damon_call() is online DAMON parameters update.  It
is done by calling damon_commit_ctx() inside the damon_call() callback
function.  damon_commit_ctx() can fail for two reasons: 1) invalid
parameters and 2) internal memory allocation failures.  In case of
failures, the damon_ctx that attempted to be updated (commit
destination) can be partially updated (or, corrupted from a
perspective), and therefore shouldn't be used anymore.  The function
only ensures the damon_ctx object can safely deallocated using
damon_destroy_ctx().

The API callers are, however, calling damon_commit_ctx() only after
asserting the parameters are valid, to avoid damon_commit_ctx() fails
due to invalid input parameters.  But it can still theoretically fail if
the internal memory allocation fails.  In the case, DAMON may run with
the partially updated damon_ctx.  This can result in unexpected
behaviors including even NULL pointer dereference in case of
damos_commit_dests() failure [1].  Such allocation failure is arguably
too small to fail, so the real world impact would be rare.  But, given
the bad consequence, this needs to be fixed.

Avoid such partially-committed (maybe-corrupted) damon_ctx use by saving
the damon_commit_ctx() failure on the damon_ctx object.  For this,
introduce damon_ctx->maybe_corrupted field.  damon_commit_ctx() sets it
when it is failed.  kdamond_call() checks if the field is set after each
damon_call_control->fn() is executed.  If it is set, ignore remaining
callback requests and return.  All kdamond_call() callers including
kdamond_fn() also check the maybe_corrupted field right after
kdamond_call() invocations.  If the field is set, break the
kdamond_fn() main loop so that DAMON sill doesn't use the context that
might be corrupted.

[1] https://lore.kernel.org/20260319043309.97966-1-sj@kernel.org

Fixes: 3301f1861d34 ("mm/damon/sysfs: handle commit command using damon_call()")
Cc: <stable@vger.kernel.org> # 6.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 6 ++++++
 mm/damon/core.c       | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a4fea23da8576..be3d198043ff9 100644
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
index c1d1091d307e4..37454e8c9c510 100644
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
+		if (ctx->maybe_corrupted)
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

base-commit: 969615b6b5d178009a87abf4e4292f90c098978e
-- 
2.47.3

