Return-Path: <stable+bounces-126012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51196A6F425
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7273E3B5CBE
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393CF255E55;
	Tue, 25 Mar 2025 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cD7xtXa4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE020BA36
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902405; cv=none; b=V3J+aPg1Xdnzg5FroY+i/uDynlV/acE3KswnbRI9TsBstNlo2K7z76A1pxnxBYcezcp7TDqaxqQYINWKUIInbHcJzV6/qEg7dp8NNCKly7MnzGMIZlr0Zr8ZkNPqTGWcZyAA66y9dPz5T8I/zIonlee4lbFCOIXS8UuJBoOebUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902405; c=relaxed/simple;
	bh=1rh6LRHwJd83lLg8fszpLqJe/Vo0SjNts8tbsMseeIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bND8b0JA7XgOzliFtwy2V4Ct1gLp8/ToM7KMetOLJy0zBdYVD862gZGkAIHTiVuQp8MDIpkGTDjfL7mG2Th7ufYd/6j0hgLTAU3/uMpoMYlhIuIGG4Jd+G7617hdnAPwxIQgMxVk+WL5YDfoTbYgzDUyl9B6BwQgJmdenNx4Skc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cD7xtXa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C602C4CEE4;
	Tue, 25 Mar 2025 11:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902404;
	bh=1rh6LRHwJd83lLg8fszpLqJe/Vo0SjNts8tbsMseeIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cD7xtXa439hfacgkPUGIr9TtG+JoujzPwOyZc9LqJ4MQLFKUj3F1Iej9By9kM0qpw
	 F3Zfn2vVuJJDkC/uIO97o8Q9T3qaBTG6GPhqzB1seT7xQU+qR6rrvak7IQRIjPhq0M
	 TRJHQIIfjrnVbBg+6Eb6KLtdE8jXi7GmPd5acVYgR8vI7IWr9mPLJbGsq8szJLVY8m
	 DgxB/pbma4CcidMdMkgEiZctwQ3TR480e/Goqs8Eznn7d3nvQyKXS0PONcRG8qxt0/
	 aWAUnmdQxVhDQuG4lBolGBaX4o+d/tNwv70gFoo3TVqa5rZMip3hJFBHrO+xlC+GLL
	 QG4/GMi7k2VPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kang Wenlin <wenlin.kang@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/7] binfmt_elf: replace IS_ERR() with IS_ERR_VALUE()
Date: Tue, 25 Mar 2025 07:33:22 -0400
Message-Id: <20250324220316-f3fe5b2a6a2a22f3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324071942.2553928-2-wenlin.kang@windriver.com>
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

The upstream commit SHA1 provided is correct: dc64cc12bcd14219afb91b55d23192c3eb45aa43

WARNING: Author mismatch between patch and upstream commit:
Backport author: Kang Wenlin<wenlin.kang@windriver.com>
Commit author: Bo Liu<liubo03@inspur.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  dc64cc12bcd14 ! 1:  35172eeb12462 binfmt_elf: replace IS_ERR() with IS_ERR_VALUE()
    @@ Metadata
      ## Commit message ##
         binfmt_elf: replace IS_ERR() with IS_ERR_VALUE()
     
    +    commit dc64cc12bcd14219afb91b55d23192c3eb45aa43 upstream
    +
         Avoid typecasts that are needed for IS_ERR() and use IS_ERR_VALUE()
         instead.
     
         Signed-off-by: Bo Liu <liubo03@inspur.com>
         Signed-off-by: Kees Cook <keescook@chromium.org>
         Link: https://lore.kernel.org/r/20221115031757.2426-1-liubo03@inspur.com
    +    Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
     
      ## fs/binfmt_elf.c ##
     @@ fs/binfmt_elf.c: static int load_elf_binary(struct linux_binprm *bprm)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

