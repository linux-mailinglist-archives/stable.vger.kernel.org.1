Return-Path: <stable+bounces-94686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E07389D69BA
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 16:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB05161742
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB593D0C5;
	Sat, 23 Nov 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAq553/b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C12F509;
	Sat, 23 Nov 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377029; cv=none; b=UfB+UT13Wq9sAcft+y8ZPb63k6h+p2JDMsy5QhqOGw9Q74NY0OZ+h6toNifOzhRH9WbfimApbyUuU6CVQZxfqlyEsFlKg5mSNG7aE+3V06xVtlgb9XL1E4XL9Fw1M8z7BHJ1n6uJ+Ec9Arnkvz48G1tIGXwK2A9Q+DsdQWWi+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377029; c=relaxed/simple;
	bh=Kv86vApSh+6VFnQQ6AgK+uFE5X9tBqt+QALJDvB113o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nAJW1tcjjoQB2T3fxmqVXBwQmVyZqxrACWbMSGq49ELHVWEu21fKTQ2ajd3zs7jY2+vW3/kpHsm/XJ9C8tWO9/Lr6Dw1xHdcN0N4/gfE5E+qiYR36noLhf+1vyBWz7dEpBMwSchZ1g4Qs4mYEfIYrcznPzh++2zwNGZbIQeJoCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAq553/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86518C4CED0;
	Sat, 23 Nov 2024 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732377028;
	bh=Kv86vApSh+6VFnQQ6AgK+uFE5X9tBqt+QALJDvB113o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bAq553/b7313j0r3Q7+1/MQugShfI+vjwcY7wP5mqr8rjeU1cMEFBoisr79zfw1jD
	 Pv86bsFXfsOtU7/kOeOzAadEVKV1PocMPrYyw4/kQz3lY6pUTJM0y1hWQ6Ox0ecWq9
	 FpHMofQVYu7pkctzGm5TMXImM7RzBiVDCFIx5VB+z5Tn6Qeocxq4gb66PAxNLRhMkX
	 tJaW2M1qhJtdZ9mjxHAEceD6C6pquBuPNCTHcBwBJcmwyNKXxDYmutw/YcznJxe1lR
	 VpkXur7nZJ44nLIee7fXCp5RL8ZCH8EyuIRyY7Eikyg0aD7ScpmOxXUIpKtU7o5ZD8
	 nZ9TAiO37URpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBF933809A06;
	Sat, 23 Nov 2024 15:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to drop all discards after creating
 snapshot on lvm device
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173237704074.3018181.13969811981387299887.git-patchwork-notify@kernel.org>
Date: Sat, 23 Nov 2024 15:50:40 +0000
References: <20241121141716.3018855-1-chao@kernel.org>
In-Reply-To: <20241121141716.3018855-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, piergiorgio.sartor@nexgo.de,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 21 Nov 2024 22:17:16 +0800 you wrote:
> Piergiorgio reported a bug in bugzilla as below:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 969 at fs/f2fs/segment.c:1330
> RIP: 0010:__submit_discard_cmd+0x27d/0x400 [f2fs]
> Call Trace:
>  __issue_discard_cmd+0x1ca/0x350 [f2fs]
>  issue_discard_thread+0x191/0x480 [f2fs]
>  kthread+0xcf/0x100
>  ret_from_fork+0x31/0x50
>  ret_from_fork_asm+0x1a/0x30
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to drop all discards after creating snapshot on lvm device
    https://git.kernel.org/jaegeuk/f2fs/c/bc8aeb04fd80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



