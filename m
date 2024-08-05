Return-Path: <stable+bounces-65462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1FB9485F3
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 01:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7F3283CCF
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 23:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F66916F288;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sk1EJWeX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C33816CD0E;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900652; cv=none; b=Ec4tu8lobHdNBVGYeCHsHcwl7gBTvHq43/IqqZdC9GeqDL4iC2eGLExTwO8Ja0nbxlmcd42/kbHi5/u6dTBqbjf+UNiW2exw7XlYd2XcwZ2RO8iKtATsjElGTUp5prbvqlGq+4oOSgEvRFQ/TGu7pmBleOl+2YsyC292Ycjg/yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900652; c=relaxed/simple;
	bh=J7HlvM9ebl2LhQNjxB74nmObesaFPxmrkJCZVoV4R2A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Csu8fbnuI4+QQQVHqmUotY8mhFAYm+IAJtJsO0EOqJ5z6VU0wV7l4RlDyVLiczgaGh5/lBwySjNyafoQhvCjvznNGenkia1H+xgJYitkbKGmwtdG8+6ewuIK/jA/PjHhfZ8l6gZ9u4rR76zWhwMcSezTwt9zUGb8hMpOzJbRumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sk1EJWeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F036FC4AF17;
	Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722900652;
	bh=J7HlvM9ebl2LhQNjxB74nmObesaFPxmrkJCZVoV4R2A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sk1EJWeXRNZlVvwBXBskZ+EXiatDYRtVUsxFyKu/e6egYDHg6PIZ2JE8wkMW55GWq
	 tSaFMWuqLz6ynzKZc8eKQ48PIcgGDr6S6sdftHhhKDqlTFdKU1KeqcUbG5D3AyUKez
	 XPOwV6Ja4T0VryfMuzKfsma5cO3kfH9M4HLdU8QCcmY/kYel0P4RDFFQqeSlaY5G9v
	 WMf7gC1Qk6Zynqv0Ru8teQJ/GFpeh7GrqSEIXIJP1EyLRdbsWeM5WZ336rAtSQ7n2Z
	 tu55kE09kCxxz8OLY4ttQVdDAArZOqnj3FfzArIRD0FelmUCQzCRO3LWgxnjd64MpT
	 igP/e6BCYfG3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7CB6C43140;
	Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix several potential integer overflows in
 file offsets
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172290065194.2803.2752541342354642319.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:51 +0000
References: <20240724172838.11614-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20240724172838.11614-1-n.zhandarovich@fintech.ru>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: jaegeuk@kernel.org, chao@kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 24 Jul 2024 10:28:38 -0700 you wrote:
> When dealing with large extents and calculating file offsets by
> summing up according extent offsets and lengths of unsigned int type,
> one may encounter possible integer overflow if the values are
> big enough.
> 
> Prevent this from happening by expanding one of the addends to
> (pgoff_t) type.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix several potential integer overflows in file offsets
    https://git.kernel.org/jaegeuk/f2fs/c/1cade98cf641

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



