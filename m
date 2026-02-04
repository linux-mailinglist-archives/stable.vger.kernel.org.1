Return-Path: <stable+bounces-213345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPgULffBgmkpaAMAu9opvQ
	(envelope-from <stable+bounces-213345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 04:50:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27804E15DC
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 04:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 191373009F38
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 03:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD64E2DD5F6;
	Wed,  4 Feb 2026 03:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hS+MUSTk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC21917FB;
	Wed,  4 Feb 2026 03:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770177012; cv=none; b=Zdg28yhqPJjNJeclPRWojV/c1K9718mc27MmeDgOK3J+1vBZrt0888WdQABQPxxgB/+VYvJVcaYJ77y02hk1q7PQjm5F/qg5abA8agcccr1PsqM4NOki0layJUtOuN7Dp0nfqPX6fXbIBtSnK8HEwCI3x+/E1gRtKPI3tc4v21U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770177012; c=relaxed/simple;
	bh=F881s/HcZPPA3MDOn35fKUDgS/Sq6HTcN1aWKD6ueSw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ebQMeBIH6eZvFM37teqM65y/KqSOxdleZ3/8st0CYCXmF2Z7Gn2Qc0nWLxU8vc/sPeI6fleX6hiaAxsAj3+VsGG8ax1GwxtpeM8kpTl57/PCEQ0k04aYgkztpJb7R7vsOiuTxQlPuUu3zMCyA7DEFyZVTLzoby888xPRWzw26tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hS+MUSTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A697C116C6;
	Wed,  4 Feb 2026 03:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770177012;
	bh=F881s/HcZPPA3MDOn35fKUDgS/Sq6HTcN1aWKD6ueSw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hS+MUSTk4xBRDZekGN9tEtQ3DibVoZAYvmLFzZHwAsZUfqIm8bzDB1UZNbuS34QRt
	 VD2MPEb0Y+l83eBPS0gq6arX9P2gyFzMGIbR6sCiIjV0Uz9b+y5jQeM/fsDAbdw8Gb
	 fVoEhHBgfzgzxcT09xAUzqSradFasVus9om/sPOcr2NPk7HkRUQmSvXBDN8NKIS+6y
	 W0VPsnX/woWEmVFJA/C0Tz6ZthnLznKXagunRgHHitHyrJx5qlCApfx+7k9lG6B4CZ
	 J7EhgINFX85XeK6R2ViIP/RtucsGDtpNTHxAu8f9ntk4yJUmQp5COCvx6VXHYqoHe1
	 6XLe/UNkYImYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 90E5E3808200;
	Wed,  4 Feb 2026 03:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/2] net: cpsw: Execute ndo_set_rx_mode callback in
 a work queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177017700837.2171580.14465132231115373061.git-patchwork-notify@kernel.org>
Date: Wed, 04 Feb 2026 03:50:08 +0000
References: <20260203-bbb-v5-0-ea0ea217a85c@gmail.com>
In-Reply-To: <20260203-bbb-v5-0-ea0ea217a85c@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, s-vadapalli@ti.com,
 rogerq@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladimir.oltean@nxp.com, kuniyu@google.com, linux-omap@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-213345-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27804E15DC
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 03 Feb 2026 10:18:29 +0800 you wrote:
> These two patches resolve an RTNL assertion call trace issue in both the legacy
> and new cpsw drivers.
> 
> Thanks,
> Kevin
> 
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] net: cpsw_new: Execute ndo_set_rx_mode callback in a work queue
    https://git.kernel.org/netdev/net/c/c0b5dc73a38f
  - [net,v5,2/2] net: cpsw: Execute ndo_set_rx_mode callback in a work queue
    https://git.kernel.org/netdev/net/c/0b8c878d1173

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



