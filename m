Return-Path: <stable+bounces-132163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9943A84905
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4F81882095
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF291EB19D;
	Thu, 10 Apr 2025 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcPNpOcA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E661E9B2F
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300501; cv=none; b=kJ5Lmu0aZZy/rm2Xw5KtwjENqMB25kg1K9Vz7M1KnbQWqr6Ge21czEg/zCG/XgvDTO+A0Crid+EkNuUgtJpdlUMaPIAeskxF36HsiGziEsaqb1SyKZnTvoOmxDZzAl2jxFt8FTC9b/Rs+8EYqI6oEGmltFdU+KQW3e5xI4ANhlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300501; c=relaxed/simple;
	bh=ZGGDt1XQIilY6UHjJ14tK3fl9IqtzOetmIMD8OylJws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fARD+usoK2gnERI0UTV/wnMJC3AHinDmRy5a4LsKHYuI2y2CA9XgPVTum9w/Ku64BBCJ0cuVrdOl9r79GlyEIdapx/jw2liXAGfPftQIKENJ3ehy4g6cyxRBsTTwYetmm0mcbI7hPfJu39Ug6jORgxH3jBb6H/mjrLHGkwRbvjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcPNpOcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B194C4CEDD;
	Thu, 10 Apr 2025 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300501;
	bh=ZGGDt1XQIilY6UHjJ14tK3fl9IqtzOetmIMD8OylJws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcPNpOcA5PiH7vsOWB+KGoBmGNbEzd3bfNZpXu8DvZRWFhOpd+rk2NjPkO6fAuxcR
	 lZk1XN+UmgPa73Udl6ooVRw6diV87MLOfesT8ymqxmfEJMixMnZtfPh0xtIUwI/2FH
	 1nDAruTcUjf83s+XNnLvTNV/pf1P825zPWAnBAPzYo45kc8Zo309ffnkt3jJ0WTz+Z
	 a8RZtDSnjJXMfgBRGR59TTPPvBJI7+Ht98AGsrTTU3EmsLy2LQU2X9ztbm38SfKOoV
	 P92+kzh+RjLSiocWbTURDkzA1v/O/3Nslh2XXNXEw1j4itwiVZUW5a4NyqUDUvDqvn
	 YS8Izcmby6lYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y 4/7] arm64/sysreg: Add register fields for HFGITR2_EL2
Date: Thu, 10 Apr 2025 11:54:59 -0400
Message-Id: <20250410101605-070c98efe8c86394@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408095606.1219230-5-anshuman.khandual@arm.com>
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

Note: The patch differs from the upstream commit:
---
1:  9401476f17747 ! 1:  bdea87153697e arm64/sysreg: Add register fields for HFGITR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-5-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    [cherry picked from commit 9401476f17747586a8bfb29abfdf5ade7a8bceef]
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
     @@ arch/arm64/tools/sysreg: Field	1	AMEVCNTR00_EL0
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

