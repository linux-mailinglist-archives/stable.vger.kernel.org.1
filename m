Return-Path: <stable+bounces-132150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78ABA848EF
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6F81BA2DBC
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9191EE00B;
	Thu, 10 Apr 2025 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pzrxa7CL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB91EDA35
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300434; cv=none; b=B5BB4yyBF9fZq1fUHf+3FyQDSH0s46/E2LpgYaOOzuCHn2bWg9p5gSI+27yvh/3j2o/AZLdkwQL7mFediO4NmQMoGLyMFb3amqvTYJ1s7iE8LUZMCLA979X3/C2sFnE9wofuCiF5lZ+mBDXLY24ve6HwIXHyw+xTeHo34vEhGK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300434; c=relaxed/simple;
	bh=6mMbvVXfRWbNVHe4PBCchjsfhpUfHoI0T6Ld8K2gXTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QyD2uVhhxcHGHS6kYKy6eDsewEkWPOznvW2wAQhvuiRfpSobtK4yYXmqSFZGYkX8SmhHT6m2uNjceJUyf95h088w56W1QFSGhnFhWlUu8LWgQefwVV8lINF5x0i8L+V/TE79jSksUdRjBA5+8bXUkFprL87NI/of1UkAGlwZXs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pzrxa7CL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB392C4CEE9;
	Thu, 10 Apr 2025 15:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300434;
	bh=6mMbvVXfRWbNVHe4PBCchjsfhpUfHoI0T6Ld8K2gXTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pzrxa7CL3lWQMOrBwWTnd7CofIJK1MK8JqYePBWzerp3ZVGKeB2umEP9gLdEZ7A5y
	 bvRlyG4oXUrtOwj5vSJadHAL6VX4Vdfb6y0zpB/ZKYAX3EXnfX0Ju47YcItsLuisA8
	 A/786jJm8mfJ0t7hddYoNGjU06x5kVGJ6WHjUCKc/SPotlkh5KxnQ7h/5fUz4rkmgG
	 9Ayvoqili5dz9CPftDQ3rGeaUPCkLo363P7kwpmIxRsFjaDR2Du8JSi36TU5iW1jQU
	 ZPxYaW9yrQX4pvNkx0gtPp7hJ/iI5z2K0PYe8KXIMx5TiFMxzdGXX1bXdaf7d7Ii6N
	 wpSn5xoyO0nMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y 7/7] arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
Date: Thu, 10 Apr 2025 11:53:52 -0400
Message-Id: <20250410090630-e351ade4a4d5c03b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408093859.1205615-8-anshuman.khandual@arm.com>
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
ℹ️ This is part 7/7 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 858c7bfcb35e1100b58bb63c9f562d86e09418d9

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  858c7bfcb35e1 ! 1:  5a56cf2361642 arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250227035119.2025171-1-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    [cherry picked from commit 858c7bfcb35e1100b58bb63c9f562d86e09418d9]
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## Documentation/arch/arm64/booting.rst ##
     @@ Documentation/arch/arm64/booting.rst: Before jumping into the kernel, the following conditions must be met:
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

