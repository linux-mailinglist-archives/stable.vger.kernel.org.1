Return-Path: <stable+bounces-238302-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEVCDZC+4GnQlQAAu9opvQ
	(envelope-from <stable+bounces-238302-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 12:48:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D8E40D087
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 12:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BFCC3049976
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 10:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DBE3A4511;
	Thu, 16 Apr 2026 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M7tsHkFG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8GjlmBf+"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37172750E6;
	Thu, 16 Apr 2026 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776336503; cv=none; b=qP5n7jjwZQ1iG2nvRIcPhjBqTulJLoapcHJMdjIBbLTGq6+G+A9m0tjX7Ni/DBSK9EUvg3PMKPbo3FdZHIpBlViZBAmaIZrYfSmjp91M+GWTCDPeS75tjNPAp/mhiLrG5lTKoerwBvFgbT4GPBakmo7NMRc0MtNi7CIIZkVE0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776336503; c=relaxed/simple;
	bh=FJAjF3c/YQAZ4eKmPCcFLz5owz9LmueVbVqgFhgoVpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zb6AqB0/Jq6RXqHE78qISulFtcJeJ3kho++TQDq+/uTXOdxXd6p2gOXVYwPlARiU+waOtcSxKTHnD6AT6igu6e2v6iT9BJgyGBMHJNi0JM8KcxyaO3wEsKs2Nk19keLp3NxVAEd45axr8eMdKMUeKLwDsPVawWowr93pAWnFrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M7tsHkFG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8GjlmBf+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Apr 2026 12:48:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776336499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I3a7Sj+pE8WYMPoTgZHgFbXHwJPGyl/mbNxCrht2ciU=;
	b=M7tsHkFGF/XC8bt3idRz80P1SxzXCGO5gMiIWSHRK8LMVMmjP8P+3kTMmXxtO7N+rHVujO
	/9lPKTFh5pnHLY3aZo0FnLakIWA8NLCmwe208rHOmbAIZCHT8A2M78ZTTB0Z1fmbfxpzBZ
	KXKhIuoxSi7O4AHAJgOI0frsk5ZD457tJbJorusOKU+FYTrbdTlOH8tgKjXmA+3yNt2vva
	yIT//0jnfMNrYs/APwx5hyHpBbiXD2QSwVayAYMHh7YKRWlPYSkfpHcb9Lq46GuMAydJV3
	3Gnzs4x910dtN0uQFajj73frA9acmQ7Xr3L+kNwKifwZ8AEWCVhkxbEyNSe/dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776336499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I3a7Sj+pE8WYMPoTgZHgFbXHwJPGyl/mbNxCrht2ciU=;
	b=8GjlmBf+HMAGSVLkjIzbXCrFa42WdQ00ZsKu1/uWFYxmusGD/wcUQkNpsq+VB0rLr3aovX
	GqiFZulv+LsAkvAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Yicong Hui <yiconghui@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [net,PATCH v3 1/2] net: ks8851: Reinstate disabling of BHs
 around IRQ handler
Message-ID: <20260416104818._EDbo9hA@linutronix.de>
References: <20260414103327.113500-1-marex@nabladev.com>
 <20260414125753.Im6GAIHn@linutronix.de>
 <2fcfb84f-69f6-493e-94d6-95d85d8000f6@nabladev.com>
 <20260414145218.lsNpdAJI@linutronix.de>
 <7734527a-d08b-49fa-b258-c37c5ae2da55@nabladev.com>
 <20260416062159.fPxqc52X@linutronix.de>
 <afe7ed2c-4434-4394-9d87-a4bdf5a15ec1@nabladev.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afe7ed2c-4434-4394-9d87-a4bdf5a15ec1@nabladev.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238302-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org,tipi-net.de,redhat.com,raritan.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 84D8E40D087
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-16 11:26:00 [+0200], Marek Vasut wrote:
> > memory allocation. Therefore I am saying this backtrace is from an older
> > kernel.
> 
> I actually did update the backtrace in V3 with the one from next 20260413
> that contained b44596ffe1b4 ("ARM: Allow to enable RT") from
> stable-rt/v6.12-rt-rebase branch [1] .
> 
> I think I misunderstood the usage of "softirq is raised" vs. "softirq is
> invoked" above . Is it possible that there was an already raised softirq
> before the threaded IRQ handler was invoked, and __netdev_alloc_skb() is
> what invoked that softirq ?

It is not impossible. Something needs to netif_wake_queue() and
ks8851_irq() must only report IRQ_RXI (not IRQ_TXI). Then it can happen.
But usually the driver "stops" the queue if it can't process any new
packets and resumes it once a packet has been sent so it has room again.

> > If there is a flaw in my the theory please explain _how_ you managed
> > that get that backtrace. I am sure it must have from an older kernel and
> > _now_ this lockup also happens on !RT kernels (except for the SPI
> > platform).
> I used [1] , with PREEMPT_RT enabled , on stm32mp157c SoC . I ran iperf3 -s
> on the stm32 side, iperf3 -c 192.168.1.2 -t 0 --bidir on the hostpc side.
> The backtrace happened shortly after.

Hmm. Let me accept it then.

Sebastian

