Return-Path: <stable+bounces-165559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD463B164AD
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934B8188E819
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAE12DE6EF;
	Wed, 30 Jul 2025 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFN29keN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17792DC35B
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892959; cv=none; b=X1Lzvxb60Z4Tg7QePlW5ej9Qaux1udsmZcqLcH9yV1iSH8o1Mv/r7kGjNW1O5sRPXAK0ia+G7sGkJKlTeFmGjFoiNmvJ41vtWAVWJ/z9VopE+nGuStXnIEnluzI9/cGqpP0E774eN+9+VJGzfT5EzqLQqlzU0JkkkWfuI6HzwcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892959; c=relaxed/simple;
	bh=Zz3MDjqZ5UOsqX2AnHOHGtYF3LbJZuxJol5oq4aCCB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArD9lMG6xptnR4XS30jrLhSx/HKiwlBynwmvuBPCeb03b1+onK5Bus0urlk89JyARPrlYsH9Qz8Gi+teEYqFHcR+0cK571YaEv4nVH90k7AQqDiN1HXeS4B8jDoxK2TE0Pi+rNsPneioCg5fXDe8mH5ZFGccmE7KKaSuxKheXAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFN29keN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5245BC4CEE3;
	Wed, 30 Jul 2025 16:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892958;
	bh=Zz3MDjqZ5UOsqX2AnHOHGtYF3LbJZuxJol5oq4aCCB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NFN29keNB+WHe3R+zAqbpaX60Di4gztYzU51xAr6jgyL+XouQ5f4ACr/djeBdXPvL
	 CNfmWX494QTv6NmR4op1M8azPrhdOfCIdisKuVQIZoNRnDiOQJ55cfeeZT/xz0p9a5
	 uq/P3/jtUHgCYpi6uOgKbUXxfzlX7DTo6nfoZZpH9ZTCwZFZBeYv2PjbZQaM2kZk8/
	 PD+3FkULGzvVc9Guj19HCiuMdpYpjGKEOphmweoNNcsMH2WzsdTpXnoBb0o1JyPzJh
	 WBl036Ti1lQz88Sw898qfTcxyE1eF1uIcGsMBh+bEeXl4z9D/YZWbceUQXd74sH9Rj
	 8xcaTusM1Mc0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 2/4] mm: update memfd seal write check to include F_SEAL_WRITE
Date: Wed, 30 Jul 2025 12:29:16 -0400
Message-Id: <1753867219-4cf09f9f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730015152.29758-3-isaacmanjarres@google.com>
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

The upstream commit SHA1 provided is correct: 28464bbb2ddc199433383994bcb9600c8034afa1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Isaac J. Manjarres <isaacmanjarres@google.com>
Commit author: Lorenzo Stoakes <lstoakes@gmail.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  28464bbb2ddc ! 1:  5a653047604b mm: update memfd seal write check to include F_SEAL_WRITE
    @@ Metadata
      ## Commit message ##
         mm: update memfd seal write check to include F_SEAL_WRITE
     
    +    [ Upstream commit 28464bbb2ddc199433383994bcb9600c8034afa1 ]
    +
         The seal_check_future_write() function is called by shmem_mmap() or
         hugetlbfs_file_mmap() to disallow any future writable mappings of an memfd
         sealed this way.
    @@ Commit message
         Cc: Mike Kravetz <mike.kravetz@oracle.com>
         Cc: Muchun Song <muchun.song@linux.dev>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Cc: stable@vger.kernel.org
    +    Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
     
      ## fs/hugetlbfs/inode.c ##
     @@ fs/hugetlbfs/inode.c: static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.6                       | Success     | Success    |

