Return-Path: <stable+bounces-161767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C994B0312C
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 15:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07D3E7A960E
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78725226CF4;
	Sun, 13 Jul 2025 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkViS1BQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C1E2E36E3
	for <stable@vger.kernel.org>; Sun, 13 Jul 2025 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752413424; cv=none; b=JHUMRlcMm3bRT3p3iv8rtclfFEkTtP0Xe4lp9Ay2rw8vex/Sy/woqIneYju9OJ3YtCW8JGMxFzwndDkA2B9RVvd8ehQ+ldW9oNLrZq16zE1Yj+ErrAcd+ItjyvD6x98Y69Rb1Fh/i8sFVQ5Y3hAnim9RV2bTZMN1nL+9zrnxSqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752413424; c=relaxed/simple;
	bh=hRFYpgqyfoGesfV6z3ehAdCO8YzHlQGuWXhDjGk8tSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVKdtGUBonvXQzb3oFMyNWQ8QgZ4cNGiR9IgsEiF0RVMCPv2LvVin5oC6wnLIuaFVVg39z8c094hmwvDDefw+AOcBBKh4bDZKUy9dh9HrNmpm26IZHldccLvKRh2miT+R6VYzjN766XrrRQ8xdUvG84u1dK6Z58oswzO03yZESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkViS1BQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460BBC4CEE3;
	Sun, 13 Jul 2025 13:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752413423;
	bh=hRFYpgqyfoGesfV6z3ehAdCO8YzHlQGuWXhDjGk8tSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hkViS1BQXegD8wcD0v9ZOzHRpGxbPqvzjcaACk1gUiow6xsjui9r8jC53fE4aLfcy
	 Pr8+lxwwLogH4XSlqzSITQsnfvd/3hdTrFk4fQ8i0joKo2wSYDWt0LQ7CXe4Dl6IZ+
	 BwfLJ5TsDYC0Hy2vQ0bOa5eJziuEHZ+dnqOptX2gGJmu/Cuvk38VgPZOIBIjGt+Bzc
	 mnH5UlS/BjaoouovRMIxDfyUSo9KVE2lQFGsQJTi4JwaiWUdasVY3JsxReynLbeuvE
	 dShJvGlx4ecHldhC2tsxvdLo8TANi8GPdlW+DCzBfJ+2lNBuDpxF6eAkBLjUrE3/Yv
	 UdbGfCX157wZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] pwm: mediatek: Ensure to disable clocks in error path
Date: Sun, 13 Jul 2025 09:30:19 -0400
Message-Id: <20250712204829-fc0f4c74bb537235@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250712205600.2182944-2-u.kleine-koenig@baylibre.com>
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

The upstream commit SHA1 provided is correct: 505b730ede7f5c4083ff212aa955155b5b92e574

Status in newer kernel trees:
6.15.y | Present (different SHA1: c4ffbbd8e366)
6.12.y | Present (different SHA1: dd878f5a5d0d)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  505b730ede7f5 ! 1:  06f8584381eb0 pwm: mediatek: Ensure to disable clocks in error path
    @@ Metadata
      ## Commit message ##
         pwm: mediatek: Ensure to disable clocks in error path
     
    +    commit 505b730ede7f5c4083ff212aa955155b5b92e574 upstream.
    +
         After enabling the clocks each error path must disable the clocks again.
         One of them failed to do so. Unify the error paths to use goto to make it
         harder for future changes to add a similar bug.
    @@ Commit message
         Link: https://lore.kernel.org/r/20250704172728.626815-2-u.kleine-koenig@baylibre.com
         Cc: stable@vger.kernel.org
         Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
    +    [ukleinek: backported to 5.15.y]
    +    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
     
      ## drivers/pwm/pwm-mediatek.c ##
     @@ drivers/pwm/pwm-mediatek.c: static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
    @@ drivers/pwm/pwm-mediatek.c: static int pwm_mediatek_config(struct pwm_chip *chip
      
      	if (clkdiv > PWM_CLK_DIV_MAX) {
     -		pwm_mediatek_clk_disable(chip, pwm);
    - 		dev_err(pwmchip_parent(chip), "period of %d ns not supported\n", period_ns);
    +-		dev_err(chip->dev, "period %d not supported\n", period_ns);
     -		return -EINVAL;
    ++		dev_err(chip->dev, "period of %d ns not supported\n", period_ns);
     +		ret = -EINVAL;
     +		goto out;
      	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

