Return-Path: <stable+bounces-142906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7DBAB006E
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E759E6811
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0AD27CCCD;
	Thu,  8 May 2025 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKhuGYf1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B03270ED0;
	Thu,  8 May 2025 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721792; cv=none; b=SNwGms7Bi8sytDRBYV/VE7ndufp4vx/W2JPWo79cld4pENeT+WELmGVxB8eivujrgTAG6rakAsaMmZIUJdg7PP6QeD7h/clE6Jvp5JHcbmYwBYrbzmim3FARensyJsUHgbuGMMZnKEUItZ7VYl6fz2ps9vyEgqsaP8DWABGCd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721792; c=relaxed/simple;
	bh=c05nwsF/Xsj3ZZ0udY2Gc5dtMsXMs8vJzGIq6HHgV7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YWiOMHM2bRqWvgtwt/yrMKHR5fFKzrV3i4FQrgX1b7bODoPgK3bmT4/8rz8+JkDAV9acYxyc2eLRZFi337k5zyjuIcT+xeCSWiDATplKMjhKz5qreMo1hzswXNiGZiEuKAG1sH4eFob0WpGBY+N0RlZSsdtZsXJXWx4cOEPLLaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKhuGYf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9057BC4CEE7;
	Thu,  8 May 2025 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721791;
	bh=c05nwsF/Xsj3ZZ0udY2Gc5dtMsXMs8vJzGIq6HHgV7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GKhuGYf1nw/QHswWp155Zar4n0RUfca1/0d160veT51Bc0tnKmcOitaBDKdMt8k8d
	 EXGdTkOugUgON7hRkQLqdFfPhOCWn26q8kBcHVdnMCYphP+Pu1niHNjT5eF28hBG53
	 jCpEIXiPLvcp104roIEFnMQ/dtrK/bzzXTweT/s3PkL6mlFmL4uBQ3Ix1ILrDgTdWL
	 Ak7eVihTMyLa8OlczX74d3rKdAN/fsL7VHKkzgC9xo+Mc+fUdMATqChBQcrbdwRs5H
	 FIlFs6k/IH6gM0JqSXDCNKpholTu6CrRs6b4+PDN07eacUgnAeEu+f21N+gl8CsTOc
	 s7IBciTEmxKnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7118D380AA70;
	Thu,  8 May 2025 16:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/6] f2fs: fix to return correct error number in
 f2fs_sync_node_pages()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174672183025.2971823.13421016836031371111.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 16:30:30 +0000
References: <20250508051520.4169795-2-hch@lst.de>
In-Reply-To: <20250508051520.4169795-2-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  8 May 2025 07:14:27 +0200 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
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
  - [f2fs-dev,1/6] f2fs: fix to return correct error number in f2fs_sync_node_pages()
    https://git.kernel.org/jaegeuk/f2fs/c/43ba56a043b1
  - [f2fs-dev,2/6] f2fs: return bool from __f2fs_write_meta_folio
    https://git.kernel.org/jaegeuk/f2fs/c/39122e454419
  - [f2fs-dev,3/6] f2fs: remove wbc->for_reclaim handling
    https://git.kernel.org/jaegeuk/f2fs/c/402dd9f02ce4
  - [f2fs-dev,4/6] f2fs: always unlock the page in f2fs_write_single_data_page
    https://git.kernel.org/jaegeuk/f2fs/c/84c5d16711a3
  - [f2fs-dev,5/6] f2fs: simplify return value handling in f2fs_fsync_node_pages
    https://git.kernel.org/jaegeuk/f2fs/c/0638f28b3062
  - [f2fs-dev,6/6] f2fs: return bool from __write_node_folio
    https://git.kernel.org/jaegeuk/f2fs/c/80f31d2a7e5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



