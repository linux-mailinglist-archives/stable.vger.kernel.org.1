Return-Path: <stable+bounces-224633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L3UJKrRsGmLnQIAu9opvQ
	(envelope-from <stable+bounces-224633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:21:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E44525AE55
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ED15301FA96
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF743446C8;
	Wed, 11 Mar 2026 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImYsyXdq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64E342530;
	Wed, 11 Mar 2026 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195610; cv=none; b=E+LYRWUXs3GxTT4J82oc1sBiV/w2dkllhuW4L1vN/c3EhDShG1cW8K5QNxUuXGDX394PhnQ7sUEoyQLY52eJPC+g6aMC50ESCYvr0auM9MHBRwOutT7anWp4DD5BH5uq1MBVdfCrBSU+gt8KnGKN3FU3whsHNDJIYuVNzxHnclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195610; c=relaxed/simple;
	bh=Iimmj9XHp7xTZhtz4FMjqfdgV3OL+64EL64CL4WWt3w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sLg1KOwhsXhKyoaepe39J4XFa9M0swpO2n67L4Ok9iggQ8zbvF3NCAbjcnUleYbnFTCRYO1qRsjAf6hdp13IYbKPAod6jKsCGl2SbGhYHWNrA/M8Ya756MgaOmcUgI+BNxEZOQ4lf9SwmCFfDyDKQAGi5RwR0ljudJdyo+Pwr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImYsyXdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0776FC19423;
	Wed, 11 Mar 2026 02:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773195610;
	bh=Iimmj9XHp7xTZhtz4FMjqfdgV3OL+64EL64CL4WWt3w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ImYsyXdqfrH6ALcPPsykzOFftUJTkO42s3Vlo2ZuMjwdb9gBQI3FYL0RCUFDJaRoe
	 cSn+EDXAwx8npBxrAduklMxay11DliE6xEDBlS5e2RpKHuG4mH+P6H2r39mbzYdeRx
	 8ZwZ1MODa8BAegwYIL4CpZhIKk4E7uLu3eNxe/PA/387uA0MppBA2AjLUF1EAaFWq0
	 OJgCI9/OOTvmqAT9QNBCYFFqw1E6J36lxI6OUk+mLcBFLMeQAVTyD/DrmVOncvqjov
	 JoVWSKZN3jsd9HNaEG5LvyGQUEPW3dpueTioZtyTEmr6fjSEqpM5JpJtOSIG75rhlf
	 D3WVBnihrg4iQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0793808200;
	Wed, 11 Mar 2026 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: ethernet: arc: emac: quiesce interrupts
 before
 requesting IRQ
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319560655.3008927.17970986810014027433.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 02:20:06 +0000
References: <20260309132409.584966-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260309132409.584966-1-fanwu01@zju.edu.cn>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 stable@vger.kernel.org
X-Rspamd-Queue-Id: 4E44525AE55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224633-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Mar 2026 13:24:09 +0000 you wrote:
> Normal RX/TX interrupts are enabled later, in arc_emac_open(), so probe
> should not see interrupt delivery in the usual case. However, hardware may
> still present stale or latched interrupt status left by firmware or the
> bootloader.
> 
> If probe later unwinds after devm_request_irq() has installed the handler,
> such a stale interrupt can still reach arc_emac_intr() during teardown and
> race with release of the associated net_device.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: ethernet: arc: emac: quiesce interrupts before requesting IRQ
    https://git.kernel.org/netdev/net/c/2503d08f8a2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



