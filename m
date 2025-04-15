Return-Path: <stable+bounces-132778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 956FFA8A928
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 22:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7EB6443B2E
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 20:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5BA253F2D;
	Tue, 15 Apr 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmBN7F5G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F379C253953;
	Tue, 15 Apr 2025 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744748404; cv=none; b=I2uJOTTQ3jn9Ag1LhbLlYYdkZiunjc1sFOfWT/Kc2RNB6vSt4DQNvrvGNfswpDmyO6GnwUPBLKFGzqRzKYfGwGDUM/sig+dyWxEtXan6DNmBsWoPzLu+WJWlW4vDOHJAaPM8Vx6ZLOfqKhOZgjaSVLsBewGu3i0W7BbrzlqK0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744748404; c=relaxed/simple;
	bh=H/mwFscNKxTzp64073SlN38yog7H6RCLy6Q0Ea84jIU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JD/CS3CoOg0btmmTUa5VMzCkk5RiYrxPy/OmhUcC8ybhPNUhRiDHxFhiz9hvhirmWUZ9QTdXVt+fMQzsPQv6oC5Y37y8mdzrtA0dm+Pq4teAN41gV7y87kvfxCpLdltS2IMUtOZdvBZiVJgxy0lT4rM+C8TjosnnBvnsc5SBF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmBN7F5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758C8C4CEEB;
	Tue, 15 Apr 2025 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744748403;
	bh=H/mwFscNKxTzp64073SlN38yog7H6RCLy6Q0Ea84jIU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HmBN7F5GfTrPc17PRr66JnIBBDGuNXuRJG2wndYiwM15lcjTJFWb0fbSJXa14fHhT
	 fAXBHDqAx4w4+eOxQZcSjvFkLdIy4grs5CGoVH/Chazh4ncwBkYaNgnuf520q0OteZ
	 0ogR5z2mW7mYn7G6B+8duY5OMFm+2QSMDD2DlgJxfOgKpJ0JMehg6fw4xnl36DecUx
	 fDjdzMTXfUJJ0pcF7W+nmQtFCWxE3tnxuBESXzS/6lpQ+msP2EtQzvbatua1LlZhZj
	 Lci6MQebD4P9lpU0U0dEXtHH+lqwaJHLiVzvKdbkXHEScvxdnItF8gonOMvOc35RE6
	 9O9s7aB5cLnRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB73822D55;
	Tue, 15 Apr 2025 20:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: vhci: Avoid needless snprintf() calls
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174474844125.2765712.8238252106715217698.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 20:20:41 +0000
References: <20250415161518.work.889-kees@kernel.org>
In-Reply-To: <20250415161518.work.889-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: stable@vger.kernel.org, lkp@intel.com, marcel@holtmann.org,
 luiz.dentz@gmail.com, jpoimboe@kernel.org, nathan@kernel.org,
 peterz@infradead.org, linux-bluetooth@vger.kernel.org, morbo@google.com,
 justinstitt@google.com, mmandlik@google.com, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Apr 2025 09:15:19 -0700 you wrote:
> Avoid double-copying of string literals. Use a "const char *" for each
> string instead of copying from .rodata into stack and then into the skb.
> We can go directly from .rodata to the skb.
> 
> This also works around a Clang bug (that has since been fixed[1]).
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401250927.1poZERd6-lkp@intel.com/
> Fixes: ab4e4380d4e1 ("Bluetooth: Add vhci devcoredump support")
> Link: https://github.com/llvm/llvm-project/commit/ea2e66aa8b6e363b89df66dc44275a0d7ecd70ce [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>
> 
> [...]

Here is the summary with links:
  - Bluetooth: vhci: Avoid needless snprintf() calls
    https://git.kernel.org/bluetooth/bluetooth-next/c/3b32759328e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



