Return-Path: <stable+bounces-195401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFA9C76117
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D1FD72A695
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299C32F6907;
	Thu, 20 Nov 2025 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw6QLL+2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C32D877E
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666662; cv=none; b=rcrJxuuehmDl2lxToCHmYWEPK4Ob+RQuPTR1rkay2+Ebb/b/c07TOR+W5LEwItyOLfCy6Mtxn8/8Egttz8I9tDt5IuDfUiIla3S045xMV3EohiE4b6uBnvyxhvURLkYoQPbAjai6k0qidylUKxPc7CuwT5dB5nCuYK2jb5Yp9mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666662; c=relaxed/simple;
	bh=J5voABVOFUZMyXtGl3qGXlREOkEQU/wpwaWkFywlg5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQCZvYSjyigLUhw6Cbz2NBctHb8shtG/heXdP4Br4xpnxir32oGJrpDZZa5yLue0MHyDaqOVs6v1pRdVzIHSMxrEErZGUI8w4QeF6uZ0kPSKP8Lm8KYgr9BebH05D0zDi8GBknesyp2B2J5yjUZwEfTcwu2gjAe6MITNGHxYjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw6QLL+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316FDC4CEF1;
	Thu, 20 Nov 2025 19:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763666661;
	bh=J5voABVOFUZMyXtGl3qGXlREOkEQU/wpwaWkFywlg5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jw6QLL+2VphYdQOeb89usYH2GuSUMxW0rY7+JlE+90hEJde550hziHuR6rOLZFGQk
	 cSM/PhZFIBC0nT3iZNhavj1sz4cqId12iG+A+qCYmXOJQms2jN12PT41SO0CWHfxdn
	 iAjYp1sG8swkjohdeZhP9Bgj+vkfDqCYFg60HMIYIXUBkUwN9tmIguQxmwg7QbrLwz
	 Qw6J3vkaQdsfXFxzGRpOC+6EvxIgPgsXbDY+fl7fBUy+AB7/v0LqhncGLWe8kf5tFB
	 yXya649VK1i8JKtUGszlRHFxnAKZRXUFsI90mMd1qnHD8wPn0SyJTL46PiAdyRpD1N
	 AFR84u9c3UbuQ==
From: Mike Rapoport <rppt@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Google Big Sleep <big-sleep-vuln-reports@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/secretmem: fix use-after-free race in fault handler
Date: Thu, 20 Nov 2025 21:24:15 +0200
Message-ID: <20251120192415.2345459-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025112021-swept-idealness-9ecb@gregkh>
References: <2025112021-swept-idealness-9ecb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When a page fault occurs in a secret memory file created with
`memfd_secret(2)`, the kernel will allocate a new folio for it, mark the
underlying page as not-present in the direct map, and add it to the file
mapping.

If two tasks cause a fault in the same page concurrently, both could end
up allocating a folio and removing the page from the direct map, but only
one would succeed in adding the folio to the file mapping.  The task that
failed undoes the effects of its attempt by (a) freeing the folio again
and (b) putting the page back into the direct map.  However, by doing
these two operations in this order, the page becomes available to the
allocator again before it is placed back in the direct mapping.

If another task attempts to allocate the page between (a) and (b), and the
kernel tries to access it via the direct map, it would result in a
supervisor not-present page fault.

Fix the ordering to restore the direct map before the folio is freed.

Link: https://lkml.kernel.org/r/20251031120955.92116-1-lance.yang@linux.dev
Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Signed-off-by: Lance Yang <lance.yang@linux.dev>
Reported-by: Google Big Sleep <big-sleep-vuln-reports@google.com>
Closes: https://lore.kernel.org/linux-mm/CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com/
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 6f86d0534fddfbd08687fa0f01479d4226bc3c3d)
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/secretmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 4bedf491a8a7..f64ea1cde2f9 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -84,13 +84,13 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 		__folio_mark_uptodate(folio);
 		err = filemap_add_folio(mapping, folio, offset, gfp);
 		if (unlikely(err)) {
-			folio_put(folio);
 			/*
 			 * If a split of large page was required, it
 			 * already happened when we marked the page invalid
 			 * which guarantees that this call won't fail
 			 */
 			set_direct_map_default_noflush(page);
+			folio_put(folio);
 			if (err == -EEXIST)
 				goto retry;
 
-- 
2.50.1


