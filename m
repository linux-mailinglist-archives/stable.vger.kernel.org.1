Return-Path: <stable+bounces-132787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAF8A8AA40
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7A93BA6E2
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C66257AD1;
	Tue, 15 Apr 2025 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oki1cYT/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83EB253357
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753398; cv=none; b=JRI6ajvT9UoE4CUB3CX7A6RLsERJI1nYIHyeGqXjVj7nREqOlrq65VpBORgtdLm4GL4H1GMo7rYfv7a9GfxM+h2Yl3RpkZITtLyEy/jUdJOJ910NT70TfyZ27A4eJPJxjRhpeRjK+F5A4FJF0kmkREw9X8RIZaC9wK/xuq38Nkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753398; c=relaxed/simple;
	bh=iZuI8ptXsEq2CMQokOtbI76KrnRg6y3FA3L69zGSIeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGKR9GmjLPZQUz5RONZOg/OccILX7nGxzI66xb0tO+2xPzEUx5dDd9AnzP/QVSX5k1V99BwlNXH5N78gG5944/Pfs5nSOwaQTf8L3hd1YNKQxRHbDjAvqSELPN1XWegU88JttP8D91+MJo9O/pSie2nPXU5ZTkAKubpWdEacSjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oki1cYT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4D7C4CEE7;
	Tue, 15 Apr 2025 21:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753397;
	bh=iZuI8ptXsEq2CMQokOtbI76KrnRg6y3FA3L69zGSIeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oki1cYT/XlOjbwoUCrjca5Py8YAWEY3rUiUb4zzal9RflVaHXg6YQ75SV70NacLa+
	 VQkbkNjb87GsRcR9oQyQvxXSUFCMIQSbyPZDijfZPBfHOJhFM/G6yFAmF5gTGdeKVa
	 UUFe9Q7RX67FvwK5ppK8l0ApjqI3oPhbnD6f74AMJr8MBjPEuuSzOC//IMwBea8/xH
	 snasM0ChepSLvScIQyFlEIGON2M8x+f2vL3EkVoIDKXxAbI1sEQM8szTqHC/K+dvyi
	 6exog6NvGSNdnnErVAnTK+Wfz3rXBdHyWUckcNSLB+rohGbYEfj7sR7YHe/Zf7iRwG
	 uMvzYt96xNeRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 6.12.y 4/7] arm64/sysreg: Add register fields for HFGITR2_EL2
Date: Tue, 15 Apr 2025 17:43:15 -0400
Message-Id: <20250415120117-478c6b247a2ec7eb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415045728.2248935-5-anshuman.khandual@arm.com>
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

Summary of potential issues:
ℹ️ This is part 4/7 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 9401476f17747586a8bfb29abfdf5ade7a8bceef

Status in newer kernel trees:
6.14.y | Not found
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  9401476f17747 ! 1:  176fc303083b4 arm64/sysreg: Add register fields for HFGITR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-5-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    (cherry picked from commit 9401476f17747586a8bfb29abfdf5ade7a8bceef)
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
     @@ arch/arm64/tools/sysreg: Field	1	AMEVCNTR00_EL0
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

