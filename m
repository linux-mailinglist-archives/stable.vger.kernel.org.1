Return-Path: <stable+bounces-267872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l5GNLhswOmqf3gcAu9opvQ
	(envelope-from <stable+bounces-267872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 09:04:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A196B4B0D
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 09:04:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="kSxQbX/V";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267872-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-267872-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 780D6300A255
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 07:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ADA399001;
	Tue, 23 Jun 2026 07:04:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5137B00E
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 07:04:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198293; cv=none; b=eIL5iHe0Fg6Jk9Ex4iifhMgRTDZF7N8zmaWb26yHcZjbnAFiJjIZ1ytqXG+h3MkXp/huNHjND3AoaDZ7kmGBdCgP97WBhyfFP84D5LLy4OLUDNadk260FsibBgCeYggj/eS1t0nvEag4m42EHBRDUlmVQC6xX/H3S5FAHEOePvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198293; c=relaxed/simple;
	bh=f9uRVhHYU17B9zzfziL6bvgeh49xE1v1kP5gfOKA8C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUdCgr5PRUrapoJ76aawrLgPAYn3/sq17ziwCNw1sCI6W0I2i7BpKyuFguzxyVGtFwFzLEgbgihiPbiSzcAXv5iF7YjUpGDt7fim4EOElHmGC8h/bkCXblBjUkB0hh9+rKtIltCbE8fXB9YXJeBBtGc68cIzgoDrAeWQ0NulhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kSxQbX/V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD4B1F000E9;
	Tue, 23 Jun 2026 07:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782198292;
	bh=SZslgiHYIytRgporNs6J4T5vY52BKPX+0IjbDd6qEXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kSxQbX/VFaoz98tYc03cuG7rUhhIUuq+N6okmdVdoJAg/zzqjebuoo1NWC4s8lRW9
	 XV6gXXe/MAFiZS96XTKH5MYs9r81VNwY2qddwRJKDuc+xNkvwjdAYLFEdiKFnoMqI0
	 av0vi8vmM/InyYxp4c3gh86HIwe2n9UGj4UeWBsU=
Date: Tue, 23 Jun 2026 09:03:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Faicker Mo <faicker.mo@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: need the upstream commit to be merged to stable kernel
Message-ID: <2026062331-bruising-wimp-74a7@gregkh>
References: <CAG9krM_RbUhPgkcP6DFJM=jgDxMCNu8032=pM5OS2Agcxm-UKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG9krM_RbUhPgkcP6DFJM=jgDxMCNu8032=pM5OS2Agcxm-UKQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:faicker.mo@gmail.com,m:stable@vger.kernel.org,m:faickermo@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267872-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34A196B4B0D

On Tue, Jun 23, 2026 at 02:35:18PM +0800, Faicker Mo wrote:
> Subject: net: net_failover: Fix the deadlock in slave register
> Commit: b84c563
> Reason: wish the upstream commit to be merged to 7.0, because Ubuntu
> 26.04 (LTS) uses this kernel. Thanks.
> 

Sure, but note that 7.0.y will go end-of-life in a matter of days :)

Also applied to 6.18.y which will not go end-of-life.

thanks,

greg k-h

