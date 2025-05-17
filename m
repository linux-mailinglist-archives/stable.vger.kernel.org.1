Return-Path: <stable+bounces-144685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D546ABAA3D
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 15:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2906C1B63C1A
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EDC1F417F;
	Sat, 17 May 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuZt2C77"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843CC35979
	for <stable@vger.kernel.org>; Sat, 17 May 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487328; cv=none; b=I/KkfHChj3ExDkxhww0WJzApHDer7jFf1R9g27C6+wP4IoBXMu1OTq1/kSEYmydySle811puC1rSbIDQPeVGebhAoEWX2d7tPnV4ztBe2oboLbJOJK314wv6cLNAPUH8Ofy3ChydumC7AMLF8ul7tbHW5LP783wtFQUaiY3Y1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487328; c=relaxed/simple;
	bh=hhfTxAPOEMxe2ki3O0Odq3dV2OtYRb0T/PxL0YlmQxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7cZ56aQxfaUmfFNP+IhzOLKUUsmU9KoIV/wccsQ85uAeXJXJXPV7jhMUgZ/NuaFh5pmbDghehRXZ8t6fVVbTkNdukeUuFCdCIEzbhdD9vPzW8RH+KbQ4QTE9P8SI6sadmvdRdGWLAP4wvZ00FCMf/zq+VvZBSrqCQoDrPIHwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuZt2C77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20BAC4CEE3;
	Sat, 17 May 2025 13:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747487328;
	bh=hhfTxAPOEMxe2ki3O0Odq3dV2OtYRb0T/PxL0YlmQxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuZt2C77UC1aXSphu81dhA1zkCCVf8R4y6k4oboO6ck2flkiPy9SNUK6GIzqrUiL4
	 mYIT/mmtsMb2BDcq7ogznUGUTXqd6FmVuPE8L59eJJhYy+iWEpFuqayTpYHcqy8RyQ
	 dsJ433S4qYJK37FAYHKxPbJT042YvnPH9h+SscPW4HZCgWFRRS9bMA2Tzr2kSKb8np
	 nOHneHEeQZS8yY6u8AhLQDhJlHwAUQO/yaBgYVFYV+qmPqbKw4KixocXOSlTAEn+67
	 o5ASoEbp/A4MiXMq8fCRKj/0qe3O/PgF/541c7o6g9Eb/bNcfH2liWrZ1vtAO26e66
	 xXF6dro/Gxb+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v3 08/16] x86/alternative: Optimize returns patching
Date: Sat, 17 May 2025 09:08:46 -0400
Message-Id: <20250516214844-2124cf53d3cd13b7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516-its-5-15-v3-8-16fcdaaea544@linux.intel.com>
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
ℹ️ This is part 08/16 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: d2408e043e7296017420aa5929b3bba4d5e61013

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Borislav Petkov (AMD)<bp@alien8.de>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 3de55fa8eadb)

Found fixes commits:
4ba89dd6ddec x86/alternatives: Remove faulty optimization

Note: The patch differs from the upstream commit:
---
1:  d2408e043e729 ! 1:  94c28300c096e x86/alternative: Optimize returns patching
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

