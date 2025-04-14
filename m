Return-Path: <stable+bounces-132432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A414A87E75
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1019C3B23AF
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427FF28F937;
	Mon, 14 Apr 2025 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOkc6o6I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE3DF42
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628952; cv=none; b=pEoFMsXsMPA73Tc/xsIwCIZ7NA9dfHViw0YpXrYzcYFUeJKu3HLQrRC9Vjf9CK9dMQr3QfiOjF+5TAIbfaTU2XLIr6xtOgMLxh2umOwpZ24ydTiQ9by3U/Ihy87uL24hkN5gQYNJJ/t/dkqRT1RwcGCp0NcotqSMUBZtscEp09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628952; c=relaxed/simple;
	bh=21VPnWA5yG0B2rXa6x9SIu267x8bFicVEi14klKOCbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDutJAlChXUfruQ9r7ILjldzG3gNPRWxcmC3vdIL09dFdSwFjst/rxCGWpzsMByqmc4acSGuR2m8ATewdbUV0dmDAil+Ay3xYG9dRRJcCii91GpqUZ54zybunzaaectV+vMZ3r/jfOc0Ps0UUm2AxU8ibd3SlhRNQrjSThDFLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOkc6o6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D92FC4CEE5;
	Mon, 14 Apr 2025 11:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744628951;
	bh=21VPnWA5yG0B2rXa6x9SIu267x8bFicVEi14klKOCbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOkc6o6I8T38SpE0I1Rv0g/MRLJLYQMSBDVdfdfgIWVC6K/Gy57MgPQ3LZw+jbzOK
	 kmsoAcNcxR8kllHhOg7NBbKMRH53C1y9o5t7x9hHvIIZXTXyF6dfeV54A16cR2CDWU
	 9fVHcF4o3JWbgVScubKZzbj6TmrvwDcyyuh11H8MFZE6xvIPYP5ayCOjeM6Bdml0y1
	 ZgzJnvv/W5CUZaw0VBhkjac2SCZn02wG3bS8EPhXChlGoGTl/aVF1tFHW+4Zk8K0Zq
	 cDWktQNeZ3EUhCqEK4S5LemZPCcoTuECt62/rBVp2QUQUKzGCdPWu3rkVOmASUTYY+
	 BALphq3WXghUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 6.14.y 4/7] arm64/sysreg: Add register fields for HFGITR2_EL2
Date: Mon, 14 Apr 2025 07:09:09 -0400
Message-Id: <20250414065557-a8f45ff87290d598@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250414045848.2112779-5-anshuman.khandual@arm.com>
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
1:  9401476f17747 ! 1:  c12f9691c2424 arm64/sysreg: Add register fields for HFGITR2_EL2
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
| stable/linux-5.4.y        |  Success    |  Success   |

