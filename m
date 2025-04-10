Return-Path: <stable+bounces-132144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FF1A848F7
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1629C066C
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146FE1EB5CF;
	Thu, 10 Apr 2025 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuhktUTR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91CC1EB1BD
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300419; cv=none; b=F1W3IP2AtO679COgGSmrZfurYz41cnS+7hf9ljeV9gHrGy7E7/AcKJYTwuaH0c1ciwe9QD4hgZlyTpzXaT9L97niNrYVatKXDREYIztTsq//GikKDVt/sz0ar5M+DXiiuu9eheLHsK8vsu854qMHziPQ/b/e6z8CRJ+3EB3vMNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300419; c=relaxed/simple;
	bh=Q/1qgpsWTis783Pr4Uyfy6ZXASyzK0/qpx33YW6PmJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwZatN/S+rG6b6ErepjWOItvY7feASV2cIJpgAKqv0rXyh0qdedDGmJjhJYmSvhVxYxcNxghRsmJ9diW4UW1dNrVUzxCOTFK1CvQro4aX5rbkxyTzMM9OIAtQnQyZ01gbp34hlkKSKTfQ7mDL/fiLdwP0mQ2yh/YT9h7RFZojyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuhktUTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C38C4CEDD;
	Thu, 10 Apr 2025 15:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300419;
	bh=Q/1qgpsWTis783Pr4Uyfy6ZXASyzK0/qpx33YW6PmJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AuhktUTRiBvqIwQ7492KxofMkjbGBIFf9rn/93cM938OpsjnZqWiqSCDDtSRS6D63
	 papZr/ZwJrB94FQWjUhFFOclqk91Vu325dqdf7jpVxVtOtUyWyrVxH1+rYD5PBqH7T
	 TaDuxzczN/Zp5iquJ0hOQYYaTitmLS9AGXcGPk1KU6OPn9DyytTHssT6bQi/t+/BKh
	 d0Uflx9FGtBoIuqlfoC0OJjffClIqGG4Yx+oaUdYwSWMgqREbfH1WNu7YYUT6tBz69
	 jtCCTc5+/UQW+R++jxIPXagK4B5mHV4lz5zrdYGBXS+zcwRTvYpMp+IhnXZad8sITt
	 lgpL34WnsXtNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y 5/7] arm64/sysreg: Add register fields for HFGRTR2_EL2
Date: Thu, 10 Apr 2025 11:53:37 -0400
Message-Id: <20250410085411-2115f7758ac3f686@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408093859.1205615-6-anshuman.khandual@arm.com>
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
ℹ️ This is part 5/7 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 59236089ad5243377b6905d78e39ba4183dc35f5

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  59236089ad524 ! 1:  84378bfa5e060 arm64/sysreg: Add register fields for HFGRTR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-6-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    [cherry picked from commit 59236089ad5243377b6905d78e39ba4183dc35f5]
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
     @@ arch/arm64/tools/sysreg: Field	1	nPMIAR_EL1
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

