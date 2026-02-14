Return-Path: <stable+bounces-216593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJEXFRXskGlGdwEAu9opvQ
	(envelope-from <stable+bounces-216593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 22:41:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A33EF13DA90
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 22:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A91300FEDE
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 21:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDDE28DB46;
	Sat, 14 Feb 2026 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIlYlZF+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F82556E;
	Sat, 14 Feb 2026 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771105294; cv=none; b=I9YZVIn6q7Esob7aHy3VuLx+a/9IscIBsmT1t9u1HXimSAt0MaxDSzpF377c1QiGt3sMBEzQ6uSOXIncr6XaIu4LpLkNB1S4WcupyA+Oc3IU6lnGTBmAPxsMgqa82ynVyEAf8Y5oAszadK/EnpCImAoKy6vIYPKwVTScZl5WAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771105294; c=relaxed/simple;
	bh=pjkwKmulTQMrj0f/NejRYLH42ooATAnuXxjLQOaFmfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fFydUEDnPUPm7NUAS4XZQHIzK9TfMWC4goCG/RnQ4aN1AsoIkA99QU9VRTuiRZEPEnmOXFHHpfp4XOgceac9C2LSAUWLz266fyCuZgPfQ8Hl8IZr4SfLE2s8njdT9Abqfg7txVCeRcl5TE1Swd/PC/H05mmPgjqO4r29QqLWdT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIlYlZF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B0DC16AAE;
	Sat, 14 Feb 2026 21:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771105294;
	bh=pjkwKmulTQMrj0f/NejRYLH42ooATAnuXxjLQOaFmfM=;
	h=From:To:Cc:Subject:Date:From;
	b=jIlYlZF+4PBNJ7bt04XHmqAWbG0k5pm94I/ik9/XFVg5T9UhMReiebz6qrbNCjikC
	 2VrBquWKBfpb9Wy9KM7Q24Sld5kulGZUULOwxzDwoxy6+d+1SiCPF5aIW21weTa2LV
	 Yltx3HWvDYu+TI7i3NPhEJ/7SnQUmXsRT8BKjvs09BY7YI0svnh4dm6hHDZfKHNjJV
	 j55Qq7pDtKVuS+wS+CSfxxQK7DA4NBt7rATEF6VVe08XrDbABHfMx8fT2UOjcLZo/8
	 3wpnmUzh09Bbba6wsoEuJaIFH2voQemC00BkqAvA2QjKoZBRPdY8CIXExtDgGwkAHj
	 SioomFYV9E26Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 18 . x" <stable@vger.kernel.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/core: disallow non-power of two min_region_sz
Date: Sat, 14 Feb 2026 13:41:21 -0800
Message-ID: <20260214214124.87689-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216593-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A33EF13DA90
X-Rspamd-Action: no action

DAMON core uses min_region_sz parameter value as the DAMON region
alignment.  The alignment is made using ALIGN() and ALIGN_DOWN(), which
support only the power of two alignments.  But DAMON core API callers
can set min_region_sz to an arbitrary number.  Users can also set it
indirectly, using addr_unit.

When the alignment is not properly set, DAMON behavior becomes difficult
to expect and understand, makes it effectively broken.  It doesn't cause
a kernel crash-like significant issue, though.

Fix the issue by disallowing min_region_sz input that is not a power of
two.  Add the check to damon_commit_ctx(), as all DAMON API callers who
set min_region_sz uses the function.

This can be a sort of behavioral change, but it does not break users,
for the following reasons.  As the symptom is making DAMON effectively
broken, it is not reasonable to believe there are real use cases of
non-power of two min_region_sz.  There is no known use case or issue
reports from the setup, either.

In future, if we find real use cases of non-power of two alignments and
we can support it with low enough overhead, we can consider moving the
restriction.  But, for now, simply disallowing the corner case should be
good enough as a hot fix.

Fixes: d8f867fa0825 ("mm/damon: add damon_ctx->min_sz_region")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 925908415a041..55cbf86476006 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1252,6 +1252,9 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 {
 	int err;
 
+	if (!is_power_of_2(src->min_region_sz))
+		return -EINVAL;
+
 	err = damon_commit_schemes(dst, src);
 	if (err)
 		return err;

base-commit: 918647226184ca20e5f86ee7d4df3e34c7433799
-- 
2.47.3

