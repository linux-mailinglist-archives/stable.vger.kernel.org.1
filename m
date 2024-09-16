Return-Path: <stable+bounces-76537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47F997A8C9
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 23:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB63C1C24519
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 21:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E02168483;
	Mon, 16 Sep 2024 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYb3rr07"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF86166F25;
	Mon, 16 Sep 2024 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726522234; cv=none; b=R/ItKDRFo8oH8VfnAzuQH/gshHYLTQfChAU+EazeYlW6TGDR91vYXA+My/mxH/o7eLc4o3AE2Nc2pJGPXiskhT+OxvDKvduiPPHSrRiktzEHU99KAjlRD0ZS0IVXp2GVXp0al5AYoXUpeBv4n4udglQy9gfxunBP3N4znWZ8dJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726522234; c=relaxed/simple;
	bh=IElyhfDN78o1mbiZffXzf72XiMjmhYBD9pCERzxZN2k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QtYkhYjPZLed8GrdVbHzyXrYno86W1GPnwyIPdnWrgvKfvuFnxVlus6tvfahinCS2rnBu8/brzPk2u2GdPW57jM3/qIbaIpAV8CKrgIGK56wNtXI97SZPpoQiG+YC7I+GS45AHS3QRi600oUmOT1nHFehqCccohN11NvvYstiik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYb3rr07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65305C4CEC4;
	Mon, 16 Sep 2024 21:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726522234;
	bh=IElyhfDN78o1mbiZffXzf72XiMjmhYBD9pCERzxZN2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DYb3rr07d3TzvsfgyI2elKTpoFP6pbCGOMlLQKhlrxN2ftizIJfSl/sr6u1fbA61w
	 k2thi76x3XeAJ83fkewk0TldXZMNgdcOBuuthxn8Fn+kXgSWcz65zhfp7GI7nwRIFL
	 KBGS/shaY2fGFe/xmjQCw89OZrTjCTufGkC4O8DgLVi7ygaVd3pwnKOvS9bQ6obpcS
	 hnNbTQwotXnKro6caW7UaXPIaIOMW+7n6g7rNm9HNXPTNR68bPQw9T3zMP/KkOAJs0
	 jnY9bqvdS4pdbAKX8ztitne6YvxZLV6bu+F0WCpobhj3avXBF+sCHCEoMCc4/YJX89
	 c5SDC35Q/M1YA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E853806644;
	Mon, 16 Sep 2024 21:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check atomic_file in f2fs ioctl
 interfaces
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172652223599.3820990.7788824828027829337.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 21:30:35 +0000
References: <20240904032047.1264706-1-chao@kernel.org>
In-Reply-To: <20240904032047.1264706-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  4 Sep 2024 11:20:47 +0800 you wrote:
> Some f2fs ioctl interfaces like f2fs_ioc_set_pin_file(),
> f2fs_move_file_range(), and f2fs_defragment_range() missed to
> check atomic_write status, which may cause potential race issue,
> fix it.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to check atomic_file in f2fs ioctl interfaces
    https://git.kernel.org/jaegeuk/f2fs/c/bfe5c0265426

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



