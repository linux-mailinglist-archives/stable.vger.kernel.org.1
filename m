Return-Path: <stable+bounces-145984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F25CBAC0225
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF39B4A761D
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EE854640;
	Thu, 22 May 2025 02:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfwTMjB4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5656118E3F
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879562; cv=none; b=tNihok3cFZUAJbaWMYQzd6cNDLLTSO9Td/YjWQQbbjl6MRJZhsgWPnNFN0tcEI41ZvFhQtbosvElXkdZChnTh8+PJMxCiMFo5GfzFDRsIcjIm5uR9AI3QX0Tl8MkFjr8U7z/SQwR989YGIaZlJpYjL8J2wrLS9DraK99eYPjLto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879562; c=relaxed/simple;
	bh=2QqRspW7lZ7gRpGFysiDieRPxyXfzGjD2yxJqWZwl2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDqwH1gILXjMUD8vCh5wglKByFaRR1OSMzoOzrUwUQTGTP3VTge/9Q7ZkvfRmW9m9oLLT/q0CtCFxYTzXxmKpxPpTiJE7Hy0fTv4AypiUG5IAOebFib3xynq4UGVj1pO04vA5irTNPCeQ1drGDfBU2EBhm+E6BNEXLihv8YjQyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfwTMjB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F82C4CEE4;
	Thu, 22 May 2025 02:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879561;
	bh=2QqRspW7lZ7gRpGFysiDieRPxyXfzGjD2yxJqWZwl2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TfwTMjB4aRrUIlCb/Fr1JVilacM4exTE8TMWZs/tjZnE26VlAJM+tjHO1pOnkPd3z
	 N/zNVzSL2vRxzHNyCNLHoDqHT2QcdGvrDgzxvlolJjPHr4AZtepubi0pSqs8JDsdd1
	 5ndt3a5nlbmiNgztS7j7UMPabGCLyqWRN1LwTHXAIlzQj1ppfofU+lnx08mVguF+DV
	 fb4P1KnKKxTeeP5YCBDuAPP1z8so5qEtybWxFZofIma9s0tgIEF3PIvzREFnKyc0wa
	 j/h4Ri4L3PEk+oX9C7O+p7LEJh2VI0x3kDergszFDsrRfBqER/v4r3Cc3FLZvQABee
	 j16jMxMJ017IQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 10/27] af_unix: Link struct unix_edge when queuing skb.
Date: Wed, 21 May 2025 22:05:57 -0400
Message-Id: <20250521202907-1328294e447284b4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-11-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 42f298c06b30bfe0a8cbee5d38644e618699e26e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  42f298c06b30b ! 1:  2a936f6956d7c af_unix: Link struct unix_edge when queuing skb.
    @@ Metadata
      ## Commit message ##
         af_unix: Link struct unix_edge when queuing skb.
     
    +    [ Upstream commit 42f298c06b30bfe0a8cbee5d38644e618699e26e ]
    +
         Just before queuing skb with inflight fds, we call scm_stat_add(),
         which is a good place to set up the preallocated struct unix_vertex
         and struct unix_edge in UNIXCB(skb).fp.
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-4-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 42f298c06b30bfe0a8cbee5d38644e618699e26e)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: extern unsigned int unix_tot_inflight;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

