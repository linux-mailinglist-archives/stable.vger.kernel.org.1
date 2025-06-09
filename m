Return-Path: <stable+bounces-151975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7964AAD16E0
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44509168FD8
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8335F2459FD;
	Mon,  9 Jun 2025 02:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8iwAiHi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419952459FA
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436481; cv=none; b=AR2Q5ooEwePLRaFMTgmj5+L3lrdR3RmCH7WTaOimFTBrmc0hIORjjV22cihkD/+JIPImWwUc8f4YU8va58x538Buk0x4ICaEnxvPSe0ArlHdw9D5jNxUx+OZMvCZjFi+o7Ulf7TPIT/hSHKx8LKrEDdCYwDahabRl+o6eYLR7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436481; c=relaxed/simple;
	bh=09jCDj/KptvDE59CzKef0jEuHaiLXnFbEi5d6YmlJ4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxRnadXEOzJGlXMtDMclEpPyh9lfWrcpouq3ehUSibNdAQeSSczIu6Ph9eiEgXdhpZB6lkukv5N67+fCDBju2t+ao0muGaVAxdVKrWWTWZJOHvS7RxpAhukC1SIb9oWQKZVhGikldbac3PKs3rMgNaEKh1onFO8hZ4+to0Xyf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8iwAiHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51331C4CEEE;
	Mon,  9 Jun 2025 02:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436480;
	bh=09jCDj/KptvDE59CzKef0jEuHaiLXnFbEi5d6YmlJ4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u8iwAiHiyNWQZVCBorgiGIdCjRK6bLoojzHItVZqjuX/uMMVfyH044DbAisSrKGVx
	 rf7Whk1I64ba2+8BMMnZGkcXAjh2SOJpp2netsETXfQGk3lq9GXQuPxlg2APVFUPBH
	 baMXd8cPw8AoQvm9Z1AL00iHLfROGoJjPyQQpE0B9dj5DfrxiR9A54Mw7tRZZOKN6h
	 4WL8lICJMH5xvTDswRBHx4K1dESujc4pHxrKIKorSrI0Ck63WDpGx/9kLlvENvkxx8
	 oOKhgO6RFBy+Al6a/cDT8FeAnOZLntUGKQATp4QHYQG4WwQDeDC64NXhaX5Jn+pSkh
	 WIZMrayRFh+tA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 07/14] arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre BHB safe list
Date: Sun,  8 Jun 2025 22:34:39 -0400
Message-Id: <20250608192233-49604c09cd391426@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607152521.2828291-8-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 0c9fc6e652cd5aed48c5f700c32b7642bea7f453

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: Douglas Anderson<dianders@chromium.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (different SHA1: 8b5a68a204a7)
6.12.y | Present (different SHA1: 20c105f58769)
6.6.y | Present (different SHA1: db8a657980e7)
6.1.y | Present (different SHA1: 75791c0441bd)
5.15.y | Present (different SHA1: 0b08172a635d)

Note: The patch differs from the upstream commit:
---
1:  0c9fc6e652cd5 ! 1:  2c972033c21bc arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre BHB safe list
    @@ Metadata
      ## Commit message ##
         arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre BHB safe list
     
    +    [ Upstream commit 0c9fc6e652cd5aed48c5f700c32b7642bea7f453 ]
    +
         Qualcomm has confirmed that, much like Cortex A53 and A55, KRYO
         2XX/3XX/4XX silver cores are unaffected by Spectre BHB. Add them to
         the safe list.
    @@ Commit message
         Acked-by: Trilok Soni <quic_tsoni@quicinc.com>
         Link: https://lore.kernel.org/r/20250107120555.v4.3.Iab8dbfb5c9b1e143e7a29f410bce5f9525a0ba32@changeid
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/kernel/proton-pack.c ##
     @@ arch/arm64/kernel/proton-pack.c: static bool is_spectre_bhb_safe(int scope)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

