Return-Path: <stable+bounces-110921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1C7A20200
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 01:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22103A34E3
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 00:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E09C1EEA30;
	Tue, 28 Jan 2025 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2cGadj8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B01EC01C;
	Tue, 28 Jan 2025 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022419; cv=none; b=M9W3EBFIqcChO5e8IMyNHvUfF2yX7j685Q4lCr1u/jkEqUDNuYQ8k+8qcOW75eM/Rn/gsG9wnhySJrpt/MvC6APvThnEV8PgfSoTW3jYYjaZHYYYPRtTaMOngJGREbgQe0YRJZrzDzTPMdBSjUEBcC9AtNjVAaCSc7IyTk5BJPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022419; c=relaxed/simple;
	bh=lj1jgYvL+AgAz7IHaOILOI39sZLkuiuGmn0PkWh0qag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i+NxplG9ztB9yie60bEWYEQhnrNrtR/H5EKI1DlXIzEsbnxolJZ6sABI+x1xF8JPY1z1APCYI1f+Xfy5sZA0Ej7e3r/2cUNziIvLUtWGCGjANlEyCkdX4gAgmsP8Vhukt4oHDk5V3OmKevX8cdNXtdqHscR7UQ9IXd+ueTSxXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2cGadj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C85C4CED2;
	Tue, 28 Jan 2025 00:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738022417;
	bh=lj1jgYvL+AgAz7IHaOILOI39sZLkuiuGmn0PkWh0qag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a2cGadj8FdAK2QJJ+WySSK2IC7r9XOzrWK8vX6X7/zFuF5i5dxv1TKZ/QrDu70OzK
	 zLDkoIgmYp6lXFGpz6I7Rq8aTEvi2V2ht4XXP6OffaRjfUGdq3Jj0hpTfePrgr4sOr
	 jKnKOmS+XJsB/5UWAD4MDtuMcm/OJn0tcScOH+RenYVFyGG2MiuU5C7PlO4TpNWaTV
	 /QqKETXRk+pzII/IZafevrxJCARkX4mPDvEyo69RsjM3dJl8tqFmelYWrGFEYFsxIb
	 h+gNR4lIzhTPQokQVIGI2FP+tIl5Z0HixAalfnjvzfX1dCiSX0fd3N4RRtGgJgXLJy
	 V4OPSa2RrJ/Jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C7E380AA63;
	Tue, 28 Jan 2025 00:00:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mptcp: fixes addressing syzbot reports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173802244325.3265158.7038381042936906837.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jan 2025 00:00:43 +0000
References: <20250123-net-mptcp-syzbot-issues-v1-0-af73258a726f@kernel.org>
In-Reply-To: <20250123-net-mptcp-syzbot-issues-v1-0-af73258a726f@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 syzbot+23728c2df58b3bd175ad@syzkaller.appspotmail.com,
 syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com,
 syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Jan 2025 19:05:53 +0100 you wrote:
> Recently, a few issues linked to MPTCP have been reported by syzbot. All
> the remaining ones are addressed in this series.
> 
> - Patch 1: Address "KMSAN: uninit-value in mptcp_incoming_options (2)".
>   A fix for v5.11.
> 
> - Patch 2: Address "WARNING in mptcp_pm_nl_set_flags (2)". A fix for
>   v5.18.
> 
> [...]

Here is the summary with links:
  - [net,1/3] mptcp: consolidate suboption status
    https://git.kernel.org/netdev/net/c/c86b000782da
  - [net,2/3] mptcp: pm: only set fullmesh for subflow endp
    https://git.kernel.org/netdev/net/c/1bb0d1348546
  - [net,3/3] mptcp: handle fastopen disconnect correctly
    https://git.kernel.org/netdev/net/c/619af16b3b57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



