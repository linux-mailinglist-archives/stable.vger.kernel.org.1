Return-Path: <stable+bounces-89105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D169B3810
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 18:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A89B22AF6
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 17:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05713200C8B;
	Mon, 28 Oct 2024 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJZXsoaP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48281DF963;
	Mon, 28 Oct 2024 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137241; cv=none; b=YIr7S93eUvE8kfVMp9jltrqM5n4y6N1Fe1KuNXWZc7WRUGK0sYYzdno0k8a+O8/0W8YWuANlleZ9LEhdZAxZO7PfADTflfwmIRnL4ROPxn+jhyu9D9nCzhhCrGR46SvCvfc9ekrwf+WfOaIQ3nFXPXo7t0LYufYAQwJnB9kJmms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137241; c=relaxed/simple;
	bh=kpJcVW/EFeg82s9DqGxirpAkIKtxE8wORBMCHE/olj0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aXwl2Tw+FQ4VNB1HfsBorMzeU4jF1EX0nMLLQhNBywAxRZ/tfqIK2sZQmuncAGQBh4U0HbV4fDSknZfIsKr5XA82WEyiVfAJhGGRPETxDNn5hWHbU4Ie3Cq1f9VkE9I3QVOubW+yLf+2NCoUbLq4miNEDwzB0i7gzy321Y5+tvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJZXsoaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE9EC4CEC3;
	Mon, 28 Oct 2024 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730137240;
	bh=kpJcVW/EFeg82s9DqGxirpAkIKtxE8wORBMCHE/olj0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hJZXsoaPeYMrAKfrAo7igcd5lhPjfIoUGs60u4X8HC4X9L+J/607xFDJYyepG6BwX
	 IKznh9OSBXxpcH7h3GUljg6YvtXgkGKRskKLy4fZr0eh8+yq0FRg5KsnDUamkl0Lrt
	 6lCVaFO8lTgo4lqFXPbFX6UdnaBqOAfGT+iROGFo2ZECzf/cO96OHS6Sfh0zXK3LVi
	 kntKPK8ip9FwVggIOGeVewtIA1AJO4+rfnyiOuH0xEEpLAuZyXypBfHUfCfHDCx7DC
	 W7IXBuagIRb1/2bjSfQ4PfA37lsEnG2yQNwGsZ4q6Du8n2siYehbnrSAWLP8WRbhJx
	 oBGChQAIeNvjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEAC380AC1C;
	Mon, 28 Oct 2024 17:40:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity check on node blkaddr in
 truncate_node()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173013724745.126843.2488678512223387224.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 17:40:47 +0000
References: <20241016081337.598979-1-chao@kernel.org>
In-Reply-To: <20241016081337.598979-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+33379ce4ac76acf7d0c7@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 16 Oct 2024 16:13:37 +0800 you wrote:
> syzbot reports a f2fs bug as below:
> 
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/segment.c:2534!
> RIP: 0010:f2fs_invalidate_blocks+0x35f/0x370 fs/f2fs/segment.c:2534
> Call Trace:
>  truncate_node+0x1ae/0x8c0 fs/f2fs/node.c:909
>  f2fs_remove_inode_page+0x5c2/0x870 fs/f2fs/node.c:1288
>  f2fs_evict_inode+0x879/0x15c0 fs/f2fs/inode.c:856
>  evict+0x4e8/0x9b0 fs/inode.c:723
>  f2fs_handle_failed_inode+0x271/0x2e0 fs/f2fs/inode.c:986
>  f2fs_create+0x357/0x530 fs/f2fs/namei.c:394
>  lookup_open fs/namei.c:3595 [inline]
>  open_last_lookups fs/namei.c:3694 [inline]
>  path_openat+0x1c03/0x3590 fs/namei.c:3930
>  do_filp_open+0x235/0x490 fs/namei.c:3960
>  do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
>  do_sys_open fs/open.c:1430 [inline]
>  __do_sys_openat fs/open.c:1446 [inline]
>  __se_sys_openat fs/open.c:1441 [inline]
>  __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0010:f2fs_invalidate_blocks+0x35f/0x370 fs/f2fs/segment.c:2534
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to do sanity check on node blkaddr in truncate_node()
    https://git.kernel.org/jaegeuk/f2fs/c/e767ae13e67d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



