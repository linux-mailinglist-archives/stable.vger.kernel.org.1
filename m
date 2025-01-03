Return-Path: <stable+bounces-106673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD760A002E1
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 03:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 492B37A03B4
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 02:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7E9199223;
	Fri,  3 Jan 2025 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0w75b79"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEFFA47;
	Fri,  3 Jan 2025 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735872618; cv=none; b=cYoDTSkrA07t4m9TNGi7TX6S55TlONVjPjZBFUqYvKzC/jSEJ4O/mGa5qWxfEl+842WpONmprrzSa8KONns6TDRA/yhvXdcqH8xWEEAVmcaAnH0P4noyM/NF3xTZ4ByXneRnm4icy4MT9aAD3enUMZ3rhrs9JTsFkpUKuDYjJHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735872618; c=relaxed/simple;
	bh=EpqeTAKnKBOlOLZyIFj5hBNbt83/nCCAOatv4ujyfng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TLYnxtmM/lTxs++VMEGc9UZsCUC4vQvdreTG4G+Y2ohrx/hwfCLgt3NHd2pf535NDBO2JV/uRbD7T65cjCWxAEbLJ7NVCyHUkHIrO5BtD5Y47CcL67anNCK+v5ONq+BmxXWO8V5ogk6S0U/Rhade1WYA3qpxy3oD3K3O3Z7FkG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0w75b79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE674C4CED1;
	Fri,  3 Jan 2025 02:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735872616;
	bh=EpqeTAKnKBOlOLZyIFj5hBNbt83/nCCAOatv4ujyfng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E0w75b79oZwKxpVuSlqXSLRd9+K/Ve+GUgyLbvp67FHNPzc3dCokNgUxoPOSfOn0W
	 iizP7CTjQSJAsVllsXxox09Gn/hiDetV+x964QG3j48eo4aYaUxgQSUdS2I2Eaw86H
	 VYVDlxRqmCQwSG2ibPMgYpAPKzlDTYZKJRlCbAFxWG79bIfK1ADKx2fIQ2O09f6My+
	 YIzxvd2hx/x8yK5JM+MwMviwhgvBwC0eOzKkVxDlFmn9ZfmjfOrWFwWCDScY2oiTFL
	 AXA2HCTFU0Ay9tocHaNjlI5ZJqZ0OwyZ/6u9sAbqj4+jsFZeOspq/YQVG5XRBSE4Dj
	 aNH9eCczlTbnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71D46380A964;
	Fri,  3 Jan 2025 02:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mptcp: rx path fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173587263701.2091902.3534187243855965377.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jan 2025 02:50:37 +0000
References: <20241230-net-mptcp-rbuf-fixes-v1-0-8608af434ceb@kernel.org>
In-Reply-To: <20241230-net-mptcp-rbuf-fixes-v1-0-8608af434ceb@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Dec 2024 19:12:29 +0100 you wrote:
> Here are 3 different fixes, all related to the MPTCP receive buffer:
> 
> - Patch 1: fix receive buffer space when recvmsg() blocks after
>   receiving some data. For a fix introduced in v6.12, backported to
>   v6.1.
> 
> - Patch 2: mptcp_cleanup_rbuf() can be called when no data has been
>   copied. For 5.11.
> 
> [...]

Here is the summary with links:
  - [net,1/3] mptcp: fix recvbuffer adjust on sleeping rcvmsg
    https://git.kernel.org/netdev/net/c/449e6912a252
  - [net,2/3] mptcp: don't always assume copied data in mptcp_cleanup_rbuf()
    https://git.kernel.org/netdev/net/c/551844f26da2
  - [net,3/3] mptcp: prevent excessive coalescing on receive
    https://git.kernel.org/netdev/net/c/56b824eb49d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



