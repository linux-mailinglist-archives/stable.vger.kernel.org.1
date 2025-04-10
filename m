Return-Path: <stable+bounces-132166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8823CA8490A
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DEBB1895E84
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB8D1E9B1C;
	Thu, 10 Apr 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqzfwVDv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B63F1E5201
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300509; cv=none; b=BL299l7kv+DZTNKiHz6Mk963CRg3WlVkSACPeNxHHOFsBRvSXc12MZhjBYQ2uMeIRiuVeE0ca7aN4fud2opf2MX3Cti6vlyceSXfsNrX9UUuANv5ot4Lfw98rMqlSKlcQCrFj6Zu8JRtG/6J6xTeE82ZRKlY2i32u9m2Lkc39m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300509; c=relaxed/simple;
	bh=SYCw9mwHwTvVLsi5Gjyx5STDi/K3G8olb/aGl6LzpzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ft0iAXhSQ9ITW/FmkOjhc9+8J28ynO6hZDTPzwlFBePdVkOaYfxog7Q0IUqWfEIGSl0X8g1qKizwpOHYm6/406pXytj6W6pDlnpp5tMKiBmQpz9sMxon7F2ZkoQ82Q41FK1AZBYG//wWut9+28nVuN5FP3d62ihEOFp+CSIpKXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqzfwVDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7853AC4CEDD;
	Thu, 10 Apr 2025 15:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300509;
	bh=SYCw9mwHwTvVLsi5Gjyx5STDi/K3G8olb/aGl6LzpzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqzfwVDvGxzLX0dzz4lhVTKiWOCPXGRCRQB5x+8PvbR0vJZwKqdzMmKCd4NQNqsY/
	 lDi1SBiJ3SJTt07qlXO0pcz7asUaiT9J/T4a8u59kcGPjJ3LCAG8+S5Nm7T5w2oTSk
	 aJOFtze7SGlEQZ3eYVZ7Ie6gTsCc9ovQ7kOCo6NWYo7cdjqbIlrU4pACiDeRlX3UD6
	 6UWe/gJGtmE36XmvyER718+Dro/B4TYjvQgz0Oas0ZWAej3dCBt6136E8mg6u16WCu
	 fCwi6LFzd0NcjdvIAd4TNZ1QN/kLElNJzU7T0M5Vbx7r/X7R40cPBtYq9Q59UJHBRT
	 zNBx4XgG9lF4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y 6/7] arm64/sysreg: Add register fields for HFGWTR2_EL2
Date: Thu, 10 Apr 2025 11:55:07 -0400
Message-Id: <20250410090243-eb3fded32a5fb07b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408093859.1205615-7-anshuman.khandual@arm.com>
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
ℹ️ This is part 6/7 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: ea37be0773f04420515b8db49e50abedbaa97e23

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ea37be0773f04 ! 1:  ccc9b1721d196 arm64/sysreg: Add register fields for HFGWTR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-7-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    [cherry picked from commit ea37be0773f04420515b8db49e50abedbaa97e23]
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
     @@ arch/arm64/tools/sysreg: Field	1	nERXGSR_EL1
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

