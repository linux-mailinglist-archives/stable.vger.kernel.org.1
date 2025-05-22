Return-Path: <stable+bounces-145948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C17AC01FC
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC4D1B62B33
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620312B9B7;
	Thu, 22 May 2025 02:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT1wnB08"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2CD1758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879412; cv=none; b=tgnl+UuCAmpRcpUp7TBMHqqkeonmR6AGSJqzjqu3SEcnH87STOFXBdMY7cWfmAQui0SxuI2zWEw4tu4bwCjqXX5ZBntvAxid1Y3C1x+EmAw0jR2aIpM0qlNxCf6vIZAKvKMgRr2iTCqlkU53RIpY9MpqCfdMD7GFymRKdyNyj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879412; c=relaxed/simple;
	bh=IbnZERFKBivPy6OTEJddJQUt0VxR0LU5FlPkIO3Ab34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsmfQrBJVvkG49tRtbAEVsJYWwifKvTCnYA8HdkxW3K2RXfxSPD4LJzdakthUCkNr4+BEApumxXxF+DzcVMJ+ud9vCy+QtbDUb7p5Ra0q+P6Z2T8BxKJmKRzx2z5rKutahLQVo4pfxiFS39/m32ug0nW9mLkTPKaqzLCAw27gT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT1wnB08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BD2C4CEE4;
	Thu, 22 May 2025 02:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879411;
	bh=IbnZERFKBivPy6OTEJddJQUt0VxR0LU5FlPkIO3Ab34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mT1wnB08KBSRr+RbnpYd3GzCIQkJAG3JoLr1g/bdURgWYYTVgj1Wcwc1Uh5LCK28z
	 yb9QyT89LVyrvMg29rO08UbgqLXQogQcm2K/m8dPHwvklkJTxRKX9eltzqY4LEbyJ3
	 rIHUAvsi1mZB2MMatfIgcRL7GMJIuv17A1KYpRHPyYHpSAZ37kWsB7siRp5yiMnGbH
	 qD6Er/po1MvOBOCdXSN/999PAu/5Gz3gQqrutUO9j9Drcxjz5lgveOk00uxD0krjc1
	 JShFGLqsKq5Vrui8PjBMNPXjvNklgoK1jAIwRQrjdegkvd4c9wAb5u/0Z2L6JTsDTc
	 yFTzvNFz3aDAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 01/26] af_unix: Return struct unix_sock from unix_get_socket().
Date: Wed, 21 May 2025 22:03:26 -0400
Message-Id: <20250521160729-f4d331b8410a6093@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-2-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 5b17307bd0789edea0675d524a2b277b93bbde62

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  5b17307bd0789 ! 1:  83b10061bb064 af_unix: Return struct unix_sock from unix_get_socket().
    @@ Metadata
      ## Commit message ##
         af_unix: Return struct unix_sock from unix_get_socket().
     
    +    [ Upstream commit 5b17307bd0789edea0675d524a2b277b93bbde62 ]
    +
         Currently, unix_get_socket() returns struct sock, but after calling
         it, we always cast it to unix_sk().
     
    @@ Commit message
         Reviewed-by: Simon Horman <horms@kernel.org>
         Link: https://lore.kernel.org/r/20240123170856.41348-4-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 5b17307bd0789edea0675d524a2b277b93bbde62)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: void unix_destruct_scm(struct sk_buff *skb);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

