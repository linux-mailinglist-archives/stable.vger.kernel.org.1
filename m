Return-Path: <stable+bounces-158592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F290AE85C2
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C252E1889349
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B9F264A84;
	Wed, 25 Jun 2025 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGtyAv9p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7D264A9C
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860543; cv=none; b=Z6Z1S0zIxqsItKgui5dHkGkUgKL9cnKHq0Y3382yHrtu7kJtzjQSywfoUsdt+6X/yZAoQhwOxs3Lb5tAMlptrG3+jHxWdkrWeG5DvvlSKzu7FHuTTo9rs3UROdlAoUy/mq4LH/ikps3zDZYP0zDBl99peVq/gVrmV8e3YeD4UXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860543; c=relaxed/simple;
	bh=KYC55DC3WWZ0J5bnBCWz8ijFvYPy5hG2AGa6eyB2FgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSB2mf73hmNf608Z4CTiRNceubdI4b5ahT+7B6C9a09/QXNZh2I4JJqNYdu3oGKeZ6L96w/srZBy/sf0l/5o0/4Lee3cIm+UD4VxfDUWlvwzL8jcj4FSQkmxIu569hZ3fayVge4bLjg8lx4sGNGalt1Kw39lq53rLuC1V8gSCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGtyAv9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F287C4CEEA;
	Wed, 25 Jun 2025 14:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860542;
	bh=KYC55DC3WWZ0J5bnBCWz8ijFvYPy5hG2AGa6eyB2FgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lGtyAv9p/C1c9ATNe8A2wzi+BBf7U1ibpd5JhD3sVMM1yj+tWdch9sl+4upTypObF
	 nQNGf3+buUYEkBvf+PMeF5UYwC0jg0JBky02UYp1R+D/l0U48UZj5nFJm0lrWDCVuZ
	 OO/fjTyJBRcKp3fc670kt5bD8qz5QAnRF+shypgM5WR/tqqV8SGZVldqkFq78cQ2bt
	 OzWtbpv7t7hpDRidAn2HYL3xyCbnPnAHEHSPoOsreVpD2nnDIjnFlRReEJ4SzIKvyS
	 iWQwx+Hv3HEuxHKGnp3D+Jd+rOOisvM9nyCHSVebQq/0CNZNPPDre0CQKtbE86e1Bv
	 npeuXdemP4z4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.6.y 2/2] x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
Date: Wed, 25 Jun 2025 10:09:02 -0400
Message-Id: <20250624194811-bfb1b41e1104004e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250624170413.9314-3-sergio.collado@gmail.com>
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

The upstream commit SHA1 provided is correct: f710202b2a45addea3dcdcd862770ecbaf6597ef

WARNING: Author mismatch between patch and upstream commit:
Backport author: <sergio.collado@gmail.com>
Commit author: Nathan Chancellor<nathan@kernel.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: ebd352672790)

Note: The patch differs from the upstream commit:
---
1:  f710202b2a45a ! 1:  defa6b7af5a11 x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
    @@ Metadata
      ## Commit message ##
         x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
     
    +    commit f710202b2a45addea3dcdcd862770ecbaf6597ef upstream.
    +
         After commit c104c16073b7 ("Kunit to check the longest symbol length"),
         there is a warning when building with clang because there is now a
         definition of unlikely from compiler.h in tools/include/linux, which
    @@ Commit message
         Signed-off-by: Nathan Chancellor <nathan@kernel.org>
         Signed-off-by: Ingo Molnar <mingo@kernel.org>
         Acked-by: Shuah Khan <skhan@linuxfoundation.org>
    +    Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
         Link: https://lore.kernel.org/r/20250318-x86-decoder-test-fix-unlikely-redef-v1-1-74c84a7bf05b@kernel.org
     
      ## arch/x86/tools/insn_decoder_test.c ##
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

