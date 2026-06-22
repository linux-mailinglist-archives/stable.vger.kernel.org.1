Return-Path: <stable+bounces-267667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eauGJxEPOWqamAcAu9opvQ
	(envelope-from <stable+bounces-267667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 12:31:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBC66AEB77
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 12:31:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b="KS17N/yh";
	dkim=pass header.d=linutronix.de header.s=2020e header.b=CtJOklFL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267667-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267667-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D90B30413AE
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 10:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8BD3A5995;
	Mon, 22 Jun 2026 10:27:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A693A543A
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 10:27:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124075; cv=none; b=PUSUguVDCa2FMVDAZ1eFxfF+WaqEfSK4EaC35qqu4e73tjrY85bodFQpwRe7VDIFrv17+amCyJzbkAhnIPvYcVZSgm0I1dndg9WHGanZ6DRaN1OzksxmbaQEQPAyEGnt4gR2XzXuUXGim7RBY928SwVWsp8L1bsJ7FPsr0nepsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124075; c=relaxed/simple;
	bh=WKHcFZO2rpkCa8F4CHPzSqRTrUd2TU9dM7KkXClfL+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeLfKrUtRay1KlxeIM68frjOjTVm09RXD7kBWF2qdy4ASGc/eXQGG3KtpAa4DijaLrOhRkz4FnCOcmeub9m0uMetgDnptj99/PFuRsEpLti1YmjWu8ZSwMiNJ4vz01Lxh8XW9ajlk5tEDVRbeSICDW43DzDNNQwXT9l2BK2K9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KS17N/yh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CtJOklFL; arc=none smtp.client-ip=193.142.43.55
Date: Mon, 22 Jun 2026 12:27:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782124072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s038YWIfUpBDCuiGtkkXVvM91k1d45bdU4KObnsKNTM=;
	b=KS17N/yhtGlAEzPY9GYkkf37vknNhhW/F4aOPJHWgOO5QoLg+Kdo+kjJ5n5Vdi01oQlScr
	vX7gqadVQ3DEg+5XdP94bR8t8CJNC36bS0fRSWzsFQ6sYN51nYqDbGu9eUeQX/wgUHp2CO
	8uT3cSFOtNUHxYwocsmkSsqxLsOpLtsFbGGh8XMfT9PGeZr6t6XQoVMOYfme5BoGn/RtSx
	Zrw5tX1gmbVle0UJzWlHKMLHdHM3SOTvs7gXQGS3PORnGEttpAuLeplqHsL0mdffDLw+gu
	fsgaveR8CX/gNkN4xiPB0wjhoihotdaCLGsx7nMqf02q7wl6LCFnnHt0f1bvwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782124072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s038YWIfUpBDCuiGtkkXVvM91k1d45bdU4KObnsKNTM=;
	b=CtJOklFLBivk0B4Szp5IZIQwhXTnQ6X1hJ/ZPE87NOUsHtUfJijYI+aG+93ou1PfVlhwov
	IVlTRAp3ySHzTsBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 0/4] ARM: stable backports
Message-ID: <20260622102750.RMAlQTxT@linutronix.de>
References: <20260511135357.2786242-1-bigeasy@linutronix.de>
 <20260608082818.LZiPJ9ot@linutronix.de>
 <2026060832-extortion-cattail-2467@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026060832-extortion-cattail-2467@gregkh>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267667-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:bb@ti.com,m:daniel.wagner@monom.org,m:jan.kiszka@siemens.com,m:cip-dev@lists.cip-project.org,m:nobuhiro.iwamatsu.x90@mail.toshiba,m:pavel@nabladev.com,m:rmk+kernel@armlinux.org.uk,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linutronix.de:dkim,linutronix.de:mid,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BBC66AEB77

On 2026-06-08 16:12:05 [+0200], Greg KH wrote:
> We have hundreds of patches in the backlog right now, these are way down
> the list, sorry.  Hope to catch up "soon"...

No need to be sorry. Thank you (two) for doing the work.

> thanks,
> 
> greg k-h

Sebastian

