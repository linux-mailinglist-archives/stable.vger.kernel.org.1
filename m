Return-Path: <stable+bounces-143826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFC6AB4215
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C197B7492
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D970C29B8F9;
	Mon, 12 May 2025 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASEh9vj5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AC829B8F0
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073098; cv=none; b=uQ4IbfoQmhAJryK6H9zsZukmhcCt0PdfWFknXqj8oF52J8QCVkTOQs2aVR9JSijHUy/ptu+jS1vJa/z6XPoVvGhwEa7/qjUxgI0xCQNToayOjDSGsHyy5J+aMLN00IKXN51FOD9QfbncDPC+Q5oi8zOAHQlidXpZE9U46Glhhow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073098; c=relaxed/simple;
	bh=c2stgpVyNOAA5GD7bASdXXvAocrLbixGABQ1mhUcLAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+mpWAqWVuxI1UYZMKBDuVtUZZ6gHQNAObwtuP0v+e57hYtWX0710GE7gC3mPsZRnouRic7D4tOowZTZ11pVP9Rg3KadzMK2fhxYuIQS3kSvgHvWZJ4XEPWz477of7TATGoL2Zs3cputfIGNi3qCnCmF6wkX5FaY/UaIdeUr3cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASEh9vj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D60DC4CEF6;
	Mon, 12 May 2025 18:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073098;
	bh=c2stgpVyNOAA5GD7bASdXXvAocrLbixGABQ1mhUcLAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ASEh9vj5Iehldg6HDTBPhRNLxommrjNfly1Gd32kLjMTaZ/kk6pbaOXQbn0TjU4BH
	 RGMmHI8Lw0NnHWPFpGYRNxl5Xz4zg+JoVTB1UzxaCCsy/NoDNJGWC7CmG6IrJwKk1J
	 LjtrLakd2mUHEcd2inwdIBOWVAvcUGhAKy3Mgksfvi0SwdDaZ9SS+2YMsTRCOjbwK6
	 7MGCO20DDuXSofS0xkL7Y+1qD8ZUTz+fEYSQ6Ad9tjqLLQ/FiCiCmJNf8eYWE5Nu1a
	 1umBUXt3o8DG4KfXX4nLchwN2mtfkl1nSFsW7IvZNY9Iq3OhGaauu4uO4w3vzLtzu6
	 X509tASbNayeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Feng Liu <Feng.Liu3@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y/5.15.y] ELF: fix kernel.randomize_va_space double read
Date: Mon, 12 May 2025 14:04:55 -0400
Message-Id: <20250511221746-17a0e7ea300c9d83@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509061415.435740-1-Feng.Liu3@windriver.com>
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

The upstream commit SHA1 provided is correct: 2a97388a807b6ab5538aa8f8537b2463c6988bd2

WARNING: Author mismatch between patch and upstream commit:
Backport author: Feng Liu<Feng.Liu3@windriver.com>
Commit author: Alexey Dobriyan<adobriyan@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 53f17409abf6)
6.1.y | Present (different SHA1: 1f81d51141a2)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2a97388a807b6 ! 1:  795c22f390cda ELF: fix kernel.randomize_va_space double read
    @@ Metadata
      ## Commit message ##
         ELF: fix kernel.randomize_va_space double read
     
    +    [ Upstream commit 2a97388a807b6ab5538aa8f8537b2463c6988bd2 ]
    +
         ELF loader uses "randomize_va_space" twice. It is sysctl and can change
         at any moment, so 2 loads could see 2 different values in theory with
         unpredictable consequences.
    @@ Commit message
         Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
         Link: https://lore.kernel.org/r/3329905c-7eb8-400a-8f0a-d87cff979b5b@p183
         Signed-off-by: Kees Cook <kees@kernel.org>
    +    Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
    +    Signed-off-by: He Zhe <Zhe.He@windriver.com>
     
      ## fs/binfmt_elf.c ##
     @@ fs/binfmt_elf.c: static int load_elf_binary(struct linux_binprm *bprm)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |

