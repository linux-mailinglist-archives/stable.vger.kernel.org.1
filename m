Return-Path: <stable+bounces-127441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073D0A7979F
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6943B3A78
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 21:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA5F1E5B81;
	Wed,  2 Apr 2025 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyjx6a84"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539DE288DA
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629109; cv=none; b=bBBUSRiS6P519H/XF9ZGRKocLAePMwup/i13Y87yJpXLrWmhbWrSKWriilcoD/nU6RnRd9EEgka8hoeFmma9rU9KJ0nq6eeyHCnt2UL4svsa4XoBsOnzu/YuM/VM+wybdluRjO+2j/YoMr6giTEK6cBdnxbvVa0GpChxxhjCE6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629109; c=relaxed/simple;
	bh=gF6+taZIJ7X2vGnWNbrSxhd89hBbqNy5tY+2ZB3ep6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/+AZdZttiffyr8w9k4RJH41YllJ6RnpjYJo2+anGQnTMN5Yxf6PhAt8+ZuQMe4twQKOxMG4Tyvi6OOk7XLBrCQUv3wty7WqEdZxomGRmRDEKADaEHrFJiK8FYemd4qL5AafILqhpeC3oFZZqXr/9wXpSGN9pPMLvOdOtXYo+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyjx6a84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5506EC4CEDD;
	Wed,  2 Apr 2025 21:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743629108;
	bh=gF6+taZIJ7X2vGnWNbrSxhd89hBbqNy5tY+2ZB3ep6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uyjx6a847mrn+ExZ6cDhEPWQExS4KZL++4TOMGtzrQNWflUUAJWIAG86YKheG3zQP
	 5K0P8yUZRmkJS6CiSCBKJsSeX2jqkxJRcTlcIIx2TtoxiqQ15uuV2BBJgedKHxbc33
	 Mrk0nDEr4xJ+6nQsICNTG2GZ+hBdI1g6zM1Bl8+8othHyJyW0sH5SxW9rGa6qS5I2b
	 JPcqBTMMe3sfwi802QPozz7pF//zjOcqAlp0QHA1qzz0LIZ/Gea618Xua5d+1lDTO3
	 G36ysQfA5Yo8/adLO/eJ3dQsa0hNhIogZjUm1IeDsM3TXQ3KofzliLQVch1DBEYlr0
	 EWIWxhc9jRx7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kang Wenlin <wenlin.kang@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 4/6] binfmt_elf: Use elf_load() for library
Date: Wed,  2 Apr 2025 17:25:05 -0400
Message-Id: <20250402134402-672b95008ba41b9b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250402082656.4177277-5-wenlin.kang@windriver.com>
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

The upstream commit SHA1 provided is correct: d5ca24f639588811af57ceac513183fa2004bd3a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Kang Wenlin<wenlin.kang@windriver.com>
Commit author: Kees Cook<keescook@chromium.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  d5ca24f639588 ! 1:  7498fc234c462 binfmt_elf: Use elf_load() for library
    @@ Metadata
      ## Commit message ##
         binfmt_elf: Use elf_load() for library
     
    +    commit d5ca24f639588811af57ceac513183fa2004bd3a upstream
    +
         While load_elf_library() is a libc5-ism, we can still replace most of
         its contents with elf_load() as well, further simplifying the code.
     
    @@ Commit message
         Signed-off-by: Sebastian Ott <sebott@redhat.com>
         Link: https://lore.kernel.org/r/20230929032435.2391507-4-keescook@chromium.org
         Signed-off-by: Kees Cook <keescook@chromium.org>
    +    Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
     
      ## fs/binfmt_elf.c ##
     @@ fs/binfmt_elf.c: static int load_elf_library(struct file *file)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

