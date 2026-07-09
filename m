Return-Path: <stable+bounces-273025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0KNTArj0T2pcrAIAu9opvQ
	(envelope-from <stable+bounces-273025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 21:21:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B366D734E3B
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 21:21:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ok7AZNxP;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273025-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-273025-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 834C3300C01C
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2283AFCE9;
	Thu,  9 Jul 2026 19:20:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34D349AFF;
	Thu,  9 Jul 2026 19:20:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624841; cv=none; b=bSB/GC4e9bmeffDbw3XcYacMcvnzYF8hTytYdnjzjltsQq7lt7J4Y3++dxS+jezplJxTcuqEIR2g1wmxp5iQa2T9wWI4XNwW91SSvVlglw3/n8muV1Zm/wqYnhqBAGJQKGsd4rDVmMj6fE2t7oxVyM7SfZSQAiOSg/unyRB5m08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624841; c=relaxed/simple;
	bh=P5sK9NprA4nFECMghBKHXOsfS7erHEbO6SI3xOIETy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgQb8h4C6QtD+Ao+/k91hbJ25O1tKP8OWcEsYpGdJuoHLO2eXdTNdGd6XPWPDOqhiF+D1Hm26809JDwsU2T7jyMBF4nOtYQ029Lw31rN1JfEoApSoSiFBaJAheEUDjkC4XTNyFrqf/rTVMpVSG7a6t0vQ7xHThvVAGYkTfJM0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ok7AZNxP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028DA1F000E9;
	Thu,  9 Jul 2026 19:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783624839;
	bh=MO3r+XohUEwAecP18p9D9scY3bD04+5zmZZZ404/Jp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ok7AZNxPp71pUUcv/OrRr1HxQhhOFFmnlWo+UKFTcDZdR2HFYd+7EwWCwLPEHwC2h
	 R3sWaGKEfY3IexlHGEk3GjjXEm7Ddk0NTI1MqbhZh2QkHwRcxvtiobrRjcyFRbGeAO
	 t5NUyt5fqUttEBM6Ixp3B+7eLw0oMZcrLHxY/XVw=
Date: Thu, 9 Jul 2026 21:20:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Jiri Slaby <jirislaby@kernel.org>, Alexey Gladkov <legion@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, kbd@lists.linux.dev
Subject: Re: [PATCH] vt: fix spurious modifier in CSI/cursor key sequences
Message-ID: <2026070921-everglade-obligate-597c@gregkh>
References: <20260626024833.3419086-1-nico@fluxnic.net>
 <4ro94n6o-r585-9693-07op-6p196oo273no@syhkavp.arg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ro94n6o-r585-9693-07op-6p196oo273no@syhkavp.arg>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273025-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nico@fluxnic.net,m:jirislaby@kernel.org,m:legion@kernel.org,m:linux-serial@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kbd@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:from_mime,linuxfoundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B366D734E3B

On Thu, Jul 09, 2026 at 02:24:29PM -0400, Nicolas Pitre wrote:
> 
> Ping.
> 
> On Thu, 25 Jun 2026, Nicolas Pitre wrote:

Sorry, am still catching up on patches, hopefully will get through them
"all" tomorrow...

