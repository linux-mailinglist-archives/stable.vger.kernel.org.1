Return-Path: <stable+bounces-195407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73105C761AA
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2AF4B291BA
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF56E1A0BF3;
	Thu, 20 Nov 2025 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SszH/plp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D316301486
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667648; cv=none; b=Y89rFk2ZJbDisN4HN03sxYnBp+XrHutJlc6k5Cq5Q0SVRHX+ekIHDMSnWXqwXDNG5LI277ksbiwti2bJMHNp3c9zV0EiYf4wHb1LCD/XjNRB9XoODI7rCc+06UtCKUYe9A+Jxm9G9rx1s5NiYs0o/whJ1xOWNcpcegl3TBht5C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667648; c=relaxed/simple;
	bh=I8O8rL9PZGCI/YaEN3cdLQOzcxMQ0LPutdfh4FVDNnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlmhKRblfjmlTdRtPjl6Tfb19c10CiIyZ0qG1pu85NBZNQAedrL32hL4VoBWIsC2iKsHKj/XNtgg71GCl2/Srg20EUAbD/id8Ccv1ZVRhq4ji63OFKZ9bCsOWJ+BfY4I2VVNv5wDuyZYZ17eLEaz9jtCxL+EDc13KyKXkXlUUHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SszH/plp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE2FC4CEF1;
	Thu, 20 Nov 2025 19:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763667646;
	bh=I8O8rL9PZGCI/YaEN3cdLQOzcxMQ0LPutdfh4FVDNnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SszH/plppuU7kdJnhMcHG8Y5Km0m3FXwI4dHCMAcbZmCw40Hx+h2KSsWXbpNO0IDC
	 GkKFLHdn8LYP+r2afV3Lxt0gAqwASWdp0CrxwHohoO73IIldnKOyxR+ekv0wGjjykf
	 KS/pRlAf+kJ99WJFH4M7yvuaybN4518TVE99/7J5cfRkFl1SMGzoZj6L26D9hVPxEq
	 hBuhSnMCwfLNpOaCEs4US3hXEdflqQD3pzpuPmieb3h9Pz925o09XbDFQqhm6PtbM2
	 klYYFKCDlhaOSWhrwfNiy7vqOeaJd8ToyYSO3BMVw+m9vT3d19bbWhiKCz+Lyw7yKJ
	 jDqNIZG+zh26A==
From: Mike Rapoport <rppt@kernel.org>
To: stable@vger.kernel.org
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10.y] mm/mm_init: fix hash table order logging in alloc_large_system_hash()
Date: Thu, 20 Nov 2025 21:40:41 +0200
Message-ID: <20251120194041.2365029-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025112033-barista-manicure-43e9@gregkh>
References: <2025112033-barista-manicure-43e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Isaac J. Manjarres" <isaacmanjarres@google.com>

When emitting the order of the allocation for a hash table,
alloc_large_system_hash() unconditionally subtracts PAGE_SHIFT from log
base 2 of the allocation size.  This is not correct if the allocation size
is smaller than a page, and yields a negative value for the order as seen
below:

TCP established hash table entries: 32 (order: -4, 256 bytes, linear) TCP
bind hash table entries: 32 (order: -2, 1024 bytes, linear)

Use get_order() to compute the order when emitting the hash table
information to correctly handle cases where the allocation size is smaller
than a page:

TCP established hash table entries: 32 (order: 0, 256 bytes, linear) TCP
bind hash table entries: 32 (order: 0, 1024 bytes, linear)

Link: https://lkml.kernel.org/r/20251028191020.413002-1-isaacmanjarres@google.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 0d6c356dd6547adac2b06b461528e3573f52d953)
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d906c6b96181..495a350c90a5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8372,7 +8372,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 		panic("Failed to allocate %s hash table\n", tablename);
 
 	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
-		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
+		tablename, 1UL << log2qty, get_order(size), size,
 		virt ? "vmalloc" : "linear");
 
 	if (_hash_shift)
-- 
2.50.1


