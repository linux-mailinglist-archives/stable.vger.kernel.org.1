Return-Path: <stable+bounces-119533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FCFA445A2
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 17:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FDF16EE48
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BFB18C035;
	Tue, 25 Feb 2025 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD8ffCyd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70C21ABAB
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500027; cv=none; b=ZVCcmYFlT1Nu+SfOsLcdyAcdKvqWltCZadSASYIK+k5a1CtjJtVG/LlY9i4CU2Vaza8+BdO8E5+JCKFn2EAqzl8unjVpk5hihRDh8E/vYFs8qOSgS2f9SHyx0a8cgbkFnfP4BHgMkJr6Otig6TAnanL/9U+uzHh1JBnD6I6CGYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500027; c=relaxed/simple;
	bh=P59Al3WinpKarbx8FZrKKezGe0AAfjMqCzBZ3MXdaRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mv0stJhoKXvpkejrZtdWjm2cB3Tvf6+qu93Bf4aEUxUy8Z3RFLBom6kh7EtBSqlJveAWEmd4tSMuB5ZV/bPEjpZJCfeEGOvYt44vhlS5l/u3J2tOuE4b8UbPxYucUkFMTbq4Ihk59fJRor4IFVADrhO7iejKKR2jNxOS3JTKbBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD8ffCyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3FBC4CEDD;
	Tue, 25 Feb 2025 16:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500027;
	bh=P59Al3WinpKarbx8FZrKKezGe0AAfjMqCzBZ3MXdaRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lD8ffCydMdgDZQj9jnmqtkVc/RMqcx1LzUeOwKRhGdDunFugsZI/VtRjaEx/Ii1JM
	 TT+brVrYPH3REBK5Pyx3m1tKxw3tU5Rt+gsCr3ez37VgrtGjFACRn2voTtRcg58w80
	 ZE4w49ORyRwhAhuZn7vQ75vYMjlrN9cRsU06gjjKPiM4yxP0AZYr346/3oIEyjdKzD
	 rmumJrHxggLF+sreIgN1NNyIknIY+rgFN3NJk+FYf3d3iSaUndXHXOddCp+Hggc20X
	 5TvoaM5oz29aRlu4Y1i084xYZGPjgY400IdY5JN7K00Ay9JL7hlfv35UAIvU9gXjbL
	 mxzQ8BMiRlosA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	arefev@swemel.ru
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] crypto: tcrypt - Fix missing return value check
Date: Tue, 25 Feb 2025 11:13:46 -0500
Message-Id: <20250225102706-e929f62555ac52b1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250225123215.26154-1-arefev@swemel.ru>
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
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

The upstream commit SHA1 provided is correct: 7b3d52683b3a47c0ba1dfd6b5994a3a795b06972

WARNING: Author mismatch between patch and upstream commit:
Backport author: Denis Arefev<arefev@swemel.ru>
Commit author: Tianjia Zhang<tianjia.zhang@linux.alibaba.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7b3d52683b3a4 ! 1:  e9b5236ad8829 crypto: tcrypt - Fix missing return value check
    @@ Metadata
      ## Commit message ##
         crypto: tcrypt - Fix missing return value check
     
    +    commit 7b3d52683b3a47c0ba1dfd6b5994a3a795b06972 upstream.
    +
         There are several places where the return value check of crypto_aead_setkey
         and crypto_aead_setauthsize were lost. It is necessary to add these checks.
     
         At the same time, move the crypto_aead_setauthsize() call out of the loop,
         and only need to call it once after load transform.
     
    -    Fixee: 53f52d7aecb4 ("crypto: tcrypt - Added speed tests for AEAD crypto alogrithms in tcrypt test suite")
    +    Fixes: 53f52d7aecb4 ("crypto: tcrypt - Added speed tests for AEAD crypto alogrithms in tcrypt test suite")
         Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
         Reviewed-by: Vitaly Chikunov <vt@altlinux.org>
         Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
    +    [Denis: minor fix to resolve merge conflict.]
    +    Signed-off-by: Denis Arefev <arefev@swemel.ru>
     
      ## crypto/tcrypt.c ##
     @@ crypto/tcrypt.c: static void test_mb_aead_speed(const char *algo, int enc, int secs,
    @@ crypto/tcrypt.c: static void test_aead_speed(const char *algo, int enc, unsigned
      			if (iv_len)
     @@ crypto/tcrypt.c: static void test_aead_speed(const char *algo, int enc, unsigned int secs,
      			printk(KERN_INFO "test %u (%d bit key, %d byte blocks): ",
    - 					i, *keysize * 8, bs);
    + 					i, *keysize * 8, *b_size);
      
     -
      			memset(tvmem[0], 0xff, PAGE_SIZE);
    @@ crypto/tcrypt.c: static void test_aead_speed(const char *algo, int enc, unsigned
     -				goto out;
     -			}
     -
    - 			sg_init_aead(sg, xbuf, bs + (enc ? 0 : authsize),
    + 			sg_init_aead(sg, xbuf, *b_size + (enc ? 0 : authsize),
      				     assoc, aad_size);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

