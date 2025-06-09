Return-Path: <stable+bounces-151983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4BDAD16E8
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB30E16915A
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA772459D1;
	Mon,  9 Jun 2025 02:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7Vb2u5F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E586157A67
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436497; cv=none; b=PLPNE55vU4piFJPmGqbRx52/qFe5JMUsLt2cljMTxypVM3X7eGhCjNpEkXNkY6GveiQ08/CdXwyEcFUuWY9DNWe3Vd4n6GDzRcZKHr22vL9/uhql7v/FnYciiUEUa9JMtFsc9p5gV64+jmVFlf0JcVgPc3GhrkntooP4a4q+Kzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436497; c=relaxed/simple;
	bh=mXhfpmji/1cvPwbzKfxXVx0N3KYvUvNtHGSTUs5QC5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSedSxm71tc2aOmgXsTBe3mSggv4qjcoDv+smtQgjPRsQW0umv/G4IWUCkeAKFl7oRuKz7IBUCTk4yo5S3HhMR9QOW5NxR/Ezi5LYnQ0gTJe1BNVPLlqHgN8ef2l50yC8z8vO+/wbFkEY6wl9nhSovKr50DI3mDlT80TOyz6WPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7Vb2u5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEA4C4CEF0;
	Mon,  9 Jun 2025 02:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436497;
	bh=mXhfpmji/1cvPwbzKfxXVx0N3KYvUvNtHGSTUs5QC5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7Vb2u5F4XIKJRw3tCdl2tYWtdUALD6HtVMhjHBZ2oTPZzwySl9C171IY7dooNfiV
	 UXcHe/DsqxY51n5/j5eP4x+8vSmWb0vzEcaDaKMkHMAEn9bqE1kKFqv8aZZRD8w5EW
	 cxyHzuFMViPvGNA6jFbz1tZqvImSPU5AS5onIfp9hplsHD2GckdtCiuTZIfAQDY/BK
	 +52chkxEs3Hhbia6chDaT0+aBOppnoi3IXuwqR4HsGoplQyzw31WgVNRXxzrJj4kH8
	 6ryPPtXSG+lgcjxKZbYY3sDv6Pg4lq6SUquN37LEIsBAYYI6txGjnOQAxCy6h8QhmC
	 Bkj7/pFGVVybg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 14/14] arm64: proton-pack: Add new CPUs 'k' values for branch mitigation
Date: Sun,  8 Jun 2025 22:34:55 -0400
Message-Id: <20250608212201-2e47c75e92d318a0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607152521.2828291-15-pulehui@huaweicloud.com>
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
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  efe676a1a7554 ! 1:  aca0c37d8a070 arm64: proton-pack: Add new CPUs 'k' values for branch mitigation
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
| stable/linux-5.15.y       |  Success    |  Success   |

