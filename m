Return-Path: <stable+bounces-254046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAe/Mog5E2r09AYAu9opvQ
	(envelope-from <stable+bounces-254046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 19:46:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2631F5C3504
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 19:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41E3A30071D0
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 17:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F152ED870;
	Sun, 24 May 2026 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvWzH3mc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521DC285066;
	Sun, 24 May 2026 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779644778; cv=none; b=AhGfaXkRkjGxiNtmQY1MZ1dAPedAhTlEbzuU9yA/JFLgtQmic0Le+yuz7mskgu9dDqVurnBVI4v+aYkwnNQ48+ycN4KrF6LcoZsjzQ+m05xXW8QvUE9kkC7S9aUvC6aO1Rk3icB4c4YXODQFH7kCQulEQjvDCYr+l5tpNBdSVUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779644778; c=relaxed/simple;
	bh=D9V8RhGUrdDW5NOa0gr06FY1nmxytjBARffB1Ils0M4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sYcuyJAgS0OHqIkkh8q3dfeSR1/o3wgEcIg501A6f9DPGhcvlVQSBdAmED5JwDfvyHRmmszX3UeLAs4Cw8AljTwxmSphH7WP4EZCJ2a6RjmqgzhOhdXlfH8F25uWSWeJ1FHnxa9pC3ZoQpfRFLyKF8kjNYdhRwN7fCrEQZEUz8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvWzH3mc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5EF1F000E9;
	Sun, 24 May 2026 17:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779644777;
	bh=uBIKyCDUB4AI2j953g540RjbdIOwXHSPmEWd/lmfFd8=;
	h=From:To:Cc:Subject:Date;
	b=DvWzH3mcrvKY3cjnYwotg5mUYKLb8jHI/4yzSTjUWoxSvfKxV8VO9lcJSONFtzOPC
	 B0WTssgk/v7CM0q3iY5uQkTNV/p9vsB2ID3IDcQZWC35VrihN0v82e2+j+dzpPopa6
	 m8/Dmz82tYqTJrjbSVngHh1RDjVTgdpK2eMmm1sLTW8K7WdIqV2hnxPHW5ckkS4NpS
	 nbKfYxkIddoIX2hjYU16kQFgzIeIrTf6AaBHL2TTuP7q2RDkbiUco1NyRssNjonTyx
	 KVjI6xNkxSdVvQdNZP897Bnr05ksiW0UrShKlGE/fC8DHRpEAIGopnYybrnNE5K7Fi
	 vfQ3n3ZQk/8Kg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 15 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1] mm/damon/ops-common: call folio_test_lru() after folio_get()
Date: Sun, 24 May 2026 10:46:06 -0700
Message-ID: <20260524174608.81112-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254046-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2631F5C3504
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

damon_get_folio() speculatively calls folio_test_lru() before
folio_try_get().  The folio can get freed and reallocated to a tail
page.  In the case, VM_BUG_ON_PGFLAGS() in const_folio_flags() can be
triggered.  Remove the speculative call.

Also mark folio_test_lru() check right after folio_try_get() success as
no more unlikely.

The race should be rare.  Also the problem can happen only if the kernel
has enabled CONFIG_DEBUG_VM_PGFLAGS.  No real world report of this issue
has been made so far.  This fix is based on only theoretical analysis.
That said, a bug is a bug.  A similar issue was also fixed via commit
3203b3ab0fcf ("mm/filemap: don't call folio_test_locked() without a
reference in next_uptodate_folio()").  I don't expect this change will
make a meaningful impact to DAMON performance in the real world, though
I will be happy to be corrected from the real world reports.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org

Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260523194145.93122-1-sj@kernel.org
- Do not change post-folio_try_get() validation order.

 mm/damon/ops-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 3a0ddc3ac7196..5c93ef2bb8a97 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -32,9 +32,9 @@ struct folio *damon_get_folio(unsigned long pfn)
 		return NULL;
 
 	folio = page_folio(page);
-	if (!folio_test_lru(folio) || !folio_try_get(folio))
+	if (!folio_try_get(folio))
 		return NULL;
-	if (unlikely(page_folio(page) != folio || !folio_test_lru(folio))) {
+	if (unlikely(page_folio(page) != folio) || !folio_test_lru(folio)) {
 		folio_put(folio);
 		folio = NULL;
 	}

base-commit: d30b72f4d0d4a88b1162143322bc99b1fce6ea67
-- 
2.47.3

