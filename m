Return-Path: <stable+bounces-273839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TCBRKqrwVGqRhgAAu9opvQ
	(envelope-from <stable+bounces-273839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 16:05:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E78CF74C18E
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 16:05:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MEkO4cOG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273839-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273839-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 538A6315E307
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925A4437479;
	Mon, 13 Jul 2026 13:58:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470ED437127;
	Mon, 13 Jul 2026 13:58:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951127; cv=none; b=njeQp3vYkYs2ioCL5g30YwRkda99aigHXQd7n0w2R/EMObqDKF4aKWFLBXME43C7NoDYvEjjRoJspGhLe/yypp2RIEVzN2IQUIbbd/3ILExFtDBLXapFO1hG0q03Bi48Q2MFdQLZZW0zkF84HCnwwj/or/MI8XhGFK3tdBCXiQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951127; c=relaxed/simple;
	bh=UvG3w3Q38JCvdgaSsgN+1fOmYYd1A7xQdvoEpH7rRxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qut64Mb5T7Qsd0qdqtNPAn1NGC/pV85pQqjSoV2T2s9P2g3BqeKljlL/tU5sHBChgex+hcWfDQApVzO+outjPGSu4azzAHOqJopeuYaS6iX+YKavk5MmQTUfz1s36cIFTcoS4pQGlmROlz2RK66DnniiDC/6/ki4hCnxTdSEJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEkO4cOG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C461F00A3E;
	Mon, 13 Jul 2026 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951126;
	bh=yFIQucAr4vFmOrW82XY64T561EcF6nkSnWV7DSiSLJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MEkO4cOG07NJ7HKPJXu62PXT/o98eeK7TbKkTVT+LMqWbUKy8aZygB2ygoNst2sRj
	 gzXjIFlJyFrWDM6dButP2m/w78beObSMeuDCcC6XBQN+wMUof0NDeVOkmTzOIjVsvX
	 vda83iP5GNBiHr2EWkKqMacRAYB3/h7Skld5ia18TmOZJHI90UFAaZW8mFaQN1STnB
	 Oh6nZjIWOrghkf2//6kGQBmZUUIjmUhpBCDv8RxOqziLQlsy0jcZN+1q2uTQorM0z1
	 hBb6oEjPFxvqOmnAsUZrNGVkxxl9jp56aoWwMgfZnCkNkSye/bJUUzrFwapcTh/0w+
	 /p3IkKRDDSeyA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 1/5] mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
Date: Mon, 13 Jul 2026 06:58:32 -0700
Message-ID: <20260713135838.32730-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713135838.32730-1-sj@kernel.org>
References: <20260713135838.32730-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273839-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E78CF74C18E

Due to online parameter update like events, the number of DAMON regions
could be higher than the user-set upper limit.  kdamond_merge_regions()
repeats merge regions until the number meets the limit, while doubling
the merge threshold up to the theoretical maximum threshold.  It is
tried only up to the theoretical maximum threshold because even the
aggressive merging can fail from reducing the number of regions under
the user-defined upper limit.  For example, there could be many
user-defined non-contiguous regions that cannot be merged.

The threshold based loop break condition is evaluated by comparing the
threshold for the next merging try against the theoretical maximum
threshold.  If max_thres is larger than UINT_MAX / 2, doubling the
threshold could make it overflow, and bypass the loop break condition.
In the case, if the number of regions cannot be reduced under the upper
limit like explained above, the loop will run infinitely.

Prevent the case by doing the break condition check before doubling the
threshold.  Also, prevent the threshold exceeding the maximum threshold,
as it could overflow and apply the wrong merge threshold.

This issue is unlikely to occur in real world, since having the
max_thres higher than UINT_MAX / 2 require unrealistically large
aggregation intervals compared to the sampling interval.  Also, it
requires an unrealistically large number of uncontiguous regions setup.
Nonetheless, the consequence is bad and the fix is simple.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org

Fixes: 310d6c15e910 ("mm/damon/core: merge regions aggressively when max_nr_regions is unmet")
Cc: <stable@vger.kernel.org> # 6.10.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 806a67d02a6e9..f3b6a46fdaabd 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3369,15 +3369,20 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 
 	max_thres = c->attrs.aggr_interval /
 		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
-	do {
+	while (true) {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
 			damon_merge_regions_of(t, threshold, sz_limit, c);
 			nr_regions += damon_nr_regions(t);
 		}
-		threshold = max(1, threshold * 2);
-	} while (nr_regions > c->attrs.max_nr_regions &&
-			threshold / 2 < max_thres);
+		if (nr_regions <= c->attrs.max_nr_regions ||
+				max_thres <= threshold)
+			break;
+		if (threshold < max_thres / 2)
+			threshold = max(1, threshold * 2);
+		else
+			threshold = max_thres;
+	}
 }
 
 #ifdef CONFIG_DAMON_DEBUG_SANITY
-- 
2.47.3

