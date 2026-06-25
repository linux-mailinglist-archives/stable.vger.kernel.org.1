Return-Path: <stable+bounces-268616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id By3XDpxWPWpP1ggAu9opvQ
	(envelope-from <stable+bounces-268616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 18:26:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 945506C776D
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 18:26:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ikqMxPyq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268616-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268616-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65809300564C
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EAB3ED10F;
	Thu, 25 Jun 2026 16:21:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F43EB109;
	Thu, 25 Jun 2026 16:21:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404469; cv=none; b=RUoRc15fkhRgoAP2EwXyQJonxLqBYzZTD1w482yJVzoUFJXraOQoZ4I/LB4iy0/MOjiW9xxXuVNi6r/8u/Lmf3MUuN3ZNyYso0kehlAjSSJmUZH5UYaHNZBJIqZyfvj1LNSXpPqbY7TjFlSIQLD7UkBSRmmSXKohfabeXYofpqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404469; c=relaxed/simple;
	bh=UOt6EGM8fMiJFW34YFdUp24CWRPrPqiNaWTM8wkZfNg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E/t0TqsD6QnVxi5Ca+fddnIiIwJNw4XjeGaSD0i5Bp587PR18OUAVA5/xsHsXeaaCUQVZGopQOrRQjSHcarqv0eWH/PZ2ppT9H8hYi768GDeVrn3VYGfDZ1rXJ1l0oYudois/UrJ6YuJ5r8z+QY7PStNYT3IDP7CM2VMSFI/yv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikqMxPyq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C061F000E9;
	Thu, 25 Jun 2026 16:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404468;
	bh=LGBo2vf5YhWLqWr2lTqOOyhPJy8D4/FOwRNjsyPwlAw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ikqMxPyqHXeNLjjVPGzWundaHYDRIPj2Iv983MLxSlcNsDXVawdAthu910VhKzErK
	 a0nchwckRMPHDXVdS5ay8Ez9rPwq/wHQgFWLqg0KcihDmEKJg6E8UqY4o/CMiPokkG
	 OJ8pVzzNizLvatWF1iQWns7BHpw7tGMJPQlGfOTzD9lsC2sqD2pLuUEbUFmxoKDeWb
	 dH/GAXeWB6vk6w3/DTmwckAk8eV2XG0D7nfPMEfjt+hDFPVp0v1saRGvKLtlx7tGt6
	 EsxKpIWKE0D3VQSEkutqydIrFGiQJUNPDEJf1gprFkuANHttP4ONB63w7bsOjW6ic6
	 y4MXHjDhnl1uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A363AD449A;
	Thu, 25 Jun 2026 16:20:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sparx5: unregister blocking notifier on init failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178240445557.3803792.18219919431428523826.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 16:20:55 +0000
References: <20260623115714.2192074-1-haoxiang_li2024@163.com>
In-Reply-To: <20260623115714.2192074-1-haoxiang_li2024@163.com>
To: haoxiang_li2024 <haoxiang_li2024@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com, kees@kernel.org,
 horms@kernel.org, bjarni.jonasson@microchip.com, lars.povlsen@microchip.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268616-lists,stable=lfdr.de,netdevbpf];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Steen.Hegelund@microchip.com,m:daniel.machon@microchip.com,m:UNGLinuxDriver@microchip.com,m:kees@kernel.org,m:horms@kernel.org,m:bjarni.jonasson@microchip.com,m:lars.povlsen@microchip.com,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 945506C776D

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 19:57:14 +0800 you wrote:
> sparx5_register_notifier_blocks() registers the switchdev blocking
> notifier before allocating the ordered workqueue. If the workqueue
> allocation fails, the error path unregisters the switchdev and netdevice
> notifiers, but leaves the blocking notifier registered.
> 
> Add a separate error label for the workqueue allocation failure path and
> unregister the switchdev blocking notifier there.
> 
> [...]

Here is the summary with links:
  - net: sparx5: unregister blocking notifier on init failure
    https://git.kernel.org/netdev/net/c/483be61b4a9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



