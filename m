Return-Path: <stable+bounces-195406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAEBC7619E
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B4DAA29176
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055DC2FFF9D;
	Thu, 20 Nov 2025 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZaULMBK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD52DCF70
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667507; cv=none; b=aNPHBnynzHzNZvz3tVvfeLgYn8HX9CDbhmga9AsRdKgE73K+qAqkjaXfihVrJjf3ggi1QRTvfd+km8duTU/gz1WM1tID39ZA5hRB0r2PUo87dMtND1k+UXNb5UCzA6LMQidqShQyzGsu6B1rGg1oIk+VkPVP99TNdDGxCsWHXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667507; c=relaxed/simple;
	bh=fBLTANODSfkqSh8+8qVVdC4+k64zS+gYxxbuXJMJzJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TviGlOIQgn+2QS17xa1QOOEZP74NINpoAXFSuN10BIHgZTbW/U7uw89fUZERQYu23ti9flF1Yj0wh0mP0n5tXng/3MYkM4a2xYq3rva2sTg/DXFN4dYaYzaU1mSXZ1uOxZ9QxQugy1RRcXoImJ2pVb5Jy1A6beF2yO75fMDlGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZaULMBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14ADC4CEF1;
	Thu, 20 Nov 2025 19:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763667507;
	bh=fBLTANODSfkqSh8+8qVVdC4+k64zS+gYxxbuXJMJzJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZaULMBKCEVt5hWh2Vx9vY0DnEUdCyfnW1U6dU542V4uaK2MsWtLx781NSZ1Y+EK3
	 cuxxGnNNDzXB8HN6oIexj3CMYsjgUeIfjKI5SP82bu7fPjA9lKVrdP7phNFFMMxhHO
	 kVApgz8Bca5hVFNFpK6d9cjxSb+BXAhH0jc/ofth82u9xZ9RdBFMiOKwDCrSLNy6b9
	 2RRypWPoz+J6KxmVgKSOHz0vRYoYu87I8zOV7Reqkk4lhSTdHFCP6UiQG8O+D6N372
	 iigNVscMBmyC+qP5WYnnUDWUl7oWvHLfZjOJznowZb1qymSeunyQsfC8e2+5HISQ5+
	 Z4HiA9bSR8oPg==
From: Mike Rapoport <rppt@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Google Big Sleep <big-sleep-vuln-reports@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/secretmem: fix use-after-free race in fault handler
Date: Thu, 20 Nov 2025 21:38:21 +0200
Message-ID: <20251120193821.2353216-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025112023-overact-rehydrate-ae42@gregkh>
References: <2025112023-overact-rehydrate-ae42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When a page fault occurs in a secret memory file created with
`memfd_secret(2)`, the kernel will allocate a new page for it, mark the
underlying page as not-present in the direct map, and add it to the file
mapping.

If two tasks cause a fault in the same page concurrently, both could end
up allocating a page and removing the page from the direct map, but only
one would succeed in adding the page to the file mapping.  The task that
failed undoes the effects of its attempt by (a) freeing the page again
and (b) putting the page back into the direct map.  However, by doing
these two operations in this order, the page becomes available to the
allocator again before it is placed back in the direct mapping.

If another task attempts to allocate the page between (a) and (b), and the
kernel tries to access it via the direct map, it would result in a
supervisor not-present page fault.

Fix the ordering to restore the direct map before the page is freed.

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
[rppt: replaced folio with page in the patch and in the changelog]
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/secretmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 624663a94808..0c86133ad33f 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -82,13 +82,13 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 		__SetPageUptodate(page);
 		err = add_to_page_cache_lru(page, mapping, offset, gfp);
 		if (unlikely(err)) {
-			put_page(page);
 			/*
 			 * If a split of large page was required, it
 			 * already happened when we marked the page invalid
 			 * which guarantees that this call won't fail
 			 */
 			set_direct_map_default_noflush(page);
+			put_page(page);
 			if (err == -EEXIST)
 				goto retry;
 
-- 
2.50.1


