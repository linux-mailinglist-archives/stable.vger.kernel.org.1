Return-Path: <stable+bounces-132429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E45A87E73
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BA617182A
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABE328EA6C;
	Mon, 14 Apr 2025 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIFaY39N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030628CF6D
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628945; cv=none; b=p858KTKTCnBJgGaKHMG76cF1JNQiJTpBlfGhW2+GJdPKRGM7DAQ7up0mzIyi6jMcLbGyBxYEogrixBHI+i5yEkED2RmenJQyp8Mvoy8ZghHRIOXtWnFW3YQVWRG5/Rfn/OXMuo89ZNQjHWFQ+MFpJuaeFC1u7N//yilvjmGEzWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628945; c=relaxed/simple;
	bh=QJq77agRiRDD+1o36rSOP7/vxHX4b8wdf0l4hYob4Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rROb82C1xiu5EjnQVWcINOidXHOuGgbSAzupCdtW55eedIH1LNoFApyjuMbfEIcnwgWnR27MNbcaVfsDS3/qT5O0R6d6naZjhd6itpeaP7/56kxQ1pAcE0AM8Z8x5u7IwD5CFvoPVAk2VKy2qlG0CN3a7ca4O07M5Q0cxeuaOGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIFaY39N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFB7C4CEEB;
	Mon, 14 Apr 2025 11:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744628944;
	bh=QJq77agRiRDD+1o36rSOP7/vxHX4b8wdf0l4hYob4Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RIFaY39Ni4pE0vMJNXMimVo4f7qGs9grVdjmYTWnYhZmUARvKNuAnJv1xvNjJldHj
	 IfqRpEzVfs0sylath2Tl7CS59kJuv34GnAP7tSLMqvWvqsgpK+F4UvY2/CVN3L53tE
	 yWnvJycTinZQuVr324le1apodBLfFWIMkQJdIhtqRx8Ag0u9coZf4yqjP9oUL5bEVU
	 bnBHoKsojDWIbThB8GN4eUb9KNHIDGJn2kCiuq/1ZQhKGKFLVk7CCd3uIZn8CAFmoz
	 ySHIuaNHzbLqT2vXk3bg5VuRxmqI0qlGYmo9s73iGR1m6UCpn69bqeKkaCj/Dvwaew
	 VJE3KaWvDocag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 6.14.y 3/7] arm64/sysreg: Add register fields for HDFGWTR2_EL2
Date: Mon, 14 Apr 2025 07:09:02 -0400
Message-Id: <20250414065255-d2686d8a75cb64dd@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250414045848.2112779-4-anshuman.khandual@arm.com>
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
ℹ️ This is part 3/7 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 2f1f62a1257b9d5eb98a8e161ea7d11f1678f7ad

Note: The patch differs from the upstream commit:
---
1:  2f1f62a1257b9 ! 1:  3fadc0fbf42ee arm64/sysreg: Add register fields for HDFGWTR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-4-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    (cherry picked from commit 2f1f62a1257b9d5eb98a8e161ea7d11f1678f7ad)
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
     @@ arch/arm64/tools/sysreg: Field	1	nPMIAR_EL1
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

