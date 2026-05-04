Return-Path: <stable+bounces-243033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jJdjDUGY+GmcwwIAu9opvQ
	(envelope-from <stable+bounces-243033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:59:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F8C4BD544
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D3DB301080A
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 12:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E283D8108;
	Mon,  4 May 2026 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/2I+jQb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C73D7D9C;
	Mon,  4 May 2026 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899493; cv=none; b=N6O1MEbBnjSkNOmScqz5vAtWEt6hqAx2N6Kq/6m1VUk8IWjQ+zEYb1nlQg+gU5UlRFdhNpJOAHqBs6/f7zV/BRu/RdTppKY8Kd7sJXWn2s0NUyY5V3sTsDCEY2Tbt3UOw0O7SXGjKEZK/cZMfOfgOhYw+pSIkN37E6sPYKn9sqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899493; c=relaxed/simple;
	bh=hFqhrxF8s/Yh9chH/dy/Ycf8OTqE6yq7s15QJcar3PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsCpQRnh2fNsmSPevyC72yB7y9BFcKPdyGsiKuzZ74Jz17bkYfOrmUVDfIgmrFzHh1L1PpEfhXXsM/YgI8rExJInnCdPY1+M4g/Q4eYevIecjUXIa/jIeKLdgDXAZueni7inW84S4HWGW7BuKRZyhmpSgkC7VwwlxqRTyKMnkYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/2I+jQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D18C2BCB8;
	Mon,  4 May 2026 12:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777899492;
	bh=hFqhrxF8s/Yh9chH/dy/Ycf8OTqE6yq7s15QJcar3PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/2I+jQbnObPHIz+Edt2/iUAX8d9nV7yELIDBGjf/6/WiO6N2IWa1/8yUEPuP8GIx
	 Kb4f2nOX/TBpzUt9TRnItvEinDnVCAP+iq0923FNamEEKPUbF62rwCsifYNjY0xx6j
	 ljshnQLHNkMXj1/MC4cIWn1ux8l8ICOFynIcGWrIpxYxSeJvDjJHc/vq2YDrrdnEnW
	 GQgfmnaK2tCxA4Cq4WqKZkZLL8tGvFi7OnkpFVLCAYakrEOnRckiXYHl8NPBXio1eY
	 zrRqskhpjwx0JmPCCod1jUxV/LIIUSSP4NMHuPkzalm75ibgJD36cfO+ATV1AqRg7L
	 K6qF+A3Hjmi4A==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/core: disallow time-quota setting zero esz
Date: Mon,  4 May 2026 05:58:08 -0700
Message-ID: <20260504125808.22145-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026050324-shed-cultivate-ed89@gregkh>
References: <2026050324-shed-cultivate-ed89@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 38F8C4BD544
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243033-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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
(cherry picked from commit 8bbde987c2b84f80da0853f739f0a920386f8b99)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ab5c351b276c..94f8450f6e84 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -802,6 +802,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 	else
 		throughput = PAGE_SIZE * 1024;
 	esz = throughput * quota->ms;
+	esz = max(DAMON_MIN_REGION, esz);
 
 	if (quota->sz && quota->sz < esz)
 		esz = quota->sz;
-- 
2.47.3


