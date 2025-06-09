Return-Path: <stable+bounces-151981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10662AD16EB
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB9E188B9A8
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D018A2459EE;
	Mon,  9 Jun 2025 02:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVo4IJtV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A52459C5
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436493; cv=none; b=Miy7YE/gXIMCg2kdyZoa+vhijUNHow9PTxeJ+yfZ1sYgq9WIVPfZkWpkf8RXE264yPLHljXnfgizWrhe58UZubovZG1qsONqbQ5pP3n6pZAuCX822Rvh2RsCMKGcQA9l8jnHjU/Fk6bhuJtb8bfjCJsA3XXqDtcjNco+Dj1MUOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436493; c=relaxed/simple;
	bh=4QNv3+tiSMrf2S32qNFSiXpnIpkkggXgh5oZJJZ1mHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUwXoH+i7w81M8c3CYFutKNbmVXvh/TE0xKBqn3UBNDwmiU7F9RpY1HScr7c1tgJLpV/cxFwtz6s8Uddz1ZaOFKLUs+sAv6P/6ryxigvx5k9Lt/khtlvN137Ww+b2SNOa5xR32BIiYXmz8YrUETqaopmROEEj7S4ilUDG2017jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVo4IJtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96260C4CEF2;
	Mon,  9 Jun 2025 02:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436493;
	bh=4QNv3+tiSMrf2S32qNFSiXpnIpkkggXgh5oZJJZ1mHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVo4IJtVC7szczK6g0o/iJneAGhTSZOcnpblqokMNcnt8szgDx1Ly+bMyq1pX4iWO
	 mLsXDbQAKOKA05B92blxgw4jvjsEdZUS6vKY1Pr8BcwFgTJ2ZO/vkmDimduMnSVwPf
	 I8evNcGXibU97kH9vAjlWWXcCYK4MtNcQTv2CKkMfb6OTvg/NbHMG71UpNre8pAFdm
	 AdMdFw4n7ZE2vrwMf/p8tv2vyCSzy3CZkNf7YwXA9Iz8U83TJ+7x03wABOWzvmzAGT
	 54FTnO+fN8bOFypAF+uT0qlz/7bBnzQ+rleswNf1yATToUvN4EA5J1U5BrqLNDZYzk
	 cBLPSLhCtPw+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 5/9] arm64: proton-pack: Expose whether the branchy loop k value
Date: Sun,  8 Jun 2025 22:34:51 -0400
Message-Id: <20250608162507-0c5d167cf94d9cea@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607153535.3613861-6-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: a1152be30a043d2d4dcb1683415f328bf3c51978

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: James Morse<james.morse@arm.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (different SHA1: 00565e8c0860)
6.12.y | Present (different SHA1: f2aebb8ec64d)
6.6.y | Present (different SHA1: 73591041a551)
6.1.y | Present (different SHA1: 497771234133)

Note: The patch differs from the upstream commit:
---
1:  a1152be30a043 ! 1:  20723d888fe98 arm64: proton-pack: Expose whether the branchy loop k value
    @@ Metadata
      ## Commit message ##
         arm64: proton-pack: Expose whether the branchy loop k value
     
    +    [ Upstream commit a1152be30a043d2d4dcb1683415f328bf3c51978 ]
    +
         Add a helper to expose the k value of the branchy loop. This is needed
         by the BPF JIT to generate the mitigation sequence in BPF programs.
     
         Signed-off-by: James Morse <james.morse@arm.com>
         Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/include/asm/spectre.h ##
     @@ arch/arm64/include/asm/spectre.h: enum mitigation_state arm64_get_meltdown_state(void);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

