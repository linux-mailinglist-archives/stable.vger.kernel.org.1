Return-Path: <stable+bounces-247303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB2+KIN2BmoUkAIAu9opvQ
	(envelope-from <stable+bounces-247303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 03:27:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2A5548665
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 03:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9DCA308B782
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 01:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E492D367F45;
	Fri, 15 May 2026 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUTpASeC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736E1DE8BE;
	Fri, 15 May 2026 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808061; cv=none; b=G2lZKXujiC47kpaOWE4vdtEqfuiC1Kd030l8W23BwLIO7X3EU5n1baMKctxvyWBOswUHNiFmIYeG5vjznM6wYnqQHn9tdPrqXgRbUEwuOtrckWMZWB/7ynRHHlRhsKpF0suVWK4u7pR5x+OcQ6AMHgDGEchxAuPCOX08MqYu3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808061; c=relaxed/simple;
	bh=vixR+NcNe3DosSISesGP9v3e0AqCPZv9q5Th9ASWfC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P5peLzr5vJBjU86d41LPTpUHC5J/FZ1j3anQmnPzRjsRrj/uRhFsu5ydqWjNlMREa3XCbw/dvcPJrpRchlySPvzSXJ6hcKgG3qLW9IPbY+7fXdaazelLd/duGjCmozcMvARcxBbblOYe9az1NU4LkHIiuORY0J1GSvGn7kfQv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUTpASeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482E9C2BCB3;
	Fri, 15 May 2026 01:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808061;
	bh=vixR+NcNe3DosSISesGP9v3e0AqCPZv9q5Th9ASWfC4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GUTpASeCy85j9QmtLDbNJvg+Zwp/jHaV34/QCK54QsoOTcfTrTIiW7cyCh40dIrMT
	 YgbxW2rynyDWCoYMqFw20PyNM9f9SHrm4QKGZQVBkKLggv1mt9zv/o66JHlCMWuX55
	 j57xsJvPWF7Qp3byv8e529tQggybbZGETCIvQa56Qsw1cONuf158P6I8PcUax5bmPB
	 vq/xsnLESvZ4hXTr5BSfXt8BPaAj6ivlfLDIaLLLiqyhk8rQfF6gttHqnlcO5AGVj0
	 seNLX1vOKxJ82PKbHLc2gusXa42aE/NeTtLSAu9xodVa+B5irRgHl7TKrBolbzydwz
	 eji8huSr2UOhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CE739E4DB5;
	Fri, 15 May 2026 01:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: fix double free in rvu_rep_rsrc_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880800580.150313.8207368814594738900.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 01:20:05 +0000
References: <20260513151320.213260-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260513151320.213260-1-dawei.feng@seu.edu.cn>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 stable@vger.kernel.org, zilin@seu.edu.cn
X-Rspamd-Queue-Id: 3F2A5548665
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247303-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 23:13:20 +0800 you wrote:
> rvu_rep_rsrc_init() allocates queue memory before calling
> otx2_init_hw_resources(). When hardware resource setup fails,
> otx2_init_hw_resources() already unwinds the partially initialized
> SQ, CQ, and aura state before returning an error. The representor
> error path then calls otx2_free_hw_resources() again and can free
> the same resources a second time.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: fix double free in rvu_rep_rsrc_init()
    https://git.kernel.org/netdev/net/c/e8fb3de2a8ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



