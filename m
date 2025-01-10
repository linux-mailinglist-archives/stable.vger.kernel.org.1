Return-Path: <stable+bounces-108214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021F0A098B7
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 18:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139803A07E8
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 17:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6386214210;
	Fri, 10 Jan 2025 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFapzpB4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858982135A4
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530752; cv=none; b=lDrFiat6aShl8MIFs5uHeD/0ue1gezsS8Jd4yxAwYI6prA5zjPru5V31Gq6VE6CyfW/hYCTrMVcfWqgktnWLnAoQqwXfx2sq8vf0d+61otIPARo0Z3QXZkrsIowrqtVse3Quq+6XfTqwf4dtkKcFw3ssqV/K9/WazSPTLhCFnzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530752; c=relaxed/simple;
	bh=4twXhwYEp2lKRMV2INPe/C5AkEx5Yo8bVaajlRJ2zb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mj9WZwlRRDSTOxQwpAzRBTJO7zPHg7EvySS+qeND/1CLsZ4M0eT+iueYokG7ZapOdtcGFNeOt2490+zXsYmJ2mXKc1wrpuPSPJ4k/MMo8tK/BSaeCiqRPf46YA7zEgkx7lGLDcX/eRWLa0iHCs3hZ+pyGbW5O1hpE9MxeodKGaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFapzpB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FF0C4CED6;
	Fri, 10 Jan 2025 17:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736530752;
	bh=4twXhwYEp2lKRMV2INPe/C5AkEx5Yo8bVaajlRJ2zb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RFapzpB4VxL2awG5/KTqgXL0Zzs+S++/QVSledX9GteRdyEaORBYu04x9L3BUoM4L
	 QqGk0uSfKTgKin72fXVLx1QlZBIUzoIfl4f099oriekInypukiz9YX/shzzvi95iHq
	 lQ/wFYgJAT0Dha47z04mMIhLpUX3UU28Wa4Pw3Ar2NfdL8wN5eOmbWylbDWp7CcfRS
	 YEgwV/rO+D3NeRgafHKSbQU0hViL7RcgDywvRrF6cFJl985BQGD/0TjxwCMb/JbSED
	 RvcyzWnf1OWp0UrPsY/p59xjvj1PPGiIfcaOjSOCIju+8xiolirBHqiWj2hMsxXsK7
	 3MWc98E9Vyd2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.4] arm64: mm: account for hotplug memory when randomizing the linear region
Date: Fri, 10 Jan 2025 12:39:10 -0500
Message-Id: <20250110105005-e6db7a1600415f93@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250109165419.1623683-1-florian.fainelli@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 97d6786e0669daa5c2f2d07a057f574e849dfd3e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Florian Fainelli<florian.fainelli@broadcom.com>
Commit author: Ard Biesheuvel<ardb@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  97d6786e0669 ! 1:  fa6d576248a0 arm64: mm: account for hotplug memory when randomizing the linear region
    @@ Metadata
      ## Commit message ##
         arm64: mm: account for hotplug memory when randomizing the linear region
     
    +    commit 97d6786e0669daa5c2f2d07a057f574e849dfd3e upstream
    +
         As a hardening measure, we currently randomize the placement of
         physical memory inside the linear region when KASLR is in effect.
         Since the random offset at which to place the available physical
    @@ Commit message
         Cc: Robin Murphy <robin.murphy@arm.com>
         Link: https://lore.kernel.org/r/20201014081857.3288-1-ardb@kernel.org
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
     
      ## arch/arm64/mm/init.c ##
     @@ arch/arm64/mm/init.c: void __init arm64_memblock_init(void)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

