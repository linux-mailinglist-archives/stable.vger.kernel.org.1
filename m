Return-Path: <stable+bounces-121655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E202A58A51
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DF13A8C50
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA2B18E764;
	Mon, 10 Mar 2025 02:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUefjFSr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C79E17A2E8
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572889; cv=none; b=gJ4+Opd05uclMUn4AWNq65RKVJZgDRVeVWTirxSILLsDwa4sJ/HiZqW4amOMH3RMSbyfviPTbSHRHnzF6b3bQhbjGsMN41lkLTVCvCMniySVf0ofqINbAiSVD6134ypSrXnR9vxuuO2z6VKT5GcMo7CzQDF2MJRXNWkpc9W+Nsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572889; c=relaxed/simple;
	bh=JgRTF2rQgELsgndw4U/OuFwBkx59ppjaWaXyKtqZviw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gujH4pjY04Ht79/D6+LOO+HwAH9jRjMFryrSqmsqVWDAdNQiq3YGo2gz5E2lU4N5KUWnqk/DfQL2v7QnrKH5ncZc9ZlP6LtwbaH+diFhkDh/74y7yvu9PgcIdTaJKjk4xG97iXZIj1wuatiRbt0wR074sTT/2fxv8N8nb3oGP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUefjFSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E07C4CEE3;
	Mon, 10 Mar 2025 02:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572889;
	bh=JgRTF2rQgELsgndw4U/OuFwBkx59ppjaWaXyKtqZviw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WUefjFSrdDvMVT/p5ohFdaczgzrVQMXRhuxFF/cwSeW2NuduyTcGl+yKX6bxeAUNc
	 zVwMx9iSf48kZNJ06qM6a/j2T31i3JJcQOHsVF8xemhrgwnE/UP9IapI2MjGDO7reh
	 WnQA/IorPtPXN/PVyXc0mMpe522LDdfRkdouXtgtr5RX1ACrjKbbghGeH1qFxFJGFx
	 9VS8WyW6vMHnz6O1DKV4mm4cx2AG3TMwgzUfrc4Ox7g2Ig+N75Me2wGuddkli8A4UI
	 WtcDk7teDADHObZeNEwf3JOfKq08UBajZ/yJlSoJIVWMTswK+mhQkSLOPLtd6fusCR
	 WLcl/s5LvrTgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12/6.13] loongarch: Use ASM_REACHABLE
Date: Sun,  9 Mar 2025 22:14:47 -0400
Message-Id: <20250309201124-5cd113a6830431fa@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250308053753.3632741-1-chenhuacai@loongson.cn>
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

The upstream commit SHA1 provided is correct: 624bde3465f660e54a7cd4c1efc3e536349fead5

WARNING: Author mismatch between patch and upstream commit:
Backport author: Huacai Chen<chenhuacai@loongson.cn>
Commit author: Peter Zijlstra<peterz@infradead.org>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 92a3a4ad5be7)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  624bde3465f66 ! 1:  0911995aac2a8 loongarch: Use ASM_REACHABLE
    @@ Metadata
      ## Commit message ##
         loongarch: Use ASM_REACHABLE
     
    +    commit 624bde3465f660e54a7cd4c1efc3e536349fead5 upstream.
    +
         annotate_reachable() is unreliable since the compiler is free to place
         random code inbetween two consecutive asm() statements.
     
         This removes the last and only annotate_reachable() user.
     
    +    Backport to solve a build error since relevant commits have already been
    +    backported.
    +
         Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
         Link: https://lore.kernel.org/r/20241128094312.133437051@infradead.org
    +    Closes: https://lore.kernel.org/loongarch/20250307214943.372210-1-ojeda@kernel.org/
    +    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
     
      ## arch/loongarch/include/asm/bug.h ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.13.y       |  Success    |  Success   |

