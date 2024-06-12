Return-Path: <stable+bounces-50298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D11905788
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 17:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602771F28B67
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 15:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF71181320;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqjqf/Ca"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886C5181307;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207757; cv=none; b=UNg1IxXD51BVZArbFmncYtLIRtsPHLb/H/9D8I337kl6NHyZJP550pFceb29xY5bG8POT1dKvcPVSUqb7StZp65g9ybUzt1dYhLxiA29awVBTX241ps7uxZh4ypuhV4nILyBU5Z5cby9dzDwWLXMvuJZnH373UucbdGRLQscj88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207757; c=relaxed/simple;
	bh=9xEyt5u+0FV1WdcJW4h5qgOf/lShmIROJbiYfAkCp2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oVJn532XkRL72YH3Jped07L9bwxjv/qVHTLnb8iEdfGreN6F/aHS6TaewL486uFZ07cXjhmMpqzOQuKq5wt/Z93oHDUiAhtgDawEf5kKYgdZ4PDbWZgDsUodl0bHIcm2gPFTHYvO3km18zW5WODwa6/2CaQoJkbrM+eZTLCCH04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqjqf/Ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DAE8C4AF55;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207757;
	bh=9xEyt5u+0FV1WdcJW4h5qgOf/lShmIROJbiYfAkCp2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tqjqf/CaZet/Ag6j0poWxHb7HiKEaaK5YcB+GOgaujeGm/CTqmmR7Dpwe85nwoQwx
	 c+V3kMPqdBP5Myz+65pVxE9oMiIsFN+BmWMtmf5VxY3oM8ksEzKlEKW+DmWNbZ/ku2
	 fRhru4Rg96vBywd/pCW4BzWif/u0wRSZeSnfWgdUxLunAclTnW6cs75Go5DXZcAw2Q
	 g7YKYNh1qexFpttb3MBCSKwtSuupJSXB6BfjE+gPOUhLGtj6l+dWeCfIVQ3z3mNFcv
	 XYN2CjEu7HC5eZuPCf3f7G3R1emFMsBGz9nJm11Ps9Q3llkAWvIl0kTwNfVqd5AdBU
	 sDaj/b6+rK7QQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FEEEC43616;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix return value of
 f2fs_convert_inline_inode()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171820775725.32393.9431930880169031046.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 15:55:57 +0000
References: <20240603010745.2246488-1-chao@kernel.org>
In-Reply-To: <20240603010745.2246488-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  3 Jun 2024 09:07:45 +0800 you wrote:
> If device is readonly, make f2fs_convert_inline_inode()
> return EROFS instead of zero, otherwise it may trigger
> panic during writeback of inline inode's dirty page as
> below:
> 
>  f2fs_write_single_data_page+0xbb6/0x1e90 fs/f2fs/data.c:2888
>  f2fs_write_cache_pages fs/f2fs/data.c:3187 [inline]
>  __f2fs_write_data_pages fs/f2fs/data.c:3342 [inline]
>  f2fs_write_data_pages+0x1efe/0x3a90 fs/f2fs/data.c:3369
>  do_writepages+0x359/0x870 mm/page-writeback.c:2634
>  filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
>  __filemap_fdatawrite_range mm/filemap.c:430 [inline]
>  file_write_and_wait_range+0x1aa/0x290 mm/filemap.c:788
>  f2fs_do_sync_file+0x68a/0x1ae0 fs/f2fs/file.c:276
>  generic_write_sync include/linux/fs.h:2806 [inline]
>  f2fs_file_write_iter+0x7bd/0x24e0 fs/f2fs/file.c:4977
>  call_write_iter include/linux/fs.h:2114 [inline]
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xa72/0xc90 fs/read_write.c:590
>  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix return value of f2fs_convert_inline_inode()
    https://git.kernel.org/jaegeuk/f2fs/c/a8eb3de28e7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



