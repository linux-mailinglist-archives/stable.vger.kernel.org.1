Return-Path: <stable+bounces-132155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A6AA848FD
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C479C17AC
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E381E9B38;
	Thu, 10 Apr 2025 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0BDAplB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE41E9B1C
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300479; cv=none; b=dlf2cDwC+rL8UWtuQ//HUiyw1YYUYxLnUQSi5AawxrHan909HsAe15gaGwSzBnEW4gxHIgiIBy4ExIVv74UpHdTr1ujMkEVOFDjY0v83c6o6A05S1c6xTRl4M7wovDzTjR+Xpl1iEBL00Y9LflNVpxyFDy35i4SLRszVRBApfdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300479; c=relaxed/simple;
	bh=c5+uhNMW2+Jvt8Xx4WcJN04UL5pk5Fn916uqJTx6XbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8vKjQnaZUKD5VNTlM7+mcYG4fS3LJ+GDVpaTfsAOQF/X0YnGiXfskIQDBdLYRuy3Z76T/BCO1HFUgISCp9nYROoKj2O05P2FrFQ8MLe9fqOkT0vMgLaAFe3lYs0n/LZE7CTlQL3lhX3bv9dMO8vk9/5ek4s93UznNuknSFpFuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0BDAplB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CCCC4CEE8;
	Thu, 10 Apr 2025 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300478;
	bh=c5+uhNMW2+Jvt8Xx4WcJN04UL5pk5Fn916uqJTx6XbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q0BDAplBzCMHN/nxmw9y4EadI93PaXx6DNZ7DhgN+uruTjrF5WAbcumnRUATWnn2F
	 rQsuCcqoymOevQbbak7HwH98xiXbSE8i5lc3qjMy6BwTIDKxe6X94TAQ2t4O6QDlRo
	 diMqbfd1mvDQTry/5rPCCGwgT2sTOgaFyTuT8QuhhBCGbxsWKF4YjqcgWWLPSOcJqx
	 Bcot+ma4HzGiowpAZsBvwExdpfCbcOU4MR2SKHjXaAD3K6wUJh0J9xyxHzOryJVO2z
	 /QiSQecH6wg4jP7Tr1LPbNLnhAjB5NavG8X2Gd+FC4Pxwk65qTg/gK7ZZyuYywwpg/
	 P+Idn97cSTgdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y 1/7] arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
Date: Thu, 10 Apr 2025 11:54:36 -0400
Message-Id: <20250410095210-5dc25849962b4acf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408095606.1219230-2-anshuman.khandual@arm.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: cc15f548cc77574bcd68425ae01a796659bd3705

Note: The patch differs from the upstream commit:
---
1:  cc15f548cc775 ! 1:  383b94dbb82a4 arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-2-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    [cherry picked from commit cc15f548cc77574bcd68425ae01a796659bd3705]
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
     @@ arch/arm64/tools/sysreg: EndEnum
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

