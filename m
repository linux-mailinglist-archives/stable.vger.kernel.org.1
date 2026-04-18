Return-Path: <stable+bounces-238598-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN2TMYe142mVKAEAu9opvQ
	(envelope-from <stable+bounces-238598-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 18:47:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 316C0421ADC
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 18:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15F3E30131DC
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 16:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3D92D0C62;
	Sat, 18 Apr 2026 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Cgqvm8Fj"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378491547C0;
	Sat, 18 Apr 2026 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776530818; cv=none; b=GnhiN77PM7C5pFVjLUrxERz7m0upknaid8HtoZdo+zaF7zN9KEkgQN2+oocA1z+rbi/jSNLQYGELgbhiYsSHxddufkiW7VOjC15cOT40K3zSEZfiwuHQHg1N/B2nyZBBMC0DuWvHbsnwt1hTZrrWLymI+vgwhlioJvBUEXmmziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776530818; c=relaxed/simple;
	bh=79g8Cj0aVvxyvk8Zpsm1NfOTZskgvZcrJiNve829PM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XG/puPEZonEJMrN3FmotVXaYse28fLQjODVPxSIh5wwCdJoYW8e7hkoQn2UPWSACY5wsg3Z15N2x2E43O1SB85KciJl8+nuuMOkLAK0dKr9/VJ4ycEQjunwrXwUPlnHUOk73uwDdTNRkUwXaNVleymvz0sP2Pdbai5qu18ETjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Cgqvm8Fj; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D11B31143A3;
	Sat, 18 Apr 2026 18:46:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776530807;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jwxsjqC6odbloW4RnZUq7a7489g9YY4pbiBKr6i/Ls4=;
	b=Cgqvm8Fj4anJr5bp47idXk4Lz9yQ3o5gIgyoLoav2L2hhUvyYqzLZy9SlJ1OmyYO+svfdO
	xD7OQyb5jC0klVf4qw6eT9sigJa3lesqJHSlhjLK7J1bcZ7yBNT2ZLH6x/XUjD+VrAu431
	R0lhBQ7/+I8dSKhmDPb3pml/aDRBVcjYcXPBhew8+49hb/ldb7wBpYlbKVfMuernFgLneR
	3VI9gLj5heKhAItCecOIi+GkKXWIXZN3ChG2js/Mr9KbGCzuVzhEHoymmSuQb6rhGyCqP6
	R6PaoWTrCvirYF3OeL5lMOX0U9ick9zMNkuG+fhlR8DXnwzo9WneYemxFyBSaw==
Message-ID: <c75c4b73-b7e9-4403-94a1-d4967ec7a299@nabladev.com>
Date: Sat, 18 Apr 2026 18:46:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH v3 1/2] net: ks8851: Reinstate disabling of BHs around
 IRQ handler
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>,
 Paolo Abeni <pabeni@redhat.com>, Ronald Wahl <ronald.wahl@raritan.com>,
 Yicong Hui <yiconghui@gmail.com>, linux-kernel@vger.kernel.org
References: <20260414103327.113500-1-marex@nabladev.com>
 <20260414125753.Im6GAIHn@linutronix.de>
 <2fcfb84f-69f6-493e-94d6-95d85d8000f6@nabladev.com>
 <20260414145218.lsNpdAJI@linutronix.de>
 <7734527a-d08b-49fa-b258-c37c5ae2da55@nabladev.com>
 <20260416062159.fPxqc52X@linutronix.de>
 <afe7ed2c-4434-4394-9d87-a4bdf5a15ec1@nabladev.com>
 <20260416104818._EDbo9hA@linutronix.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260416104818._EDbo9hA@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238598-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org,tipi-net.de,redhat.com,raritan.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 316C0421ADC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 12:48 PM, Sebastian Andrzej Siewior wrote:
> On 2026-04-16 11:26:00 [+0200], Marek Vasut wrote:
>>> memory allocation. Therefore I am saying this backtrace is from an older
>>> kernel.
>>
>> I actually did update the backtrace in V3 with the one from next 20260413
>> that contained b44596ffe1b4 ("ARM: Allow to enable RT") from
>> stable-rt/v6.12-rt-rebase branch [1] .
>>
>> I think I misunderstood the usage of "softirq is raised" vs. "softirq is
>> invoked" above . Is it possible that there was an already raised softirq
>> before the threaded IRQ handler was invoked, and __netdev_alloc_skb() is
>> what invoked that softirq ?
> 
> It is not impossible. Something needs to netif_wake_queue() and
> ks8851_irq() must only report IRQ_RXI (not IRQ_TXI). Then it can happen.
> But usually the driver "stops" the queue if it can't process any new
> packets and resumes it once a packet has been sent so it has room again.
This driver .start_xmit is very simple, if there is space in the 6 kiB 
TX FIFO, then the packet is written into it, otherwise the .start_xmit 
returns NETDEV_TX_BUSY . There does not seem to be any 
netif_{start,stop,wake}_queue() in the .start_xmit path.

