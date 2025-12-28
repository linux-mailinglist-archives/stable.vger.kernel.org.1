Return-Path: <stable+bounces-203439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0B3CE4A32
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 09:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72B06300E007
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 08:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7844261388;
	Sun, 28 Dec 2025 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0Qpc3Un"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C242A41;
	Sun, 28 Dec 2025 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766910894; cv=none; b=d9YoGuRG9jXGeQUFNEU3O28+7qd3UU7K9IrjuTJu1XybQrLwcVnhrS8Vezm92CdAy9vtJtMaH3HiW45fxNN+uyWvGgqmPiJBQtBjnSIYilm8GNQG9sAWtrQmLqhNJ+bAjqqLOdpShsvfiWOUYT5+wTKApXCJhce6NkpDo/vB+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766910894; c=relaxed/simple;
	bh=unQKj4ioHFI6iMRSCKjeqOtn1wbeNZwYsfB+npBKFhw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jFG6M+52w4TqSHvm5io3w1Vs3KsLiP9L9ofbS7OpEL3WDcE2t3TRm8cN2uHJZHOR6NJQduO+6mhV4pPQ4KxjiT/sNigkUfgICfcRUVvqz85RJBpRETvTjH7kign8wKufAsxgcEX1EV6EEWu6qJQkXNX4Nsn2Ci6IHP6EfC/k7sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0Qpc3Un; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F600C4CEFB;
	Sun, 28 Dec 2025 08:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766910894;
	bh=unQKj4ioHFI6iMRSCKjeqOtn1wbeNZwYsfB+npBKFhw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P0Qpc3UnexqGQdPqr2PnY1+gGGyH8GOlePyes7abTkzygdSLrwACcEiziVYC5XO/4
	 33JyaVylz2PGU7RX4DLgT8Tbb04mIVjBEcxSuVxkW76xbl8G4jojiBFszDEWdG78qm
	 aeiRgJMwC/fRfpmn360c/CJmz0/gM5tlPrHD/WTfzHmyvLqIzRkd/HBGQCsFxs2yR+
	 bAHq/vpqiEBEnNN5AY8MvgyqsRYCdsucCCwWCaEM9j/3pfoHRex1IqDH3RjCJ/wFtj
	 fzfB02B9qPUjH8345jQXlMOiUmuIed0p/uHhA/6z6oZhkq2RhYztP+kkPRMV03MgYj
	 sT2HHs237skkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B63E53AB0926;
	Sun, 28 Dec 2025 08:31:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: nfc: fix deadlock between nfc_unregister_device
 and
 rfkill_fop_write
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176691069757.2288022.17005700112119385808.git-patchwork-notify@kernel.org>
Date: Sun, 28 Dec 2025 08:31:37 +0000
References: <20251218012355.279940-1-kartikey406@gmail.com>
In-Reply-To: <20251218012355.279940-1-kartikey406@gmail.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, linma@zju.edu.cn,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+4ef89409a235d804c6c2@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 18 Dec 2025 06:53:54 +0530 you wrote:
> A deadlock can occur between nfc_unregister_device() and rfkill_fop_write()
> due to lock ordering inversion between device_lock and rfkill_global_mutex.
> 
> The problematic lock order is:
> 
> Thread A (rfkill_fop_write):
>   rfkill_fop_write()
>     mutex_lock(&rfkill_global_mutex)
>       rfkill_set_block()
>         nfc_rfkill_set_block()
>           nfc_dev_down()
>             device_lock(&dev->dev)    <- waits for device_lock
> 
> [...]

Here is the summary with links:
  - [v2] net: nfc: fix deadlock between nfc_unregister_device and rfkill_fop_write
    https://git.kernel.org/netdev/net/c/1ab526d97a57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



