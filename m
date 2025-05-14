Return-Path: <stable+bounces-144427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DE5AB7688
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CF34C2A3C
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F002951A6;
	Wed, 14 May 2025 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVJJPBq6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F45295502
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253621; cv=none; b=kO+wKC2T9HXPvXCy29JFap6ZGGXTIbMTuNUyNeGQkjO3stu8ih9sfCdyM3JMC66dm24GLIBruIt/l53JHp2rALnEu4QMc91n1CXJzuiu9tYlLwmIVtgMADZBZXLYNfP8r5wiFd6pqMm052qLn6x9jOZnmGNEZp40BkkRUf7ufNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253621; c=relaxed/simple;
	bh=AEl70ACJzLqV82ZPjpUpFuGVrV8h39v5aAPB8niW+Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufrEkO03mJcOvrCSsTb0bz8AWs9T4BQDMS28V1a3o5h/KQGTZW9oer8PHVPJMXWoSAIL2inopBsw9ufW9ZDgISStvUGiTrKv6QaAUyMLqAjKojdl94VKZycaQTb3uW0BlFn7dshPDP9iEMoFQ96UpMXqWygL1H1KqmlsKdbKT1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVJJPBq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBDBC4CEE3;
	Wed, 14 May 2025 20:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253620;
	bh=AEl70ACJzLqV82ZPjpUpFuGVrV8h39v5aAPB8niW+Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uVJJPBq6tcr0/dFw7bf/K9gdjylqg1xd5Z4z6hUDtAd9ipjdf0FmZduV90nPflAQp
	 bwX6ZE1bDbs7Q9/l2AGJhlrIpSQoBRCaA9IAxIcWSjcCnWd/DXvKaL/wguw0GZB/Jp
	 53NRI8SQTmFNEXUnvN3b+gAlxEkJJNzjZCINOog3JLa3qYt8+XQls1TH1b3uOrnXL3
	 /0X4Bn4IqJCV30arRgrjWaBypTA6LBA9wxPlhISIoZUxkfmMa+2kAgX5DpVdTfemKP
	 B35lWZtgWzc7MtNZGWiCR8hAjwKEJLpJiukBZdbVLIZd9J6KUBzuMhmR4QXyw15npq
	 22KiSRB0HtLig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 13/14] x86/its: Align RETs in BHB clear sequence to avoid thunking
Date: Wed, 14 May 2025 16:13:37 -0400
Message-Id: <20250514113946-23aea5f5b7d675ec@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-5-15-v2-13-90690efdc7e0@linux.intel.com>
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

The upstream commit SHA1 provided is correct: f0cd7091cc5a032c8870b4285305d9172569d126

Status in newer kernel trees:
6.14.y | Present (different SHA1: 375fe8890b23)
6.12.y | Present (different SHA1: 5eaa60e1baf1)
6.6.y | Present (different SHA1: f17249f8a872)
6.1.y | Present (different SHA1: 724e897203bd)

Note: The patch differs from the upstream commit:
---
1:  f0cd7091cc5a0 ! 1:  9b2b6206dceda x86/its: Align RETs in BHB clear sequence to avoid thunking
    @@ Metadata
      ## Commit message ##
         x86/its: Align RETs in BHB clear sequence to avoid thunking
     
    +    commit f0cd7091cc5a032c8870b4285305d9172569d126 upstream.
    +
         The software mitigation for BHI is to execute BHB clear sequence at syscall
         entry, and possibly after a cBPF program. ITS mitigation thunks RETs in the
         lower half of the cacheline. This causes the RETs in the BHB clear sequence
    @@ arch/x86/entry/entry_64.S: SYM_CODE_END(rewind_stack_and_make_dead)
     + * Target Selection, rather than taking the slowpath via its_return_thunk.
       */
      SYM_FUNC_START(clear_bhb_loop)
    - 	ANNOTATE_NOENDBR
    + 	push	%rbp
     @@ arch/x86/entry/entry_64.S: SYM_FUNC_START(clear_bhb_loop)
      	call	1f
      	jmp	5f
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

