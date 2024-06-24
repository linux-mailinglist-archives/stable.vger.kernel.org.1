Return-Path: <stable+bounces-55096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B2491558C
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 19:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2D91C222E4
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B324919F46E;
	Mon, 24 Jun 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPavk1N/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7319EEDD;
	Mon, 24 Jun 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250831; cv=none; b=dbShJF4l1QVIz6uqvaEKWRehT0U8eeQ8g8O6YSbYcRUXfn5ljQtt23DOk57uqD1+btmMFIBo5PIQZEmrDlaDMp0NfHo21OgH2uWU28ysLq737JmaydtSF77ExtNBBB9+A9d/DNv9H4oF/G1ebUHPIWqvw1wsYiAcFueTeU4fUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250831; c=relaxed/simple;
	bh=cVZguKETeKIYSegRsLSDsF+ocn6kUtTa2dnkN7qny8k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CpQ8yTYt5ZcfvKOd7sw0wGi0JWdrgbpKG06m9sO4pCRAWG2394Yvgw0KfeE/HJsbgaCQwPpG/hwcPKnuBhbbnm/BjyYbDDNxygg2RfFr+2QCugtcUZNswn3w6zRyo19yBwdrKzXL5pRY0uOtAPcWamqgMDbTsvQKUtetlzSzI0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPavk1N/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07D57C32789;
	Mon, 24 Jun 2024 17:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719250831;
	bh=cVZguKETeKIYSegRsLSDsF+ocn6kUtTa2dnkN7qny8k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CPavk1N/CfgB5i6aKmd98eXP58YRJCznv0VMuBaHiSlqNPERXtcr5gKjJ4jJcv+49
	 y1e1lYJ7BmNcr/IKlKU0Yu6n/FFldPUegW/xd4bindRky6ec3uL2OxiSAbbuBg2/zo
	 RssF/NSP7BFMPL6k6wA8yUuiQBTBtWemwyaMI8ObZtGZnB2geY/Q61aeR1h+stBjck
	 km1+cva12wyZ8ShxfawpeOSeH9ZAHIVy2vJyDM4GUNRCcgNa2LkCNJiRqLeHvwiWgK
	 0/ppXqXkVmUjJQURzK4hfNT01ZXDb2a2b2tmmQAlGSL/uScAIDd6V05lGmFk4SNlQ4
	 Ww37vgtplBjyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D89D1C43612;
	Mon, 24 Jun 2024 17:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: assign CURSEG_ALL_DATA_ATGC if blkaddr is
 valid
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171925083088.4247.5859176757737434245.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jun 2024 17:40:30 +0000
References: <20240618022334.1576056-1-jaegeuk@kernel.org>
In-Reply-To: <20240618022334.1576056-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 18 Jun 2024 02:23:34 +0000 you wrote:
> mkdir /mnt/test/comp
> f2fs_io setflags compression /mnt/test/comp
> dd if=/dev/zero of=/mnt/test/comp/testfile bs=16k count=1
> truncate --size 13 /mnt/test/comp/testfile
> 
> In the above scenario, we can get a BUG_ON.
>  kernel BUG at fs/f2fs/segment.c:3589!
>  Call Trace:
>   do_write_page+0x78/0x390 [f2fs]
>   f2fs_outplace_write_data+0x62/0xb0 [f2fs]
>   f2fs_do_write_data_page+0x275/0x740 [f2fs]
>   f2fs_write_single_data_page+0x1dc/0x8f0 [f2fs]
>   f2fs_write_multi_pages+0x1e5/0xae0 [f2fs]
>   f2fs_write_cache_pages+0xab1/0xc60 [f2fs]
>   f2fs_write_data_pages+0x2d8/0x330 [f2fs]
>   do_writepages+0xcf/0x270
>   __writeback_single_inode+0x44/0x350
>   writeback_sb_inodes+0x242/0x530
>   __writeback_inodes_wb+0x54/0xf0
>   wb_writeback+0x192/0x310
>   wb_workfn+0x30d/0x400
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: assign CURSEG_ALL_DATA_ATGC if blkaddr is valid
    https://git.kernel.org/jaegeuk/f2fs/c/8cb1f4080dd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



