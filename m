Return-Path: <stable+bounces-145490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ACFABDC1D
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B02F7B7466
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E83F248872;
	Tue, 20 May 2025 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="glC45yFl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DAA247DEA;
	Tue, 20 May 2025 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750328; cv=none; b=SH/7lj9n7AhPEx633yMqckztQDLOKATUOS9Bqw74uYE3i7ThCVtG+7p7HBNTs23qxjJz9i/z7yP2mTQyp/tcT4shYGW3082Y7FEprXxncQVdM75g/q9OGSBpaar7/ahBVY39XSr+1VUmgBwB+J71y/tpoj+wHPRAtrze7fDomHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750328; c=relaxed/simple;
	bh=+MHXeWTCx/qxnBchXhrngBCwMnj/AV3Jd9wI3/0Bqcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qftIAnTxjSM9QRe+6lcr/WNk8a7D/lGphmv123JjwYg0Y7ADOB0oL3DKVnB/bBP9pNZ3M4O8k+kSctakZ3mNBB68kzpXLU+cYTGlcoZb9ALek+aOUGkaJyAKdeWN0406ZRLsYdcdEs2GmTGSKp/MG2ATPWT83j27Po5N2j7Yz10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=glC45yFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51C1C4CEE9;
	Tue, 20 May 2025 14:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747750328;
	bh=+MHXeWTCx/qxnBchXhrngBCwMnj/AV3Jd9wI3/0Bqcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=glC45yFl8ubHo/6eEUwr1Z64sxnZPnkOIRAKxaBLnc2rPOYX9xRg37iwyEiQxWZDP
	 4jBDx0pBp4ND+t0qV4rE/KtwK2AdpMBL+RKXJRa8RN0gjhlRQDKSszQXfeFpzNd6Je
	 XmZ9jk9Nww8PZzcYcCJOsfyPY1UqhdnAqQVh/+3A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Barry Song <v-songbaohua@oppo.com>,
	David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 117/143] mm: userfaultfd: correct dirty flags set for both present and swap pte
Date: Tue, 20 May 2025 15:51:12 +0200
Message-ID: <20250520125814.631002399@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>
References: <20250520125810.036375422@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Barry Song <v-songbaohua@oppo.com>

commit 75cb1cca2c880179a11c7dd9380b6f14e41a06a4 upstream.

As David pointed out, what truly matters for mremap and userfaultfd move
operations is the soft dirty bit.  The current comment and
implementation—which always sets the dirty bit for present PTEs and
fails to set the soft dirty bit for swap PTEs—are incorrect.  This could
break features like Checkpoint-Restore in Userspace (CRIU).

This patch updates the behavior to correctly set the soft dirty bit for
both present and swap PTEs in accordance with mremap.

Link: https://lkml.kernel.org/r/20250508220912.7275-1-21cnbao@gmail.com
Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reported-by: David Hildenbrand <david@redhat.com>
Closes: https://lore.kernel.org/linux-mm/02f14ee1-923f-47e3-a994-4950afb9afcc@redhat.com/
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/userfaultfd.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1059,8 +1059,13 @@ static int move_present_pte(struct mm_st
 	src_folio->index = linear_page_index(dst_vma, dst_addr);
 
 	orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
-	/* Follow mremap() behavior and treat the entry dirty after the move */
-	orig_dst_pte = pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);
+	/* Set soft dirty bit so userspace can notice the pte was moved */
+#ifdef CONFIG_MEM_SOFT_DIRTY
+	orig_dst_pte = pte_mksoft_dirty(orig_dst_pte);
+#endif
+	if (pte_dirty(orig_src_pte))
+		orig_dst_pte = pte_mkdirty(orig_dst_pte);
+	orig_dst_pte = pte_mkwrite(orig_dst_pte, dst_vma);
 
 	set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
 out:
@@ -1094,6 +1099,9 @@ static int move_swap_pte(struct mm_struc
 	}
 
 	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
+#ifdef CONFIG_MEM_SOFT_DIRTY
+	orig_src_pte = pte_swp_mksoft_dirty(orig_src_pte);
+#endif
 	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
 	double_pt_unlock(dst_ptl, src_ptl);
 



