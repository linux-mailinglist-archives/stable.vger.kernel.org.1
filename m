Return-Path: <stable+bounces-151978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF58AD16E4
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C4F7A4387
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7A52459D6;
	Mon,  9 Jun 2025 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkKSZLg8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EBC157A67
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436487; cv=none; b=uQcWH4B8VONKGXZgHyqre4ECcNiRe3RmGEeTwTMDLX69PVRiIKZhvaoqYJ1cI8FY9SJM3lDQLrz8sLKlbH1cgfllJh41OEhMcWKn6JEpFeygpwdkUx/GBDqawwii+hNyzDog2dhbxziksgQxGv6QYh3KP2Q/0y4k079DWsigJyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436487; c=relaxed/simple;
	bh=VMPYx0nQxof3wXq9R3lPuA0Vqezskp3cm7GivnW4GME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3psm7JC0AQwTdAxsqMNEPMZbZmS9nGTfmIChFdQR5jtgrdBzR670m5BlXgA8KZmW55WyNcXYEEOkVHaaTO2ZgRe3DwgnmhIG7R96/0gJU9w3HjvrhSnkWqo3gUX/dn6Avbd08kU1a+Xffr3VAEG5KXwA8dRKyXSKL5i/pzC/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkKSZLg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE8FC4CEEE;
	Mon,  9 Jun 2025 02:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436486;
	bh=VMPYx0nQxof3wXq9R3lPuA0Vqezskp3cm7GivnW4GME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkKSZLg8fR14BCCfnJ35NoaOTo1+e086QbHX3TEQc3V4qDPR4V2ZuXUIQJiuGLNCk
	 hNTrsedxhFJqhLc3tf1tRQCj3sOTBMZ69YkTj1RKIR7OQ+chWU+XO7xTP/u7vnJr6A
	 Sj45uz+MTABgYV6bHCuLTIh1j/1O0Rbz/WvtAcgp6bZRYkUfN1KB5pv0/wpTkdVSCt
	 34NkJeI/wT63iLMGads6U7Q5akq0VoHeksbI4lmxOkGvYSa0gG453qoCLhXf4A1DX3
	 Ysthq1h+veXlpjHUn01pA4BR3FLs4h+/xeU+HxDFngHzV95fBIwz7wSKYyCGGrxavU
	 kFCaw90OL/qXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 13/14] arm64: bpf: Only mitigate cBPF programs loaded by unprivileged users
Date: Sun,  8 Jun 2025 22:34:45 -0400
Message-Id: <20250608203333-45ba5c3a01522405@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607152521.2828291-14-pulehui@huaweicloud.com>
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
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f300769ead032 ! 1:  25299eb59e44f arm64: bpf: Only mitigate cBPF programs loaded by unprivileged users
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
| stable/linux-5.15.y       |  Success    |  Success   |

