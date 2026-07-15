Return-Path: <stable+bounces-274709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KGtyKCf6VmqVDwEAu9opvQ
	(envelope-from <stable+bounces-274709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 05:10:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DB275A380
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 05:10:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hdwQejIq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274709-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274709-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4C793013C7F
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 03:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A643A9635;
	Wed, 15 Jul 2026 03:10:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6D36215B;
	Wed, 15 Jul 2026 03:10:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784085014; cv=none; b=Mk2hfcWqe0sOjJGJqlOD+QdLT0nQ0+cI3nWLpERXc/fi77FtrTaxi+JaKtmrgJuH/GmRrDrHQcYTedqkf+he34+hKg24R/zACfAmii8OPaNpphqRw+B3PbboUcDFm+aLjplyJL/AKuizpMFhskjZ/3FE0xclx1k/4jZPUe8vpwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784085014; c=relaxed/simple;
	bh=oa/Api2m6C6paRLqdcrPW1anhL7pYe2ZAUU7W+EEjsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtZgv8XsqNsbFU9U3FkTvlK40w1dmd88umaZ7rDStwam2LLPczVjYqZo3cEcDIKsiX8jkFN40iw/Q7mcwCXXrKIzkovQ/pa0GlsF4n0jeT6xXopEOrUwMXQXVAKRseOg0mat09PtZGfxxXl7RUFfmeAMG3eIt6yEkg9L0KV3IaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdwQejIq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D9A1F00A3E;
	Wed, 15 Jul 2026 03:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784085012;
	bh=Csk2Bs95SoFAJpGitaPFL2lXi5OcS5tAvUkrHnWNWRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hdwQejIqjSXVn6ZOjjgrAJxWrno8uipge6ifEx+jog45KonTkm+btFthmQAKpVfGY
	 0lJqAjEeCtWVkb3LH5/9Rh3jnbfuu/DkUFS5DORwogllwKC71kxDCU4xDTxYtyxG/8
	 TwHmM9R05lRNvUclDVUams2YNzRAzh6erkKutdnASE02fLexoXyXpg7rKd8/2lOYqu
	 DWMfD6VbNrS+gZHEUeuwMlDEWMMtwZoAkVRjTdK2XBtV9TUo8+/sZIuMXaqs/PGXUb
	 jI6CmAHHekvsgEt0luLBay+leef/Kv8/pd601qEHt3iU61R8KZ7LNGoN8HmQXIEl5o
	 fhuANby88ZDVQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	SeongJae Park <sjpark@amazon.de>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1.1 2/6] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Tue, 14 Jul 2026 20:09:57 -0700
Message-ID: <20260715031002.108504-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260715031002.108504-1-sj@kernel.org>
References: <20260715031002.108504-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:sj@kernel.org,m:stable@vger.kernel.org,m:brendan.higgins@linux.dev,m:davidgow@davidgow.net,m:sjpark@amazon.de,m:damon@lists.linux.dev,m:kunit-dev@googlegroups.com,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274709-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92DB275A380

KUNIT_EXPECT_EQ() does not abort the execution of test code when the
expectation is not met.  But damon_test_merge_regions_of() code after
its initial KUNIT_EXPECT_EQ() call assumes the expectation is met.  It
does a per-region test with a hard-coded number of regions that is
correct only if the expectation was met.  As a result, __nth_region_of()
could return NULL, and the test code can dereference NULL pointers.  Fix
the issue by catching the expectation failure and skip the per-region
tests.

The user impact on realistic setups should be negligible, as it is a
unit test.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 485472ddebd19..eba643762132f 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -260,11 +260,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	damon_merge_regions_of(t, 9, 9999, ctx, true);
 	/* 0-112, 114-130, 130-156, 156-170, 170-230, 230-10170 */
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 6u);
+	if (damon_nr_regions(t) != 6)
+		goto out;
 	for (i = 0; i < 6; i++) {
 		r = __nth_region_of(t, i);
 		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
 		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
 	}
+out:
 	damon_free_target(t);
 	damon_destroy_ctx(ctx);
 }
-- 
2.47.3

