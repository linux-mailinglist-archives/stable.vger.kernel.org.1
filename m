Return-Path: <stable+bounces-124716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4C9A65912
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B872588459D
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28C520ADD1;
	Mon, 17 Mar 2025 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apxUsfgi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D320A5E9
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229619; cv=none; b=pvXDdWWxwRlc4sbkvnrHYLxUnlG8IxT+Gig4NhZKWq9liAnd4RjNefyXEE7vnL0wwSMv7wVgmJQ6W50sM2dexebL8kV46pCTq1gvN1y0wTJ0qLdUHjBDtNcEYllEoIopHLHBBIFdYKwh/9qWX1o4o4IzgLIg0ONGblM1Z6VFq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229619; c=relaxed/simple;
	bh=nltNzjgs+k0fN+msjMJ8okgLMqKbksSy1etz5nBCziE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d40MZqaycT7Aj2HZc/bp7xf8B0nawSE7KdJfwVGGmhyuDhC85bqiYOScxSypwLJwmG51CwEcL7uXylZmUJdcZc70LXjtL1OIf/QubcDTU0C37cz21UuKBXCTa58m8c7TR9OHxTsQKWOvY+KQMSWFL7nc8uAKj7gs9y4e9mYd8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apxUsfgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F89C4CEF0;
	Mon, 17 Mar 2025 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229619;
	bh=nltNzjgs+k0fN+msjMJ8okgLMqKbksSy1etz5nBCziE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=apxUsfgi3ghUzuffZyZVRqO36ggt+zsQhw7jIj/82/5XHdeZnTi+6ctlmPXgzzxoN
	 X9FJxFMITMiE6ckA6hREZPWqGymHLZtA0GDsK6uoJY3B9/Fm6PyIOkM4+5rREFUL5A
	 m0YUAOeaRCisE8mawUQsEivg+54Tt1WOXJ+Vb5DWMrFrRatEzdkYtJCC8EYySdKNBE
	 Jx75zsc9kBcizbFUbOWsOZx2sQPyOVavaVU8iWcVSVBT7TOFLMiMeofcKrNVdVRY0b
	 cFOhXl1l6cb3LrGkrjFJYQLdENw0ZVVIe0Xxr2Cv8xaGrg34hO5GDseYOJ9V4JRfIY
	 9gTUQWGDoD2sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] mm: split critical region in remap_file_pages() and invoke LSMs in between
Date: Mon, 17 Mar 2025 12:40:17 -0400
Message-Id: <20250317090925-ea0127e4bb24d4de@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317031629.2244-1-jianqi.ren.cn@windriver.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 58a039e679fe72bd0efa8b2abe669a7914bb4429

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Kirill A. Shutemov<kirill.shutemov@linux.intel.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  58a039e679fe7 ! 1:  8ef52303f2705 mm: split critical region in remap_file_pages() and invoke LSMs in between
    @@ Metadata
      ## Commit message ##
         mm: split critical region in remap_file_pages() and invoke LSMs in between
     
    +    [ Upstream commit 58a039e679fe72bd0efa8b2abe669a7914bb4429 ]
    +
         Commit ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in
         remap_file_pages()") fixed a security issue, it added an LSM check when
         trying to remap file pages, so that LSMs have the opportunity to evaluate
    @@ Commit message
         Cc: Shu Han <ebpqwerty472123@gmail.com>
         Cc: Vlastimil Babka <vbabka@suse.cz>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## mm/mmap.c ##
     @@ mm/mmap.c: SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
    @@ mm/mmap.c: SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long
      
     -	if (mmap_write_lock_killable(mm))
     +	if (mmap_read_lock_killable(mm))
    - 		return -EINTR;
    - 
    ++		return -EINTR;
    ++
     +	/*
     +	 * Look up VMA under read lock first so we can perform the security
     +	 * without holding locks (which can be problematic). We reacquire a
     +	 * write lock later and check nothing changed underneath us.
     +	 */
    - 	vma = vma_lookup(mm, start);
    - 
    --	if (!vma || !(vma->vm_flags & VM_SHARED))
    ++	vma = vma_lookup(mm, start);
    ++
     +	if (!vma || !(vma->vm_flags & VM_SHARED)) {
     +		mmap_read_unlock(mm);
     +		return -EINVAL;
    @@ mm/mmap.c: SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long
     +	/* OK security check passed, take write lock + let it rip. */
     +	if (mmap_write_lock_killable(mm)) {
     +		fput(file);
    -+		return -EINTR;
    + 		return -EINTR;
     +	}
    -+
    -+	vma = vma_lookup(mm, start);
    -+
    + 
    + 	vma = vma_lookup(mm, start);
    + 
    +-	if (!vma || !(vma->vm_flags & VM_SHARED))
     +	if (!vma)
     +		goto out;
     +
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

