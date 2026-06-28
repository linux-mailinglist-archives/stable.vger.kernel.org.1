Return-Path: <stable+bounces-269592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xjQGLHiYQWrWsQkAu9opvQ
	(envelope-from <stable+bounces-269592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 23:56:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ADD6D50B6
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 23:56:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RAh3iceE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269592-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269592-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40CA6302AC03
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 21:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638043B9D9E;
	Sun, 28 Jun 2026 21:54:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A283B95F2;
	Sun, 28 Jun 2026 21:54:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683696; cv=none; b=P0cTOETZ7jKojZJd3wDRJHvT+amsUsXAsh8f0we42DS52cQ7+F1vXYM3b8WZTxy2QAHRd4ftzsii7D4PhOZ1qRP67/VJzVRyhFajxXzgYH8M1ZnVhZ3IViZ/fr+n9ycqUntJuj4V7sFaRLJG9D6qVhszKqdvmvTj4fi0wSUBk1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683696; c=relaxed/simple;
	bh=n/t3/pdVXS0Jt0TAUkoYM31IalaCViDcV8Ahgd4JMJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxmbZNz0ojObvGal6Mw26Z2Yow3nUjGJ4BNe/FZDEWcNY/exINAkrGn8XabXoO9Tp5EWpgowAB7wUR0/qwtlL2DMceYzbq27yu6pQ6nD1kKmUHHA7pXwkaWQgt0Hu44WyF8ttsjYkGpcTbhWvCaOuKEvKjYH76q4XJOB++vGzD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAh3iceE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1D91F00A3A;
	Sun, 28 Jun 2026 21:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782683694;
	bh=qdss7KwiVKURhK0NoHx/6TLcyP6FekMODUWc+wtuLzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RAh3iceE+2/jLRIbPExiF4OEJXdK1pOSagWGRv2I22jnZuwEXyPdTVEoMGr9MedDV
	 HepS3fjZxFpRxcffJphSwDhqy2/m4O0B0I7mtMdwXSZAaUme/oCsB4GZiOYBLHrhQT
	 uoKkRg3WyJ4/SC4ErgiQ5AUKonTAE+1LDgeIobyGAGB6VvvPfUoP3h+UPCubvhWIZP
	 P9Fb71spOW/ehbld5FNPoBXyUVRqxBRYg8dalvE6umO6egz3WjrQtX39oJ6u2Cp4r0
	 aXw2fOKURDb+ZHGiNoy1KVZscF4PeLXuYAsjRaOlRJuAmVXbhcE7bahFHYTeLTjGm7
	 L0vL7r2qhp3nw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH 4/6] samples/damon/mtier: handle damon_stop() failure
Date: Sun, 28 Jun 2026 14:54:43 -0700
Message-ID: <20260628215447.96166-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628215447.96166-1-sj@kernel.org>
References: <20260628215447.96166-1-sj@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:sj@kernel.org,m:stable@vger.kernel.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:zenghui.yu@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269592-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1ADD6D50B6

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
Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
Signed-off-by: SJ Park <sj@kernel.org>
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

