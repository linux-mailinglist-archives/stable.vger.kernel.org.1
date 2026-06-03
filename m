Return-Path: <stable+bounces-260073-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CouDCoMdIGpdwAAAu9opvQ
	(envelope-from <stable+bounces-260073-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 14:26:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1A46377B4
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 14:26:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260073-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-260073-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0F623006B46
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 12:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237153D34B5;
	Wed,  3 Jun 2026 12:26:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284C3C4577;
	Wed,  3 Jun 2026 12:26:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489599; cv=none; b=iqJZaEMXptXiwGVq/th4zpUXKwX+vCJQMy4DnVvf5iycCfMl9u8LEdYVkZRC5YaNDoAd8BUZxUvZ39gR+ZSdCDij+D/OSSb8Lw2jCsPeJGt0VMtTPQ84+4oEVu9lLhOd9s0kzxnRexi9MveRW7FqsDf62ghiKSbc4Rz8cQJ5DV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489599; c=relaxed/simple;
	bh=iEw0d2HxGjaXO1qlltq6rX8bbbhmpUKAI2DaxgB8uVs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=axlNW16jaIs2I4NFaqe3NeumCBPrwGviBLTAeU72Npv0Q8RjZlfDjLOiky0J820hbUvlBFTVznqj4A8uCIsgk1ZGs8SXfn9CKb8HsmSLS0NmAhnPHmd36WX6HEZMFSMxLBF+SBfVflE7Clo89YS+ZO3V0xBnTAsTonGtugtTXy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 43DB39200B3; Wed,  3 Jun 2026 14:26:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 400C992009C;
	Wed,  3 Jun 2026 13:26:34 +0100 (BST)
Date: Wed, 3 Jun 2026 13:26:34 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jacques Nilo <jnilo@free.fr>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] serial: 8250: fix BREAK+SysRq dispatch on
 guard()-locked IRQ handlers
In-Reply-To: <cover.1778675349.git.jnilo@free.fr>
Message-ID: <alpine.DEB.2.21.2606031315270.22659@angie.orcam.me.uk>
References: <cover.1778592805.git.jnilo@free.fr> <cover.1778675349.git.jnilo@free.fr>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-260073-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[macro@orcam.me.uk,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,orcam.me.uk:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB1A46377B4

On Wed, 13 May 2026, Jacques Nilo wrote:

> This series fixes a silent regression where a SysRq character entered as
> BREAK + key on the serial console is consumed by the kernel but never
> dispatched to handle_sysrq(). Same description as v1 [1].

 Thanks for the report and working on a fix.  This issue hit me hard last 
week when chasing a bug with one of my systems where my debug hacks caused 
me to become unable to become root and reboot the system properly.  To my 
surprise I was unable to access any of the magic SysRq features either and 
consequently I had to power-cycle the system remotely via a PDU (it's some 
1600km/1000mi away).  I've now verified that 1/3 and 2/3 bring the feature 
back with patched 7.0.0 and said x86 PC.  No way to verify 3/3 though.

  Maciej

