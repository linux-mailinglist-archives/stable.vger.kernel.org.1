Return-Path: <stable+bounces-124304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76CFA5F494
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C951F3BD69C
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552F2673B2;
	Thu, 13 Mar 2025 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNsqTElh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C0267381
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869118; cv=none; b=Vu9x0hcD4NUl2ZL2mFb86Y9eiz1nb+6H7O+yTL458+d6BIG2dahINeCcbB2QJ8M+QhGTKAMWRPTrG944EqEAgcbD6GmRw/LbGw6exekcYc22H9ijz6hPnSfuMWg/YomF5jcGGLAYL+Zmxu02TS2YdMYO31CTd09Ral/qhiefZ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869118; c=relaxed/simple;
	bh=vXusQ3f9oWefI7BtybBROpBEdVt3J0bn8fHCaej0Hv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXqUcHFBA877v4p30FYrdrzWO7HxaSH5eK4n+02D6qs9Kvc6pHm/qnZQ/pvRtlnpC2ohlYzQwfJi1uCLTd2h5oCdGkJVb3vXpA6QyxrrElk560xUex2RuC2T715YOu+c4Cq6yftpdZzWq5Zb/gen12BFC5LiqAtff0PP9tXTo80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNsqTElh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CC8C4CEDD;
	Thu, 13 Mar 2025 12:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869117;
	bh=vXusQ3f9oWefI7BtybBROpBEdVt3J0bn8fHCaej0Hv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNsqTElhj60R4t8XDlbSkLD6wI2SDn6Q/tYBoe5qYT6YkiTA7jG/jZduxBngF7H3F
	 K3uBw5SI3sJw4AxZgW82IUuQCZGhhgE5vij1xD+bRHXu3ivQjf3VuVEYztC42lv7bW
	 4dLL5MYdRhUNO0E6BaqfjDF04iYD7Bj8HAvslRm8AUv3leW6SzKL4qV+7WBjF7oXJ8
	 bV+bVC1xJYYJJr0LDZMXnk7TfB33U+I+RDmVkB4RavYkwEUgQNGjR3F8pOrAgzxTvG
	 xRI0SP8edcxSDTr2+xAj4hfQJowurNd2bHoG7qxgI7xkvege4LAAZvj8cibMspgvLV
	 y822IwPRhvFUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kareemem@amazon.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] x86/kexec: fix memory leak of elf header buffer
Date: Thu, 13 Mar 2025 08:31:55 -0400
Message-Id: <20250313053046-4cc9e3ab5639973b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250312132744.55143-1-kareemem@amazon.com>
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
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: b3e34a47f98974d0844444c5121aaff123004e57

WARNING: Author mismatch between patch and upstream commit:
Backport author: Abdelkareem Abdelsaamad<kareemem@amazon.com>
Commit author: Baoquan He<bhe@redhat.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: 8765a423a87d)

Found fixes commits:
d00dd2f2645d x86/kexec: Fix double-free of elf header buffer

Note: The patch differs from the upstream commit:
---
1:  b3e34a47f9897 ! 1:  2981ec404a4e1 x86/kexec: fix memory leak of elf header buffer
    @@ Metadata
      ## Commit message ##
         x86/kexec: fix memory leak of elf header buffer
     
    +    commit b3e34a47f98974d0844444c5121aaff123004e57 upstream.
    +
         This is reported by kmemleak detector:
     
         unreferenced object 0xffffc900002a9000 (size 4096):
    @@ Commit message
         Acked-by: Dave Young <dyoung@redhat.com>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    [Conflict due to
    +    179350f00e06 ("x86: Use ELF fields defined in 'struct kimage'")
    +    not in the tree]
    +    Signed-off-by: Abdelkareem Abdelsaamad <kareemem@amazon.com>
     
      ## arch/x86/kernel/machine_kexec_64.c ##
     @@ arch/x86/kernel/machine_kexec_64.c: void machine_kexec(struct kimage *image)
      #ifdef CONFIG_KEXEC_FILE
      void *arch_kexec_kernel_image_load(struct kimage *image)
      {
    --	vfree(image->elf_headers);
    --	image->elf_headers = NULL;
    +-	vfree(image->arch.elf_headers);
    +-	image->arch.elf_headers = NULL;
     -
      	if (!image->fops || !image->fops->load)
      		return ERR_PTR(-ENOEXEC);
    @@ arch/x86/kernel/machine_kexec_64.c: int arch_kexec_apply_relocations_add(struct
     +
     +int arch_kimage_file_post_load_cleanup(struct kimage *image)
     +{
    -+	vfree(image->elf_headers);
    -+	image->elf_headers = NULL;
    -+	image->elf_headers_sz = 0;
    ++	vfree(image->arch.elf_headers);
    ++	image->arch.elf_headers = NULL;
    ++	image->arch.elf_headers_sz = 0;
     +
     +	return kexec_image_post_load_cleanup_default(image);
     +}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

