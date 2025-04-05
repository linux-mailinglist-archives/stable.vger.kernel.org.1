Return-Path: <stable+bounces-128391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEEDA7C900
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6142B1894FFB
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 11:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D881DDC21;
	Sat,  5 Apr 2025 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6ShKWcJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420DA8F64
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854276; cv=none; b=sHpg6Bx+GRD9aLyOXesKdmetXf1mnZOCADZKvN3xBscKqOWKFYGG2qLlwwKrn+EabAd/e5UDCWMJCaUPdwj/QmXtZNyVws6awZIAI3+8f2N4mBaQuZ/RwnYOqbXcNTfdSuFcEp2trSAwDFd0s7szxuhJCfgKme/SCmfBLI/qUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854276; c=relaxed/simple;
	bh=KoIgaQQtzBqQVCo4zsDM7cubl2RutsAMq1ki+2udgi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2Mwpj4Vf9CbeWL8XgoYYcHkaHJvyAZQBkBgRDCiNIqnx1UoW1AY+RnxuNnsZw+slt3JNRrMhAt+LauTzAM9k0FxtNL28sBV7h3k1XTanaUShxVoTHpdfAmcO6c5PtLPnnplnIpPrsDiDcz27dxDQCxiEdfzj/J5s0zABc2ZlR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6ShKWcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4944BC4CEE8;
	Sat,  5 Apr 2025 11:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743854275;
	bh=KoIgaQQtzBqQVCo4zsDM7cubl2RutsAMq1ki+2udgi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S6ShKWcJyER4+ARlXDxy0Mrf/ZYRnyVLGF2IgaXVa2uop4JJJMwF58VkzgDCJegm4
	 Rv/S/0750OK7tsOI/PeaejrjpHKESBTF75I7x9qT9u1Uj9P0HR51pD54jSlErAiNAx
	 8mvEykixS6fkZD40dQDIU4EWHr4zVbBxcUkmv2vf8ZQNcr3JHfSAPHcPdR9dqu8vXy
	 +E5TWj3y/iTUE28/yDDhJ8Q0Flao7lLlMM9WWUybd3eyJceGn+pvt8g6Bl92C+Kni8
	 YUuq4Ihd1WjHtgMb4ZLI2VUIVNIvWIiCNeNNeL+wOUmIjr2tu96CSvKP023C1hBLJg
	 X0UNhMictnzvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 6.1 04/12] arm64/fpsimd: Stop using TIF_SVE to manage register saving in KVM
Date: Sat,  5 Apr 2025 07:57:54 -0400
Message-Id: <20250405014349-e5432de237501044@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250404-stable-sve-6-1-v1-4-cd5c9eb52d49@kernel.org>
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

The upstream commit SHA1 provided is correct: 62021cc36add7b2c015b837f7893f2fb4b8c2586

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  62021cc36add7 ! 1:  237bad63ed267 arm64/fpsimd: Stop using TIF_SVE to manage register saving in KVM
    @@ Metadata
      ## Commit message ##
         arm64/fpsimd: Stop using TIF_SVE to manage register saving in KVM
     
    +    [ Upstream commit 62021cc36add7b2c015b837f7893f2fb4b8c2586 ]
    +
         Now that we are explicitly telling the host FP code which register state
         it needs to save we can remove the manipulation of TIF_SVE from the KVM
         code, simplifying it and allowing us to optimise our handling of normal
    @@ Commit message
         Reviewed-by: Marc Zyngier <maz@kernel.org>
         Link: https://lore.kernel.org/r/20221115094640.112848-5-broonie@kernel.org
         Signed-off-by: Will Deacon <will@kernel.org>
    +    [ Mark: trivial backport ]
    +    Signed-off-by: Mark Rutland <mark.rutland@arm.com>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/kernel/fpsimd.c ##
     @@ arch/arm64/kernel/fpsimd.c: static void task_fpsimd_load(void)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

