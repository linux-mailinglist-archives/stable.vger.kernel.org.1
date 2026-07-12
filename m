Return-Path: <stable+bounces-273507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CHNCEYLJU2okfAMAu9opvQ
	(envelope-from <stable+bounces-273507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 19:06:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 884D674575E
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 19:06:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mjT+7kGG;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273507-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273507-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6916D304C077
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 17:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E15367B9F;
	Sun, 12 Jul 2026 17:03:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9F340410;
	Sun, 12 Jul 2026 17:03:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783875821; cv=none; b=p3gatf67QZGQbozk+xMMcbHn0dSZldLWaruzCmRcww3ons7yfqjVJ5eJLr7AtO7cxO0v2pUYNQDEwSanL1E/NogkBTlXRgayMjbfD2iXE8fvzo0N29J8C8YEX7YuD9lV3437AhIIJ2xHoF/aKEoFDzrw6CuXnPkeBxIbuhERBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783875821; c=relaxed/simple;
	bh=2YTUi5fssLwguc0tdmj+L1Qs0tTe4BqhfdbB6oOiClA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzE3/MA1h92WFN8hYJL8LglyNkrt16HBgnYdbauyUC/b352wkcoZmczHO4shXqw5y8EHR1E4VnTEFMx8+PdQdM7SPAepcxx/dIJsNvukDnqysYkX9LPoA0oDlf4Iub+MO3URuwASzcOjQp/o3EV5tiGW7UCf8hz4A1AYIs5T8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjT+7kGG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC761F00A3E;
	Sun, 12 Jul 2026 17:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783875819;
	bh=SKLq7ZuoHq2BFm176pu4DfNEYfPU8F0EbpgzHa8ZXlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mjT+7kGGAZYWj8JiuahXfYm2MBh7kCuE9DE+qZXwgVLnf66mD8V7l5743EVqT/ZB+
	 px2Kktm5XGebVXuPIEqzhuGDyAxeou/Yg5M3DlHa+j3Fh1/kpD0DD6txtSqp5RfQ/y
	 lcFGHl2+XcewCNUxbjxgMnH9R0lVWko4XgbBORuqZ8AbCbSt3DFRDv8l8RRKBcrZQu
	 7eMhcaAEkzAYqX+zbo0qSI7Cf9AVEST+FwnpkEYdutt7uaJ2VpVjONtoiPhR2ZeCgT
	 yXnTXCwj6RviPh1VazChP3DAGy28Q8nkBEV+kuYR+vDUeAfMfNytJrGMvgT14wTs20
	 D6KhmXJ2YEGMQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	SeongJae Park <sjpark@amazon.de>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 2/5] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Sun, 12 Jul 2026 10:03:24 -0700
Message-ID: <20260712170328.91144-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260712170328.91144-1-sj@kernel.org>
References: <20260712170328.91144-1-sj@kernel.org>
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
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:brendan.higgins@linux.dev,m:davidgow@davidgow.net,m:sjpark@amazon.de,m:damon@lists.linux.dev,m:kunit-dev@googlegroups.com,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273507-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 884D674575E

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
index 6ad73559dd8ea..a99363720e677 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -260,11 +260,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	damon_merge_regions_of(t, 9, 9999, ctx);
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

