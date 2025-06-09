Return-Path: <stable+bounces-151980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1845AD16E7
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AC1E7A4498
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4242459E1;
	Mon,  9 Jun 2025 02:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/mN+Y7t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C38324503E
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436491; cv=none; b=a/ghzGJ1lQpr2Sf2YRKJMFJ9lY9NydTBXZwfFhupO23JY1lS25J+H40r446RItT1j7XCm2KjDaBqGHgkS/Jxw+6n/QIBCNMy3Gm6sTJi04UkZe6pXcICBKMhmk56a/qyipRsT7zB26Xcgaxot821pJlXykq3FtNQ4KnraF+Q+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436491; c=relaxed/simple;
	bh=RhPjyb/wx0eTKycPguQzAKB5hUoPZwdvddiGPdaxMA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJnQX+7d3xTRujU+RmcAH/iE0B9soN2fEiAcyTklNS5yCEmMYd0qon9YWB6khge2hbrgCJH2zuaWw6BVXx2KjjwqpLF+nz4SVIaE/ro+h+tpz1Z5BqA9fK9EBwdWpskwsdtM5e9RJA8t5jrXqqgWhaBN7BjHT01JOBAeua6HMps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/mN+Y7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F33C4CEEE;
	Mon,  9 Jun 2025 02:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436491;
	bh=RhPjyb/wx0eTKycPguQzAKB5hUoPZwdvddiGPdaxMA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/mN+Y7t/hyIXj9oFr5TQ+5gZDu6irl+zfFEpygmBnDAtycqtg8R5D2yhI4Pc0DvJ
	 suJABAZOlKYHlsl151tyr5PKPG81zEoywnIZHEw9sm8bz042nAoRwEWyRwfFZX2DKw
	 EgGIeiqb3q2EXPDXE7WGKfDklGJqlCW5iTdADRR1TymoWBvdWBif5S7CFbg/nZBu+C
	 aC891cbLBGqXU5K7Ap1WE5NbfCVxm77+oSd7z3pFZ8mQcFEiVmGp5+xWpOI3C/BpOx
	 5Ao3sj5ki5LUXtfhlG/OlZnEH2NnnhjQ0WLUsaHg4g5+vCW1klQ4Ak94S36AN2R1Gt
	 KJ6XtVtqkEfrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sergio.collado@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 2/2] x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
Date: Sun,  8 Jun 2025 22:34:49 -0400
Message-Id: <20250608131945-4e96cd203d765c70@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250608145450.7024-3-sergio.collado@gmail.com>
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
ℹ️ This is part 2/2 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: f710202b2a45addea3dcdcd862770ecbaf6597ef

WARNING: Author mismatch between patch and found commit:
Backport author: <sergio.collado@gmail.com>
Commit author: Nathan Chancellor<nathan@kernel.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f710202b2a45a ! 1:  aea5c55c49b88 x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
    @@ Metadata
      ## Commit message ##
         x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
     
    +    From Nathan Chancellor <nathan@kernel.org>
    +
    +    [Upstream f710202b2a45addea3dcdcd862770ecbaf6597ef]
    +
         After commit c104c16073b7 ("Kunit to check the longest symbol length"),
         there is a warning when building with clang because there is now a
         definition of unlikely from compiler.h in tools/include/linux, which
    @@ Commit message
         Signed-off-by: Ingo Molnar <mingo@kernel.org>
         Acked-by: Shuah Khan <skhan@linuxfoundation.org>
         Link: https://lore.kernel.org/r/20250318-x86-decoder-test-fix-unlikely-redef-v1-1-74c84a7bf05b@kernel.org
    +    Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
     
      ## arch/x86/tools/insn_decoder_test.c ##
     @@
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

