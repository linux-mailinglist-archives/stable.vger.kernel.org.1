Return-Path: <stable+bounces-198005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B09C995EE
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 23:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9473B4E23B9
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 22:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3D725F988;
	Mon,  1 Dec 2025 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyC3LWN+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8DB23AB95
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764627508; cv=none; b=bs+QbdyvnowFjQMkqkNCu0GmzHMnKARK84EFqChXLvnQVa0SrxipG4gWo4gc+jh3oQB3cE+6KxCiP+qn09nSo6XhMGAVXEG81k9WVRFiVrPhgYzt1dsO+fJsgjNTB7KWx+Kvvd4BTFbx3T1F91Qyi/2OmFJ+kWYvgaA4jbxInMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764627508; c=relaxed/simple;
	bh=DQrz4Oi3KOTQ6DszB4A3PDYNK4q7rvFCEyGO7op2j6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1vn09KEet0diKeSgCLI/7cLHjRv17lDii7cNbtkHOVj018tQg8LG452JXzE0ziF0Z9VSlnkAnRdr+w62nTkgyvjS3IYWoke3PIuJIcui3QYUMdNnSuZwLcDfAKyfcdSYmZC+FRsLA3yO0kA2+1NCJzIVCADm4IbViCr6weoGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyC3LWN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5A4C4CEF1;
	Mon,  1 Dec 2025 22:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764627508;
	bh=DQrz4Oi3KOTQ6DszB4A3PDYNK4q7rvFCEyGO7op2j6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XyC3LWN+VtWcfQExMFUJeofdBXvkVokPqZbeR5Bl16RuEl+SsKK8+dWuOTQ8ufzg1
	 i9KJMT+2PoMUAz3Q+eD8ynYqEBD8aL9+zSwRrwchac1PPQW/Qh5+03jDhz8eJZsRSU
	 vndeLitD8FYVyAbh1VcqXyXqRWLyNmQC09bjxmqpjonBqhP4xo3aWR0yPTiU4WOrXK
	 CaCVxQsyNLXxnN+NmBwY769fWhB/8ox+1lj7yZLiRzcDtEw4OIn43MxZ6twb5UE62n
	 gu6sJyCyfei128BDZNBvPz2EPKkWHm97ngdHxXtF593GEq3UOYxZvM3q0uPbF4k+F/
	 ACnU2vaPvPtxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/huge_memory: fix NULL pointer deference when splitting folio
Date: Mon,  1 Dec 2025 17:18:18 -0500
Message-ID: <20251201221818.1285944-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120102-geranium-elevator-ca86@gregkh>
References: <2025120102-geranium-elevator-ca86@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Yang <richard.weiyang@gmail.com>

[ Upstream commit cff47b9e39a6abf03dde5f4f156f841b0c54bba0 ]

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
[ applied fix to split_huge_page_to_list_to_order() instead of __folio_split() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d68a22c729fb3..2065374c7e9e6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3404,6 +3404,16 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	if (new_order >= folio_order(folio))
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
 	if (is_anon) {
 		/* order-1 is not supported for anonymous THP. */
 		if (new_order == 1) {
@@ -3466,13 +3476,6 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		gfp_t gfp;
 
 		mapping = folio->mapping;
-
-		/* Truncated ? */
-		if (!mapping) {
-			ret = -EBUSY;
-			goto out;
-		}
-
 		min_order = mapping_min_folio_order(folio->mapping);
 		if (new_order < min_order) {
 			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
-- 
2.51.0


