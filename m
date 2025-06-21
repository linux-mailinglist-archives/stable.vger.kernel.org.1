Return-Path: <stable+bounces-155216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD165AE281C
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2CAC7AE08E
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E011DE2A0;
	Sat, 21 Jun 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piPnDDTr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856031922C4
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495913; cv=none; b=raKDtCsjtJtEIH/lqsZ/48EMOLWYwcgWd3z93qSxsDAwP8ZLoY8q2kelICJDel+3T0Xxe6cVR/xAqDFzapzjERZYc8FybqLFd1uI1ayu2nwBE6LOvELUmWgL41NNKFnDfU1szISPMbwWrOLW+sWbnbCpEec0YYbX51VpinWjsQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495913; c=relaxed/simple;
	bh=d8dDovMS11vZ81Xn55m7ycOkFrwFn3p8urNBs45iHJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YknNyqOd0IrqkMaxROy9QQGmmyN1eGUYL7iOkTvRtM5qLMs2Ghkk7vc/DGLP3ScjtzMkfkrHNtaWKMZBasb/t+ZbS1S5HLdO1d9HK0plwxDnMn9gP4D/L18/bTW8X3zcBs7TwLoFXQPzipOk737Vjg1+33SlBD8Jv3YLRh/Djq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piPnDDTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFDBC4CEE7;
	Sat, 21 Jun 2025 08:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495913;
	bh=d8dDovMS11vZ81Xn55m7ycOkFrwFn3p8urNBs45iHJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=piPnDDTrjFHABtqX2PIA6v1GMyMx98q3x3ChCPIFo8sECwNT0UN+M7k2O67Ciighh
	 fRKVRsZgXSzzTSrE6Oe6wAOIAJBD/j1LvyzAHFnJGLthn07KBI+nCAr9lLLQ/RefKj
	 axJOnwbSOdDPn9uZoQDR7dzIZnXIZMOz6yoAn9D0y0bzcXvWDfPeRxswvtp28W8fwQ
	 EHw7G63FmfvqLkjB/YB+ayajEVnmJ10CATmVlt/RY6kzles+p59Mo+GtFOVbXQo/Xb
	 4PSe3ecQlv5vNUShVC6WnvfSdCD+Bn58JbJ+TwkcxBemolst02m4N9dOWtw8QxT2QL
	 X1PUbIXG53Mhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sj@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.15.y] mm/madvise: handle madvise_lock() failure during race unwinding
Date: Sat, 21 Jun 2025 04:51:51 -0400
Message-Id: <20250621033546-1fcedcafae052ec1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250620164257.92454-1-sj@kernel.org>
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

Found matching upstream commit: 9c49e5d09f076001e05537734d7df002162eb2b5

Note: The patch differs from the upstream commit:
---
1:  9c49e5d09f076 ! 1:  0f9b85d494656 mm/madvise: handle madvise_lock() failure during race unwinding
    @@ Commit message
         Cc: Vlastimil Babka <vbabka@suse.cz>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    (cherry picked from commit 9c49e5d09f076001e05537734d7df002162eb2b5)
     
      ## mm/madvise.c ##
     @@ mm/madvise.c: static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
    + 
      			/* Drop and reacquire lock to unwind race. */
    - 			madvise_finish_tlb(&madv_behavior);
      			madvise_unlock(mm, behavior);
     -			madvise_lock(mm, behavior);
     +			ret = madvise_lock(mm, behavior);
     +			if (ret)
     +				goto out;
    - 			madvise_init_tlb(&madv_behavior, mm);
      			continue;
      		}
    + 		if (ret < 0)
     @@ mm/madvise.c: static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
    - 	madvise_finish_tlb(&madv_behavior);
    + 	}
      	madvise_unlock(mm, behavior);
      
     +out:
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |

