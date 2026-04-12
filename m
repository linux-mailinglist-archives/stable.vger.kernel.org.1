Return-Path: <stable+bounces-235826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGA5Ke3B22lNGQkAu9opvQ
	(envelope-from <stable+bounces-235826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 18:01:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C0B3E4A66
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 18:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EADB53011765
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 16:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF96279358;
	Sun, 12 Apr 2026 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwuErRpA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317ED1A3164;
	Sun, 12 Apr 2026 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776009703; cv=none; b=jOCYnmMAgrBXL57JqZ0kT49LuXoDW35Sj6AMUdUde7OxpMswMmhrhvKpBPvkgVgZHbMoH9Qxhr0g++vMGahEu5EfcDcArL98yFtA70M68v5Xv7BGhGmCXT1/s6uPBMP7pKSVEYWblUZ6yXRHBnpx0GhxHU2bBxkMwCTyF/l/9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776009703; c=relaxed/simple;
	bh=vgerdKwbuKZBjz+foaiZAMrqhC3fWccDQiaJc3XbjQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3E4oqsqVEzjwYBPSC4F8PiMOBhPPEBwUsLmn2KsUND6VX2pvOvB2fLLIlkzdcZ3xhJs/4fG6H1yhCRuWie5Obnl35VtivySEP/DRoq+RpSqX2EnU1S98z/N/FtUQ/JzO7H3aQQsYqPkxO1skqbCW8cRWnjPsNyekcQ3DsWTvwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwuErRpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F075C19424;
	Sun, 12 Apr 2026 16:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776009702;
	bh=vgerdKwbuKZBjz+foaiZAMrqhC3fWccDQiaJc3XbjQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZwuErRpAaZTRXLGMb9pKMGSgiVO5wHd48b2zLACZdbA/yqzhaVpYG/quJCWVE0mby
	 9XZKEjxSSCRGSggD91/9SFaqqn07Ju9y3ZhRWBXrOgKyf7uKMKpW2MpJE3ym2GiZcV
	 YgDox0yikcN/7wx3tRtyXrSwhBgqT+1G/dWKPekhF0PzFPmAVp8D7stTKZ+I2ftzeI
	 RwxI3hz3HwYGYkj9h3auSAwSr09Erc6GZxMVTacNvS+TxepAmEyg2M7g626sTyFQIa
	 CpFWDBT6TPJKuLkZdpTyRqWBJMhZtbP8igJSG7QB81Z/bNv4j8JFbSL73I5g/ay9r3
	 u2DsuXkWsDdpA==
Date: Sun, 12 Apr 2026 09:01:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Nicolai Buchwitz <nb@tipi-net.de>, Paolo Abeni
 <pabeni@redhat.com>, Ronald Wahl <ronald.wahl@raritan.com>, Yicong Hui
 <yiconghui@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [net,PATCH v2] net: ks8851: Reinstate disabling of BHs around
 IRQ handler
Message-ID: <20260412090141.21bf1534@kernel.org>
In-Reply-To: <20260408162535.98108-1-marex@nabladev.com>
References: <20260408162535.98108-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,tipi-net.de,redhat.com,raritan.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-235826-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49C0B3E4A66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed,  8 Apr 2026 18:24:58 +0200 Marek Vasut wrote:
> If CONFIG_PREEMPT_RT=y is set AND the driver executes ks8851_irq() AND
> KSZ_ISR register bit IRQ_RXI is set AND ks8851_rx_pkts() detects that
> there are packets in the RX FIFO, then netdev_alloc_skb_ip_align() is
> called to allocate SKBs. If netdev_alloc_skb_ip_align() is called with
> BH enabled, local_bh_enable() at the end of netdev_alloc_skb_ip_align()
> will call __local_bh_enable_ip(), which will call __do_softirq(), which
> may trigger net_tx_action() softirq, which may ultimately call the xmit
> callback ks8851_start_xmit_par(). The ks8851_start_xmit_par() will try
> to lock struct ks8851_net_par .lock spinlock, which is already locked
> by ks8851_irq() from which ks8851_start_xmit_par() was called. This
> leads to a deadlock, which is reported by the kernel, including a trace
> listed below.

lock_par is a spinlock, and AFAIU softirqs run in their on thread on RT.
I'm not following.

The patch looks way to "advanced" for a driver. Something is going
very wrong here. Or the commit message must be updated to explain
it better to people like me. Or both.
-- 
pw-bot: cr

