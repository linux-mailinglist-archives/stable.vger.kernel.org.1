Return-Path: <stable+bounces-195404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0397CC76192
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1FF0346FCE
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4B52F49E3;
	Thu, 20 Nov 2025 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+3n7PPV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091502D7DC5
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667391; cv=none; b=Gh5b0NyIUmILibstGGANNO/sIGWM12O2fzEkWr7hll6SzmnPttXLxc+pHjd+odLWHS09Wa5OJJDj2MtkqB+RAElPN2n6lvTVOK3CJNsSaaivYaoUhHEOtAOGcxTniHFCTTvT4BIceclgzcU62Wz4oW1dikqvEagLTie+vVWEk4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667391; c=relaxed/simple;
	bh=aK+gfUOlx2+gwabAm9LFJEr8k4kTrxSQIMx7e+CwsLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACFYOSIlMtfYbaww83KTFaCs/2AnVXxbhLoHYw6f8b0m0R78GTvlkiAmNyEJ8vn52l+F+URK+MeBMX3jq72QlsbRimP2vXSRS47roUBDKPq8xxm8o/FEmFI1JGnjqFXRW6Z9HngxQXCR808u6KSwruECn3vDM16ddc42zOLtaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+3n7PPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED64C116C6;
	Thu, 20 Nov 2025 19:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763667390;
	bh=aK+gfUOlx2+gwabAm9LFJEr8k4kTrxSQIMx7e+CwsLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+3n7PPV4jHqvF9ahMCAWDxdXA1gon9lzF43m2YfEiPjqhXwhqEHfmdz5E42b4FNc
	 5FybhigSQh1oLlJuflk3xw5e8iZYpPlz1tte5RwgqOSiKnXmsOXeYZjHVyLTYrhl4v
	 6TGHzk3qEmxaSxR+HIEbj8eocVtQv5EmCooGYuMmWA6dz62VuZZAhswX3FoGzP0Xaa
	 ZCg1Hm6LeQQPxR9f8vkYAdnPNLzu2xTPrF8Vzvq3/hQKVBdQcLJys0khN5FtGo9QGr
	 yOK29yWXrgYkgQGbjVhFkxrNaaj/9dGZGmkjtHUHCWcgxOjJ+vl6sEqNI6TW/slpf/
	 Py3DyBdawZegA==
From: Mike Rapoport <rppt@kernel.org>
To: stable@vger.kernel.org
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/mm_init: fix hash table order logging in alloc_large_system_hash()
Date: Thu, 20 Nov 2025 21:36:25 +0200
Message-ID: <20251120193625.2353017-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025112033-overstep-denim-0e6a@gregkh>
References: <2025112033-overstep-denim-0e6a@gregkh>
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
index 63e131dc2b43..0a5e9a4b923c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8921,7 +8921,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 		panic("Failed to allocate %s hash table\n", tablename);
 
 	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
-		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
+		tablename, 1UL << log2qty, get_order(size), size,
 		virt ? (huge ? "vmalloc hugepage" : "vmalloc") : "linear");
 
 	if (_hash_shift)
-- 
2.50.1


