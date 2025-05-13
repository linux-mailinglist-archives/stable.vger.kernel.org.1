Return-Path: <stable+bounces-144244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7DAAB5CC5
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38EB163D1E
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471508479;
	Tue, 13 May 2025 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuGUZOuP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B51E521A
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162205; cv=none; b=aIgOV/3tkp78BNjySgnbRkZkPLMriCsgn57IuRy8pvA3W/n1Vz5NSk3SmmaFxqCgEWUrK2v+Bw4ZH0fw3AUhfCc/2SVmmeUxq9lSfRou6v6iUCxTTD4UQMeBNfV6/sfyZqnvXZjFOIGtPRRaV7vy+hNYGHv2NFaY+XNAHwz07R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162205; c=relaxed/simple;
	bh=O52yn9OFD4+IpRuVDECBe3TP8EABkNL0m9Qe2YSJnOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFIQbTOQCuyuZ140CmusVfbG6/bvmwhmKfucj5cv6N1Wgh9Nzb+Rlxdlcr/vlGZ+nQ6U71eXMiwu+TALbC7bHFEliO9lmvNnfkPNtiRwGxpJ5E0jHjn5AOrMomfXoGwJozLagIreUgqehNPpsh5GLjTUSAK5fG1qo4K661pAIWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuGUZOuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7841C4CEE4;
	Tue, 13 May 2025 18:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162204;
	bh=O52yn9OFD4+IpRuVDECBe3TP8EABkNL0m9Qe2YSJnOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kuGUZOuPhFtIHwuVVl8dfcuNXjF409V3GY/EDm9y2kLzXJ2jV/hpsgiO0gTI2LnGf
	 QyP3vxlZ2O9jrTs1pmlwiKebjZnZ9zpZLdm8FP2AUFxv/pPIBBb5OmJrbM4EyKLqXx
	 KdQU8iuCS3jjONPAtfwzkSbBr35pqAMpy33N99GXToMlB2NElanXr1jDrZlGzLeaz+
	 JD1/H0OajmhxGKYCiAwxA9FU1vlOYj1WEofBEAUSEwznlxLVcpQ2zvTYnGb53GNHn3
	 kLF7KJIpE4ht8E7IUYbIA93Pn2Y1XPrsS8ie+K08zjeBk+h0FeDQ/1JfFnv4vNy2cd
	 V3Ks7TXnigpWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 01/14] x86,nospec: Simplify {JMP,CALL}_NOSPEC
Date: Tue, 13 May 2025 14:50:00 -0400
Message-Id: <20250513121300-f9b7a8db80e2cd23@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512-its-5-15-v1-1-6a536223434d@linux.intel.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 09d09531a51a24635bc3331f56d92ee7092f5516

WARNING: Author mismatch between patch and found commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Peter Zijlstra<peterz@infradead.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  09d09531a51a2 ! 1:  92e9b52cf2ab3 x86,nospec: Simplify {JMP,CALL}_NOSPEC
    @@ Commit message
         compiler generated retpolines are not.
     
         Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    +    (cherry picked from commit 09d09531a51a24635bc3331f56d92ee7092f5516)
     
      ## arch/x86/include/asm/nospec-branch.h ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

