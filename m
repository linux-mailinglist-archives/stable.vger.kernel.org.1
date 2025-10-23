Return-Path: <stable+bounces-189125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6213CC01A93
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 16:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911C7188145E
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F96322C7D;
	Thu, 23 Oct 2025 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pm9Nidj9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357342C08D4;
	Thu, 23 Oct 2025 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228660; cv=none; b=MGNaRc1HXotYGx8wJH1jxUk7BOcBxPjmxDmmnlpIEebwJfR2uY2gWaGS83MPJQ1xEafI+exLGL/46ALzYFv7Bj2ws+o8AyM1XoJezfIqlsQqeZ0KwhxRDRl92Bqt53XTGM4cz/yb715HYeWtwViEK+45NNY0Z+z+39/yZGwtfFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228660; c=relaxed/simple;
	bh=eSprNQlHjgFzkbUuWVP7nIc8dN/p5jGa3oWGpzxaiY4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rYYys97xLvzav1lCmdNH9M9TR5lBGU8oPTq7KyJfXj6Ye7DZ2GOv1pT6wxI1WD6NVZczzVYiJYdveHThImEF49yi2IQxTYF2ge2pXtT8AGO8uNpY9W//0R6ToJ1YgiaojkXW05kx2b9/CMhWFFM7CwJg69YCt8XIJsghnbGxhBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pm9Nidj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D3EC4CEE7;
	Thu, 23 Oct 2025 14:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761228659;
	bh=eSprNQlHjgFzkbUuWVP7nIc8dN/p5jGa3oWGpzxaiY4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pm9Nidj91Fi+yfXRmJwj8wVZHIZgbjGDV/dfkC/8TMB7zQjnQsK/QBLjuLywtWCO6
	 CHgKqi1WU5SoGj8YT5OUK8PMHTVk+CLGMJZHxAOdBvZQtvbBpGmkLzHrT/a1ZANL0i
	 0/UaNjiQpxtjmWyDtN1WEmQIJHkl3oS1U9mK+ZcdKYyqKd+fxfBaklYcd4e1uF3TEN
	 mcSHv6NrgBmCCG1z6eJ3Le9cy0UCrLwNn1jjzRlAhT6fm8bbsJzP7f8mgK0/uMSgjC
	 p7BbZ664nbOkRTBkYuhZJwas3r0XzOJTTISoY6JqypseQ0WybHEvs9KP1NrCZOMyY9
	 ualZ8llezL7Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FA73809A96;
	Thu, 23 Oct 2025 14:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock: fix lock inversion in vsock_assign_transport()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176122864026.3096909.17516600367441031200.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 14:10:40 +0000
References: <20251021121718.137668-1-sgarzare@redhat.com>
In-Reply-To: <20251021121718.137668-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, kuba@kernel.org,
 virtualization@lists.linux.dev, mhal@rbox.co, edumazet@google.com,
 davem@davemloft.net, syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 Oct 2025 14:17:18 +0200 you wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> Syzbot reported a potential lock inversion deadlock between
> vsock_register_mutex and sk_lock-AF_VSOCK when vsock_linger() is called.
> 
> The issue was introduced by commit 687aa0c5581b ("vsock: Fix
> transport_* TOCTOU") which added vsock_register_mutex locking in
> vsock_assign_transport() around the transport->release() call, that can
> call vsock_linger(). vsock_assign_transport() can be called with sk_lock
> held. vsock_linger() calls sk_wait_event() that temporarily releases and
> re-acquires sk_lock. During this window, if another thread hold
> vsock_register_mutex while trying to acquire sk_lock, a circular
> dependency is created.
> 
> [...]

Here is the summary with links:
  - [net] vsock: fix lock inversion in vsock_assign_transport()
    https://git.kernel.org/netdev/net/c/f7c877e75352

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



