Return-Path: <stable+bounces-154773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D57FCAE016E
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3B21BC0236
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4AB27A904;
	Thu, 19 Jun 2025 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OG1dQ5m2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD14E26E705
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323858; cv=none; b=fILxDVSD/8qhjaVXy7z7xkRmVrIDeCe8SOVvT0jKdffu0o9qPbpuxZ1BzxJlaA5CqhcQT8UMdnZEhg1GogEona7UiIlKqGVeUv5KMOlmUGVcAqWJqu4wssJoEBMJi7DEwcy8k+5GMltfEiHBX4n/aP/HXzZ3CoP1faO7QA+Xx/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323858; c=relaxed/simple;
	bh=5Tp7Gyrj5aazm2ZTQ/q9jKLpJLRUJr5PWU2Qb8WnqFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajonknDAdxNtQOxk4wJVDIxqyrzUE+XuePAxwLWc29GJ4b2uBdo0yTmRRlLh893K94qm3tTWOT+FjAZff8l/SC+I9ZR7spj6OWIwkB/MP89z9ILWdeCXNVlFuiSeDxpqAL3h3xtlljKNDkB/xrGyoV9O52TgsChy3UovYQtZqgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OG1dQ5m2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239AEC4CEED;
	Thu, 19 Jun 2025 09:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323858;
	bh=5Tp7Gyrj5aazm2ZTQ/q9jKLpJLRUJr5PWU2Qb8WnqFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OG1dQ5m2vjqbFDtwreogSZBPAaRQgzIoPN1WHSNKh7he+uxPL/en/E14lYk+un5KQ
	 LyI9cL0QZt1U0Cxn4K55K7Hk6h3eAKPit7Erv0n5fDMrIYEG7FBGma//inLMHSDcOU
	 ffc3mZVLlOc2+CocCW1A28ypbmmDJ1JF1RJ547HMN/uS2ykhxM9nv4LIhrryX7QvAo
	 7l1DbNBuDuhGPlUSECFSKZyL3mP48YYYZOQIaS97Hiu37nG6zGnHJZO0Hk4czDmqvV
	 aveuXCOwAB/N8wa7X8rO6belw42kgyIx9w+2ipebRCUsBSrOUcoW8MBAi2oO/Bn9UV
	 w+5Loo59ADtPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aditya Garg <gargaditya08@live.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] drm/appletbdrm: Make appletbdrm depend on X86
Date: Thu, 19 Jun 2025 05:04:16 -0400
Message-Id: <20250618150919-fc084cbd8b1436f8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <PN3PR01MB95974E38ACEDEB167BAA2BFBB872A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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

The upstream commit SHA1 provided is correct: de5fbbe1531f645c8b56098be8d1faf31e46f7f0

Note: The patch differs from the upstream commit:
---
1:  de5fbbe1531f6 ! 1:  4d7bd53570467 drm/appletbdrm: Make appletbdrm depend on X86
    @@ Metadata
      ## Commit message ##
         drm/appletbdrm: Make appletbdrm depend on X86
     
    +    commit de5fbbe1531f645c8b56098be8d1faf31e46f7f0 upstream
    +
         The appletbdrm driver is exclusively for Touch Bars on x86 Intel Macs.
         The M1 Macs have a separate driver. So, lets avoid compiling it for
         other architectures.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

