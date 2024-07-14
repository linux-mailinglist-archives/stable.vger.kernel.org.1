Return-Path: <stable+bounces-59248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C942B930A75
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 17:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F66F1F21244
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 15:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB70135A69;
	Sun, 14 Jul 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/IFeQ5w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D6E7F;
	Sun, 14 Jul 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720969833; cv=none; b=B8lAAhSnut8QR+JTU5sktVQhLkfLYFhoE5hRAQj7iFRx9BPu+hDebucwYceDgA+gnR6LwyUcgvKV0OERYNVBGeY0E+vbNO5SrvqNz/gHGoyiBNneM7ZP0JQxCb51LYQAUVy1pDHAP3mCNtDCByE8ndbmI5KYBgIEXGINqX/rVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720969833; c=relaxed/simple;
	bh=IhcjfhSEmxcqiCXRtARAcBH53uNMgBN3xs0S9hzuHv8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bf1q6PX+9oaHfMa8uggdpu6dHKAbPT7FrgmxdnZHW3o1PJ9bZlV5TuElmAdvV0mCwPbPr38SfvNg7dLVn1NRM2orzftHRoDc8F6VJ8ZMcxbiVhiSVTs4vIsceh/UUfPGUOxS4CupEuQvVRnMHo2BX994uQEHxvMMa6pPSDwgMMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/IFeQ5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78BF3C4AF09;
	Sun, 14 Jul 2024 15:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720969832;
	bh=IhcjfhSEmxcqiCXRtARAcBH53uNMgBN3xs0S9hzuHv8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u/IFeQ5warCKzMpc86K0DwMHV/BQtL9ljFsYpyOo3kOgN9A8eyvfSHBIvOh8xPdlA
	 zI44Q+iF5Py1ME/+T+90+OIsfbpnhGLEaUXXQqGbvVu90GNcmk24RzqX7uCdlkPmnu
	 a52Y4tdwQ6/khAbusgRD4Hw07hX2hG+oF0UCRGtc49x444Xpk2YQwoTzBSjEf2kd1y
	 3Wx6OMRq5NdwCxc0YB6zQIwl+fzXFhx/M5YcE/oxz4XsCNveciK83cxyYjAvliLM/a
	 xATQU/SzeZU2TeHQIlJHbDKxyR0FbWfJOiQZWf8lcxEuvQn/NjqsBkLJnM9jZlXLn1
	 N4z3aU9G1JtFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 588E2C43153;
	Sun, 14 Jul 2024 15:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: netconsole: Disable target before netpoll cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172096983235.15294.10308314035565228278.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jul 2024 15:10:32 +0000
References: <20240712143415.1141039-1-leitao@debian.org>
In-Reply-To: <20240712143415.1141039-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 kuba@kernel.org, bonbons@linux-vserver.org, mpm@selenic.com,
 thepacketgeek@gmail.com, riel@surriel.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jul 2024 07:34:15 -0700 you wrote:
> Currently, netconsole cleans up the netpoll structure before disabling
> the target. This approach can lead to race conditions, as message
> senders (write_ext_msg() and write_msg()) check if the target is
> enabled before using netpoll. The sender can validate that the target is
> enabled, but, the netpoll might be de-allocated already, causing
> undesired behaviours.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: netconsole: Disable target before netpoll cleanup
    https://git.kernel.org/netdev/net/c/97d9fba9a812

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



