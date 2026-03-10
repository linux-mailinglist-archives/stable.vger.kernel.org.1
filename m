Return-Path: <stable+bounces-224519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEZMIipPsGnFhgIAu9opvQ
	(envelope-from <stable+bounces-224519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:04:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE62025536C
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2EB030785C4
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE7B3C8727;
	Tue, 10 Mar 2026 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAxW4CfJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35F3C871E;
	Tue, 10 Mar 2026 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160501; cv=none; b=bXL72aCqpZ5liAxA6ztLFx+FdNm7JYsKOtRFGY+etC2arN0WIcAbruD3WoquY33RgdGMGJxEG+5wPJYNGSqnd94L3B5/yTOnMJIcBjC7wAZqAWT1xRsXRZGXtwd5Hx11tu76PMTYmKjnC9k1UNYjlcn/aw12i/BZrO8qi1S7tTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160501; c=relaxed/simple;
	bh=8VhSBldjem6ojHmzQzX5fw9Cng1c1xogBimhshznzt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKkub+4uIW/UdYtW4LUKBt8x1+pJ49LYMXfeE7DabycqezdCFgqAMg+uLx+szpvLzvi1IUAyTrrzhSLF1nduXc3pZfR9u7XbzR4TAmbjjQxHtejdYsSDF56Rwc3BvQaM8IpaVx2GpVFR2qO7UriVpnfnRDihDh3oIZjE6hMV1r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAxW4CfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A90C19425;
	Tue, 10 Mar 2026 16:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773160501;
	bh=8VhSBldjem6ojHmzQzX5fw9Cng1c1xogBimhshznzt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAxW4CfJeV03c664fbg+KfzgCyun72xcQ/sSTUzRRf0X6RWSKcyyYRAPrXcuAla3S
	 uZDb6Okt+21WR/+nsrrYOJe9n818YEB9v9HxjkOaH4eyq29ckQ01g7rQYHOrexU/zJ
	 DSb8K7iEVOaZ564tHoUmXVB3sPmqnhJw456OPdFzhu+kAbJoFASySgkAEyjmT+KZlQ
	 ZDhFMW6WER6+xmddfWQbet7GEZue23PFPDnUKSooW2gaaJk0sqlCXX6Jnl9A8q5St4
	 Kb/9rO2/myRpyQmq4Bf2YjN8leb429PKXb2x4JywylOvD1nomoVifedde/QUQ6kaOz
	 Hit9hOE54L79A==
Date: Tue, 10 Mar 2026 16:34:56 +0000
From: Simon Horman <horms@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, Quanyang Wang <quanyang.wang@windriver.com>,
	stable@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net v2] net: macb: Shuffle the tx ring before enabling tx
Message-ID: <20260310163456.GK461701@kernel.org>
References: <20260307-zynqmp-v2-1-6ef98a70e1d0@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307-zynqmp-v2-1-6ef98a70e1d0@gmail.com>
X-Rspamd-Queue-Id: AE62025536C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224519-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,linux.dev:url,amd.com:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 03:08:54PM +0800, Kevin Hao wrote:
> Quanyang observed that when using an NFS rootfs on an AMD ZynqMp board,
> the rootfs may take an extended time to recover after a suspend.
> Upon investigation, it was determined that the issue originates from a
> problem in the macb driver.
> 
> According to the Zynq UltraScale TRM [1], when transmit is disabled,
> the transmit buffer queue pointer resets to point to the address
> specified by the transmit buffer queue base address register.
> 
> In the current implementation, the code merely resets `queue->tx_head`
> and `queue->tx_tail` to '0'. This approach presents several issues:
> 
> - Packets already queued in the tx ring are silently lost,
>   leading to memory leaks since the associated skbs cannot be released.
> 
> - Concurrent write access to `queue->tx_head` and `queue->tx_tail` may
>   occur from `macb_tx_poll()` or `macb_start_xmit()` when these values
>   are reset to '0'.
> 
> - The transmission may become stuck on a packet that has already been sent
>   out, with its 'TX_USED' bit set, but has not yet been processed. However,
>   due to the manipulation of 'queue->tx_head' and 'queue->tx_tail',
>   `macb_tx_poll()` incorrectly assumes there are no packets to handle
>   because `queue->tx_head == queue->tx_tail`. This issue is only resolved
>   when a new packet is placed at this position. This is the root cause of
>   the prolonged recovery time observed for the NFS root filesystem.
> 
> To resolve this issue, shuffle the tx ring and tx skb array so that
> the first unsent packet is positioned at the start of the tx ring.
> Additionally, ensure that updates to `queue->tx_head` and
> `queue->tx_tail` are properly protected with the appropriate lock.
> 
> [1] https://docs.amd.com/v/u/en-US/ug1085-zynq-ultrascale-trm
> 
> Fixes: bf9cf80cab81 ("net: macb: Fix tx/rx malfunction after phy link down and up")
> Reported-by: Quanyang Wang <quanyang.wang@windriver.com>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> Changes in v2:
> - Resolves the issue of incomplete copying of the tx descriptor, as identified by the AI [1].
> 
> - Resolves warnings for lines exceeding 80 columns.
> 
> - Link to v1: https://lore.kernel.org/r/20260305-zynqmp-v1-1-5de72254d56b@gmail.com
> 
> [1] https://netdev-ai.bots.linux.dev/ai-review.html?id=44318d8b-d8c3-42c8-8884-238421f708c5

Reviewed-by: Simon Horman <horms@kernel.org>


