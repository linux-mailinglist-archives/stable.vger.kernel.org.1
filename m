Return-Path: <stable+bounces-243035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHm3Lg2a+GkAxAIAu9opvQ
	(envelope-from <stable+bounces-243035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:07:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1634BD6F7
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D7A330182A5
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFE23D88EB;
	Mon,  4 May 2026 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2GwhBsi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1817D3D813E;
	Mon,  4 May 2026 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899865; cv=none; b=qxsfGB+W3GkjLm94wDe+F2lWq7ESS0gRfmEoS1h0kPXBksyTopetL4m2TynsF7w2POl4/xPviFTgGi1YVnL8LgPLu0Yp70t/UqwWKXXli1vp2OinlxkykU6WhpmLjtmV7uNycipVDM4SgzPA707sETfssV0GaaXAKx0so9DyZGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899865; c=relaxed/simple;
	bh=Pshoy4gNUESr72jkg51Vu4NZDeQVG+b2J7eBZyXJXa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfY6ne1hUVpf4jV8Z48kP0h2iMaPZtmklb65NMigscmmd5D2cTpf7yID3kS2ZKvAvCpjxbdp6rnqBulmlgeY6W7f4mq2//A5AT6RolXgCtSY4pdoRq+gRe1KNpxIIB/IQBFGkdHW4O7BAfY1U4WvN+U1FOd/cw0TsMzlDtQadIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2GwhBsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217A0C2BCB8;
	Mon,  4 May 2026 13:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777899864;
	bh=Pshoy4gNUESr72jkg51Vu4NZDeQVG+b2J7eBZyXJXa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D2GwhBsipAdkdlfWAqbcXteC6g/ScRV0F7UWOdaq15Fx5dbmShsi3K6793xOzEhI9
	 4LXrX3pqZOU3NsU208sR9zqfpMZSXxAFlUz/Rw1QTyZK/S9Wgsc+uILdBjWYJSmQ7V
	 fncSm0OnKPAWnCyxYZNVcSixcfPBC+hYDT/sLkmn3NxdtV75vvJdj/1tFi/LMnJReZ
	 ZvoA9ytaVFmaOfTy5LrWMcTIZJTvYjKYa8MBp+rRECdYW3oWQOTDx+gWK5ojMMae4J
	 1KjiBvqIjjPmHoUCGOPLNJWAyNdlOknrt46VLe8SqGAUQ4jr1BlobE+50pBcxrYQ5n
	 BGDQLgXnGZpGA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/core: disallow non-power of two min_region_sz on damon_start()
Date: Mon,  4 May 2026 06:04:18 -0700
Message-ID: <20260504130418.26862-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026050357-senator-aroma-1859@gregkh>
References: <2026050357-senator-aroma-1859@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2B1634BD6F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243035-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Commit d8f867fa0825 ("mm/damon: add damon_ctx->min_sz_region") introduced
a bug that allows unaligned DAMON region address ranges.  Commit
c80f46ac228b ("mm/damon/core: disallow non-power of two min_region_sz")
fixed it, but only for damon_commit_ctx() use case.  Still, DAMON sysfs
interface can emit non-power of two min_region_sz via damon_start().  Fix
the path by adding the is_power_of_2() check on damon_start().

The issue was discovered by sashiko [1].

Link: https://lore.kernel.org/20260411213638.77768-1-sj@kernel.org
Link: https://lore.kernel.org/20260403155530.64647-1-sj@kernel.org [1]
Fixes: d8f867fa0825 ("mm/damon: add damon_ctx->min_sz_region")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 95093e5cb4c5b50a5b1a4b79f2942b62744bd66a)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 87b6c9c2d647..e016ca7fde5e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1352,6 +1352,11 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 	int i;
 	int err = 0;
 
+	for (i = 0; i < nr_ctxs; i++) {
+		if (!is_power_of_2(ctxs[i]->min_sz_region))
+			return -EINVAL;
+	}
+
 	mutex_lock(&damon_lock);
 	if ((exclusive && nr_running_ctxs) ||
 			(!exclusive && running_exclusive_ctxs)) {
-- 
2.47.3


