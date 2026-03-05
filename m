Return-Path: <stable+bounces-223167-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKw4KTvtqGnnygAAu9opvQ
	(envelope-from <stable+bounces-223167-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 03:40:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9E920A445
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 03:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CC0C3034A3F
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 02:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED6C267B07;
	Thu,  5 Mar 2026 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biClM33R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8B9265606;
	Thu,  5 Mar 2026 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772678430; cv=none; b=KyKV00aEwDhCLgNejhcbVB2AC4La7hVURfkMwbuwUfYCWxC45faFkoeEsFFmUMtRJvnULnuqPt6Hs/mmWlGmSy5fw/gDKqQxkV0Eq3HoEUoAuP9BMHIWOAr7tiVpUh446dwMcsT6ISkflpIZv4nWx9QHG0hHzpU8clq7MYCWZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772678430; c=relaxed/simple;
	bh=nl0dpc9m3TCYaVW1rx0nWk4+O3u2mDH42AihvgONVkQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qZxHvixy4565OzCLqLAcMTQWV71qSIXTvWYcHbKnszVJbbGcYUU0FnwhOwONEXU8+yuEegYAe5oax0FNpz6Dj0+JJvehIvDRHtXU7L4YmkL5f9lo3rJdkFxA7Fd7AE0SM5FSKiCzmWPzj1ewI0PAc1zGoxaAE1+Q7MhNRd6E+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biClM33R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC70C2BC86;
	Thu,  5 Mar 2026 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772678430;
	bh=nl0dpc9m3TCYaVW1rx0nWk4+O3u2mDH42AihvgONVkQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=biClM33RByMZAAvt5U5RBOE6tmb+6LBUDw0SFlzfjrbuuu811p7PgOBQH+2qo2RTu
	 +6RUcAw9lIg207TLb+9m3zBo2VCekuMYA/0CBcSWDlGmOuohY3SzouHDIlBPw5OkrN
	 FVAUsg+kPyar4Tw6EoP+B69+hDBN++YJfSkU/1LtZyRuQiBxayh55ACclsY2aFHfH8
	 g7/mXV8C/ZUGMaU1aLYbVOhXN71fGnCvKFyRDdgJrVZHhXtKwEI1GFKEH2TjsV6nou
	 FoHs9sALZZQBvpD6kDtT+vTyJFV12dHvxRQQ91F04Nf3gM00CUtW0EQP8b0LnJ2Q8h
	 H5A164ftZ8sjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE973808200;
	Thu,  5 Mar 2026 02:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mptcp: misc fixes for v7.0-rc2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267843079.2487871.6512624751988502884.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 02:40:30 +0000
References: 
 <20260303-net-mptcp-misc-fixes-7-0-rc2-v1-0-4b5462b6f016@kernel.org>
In-Reply-To: 
 <20260303-net-mptcp-misc-fixes-7-0-rc2-v1-0-4b5462b6f016@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, lorenz-frank@web.de
X-Rspamd-Queue-Id: 1E9E920A445
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.linux.dev,web.de];
	TAGGED_FROM(0.00)[bounces-223167-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 03 Mar 2026 11:56:01 +0100 you wrote:
> Here are various unrelated fixes:
> 
> - Patch 1: avoid bufferbloat in simult_flows selftest which can cause
>   instabilities. A fix for v5.10.
> 
> - Patches 2-3: reduce RM_ADDR lost by not sending it over the same
>   subflow as the one being removed, if possible. A fix for v5.13.
> 
> [...]

Here is the summary with links:
  - [net,1/5] selftests: mptcp: more stable simult_flows tests
    https://git.kernel.org/netdev/net/c/8c09412e584d
  - [net,2/5] mptcp: pm: avoid sending RM_ADDR over same subflow
    https://git.kernel.org/netdev/net/c/fb8d0bccb221
  - [net,3/5] selftests: mptcp: join: check RM_ADDR not sent over same subflow
    https://git.kernel.org/netdev/net/c/560edd99b5f5
  - [net,4/5] mptcp: pm: in-kernel: always mark signal+subflow endp as used
    https://git.kernel.org/netdev/net/c/579a752464a6
  - [net,5/5] selftests: mptcp: join: check removing signal+subflow endp
    https://git.kernel.org/netdev/net/c/1777f349ff41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



