Return-Path: <stable+bounces-233129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLBtNaQYz2mTswYAu9opvQ
	(envelope-from <stable+bounces-233129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 03:32:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE03D390101
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 03:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DD3D3016C01
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 01:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D606C320CB1;
	Fri,  3 Apr 2026 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOlXNUyj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33E315D23;
	Fri,  3 Apr 2026 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179836; cv=none; b=HDin8Cx/ErF1tm4RFZvVlYOr8kQKFZO8OINrk7nbyIKIHVXMmJcXXyWBNPavzBsMyI+RQ+TEjX5yQYmTuVeOd3067j/Sq8gyiQISj9CKnvoX9gE+PA4LN9gOd6dr9F5GZZQ1eOpVt9evEowfz0vG/iQXmPfri26NAJj0O93e1ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179836; c=relaxed/simple;
	bh=1Hm26f7WSUaU7gdqzw0LrW0GUT8cAoS27TdPbUmbB8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lPcGfEV2mDv7I+9kur6YevKNW7Zb18wIYXhRElRydKp/Wx1J4qJWf0ugK0Y9c+r6eSgt960bMbxnwfiVLi103hXxjeNKyAjh3jsZYibEoTgaBt9+GQWCxzydb7ygah+/Ry+mWGYjEQn6LqZbnUQRBJUn28Q9n9Fmk1N3lh3A1RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOlXNUyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39BFC116C6;
	Fri,  3 Apr 2026 01:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179835;
	bh=1Hm26f7WSUaU7gdqzw0LrW0GUT8cAoS27TdPbUmbB8c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OOlXNUyj+l3M0xdV+5kMmPfQcKE3Rx/EMzsC05AmPgrwXDVzraV//tI0UwdAcYwAj
	 pau2A/eu77U20zJftwyaPVq+XCeplB6JISNvvqCNjMXjK1X5mdd8W+5+UvetRgjuGm
	 m26AESPCH/MzvM785Z1NHU7Fgcu0z9Vk5VY3T0iWo4UplMngSv07RZZn/YlLsFIJVG
	 uKNH+I2+0IpKym8r8IZqfGup0o/qtnGTRu5he0La60DLuiTkEKt1iX93m8VqN412aS
	 2YZm40C2evnZ9NuNwQAioOPMtr3LSjKPyZZ00mTQnvVrlvS84yHEUhT32tHP+T2SUL
	 1S4d6K4MZfTgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDD93809A09;
	Fri,  3 Apr 2026 01:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: altera-tse: fix skb leak on DMA mapping error in
 tse_start_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177517981778.692254.771453892344758409.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 01:30:17 +0000
References: <20260401211218.279185-1-devnexen@gmail.com>
In-Reply-To: <20260401211218.279185-1-devnexen@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: boon.khai.ng@altera.com, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vbridgers2013@gmail.com,
 netdev@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[altera.com,lunn.ch,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-233129-lists,stable=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DE03D390101
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Apr 2026 22:12:18 +0100 you wrote:
> When dma_map_single() fails in tse_start_xmit(), the function returns
> NETDEV_TX_OK without freeing the skb. Since NETDEV_TX_OK tells the
> stack the packet was consumed, the skb is never freed, leaking memory
> on every DMA mapping failure.
> 
> Add dev_kfree_skb_any() before returning to properly free the skb.
> 
> [...]

Here is the summary with links:
  - net: altera-tse: fix skb leak on DMA mapping error in tse_start_xmit()
    https://git.kernel.org/netdev/net/c/6dede3967619

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



