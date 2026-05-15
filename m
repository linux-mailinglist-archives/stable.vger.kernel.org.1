Return-Path: <stable+bounces-248887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ2wOcNbB2orzwIAu9opvQ
	(envelope-from <stable+bounces-248887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:45:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7C7555834
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43F88306524C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42353DA7C9;
	Fri, 15 May 2026 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcO35qFi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E83F9A0D;
	Fri, 15 May 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866792; cv=none; b=CF24rI7ADd27nH9e1zSizhlPZFeNgpiueRsStKQrXRvnT+EXJobtGvsulkuzIgYlPIglWwd5c/r1gG13pGDC9ku0uy7tx+c1Z4herDfoJL48fDExp6Eux3gDgaT2vDHJiRB/Bx5nJ1JB1aYCmNv4kfoB47DOK7oEt4r75oB6OUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866792; c=relaxed/simple;
	bh=8GbcXFZEKguzJtJMPWiGizINnjHIqkzVVpj5M0kIGcM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OwYmq5wt7v6CCHknOlBi3dlzw5Ef3IK9hkUegKmV2cDBw4k1fEA6jZzDGqZ0zjnbD6LAuGfPKDM262OlFv1RMvRQJNDaqXjXZXZ+dUCPnCCbGzPRo9uOMVkFDHpq3+NEmMVeHInff7yQfylediCn0JjPzSJOWfBlVv0Hj+Fs5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcO35qFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EDDC2BCB0;
	Fri, 15 May 2026 17:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778866791;
	bh=8GbcXFZEKguzJtJMPWiGizINnjHIqkzVVpj5M0kIGcM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HcO35qFit2TBOOyFC+TnsHLGoqxs27yRj0zYdZ1BjyLvjFRhp6u/LI3tmnETDfkVt
	 DMA/U4qFKp/rQEnUwhAvoT1XX7OVQNZoKjqSa791zq3XqcGZAT6f/tcZSqsYNoB6mS
	 NrYB4xUT72ZsrkOtxm1b/aDik9u5EfJPjJ7q3RRhGNfrMEfOUebM6bRdljHFD4OwCN
	 bPq6m/3urdffzaZqGvgmWb4wMdB9oDKUR2w5E+jKT1FFeu71XSU4NUfj9HVG0URduf
	 Cc8jiaQIibNiXemJxy1ifglbaILSIXIaZk3FuxgrzeCZW51DQD7bvhuqC6cSea7wGI
	 UC6xMmoCfwK6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939203930A03;
	Fri, 15 May 2026 17:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Bluetooth: ISO: drop ISO_END frames received without
 prior ISO_START
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177886680439.97270.9725594380754739990.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 17:40:04 +0000
References: <20260515062525.57603-1-devnexen@gmail.com>
In-Reply-To: <20260515062525.57603-1-devnexen@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 stable@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 8F7C7555834
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-248887-lists,stable=lfdr.de,bluetooth];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 15 May 2026 07:25:25 +0100 you wrote:
> ISO data PDUs carry a packet-boundary flag indicating START, CONT, END
> or SINGLE. The ISO_CONT branch of iso_recv() guards against a missing
> ISO_START by checking conn->rx_len before touching conn->rx_skb, but
> ISO_END does not.
> 
> If a peer sends an ISO_END as the first packet on a fresh ISO
> connection, conn->rx_skb is still NULL and conn->rx_len is zero, so
> skb_put(conn->rx_skb, ...) dereferences NULL and oopses. For BIS,
> where receivers sync to a broadcaster without pairing, any broadcaster
> on the air can trigger this.
> 
> [...]

Here is the summary with links:
  - [net] Bluetooth: ISO: drop ISO_END frames received without prior ISO_START
    https://git.kernel.org/bluetooth/bluetooth-next/c/6aba94a49bc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



