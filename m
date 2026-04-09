Return-Path: <stable+bounces-235412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JimBLar12kMRQgAu9opvQ
	(envelope-from <stable+bounces-235412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 15:37:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9DA3CB5A5
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 15:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EE213152104
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 13:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C1A39FCAD;
	Thu,  9 Apr 2026 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKaoq0Q7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D30298CA5;
	Thu,  9 Apr 2026 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740836; cv=none; b=q5h7h2qFnq2Ms28a5AUWgyVTNIcMnd794Ap+yAbVko6nemmsKuma9++0P9zjR62mq8dBLcp0gH/GJ19GGOpFRTCtGp51XAvk6psi3iIQ3gpXcnsg31CRzVifh3pRkjtkx1CYsWnWytdrXhN3vyFjzYMuwLPP8sZcx7bc8a/y9OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740836; c=relaxed/simple;
	bh=cTQ57aENrRzOfxnUj5wfsKF30U1wQyW8nuZb5QJdE/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MraIE9TCGy/ozu2hh+nMY9u/ViuEnJrJUWjPBFLVjXi4PuVE4ux/wwKEfOGAyqQfZA+Cb+xBz61gZbo8n5OmYLxen5TGNmDDqqXXcpus9BlAO0LFGI+/9xwShlfxPs5rTz+MNuc+ngKvud4tYCrns6fKqvh8O7Ndu8Z4+Sl7jIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKaoq0Q7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44132C4CEF7;
	Thu,  9 Apr 2026 13:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775740836;
	bh=cTQ57aENrRzOfxnUj5wfsKF30U1wQyW8nuZb5QJdE/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dKaoq0Q7aF36khnil/jeqor4SqeDiBU6LTMzVk+lRak6WmpqUMIulMIB5wBeni908
	 LilrlZ1hI/a5iygJOZRitr4/OLNQoHhs8vfwHbZLj9HuLiDaQpk1xb0+d6vbFLzkZV
	 SUSrXW6VLLGlwGXPktmJlHeSHqvrCBKWad11ieNmWHiVDd75zgnfwcbgcRJCtVYWmc
	 mI6QIPip2PHMTkBk4cu50OibyXBejG+sYsypW/JruJLDcslNrZKcCsfq1/F2zM80JZ
	 mHGTPX3AxCA0uMMvDtEGEhmT3duM8Rkn+jXA/8RX5LY7cmHBs+1gJLfDVGwRX/lgl6
	 gYuh+NC6O2vag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD4E393088E;
	Thu,  9 Apr 2026 13:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] net: lan966x: fix page_pool error handling and
 error paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177574081204.1154771.5454597841485925839.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 13:20:12 +0000
References: <20260405055241.35767-1-devnexen@gmail.com>
In-Reply-To: <20260405055241.35767-1-devnexen@gmail.com>
To: David CARLIER <devnexen@gmail.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235412-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E9DA3CB5A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  5 Apr 2026 06:52:38 +0100 you wrote:
> This series fixes error handling around the lan966x page pool:
> 
>     1/3 adds the missing IS_ERR check after page_pool_create(), preventing
>         a kernel oops when the error pointer flows into
>         xdp_rxq_info_reg_mem_model().
> 
>     2/3 plugs page pool leaks in the lan966x_fdma_rx_alloc() and
>         lan966x_fdma_init() error paths, now reachable after 1/3.
> 
> [...]

Here is the summary with links:
  - [net,v3,v3,1/3] net: lan966x: fix page_pool error handling in lan966x_fdma_rx_alloc_page_pool()
    https://git.kernel.org/netdev/net/c/3fd0da4fd885
  - [net,v3,v3,2/3] net: lan966x: fix page pool leak in error paths
    https://git.kernel.org/netdev/net/c/076344a6ad9d
  - [net,v3,v3,3/3] net: lan966x: fix use-after-free and leak in lan966x_fdma_reload()
    https://git.kernel.org/netdev/net/c/59c3d55a946c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



