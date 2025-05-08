Return-Path: <stable+bounces-142907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6DEAB0077
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85701C02709
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58332853FC;
	Thu,  8 May 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpiEbtZa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6270C2853E9;
	Thu,  8 May 2025 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721798; cv=none; b=BhAEOBffeS9a+uIGxie35zIB7I4Fn+hnInFb8emqGxi739d0L7byFytw/EDczzj0WCVZBs8GvBZRwDjQr1+yHAbVk7+q4YWGtCIQpFnG0zy3dolkMV4BnmATYN/FaEA9UPSX+HkESoOTbT9KQ+0G7pF8THSfHXzEOldz8yHEjVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721798; c=relaxed/simple;
	bh=SeIAFSWx7zH//oPWO+0JB8KVFbGqrfACDBlR28gXzlQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VIEW1aw1Oi45w8h7z8hHX/B4/KYDE51PwwvvM1PWK2+jtEIFHANBO6wjI3jICmo831vwl9YQzh+xZmSm+gyUKhDJL5f88stY5xPewVgOWNjDUZ75qgqeon8B5UfWWktekeuHNAZTF6zG+bmvSq2yOymLvmpd5gcl7YoqeXiPxSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpiEbtZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF796C4CEE7;
	Thu,  8 May 2025 16:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721797;
	bh=SeIAFSWx7zH//oPWO+0JB8KVFbGqrfACDBlR28gXzlQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YpiEbtZaSJ+qSHZslzT+J8tPhqmeRm6hJG8xdBW+SrRTGWEn0MAn/ahVpQrmBB8m9
	 IR/rAjBeX1Eekp2zjMRBYBdD2ix4olIArIeOmP4FgvCXkXJfO/6CrXGqXyD1X1xTSu
	 59iQS57jCFHHU1mpWCJx/KAuRnTlzK6kk5patJ4b01nDvicU6ys5xGKiha5+w/H7w1
	 FjF8Tt9FKBQ3n8QcQ3JtmpGJwQb6JR8qr0ffiOiojsYJ9Z3iO0WYzyxyBE0GpXa61o
	 FPVuwaCO9wgbfgl2I7SoljhhKEgVJxHA5GwVhpTx6qTDz2PXbDjoTjV+wvwh4FylDQ
	 LgBhq5aX+JixQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4F4380AA70;
	Thu,  8 May 2025 16:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to return correct error number in
 f2fs_sync_node_pages()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174672183636.2971823.10798843994622646234.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 16:30:36 +0000
References: <20250507080838.882657-1-chao@kernel.org>
In-Reply-To: <20250507080838.882657-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, hch@lst.de, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  7 May 2025 16:08:38 +0800 you wrote:
> If __write_node_folio() failed, it will return AOP_WRITEPAGE_ACTIVATE,
> the incorrect return value may be passed to userspace in below path,
> fix it.
> 
> - sync_filesystem
>  - sync_fs
>   - f2fs_issue_checkpoint
>    - block_operations
>     - f2fs_sync_node_pages
>      - __write_node_folio
>      : return AOP_WRITEPAGE_ACTIVATE
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to return correct error number in f2fs_sync_node_pages()
    https://git.kernel.org/jaegeuk/f2fs/c/43ba56a043b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



