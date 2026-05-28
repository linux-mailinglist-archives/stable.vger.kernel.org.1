Return-Path: <stable+bounces-254721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +INvLRrdF2oUTggAu9opvQ
	(envelope-from <stable+bounces-254721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 08:13:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBA25ED2C2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 08:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E479E30BF8A5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 06:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDA232B124;
	Thu, 28 May 2026 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs27dfN2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4824313550;
	Thu, 28 May 2026 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948677; cv=none; b=N/Ue3AkbSfqoHyVnuPgQKfsqy8uBoXTfbmgP26pvC8jSOnEMzxK/O6O8ZCAQl6N8ciEzyvR9mQGuMGAOM1vu4R64Fnt0NiRRKWGlP1pbA++Ry/HfDUGlQY5F3bvpKh57qZ7ZXw5TH8nmLDJ3zXRjhK/VXvbcXHr9yJozAVzEFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948677; c=relaxed/simple;
	bh=syR8gk/1Kn3wTXFIT82Sc+Spvg8Sajy64FM66/WxSLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGAD/ef2dz5K5KXwkOLFNAQ4bNu2ILMGKO6aw0fYyVlDN0pKMlh9HIcdQzKd9k7YRLx7g2xXuLSHQjXL+R9Uqnmzgf+BIf0c4LUT+jB/XR4J30q3UiK/9eQ4op4S65eqIFJN2w91TOL1E0pBX52cwFya6sxVj/K+VktKtcLzzAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs27dfN2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F243F1F00A3D;
	Thu, 28 May 2026 06:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779948676;
	bh=8uMRK9tYWaXpNpaEqAhpqFf64f/zJybxf3IUBnmYDVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gs27dfN21CiTt+PgfYYZx9Ka1+VQ/7yaR6M6MNvCNPmtci4NRpxu14XTw3/d6dYs8
	 HFT34C/cmGeM5zLSGKmCyKoNDf9qUp9MA5JfQzDpzty6SXc6Pdu34ueDpxBAk0eT4f
	 46AfpjGYpBbuTw+AH3bu+iq8U/gX+MTdrqaBZymNyp4B8elHWRedu65GC3IkBxXUD4
	 x4Jhfs24++lnYUzLNNgscL5bquYsiFBNDyzl4gtgVLtgwLgWxRHgM9ZTYQsTPgJwNZ
	 C2GBpnYGRRkGc+3at035kkfF0rrq+nW+RJ3AluHwrcnMA2OB1QNompcuPBFMyCH6De
	 dh9XD/40Jvrng==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/2] mm/damonn/lru_sort: handle ctx allocation failure
Date: Wed, 27 May 2026 23:11:09 -0700
Message-ID: <20260528061110.2172-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528061110.2172-1-sj@kernel.org>
References: <20260528061110.2172-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254721-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1CBA25ED2C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DAMON_LRU_SORT allocates the damon_ctx object for its kdamond in its
init function.  damon_lru_sort_enabled_store() wrongly assumes the
allocation will always succeed once tried.  If the damon_ctx allocation
was failed, therefore, code execution reaches to damon_commit_ctx()
while 'ctx' is NULL.  As a result, it dereferences the NULL 'ctx'
pointer.  Avoid the NULL dereference  by returning -ENOMEM if 'ctx' is
NULL.

Fixes: c4a8e662c839 ("mm/damon/lru_sort: use damon_initialized()")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index eca88ed941b32..8298c6001fd09 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -476,6 +476,10 @@ static int damon_lru_sort_enabled_store(const char *val,
 	if (!damon_initialized())
 		return 0;
 
+	/* damon_modules_new_paddr_ctx_target() in the init function failed. */
+	if (!ctx)
+		return -ENOMEM;
+
 	return damon_lru_sort_turn(enabled);
 }
 
-- 
2.47.3

