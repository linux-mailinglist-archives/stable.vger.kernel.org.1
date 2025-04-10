Return-Path: <stable+bounces-132169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1117A8490F
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E874A1889BF0
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FBA1EB5CB;
	Thu, 10 Apr 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCeSWgC8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759BF1E98FC
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300591; cv=none; b=Ybt8xtKQidUV38jrfe6teribbY6k3YVnvjR9D4oR0ptEX1l+zvDuEyAC/SY77U2atewBiv8Aldo+/cDaa6ymj5xr9Y52/vlIIfUXNT23QjiKmO5RiGci89ucop2vFzU9nRPqft0y1nxuqZcughZANzrJ53xaXkumPfjL83pZUzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300591; c=relaxed/simple;
	bh=eyIzV57He4Dmm6IbG+SbQDnIGfLw4locuE3GxG5Vpb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBKssYbuY/xn7dR5OZJHjh/8ytU3poGbVLYOy6BCV34ltlyqAtU1ytC5aLQxOtpjkWiW6BTLQCV/S+R33qA7LWAOkOpmcVdz4b+xmhb2o1TC3C5ELIaZKe4DQ+XCG/ySZjDCHc0F4w5Bw7cKSHUvBnpEI9ISuZGZBN5UJm7lC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCeSWgC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1057DC4CEDD;
	Thu, 10 Apr 2025 15:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300590;
	bh=eyIzV57He4Dmm6IbG+SbQDnIGfLw4locuE3GxG5Vpb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MCeSWgC8CZAz5vmqEnR68MRFwMM29y7J0UQKSlmfUs3/5EuSq4/YSqzEB0JY2gErA
	 sHZBpS2xCNMQCyFDN5prEm5cDjDG+m3RxiHwjdt2W9YZVvCAs3nGl8rRABHh3S0pLp
	 rkg7ZMNQgZ08Qx81T6RgUOjQQHCYI80y3LVnedzzoy/ZNb8VwTVrLNO/PT+8yu99TA
	 lOFmvrDiSKgvuRHAWPUczqSd9GxglUyea2v/mKQ9bPZaMYHFrSZQ9M/p9ov3zEALXn
	 rjdORIYuVZhTXSSQdGQyP7btE2bPQyenFKk5CAvlzV6Pq2CzKWp0tWwMChIhLOCzJQ
	 nGau2GblEo4Tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y 2/7] arm64/sysreg: Add register fields for HDFGRTR2_EL2
Date: Thu, 10 Apr 2025 11:56:28 -0400
Message-Id: <20250410082821-2401375c920f6c34@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408093859.1205615-3-anshuman.khandual@arm.com>
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
ℹ️ This is part 2/7 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 44844551670cff70a8aa5c1cde27ad1e0367e009

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  44844551670cf ! 1:  fdda1b4072c20 arm64/sysreg: Add register fields for HDFGRTR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-3-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    [cherry picked from commit 44844551670cff70a8aa5c1cde27ad1e0367e009]
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
    -@@ arch/arm64/tools/sysreg: Field	0	E0HTRE
    +@@ arch/arm64/tools/sysreg: Field	1	ICIALLU
    + Field	0	ICIALLUIS
      EndSysreg
      
    - 
     +Sysreg HDFGRTR2_EL2	3	4	3	1	0
     +Res0	63:25
     +Field	24	nPMBMAR_EL1
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

