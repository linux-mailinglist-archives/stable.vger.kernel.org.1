Return-Path: <stable+bounces-89688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5209BB2EA
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2096F284AA1
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3C81C243C;
	Mon,  4 Nov 2024 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0VN6SX/H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vmlrtgcp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DA91C07DE;
	Mon,  4 Nov 2024 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718433; cv=none; b=btVMVyfzpp2up3Tnl5bLBmmvLBej2LMnLfe1eI45bJOoL2cRPUSPQ5Tu4uL88TvfAq+eY7dflba2hlmbF/2PQSBy/xWOznYOV8tBpbDnn4FTQ88yG0I4BFKNdQeuJO+4Kto5TsAw/A/4ZacRpgdfO/55M9+yyheR1d2PVRHzyns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718433; c=relaxed/simple;
	bh=6XwODjrOdcDVNzCFZZMMdhOhxxTW3MIA6P3Or5VJqUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjroGVkvXkuhnT/up6gPNd98szRq5pwCi48G43ojefHBiE5gcomyj+Sna3oh519QnIgEjj2W1lMFilHoZVU3GjapyuzVWyI4wEoWKosoac7cudXnctetVd7pWnqXtiv5BCZszxGx+ipRW+91X2oeHEl6lYHjCcmjWBJBn8IuBl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0VN6SX/H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vmlrtgcp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 4 Nov 2024 12:07:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730718430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yl6DSR79uyW/vGqRXqqsb6z9FEylh/TTsKeElRxkQ3k=;
	b=0VN6SX/HWw3viDjut+P5LVEMYkQ5BW0MP9u4SwJ6vGoSd/+RjIdUKLKY1xPDpq5lXZYtHv
	c9IpBwsB5eeBZE2p3IIyMVcBEqDCBHZX20chx4ewwlUeaO4UoKsnl0D1VaLtMWpdBqWcuG
	dJTrRYiv9eDqHAhNQ1uJ2yM/wg8FMIioWQEwa+TpAKoktVeGDhdZcotCXIv001J6WU6yya
	0Eds501Ek76R7NIdc5tJMrizmgyLmxZAp9BXQUi17CNT6tCHdbuf7u8s6qIPs84Sy4SsKy
	5ZSOn5g2ppt0HdQ2oGhvttDnSktejomWpBOSdVcjsExY7oTvmOJxhHGWLN54mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730718430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yl6DSR79uyW/vGqRXqqsb6z9FEylh/TTsKeElRxkQ3k=;
	b=vmlrtgcpsUlGm0eyD+lQVfWNYZvRWb8c+np03+VqxuDBc6WdpRHxcRclyS03ADpAJ34vMk
	n0o1mLOxJsSWhWAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, wander@redhat.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de
Subject: Re: Patch "igb: Disable threaded IRQ for igb_msix_other" has been
 added to the 6.11-stable tree
Message-ID: <20241104110708.gFyxRFlC@linutronix.de>
References: <20241101192124.3847972-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101192124.3847972-1-sashal@kernel.org>

On 2024-11-01 15:21:24 [-0400], Sasha Levin wrote:
> commit 052382490ee4f0f6d783ddce02fe6f2d15e134b5
> Author: Wander Lairson Costa <wander@redhat.com>
> Date:   Mon Oct 21 16:26:24 2024 -0700
> 
>     igb: Disable threaded IRQ for igb_msix_other
>     
>     [ Upstream commit 338c4d3902feb5be49bfda530a72c7ab860e2c9f ]
>     
>     During testing of SR-IOV, Red Hat QE encountered an issue where the
>     ip link up command intermittently fails for the igbvf interfaces when
>     using the PREEMPT_RT variant. Investigation revealed that
>     e1000_write_posted_mbx returns an error due to the lack of an ACK
>     from e1000_poll_for_ack.
>     
>     The underlying issue arises from the fact that IRQs are threaded by
>     default under PREEMPT_RT. While the exact hardware details are not
>     available, it appears that the IRQ handled by igb_msix_other must
>     be processed before e1000_poll_for_ack times out. However,
>     e1000_write_posted_mbx is called with preemption disabled, leading
>     to a scenario where the IRQ is serviced only after the failure of
>     e1000_write_posted_mbx.
>     
>     To resolve this, we set IRQF_NO_THREAD for the affected interrupt,
>     ensuring that the kernel handles it immediately, thereby preventing
>     the aforementioned error.

Wander, please send a revert of this patch. The ISR (E1000_ICR_TS set)
may invoke igb_msg_task(), ptp_clock_event(), igb_perout(), igb_extts()
each of which acquire sleeping locks on PREEMPT_RT. Not sure if this
improved the situation or not.

Sebastian

