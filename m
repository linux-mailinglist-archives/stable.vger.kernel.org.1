Return-Path: <stable+bounces-126952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F11A74ECA
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 18:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB66172FF2
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 17:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B8E1DA0E0;
	Fri, 28 Mar 2025 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqbWpdwZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0081D8A0B
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181384; cv=none; b=OsXdHycJBwOPK3oRZ8+R2Lp9UXCCqWPE3KUMgYdRcApSxWOCMG13HkcrX+pvBIQS8cjNww7ZL4cexkbcF7blWE0W+AjP6MlQ6U+/NqveYm7GLyCfcRdTSsfLDrJfT8Y0aZvTB567dcJ82+JX8xXpVaLsVziWG3wZzeitAf/j4bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181384; c=relaxed/simple;
	bh=PNTqG075RYBsaLR7l760h3y2xIPLtfpHPQQYxSyoSS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nq/Jr1kRCkievl2grCc1phfwYr3p6F7GdbHC9XqT+aCosAe1RVjFLOsGgsVaXiXtmsXDI0KzEYx5HWL+LoXaxFHMtSr5ua+j5qS11N8LeeCl//6sREX31DVfSRU7ahTv/+r4nqjk4kd7trI8Ne7YIPC2B9HLp1LIVmpdVWLNKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqbWpdwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4A8C4CEE4;
	Fri, 28 Mar 2025 17:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743181384;
	bh=PNTqG075RYBsaLR7l760h3y2xIPLtfpHPQQYxSyoSS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqbWpdwZSlGBzXaA71obMeX8FWX5nB7+A+oFsJyI5GJpURzssCZkQW8mnylGrxQdg
	 jCYK1w96LUoEOGoWjyrCNkHTEMz0L2rVx8k6DmVE2vrnvmUUJE1F95u7MgeL3WNeRf
	 t5bFX/dnz1iIi0q87RSNETNQd1gk+IHPCZ/5/bovrFsCfB563OOU0AznqXjfU3f/sO
	 TYKI1x/wsjD6M9CbpQ7G4sZoziDeUohSIMUYMvKTO+uHyAqhtFh+2LunSxgARn9GPf
	 iouVWUga4meYWtShGv1SdCP6Oy4fknGTZw6ceyGgB7izA9clT9yIUGp+5EU1CmM+lD
	 sVobXkaQiUJbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] reset: starfive: jh71x0: Fix accessing the empty member on JH7110 SoC
Date: Fri, 28 Mar 2025 13:03:02 -0400
Message-Id: <20250328120453-20e670e34e7db3ca@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250328003818.1525870-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 2cf59663660799ce16f4dfbed97cdceac7a7fa11

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Changhuang Liang<changhuang.liang@starfivetech.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  2cf5966366079 ! 1:  525e760e970b6 reset: starfive: jh71x0: Fix accessing the empty member on JH7110 SoC
    @@ Metadata
      ## Commit message ##
         reset: starfive: jh71x0: Fix accessing the empty member on JH7110 SoC
     
    +    [ Upstream commit 2cf59663660799ce16f4dfbed97cdceac7a7fa11 ]
    +
         data->asserted will be NULL on JH7110 SoC since commit 82327b127d41
         ("reset: starfive: Add StarFive JH7110 reset driver") was added. Add
         the judgment condition to avoid errors when calling reset_control_status
    @@ Commit message
         Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
         Link: https://lore.kernel.org/r/20240925112442.1732416-1-changhuang.liang@starfivetech.com
         Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/reset/starfive/reset-starfive-jh71x0.c ##
     @@ drivers/reset/starfive/reset-starfive-jh71x0.c: static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

