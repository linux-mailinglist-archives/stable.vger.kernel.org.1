Return-Path: <stable+bounces-223945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ABHCM/8r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 968B324A21B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1E8331661BC
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB71313537;
	Tue, 10 Mar 2026 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2TgovUo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B622BF3E2;
	Tue, 10 Mar 2026 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141080; cv=none; b=NqIUDaTbn/TFjuWCVTSGv4+aSn3NS+kBV9J4I+IcbmaeUHYa1ZyamHU8vlrniIVT68dIYDEIIr0qOyFywceAGCaNuDlLS1DfGzlQdU9rMSSOg5t4vkxjj+yxOh2QAATXH30BLc9frTVGYfLMc2HWVsDZ78EOUukHm6flakuGOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141080; c=relaxed/simple;
	bh=jqf7/qLX9U5APWKsGf8/pfELpobv0EkK+qCk3MQqkog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwbaEwql/aJjFBPRfJhziKqTwUQBLrY0eUxOYjR1Fzhaa56/kCF2ykurcAQ9c+Zqja6cH72uxkTOOmxRs706gZgKdsOpfVZ8SVC9wg1/sfgW371odyl4QseuMmDXUc3cEdmhyL4Cge6zDd3bxM/BnVA15VHCgylF62ctZ3DYCag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2TgovUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A4DC2BC9E;
	Tue, 10 Mar 2026 11:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141080;
	bh=jqf7/qLX9U5APWKsGf8/pfELpobv0EkK+qCk3MQqkog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2TgovUomUjxJgjeifI1Qyhkcjn6ai1RPO0s7TVk7TvA2diQdxdW3qK639WRpeBWN
	 dQUCbr3Ph/a0s6CoJWCr8m51B8HP+wBpA6yKLdVt3pw8nNh6lQYjFfO+8ci80VqmOG
	 RvspI8WZ4UXww0+dKjGZEfz04wibodublwaqqS3v60zm2dd0KB2RrzwzLQeVejcb21
	 i3lXOfM81ZiZbwFWq/8tKq//3OXmzsSYWSHu7vUXhtS7t6nzs97rHZ20EE37XgkXeA
	 dqX3QTnv7NM5UcKXXxam0FjeWJfjCDo7H48urtns2Oa2D3xUbEATN+kXO54JXsCSwp
	 qnCwbynOaC7DQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Harry Yoo <harry.yoo@oracle.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 080/311] mm/slab: pass __GFP_NOWARN to refill_sheaf() if fallback is available
Date: Tue, 10 Mar 2026 07:02:07 -0400
Message-ID: <5c45fb8347c5ead932dac1c5f9a430e7474829d9.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 968B324A21B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223945-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Action: no action

From: Harry Yoo <harry.yoo@oracle.com>

[ Upstream commit 021ca6b670bebebc409d43845efcfe8c11c1dd54 ]

When refill_sheaf() is called, failing to refill the sheaf doesn't
necessarily mean the allocation will fail because a fallback path
might be available and serve the allocation request.

Suppress spurious warnings by passing __GFP_NOWARN along with
__GFP_NOMEMALLOC whenever a fallback path is available.

When the caller is alloc_full_sheaf() or __pcs_replace_empty_main(),
the kernel always falls back to the slowpath (__slab_alloc_node()).
For __prefill_sheaf_pfmemalloc(), the fallback path is available
only when gfp_pfmemalloc_allowed() returns true.

Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Closes: https://lore.kernel.org/linux-mm/aZt2-oS9lkmwT7Ch@debian.local
Fixes: 1ce20c28eafd ("slab: handle pfmemalloc slabs properly with sheaves")
Link: https://lore.kernel.org/linux-mm/aZwSreGj9-HHdD-j@hyeyoo
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Link: https://patch.msgid.link/20260223133322.16705-1-harry.yoo@oracle.com
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 889c2804bbfeb..b68db0f5a6374 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2715,7 +2715,7 @@ static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t gfp)
 	if (!sheaf)
 		return NULL;
 
-	if (refill_sheaf(s, sheaf, gfp | __GFP_NOMEMALLOC)) {
+	if (refill_sheaf(s, sheaf, gfp | __GFP_NOMEMALLOC | __GFP_NOWARN)) {
 		free_empty_sheaf(s, sheaf);
 		return NULL;
 	}
@@ -5092,7 +5092,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 
 	if (empty) {
-		if (!refill_sheaf(s, empty, gfp | __GFP_NOMEMALLOC)) {
+		if (!refill_sheaf(s, empty, gfp | __GFP_NOMEMALLOC | __GFP_NOWARN)) {
 			full = empty;
 		} else {
 			/*
@@ -5395,9 +5395,14 @@ EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
 static int __prefill_sheaf_pfmemalloc(struct kmem_cache *s,
 				      struct slab_sheaf *sheaf, gfp_t gfp)
 {
-	int ret = 0;
+	gfp_t gfp_nomemalloc;
+	int ret;
+
+	gfp_nomemalloc = gfp | __GFP_NOMEMALLOC;
+	if (gfp_pfmemalloc_allowed(gfp))
+		gfp_nomemalloc |= __GFP_NOWARN;
 
-	ret = refill_sheaf(s, sheaf, gfp | __GFP_NOMEMALLOC);
+	ret = refill_sheaf(s, sheaf, gfp_nomemalloc);
 
 	if (likely(!ret || !gfp_pfmemalloc_allowed(gfp)))
 		return ret;
-- 
2.51.0


