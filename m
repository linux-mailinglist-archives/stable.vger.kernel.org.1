Return-Path: <stable+bounces-65463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9909485F4
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 01:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871C8283D13
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 23:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E9616F824;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1eM5oh1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C37E16CD12;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900652; cv=none; b=l7ymXXjWybpeTrftxYdD9xojwufmFlez0AW1/OT6yOA2Pe9drlCrat4qMoN0NG7W22GOkhyOr/YoabZ8rpq/8NburuRDsXEUOuQJVp+BXvE5t3S+Gq79DmLmPBt7LwYYQ5rlx8CizxuhLodnMRDg429E/pxEHzmgi7ozJm+3fQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900652; c=relaxed/simple;
	bh=BmAKtpyETPm1YzZTlRU1TiFMVb0KZtHi8NofXiNghTg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jpmA9Vsmf2zUtjR9vx7ugbziG9KstRdbjDN4FauRZw7g4QYb/x6ntjsKwWGH335sklisjziHDwKRbtpjyC8uyZSZA7xPvho85ihkSGFhNN/XmMso/op2wpb9Ognx3mqv8GhRYQQI9e2HwWa5CcRk/4MOUQU2iYm27NPAGOk2b3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1eM5oh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17844C4AF50;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722900652;
	bh=BmAKtpyETPm1YzZTlRU1TiFMVb0KZtHi8NofXiNghTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q1eM5oh1c2oVU0tBZorsUrcpABdyVOs6p5k/vQivhg8HOx3TA0KDLc+LhEj1HyNfy
	 mnDzGNa0HarqXnRLjmqSJdCyAToMz/BVuzoc42SBOyxfCBy3x/3b4IgqQ++haZ+gjH
	 cRrqCPfFEd2M5EXGbGFadJU3uzLL1iY5LWI/l/L5YZbnmPivFsLEQCI0y9FEmguygQ
	 KKNm3V8xuPU1yjnINTPjExE1CqJYkdur5+aYEV8r+bRCZKuREJCRFRmDfFy6OZ/nyM
	 bXu8YWpiKExwTZ6MVtNF4Kq/bWzsN2j4Cl5hmYtymPP9yuj1hBrbhxAGGbG30sm/Cj
	 FFEVa3hzFWy/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B476C3274D;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent possible int overflow in
 dir_block_index()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172290065204.2803.10007931893613649587.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:52 +0000
References: <20240724170544.11372-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20240724170544.11372-1-n.zhandarovich@fintech.ru>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: jaegeuk@kernel.org, chao@kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 24 Jul 2024 10:05:44 -0700 you wrote:
> The result of multiplication between values derived from functions
> dir_buckets() and bucket_blocks() *could* technically reach
> 2^30 * 2^2 = 2^32.
> 
> While unlikely to happen, it is prudent to ensure that it will not
> lead to integer overflow. Thus, use mul_u32_u32() as it's more
> appropriate to mitigate the issue.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: prevent possible int overflow in dir_block_index()
    https://git.kernel.org/jaegeuk/f2fs/c/47f268f33dff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



