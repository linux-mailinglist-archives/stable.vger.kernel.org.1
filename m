Return-Path: <stable+bounces-159097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B9BAEEBEF
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 03:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593113E077C
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 01:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2A818DF8D;
	Tue,  1 Jul 2025 01:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Miw71lfJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F52195808
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332529; cv=none; b=RMeLxmKzxq8Gu/NzkPBamdQdXiBdHVpfNF21st1ERQD8Kv3npL5zVjEYxeF1vlnwJSMMz4kC3bPWzEzmrb9dRq1iUCGG1FHu6XylfG7i/CTf86oJaY9OoRMHnp3Gkb7S8jOIP70xWHveOMpIND4FtpcfLlvoAl64NSmDhl7aDpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332529; c=relaxed/simple;
	bh=j3gIuL+N1Das/1KpLiEEce8ehvs8JlqoAs5x2sZPGR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bx/XCJPWum1bcC7lIoqYZRRtyEfTXvpekQjH8ZkPy1Yqwc7Ri5leabaP9JVOMQUNTWEZZjkT5EkbrVKWNGgcGEHsR8DfJOT2gMvuV3rZWe6bSbAQ4vH7RMOmQQ+56nXk7Ij2GHOWXXIhL58GpOfE85obrPt3CKuI3ioTQ0TZC1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Miw71lfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EF8C4CEE3;
	Tue,  1 Jul 2025 01:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751332529;
	bh=j3gIuL+N1Das/1KpLiEEce8ehvs8JlqoAs5x2sZPGR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Miw71lfJkdCiVf+Q9Xpds+UzvGFzJVzTV+sgxUWftVRN5ysdCxiC3zCr37KDNwkZ8
	 3Rgbs4OjcAYu+PEllaPV7qEI6/gxug8/pfw7zQ+zYwo4BOCan6qXmJ4fxL2jbRHXx3
	 6yLxvwrQuqRJTOOCsZE25CuqfqzcHApFKf50BPzRwxQ48KXU9Sn+d8h+OoeRTAEM75
	 HlFPK77vf00d6VEjgqLWiGJnkPtnXolUpGrlHiWXOtK7gARd4sB6vX2OkzvDDhFwyJ
	 lhVcO5AIAliLhcy4FJt0GIN2LYREMJiMco0LVcdnLBztha6IfSUtQx21I1mwKCOD6n
	 bmLv7GMmhC6kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lorenzo.stoakes@oracle.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] mm/vma: reset VMA iterator on commit_merge() OOM failure
Date: Mon, 30 Jun 2025 21:15:27 -0400
Message-Id: <20250630185452-e7a223d4b65c00a5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250630175817.164918-1-lorenzo.stoakes@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 0cf4b1687a187ba9247c71721d8b064634eda1f7

Status in newer kernel trees:
6.15.y | Present (different SHA1: b07a09cf2a1c)

Note: The patch differs from the upstream commit:
---
1:  0cf4b1687a187 ! 1:  2e6afa970267d mm/vma: reset VMA iterator on commit_merge() OOM failure
    @@ Commit message
         Cc: Jann Horn <jannh@google.com>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    (cherry picked from commit 0cf4b1687a187ba9247c71721d8b064634eda1f7)
    +    Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
     
      ## mm/vma.c ##
    -@@ mm/vma.c: static __must_check struct vm_area_struct *vma_merge_existing_range(
    - 		err = dup_anon_vma(next, middle, &anon_dup);
    +@@ mm/vma.c: static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
    + 		err = dup_anon_vma(next, vma, &anon_dup);
      	}
      
     -	if (err)
    -+	if (err || commit_merge(vmg))
    - 		goto abort;
    - 
    --	err = commit_merge(vmg);
    --	if (err) {
    --		VM_WARN_ON(err != -ENOMEM);
    +-		goto abort;
     -
    + 	/*
    + 	 * In nearly all cases, we expand vmg->vma. There is one exception -
    + 	 * merge_right where we partially span the VMA. In this case we shrink
    +@@ mm/vma.c: static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
    + 	 */
    + 	expanded = !merge_right || merge_will_delete_vma;
    + 
    +-	if (commit_merge(vmg, adjust,
    +-			 merge_will_delete_vma ? vma : NULL,
    +-			 merge_will_delete_next ? next : NULL,
    +-			 adj_start, expanded)) {
     -		if (anon_dup)
     -			unlink_anon_vmas(anon_dup);
     -
    @@ mm/vma.c: static __must_check struct vm_area_struct *vma_merge_existing_range(
     -			vmg->state = VMA_MERGE_ERROR_NOMEM;
     -		return NULL;
     -	}
    --
    - 	khugepaged_enter_vma(vmg->target, vmg->flags);
    - 	vmg->state = VMA_MERGE_SUCCESS;
    - 	return vmg->target;
    -@@ mm/vma.c: static __must_check struct vm_area_struct *vma_merge_existing_range(
    ++	if (err || commit_merge(vmg, adjust,
    ++			merge_will_delete_vma ? vma : NULL,
    ++			merge_will_delete_next ? next : NULL,
    ++			adj_start, expanded))
    ++		goto abort;
    + 
    + 	res = merge_left ? prev : next;
    + 	khugepaged_enter_vma(res, vmg->flags);
    +@@ mm/vma.c: static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
      	vma_iter_set(vmg->vmi, start);
      	vma_iter_load(vmg->vmi);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

