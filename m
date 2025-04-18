Return-Path: <stable+bounces-134602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E65EA93A0D
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7C93B0B37
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83060214A9B;
	Fri, 18 Apr 2025 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yiw9785Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DBA214212
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990959; cv=none; b=L9n5gY0cI7i0/+ciAaD+14kLgn5dRk9wkZLZLBfUjNm1xkfihxl4WxyYg0TFbxkMhTTlnv2H/HIaJbJApu27P9cRj1t9vUhDoGK0gYxsjH00SMVeqvQHz/YkPoXs6st54iDibWIWOviUWzYTAzWdrBYbfZyIKaEgJARwiVkjXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990959; c=relaxed/simple;
	bh=yqD+D9y52mDr4osynRrMK+WqL60FV04d8Jvrn0o27F0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjvvhXVzre19g7SJ39t5838XmHN4q+erCatlIFRMxqbuKG2X74xQ0bJyq1aEk/KnV5g/DpKr2P57xgnvkPwuSo5SgTm8z4RWG/OVPm4gHQLyNCgtoPaTEb635hfgej8a2dk3xIBaUo26ZR++T+5a4eEY3NGhyuv/7R7XtSGIBGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yiw9785Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D919C4CEEB;
	Fri, 18 Apr 2025 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744990958;
	bh=yqD+D9y52mDr4osynRrMK+WqL60FV04d8Jvrn0o27F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yiw9785QtpcdNaiIsqHnGDINvMEUbIKLrLNZ9SFYhsQzBMgyZJuDd0BzV/jqAPbIq
	 0w0454QdZH9anMTQ7V2IdghjVzQ2crq8AJ2l48BvgeOlTnqsx9oznC6ecXmr8ynzcZ
	 fXs8QeqQYBDjxM/6o+Sj8iimmX8sgGpVfC5dHWJeKYslqofkX3Kjs31fl4JnoPy5wo
	 zP8Ubn3Na5ooo2zs2SU1TEOHMLWKu7FbTnIiH5I50m5myXeBOpe7/RE19lH3jJgX1A
	 x7T3zwbur2ej/kiDu4B0EuJpm47CdkD5uQOwAcH6/gd2nf938JHbcodp/2XzjCnZRn
	 fPnxD7tOwMH5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	myrrhperiwinkle@qtmlabs.xyz
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 5.10.y 5.15.y 6.1.y 6.6.y 6.12.y 6.13.y 6.14.y] x86/e820: Fix handling of subpage regions when calculating nosave ranges in e820__register_nosave_regions()
Date: Fri, 18 Apr 2025 11:42:36 -0400
Message-Id: <20250418093106-0299edfc32afe6d7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250417123848.81215-2-myrrhperiwinkle@qtmlabs.xyz>
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

Found matching upstream commit: f2f29da9f0d4367f6ff35e0d9d021257bb53e273

Status in newer kernel trees:
6.14.y | Not found
6.13.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f2f29da9f0d43 ! 1:  f3ea523486c43 x86/e820: Fix handling of subpage regions when calculating nosave ranges in e820__register_nosave_regions()
    @@ Commit message
         Cc: stable@vger.kernel.org
         Link: https://lore.kernel.org/r/20250406-fix-e820-nosave-v3-1-f3787bc1ee1d@qtmlabs.xyz
         Closes: https://lore.kernel.org/all/Z4WFjBVHpndct7br@desktop0a/
    +    (cherry picked from commit f2f29da9f0d4367f6ff35e0d9d021257bb53e273)
    +    Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
     
      ## arch/x86/kernel/e820.c ##
     @@ arch/x86/kernel/e820.c: void __init e820__memory_setup_extended(u64 phys_addr, u32 data_len)
    @@ arch/x86/kernel/e820.c: void __init e820__memory_setup_extended(u64 phys_addr, u
     -
     -		pfn = PFN_DOWN(entry->addr + entry->size);
     -
    - 		if (entry->type != E820_TYPE_RAM)
    + 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
     -			register_nosave_region(PFN_UP(entry->addr), pfn);
     +			continue;
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.13.y       |  Success    |  Success   |
| stable/linux-6.14.y       |  Success    |  Success   |

