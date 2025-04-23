Return-Path: <stable+bounces-135274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF308A9897D
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CEF179D3C
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C831EF39A;
	Wed, 23 Apr 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0icOAYP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857D8632B
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410623; cv=none; b=cLnY+cQvIa6d3n+uJmvqj84yINR/qPdB3GDc1MAt2wpVo2juC2C3Mt8eKacv71UN711/Fgl51ik2ihEx7vEGfeq7P4kvBrhBjbt9RrDbH8a8j84cubH0zQxGS+JexNf80kd63A8l/tYMXekRV2BpmlJlG/Y+2fLWNGd6ZAQbWjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410623; c=relaxed/simple;
	bh=BII0zNLeoNtDSnzS1JQGW5tRNI6vYpko1kP5a3vmnBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C59lpxMb+BhgiENiLHsMDLxHBS5aZyOxaJN8cDBQ1a340O/q2Rd6zK1dx62qn3QYn/IdBKA2pOeCANMDWthnjC/3u8ZJoo2LICyhdLcou/1wGcBH5RWI+7X8xdxnJU1yTmL1lGu0VVHeoHxeDJF8/mM7Ne2NrrPqwdWr/P3ft6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0icOAYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0835BC4CEE2;
	Wed, 23 Apr 2025 12:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410623;
	bh=BII0zNLeoNtDSnzS1JQGW5tRNI6vYpko1kP5a3vmnBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0icOAYPNJfmhKK5bEKHcYH4vWED3Lbk1w1buUoCk3aNiTSHwqeGGOyNotrv3ARKl
	 irDxx1p+BM8dh+2/FkaKXEFgBCwefhY+Qvu8HMaLFc0f6o/d158Hk6YsIeACZjSOpp
	 plOcGN/1QSO7baG+9Y8Gs14dveWdO3WlwmZGWTk3MbUSmGMFOrHKP2fBy9MVOjnxaQ
	 JWHmFEREzP0+AixjBN+fmBq6+Lu2ESWrFayq482zeR10aQS+B6TY0l5KPhmaF1qmnH
	 IOpvOIdPGU/2dlVk8R/agDHrObK0Bb9WK9M+IrW3Ajem4rticBw6jvs1x3y8uqV/J2
	 vp2hRJYq0JWqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.12 7/8] bpf: fix null dereference when computing changes_pkt_data of prog w/o subprogs
Date: Wed, 23 Apr 2025 08:17:01 -0400
Message-Id: <20250423081022-df8541695284f0d4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423055334.52791-8-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: ac6542ad92759cda383ad62b4e4cbfc28136abc1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman<eddyz87@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  ac6542ad92759 ! 1:  10066c4273710 bpf: fix null dereference when computing changes_pkt_data of prog w/o subprogs
    @@ Metadata
      ## Commit message ##
         bpf: fix null dereference when computing changes_pkt_data of prog w/o subprogs
     
    +    commit ac6542ad92759cda383ad62b4e4cbfc28136abc1 upstream.
    +
         bpf_prog_aux->func field might be NULL if program does not have
         subprograms except for main sub-program. The fixed commit does
         bpf_prog_aux->func access unconditionally, which might lead to null
    @@ Commit message
         Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
         Link: https://lore.kernel.org/r/20241212070711.427443-1-eddyz87@gmail.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## kernel/bpf/verifier.c ##
     @@ kernel/bpf/verifier.c: int bpf_check_attach_target(struct bpf_verifier_log *log,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

