Return-Path: <stable+bounces-262503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sb6RJQluKWruWgMAu9opvQ
	(envelope-from <stable+bounces-262503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 16:00:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 197EC66A0B7
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 16:00:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Rji3sPlq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262503-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262503-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86CD3314C7B4
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 13:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED58413616;
	Wed, 10 Jun 2026 13:55:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1D411687;
	Wed, 10 Jun 2026 13:55:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099759; cv=none; b=AQzKSSwRTkRaf4L0mZplH2N2PBSKOYvLmGHSnrVM52RKtRrBm/ZohBSI21us7uibd4+HDGVYM7B3TAYDO8K6MaU0WDJQPrOXiHSLCsgBwS8aQjTFZTsWnnWY4PGZDNiqO2oNx4rMsgfsKsj0vBC5OCTovU47PS6stk4qqvIjuyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099759; c=relaxed/simple;
	bh=enbigSKfZhHs55sFswY1ofWl2WsfR5xtqPL9/la+0Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDsq7yTv6CWeYmRQN11mePUuBfOX7Re+a7YMdA9S9/fWyfF1zq8MB9YPrbce5iz9paA33tzpljYoTzhECcIsYWKyMbx5zeSRvLSMJXx4glUjGNEsAHxP8CgGYCiMbb9Wf2effDAY9eH/RAQfWY3zyLKsz/+YY4o7+IyMY95lrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rji3sPlq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4991F00893;
	Wed, 10 Jun 2026 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099757;
	bh=wvTmgzWVeo+cgK/5Fasuy9LNL6Vq1lM40f7iFKommVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rji3sPlqTY8ctgiYIT9CS7Y49q7tR0k6yOM2EHlHJxaxhefyvT56Z4d8udfEUajwB
	 KvkJHgfh5cbOSx6wEKZATBQfuvsAxdepjtiqaS8Pyk7OOsGfM1rxlIhF5gho1hEhpv
	 1+DAxz5IqAUFViWqsp4HF4jFvKcHi3mjr0zRpGY+EZ3MmExzagpwV47KeSbjHTP1u3
	 I1z8PGc2/8prMVoAza0dBmaA32J10LmYm33c1lRvbOtXvJK9WJwg3bg8nGy9ROCoq+
	 O2x69ckdQhHNAtLTxPFtRNByinbhkTVSrezp8gN9HU8g71V4clAzrBS8cZa8w6zxeG
	 WyR3+cd1IFNww==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 4/6] samples/damon/mtier: handle damon_stop() failure
Date: Wed, 10 Jun 2026 06:55:42 -0700
Message-ID: <20260610135546.64943-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610135546.64943-1-sj@kernel.org>
References: <20260610135546.64943-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262503-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 197EC66A0B7

damon_sample_mtier_stop() assumes its damon_stop() call will always
successfully stops the two DAMON contexts.  Hence it deallocates the two
DAMON contexts after the damon_stop() call.  However, if a given context
is already stopped, damon_stop() fails and returns an error while
letting the DAMON contexts that have not yet stopped keep running.  This
kind of unexpected early DAMON context stops could happen due to memory
allocation failures in kdamond_fn().  Because damon_sample_mtier_stop()
just deallocates all DAMON contexts with damon_target and damon_region
objects that are linked to the contexts, the execution of the unstopped
DAMON context (kdamond) ends up using the memory that freed
(use-after-free).  Fix the issue by separating the damon_stop() to be
invoked per context.

Note that DAMON_SYSFS also allows multiple DAMON contexts execution.
But, it calls damon_stop() for each context one by one.  Hence this
issue is only in mtier.

For the long term, it would be better to refactor damon_stop() to always
ensure stopping all contexts regardless of the failures in the middle.
Make this fix in the current way, though, to keep it simple and easy to
backport.  I will do the refactoring later.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260609014219.3013-1-sj@kernel.org

Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/mtier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 66b591f2180fa..faaaaa12e6206 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -199,7 +199,8 @@ static int damon_sample_mtier_start(void)
 
 static void damon_sample_mtier_stop(void)
 {
-	damon_stop(ctxs, 2);
+	damon_stop(ctxs, 1);
+	damon_stop(&ctxs[1], 1);
 	damon_destroy_ctx(ctxs[0]);
 	damon_destroy_ctx(ctxs[1]);
 }
-- 
2.47.3

