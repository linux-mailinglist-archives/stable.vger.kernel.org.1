Return-Path: <stable+bounces-178716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78233B47FC6
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E62320066C
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF83F2139C9;
	Sun,  7 Sep 2025 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M7spYLCr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3374315A;
	Sun,  7 Sep 2025 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277729; cv=none; b=LQopMeFh96fT5ze9Ci+zDNp/QdtAgVfN9sNgc6v6YTh8R9gFdScCOPsZI2RAnbYB52CTPq2YneCrlIfF47uVSxUFh+0g5aMVQv8BKBbSN31ORBWRY7acMNVbzT0G+Jxx3CQO04oa1RyF6boPsou3NUAsfv64myg+QuBJCSANpRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277729; c=relaxed/simple;
	bh=PCinbxoggPxYFE6+XxbTYEvu1UkXuPOkQtAr798dwzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKMIjhKMcOnQ7NgnI+67Vx2wlnYrUJSzLQxBdKCPBYb4llnZjclGvbL9EGVw8OLoiq2f/TKVrwRrr9Kr96+xaCAQzhrnOn3BDwdKTt/umtfUDr1SGLXylBm57pOKCP/Bphf0vsHygZbN5AulIjjgxid6bxVbvUJmovKpsrg5GWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M7spYLCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1FBC4CEF0;
	Sun,  7 Sep 2025 20:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277729;
	bh=PCinbxoggPxYFE6+XxbTYEvu1UkXuPOkQtAr798dwzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7spYLCr5WLU7q0niCJUn94mhU6YMUj0u2V5wjFV2H27rR+5hQP4UZWtR4RLAx0Iy
	 LJ8Rj09hXHA07Gw1Tm94pZ1s8CVrvazAWt4/VUozWCYJxY8RGPwdWVbkeyEGdPz4qu
	 mrYjS2LWqEPyJPWSbzKjxtYChinzIbD36BAHO5vc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.16 104/183] mm/userfaultfd: fix kmap_local LIFO ordering for CONFIG_HIGHPTE
Date: Sun,  7 Sep 2025 21:58:51 +0200
Message-ID: <20250907195618.262100314@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
References: <20250907195615.802693401@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sasha Levin <sashal@kernel.org>

commit 9614d8bee66387501f48718fa306e17f2aa3f2f3 upstream.

With CONFIG_HIGHPTE on 32-bit ARM, move_pages_pte() maps PTE pages using
kmap_local_page(), which requires unmapping in Last-In-First-Out order.

The current code maps dst_pte first, then src_pte, but unmaps them in the
same order (dst_pte, src_pte), violating the LIFO requirement.  This
causes the warning in kunmap_local_indexed():

  WARNING: CPU: 0 PID: 604 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
  addr \!= __fix_to_virt(FIX_KMAP_BEGIN + idx)

Fix this by reversing the unmap order to respect LIFO ordering.

This issue follows the same pattern as similar fixes:
- commit eca6828403b8 ("crypto: skcipher - fix mismatch between mapping and unmapping order")
- commit 8cf57c6df818 ("nilfs2: eliminate staggered calls to kunmap in nilfs_rename")

Both of which addressed the same fundamental requirement that kmap_local
operations must follow LIFO ordering.

Link: https://lkml.kernel.org/r/20250731144431.773923-1-sashal@kernel.org
Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/userfaultfd.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1453,10 +1453,15 @@ out:
 		folio_unlock(src_folio);
 		folio_put(src_folio);
 	}
-	if (dst_pte)
-		pte_unmap(dst_pte);
+	/*
+	 * Unmap in reverse order (LIFO) to maintain proper kmap_local
+	 * index ordering when CONFIG_HIGHPTE is enabled. We mapped dst_pte
+	 * first, then src_pte, so we must unmap src_pte first, then dst_pte.
+	 */
 	if (src_pte)
 		pte_unmap(src_pte);
+	if (dst_pte)
+		pte_unmap(dst_pte);
 	mmu_notifier_invalidate_range_end(&range);
 	if (si)
 		put_swap_device(si);



