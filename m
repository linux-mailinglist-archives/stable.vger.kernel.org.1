Return-Path: <stable+bounces-135272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9394A9897A
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93038174524
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763111F37D8;
	Wed, 23 Apr 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUr1VKmc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366FB1119A
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410619; cv=none; b=G2ZnGpzrXJlUW6paXij+cjKSTUuwBbUSmDVNDVYiN8r6fJInC4LgZPT3fa7Ernqyjic7bnwMkPC++7DSbF5fRpLccM9DLNR5faOvhUMqwx8++FvTCeudcvb/p3xo3Vrjkmz1TpO/AA40TxYBHxhg/qxReuEq9eBDRxPkqx5pA9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410619; c=relaxed/simple;
	bh=VmSP3tZD7ru4IbmdRivpqjr0TGcqJLQen4nfOiOMTV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyGmx4Z0gE/5ONF2KqN/cgIrTqj78lgJum6Hu4iNvr1NrmkcipNbRLzYp8PhVPS527O81NKTAG9sNhv/UQhrbd3+rT7g72CaKeGJeK4x8KndQ+RJlpXATKS4zMPby8oaLWbVJsL9SR6T0DMiE3ztd0n2IucIYr/2msuuvijCyS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUr1VKmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5CBC4CEE2;
	Wed, 23 Apr 2025 12:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410618;
	bh=VmSP3tZD7ru4IbmdRivpqjr0TGcqJLQen4nfOiOMTV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OUr1VKmcZ/EnN0vwbWPp53womkkItpxkOG8JmXrtWo0ySBaZ7xr/QsI7VrRU0BmY/
	 3bMyWHO5AU5meelHje+bnIYbaHGvL/H+oLyPAdDi3/mgC9wsdXWQ1yIiACq0o1/DFV
	 kxsN+1Mi+seaPbJ++q/wr08RfeGqgtB0slEt7b4yeisFtJAtidCfpuvg41tnOBMAI8
	 rOIRDYOYuSALZhQvrbH5XWXpFWSWxGGVH+5Mv9Rjrq9+GjXHtZnyf+vGwx9coIGQwI
	 4l7p2+74jUSFlYGNcDNyHZR2C1OL1L2E2UYhROl5SnoTXLHx6JAG+ybE2TxHzcXntx
	 n777Bs6k05kRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhi Yang <Zhi.Yang@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] xfs: add bounds checking to xlog_recover_process_data
Date: Wed, 23 Apr 2025 08:16:57 -0400
Message-Id: <20250423073617-10311c814bb02a1e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423072750.3369814-1-Zhi.Yang@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: fb63435b7c7dc112b1ae1baea5486e0a6e27b196

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhi Yang<Zhi.Yang@eng.windriver.com>
Commit author: lei lu<llfamsec@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 7cd9f0a33e73)
6.1.y | Present (different SHA1: d1e3efe78336)

Note: The patch differs from the upstream commit:
---
1:  fb63435b7c7dc ! 1:  bf85574b1bf1b xfs: add bounds checking to xlog_recover_process_data
    @@ Metadata
      ## Commit message ##
         xfs: add bounds checking to xlog_recover_process_data
     
    +    commit fb63435b7c7dc112b1ae1baea5486e0a6e27b196 upstream.
    +
         There is a lack of verification of the space occupied by fixed members
         of xlog_op_header in the xlog_recover_process_data.
     
    @@ Commit message
         Reviewed-by: Dave Chinner <dchinner@redhat.com>
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Zhi Yang <Zhi.Yang@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## fs/xfs/xfs_log_recover.c ##
     @@ fs/xfs/xfs_log_recover.c: xlog_recover_process_data(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

