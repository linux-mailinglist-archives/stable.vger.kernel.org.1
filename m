Return-Path: <stable+bounces-132435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D23A87E7B
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E6A175DC9
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F9628D845;
	Mon, 14 Apr 2025 11:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2wMOFzV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A186928CF6D
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 11:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628959; cv=none; b=Vu2UnB7iqmo2bWnYYShXhtixJIboEiiClO8NO3lyGDv4iAaNnp3stIFcsnjgr2islhneJTt4bjH7HhArrjayCUi2yQPh9KJ4pq4JzUDuDodzVTtEdDSr/NE537k9eGwOXMWv3//+Baq9rzjRJtB4HhgmkVqze4v0WjiRIH5nhPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628959; c=relaxed/simple;
	bh=wnwxdjU2FJ/jlIjHjLdF0vLkuvnHbrF9alhZJxlEil4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUP4Rk4qk9tocL/Uac7bTWkUljlpFpkf8Xy59bwkcI1IlGEO1V2GetsAUGQLcpcLn9ZQ7JTD3foJfsacbP7lq5IbI6aCzyrtshyLHSjtHMAJl9HN26mitewLErxI78PTBA7Zj59Gi81HxNYsYInPT7Ze0vL9JFED+Wfc4m7tTnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2wMOFzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1624C4CEE2;
	Mon, 14 Apr 2025 11:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744628959;
	bh=wnwxdjU2FJ/jlIjHjLdF0vLkuvnHbrF9alhZJxlEil4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j2wMOFzVChsJfHkMXp2Sk/ePd4MQjIlu8tpcsfEcnrqJfD2ib/+7DNbksw5BhNKBr
	 PAQMEdJP75SBX+iAytUpRiAUIK9rCtDTNdsPAbMGLNZCA/tv18JDREyyppKgykVPxs
	 p3NPavY1XUft8+3eKgu3D5k/KwK10WLwdBRsusCNCilPQxGUM7o5PHAX1NHpikXoOU
	 cUuolhU488wTA3G6OY8SNKGA21GRntofjAiMw/Q15q6i0np09VgzJjmPaEYcQ+9ptx
	 TdbZY/DErU6lG7QWl40esAxYHjvLDRMGyxE/01QNjFnMv57Qbc3+WKQD87i0+Ds3qV
	 9m/wusTeiBUWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 6.14.y 5/7] arm64/sysreg: Add register fields for HFGRTR2_EL2
Date: Mon, 14 Apr 2025 07:09:17 -0400
Message-Id: <20250414065902-23e4c477984d17f3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250414045848.2112779-6-anshuman.khandual@arm.com>
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

Note: The patch differs from the upstream commit:
---
1:  59236089ad524 ! 1:  2316dae089c5b arm64/sysreg: Add register fields for HFGRTR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-6-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    (cherry picked from commit 59236089ad5243377b6905d78e39ba4183dc35f5)
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

