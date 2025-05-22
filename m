Return-Path: <stable+bounces-145959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AEEAC0207
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC8C4A742B
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5AA35953;
	Thu, 22 May 2025 02:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNwY7joB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEDA1758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879460; cv=none; b=FohkU9244KwZm/LoRv/bR88T1Jp+6HsLXD+BNQmyRavruQpuonGO3ZbA+VnqPXaojVf04cCyJplL4XnKn8dKtFa8Uin10LMcWLIWyjqhpBAKlkrys02JS6sAZqzR6Jnfdi/ihbCfk1D3Ye47H10gdw8O9Zp3oQE2A0M/dIUV18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879460; c=relaxed/simple;
	bh=6yPnBtdynDGIPO7DQ44jSTCyveNyIbPRMzABZnouw6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkTra633Qjq5bfCVF0UhvAftKdGj7VhuF/EPZPZJPiV1mQh3BlFoGKrSBcpZmo8KWXRBiCXrrmQN58ijDZCSJGENr+Oz26b4OS2vInCkIRJYsBAf7nUYhiq+YmVy4ZUgTml0kqeBhjmCzOqQeNnAjEK2IzIOpMcbDJ9zhyhTns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNwY7joB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A1BC4CEE4;
	Thu, 22 May 2025 02:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879459;
	bh=6yPnBtdynDGIPO7DQ44jSTCyveNyIbPRMzABZnouw6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNwY7joBoJJpqlMxkUzmtot2Dd3aCsxMWmfEeISKqVrUyymNyN2fJSHymwAxoJjaC
	 Sg3dlQ00XdXZVk77ptpWvG3vONtza/+wcDi1TJtfmqyFX0LxkwR+XKoyVCNw66hhd3
	 B+olpxls0GCgxo88I4K+rGffNCSsKx8swQLJJrFhxPaH4ZeiuQ228gM3hF26c/ui9e
	 e7hDozKggUXwwl0YoHs4csxk8sQD+B5C7b4RzHxpS+Cvl/j6pIrpw8sQ0r7jyHM3EU
	 wF14C4ko7DMkv2GYpgqkr1GzoK201VOJnZW40oj/o+KngrH0Z5XSl/H4YCMVHxLNi8
	 IoWOjUwcqeHjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 03/26] af_unix: Try to run GC async.
Date: Wed, 21 May 2025 22:04:15 -0400
Message-Id: <20250521162457-e0d2cb01697a7833@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-4-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: d9f21b3613337b55cc9d4a6ead484dca68475143

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  d9f21b3613337 ! 1:  d70301af4426d af_unix: Try to run GC async.
    @@ Metadata
      ## Commit message ##
         af_unix: Try to run GC async.
     
    +    [ Upstream commit d9f21b3613337b55cc9d4a6ead484dca68475143 ]
    +
         If more than 16000 inflight AF_UNIX sockets exist and the garbage
         collector is not running, unix_(dgram|stream)_sendmsg() call unix_gc().
         Also, they wait for unix_gc() to complete.
    @@ Commit message
         Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
         Link: https://lore.kernel.org/r/20240123170856.41348-6-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit d9f21b3613337b55cc9d4a6ead484dca68475143)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

