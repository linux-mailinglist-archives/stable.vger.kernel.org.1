Return-Path: <stable+bounces-65461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCEB9485F2
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 01:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FFF283D57
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 23:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1B016EC02;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNCsYQGd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D115ECEE;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900652; cv=none; b=SIYvjEa4ZVeFKBXrZDbfzuRSoh0YD0iEj+gHlp8oSMAKR5JVa2U+RYT30dhRoClLhKWr5s9MBBtYDZ4bNIoGei8QB/RIBPXjPX5xXUukbfURzejxVfYaI+T6qefm3V9JKTjobuRtyF5H1mfeBUajMirv4fvs722jYMRxjAO7bn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900652; c=relaxed/simple;
	bh=kGm5LA15IuGcTFdaGxlr/xX0h027GMbeDIqGZRv/szI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hH8yPnxYPvg5Ns/a3BNLPb02Sb9cfUCx9lfxSDqm7LEoLMEctY5oAErxDx69r06FclHqooBsr9P3MerkoZ/rFgjSIL8XXH5d7HZauLbM5OKwR2DoYXEJVqh6BiIGrDSW2b7siNj42G9Kphjs5h27KJ9wZnctS4+OdlvWpX7Op7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNCsYQGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F030AC4AF15;
	Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722900652;
	bh=kGm5LA15IuGcTFdaGxlr/xX0h027GMbeDIqGZRv/szI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pNCsYQGdTv20TztN7Ki6TaV9wrW4JDW20yNtwQ7eGyriZwmo1kOCI6tRETgYqm0Xk
	 2uu61mVWp1ABXiGwWu9wMb3ex+r7A+RR7W28qW/I5Kzv9MYDH6ly53MJaiEGQj7uTM
	 kAILh2L4EOhU3R6Yz7wRX7mFXcwTgMLnTeGoJzF8a+otiNJkbUiNlhMgUT6kBdCgIZ
	 nI5zxOcRuixs/M1IN1WyHFArFPLWUIzki6z2xlVVs3KDr2SHaSS58rO+cEBJ3u2Dmo
	 0MttebndKHJyTWsqSvRi0PwTlD6DIipiHVUM+j6cOfheogUO0alnUPQbndYz9e09WZ
	 3giJcq+hGeJ8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF85EC43337;
	Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to wait dio completion
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172290065191.2803.3335621723887091762.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:51 +0000
References: <20240627071711.1563420-1-chao@kernel.org>
In-Reply-To: <20240627071711.1563420-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 27 Jun 2024 15:17:11 +0800 you wrote:
> It should wait all existing dio write IOs before block removal,
> otherwise, previous direct write IO may overwrite data in the
> block which may be reused by other inode.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to wait dio completion
    https://git.kernel.org/jaegeuk/f2fs/c/e60776860678

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



