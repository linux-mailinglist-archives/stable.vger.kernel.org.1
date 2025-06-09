Return-Path: <stable+bounces-151974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C723BAD16EA
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F97E188AA9C
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7C72459F7;
	Mon,  9 Jun 2025 02:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3vS0KEp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECEB2459C9
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436479; cv=none; b=FAkB7Ed9Jf7eEJb1BRe3tX3jTKeKUBHJ4gQC0k5inNX1TnPTvd0s2e6j4rbrFtgm8cwuOs9sa8uGb0J7efNXuXd8W8u5lBduDGyF8+dc97l2XyvO1kVacD/eqFFOuh0K+Cnf6eBPvaKSdqZa1uRjD7hHpPrZ0aTSG5yQoCJewNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436479; c=relaxed/simple;
	bh=VAVGUQttyKg6sjBV462gPmLKKjQTaU8KvdBIIcfpSTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6LAS3LBcyER0SJNw13tM0I6NSSOMbC4KPAuXXNgG0DDUqgXrFtlLv3SYYMrjC93RnqPbZ+3sBe9Snd0J4tunPKwEqUrUIqptiRKyA4/TVuXYtw0tmyv5SOSe4ZaUWmD76rJTV6yhnvSUU5sDK0wxQmuiocfB21nCGxzgUMLK18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3vS0KEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40658C4CEEE;
	Mon,  9 Jun 2025 02:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436478;
	bh=VAVGUQttyKg6sjBV462gPmLKKjQTaU8KvdBIIcfpSTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b3vS0KEpJ3UASSqFoUlt3Iv1y3A+SH/WMkLrX+FxncFjrmWafg4VoErRVNkmOep2i
	 8orbgjHqQ7sFqPG6T3yhAULZCkXkdNf2P4n1uzkW384awX45zAEPkk7qhCj4RcN9EA
	 1tzGHYD1715ICWV+E7mENRqApbHqour6ZX/WypUrMiGzgJ4MlRlrX7o9GMXjz69/2w
	 HALSloFcFcTwjCbSFNRVf8Cldch3oIiOUWruZLEHoBs9eh9cF1CR+gBvdzAJM89F4p
	 43H9fy7FhAC+JaJtjaHH0EGkDb6RGKtW6TockNcdLTIkjwvhNKtLmBg+x0ILjToX7Z
	 AFC62bUJHkicA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 09/14] arm64: errata: Add missing sentinels to Spectre-BHB MIDR arrays
Date: Sun,  8 Jun 2025 22:34:36 -0400
Message-Id: <20250608193228-bc80dc8cef589a9d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607152521.2828291-10-pulehui@huaweicloud.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: fee4d171451c1ad9e8aaf65fc0ab7d143a33bd72

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: Will Deacon<will@kernel.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (different SHA1: 333579202f09)
6.12.y | Present (different SHA1: 090c8714efe1)
6.6.y | Present (different SHA1: 3821cae9bd5a)
6.1.y | Present (different SHA1: 446289b8b36b)
5.15.y | Present (different SHA1: 6266b3509b2c)

Note: The patch differs from the upstream commit:
---
1:  fee4d171451c1 ! 1:  0334c29ef604d arm64: errata: Add missing sentinels to Spectre-BHB MIDR arrays
    @@ Metadata
      ## Commit message ##
         arm64: errata: Add missing sentinels to Spectre-BHB MIDR arrays
     
    +    [ Upstream commit fee4d171451c1ad9e8aaf65fc0ab7d143a33bd72 ]
    +
         Commit a5951389e58d ("arm64: errata: Add newer ARM cores to the
         spectre_bhb_loop_affected() lists") added some additional CPUs to the
         Spectre-BHB workaround, including some new arrays for designs that
    @@ Commit message
         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
         Link: https://lore.kernel.org/r/20250501104747.28431-1-will@kernel.org
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/kernel/proton-pack.c ##
     @@ arch/arm64/kernel/proton-pack.c: static u8 spectre_bhb_loop_affected(void)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

