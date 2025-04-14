Return-Path: <stable+bounces-132431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFAAA87E76
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EA387A40A5
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E134F28CF6D;
	Mon, 14 Apr 2025 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te4WhIdc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2529DF42
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628949; cv=none; b=pSmB7ocb0ainXiJpTexYKQH65mKFY33EhdqbaJzIV78x4OH8vW3Mz2xKUxOH0GE3sXDqfa+Np5qibwMmlWn1dbDDR+1TLu5HX9MsjCQ1Hgo7HU9qdaKsjwiu1Xqm5qaOKsMfpeBDGVdGH1QOmiAI5DsMZ7xY/d6Y/+pByOGv7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628949; c=relaxed/simple;
	bh=n2QxzkZ97J9ydNK6qJC0R2xqFsCz8NyKV/ZO/a44b6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mB9EOYvbTsQJSW9sjW5Dkirx4XdC035mq/DH4QLV8N73jSeneOV+zkGxoiD1oWgcT/ZyFzwwoCtKrllb7NYee3g7jP/yDXtnBh8uLgpRQj9X8DxnTlhGShsokFH3dgIJ3pSbUsI47WPuz29BUkcsM3WR9Haavh+KpKwZfPlvxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te4WhIdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E3AC4CEE5;
	Mon, 14 Apr 2025 11:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744628949;
	bh=n2QxzkZ97J9ydNK6qJC0R2xqFsCz8NyKV/ZO/a44b6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Te4WhIdcdIbbomJ3fNJBfKcfecn9g++Mz7HqUu2ckg3/EkvrByj7q/T+e7uNrjIci
	 pG/EoSrvkRVtTEkq7C6bXVtfgVDsNniMvAbqdWetN5GQoNKd/zivNXeZD60YQBA1l2
	 BUZF3ttu5rQNx/HjOJt1D2BFu3TDVCUIWq1yDMANC7biIz3kUOoA1IqJyGtWyij1mr
	 zGCAG7kH6qZ5SdUKeAVXjHahJm70DCCjq6EKZJHxlsE/2sHmqtSFtySIEIcCOBp+Hd
	 kKZWHrq2CSrAfTqE/dn0L3Njmr4ak31OcfZOouM9a8YIwDQYLzCpb6Pi5xNXzPi8Ou
	 tDWuZiW0H5sCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 6.14.y 1/7] arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
Date: Mon, 14 Apr 2025 07:09:07 -0400
Message-Id: <20250414064653-21b517a40adf5eed@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250414045848.2112779-2-anshuman.khandual@arm.com>
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
1:  cc15f548cc775 ! 1:  9582b0017ce89 arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
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
| stable/linux-6.14.y       |  Success    |  Success   |

