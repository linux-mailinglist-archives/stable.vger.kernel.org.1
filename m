Return-Path: <stable+bounces-106113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8FA9FC757
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 02:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91BE162B2C
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 01:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A1CC8F0;
	Thu, 26 Dec 2024 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzQXmeMQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C4BEC5
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735176108; cv=none; b=DgrkVd/LQ5GsypSYctI+3dQNjuckLvZ8evFFFdDdaWAjXU66yV3kYtzaaxPm9BI1y8yaBkxtrmLphgBKXhUR3qopeA7vP9vZn4CiQfXXaw4pexoktVvliNuz3ZZfjxZrSA2/gxGIQZDP7kmLb2lbiQFaMnquJ5YYVnLS/1gccIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735176108; c=relaxed/simple;
	bh=WDmby4bpkgO2o6jl0NV24nJeOm0c6WJA1wnAA/qYanQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dq80WPGLVo/xDqe2NKBoU4B33hRj7rTm1uSX+0VMNRHGeeHX3zKL9iSb/paQtqm7mk0Tf6xO8yXNvqXBvnvsfc++Czr0Iv6CQZGQkOI4h9bo8phu9SuaxmsgEg4WRgZYZygIQ47JU18Kd1g+yAQb/BLIW6USxHYxUxNLWS3Uv5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzQXmeMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957AFC4CECD;
	Thu, 26 Dec 2024 01:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735176108;
	bh=WDmby4bpkgO2o6jl0NV24nJeOm0c6WJA1wnAA/qYanQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UzQXmeMQM72UfzZqxnNgkdhREBBgzFGBy/RLYxidb3aN8zMXaGhkQDMG/pwMpMEXW
	 lOCDayqCeeawrWeMS2FImQh7YhVLK/oZot2B7eOOfku6BAjb+UQF1XeaDwAG6HZcsp
	 6vbbygMxF4rd41cYsf/jG+QHrBBO6Q6xone8iRgn+mDA/LTQkIOGReGLN22VvcDSLZ
	 0EsOQVipE1jIc9vbwcjALwLKVSlkhsRbpM0rgvY5EDlq5JAieN8DdavJtn+EZ2A+Df
	 hvkVZ8paLXFEEMGx61ZxGe5qxwyOtvhUShNBz5gvJ7GX+TfPUnKoXBV5YP67V29Wrg
	 qnZeuvdjQAoCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1/6.6] MIPS: mipsregs: Set proper ISA level for virt extensions
Date: Wed, 25 Dec 2024 20:21:46 -0500
Message-Id: <20241225174433-a6ea649ee16c8b60@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <38A42FE743EFB36A+20241224062239.19248-1-wangyuli@uniontech.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: a640d6762a7d404644201ebf6d2a078e8dc84f97

WARNING: Author mismatch between patch and upstream commit:
Backport author: WangYuli <wangyuli@uniontech.com>
Commit author: Jiaxun Yang <jiaxun.yang@flygoat.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a640d6762a7d ! 1:  b6d3079a55fb MIPS: mipsregs: Set proper ISA level for virt extensions
    @@ Metadata
      ## Commit message ##
         MIPS: mipsregs: Set proper ISA level for virt extensions
     
    +    [ Upstream commit a640d6762a7d404644201ebf6d2a078e8dc84f97 ]
    +
         c994a3ec7ecc ("MIPS: set mips32r5 for virt extensions") setted
         some instructions in virt extensions to ISA level mips32r5.
     
    @@ Commit message
     
         Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
         Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
    +    Signed-off-by: WangYuli <wangyuli@uniontech.com>
     
      ## arch/mips/include/asm/mipsregs.h ##
     @@ arch/mips/include/asm/mipsregs.h: do {									\
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

