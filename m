Return-Path: <stable+bounces-50299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3747690578C
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 17:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E7228C242
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B5E181330;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WW+wSfbA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB90D181314;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207757; cv=none; b=hGkoHIm/4wCpppeX6+fVCKV9F2O88ELABWFxuGTV/1dusxjdgFoGw5cfPH9lhsVqNLUzKvplK1H5DQq1tUxq6SUZU321NJX2xdzoIX2zciOimKgg6I8dB4w5Q6G3De2mOseIT7pKYMbMWJvB0zWMigHuLgLrfcjG/lkJwYNvWGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207757; c=relaxed/simple;
	bh=47LLGyJx3n63fVJFIMhbJCouJ2KvXOEPCo6cPO4GGZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wye/1JouSSRcHyXqnnuHHN5WIwOwBFcES4qfqyLDIVNuzjC9DD3GH3e07BaTtqwsp11uZW3Ui67VJjNbntJpOkgqT+8Y9oAiwcScZg0BpEobXzEhztC9AkxOvEU6xUr2bVrVnhvHGwqgbDqowQdeAqShviHC0j5qJu9jR2c5cgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WW+wSfbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E7F4C4AF68;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207757;
	bh=47LLGyJx3n63fVJFIMhbJCouJ2KvXOEPCo6cPO4GGZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WW+wSfbAAomyAeKf1LSvtfryt8kxqzuwLGL3TFDswDG+935E5W31eLoxtwmgUVsI5
	 3u1EqTPTQb0XumXkosdATdfrXmIeUSjzVsbuZEoD/mPlSU3FYKVwj0WzSCPr89liZY
	 FJ1JZZ1HkCKaTpWZE6LRi4wtYnH5hi71LM1ALq+JSBO1GWjSPdeh1PCjeOky5uVut9
	 oTeqvqkxmoZGzmaKvsorSQdVXaSX+hbsjjI01OemSpDNXplhCyRMunGcvXy48dL9sA
	 jQCb2Q1ozyE0tQRR08Sc6Vge+9ng+SXrYFDhbN5i4FYlHz1TlXnTYg46CizSu5Y8b6
	 c/VDWLtt0em1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4924EC4361A;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to force buffered IO on inline_data
 inode
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171820775729.32393.7251723492802127361.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 15:55:57 +0000
References: <20240523132948.2250254-1-chao@kernel.org>
In-Reply-To: <20240523132948.2250254-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, v-songbaohua@oppo.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 23 May 2024 21:29:48 +0800 you wrote:
> It will return all zero data when DIO reading from inline_data inode, it
> is because f2fs_iomap_begin() assign iomap->type w/ IOMAP_HOLE incorrectly
> for this case.
> 
> We can let iomap framework handle inline data via assigning iomap->type
> and iomap->inline_data correctly, however, it will be a little bit
> complicated when handling race case in between direct IO and buffered IO.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to force buffered IO on inline_data inode
    https://git.kernel.org/jaegeuk/f2fs/c/5c8764f8679e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



