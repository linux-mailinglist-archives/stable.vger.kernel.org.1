Return-Path: <stable+bounces-237863-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB8KDAA73mkxpgkAu9opvQ
	(envelope-from <stable+bounces-237863-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:02:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 693693FA42C
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE2093057137
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545BB3E6DCE;
	Tue, 14 Apr 2026 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kk21Wj6r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ta3fwnJh"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D596F3E6DDC;
	Tue, 14 Apr 2026 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171740; cv=none; b=ZUGTBCgtq0P9nwoL+SLYLTx5NyRwgPuN7yQ1UgPzJPUHvvYJOgQxjFuoK55hGV51gRpQEpsWPZFW9JmgRcJfCs9iNSG4iflfe0KE9dApE+Kw8NGSwScnqCrhNpQY/mIGcEKiXpo3c6T3dKzl5qpOF6d5h77m1UAAbE/YAvaMfEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171740; c=relaxed/simple;
	bh=PK3sq8t3E0t+ZSRuit9ZpFIdHONFLa626Az2fxiC/LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rakqaKw58WU8Znjd6Bi5M0AjlYLbKBUnoRD8ZaKG25d5XT4YEZdwhyeWNpiSmMiH30TYI08z7RsQ++3mw3vketwiiKVwMAbnBhwnwAv7FSzv3+6D9UAct6E/6+WuzY7kZAiG/q9ZivkvQV3zwXR7YYUj1JXSmf7u+jConFXmJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kk21Wj6r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ta3fwnJh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 Apr 2026 15:02:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776171737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bUFbGS28smoK+aZ7hRlIJDcZvCwREXti4XkgqB1hRKc=;
	b=Kk21Wj6r3YYrYAExb8u6F3MJhhhlJoTE6UUWNDIFAnM70cqK3QNiKxCr9wudg2CNps7iMA
	2D4hDssP51CGeLYOZbfTqiz19GUcUCgQPsKgcmoSEK9P5X26Y4IfvPHczMAIIylqor/bnB
	vo82k7r3bAqu7WP+pUU8hQn1uHTlM8Hjne/oRdwwfWrS/kKQ05BC2TQy3L1oOnAwGyJjM8
	gdKfoLzqj11+jQXy3sd8BHNwv3kZ4j0vD8VYHhBDitHwfGrFtJSpHg3kx0aDgbu6OLSCPl
	XoLk0mM41+M/DC9xhskj93KO0eWVmp/nVBQl0NFjgazMxnCiyHF1kUR5ypWPYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776171737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bUFbGS28smoK+aZ7hRlIJDcZvCwREXti4XkgqB1hRKc=;
	b=Ta3fwnJhIC043y8GS7jIghot1/KXoeOJQi9h6y6PlY/cDL/tdXTjktlCPAThGnzNOWrpGM
	Iw1dYu/6SACzP7AQ==
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
Subject: Re: [net,PATCH v3 2/2] net: ks8851: Avoid excess softirq scheduling
Message-ID: <20260414130216.FPwZgq-V@linutronix.de>
References: <20260414103327.113500-1-marex@nabladev.com>
 <20260414103327.113500-2-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260414103327.113500-2-marex@nabladev.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237863-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org,tipi-net.de,redhat.com,raritan.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,nabladev.com:email]
X-Rspamd-Queue-Id: 693693FA42C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-14 12:32:53 [+0200], Marek Vasut wrote:
> The code injects a packet into netif_rx() repeatedly, which will add
> it to its internal NAPI and schedule a softirq, and process it. It is
> more efficient to queue multiple packets and process them all at the
> local_bh_enable() time.
> 
> Fixes: e0863634bf9f ("net: ks8851: Queue RX packets in IRQ handler instead of disabling BHs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

