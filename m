Return-Path: <stable+bounces-144257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206E9AB5CD0
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08BF4C0066
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F24949620;
	Tue, 13 May 2025 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pw6c6biE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6A3748F
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162259; cv=none; b=e2wPaSI0wEFIAaNFSCaJUiwfeLRJ9/H7BKvyuaNITd7lgDQTe1w3m7xWCgECY3j67JICqkX6W09rF9HhY4jCPDiB4MTrHwWOIgCW0OgeTy/8JxbFkXilXCN0Q8Abs7kudkRe+Mi6tdPhHRBSlD5Cm7IUUaZz6YqzBEOGcxdt7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162259; c=relaxed/simple;
	bh=fmk5YGnWFO8k0IbGXE+0+ZBc/2KucoWHttEp0SLrz+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvPdOzTMGAzLQ1ZZVxLyEwYcyRuRupiJX6pLw1b6QC+PxD1rHwwqpmLbSPxVq/sEG2YxO8dzNoSXFa0BNsk7lehvbFoGMgEd9KSRHMg194pAb0WFPTV4zrAL0vPN2dD2eAYBewWjWHgAwVhT0DJhgQ+ZcRzxRFhZp535d++3cQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pw6c6biE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB00C4CEE4;
	Tue, 13 May 2025 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162258;
	bh=fmk5YGnWFO8k0IbGXE+0+ZBc/2KucoWHttEp0SLrz+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pw6c6biEQdLfth1GC+w2UsEWOzUAJd8If5eOpRy8+Az+OWs0b+tZZi4EabMKDia74
	 OSOOAQPX0EwldlbyQOQRlwGO+MOmHnHBr0/rsFzHtnU/yydWRJu2sJ/Nxos4RBIbLS
	 v/PLuT5j8JTIekg6uqADGs37aRrdwA0zCLcjqOHHHAr0W1sMPJ1mkeN01JCDV8pcLN
	 PnLe5Y+pzbrkaNox49nXAe/eGGpPUF9Zn+XJvsWOK5NSQmvGRWHWEC1uwZ+iewW240
	 yeyyS6OdMEF74HAkJftxph3x5cWEx7H90f21tIu6FWYqODvqynS+oREEjnJJkZEvc8
	 GV6xrdngIzZ4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 08/14] x86/alternative: Optimize returns patching
Date: Tue, 13 May 2025 14:50:54 -0400
Message-Id: <20250513133411-fbff29445240a559@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512-its-5-15-v1-8-6a536223434d@linux.intel.com>
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
1:  d2408e043e729 ! 1:  6ea6c6cbaae6a x86/alternative: Optimize returns patching
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

