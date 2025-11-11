Return-Path: <stable+bounces-194544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2980FC50049
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 23:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F30184F3369
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 22:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C898A2F6583;
	Tue, 11 Nov 2025 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cosvdhqL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851192F656E;
	Tue, 11 Nov 2025 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901450; cv=none; b=Rrt1Dol9cZ16ooJmmt6LQuq1ra+3t7Ml3lnXnMy5W7qOVSZglvFl4eD9qUCjRxyP/DMYYVlMeJ7gIpzIlQ6mbi1xMLOXYdsZ/tMRoXWVB8jy229glIa8nZO929s61Do0MXQZS1QXN/1aDrjFID8lUWVcmVW/ncIMD/J0DfyjNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901450; c=relaxed/simple;
	bh=vn2gL6MOI11wVy8RMceFUcCj5h0SeTBKfJ0/P0DfPKg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ckHqDCaIesRf65savYF2CJhGUwVw8EXfygz8ACx5NjCbPgNVM93rv+LDQi/M//NEpbr7rp6dod4Gf1Hc1GJluy+r/chrpB3CYE5hhqtST1Bv3kI1IxPwcw/k9c37NGyLIlW3h4AEiS7UypElnUyU9tuIjZKILA3+BThk+GxJm2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cosvdhqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2495DC113D0;
	Tue, 11 Nov 2025 22:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762901450;
	bh=vn2gL6MOI11wVy8RMceFUcCj5h0SeTBKfJ0/P0DfPKg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cosvdhqLr34OeP8XAUE3+1jUYM8RTNQxEYagv9YUqbW70wGIiaLcN8vvqahXsyAhY
	 10IWJsh3jKoOvclBo3p7a4U7hW9+HIvNbjCtUN9HNzMqJ8BbMU3VutWn6ChWY/tAzO
	 Q8u48QbL8j/iyzPAAChTxtLLL/FzLEOCsKsRzfRkqAhyuiT5/aQE7V5kTgUwjLD2q1
	 L5I8Rka3tu1fg2AT6DbXD6tFnzSa8k9tthj4Cm4UVlCO6LA9k2B3TOkqpp8NBIi3OP
	 u5tjbskCR2/TU/EdiYmoTZvXmgrA/FJ+PR2Q93Ui+xFB4stBoGaZofyV1l3pNlwSr/
	 efBLis0aQfk3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D3F380DBCD;
	Tue, 11 Nov 2025 22:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: invalidate dentry cache on failed
 whiteout creation
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176290142024.3596344.13243926252945264194.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 22:50:20 +0000
References: <20251027130635.13739-1-kartikey406@gmail.com>
In-Reply-To: <20251027130635.13739-1-kartikey406@gmail.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org,
 syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 27 Oct 2025 18:36:34 +0530 you wrote:
> F2FS can mount filesystems with corrupted directory depth values that
> get runtime-clamped to MAX_DIR_HASH_DEPTH. When RENAME_WHITEOUT
> operations are performed on such directories, f2fs_rename performs
> directory modifications (updating target entry and deleting source
> entry) before attempting to add the whiteout entry via f2fs_add_link.
> 
> If f2fs_add_link fails due to the corrupted directory structure, the
> function returns an error to VFS, but the partial directory
> modifications have already been committed to disk. VFS assumes the
> entire rename operation failed and does not update the dentry cache,
> leaving stale mappings.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: invalidate dentry cache on failed whiteout creation
    https://git.kernel.org/jaegeuk/f2fs/c/5e8c6aae36ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



