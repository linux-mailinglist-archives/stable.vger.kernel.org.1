Return-Path: <stable+bounces-59355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA5E9316F9
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 16:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394D41F21FC6
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813AC18EFE5;
	Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="greNMbVr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4258518EFCD
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054432; cv=none; b=uvYwpY5nhcmEJYM+XKcXn8Qjoz+M9tKdiLGfWKBOP25iJe0E18nBalt0hf2Sn9QgK1PLgcRPCvAWSKiVcZC8G+FbHVEcSciT8t1i/xxAzfWNtY2lZb4v3ZCGqKbzGysEtyW53fybKSfRgZM0Al1t8eBCSby8f0ZgRJDuZa0JQ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054432; c=relaxed/simple;
	bh=KzDd9XQYgO857UobzAp/4Deac60lHHMkorgQg6A0eas=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XWH+Z+E9Y1hnEVYbGGpGUCZHa4hzt6G85VOmBpptMzMfhm+IZnrXjAU2vlEssqbwRULON0fkOgdmM2NqQ+RacMGXtkHF0crihsKY0CpiCLgKtBnmNN9ldqmIi03UedHI/ohiArSVE3/VyEevrumUjlPHe5QsADVGF43OKpY8vDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=greNMbVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 100EDC32782;
	Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721054432;
	bh=KzDd9XQYgO857UobzAp/4Deac60lHHMkorgQg6A0eas=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=greNMbVrmbZU+hLx+7PFSF/bhj0vdj3njF1i8X3k9R2h6IdvDOsXSZ3N4buYNmsd2
	 RmQY3pScpEXeZPCh+zuM/v0R4P3sR1uXTs5uG6TQN4mBygn3vyyWOfnwFo1AswQRFT
	 i5/ZpKZ+VVQFyF/UCq9zstoeuc5MLnkgBnPSNZMXt9hG8eQ3tmsR+jdjOVHNdIgsyF
	 P89o74wqhojS7TNDhB80BNJmQbPJ4PDbttswZgct5IAN7YNgGb2fZ77p5CirLNwR+h
	 HvuDgSyPMIiwzBW7CSClb8ExAR6W8194R+/SqghXSkSR7QY2/DChbgjT+QRVH+0Sy4
	 rLJAIHEOZOGVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0127CC43443;
	Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: use meta inode for GC of atomic file
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172105443200.17443.3328341243004034413.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 14:40:32 +0000
References: <20240710115117.61255-1-s_min.jeong@samsung.com>
In-Reply-To: <20240710115117.61255-1-s_min.jeong@samsung.com>
To: Sunmin Jeong <s_min.jeong@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, daehojeong@google.com,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 sj1557.seo@samsung.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 10 Jul 2024 20:51:17 +0900 you wrote:
> The page cache of the atomic file keeps new data pages which will be
> stored in the COW file. It can also keep old data pages when GCing the
> atomic file. In this case, new data can be overwritten by old data if a
> GC thread sets the old data page as dirty after new data page was
> evicted.
> 
> Also, since all writes to the atomic file are redirected to COW inodes,
> GC for the atomic file is not working well as below.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/2] f2fs: use meta inode for GC of atomic file
    https://git.kernel.org/jaegeuk/f2fs/c/b40a2b003709
  - [f2fs-dev,v3,2/2] f2fs: use meta inode for GC of COW file
    https://git.kernel.org/jaegeuk/f2fs/c/f18d00769336

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



