Return-Path: <stable+bounces-268403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LYjFAcwnPWo2yAgAu9opvQ
	(envelope-from <stable+bounces-268403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:06:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 471476C5E47
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:06:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=fiSxugUj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268403-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268403-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 777E93038C7D
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CFD1DB551;
	Thu, 25 Jun 2026 13:01:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3871212566
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 13:01:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392484; cv=none; b=Lkt/EsqVz0CiyazwEwC3R39rwMxRI6zoSAlLKZz7TXJ9rr9Akbq/9TTWYjRxPjqNYZbP5KK9WrPt60IpwGV/fKYaPTEWJrLnz+pbIIvH7yR2LUlYD7Y4pAnEVjUhkDLYzwQHpVnJ107RpFIgjXe2Ye+ifuzjWm7X58yOZGN8aOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392484; c=relaxed/simple;
	bh=culk48HL8bXpu0r6FCRlrYUTQGpj6eC0Vq/pDDnEH6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jV82J23REqeibC+7i11VaJr8aGJNI5jzpSVrh77r8Bwy+0iT9C798ak2MKhM69mBExTd7fb1pmj3wjIX/Dapnhe0w+9RTI5zzZxiw5cFnMp/sXU6RG/bGWjpeexzxBg3fkCDRU3AllQayaBnnx2VY/1LrNG8lsDAfCWXQLpvqSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fiSxugUj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BDA1F000E9;
	Thu, 25 Jun 2026 13:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782392483;
	bh=iVLD/Mi/f86fBSiMdLQaqOP4RSHQzTVoQRncNaHo6zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fiSxugUjpDcnQsMgCqPjVg8qmGiHIffyg6o4kKRwVGyFQgSws0eaPCqETjWS7psqn
	 QSivNBkx3+Wnr58aCpZ4OaiRBX0x3KqlIpGW2Ykk3sOwWVFf9Hh9taL04koGMbTZbx
	 ufUR9/V0G0YgXtu3uDkZBLvdC5b96qW99uzqnNAU=
Date: Thu, 25 Jun 2026 13:53:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Faicker Mo <faicker.mo@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: need the upstream commit to be merged to stable kernel
Message-ID: <2026062530-kinship-repackage-8875@gregkh>
References: <CAG9krM_RbUhPgkcP6DFJM=jgDxMCNu8032=pM5OS2Agcxm-UKQ@mail.gmail.com>
 <2026062331-bruising-wimp-74a7@gregkh>
 <2026062320-backtrack-unusable-96e1@gregkh>
 <CAG9krM9398KH27SngNaujagzMz6DYfcSBFYzFaxj8aZMRh7_iQ@mail.gmail.com>
 <2026062536-pleat-unpiloted-9a6c@gregkh>
 <CAG9krM-Ny2dL28umOotOGg8YtXkcReb11_QtyFMg8eJ=kNeiEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9krM-Ny2dL28umOotOGg8YtXkcReb11_QtyFMg8eJ=kNeiEg@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-268403-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:from_mime,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 471476C5E47

On Thu, Jun 25, 2026 at 08:11:18PM +0800, Faicker Mo wrote:
> On Thu, Jun 25, 2026 at 3:32 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jun 25, 2026 at 11:42:31AM +0800, Faicker Mo wrote:
> > > On Tue, Jun 23, 2026 at 3:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Jun 23, 2026 at 09:03:42AM +0200, Greg KH wrote:
> > > > > On Tue, Jun 23, 2026 at 02:35:18PM +0800, Faicker Mo wrote:
> > > > > > Subject: net: net_failover: Fix the deadlock in slave register
> > > > > > Commit: b84c563
> > > > > > Reason: wish the upstream commit to be merged to 7.0, because Ubuntu
> > > > > > 26.04 (LTS) uses this kernel. Thanks.
> > > > > >
> > > > >
> > > > > Sure, but note that 7.0.y will go end-of-life in a matter of days :)
> > > > >
> > > > > Also applied to 6.18.y which will not go end-of-life.
> > > >
> > > > Nope, breaks the build :(
> > > Hi, I tested it with make defconfig(CONFIG_NET_FAILOVER=y), make
> > > vmlinux, no errors.
> > > Both 7.0.y and 6.18.y branches were tested.
> >
> > Here's what I get:
> >
> > $ make -j100
> >   DESCEND objtool
> >   CALL    scripts/checksyscalls.sh
> >   INSTALL libsubcmd_headers
> >   CC [M]  net/core/failover.o
> >   CC [M]  drivers/net/net_failover.o
> >   MODPOST Module.symvers
> > ERROR: modpost: "netif_open" [drivers/net/net_failover.ko] undefined!
> > make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> > make[1]: *** [/home/gregkh/linux/stable/linux-7.0.y/Makefile:2061: modpost] Error 2
> > make: *** [Makefile:248: __sub-make] Error 2
> Got this.
> Need commit 3fdd33697c2b(net: export netif_open for self_test usage)

Ok, that worked better, thanks.

greg k-h

