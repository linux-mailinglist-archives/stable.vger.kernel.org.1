Return-Path: <stable+bounces-267873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xm6gIp4wOmrJ3gcAu9opvQ
	(envelope-from <stable+bounces-267873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 09:07:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 070A36B4B31
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 09:07:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=OSKbVgWm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267873-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267873-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CABF330078D1
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 07:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFE039D6EF;
	Tue, 23 Jun 2026 07:06:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCDD399001
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 07:06:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198412; cv=none; b=krYI4Rz1KZO5gE8bHhguMlzWwQuaQiPcezCZwl3qVii7wPpSef84abXQ6aQVd+uF9SrMWBPoSlRDCGr8/Ji0n38act6El5R94O6kc7L5kLp+bRFozJNYCVsVmySRt7RlTBk8nQK1Z3t7DCVm24g888M/g+pnzdtRfGXc5A9HiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198412; c=relaxed/simple;
	bh=4s7onRT01ASFyKqHj9AVpQMGFNh/pfCV695fBbGFx7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr2Wp9KMWyKZLwTNXmd1KJsZUcWYbnIqiMFkY8pkYdagHrvSsImRWO1xV9l2doVL0B6FzWMHrSzlaHCDVCSionTliVQkr+8huxa6L59ItB7Sw//+2izbT9ybe8esXC7lKs0KnGpOx6uYwZd2ZAO9JiuMAP2W9l8rXmNtRUEQvhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OSKbVgWm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E7A1F000E9;
	Tue, 23 Jun 2026 07:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782198410;
	bh=D98xzTk2QBfOwFijV4+apc2Xxh6rGbchzapzxTZYbGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OSKbVgWmhpTEtJAx2Um3PWtWmS4OLg780FzibO35xJcuqQfQ3tsLb65IC+ERsF+1o
	 ky1i955/rtm/R7TEMlWzTUTWbiF/6OmoLY71feEIS56BVsenCinfTAZt/nz4KEee/E
	 gsTUGRQqNZ2GgFKb5eSL7nSCvNz7oFE+gdZQ4MLg=
Date: Tue, 23 Jun 2026 09:05:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Faicker Mo <faicker.mo@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: need the upstream commit to be merged to stable kernel
Message-ID: <2026062320-backtrack-unusable-96e1@gregkh>
References: <CAG9krM_RbUhPgkcP6DFJM=jgDxMCNu8032=pM5OS2Agcxm-UKQ@mail.gmail.com>
 <2026062331-bruising-wimp-74a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026062331-bruising-wimp-74a7@gregkh>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:faicker.mo@gmail.com,m:stable@vger.kernel.org,m:faickermo@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267873-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 070A36B4B31

On Tue, Jun 23, 2026 at 09:03:42AM +0200, Greg KH wrote:
> On Tue, Jun 23, 2026 at 02:35:18PM +0800, Faicker Mo wrote:
> > Subject: net: net_failover: Fix the deadlock in slave register
> > Commit: b84c563
> > Reason: wish the upstream commit to be merged to 7.0, because Ubuntu
> > 26.04 (LTS) uses this kernel. Thanks.
> > 
> 
> Sure, but note that 7.0.y will go end-of-life in a matter of days :)
> 
> Also applied to 6.18.y which will not go end-of-life.

Nope, breaks the build :(

Please provide a working backport if you need/want a commit backported.

thanks,

greg k-h

