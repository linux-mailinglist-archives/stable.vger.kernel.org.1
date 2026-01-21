Return-Path: <stable+bounces-210731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA/ZG0a6cGnwZQAAu9opvQ
	(envelope-from <stable+bounces-210731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 12:36:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E5256183
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 12:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BBCD981968
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 11:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C063E9592;
	Wed, 21 Jan 2026 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPFSdnX4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC53EFD04
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994894; cv=none; b=UbAZtQP5leklt+RYUlVcNXiySNR08iPd2d0nzNG7/0u2vs7sJQuB4VNJ+HPSx7CUsfyZWlnGvGlS2JWVlvFmp8knD3e4D4MOVTp3Ceg0EOKuGKxcMpAV7Oa7d9PZtjVoVsvbyfmztEcjWGjbqAKzLUCwbbblZRO0zra7f4U2iyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994894; c=relaxed/simple;
	bh=CCH9R0dUeK27lj6nTiMlygWvHvLUeOlJiKPTeW47CHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/zfH1+qXPTwO1NOD4rEYpVF5UQ+2HCscxMx40NBcNgRMHgXHzAzxihn0AesuttSDdRfuP6JYx5GPZ8Cr1m06MOZkpFg86pF1uSf7NfRSU7ynWxIbYD9N4tLc3P8KnxwDtgozSm4dHd5YJdbiXnJn4/ITJwAGYZrNrkqVh6NeYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPFSdnX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F28C116D0;
	Wed, 21 Jan 2026 11:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994893;
	bh=CCH9R0dUeK27lj6nTiMlygWvHvLUeOlJiKPTeW47CHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dPFSdnX4zWMZG/yZfLVVCD0X6R2g7sX4INGgzubutZuLcXWKypegrxybpwPN5lJWa
	 bnSiR9hNfEFGOoRKWa8XHZ0dIybqunGza8K8jr2kfkv8X5agnr5+Q0CJ5rkDeOLk3g
	 KEM+ACYA/sKhivhsJjORCRVydbkBIehLz7gGBJ1q1N0vIHhbtO1DjAIlE7M8rGbImh
	 Qjrk5c0bH5y/hst9DOPg7MJAJMALc0+ykWJ8Osmp3ezAVx8SLElUIANGvZIZ9KfiKd
	 t/AgW12Ldav/yCYfO1Ua0CxhN5D662uM19K7ZwEJ6loM07SBWNCdnOwhxwXYU0CnS6
	 9nToCLq6ng5nA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,
	Chris Mason <clm@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Michal Hocko <mhocko@suse.com>,
	SeongJae Park <sj@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] mm/page_alloc: batch page freeing in decay_pcp_high
Date: Wed, 21 Jan 2026 06:28:07 -0500
Message-ID: <20260121112808.1461983-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121112808.1461983-1-sashal@kernel.org>
References: <2026012041-wilder-jalapeno-0398@gregkh>
 <20260121112808.1461983-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,linux-foundation.org,cmpxchg.org,suse.cz,google.com,shutemov.name,suse.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-210731-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D3E5256183
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Joshua Hahn <joshua.hahnjy@gmail.com>

[ Upstream commit fc4b909c368f3a7b08c895dd5926476b58e85312 ]

It is possible for pcp->count - pcp->high to exceed pcp->batch by a lot.
When this happens, we should perform batching to ensure that
free_pcppages_bulk isn't called with too many pages to free at once and
starve out other threads that need the pcp or zone lock.

Since we are still only freeing the difference between the initial
pcp->count and pcp->high values, there should be no change to how many
pages are freed.

Link: https://lkml.kernel.org/r/20251014145011.3427205-3-joshua.hahnjy@gmail.com
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Suggested-by: Chris Mason <clm@fb.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Co-developed-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Michal Hocko <mhocko@suse.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 038a102535eb ("mm/page_alloc: prevent pcp corruption with SMP=n")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6e1669a562946..23ad33020f312 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2365,7 +2365,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
  */
 bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 {
-	int high_min, to_drain, batch;
+	int high_min, to_drain, to_drain_batched, batch;
 	bool todo = false;
 
 	high_min = READ_ONCE(pcp->high_min);
@@ -2383,11 +2383,14 @@ bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 	}
 
 	to_drain = pcp->count - pcp->high;
-	if (to_drain > 0) {
+	while (to_drain > 0) {
+		to_drain_batched = min(to_drain, batch);
 		spin_lock(&pcp->lock);
-		free_pcppages_bulk(zone, to_drain, pcp, 0);
+		free_pcppages_bulk(zone, to_drain_batched, pcp, 0);
 		spin_unlock(&pcp->lock);
 		todo = true;
+
+		to_drain -= to_drain_batched;
 	}
 
 	return todo;
-- 
2.51.0


