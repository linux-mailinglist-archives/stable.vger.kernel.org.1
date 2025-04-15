Return-Path: <stable+bounces-132798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ED9A8AA4B
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A7117C53B
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABD025744B;
	Tue, 15 Apr 2025 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyQt+s6p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE4253357
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753438; cv=none; b=KckKXUGg+8cTrEYA/BK+Zyzr1kj/1MWjTVAq7Ug1yposLDn6/mlmcky4TxLa9Ni2EsNckBAdJRPvAOE5NgyvyxX1gkUp+rOU0TM8ynzGWGCxKR0wJ0zG//1ySY4dinf5uG2bLSi4Uc1hnLUzlgdaB2islbjWY+P4ZJaHCC4J+MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753438; c=relaxed/simple;
	bh=otHeMbwBsCNLPld6vbnYH4NDHyO4h9R8r/nNCs6zmZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBnO/teD+CdAu45bI0hIQLPHSj+RXmikidCUVJWK8ydkRYMeoa5uCkfaF1drQCS/566wwMulNE22OXAFHN3grJArfwkio79t2ePwddhYr1MUTcj4DfakRSi8HfO+3Z4sa7gxCd4/2DUsGbqbSrHFZKiCuLBS3UX+l5QpmP8/yMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyQt+s6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A4FC4CEE7;
	Tue, 15 Apr 2025 21:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753437;
	bh=otHeMbwBsCNLPld6vbnYH4NDHyO4h9R8r/nNCs6zmZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dyQt+s6p8KDhwodrDlKS59MBhNP7WxTSl4+9ZN66ZXFFhOzAJMNLp35aWcwzngBZG
	 s6FcPloIpf70sO0ieavHEWBI8fMcMrLrBPunowYYaRuOKBlBoo5POVha1Chc5ZgAQM
	 oyCWNw/NtjjTTOlbTVmx5apEdnAxwbQT1XSQNYExNQssEQtSAqZKlmJJ2gElkHI3NH
	 v6Vof1tXARVUJV1Q98PN9MsayNW2uP8SJ65odIc9iC+nur/0sUCmyN9i0E+cOoCBWT
	 SKG2AF0iCRM3bqDWsB9AYuo4fDhUCRkHFNl+OAwwk6RSnaEyjdACN47pImTo412RVr
	 e2Q1PikbjrSXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 6.12.y 1/7] arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
Date: Tue, 15 Apr 2025 17:43:55 -0400
Message-Id: <20250415113643-c60685948e4b9ba8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415045728.2248935-2-anshuman.khandual@arm.com>
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

Status in newer kernel trees:
6.14.y | Not found
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  cc15f548cc775 ! 1:  25eca6f65b94d arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-2-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    (cherry picked from commit cc15f548cc77574bcd68425ae01a796659bd3705)
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
     @@ arch/arm64/tools/sysreg: EndEnum
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

