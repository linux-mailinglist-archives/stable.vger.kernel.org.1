Return-Path: <stable+bounces-262505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M1G9NEVuKWoeWwMAu9opvQ
	(envelope-from <stable+bounces-262505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 16:01:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8143E66A0CC
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 16:01:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bcr15hwW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262505-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262505-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C5CE3166626
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B241A25A359;
	Wed, 10 Jun 2026 13:56:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397D41325C;
	Wed, 10 Jun 2026 13:55:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099760; cv=none; b=QDu8u6X4rYEyetn1NZ1Azq6KYQ0XWfGZ2yiMfpUz7eJbDzNpMHHyxRVRpXWhp/ZvO9PhuZ8+YsRxQcWUfsPv5BjveDNhdJajxkielgcsSFYQq4hjdmbVtdjDplfwezw0JG02mi0CXwHIWVg6Dr7jgaiNKbDuDms4Gb5y+5oYUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099760; c=relaxed/simple;
	bh=tyY/UdZQq2D/sVxcxXfMLKmhuTV2Mi47LEa0TyPuc24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnTKeEX9UWX852V9XvwI5UkBO6gkrdKTrQHZdMDpQMtHegyUdpZ4epKt7/rRuA6OKF8rE3i7laUiVEhGolYJQCoMqhtiaiNMIwtub0D798WpDCW8rwnP5YR9oWAAujQP7lHEmRl3OdiXIuwwsStyhiUlL/9BjDXKWi9v2+t1w18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcr15hwW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02171F0089A;
	Wed, 10 Jun 2026 13:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099759;
	bh=Q4eyIQGc8+YbZ/+RebaJPmK558jLRcrZFCvASXPTF6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bcr15hwWNAfWGBze970neza/Riie2JsT2EdEpr8fVGGSz/6GM2MidgoBinploF7aB
	 /mSVBSfQKFx0TXZi42o7h9jrs2eo4St4BNqW9RUHXl+SUJ6U8KWCskCFY7TQmuXUoi
	 HhQvD925TuFMndmRQsZy8rexLZgA5rUmcw+cp1Rm0SjTH267TO7xydap/4uw/zrgOb
	 ys7XestTmnfII6oJs+RE+lc7U4EocNkoxEMJKZ3KFayltTHMpk+Em8DkhmS9LmUeJ/
	 r5DkrntC04oRcE9ievA7cc5Wi1rranE237bxLJ04yUFDhAP2X6i74MW5Mea5FFg+vk
	 nuxRaNeekQP8A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 6/6] samples/damon/prcl: stop and free damon ctx when damon_call() fails
Date: Wed, 10 Jun 2026 06:55:44 -0700
Message-ID: <20260610135546.64943-7-sj@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[vger.kernel.org:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262505-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8143E66A0CC

damon_sample_prcl_start() calls damon_call() right after damon_start()
is succeeded.  The kdamond that has started by the damon_start() could
be terminated by itself before or in the middle of the damon_call()
execution. There could be multiple reasons for such a stop including
monitoring target process termination and kdamond_fn() internal memory
allocation failures.  In the case, damon_call() will fail and return an
error without cleaning up the DAMON context object.  The
damon_sample_prcl_start() caller assumes it would clean up the object,
though.  When the user requests to start DAMON again,
damon_sample_prcl_start() is called again, allocates a new DAMON context
object and overwrites the pointer for the previous object.  As a result,
the previous context object is leaked.

Safely stop the kdamond and deallocate the context object when the
failure is returned.  Note that the kdamond should be stopped first,
because damon_call() failure means not complete termination of the
kdamond but only the fact that the termination process has started.

The user impact shouldn't be that significant because the race is not
easy to happen, and only up to one DAMON context object can be leaked
per race.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260610035214.4850-1-sj@kernel.org

Fixes: a6c33f1054e3 ("samples/damon/prcl: use damon_call() repeat mode instead of damon_callback")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/prcl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 0db2598946911..edeae145c4a8a 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -112,7 +112,12 @@ static int damon_sample_prcl_start(void)
 	}
 
 	repeat_call_control.data = ctx;
-	return damon_call(ctx, &repeat_call_control);
+	err = damon_call(ctx, &repeat_call_control);
+	if (err) {
+		damon_stop(&ctx, 1);
+		damon_destroy_ctx(ctx);
+	}
+	return err;
 }
 
 static void damon_sample_prcl_stop(void)
-- 
2.47.3

