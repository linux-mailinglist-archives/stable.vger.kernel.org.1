Return-Path: <stable+bounces-238623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WR3mMVd15GkXVgEAu9opvQ
	(envelope-from <stable+bounces-238623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 08:25:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 208294233A5
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 08:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCCF93014107
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 06:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBC7302163;
	Sun, 19 Apr 2026 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IeFlDFEm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FADA16FF37;
	Sun, 19 Apr 2026 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776579924; cv=none; b=HK1M+1+uxEYPm2EUDnLbi7+hvx0JUBtZPjhu25HUmBgyXiZjAyY+AvAaFWyt72yLM98BJfsAICO+5GBrarFRa/ux4R9korQ36CExINOedKKSXu6943kN8WW8WDUrHvv6QKruPmH7OYJQBktkLqwm06brzUAO5f7P7t3Bw+XiSkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776579924; c=relaxed/simple;
	bh=LVlv8cSgW0pimOvm7HD+ZQTHPvQb6wo56LV3IgCd2ZQ=;
	h=Date:To:From:Subject:Message-Id; b=LezrfoAxFgmL0fnkzfxh1ykeVrYbOSeiekD/V5sZErirXjBDBNCDkupERmkE/ozMvrplqwGUGZMwBQA3hAl86ZWEMVZJbXBkvssDfI2RpRzTeTqwr3CcLKCgm9VpvdgxJ3SBYANgRgRtd2f0FAqNDj3aJ/JhxXf8a32xIf6dp8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IeFlDFEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8BDC2BCAF;
	Sun, 19 Apr 2026 06:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776579924;
	bh=LVlv8cSgW0pimOvm7HD+ZQTHPvQb6wo56LV3IgCd2ZQ=;
	h=Date:To:From:Subject:From;
	b=IeFlDFEmUMvSsDgK5Gg/pjuned1fFGqJcyhFYOb2IDvnjNmpXIIyFLHqcduPHNleX
	 qrFkEKdk/IU+RwKg2vE7roO18LVqcmtya7XQrcH6x+4aTryKO8mUBxqQxAhi2AIz1l
	 5M2R7EOusBaJZXFv4sYF5/vzLbGnwnQUoALLFcZo=
Date: Sat, 18 Apr 2026 23:25:15 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,sj@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-damon-core-disallow-time-quota-setting-zero-esz.patch removed from -mm tree
Message-Id: <20260419062523.6C8BDC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238623-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 208294233A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: mm/damon/core: disallow time-quota setting zero esz
has been removed from the -mm tree.  Its filename was
     mm-damon-core-disallow-time-quota-setting-zero-esz.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: SeongJae Park <sj@kernel.org>
Subject: mm/damon/core: disallow time-quota setting zero esz
Date: Mon, 6 Apr 2026 17:31:52 -0700

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
---

 mm/damon/core.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/mm/damon/core.c~mm-damon-core-disallow-time-quota-setting-zero-esz
+++ a/mm/damon/core.c
@@ -2228,7 +2228,8 @@ static unsigned long damos_quota_score(s
 /*
  * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
  */
-static void damos_set_effective_quota(struct damos_quota *quota)
+static void damos_set_effective_quota(struct damos_quota *quota,
+		struct damon_ctx *ctx)
 {
 	unsigned long throughput;
 	unsigned long esz = ULONG_MAX;
@@ -2254,6 +2255,7 @@ static void damos_set_effective_quota(st
 		else
 			throughput = PAGE_SIZE * 1024;
 		esz = min(throughput * quota->ms, esz);
+		esz = max(ctx->min_region_sz, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)
@@ -2290,7 +2292,7 @@ static void damos_adjust_quota(struct da
 	/* First charge window */
 	if (!quota->total_charged_sz && !quota->charged_from) {
 		quota->charged_from = jiffies;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(quota, c);
 	}
 
 	/* New charge window starts */
@@ -2303,7 +2305,7 @@ static void damos_adjust_quota(struct da
 		quota->charged_sz = 0;
 		if (trace_damos_esz_enabled())
 			cached_esz = quota->esz;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(quota, c);
 		if (trace_damos_esz_enabled() && quota->esz != cached_esz)
 			damos_trace_esz(c, s, quota);
 	}
_

Patches currently in -mm which might be from sj@kernel.org are



