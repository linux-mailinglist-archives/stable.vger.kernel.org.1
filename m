Return-Path: <stable+bounces-126027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8861AA6F444
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02D7168DC5
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9D71F0E31;
	Tue, 25 Mar 2025 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaLCkQcj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B455BA36
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902435; cv=none; b=iydYApjqIpO9x//A7bVKM+S8tSFFnh22ebkPHIeAsUoDb4qaUOsV255tLeBn6lfrX34/CK5eAiLYUDOTKJy5rApcj8+CxOgGoj/GiRjg1xW4haF9n0EZfLR5VyqWUx6aiObiaO4xjUfMAO9xnTYFl/FKrhty9oGEid7KAd/GE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902435; c=relaxed/simple;
	bh=JCs1zo+i+ot2KF+/Dfk8JGzbxQaTLiILMqV6bNKaQ+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQ2K0HgJgT4FLkLqxC+pZO8vPDnko3wRi1ldFZj2xprADgeFQX0z60nLtQhTVyWP8GjlR/pxedr3QMdtlSHpgEEhyS5CzEvQuYQgoMSYDH2Tv4dy66M5RSjMVK5NEGJ553mZDWSgy+pcQarjqIMzCr3WVBCCYHL05FLT0077Rz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaLCkQcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765B7C4CEE4;
	Tue, 25 Mar 2025 11:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902434;
	bh=JCs1zo+i+ot2KF+/Dfk8JGzbxQaTLiILMqV6bNKaQ+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JaLCkQcjVtovbAXBhboz/l3pdp9WJ5MudgzO9CnjeKgTaNOLSVY6hJSnyRgTRWFd+
	 NRKDvSTz9HXwImzNzUH0utKLohMmmErqUmFBy6ArWJLYoWQC1+6TC0udztc+pr947C
	 HaK2zLpnReuub/TASeG7YGPkotAw1jifk5c7NtT5QOwi0eGBNFZCxrgXxgq4J2sRxN
	 VTzfy9Ehg6GQQbCgZxfAHUbXlu2VviqsX2PPJ3XFkA6IBfOniAaWudHTtQbYvD2NKb
	 FoZkg6U6FrS1fwmMNNDOFTlj5Z0lOh/US3a0Jfmc9UI5UqywEHxbTVkgjUTgtEyeFP
	 XznqJHCVYuZGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kang Wenlin <wenlin.kang@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 6/7] binfmt_elf: Only report padzero() errors when PROT_WRITE
Date: Tue, 25 Mar 2025 07:33:53 -0400
Message-Id: <20250324223522-724fe7a12d1d753b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324071942.2553928-7-wenlin.kang@windriver.com>
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

The upstream commit SHA1 provided is correct: f9c0a39d95301a36baacfd3495374c6128d662fa

WARNING: Author mismatch between patch and upstream commit:
Backport author: Kang Wenlin<wenlin.kang@windriver.com>
Commit author: Kees Cook<keescook@chromium.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f9c0a39d95301 ! 1:  6dcb8e418404b binfmt_elf: Only report padzero() errors when PROT_WRITE
    @@ Metadata
      ## Commit message ##
         binfmt_elf: Only report padzero() errors when PROT_WRITE
     
    +    commit f9c0a39d95301a36baacfd3495374c6128d662fa upstream
    +
         Errors with padzero() should be caught unless we're expecting a
         pathological (non-writable) segment. Report -EFAULT only when PROT_WRITE
         is present.
    @@ Commit message
         Signed-off-by: Sebastian Ott <sebott@redhat.com>
         Link: https://lore.kernel.org/r/20230929032435.2391507-5-keescook@chromium.org
         Signed-off-by: Kees Cook <keescook@chromium.org>
    +    Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
     
      ## fs/binfmt_elf.c ##
     @@ fs/binfmt_elf.c: static struct linux_binfmt elf_format = {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

