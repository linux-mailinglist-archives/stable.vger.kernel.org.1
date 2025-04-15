Return-Path: <stable+bounces-132789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34B5A8AA41
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D672517FDF3
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8C725745F;
	Tue, 15 Apr 2025 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqiijMU2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A92256C60
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753401; cv=none; b=FgcwrmZzVX2LfJrsBEp1nkvvTN/LGNRRybMqK5iw6si0ZG07rBcXlJVJ/NHO4z/vinqdKrVXjH8gcoDLuTuuKfHtJyTXiqAvBTVHLX2QvMVB1GpdX67StRVqpc/J0vItEbd090+06SfRwwarNSMSuouKNd3osMEktOGkvTrhATc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753401; c=relaxed/simple;
	bh=aTYh5nKCz6WpDqdV8eVpPWS1UKzSyr/KLg4M/MyNYGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJzTpHijSNkdVkUUnomGT8LJnk5Hqu1NOeh04HvSbi3TmOf09OMWL8Q5rNP9DntYDJRy0pAPnAN4vBucKZpwDb8eaz7y/BWtaqHOu33asrA6ObqLoNvuV2c+ifkHQ/0KCIJ35OZ7K0dRpsGly8Qydxx81ZfongWgvWX65Dh5qNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqiijMU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAC5C4CEE7;
	Tue, 15 Apr 2025 21:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753401;
	bh=aTYh5nKCz6WpDqdV8eVpPWS1UKzSyr/KLg4M/MyNYGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DqiijMU2orks2W7DTX3OUWr9n0Ua4m2+M8ZbnU/+cZYQ7Rfd/ovO8u8Uw5NFKQQei
	 9B1TRmt4g/zohBxNSO0p54t2MIf2u03hKty2S1emvg/RWu83koG/0t9rBUkwrIEDje
	 /pFGQnxZ5MHiIvdgoQn4SdrTHCprdw2rwqD+0DJvdAKYaNIbVGxUEXzYo+NKTEE8Lf
	 fEb8UnFAddZhpCGUNZUexSD0WGLehaXNKeEDRhzoWeT6odUOP8xJlleCVfi7kV4xx1
	 TiafFmder0XoX0/V2fTEJZjQkcMnCd2uDsWQg6WolGqt4mvWldyzZe3Yb5OYeDpNeE
	 9yQjM4vNs93qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 6.12.y 2/7] arm64/sysreg: Add register fields for HDFGRTR2_EL2
Date: Tue, 15 Apr 2025 17:43:19 -0400
Message-Id: <20250415114447-0f6fee68a3ca54c9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415045728.2248935-3-anshuman.khandual@arm.com>
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
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  44844551670cf ! 1:  1ebb6e8b25516 arm64/sysreg: Add register fields for HDFGRTR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-3-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    (cherry picked from commit 44844551670cff70a8aa5c1cde27ad1e0367e009)
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
| stable/linux-6.13.y       |  Success    |  Success   |

