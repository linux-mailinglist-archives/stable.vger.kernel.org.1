Return-Path: <stable+bounces-210652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMZkB2Y9cGnXXAAAu9opvQ
	(envelope-from <stable+bounces-210652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:43:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6424FF9F
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 132893AF9A8
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E614C34AB18;
	Wed, 21 Jan 2026 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkshXmvI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F446348445;
	Wed, 21 Jan 2026 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963223; cv=none; b=VgGYAVTy2bf7M5GMYjgBLQgV1LlaYDbXZbPhZDePYyZGle5pLJFGbS2EgRem/LCma3ISC1on6k1R2CX5KJ74a3pLvq37f5+dK53e8BjhKZNqWDgwVxGVUToFvxT81I55AoUaWhClSAfSkcdB+x5iR1XMKwZY662SZr6KSEMUGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963223; c=relaxed/simple;
	bh=+kKuvKZBAVpGffavCyJG72uGSUe/JaL1MpWlhAU2I8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UhsIQwOjle2+BY4810Q1LiNpDhGCXwoGvzgXju48z4i8YTWsl1F9lflBlo2y9j/0zEu8+4cujWbo46KyJu0md57woX7FiQuY8rZXxvJMAAtlmxbfnbIcd1YOqByoFJgNHkrtSH4FUIgzVxgSJ4VRswg8BNWMnp+hZiRPjSEKhR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkshXmvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32492C16AAE;
	Wed, 21 Jan 2026 02:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963223;
	bh=+kKuvKZBAVpGffavCyJG72uGSUe/JaL1MpWlhAU2I8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JkshXmvIGEVVusGEnf9mIMBAaZVfNSVSqjnFNLH6cWUnNWIGKYim0c+KSlLAXF9KR
	 DBVKBzfAt1HJEHSM6qKfsrar+OFytHQPEaOefVTbMJqH7Nvvyvzv0AAAEmCaHrAUjG
	 mKU6JhDqeeVyUQzvzilKimtvVUQdfBP46S3SZjPmx/nHr2tfYdswwmsaS2Xee/3N7I
	 Ojj2gsA5rPNDcpCv4ZZLkWM+Su5R0YRLZ+cnNnsmNJgSs0vxYXb3MazCg4W1EPSzsC
	 88TqmJrti05ixwEQI4cp6t4wXCHYDZ+OaF7hRHsFDjYexHz6UzeAaF3n4eRxjIchGa
	 y3Bj0w8kR2xIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8D1E380820D;
	Wed, 21 Jan 2026 02:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: txgbe: remove the redundant data return in SW-FW
 mailbox
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896322035.699622.2790684243723717712.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:40:20 +0000
References: <2914AB0BC6158DDA+20260119065935.6015-1-jiawenwu@trustnetic.com>
In-Reply-To: <2914AB0BC6158DDA+20260119065935.6015-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mengyuanlou@net-swift.com, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210652-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: EE6424FF9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 14:59:35 +0800 you wrote:
> For these two firmware mailbox commands, in txgbe_test_hostif() and
> txgbe_set_phy_link_hostif(), there is no need to read data from the
> buffer.
> 
> Under the current setting, OEM firmware will cause the driver to fail to
> probe. Because OEM firmware returns more link information, with a larger
> OEM structure txgbe_hic_ephy_getlink. However, the current driver does
> not support the OEM function. So just fix it in the way that does not
> involve reading the returned data.
> 
> [...]

Here is the summary with links:
  - [net] net: txgbe: remove the redundant data return in SW-FW mailbox
    https://git.kernel.org/netdev/net/c/3d778e65b4f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



