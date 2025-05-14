Return-Path: <stable+bounces-144438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D40AB7698
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F26216B05F
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5B427703E;
	Wed, 14 May 2025 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6T8xrXu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D196295519
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253669; cv=none; b=OK0uTwngQchjgr1woOE388s01aNXRM/+37lX+X8cDZiDg+QjJgJUy5+KP7ywWrhUKccaK6Mrd/qmEc1fmCt9gBbOsfnL82tC6alkrYKsxdjyu2I8FTYbzun9msAIzFBa7Ocyu1fx8x7ZUXjm6vaFVUb5y63AnlukIBn6hX4YiqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253669; c=relaxed/simple;
	bh=ROaS1dRaU72GR+ULkyKMFVMlLbCd8wrAuZ9OkPAPYkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urOf5iDKgFpZDT45Zc4S+BbtHOBBh8Cr3gNEL4A5mL3dCGmIyIq5j8SwPugp6n9XRGTZtdxXWu2dHZ+IOjeYCO+4AQQiSO8RlN9krae8iBacKgF6+12fzp11Jw8D4oIHR+ynJxgq9s3Nd3lJQkcFUEL9q6KN2I0Y2ImN1RSox7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6T8xrXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15316C4CEE3;
	Wed, 14 May 2025 20:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253669;
	bh=ROaS1dRaU72GR+ULkyKMFVMlLbCd8wrAuZ9OkPAPYkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e6T8xrXuemhHv2aQIykQj/KpGtYgIANzsT2Nq3Vg8HwrHbaL4RQe+/UD7zDOYV/oB
	 eF/oI+7MQQSwJ/MhOqGrA/Kf99pwCoh3iakhLT+YnVHAEuzmRykTcb1x1k9fRUMyrs
	 hOItti4r/DOUjoFkCFhViu72FDxUo8SH7tX9lSS4xQ7LNN5vysI/XbNYvPB/SqJtS0
	 HEYto7FQLZahqXTrdm29aFa1WLeIx8yXjvmLCY7+AF+1uKHHYUfT94XqtVfEhrcKR8
	 Anl8jv+1PfsnJTIl6H1+HayGM9AGQvmZWDT3iOdX5tVn2oeJjm/T8qCoC5omKD0HEt
	 wPpAA8WYZ4inQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 08/14] x86/alternative: Optimize returns patching
Date: Wed, 14 May 2025 16:14:24 -0400
Message-Id: <20250514112016-3d66742d84148d48@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-5-15-v2-8-90690efdc7e0@linux.intel.com>
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
ℹ️ This is part 08/14 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: d2408e043e7296017420aa5929b3bba4d5e61013

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Borislav Petkov (AMD)<bp@alien8.de>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found

Found fixes commits:
4ba89dd6ddec x86/alternatives: Remove faulty optimization

Note: The patch differs from the upstream commit:
---
1:  d2408e043e729 ! 1:  434b5a53f4508 x86/alternative: Optimize returns patching
    @@ Metadata
      ## Commit message ##
         x86/alternative: Optimize returns patching
     
    +    commit d2408e043e7296017420aa5929b3bba4d5e61013 upstream.
    +
         Instead of decoding each instruction in the return sites range only to
         realize that that return site is a jump to the default return thunk
         which is needed - X86_FEATURE_RETHUNK is enabled - lift that check
    @@ Commit message
         Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
         Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Link: https://lore.kernel.org/r/20230512120952.7924-1-bp@alien8.de
    +    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
     
      ## arch/x86/kernel/alternative.c ##
     @@ arch/x86/kernel/alternative.c: static int patch_return(void *addr, struct insn *insn, u8 *bytes)
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

