Return-Path: <stable+bounces-230957-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKoaMEZSyWnrxQUAu9opvQ
	(envelope-from <stable+bounces-230957-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:24:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 194FD352E11
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06FC530166C9
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972DC36EAB5;
	Sun, 29 Mar 2026 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prJWhsIi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F4235FF58
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801322; cv=none; b=RZtDuislSMBE/KGvOBG6FwWDOJ/RQCQuSj85TdpGuBiCFRnubAUOIvyAr86p/VvINo1iaJhmYeL7gSF8cj8aMRfCVM/sCh55uMQ9P+Fdhx2eWWnXTx+nK9aisrnKvhXxa+5mfFbiaHtc+nXYZl81T0SiaYAy+/7O+C+LUE8V56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801322; c=relaxed/simple;
	bh=CPPzlWUbMbTOc/U6leI3v1BPV04vETobDPjoiG6G/5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYNmaEM+k8WCgn2mmxHpMXjWs6TQSV5/riNq5JgsRdwd8j2Orb+z8j9qUnhivURc5QcIgHLYfrGWNQ3lnm0xNc8BSzx1Rifskj+J/iCOLOona7LXO7RVsgM+la/muASCN5g/+32vG6l57daaSEgF4E91GpzcS0xU0GCFk6wscko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prJWhsIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917E1C116C6;
	Sun, 29 Mar 2026 16:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774801321;
	bh=CPPzlWUbMbTOc/U6leI3v1BPV04vETobDPjoiG6G/5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=prJWhsIigzwQUCBUfkbJsFxZeBk3POrjuTk1PAWeXhSxnXLqzmIp0MjgsbDhg90Vy
	 HgmPedOTOu6XmVkARLXsIxUDR7z5OcSoCM86Cq+lYptKDDVYjqcsnZWbaqlvbtDdaf
	 Y9eL/tcg0fuuId2xBnjPOhengNtU0vbbQElBdKnb/mueE6hjkXGDRqaWasv++uiASi
	 SxxQfFuWufgLt8Sodue4qyzYdJSlAfpJdRoOBkJ6qeQN8oc+9e/E9qy84h7LQTGLpP
	 SOGtqC7nHBiebWb++c/D0KOSxe3X7jutRmAj9IBJNko4liT8PlnpeFcuM2DQo7HsJW
	 7xfnwj+lGdznA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.19.y] mm/damon/core: avoid use of half-online-committed context
Date: Sun, 29 Mar 2026 09:21:59 -0700
Message-ID: <20260329162159.56306-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026032924-italicize-animate-f383@gregkh>
References: <2026032924-italicize-animate-f383@gregkh>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230957-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,linux-foundation.org:email]
X-Rspamd-Queue-Id: 194FD352E11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
(cherry picked from commit 26f775a054c3cda86ad465a64141894a90a9e145)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 7 +++++++
 mm/damon/core.c       | 9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 33e59d53d9f1..e44ec9d76771 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -806,7 +806,14 @@ struct damon_ctx {
 	struct damos_walk_control *walk_control;
 	struct mutex walk_control_lock;
 
+	/*
+	 * indicate if this may be corrupted.  Currentonly this is set only for
+	 * damon_commit_ctx() failure.
+	 */
+	bool maybe_corrupted;
+
 /* public: */
+	/* Working thread of the given DAMON context */
 	struct task_struct *kdamond;
 	struct mutex kdamond_lock;
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ba3b7ff8ecf4..0464ef163b7c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1241,6 +1241,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 {
 	int err;
 
+	dst->maybe_corrupted = true;
 	if (!is_power_of_2(src->min_region_sz))
 		return -EINVAL;
 
@@ -1266,6 +1267,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	dst->addr_unit = src->addr_unit;
 	dst->min_region_sz = src->min_region_sz;
 
+	dst->maybe_corrupted = false;
 	return 0;
 }
 
@@ -2610,10 +2612,11 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 			complete(&control->completion);
 		} else if (control->canceled && control->dealloc_on_cancel) {
 			kfree(control);
-			continue;
 		} else {
 			list_add(&control->list, &repeat_controls);
 		}
+		if (!cancel && ctx->maybe_corrupted)
+			break;
 	}
 	control = list_first_entry_or_null(&repeat_controls,
 			struct damon_call_control, list);
@@ -2646,6 +2649,8 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 		kdamond_usleep(min_wait_time);
 
 		kdamond_call(ctx, false);
+		if (ctx->maybe_corrupted)
+			return -EINVAL;
 		damos_walk_cancel(ctx);
 	}
 	return -EBUSY;
@@ -2731,6 +2736,8 @@ static int kdamond_fn(void *data)
 		 * kdamond_merge_regions() if possible, to reduce overhead
 		 */
 		kdamond_call(ctx, false);
+		if (ctx->maybe_corrupted)
+			break;
 		if (!list_empty(&ctx->schemes))
 			kdamond_apply_schemes(ctx);
 		else
-- 
2.47.3


