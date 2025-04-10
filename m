Return-Path: <stable+bounces-132164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0200A84904
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA2C1895D68
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD891EB1BD;
	Thu, 10 Apr 2025 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOh8IG9l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD1A1E9B1C
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300504; cv=none; b=bH0borNtztdegTXs6J+LM5xKPa0QntgF3xHtzXN6M7sODICSeR3Cqw1IHaNrlvMO+4evnhKdiH5w4cl2tYcvwdlJs7c2XAqmjnuf3yV7JQhI/KO28XhbT9dCWMWJ4loKKB6TeVf+JOlQfTXfkUgoMpjiVzpuFJA2vDYHrTs2Cxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300504; c=relaxed/simple;
	bh=GxkYO68EbMIrEmHkOUWfakEmF+PjDDYx1pP+8zXZLiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbDWOyFWprecjQ2wfbSOhJz1hr6I5fKT7LRtiiX5hIvW/AeiCXvZiTPT6Z0ePXswfWY3PU6K1R6zC0KbShtgbABh/ifb2Lle6kMw6MnOtrgQb/TpMb/Gz1hn7hHUKm8HPVI925L6/Ryow3qeu0LL2a8tTHt+LHkVSQCdgt1ZDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOh8IG9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8056AC4CEDD;
	Thu, 10 Apr 2025 15:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300504;
	bh=GxkYO68EbMIrEmHkOUWfakEmF+PjDDYx1pP+8zXZLiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOh8IG9ll1xMjK5I/H+v1Z88ierlxELtu0dORJeGvqcHdmEo6teU7CykQJlNjQFzr
	 /g/2j/aA+z+dLYlPNYwrhE2fTYNjWB0N0FUmSnaFJ0MqHlz3HRObJwaegtML4CbAt6
	 HdUAGDCIyEhmDYL+RBEOJypF7wKkVLRhATCdAqPdJjgXncidil2TnSGAjkWA4SjFoi
	 NgvDf3UTl+swTxqePtBQmJOkpE/ubRSS/SIFNjubK/jpAvq0EMMUspviVYyzXkHRRU
	 DiNT5kDbQUE46gS+wLlH0cW7msr8sbGkdJO0vs7tBy8yN5gne5W9OYjbcgRM+zPTvZ
	 Zj7iyZYqs2DAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y 2/7] arm64/sysreg: Add register fields for HDFGRTR2_EL2
Date: Thu, 10 Apr 2025 11:55:02 -0400
Message-Id: <20250410100015-b404f9b2f1e2de30@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408095606.1219230-3-anshuman.khandual@arm.com>
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

Note: The patch differs from the upstream commit:
---
1:  44844551670cf ! 1:  3f5dfa41354cb arm64/sysreg: Add register fields for HDFGRTR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-3-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    [cherry picked from commit 44844551670cff70a8aa5c1cde27ad1e0367e009]
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
     @@ arch/arm64/tools/sysreg: Field	0	E0HTRE
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

