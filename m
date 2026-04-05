Return-Path: <stable+bounces-233342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Nfs/IULo0mnHcAcAu9opvQ
	(envelope-from <stable+bounces-233342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 00:54:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 871843A00FA
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 00:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94F90300253F
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 22:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2DE3845A3;
	Sun,  5 Apr 2026 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0aMKT9g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED633148A8;
	Sun,  5 Apr 2026 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775429690; cv=none; b=Y2++Og2ryGEe4PSl/KmOm4jULBb+6F1BiwoqMqFcbY/T40TZP4cWift5aNhiSUk0WgkLIAwPZClJBKXN+RM+jPkLVIlrnp9VjPzTU4k0W1Zv1YX1dF6xncYgo7+mNSTbEJzA6VN2URnR8A8yIyYJq9LMUW+OIagr2auVmoeI7GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775429690; c=relaxed/simple;
	bh=uGhQilv6HZyt2+AVfLdJ6PyST+KHCobYzLvRtNH2bKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIIexzwUPc89mbz41FlWxtHULmSkTZdcOXi+PaKVd67YpbBAlbQOknlxnnMPYuOiyKrcfGTeq8Pz5gRIBDSDT4VfeEE5dwMNDD7XUCBrCQU03naXLAEz0nQRYY1EnEPTVgHPWmc32pmIwTnWpD5CIvM7UKdWJf2wG42cQocUlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0aMKT9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72609C116C6;
	Sun,  5 Apr 2026 22:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775429689;
	bh=uGhQilv6HZyt2+AVfLdJ6PyST+KHCobYzLvRtNH2bKY=;
	h=From:To:Cc:Subject:Date:From;
	b=U0aMKT9g8leGqzvSZQLfC6Cko+kdjQ5Htb8YAW3t7Z3IGPzJ5XQ0uNM7/yJAfqjmr
	 79KZ+hs6tROxELPB3xABOf5AKT0yfu60vic8lS/8OaiVKhvmaFem3Wd03JPxgfGH2J
	 0nIKyWWgnnMlmRNWV6KIAqFWktOhYR2JpDT+PTattN/UVTMeHffr85sq4feVplV++y
	 XpJUJZ23wgGUzdMCx+9nHAYUrFgkevazZT6pULyVS8mLw+jGQFH8B0YCrcCSbI2Jsg
	 khzRjeC9qAZD70UUT736Qxb1FC52L28g7TXP6TUtR7QcO8+a0IvYTLwLi5rJqI9Y8h
	 wwG79IK/pWJIA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/core: avoid time-quota permanently disabling scheme
Date: Sun,  5 Apr 2026 15:54:38 -0700
Message-ID: <20260405225440.76827-1-sj@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233342-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 871843A00FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the throughput of a DAMOS scheme is very slow, DAMOS time quota can
make the effective size quota smaller than damon_ctx->min_region_sz.  In
the case, damos_apply_scheme() will skip applying the action, because
the action is tried at region level, which requires >=min_region_sz
size.  That is, the quota is effectively exceeded for the quota charge
window.

Because no action will be applied, the total_charged_sz and
total_charged_ns are also not updated.  damos_set_effective_quota() will
try to update the effective size quota before starting the next charge
window.  However, because the total_charged_sz and total_charged_ns have
not updated, the throughput and effective size quota are also not
changed.  Since effective size quota can only be decreased, other
effective size quota update factors including DAMOS quota goals and size
quota cannot make any change, either.

As a result, the scheme is unexpectedly deactivated until the user
notices and mitigates the situation.  The users can mitigate this
situation by changing the time quota online or re-install the scheme.
While the mitigation is somewhat straightforward, finding the situation
would be challenging, because DAMON is not providing good
observabilities for that.  Even if such observability is provided, doing
the additional monitoring and the mitigation is somewhat cumbersome and
not aligned to the intention of the time quota.  The time quota was
intended to help reduce the user's administration overhead.

Fix the problem by setting time quota-modified effective size quota be
at least min_region_sz always.

The issue was discovered [1] by sashiko.

[1] https://lore.kernel.org/20260405192504.110014-1-sj@kernel.org

Fixes: 1cd243030059 ("mm/damon/schemes: implement time quota")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3bc7a2bbfe7de..12544c60531d3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2384,7 +2384,8 @@ static void damos_goal_tune_esz_bp_temporal(struct damos_quota *quota)
 /*
  * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
  */
-static void damos_set_effective_quota(struct damos_quota *quota)
+static void damos_set_effective_quota(struct damos_quota *quota,
+		struct damon_ctx *ctx)
 {
 	unsigned long throughput;
 	unsigned long esz = ULONG_MAX;
@@ -2409,6 +2410,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 		else
 			throughput = PAGE_SIZE * 1024;
 		esz = min(throughput * quota->ms, esz);
+		esz = max(ctx->min_region_sz, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)
@@ -2445,7 +2447,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	/* First charge window */
 	if (!quota->total_charged_sz && !quota->charged_from) {
 		quota->charged_from = jiffies;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(quota, c);
 	}
 
 	/* New charge window starts */
@@ -2460,7 +2462,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 		quota->charged_sz = 0;
 		if (trace_damos_esz_enabled())
 			cached_esz = quota->esz;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(quota, c);
 		if (trace_damos_esz_enabled() && quota->esz != cached_esz)
 			damos_trace_esz(c, s, quota);
 	}

base-commit: 8c08ea3625d4fa8c1c74b208c0c630fce76e14a9
-- 
2.47.3

