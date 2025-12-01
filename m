Return-Path: <stable+bounces-197936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BDFC9829C
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 17:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B353A352E
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 16:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5955B30B53B;
	Mon,  1 Dec 2025 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PmfCsJEY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEA81DE887
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764605046; cv=none; b=FZKNcyhCLpfMkkdtHQT3KIS9WQYiesPj+Yqu4XiEP7aIjKomsm04rttabT8ZFMwczYGIbR8WyBOHUaEkR6vFg4+FHt/ofuSpvXMNHTJ4UCw+xhKJKp+i1Ss/bbnkwauwfkT+7XZtUIU7SBhRdX37mw0wq7axW7/DBLa5nUuB8L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764605046; c=relaxed/simple;
	bh=m5MQNOqsrMcBIuZ9Fg12UAS+JsIBu0EIME8wSFCzkV8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W5TxIbL0Xfm48egWYE/ZDYJwpksJRBvInWz0kLb74PhiQ7a1xdXgK/aSu2+Q1kqWRqCsfZDQBVKL04BWyEOmqM1snEa6ukaQJxe+8ZwemE0Ww97Tt8o68zPVV3oWRBWfiqixMPAlH09XCvuFYivV04ODWKap1VgQX/RNy3qECFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PmfCsJEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11404C116C6;
	Mon,  1 Dec 2025 16:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764605045;
	bh=m5MQNOqsrMcBIuZ9Fg12UAS+JsIBu0EIME8wSFCzkV8=;
	h=Subject:To:Cc:From:Date:From;
	b=PmfCsJEY2U5poQwQQ1EDgG9ip3ql8kRNY+e4LUQbKURy4R310w5Gse/8oy6fL2Bqi
	 xfF5e238/I169ucEzdUB7Zs5DvHJ7ZHa6mebODgC2WbuPsWkqqs/L8eZhGk48up4P7
	 daAaWN8kKC40z/suPfSuyudfcOqzMVAqn/uRqD3s=
Subject: FAILED: patch "[PATCH] mm/huge_memory: fix NULL pointer deference when splitting" failed to apply to 6.12-stable tree
To: richard.weiyang@gmail.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,david@kernel.org,stable@vger.kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Dec 2025 17:04:02 +0100
Message-ID: <2025120102-geranium-elevator-ca86@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cff47b9e39a6abf03dde5f4f156f841b0c54bba0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120102-geranium-elevator-ca86@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cff47b9e39a6abf03dde5f4f156f841b0c54bba0 Mon Sep 17 00:00:00 2001
From: Wei Yang <richard.weiyang@gmail.com>
Date: Wed, 19 Nov 2025 23:53:02 +0000
Subject: [PATCH] mm/huge_memory: fix NULL pointer deference when splitting
 folio

Commit c010d47f107f ("mm: thp: split huge page to any lower order pages")
introduced an early check on the folio's order via mapping->flags before
proceeding with the split work.

This check introduced a bug: for shmem folios in the swap cache and
truncated folios, the mapping pointer can be NULL.  Accessing
mapping->flags in this state leads directly to a NULL pointer dereference.

This commit fixes the issue by moving the check for mapping != NULL before
any attempt to access mapping->flags.

Link: https://lkml.kernel.org/r/20251119235302.24773-1-richard.weiyang@gmail.com
Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2f2a521e5d68..6cba1cb14b23 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3619,6 +3619,16 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (folio != page_folio(split_at) || folio != page_folio(lock_at))
 		return -EINVAL;
 
+	/*
+	 * Folios that just got truncated cannot get split. Signal to the
+	 * caller that there was a race.
+	 *
+	 * TODO: this will also currently refuse shmem folios that are in the
+	 * swapcache.
+	 */
+	if (!is_anon && !folio->mapping)
+		return -EBUSY;
+
 	if (new_order >= folio_order(folio))
 		return -EINVAL;
 
@@ -3659,18 +3669,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		gfp_t gfp;
 
 		mapping = folio->mapping;
-
-		/* Truncated ? */
-		/*
-		 * TODO: add support for large shmem folio in swap cache.
-		 * When shmem is in swap cache, mapping is NULL and
-		 * folio_test_swapcache() is true.
-		 */
-		if (!mapping) {
-			ret = -EBUSY;
-			goto out;
-		}
-
 		min_order = mapping_min_folio_order(folio->mapping);
 		if (new_order < min_order) {
 			ret = -EINVAL;


