Return-Path: <stable+bounces-242694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKqUM/M292mpdgIAu9opvQ
	(envelope-from <stable+bounces-242694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:52:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7CB4B5675
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A89C230037E7
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 11:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F12C2DCBFC;
	Sun,  3 May 2026 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iFs3iWvw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BDD38DD3
	for <stable@vger.kernel.org>; Sun,  3 May 2026 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777809137; cv=none; b=CTqacAjsGCsTKbldQr8Mw/PBsZY53ejOBWsEkZfwoPjfDapKnf7X1op9fjl/oMz6j11POw+noXmNarNib7SsyqHxlgLxaAg2M7a0sbjKa7aeXhzKGXmFrNjR2Hh4gifHHCim5D2ArxzTrhEe/k2+0mCyN1w2NE45H5WM6sbKvR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777809137; c=relaxed/simple;
	bh=yHXVCvIcuS+B2letF6MWM6lE5GitdI4/LR0+H1hSaW4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mvjicHInQAE4rY1PFmSuCRkZ0vRLJ7XzsWQT/yzWq+eENUZ3XsdsF3WylnftyRRefH+SJACEK62p1SGMyTbGBh6aHnsegoDsIezoexGZQrId2JsrhPfk6hU8IhQxoLtupyDmPZ7OrV0jecvJ1elQ8a/V3HzTYsKvJO/Eino7Egw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iFs3iWvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47654C2BCB4;
	Sun,  3 May 2026 11:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777809136;
	bh=yHXVCvIcuS+B2letF6MWM6lE5GitdI4/LR0+H1hSaW4=;
	h=Subject:To:Cc:From:Date:From;
	b=iFs3iWvwkNFcWNoIzo9SDYY+bbEC+KIQ87cTQVhHgTiumPwCuy8ekl2dVHqBUC3CD
	 rAFdZBPOeHB+hzsyTL2dqFFIy4uqSWUv/zvZ3zxOzm4cBEw/alKyAi+JJaDJtjjWYD
	 Q3tIprGA/lt5kLPGoLAdyB617eFvimh3DkB8oT2o=
Subject: FAILED: patch "[PATCH] mm/damon/core: disallow time-quota setting zero esz" failed to apply to 6.12-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 13:52:13 +0200
Message-ID: <2026050313-giddy-quizzical-4cc1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3B7CB4B5675
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242694-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,gregkh:email,linuxfoundation.org:dkim]


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8bbde987c2b84f80da0853f739f0a920386f8b99
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050313-giddy-quizzical-4cc1@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8bbde987c2b84f80da0853f739f0a920386f8b99 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Mon, 6 Apr 2026 17:31:52 -0700
Subject: [PATCH] mm/damon/core: disallow time-quota setting zero esz

When the throughput of a DAMOS scheme is very slow, DAMOS time quota can
make the effective size quota smaller than damon_ctx->min_region_sz.  In
the case, damos_apply_scheme() will skip applying the action, because the
action is tried at region level, which requires >=min_region_sz size.
That is, the quota is effectively exceeded for the quota charge window.

Because no action will be applied, the total_charged_sz and
total_charged_ns are also not updated.  damos_set_effective_quota() will
try to update the effective size quota before starting the next charge
window.  However, because the total_charged_sz and total_charged_ns have
not updated, the throughput and effective size quota are also not changed.
Since effective size quota can only be decreased, other effective size
quota update factors including DAMOS quota goals and size quota cannot
make any change, either.

As a result, the scheme is unexpectedly deactivated until the user notices
and mitigates the situation.  The users can mitigate this situation by
changing the time quota online or re-install the scheme.  While the
mitigation is somewhat straightforward, finding the situation would be
challenging, because DAMON is not providing good observabilities for that.
Even if such observability is provided, doing the additional monitoring
and the mitigation is somewhat cumbersome and not aligned to the intention
of the time quota.  The time quota was intended to help reduce the user's
administration overhead.

Fix the problem by setting time quota-modified effective size quota be at
least min_region_sz always.

The issue was discovered [1] by sashiko.

Link: https://lore.kernel.org/20260407003153.79589-1-sj@kernel.org
Link: https://lore.kernel.org/20260405192504.110014-1-sj@kernel.org [1]
Fixes: 1cd243030059 ("mm/damon/schemes: implement time quota")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3e1890d64d06..3703f62a876b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2228,7 +2228,8 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
 /*
  * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
  */
-static void damos_set_effective_quota(struct damos_quota *quota)
+static void damos_set_effective_quota(struct damos_quota *quota,
+		struct damon_ctx *ctx)
 {
 	unsigned long throughput;
 	unsigned long esz = ULONG_MAX;
@@ -2254,6 +2255,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 		else
 			throughput = PAGE_SIZE * 1024;
 		esz = min(throughput * quota->ms, esz);
+		esz = max(ctx->min_region_sz, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)
@@ -2290,7 +2292,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	/* First charge window */
 	if (!quota->total_charged_sz && !quota->charged_from) {
 		quota->charged_from = jiffies;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(quota, c);
 	}
 
 	/* New charge window starts */
@@ -2303,7 +2305,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 		quota->charged_sz = 0;
 		if (trace_damos_esz_enabled())
 			cached_esz = quota->esz;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(quota, c);
 		if (trace_damos_esz_enabled() && quota->esz != cached_esz)
 			damos_trace_esz(c, s, quota);
 	}


