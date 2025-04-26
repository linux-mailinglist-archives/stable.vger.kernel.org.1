Return-Path: <stable+bounces-136749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3B2A9DB12
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 15:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFAE9A1045
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 13:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B66813E41A;
	Sat, 26 Apr 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKBQUt6w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01EC3208
	for <stable@vger.kernel.org>; Sat, 26 Apr 2025 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745673778; cv=none; b=IFlohhISocuZMNlrmGPZMjXgqTgf0v9SKXlq6T1Gc0SN8pzzBldytm+SQDG8Q5giBetbPw3rPkM8v1mLMAqsu12SOeavapP6gCrS63t/YvjXcSCGNR8AQJWwlJxlzKwwI08BTxAVmLDvQuYW+rhGaDZ0tMCoTavQIiSSEv6rInM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745673778; c=relaxed/simple;
	bh=wafDkoGpdVlBPSNhMOagVu5gp0f4Gdso2pZfuQg7Naw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgXGYtzcAqe+k99vYSxPuY8Xofd2GpQydIkY1vyoHhi8VDwyTvwCZ9/wX+0oExQZcYt0eu+BPQd+Aa5Z4zjB0S/Z6QHxTN9rLtXttDurcuqR+PQYhk7pa+HfeGkm5O5a3ycpz7QV8ljjD9iuqtfbPCopTwodlp65CY12z2TSsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKBQUt6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F851C4CEEA;
	Sat, 26 Apr 2025 13:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745673778;
	bh=wafDkoGpdVlBPSNhMOagVu5gp0f4Gdso2pZfuQg7Naw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BKBQUt6wFvGhINIsXNup+2YGFw62vqnKWvND/8paw8lYX34xtO5QTyI/T2h/jcnht
	 Gs4ey+35Biu02Hg2+Y9Evs/olaky1LctFTxvvV2lqoVgGZvWQ0WLJZse6fTcFpnu/p
	 HzSCeV4yeiSJvkf69U03rGhn15k+ehVz9gkTgVM3qxs07pjTzheS/mnJgtP5uHqg9m
	 NPiCY1/QhkiBvFrs+rXqtkTS0ku7Ryl0mmBMYoh2+hdMpEeXzCDVsPOLMvkDd6pwlf
	 /ZYRvpDdRDPuBoyAVGptc/JxcEDugW/DA03ysURm0z6UTHqC6Kv5A+UrkFia9vkVEV
	 h4IYCvXAJiqsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.12 2/4] selftests/bpf: make xdp_cpumap_attach keep redirect prog attached
Date: Sat, 26 Apr 2025 09:22:56 -0400
Message-Id: <20250426045935-045396e7c606a23e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250425081238.60710-3-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: d5fbcf46ee82574aee443423f3e4132d1154372b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Alexis Lothoré (eBPF Foundation)<alexis.lothore@bootlin.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  d5fbcf46ee825 ! 1:  25fd958b2c307 selftests/bpf: make xdp_cpumap_attach keep redirect prog attached
    @@ Metadata
      ## Commit message ##
         selftests/bpf: make xdp_cpumap_attach keep redirect prog attached
     
    +    commit d5fbcf46ee82574aee443423f3e4132d1154372b upstream.
    +
         Current test only checks attach/detach on cpu map type program, and so
         does not check that it can be properly executed, neither that it
         redirects correctly.
    @@ Commit message
         Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
         Link: https://lore.kernel.org/r/20241009-convert_xdp_tests-v3-2-51cea913710c@bootlin.com
         Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
    +    Stable-dep-of: c7f2188d68c1 ("selftests/bpf: Adjust data size to have ETH_HLEN")
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

