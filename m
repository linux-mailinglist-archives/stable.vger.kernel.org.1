Return-Path: <stable+bounces-35619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624E5895921
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 18:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D0428F310
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 16:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DDB13329D;
	Tue,  2 Apr 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQacvV0G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0798134BE;
	Tue,  2 Apr 2024 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073694; cv=none; b=JhVqDE6aOv5bK3+EYiY1JXG7crXOBNqjx0K6qJcXLtRp2fd7YMPPbH76pVmAQChafEiEV2Hm7pTHqasKLHq90hODGbxXm8VeQQFBY9eSZMunU1GkVVt939ZrnOW5vvtsM+7q3U2btkVDYkUZUffLJG9GpVN/9E15FmvAkTTVd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073694; c=relaxed/simple;
	bh=0q8JNj03RO1bowqfHPzaZnTUaz8dx0ZxbwFogRfGt1M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ETi1wh0yW/vkWXS+mTbDl3NyqyB7/Lgvg6A74a0DR6ymJh8Zp5tu1TDxa9wwUGIWIr9qCJ0TOiyobq/DF7ZsUHiG5wkP1UwOGZmHRp1Rq81HqYOW3bdWCwfz2ZhEnutbLF9zC66qC1w63wTZ5UEaGfityi7IPQYgkH7p+Ojxc20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQacvV0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFE6AC433F1;
	Tue,  2 Apr 2024 16:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712073693;
	bh=0q8JNj03RO1bowqfHPzaZnTUaz8dx0ZxbwFogRfGt1M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aQacvV0G+OhRzC8z4HX1dsD2z7D+fNJkWLGHczj4FsxKG/oUvdlsB0xZVvsYzSwPH
	 oI2Se5Vk1OcFStl6Z2HRWJe5DDxRVn+PgHg2U9HmuObz15reNzoJNChuKC8t42z3qh
	 R+ESDeGCb9aS4zDxr8GY1nYom8C0pxqOnHgaAw3goLMiMJU1joSJwckaYNE1aVzMhN
	 EbhVoDRHIwA6Nlyrt5P83q1ieC00fb8tPczV/Up5cPzMI2WR55/W116oc7WBfJpypg
	 UVaApXWvfk6paPZKcHUUZT4HjbjVIdwCRFup1ygMqs3tb+OMC2iBoK+nF7Lf4mOas8
	 De6y7bbODJ43A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D2D7D9A14F;
	Tue,  2 Apr 2024 16:01:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: fix memory leak in hci_req_sync_complete()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171207369363.10776.3107408338305294242.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 16:01:33 +0000
References: <20240402113205.7260-1-dmantipov@yandex.ru>
In-Reply-To: <20240402113205.7260-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  2 Apr 2024 14:32:05 +0300 you wrote:
> In 'hci_req_sync_complete()', always free the previous sync
> request state before assigning reference to a new one.
> 
> Reported-by: syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=39ec16ff6cc18b1d066d
> Cc: stable@vger.kernel.org
> Fixes: f60cb30579d3 ("Bluetooth: Convert hci_req_sync family of function to new request API")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> 
> [...]

Here is the summary with links:
  - Bluetooth: fix memory leak in hci_req_sync_complete()
    https://git.kernel.org/bluetooth/bluetooth-next/c/4d0d849bc5fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



