Return-Path: <stable+bounces-125671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B79A6AAB4
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 17:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BC119C03DF
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0E71F03F2;
	Thu, 20 Mar 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T64PPxxD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3791EF394
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486639; cv=none; b=GkMzAAv/2FkFB+6EbCvavRYhZIJZR+n30NPba/qrfMui0V5kIremgMw3rTeLT0l3kxHQZhqzobXempq8HRbbKv3UdeIiZ8t2FOFIwcY+yz1U2GwYGOx8+I7vOONUFLPTeeBMM1SDin80iEwb/K0tQD0eFazcs6SM6JhifR+vJBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486639; c=relaxed/simple;
	bh=iC/rfbhAqVzwf5o0IkpqRFPB2D3d7Cs8DgbgyADqi2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAUYPUbK1/4XGdcbEaJ/+z3+7UBoT50exB0F67q3Bd1e9NCfK6jwrkJpFjE+3ntNMBnNkmOTopxPbmoOgwAAy8M8qXmd5RdEhKVE9R7chXPqdfvdp/DobjdizBS4az2ZUVIyuJkMfprfAFA3fVZkZ6ekE71ghsK8Yvwx/x7UJw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T64PPxxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED70C4CEE7;
	Thu, 20 Mar 2025 16:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486638;
	bh=iC/rfbhAqVzwf5o0IkpqRFPB2D3d7Cs8DgbgyADqi2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T64PPxxDPO4CBPQ+JoR7WBbsljU+lFeyYr4dog3IENHX9vIroqN8SUS5jPUX806a7
	 r6KQzqX2YIBNireM4AC1nN1uvN00Ew5s0iLtg7z4n1CKzrIoKrboe7P5AhRLTgBYSx
	 1ewEUBxFCwwmA2KJB1xwzw3VI7V4wu9pAbgEAb385pK6+rDbX+SFVhFXKBVfyjQDt4
	 ayWF+h2/6CHbO3QEltbmFjLDfuU0IBKiEFpNhQ02SRrXAc3Ieh1a8mGXqRFQH9V45v
	 IgIZpXZorMao5YyNLuQDedAtsDEXMk5aB/VGBQ7+/3Epk1qVfNfCU5AYBzP/SIU3ED
	 OJFBeoljqcTOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 6.6.y 1/1] netfilter: nft_counter: Use u64_stats_t for statistic.
Date: Thu, 20 Mar 2025 12:03:46 -0400
Message-Id: <20250320115029-c17a5a20b63e96df@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250320124108.338412-1-felix.moessbauer@siemens.com>
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

The upstream commit SHA1 provided is correct: 4a1d3acd6ea86075e77fcc1188c3fc372833ba73

WARNING: Author mismatch between patch and upstream commit:
Backport author: Felix Moessbauer<felix.moessbauer@siemens.com>
Commit author: Sebastian Andrzej Siewior<bigeasy@linutronix.de>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  4a1d3acd6ea86 ! 1:  348975e270b55 netfilter: nft_counter: Use u64_stats_t for statistic.
    @@ Metadata
      ## Commit message ##
         netfilter: nft_counter: Use u64_stats_t for statistic.
     
    +    commit 4a1d3acd6ea86075e77fcc1188c3fc372833ba73 upstream.
    +
         The nft_counter uses two s64 counters for statistics. Those two are
         protected by a seqcount to ensure that the 64bit variable is always
         properly seen during updates even on 32bit architectures where the store
    @@ Commit message
         Cc: Eric Dumazet <edumazet@google.com>
         Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
         Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
    +    Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
     
      ## net/netfilter/nft_counter.c ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

