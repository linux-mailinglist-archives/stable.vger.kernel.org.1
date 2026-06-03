Return-Path: <stable+bounces-260074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VH4KNJshIGpFwgAAu9opvQ
	(envelope-from <stable+bounces-260074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 14:44:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1D9637A5D
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 14:44:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260074-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260074-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFA8B30E1581
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB593D4107;
	Wed,  3 Jun 2026 12:26:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042CC3CF94E;
	Wed,  3 Jun 2026 12:26:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489602; cv=none; b=rJR2RhBW2SPwyR/aokYjk3/wEh8f5iKL+G98tmni643dPBfUgxab6lffoqnl+VsIKeVrhpx6WmUEM5PBvyfZO1FCapDGRJB1dKfDrEeKpKR7bkBxIMdmQPpFo/iHfu59XEoCBRJjOW6yg4MSBb1JbWN2HxS0D+3GNCEtDfFPEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489602; c=relaxed/simple;
	bh=vQTDnlvp1Cgx+/xFkKa5SSX6tyuC2rRhTo69Y+n63Zs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F5Gb75XRFtxB/clCTH21ghQAnxVR4Z8De2xq4Eoq307W/Hojms/+M/WfgU114TdXtSe9di4MOsBgsUO4djNEfNvedLeGIzMM5gEzgniVz3+u5rPaq+HkM0+aBi4/02tbNet/Fe9FWOmYQij+HwOpw5qvWpSE3Ti57mUWD5Up4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 904C99200B4; Wed,  3 Jun 2026 14:26:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8AE5892009C;
	Wed,  3 Jun 2026 13:26:39 +0100 (BST)
Date: Wed, 3 Jun 2026 13:26:39 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jacques Nilo <jnilo@free.fr>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] serial: core: introduce
 guard(uart_port_lock_check_sysrq_irqsave)
In-Reply-To: <3849af4bc55d5d2a424fa850844e94d641b2f8a6.1778675349.git.jnilo@free.fr>
Message-ID: <alpine.DEB.2.21.2606031313460.22659@angie.orcam.me.uk>
References: <cover.1778592805.git.jnilo@free.fr> <cover.1778675349.git.jnilo@free.fr> <3849af4bc55d5d2a424fa850844e94d641b2f8a6.1778675349.git.jnilo@free.fr>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jnilo@free.fr,m:gregkh@linuxfoundation.org,m:jirislaby@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:andriy.shevchenko@linux.intel.com,m:linux-serial@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[orcam.me.uk];
	FREEMAIL_TO(0.00)[free.fr];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260074-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[macro@orcam.me.uk,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,angie.orcam.me.uk:mid,vger.kernel.org:from_smtp,orcam.me.uk:from_mime,orcam.me.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C1D9637A5D

On Wed, 13 May 2026, Jacques Nilo wrote:

> Add a dedicated guard(uart_port_lock_check_sysrq_irqsave) variant
> whose destructor is the sysrq-aware unlock helper. The lock side is
> identical to uart_port_lock_irqsave -- only the unlock-time behaviour
> differs. Callers that may capture SysRq characters must use
> guard(uart_port_lock_check_sysrq_irqsave); the existing
> guard(uart_port_lock_irqsave) keeps its current plain-unlock semantics
> for the many callers that do not process RX.

Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej

