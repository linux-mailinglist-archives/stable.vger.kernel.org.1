Return-Path: <stable+bounces-195402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D301C76141
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACF01341BFF
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FE72F60A4;
	Thu, 20 Nov 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWBQ3uw1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E22D877E
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666818; cv=none; b=ggVfJh9vRXt4y3S44ZIjWg62IfOQLFwb+qKKWgz5HXWb2mmNTIAtTeN+LCa7JttsYDgFk6hAIJPjgp1FH8Vnwj/5WLtVgUXG2cE/YkyS/oglr+CFh2R4eGHQuqntm+hp4YoygLLdPuE6/qUBtm2uCbAUBcWNpVYj7DTm1Ufswv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666818; c=relaxed/simple;
	bh=S7ZcNDWKVU5QgJsDywWCTgoUisVhkPC7mbpUfOLQYus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQ47+k60ariC4rRO44aAWWEWwSK9Va64tp7hTTu1oGPeyJxMF8ftXyasznvquyQf+gl5Y6vCPcQB9HePMtcYW/rZroDZUURaWhMG7GZ5mk+BNAfsVLphyH2O+f59hBEeo93iyqd68UYvGrE3Srg83wx6jgz31fKhJyt0PM1VpzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWBQ3uw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D03EC116C6;
	Thu, 20 Nov 2025 19:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763666817;
	bh=S7ZcNDWKVU5QgJsDywWCTgoUisVhkPC7mbpUfOLQYus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWBQ3uw1Q52ONnhHCLK2s2BeoFf5LYv7ynK4067by6fFWthES1Ni6gNpzRn6DFAmv
	 5HfXSj327F0FeVHRmKdHyUvblXJY5IlElShSrrBkjESJRv692BjAaIjGC4gbaaYuJl
	 aYxGiZ9KtUfJgSWV4RKYt4o6r5Gw8z1n3m6RNoDCzEcvV5fSyFAuV46M/A+D9L/zmy
	 pQngN2LJz/Hvgew8UzzJDJaYGIDwz08CI86S3pgMb5kloMCkG2GG1BKh+EE/SC9SLU
	 pj4+tQBET4a9nMM3XlZWLYvLcyAWSRhRj2qKqs2415gyxGs/+fFFrD0Jm/qv1/m/wc
	 WhPxXMMG09pEA==
From: Mike Rapoport <rppt@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Google Big Sleep <big-sleep-vuln-reports@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/secretmem: fix use-after-free race in fault handler
Date: Thu, 20 Nov 2025 21:26:41 +0200
Message-ID: <20251120192641.2346018-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025112020-buddy-bobbed-3c5d@gregkh>
References: <2025112020-buddy-bobbed-3c5d@gregkh>
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
index 4662f2510ae5..aec96e4896f0 100644
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


