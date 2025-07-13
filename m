Return-Path: <stable+bounces-161766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E12F6B0312B
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 15:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215AB188E8DD
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6CB38FA3;
	Sun, 13 Jul 2025 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/Ppdu5R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F162E36E3
	for <stable@vger.kernel.org>; Sun, 13 Jul 2025 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752413420; cv=none; b=akk9Fn/UfJFcqgzDQ6ESuhxB3IX/fL4kTwAcrqFdQ/HwTUk2qXtsa/nh8AsRpmKsj0jVnEQcwc/30u3amXc/0vvqQlk1fc4OACdYEqe+myCvX5ed5gmD0x3uUMsf4bUgZYwii71NlnzKGLoU4izEKILroJdB/w/+SsxBKKoMXYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752413420; c=relaxed/simple;
	bh=YVg7k7yTUIAVccwxc2tNwEpOsCxIKdu8TSdYHx2eKVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBelWHO+d0xvIidOeLgZlJG6OX+C2zc/dXruBgFkFwQffJUuu2rptJkaPBeDKhXFohBVhy1/ska9E+h3f1sEb1tiHjGnhhDZxgnG6TwNz6FkNjAQRtiSfaW9Sl30yZi8aXsgTtk/Jw5ZgoHMei+IoKEjnagY29+F1oa6QPQpvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/Ppdu5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A765EC4CEE3;
	Sun, 13 Jul 2025 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752413419;
	bh=YVg7k7yTUIAVccwxc2tNwEpOsCxIKdu8TSdYHx2eKVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/Ppdu5Rqo4cNQOVVF1sBvAQ31aTdRSHiGbz4ktzG/EifTF6oyrKSUwBq5CbD3xUv
	 QtJ/K6ci0GSYifoi7gE9Gud9X2Ret8iOf5xhsO4hIO9SUeQAbBD2Tp4mrkOnIZRlH5
	 6cmUY0vrRKO1eql8kSxJpZInBhB+tQN3NWEXDvZug/ycOEFsW/QIAqhUApOFDCT2EY
	 apcEWSHnZevRVpM0G6GzMA5MqP3ODLqUAbSX6xwfNJmC59cD4ebanQSQdbcRk3feMP
	 vTz/RU6tNcFy5bT/7kMwWPadMNOmgEjxP9aO4XeQg9/HE3kw08nx/fmgTEgyoiRjH2
	 WK+u8NNqkiUZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] pwm: mediatek: Ensure to disable clocks in error path
Date: Sun, 13 Jul 2025 09:30:15 -0400
Message-Id: <20250712205857-51983e3f252b7d79@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250712204543.2166878-2-u.kleine-koenig@baylibre.com>
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

Note: The patch differs from the upstream commit:
---
1:  505b730ede7f5 ! 1:  2199efc1b6d97 pwm: mediatek: Ensure to disable clocks in error path
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
    +    [ukleinek: backported to 6.6.y]
    +    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
     
      ## drivers/pwm/pwm-mediatek.c ##
     @@ drivers/pwm/pwm-mediatek.c: static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
    @@ drivers/pwm/pwm-mediatek.c: static int pwm_mediatek_config(struct pwm_chip *chip
      
      	if (clkdiv > PWM_CLK_DIV_MAX) {
     -		pwm_mediatek_clk_disable(chip, pwm);
    - 		dev_err(pwmchip_parent(chip), "period of %d ns not supported\n", period_ns);
    + 		dev_err(chip->dev, "period of %d ns not supported\n", period_ns);
     -		return -EINVAL;
     +		ret = -EINVAL;
     +		goto out;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

