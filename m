Return-Path: <stable+bounces-132137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB93A848E6
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749CE1BA0E7C
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859921EB5E9;
	Thu, 10 Apr 2025 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cd3Xqi+z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC551EA7F1
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300403; cv=none; b=XN0BHlGWfAXRdNUQvVBjSxmYFami9nWCu2weWKSRU1b8x4JVJDuzipS3fQ2MoIdnsEziLO+ZtYJtfze2eulgmMkGGRnROLVMizvz/Ct6z473LmMKYKrTvRnale2Uab1/ye6SqLn7i90WQLk6BFy3TvjqkBTwc/HHL+bXMtxvNMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300403; c=relaxed/simple;
	bh=AD1owSHcoBSmAq3JG1hjesCNIlL2C6zEt9T9SZqNiyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbAUE7VsKKbMT7Op3jccrlf2mCAmd0tjSiBMmyQ0gG4qtIJJLyp08lrHODCAUK5+TxjhlU0TM5FmlAV109+kvhiZdL/ymL0XQZGB3fN2vW7+cLwAZchn+1E9HDi963syjI57mFVEco03g2w9LWV5jUg/7H5oXVKHvEDxR+m0In4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cd3Xqi+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12382C4CEDD;
	Thu, 10 Apr 2025 15:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300402;
	bh=AD1owSHcoBSmAq3JG1hjesCNIlL2C6zEt9T9SZqNiyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cd3Xqi+zQv0TI70cfg9tAFeXEU0Ga2bYGg+tK/zGT5EuadKJv1XWFNmqgxOls+j6n
	 BdfgvV2bpSTocu/cfiWOSbdel7vscOQlisE85/ewRJUN77L3F09AU1T/lcWDpV704J
	 dAnWBkWn6ePvDC9b1Aa5uuDh5aJ2+nPeW7SalMYXO9BGE3cjsbiQeBVhnSwyw2byXg
	 cj59aEPEc9DMJyxFJHMSeueNQ/ViVd4Kp5insT47j9TM+QhK0jGhgvRTNyVD8e7XlP
	 hf4Af8/ZjuVIC9WAjiqFKJO3KAlWXeqdUUiiEV8pdPkMVUI/3ynm7btefmNb7ucwnz
	 PlWvL9w8Pvsmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y 3/7] arm64/sysreg: Add register fields for HDFGWTR2_EL2
Date: Thu, 10 Apr 2025 11:53:20 -0400
Message-Id: <20250410083634-f79a3819c71b8779@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408093859.1205615-4-anshuman.khandual@arm.com>
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

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2f1f62a1257b9 ! 1:  8cf4af8e4f698 arm64/sysreg: Add register fields for HDFGWTR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-4-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    [cherry picked from commit 2f1f62a1257b9d5eb98a8e161ea7d11f1678f7ad]
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
     @@ arch/arm64/tools/sysreg: Field	1	nPMIAR_EL1
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

