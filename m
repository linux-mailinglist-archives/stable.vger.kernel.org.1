Return-Path: <stable+bounces-240010-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJVULYmi5mkrzAEAu9opvQ
	(envelope-from <stable+bounces-240010-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 00:02:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE60943471C
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 00:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD101303C420
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB42F3CF058;
	Mon, 20 Apr 2026 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loyV55JY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62B4274FD0;
	Mon, 20 Apr 2026 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722423; cv=none; b=l2D/0Quo9og/SMJsUjw+Xr0PxA1aasSCGKU8K8e8NA6bpDiWZIL4tjM+MJ/SpP+TXqFGjgxE+kNGdsopj8OD0oM9LFMz6YdSSrj1aLdRo5Gjl/b+KjZfPXfaj3IXfvdWxPiDRXD+P6uHxfquWXPlxDlUvs2M/CDXLGfZ+dNN7ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722423; c=relaxed/simple;
	bh=06k+L69MGxQpyUnpeTop53TZeyKH6tZudEvym3TXPfM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XfT6wWVC04Vm736M2e4eqvmzS1QIxJ9N5sfcqCbI1mzlSDftNJ48+nfDazgYBpqR76ADKkdftjoQwkav8aUwLQGFP5D0amnaIl0dAmxqkhcPdpX4IcChRI7knIfyLYmREV8SSQ4vm5iks4gpSXuy20v4wxrhi/8bjfULuGEbnQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loyV55JY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C69C2BCB0;
	Mon, 20 Apr 2026 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776722423;
	bh=06k+L69MGxQpyUnpeTop53TZeyKH6tZudEvym3TXPfM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=loyV55JY+upSRkNglfQQ/PStacCmDmuCY//ffr0qQiq03WwS+2pft9XwIvMbP+fEf
	 X6JbocgAPod78PFI3yuHm+hIqinzZHvRaCR7tcErthJhpcoF9nTi2sYeqUpJ5DOxe7
	 6XU0YVjv9TEQdpIrtqtKTjfRCUWTGgoRTyzU/9FKBDNDYvAt27cn25Q/IZLZSmjXl4
	 eh27z2Eeye6wQ3s0x6CIPtZyHH4TxM/omyf6wrTPHJLMl7S6dBj0MXlfIbO0OZgNKA
	 dwKy/BS8HSERCceVi+UGOdh3WiEsS+R5/Q3gPn0Ry6xLTLNvm9QcXi3IkjOk+z9eFS
	 QfY6fBkquommg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9541C3930022;
	Mon, 20 Apr 2026 21:59:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] gtp: disable BH before calling udp_tunnel_xmit_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177672238729.1802062.5676745432497911101.git-patchwork-notify@kernel.org>
Date: Mon, 20 Apr 2026 21:59:47 +0000
References: <20260417055408.4667-1-devnexen@gmail.com>
In-Reply-To: <20260417055408.4667-1-devnexen@gmail.com>
To: David CARLIER <devnexen@gmail.com>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bestswngs@gmail.com,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240010-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[netfilter.org,gnumonks.org,lunn.ch,google.com,kernel.org,redhat.com,gmail.com,lists.osmocom.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE60943471C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Apr 2026 06:54:08 +0100 you wrote:
> gtp_genl_send_echo_req() runs as a generic netlink doit handler in
> process context with BH not disabled. It calls udp_tunnel_xmit_skb(),
> which eventually invokes iptunnel_xmit() — that uses __this_cpu_inc/dec
> on softnet_data.xmit.recursion to track the tunnel xmit recursion level.
> 
> Without local_bh_disable(), the task may migrate between
> dev_xmit_recursion_inc() and dev_xmit_recursion_dec(), breaking the
> per-CPU counter pairing. The result is stale or negative recursion
> levels that can later produce false-positive
> SKB_DROP_REASON_RECURSION_LIMIT drops on either CPU.
> 
> [...]

Here is the summary with links:
  - gtp: disable BH before calling udp_tunnel_xmit_skb()
    https://git.kernel.org/netdev/net/c/5638504a2aa9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



