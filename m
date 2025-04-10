Return-Path: <stable+bounces-132151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09665A848F0
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645AF18958F8
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4079F1EE014;
	Thu, 10 Apr 2025 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGlsZ0oF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9B1EDA2B
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300437; cv=none; b=D4lbX94Pl0ai8DKl/+DrcLASiy/v0heIbk74sw/2CPKczMao2mKUXfzIbgojytw1TelAhdiRnNq5M79zh+1TxL7aO45rBdi2V1ZZSmRfNr7zubY4qVi2EGkS5C88h+utsGCWno+/KAHrxj5pqUgyDFKudiPxLuJwC1FiWHYwq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300437; c=relaxed/simple;
	bh=TEnImJCVb5V5j157PTe24nqEjVzQ6KFJ/plApe72bO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIpkKyAR3ija0IyjRW95r4lhVeg+5qDc4GLNO0Ivst5Sn+iaH7vUDUOzDmuWgRuAypVru1PIvIiz7hzKfCsG9Y9FIvQhHLrN135p5UDZ7r2HuuChnbyqLWfkwoQ4y9gtnXL55Awp/+Dn5ZVsEJqLt0NvvwLPqp61l8jCYab4h28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGlsZ0oF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B803C4CEDD;
	Thu, 10 Apr 2025 15:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300436;
	bh=TEnImJCVb5V5j157PTe24nqEjVzQ6KFJ/plApe72bO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGlsZ0oFAVZ1yQ+DccpraTOROV7VD14crJPLctGH4QuSfyc2SINaSRyNmUSW1JVtY
	 TzwT/8e95IZwnCoj3SgtrOrOnb+YNP3PsG2sY7c2vQIVu2ZP2HFBSqwzM3Rcpb2GR9
	 aC5At0fDd1VJFQwlLzz4sQTrNJRN2NLcjieBt400bycb4FIvWVHijiWrfyN65z1Y6i
	 nwqCmSed72YH9Opwq59RaTqPaEoF5dLIW68otwPGMWnHFamqT0ey+P9ERoPMh6uFdT
	 mvv/auJKoWYKqJWPMoTorfbIek+UwVDRAtT4tWIgky/f51FUTcVmEAs8tPfwmxOVd6
	 Dz5TGjjtn+lbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y 6/7] arm64/sysreg: Add register fields for HFGWTR2_EL2
Date: Thu, 10 Apr 2025 11:53:54 -0400
Message-Id: <20250410103149-22d7895c37ed2075@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408095606.1219230-7-anshuman.khandual@arm.com>
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

Note: The patch differs from the upstream commit:
---
1:  ea37be0773f04 ! 1:  05e641890fd7f arm64/sysreg: Add register fields for HFGWTR2_EL2
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
| stable/linux-5.4.y        |  Success    |  Success   |

