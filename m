Return-Path: <stable+bounces-50297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E26905786
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 17:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081121C220DA
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEF618131E;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qrybn7YO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4E18130C;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207757; cv=none; b=N9qfr5HyA24lRoxmBpP0EjmJgdQOs/ImCtwUf1rxI1xsEvlAjilTAVFpSslV2zA93RTmJwNeDe9ViE0tJmPnIpZO7VHxYiim5yXCw+LwtqXYmSZFkh0vEpGraBv0vzhdkbfKidYxOxjQCDvDkIPNC0ShLCeiZbQJJ0mmebcQzq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207757; c=relaxed/simple;
	bh=xjFhkd1pDCVuCkX4MEJUFhIi2XRBRKnNHn6Nq/p1zpI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r8p13Hj3QKb6Uy9kEFX5/hTq/uihTjJr0kh5gx9tdx1LtCUypsjRBFp3EiRkd9fPZBOD2yGqIaaq7xtCKRRAAAcWq/j71Lg2GDKAxVi9cwmZtKT9NFDkJzuTnwTtQhrnoeL3XzAi5ENJqbxaVaa2nTRD31mjf5G3AB1ZewqZ/oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qrybn7YO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40F0CC4AF51;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207757;
	bh=xjFhkd1pDCVuCkX4MEJUFhIi2XRBRKnNHn6Nq/p1zpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qrybn7YOhRJp8ek1nsiVlA8Zdu3h4KRNRVbHTVynqLmRqUvAZ5muuOT4OW3EzbxU5
	 a29mUTTgoY3TfJwTzK/vRYFRIGm899tsiYnj+8ZZoOR9SFFmKqxOU4zlZlfxAOYvxd
	 zndh9YRaxOJ2VMsW2oLgHm/J/nXnZYJBBQgnFe+paqXWKZhiq7FPU7bgnFc3ggMN91
	 oukIVY8CV6fo9sCNwZov8WPkd9UeAUsBQ/5pUHp6BQFqtZDfo3WfhOQw6bgMR0fxYN
	 /SIQEjn2q1t+T9g6vpEw/Z9FnEwuY3QdB1jhyDDX6kq71PpIGuVU1klF67K5xMSMK7
	 lrxLMIdtMa2dQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F12FC43618;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to don't dirty inode for readonly
 filesystem
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171820775712.32393.17507695192982662246.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 15:55:57 +0000
References: <20240604075636.3126389-1-chao@kernel.org>
In-Reply-To: <20240604075636.3126389-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+31e4659a3fe953aec2f4@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  4 Jun 2024 15:56:36 +0800 you wrote:
> syzbot reports f2fs bug as below:
> 
> kernel BUG at fs/f2fs/inode.c:933!
> RIP: 0010:f2fs_evict_inode+0x1576/0x1590 fs/f2fs/inode.c:933
> Call Trace:
>  evict+0x2a4/0x620 fs/inode.c:664
>  dispose_list fs/inode.c:697 [inline]
>  evict_inodes+0x5f8/0x690 fs/inode.c:747
>  generic_shutdown_super+0x9d/0x2c0 fs/super.c:675
>  kill_block_super+0x44/0x90 fs/super.c:1667
>  kill_f2fs_super+0x303/0x3b0 fs/f2fs/super.c:4894
>  deactivate_locked_super+0xc1/0x130 fs/super.c:484
>  cleanup_mnt+0x426/0x4c0 fs/namespace.c:1256
>  task_work_run+0x24a/0x300 kernel/task_work.c:180
>  ptrace_notify+0x2cd/0x380 kernel/signal.c:2399
>  ptrace_report_syscall include/linux/ptrace.h:411 [inline]
>  ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
>  syscall_exit_work kernel/entry/common.c:251 [inline]
>  syscall_exit_to_user_mode_prepare kernel/entry/common.c:278 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
>  syscall_exit_to_user_mode+0x15c/0x280 kernel/entry/common.c:296
>  do_syscall_64+0x50/0x110 arch/x86/entry/common.c:88
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to don't dirty inode for readonly filesystem
    https://git.kernel.org/jaegeuk/f2fs/c/192b8fb8d1c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



