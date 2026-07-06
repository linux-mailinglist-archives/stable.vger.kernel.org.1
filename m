Return-Path: <stable+bounces-272270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iHuYDITHS2p+aAEAu9opvQ
	(envelope-from <stable+bounces-272270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 17:19:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5397127BB
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 17:19:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=VTBiBrwE;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=P9d7GLAb;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272270-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272270-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81AB832883E4
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 15:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886BA381B1F;
	Mon,  6 Jul 2026 15:05:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161C5380FEB;
	Mon,  6 Jul 2026 15:05:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350356; cv=none; b=NNFcA2QgHQwEAV5PqbSlgoIlbbi/FNdPlg1QPpt0j7IDZZ65C2feFM6UaRnV5qi7MJXGUKVfPCA9jN1spofaN6ozFj1sRdRkmthR5UKo4atdWMeZgyzg5uuJ3ylZDO6Mym6x0H9ppQFsF+2PB9kPC1lLhFlAnZl31iAkadmSitI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350356; c=relaxed/simple;
	bh=3yi8neAEE9rEq0mxmjpaiKYd96ZV5xiHUgR7phnh+HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYM/DW9RSycYeJlFYD8ppb84oLsdsuhw8D9niByrc7Owp90mLOfJM64am8Si85j2ICrdAlwgz0Dh+ggiNnE5c3EpGFnaqB9xx9TRMRQN7b0ZOyPMBZfatdGWzbyUv6QVTR1L/Ke6vcWsxR6AO4PK4zFTApUbW/a2Tp9m1xJSnYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VTBiBrwE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P9d7GLAb; arc=none smtp.client-ip=193.142.43.55
Date: Mon, 6 Jul 2026 17:05:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783350353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NB9C1tjmGRHLySf+l2Zt8ileBtf+TYUJy39INOr86Rg=;
	b=VTBiBrwEo17Mp0HQTuYwb3bfzd/zrFr8t8ZTDKDypENitm0+Tnkk2+H68X4nS0AayUt6HM
	zxCU0OHI8K1adKE2YYCFU5nJdq3/Sl1nH1nw9pd5xwiFndFn3hhg/AGZu/1ftTLRmTVfMK
	bd46WKl2tO4PyLyDznw4dUxapNUGv9Y/1NHNDGcEgOSp8DcAvTHmXD3Qw0v+iD+Lfv5CuK
	SE3yVClhbRdjccY12f5szI5t+OE8fEc/4fk7povRHWvuphZ7x35kgVb/R59ZmswD2eJgWP
	yqJD4h9T1WdoNY26uR0LRwgmlzamqE5Gb3U7jPzq1hFTxVqX+gRDN+Nbk9QKfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783350353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NB9C1tjmGRHLySf+l2Zt8ileBtf+TYUJy39INOr86Rg=;
	b=P9d7GLAbFTnLUHFuMicc7kn2osB9FQ+NuT3a7SjkC6F/47wbb8306piJiBgy8MPLHY9rIJ
	kk/YwkP3tYClXWDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: christian.taedcke@weidmueller.com
Cc: christian.taedcke-oss@weidmueller.com,
	=?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kevin Hao <haokexin@gmail.com>, Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Robert Hancock <robert.hancock@calian.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: macb: mask TXUBR during TX NAPI poll to
 prevent IRQ storms
Message-ID: <20260706150552.EomovsBn@linutronix.de>
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
 <20260706-upstreaming-macb-irq-storm-v1-2-ab3115b5a13a@weidmueller.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706-upstreaming-macb-irq-storm-v1-2-ab3115b5a13a@weidmueller.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272270-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:christian.taedcke@weidmueller.com,m:christian.taedcke-oss@weidmueller.com,m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:haokexin@gmail.com,m:horms@kernel.org,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:robert.hancock@calian.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[weidmueller.com,bootlin.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,goodmis.org,calian.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,weidmueller.com:email,linutronix.de:from_mime,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC5397127BB

On 2026-07-06 16:02:15 [+0200], Christian Taedcke via B4 Relay wrote:
> From: Christian Taedcke <christian.taedcke@weidmueller.com>
> 
> macb_interrupt() defers TX completion handling to NAPI, but when it
> schedules the poll it only masks TCOMP, even though TXUBR is enabled
> alongside it (both are part of MACB_TX_INT_FLAGS). macb_tx_poll() is
> asymmetric in the same way and only re-enables TCOMP. TXUBR is thus
> left unmasked while responsibility for handling it has been deferred
> to NAPI.

So this is not a race condition, this is always a failure?

Sebastian

