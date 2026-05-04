Return-Path: <stable+bounces-243029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMEeLEmX+GknwwIAu9opvQ
	(envelope-from <stable+bounces-243029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:55:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 140814BD476
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59EEC301C3E2
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 12:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F76D3C456D;
	Mon,  4 May 2026 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yon7LmOV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279F333730;
	Mon,  4 May 2026 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899334; cv=none; b=i3vtcwBBrf2kXGRScjUllpxeY/zPZ72PyXbqohlRiD4PRfnmVvNiFBjZngWaFJABHT842Mo958O5SjY1KWKipahmO/7owyJAwyFVtt8qk59IVdeUHCagwwK703ywOH0c1VSEvCPO9av1mhHE4LLCJM42c5rvgnAAOfwz2v9iSbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899334; c=relaxed/simple;
	bh=DTiN/YJ2gy/qPq7dFsTVkyc1CuyNNDCRaXA9TmkPcqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ol0h4tMIE8KeE9uBCugR2X/oeoyhtZbU8PAhifbJyJj/iUxj8KKQ2/80xW93kdDCv+AcSXlNjg2yCFgEmoT25uq9GsN7JYW90oi5hjzJpIceDMk3GzfUVMnuqN5+BrNbJwlG+Lyo0olriuuJzbNu2w6ocd6TVMxRU4FGgyQPNT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yon7LmOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA096C2BCB8;
	Mon,  4 May 2026 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777899334;
	bh=DTiN/YJ2gy/qPq7dFsTVkyc1CuyNNDCRaXA9TmkPcqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yon7LmOVDVI2BJDKa61uKQnUmSLG3HkPqqx74S+A5yNu6nnMMgU6QSBBuKkWrTXRp
	 yZxBIYJTNJJ7JLfXMXhu3T/RmQrJ6+ZNV9xVjXxwLw3JvM45/5znQRWOWA8gwKt1kl
	 ZcjMhKc5NOFhaV0/E3M5F78fQ4cORZXVMT9MAkMKNg9GGmWzleeJXMssBKKSoVA+TD
	 Bpmo2sYkdquq+MteXNpbT9Xd0C5azVzgY8gd8SWoQ4719pEvYwC/BIDSvfxr9zHox+
	 Jf5fFXNTNhnuZS81TS+QRN3MlCMu5ypX2fyyCDa0fbXTpn//hwXGwMh5FO0RqFGfeg
	 BI1JBO+JwhNqQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/core: disallow time-quota setting zero esz
Date: Mon,  4 May 2026 05:55:29 -0700
Message-ID: <20260504125529.18220-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026050319-verbally-voltage-207f@gregkh>
References: <2026050319-verbally-voltage-207f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 140814BD476
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-243029-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]

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
index 48747236c21c..12c2e584659a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1026,6 +1026,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 	else
 		throughput = PAGE_SIZE * 1024;
 	esz = throughput * quota->ms;
+	esz = max(DAMON_MIN_REGION, esz);
 
 	if (quota->sz && quota->sz < esz)
 		esz = quota->sz;
-- 
2.47.3


