Return-Path: <stable+bounces-151959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E09AD16CF
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2248716790C
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF842451F0;
	Mon,  9 Jun 2025 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSdmvsL/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF805157A67
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436446; cv=none; b=lHdmDgjco1wvP3SIBSLXwt5K0jYbmD9A792cDCrc9zaev/Pki9knrxEbyDS64HyDd48w5RqP6c+c9PooGD6+uUJCEWG7rc2eVVzOPuLk9HkruIvd67qGbJyjVbXSuNqIn3BhRLGbdi4hl5hcrcewJPeW3PJRJlymkKBa1HJyj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436446; c=relaxed/simple;
	bh=tyhz6gNLCzzungrFmzAiwPJxMG8iWtggNXGMoTTWT8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNTr0q0X/K/SxhPXJh/Ch8HVXUPceRgSlW/ITv7lqpwR3SAqLIp7T2y7td4xiQ6SF2mw/l7DXFD0GJZO73VFdpcKyNsVIuqVfmQTh02mtA857GWI0LtF41EzqAiM1zX18/sevZmiKpUrJa0XjTw0Fki0sZl8C9cXmoBfMUOT0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSdmvsL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E04C4CEEE;
	Mon,  9 Jun 2025 02:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436446;
	bh=tyhz6gNLCzzungrFmzAiwPJxMG8iWtggNXGMoTTWT8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSdmvsL/VuVOc9E5t4Bt4RrAYb7vVNOqjExvdeb3Z2Ooy9rIU5xfXREi9gYDS5pFO
	 6cy+b6APmR7to7pDRm50q/KyyVtls80kx2/wOjLU+Vg1byAwyza6PT+rAZ154FV/ZL
	 soLXIwmtFxbKRJXjM8WNhPECVax2TRLKrD37mxUswVFLFWCLBxMUcvFiXPAIZ8Fq6x
	 kkFvezorHaA4rzWpkhzshhvOBXkPCg1MRqx+hU/f7ukUrmdeu4Hqclzw5Qf1u2wUQ1
	 VdJAYIltZ9DjJUkkVo3ujO0IWPmdGqbTQIm0r9IaUFonorqs25ZhQxYHzqXPrLqOaS
	 7KTYQv5/nG5og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 8/9] arm64: bpf: Only mitigate cBPF programs loaded by unprivileged users
Date: Sun,  8 Jun 2025 22:34:04 -0400
Message-Id: <20250608165759-4410a9ff2f9669c3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607153535.3613861-9-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: f300769ead032513a68e4a02e806393402e626f8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: James Morse<james.morse@arm.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (different SHA1: 477481c43482)
6.12.y | Present (different SHA1: e5f5100f1c64)
6.6.y | Present (different SHA1: 80251f62028f)
6.1.y | Present (different SHA1: 6e52d043f7db)

Note: The patch differs from the upstream commit:
---
1:  f300769ead032 ! 1:  238fedf68f1c7 arm64: bpf: Only mitigate cBPF programs loaded by unprivileged users
    @@ Metadata
      ## Commit message ##
         arm64: bpf: Only mitigate cBPF programs loaded by unprivileged users
     
    +    [ Upstream commit f300769ead032513a68e4a02e806393402e626f8 ]
    +
         Support for eBPF programs loaded by unprivileged users is typically
         disabled. This means only cBPF programs need to be mitigated for BHB.
     
    @@ Commit message
         Signed-off-by: James Morse <james.morse@arm.com>
         Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
         Acked-by: Daniel Borkmann <daniel@iogearbox.net>
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/net/bpf_jit_comp.c ##
     @@ arch/arm64/net/bpf_jit_comp.c: static void __maybe_unused build_bhb_mitigation(struct jit_ctx *ctx)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

