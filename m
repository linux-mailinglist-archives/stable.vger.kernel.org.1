Return-Path: <stable+bounces-151977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8D2AD16E2
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A23CB7A4114
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879232459D1;
	Mon,  9 Jun 2025 02:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfGdpCiW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B32459C5
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436485; cv=none; b=rxQ+b68dZWqm5qvuXI07X8S47QARdIuBvWzSsw549y2Ii+n+TsyWuKBNXLilfHnEW+OuViOc2D6tkxoXcL69wzr9oa6gyIKSrIfcMJ2Sq1o+ciIyE5gAbRiqTxGOftWtG7DpxiCBC8k9DBW9fDtb2I+OI+PGg3121POEAUIYpqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436485; c=relaxed/simple;
	bh=bozrrDnevMGfpSyeywNhtOSxX435BWvKnGTPTMcpv6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJHjBH0HGhx1YlF6VgmizFIQJjzqmWZdxwijoGtkK9mwPPommCyi1iVZLllVSigc7xCvUiHV+tLE+DJoV5ZASLEjOEhMCmTI0uMBH7aRx+/xCOHK4D62K6m6gBMO3+14rUokc5WUeaoMwtfIYaUlRjpZQXlLCY6wPUm6/9dCkU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfGdpCiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599F9C4CEEE;
	Mon,  9 Jun 2025 02:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436484;
	bh=bozrrDnevMGfpSyeywNhtOSxX435BWvKnGTPTMcpv6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WfGdpCiW2p6IVBwG6gx0Fr0gl5jRBo9KPNfHsfxKSsmm3EQaNbWsy/zTsLju/gZWj
	 ZQTrwBFyp+CRCg39mVGIWSrmUNHocYW29AH4MF6OCSCp5bnddHe2kivKQ6Mu3TtuMi
	 36VLa2Rg//nEYb8KBBbeA9JdtZG2+J6OX9H2l2S7lq1kLM28Z40FPuzYu7VXb5o8HO
	 XM0jjfUT8QW/Kc8A0Kp2ICSJj7E3n1mskE0XCN4RJe1fFtLSuvkGYLaNiOCUn0XK4n
	 q7c9XUkaYRVIbig9Wdgtbk54vZBjc1ks3Kf6UOHlJX+yQ+BZ4oxXPA6KAJeJTVNd0+
	 Al6WiAJNTCdeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 9/9] arm64: proton-pack: Add new CPUs 'k' values for branch mitigation
Date: Sun,  8 Jun 2025 22:34:43 -0400
Message-Id: <20250608172016-456389fd507788ac@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607153535.3613861-10-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: efe676a1a7554219eae0b0dcfe1e0cdcc9ef9aef

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: James Morse<james.morse@arm.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (different SHA1: 2dc0e36bb942)
6.12.y | Present (different SHA1: 2176530849b1)
6.6.y | Present (different SHA1: ca8a5626ca0c)
6.1.y | Present (different SHA1: 9fc1391552ad)

Note: The patch differs from the upstream commit:
---
1:  efe676a1a7554 ! 1:  f17311a7544fc arm64: proton-pack: Add new CPUs 'k' values for branch mitigation
    @@ Metadata
      ## Commit message ##
         arm64: proton-pack: Add new CPUs 'k' values for branch mitigation
     
    +    [ Upstream commit efe676a1a7554219eae0b0dcfe1e0cdcc9ef9aef ]
    +
         Update the list of 'k' values for the branch mitigation from arm's
         website.
     
    @@ Commit message
         Link: https://developer.arm.com/documentation/110280/2-0/?lang=en
         Signed-off-by: James Morse <james.morse@arm.com>
         Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/include/asm/cputype.h ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

