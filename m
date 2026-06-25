Return-Path: <stable+bounces-268287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UoBdJYjZPGo6tQgAu9opvQ
	(envelope-from <stable+bounces-268287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:32:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0038B6C3614
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:32:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Qw9xP0OM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268287-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268287-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F4763029E7A
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 07:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1F3379ECD;
	Thu, 25 Jun 2026 07:32:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F11378D89
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 07:32:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782372740; cv=none; b=CS7JU3N1ytzA1siRlnbzhTHPBez7dakD8nndEdghqwAAHkJBVmZR40wAAdNQumJOjxXQr2IKBISE0Tyz92w6eV7PD+R2pe3SuLaLy+YpnjsgP4yd8/nzjIyQDcpp4E49/w4rHSq143tJNoUa/4eYLyNmMClG3UUZE3taOO3zQzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782372740; c=relaxed/simple;
	bh=zevK5vF09d6T9kn9KhDm+RWkCiWy3KpFERzApn0czK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5VR/Qtajhtl8DzSb0d8CrWVl1j3Oe5RqZEUHako0p+Ml3GfF8wsouMLju8icwUcDat6DdS93Q2LnO3zV1UP5TzlPjYIDclvmBz8IXfHOprl1J16QrI2MgZsCQV2PKMa2/YDTwDQ8GX39+NgBq1eiNs8aq37eRRkxszFUHBensY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qw9xP0OM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4061F000E9;
	Thu, 25 Jun 2026 07:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782372739;
	bh=1tI5DV4QPJAYhk1GZLq5dEDXXnyejB+8Z3wWKxu2iKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qw9xP0OMU2Nk3/poNDhfRXCKoVkrLWZ+L1ttpZR8WR1WF6zo/nCb9jq1++108mnX4
	 ef+OHJXG//V4JfpC1zBGTnn76typTPjKq6Of2LO1y5v3P+49vXCZtH7BgbN3F6vxPe
	 CBC/a8tZbs5CrOLCsm/0DGYreylotf//bqRgMKH0=
Date: Thu, 25 Jun 2026 08:31:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Faicker Mo <faicker.mo@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: need the upstream commit to be merged to stable kernel
Message-ID: <2026062536-pleat-unpiloted-9a6c@gregkh>
References: <CAG9krM_RbUhPgkcP6DFJM=jgDxMCNu8032=pM5OS2Agcxm-UKQ@mail.gmail.com>
 <2026062331-bruising-wimp-74a7@gregkh>
 <2026062320-backtrack-unusable-96e1@gregkh>
 <CAG9krM9398KH27SngNaujagzMz6DYfcSBFYzFaxj8aZMRh7_iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9krM9398KH27SngNaujagzMz6DYfcSBFYzFaxj8aZMRh7_iQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:faicker.mo@gmail.com,m:stable@vger.kernel.org,m:faickermo@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-268287-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0038B6C3614

On Thu, Jun 25, 2026 at 11:42:31AM +0800, Faicker Mo wrote:
> On Tue, Jun 23, 2026 at 3:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jun 23, 2026 at 09:03:42AM +0200, Greg KH wrote:
> > > On Tue, Jun 23, 2026 at 02:35:18PM +0800, Faicker Mo wrote:
> > > > Subject: net: net_failover: Fix the deadlock in slave register
> > > > Commit: b84c563
> > > > Reason: wish the upstream commit to be merged to 7.0, because Ubuntu
> > > > 26.04 (LTS) uses this kernel. Thanks.
> > > >
> > >
> > > Sure, but note that 7.0.y will go end-of-life in a matter of days :)
> > >
> > > Also applied to 6.18.y which will not go end-of-life.
> >
> > Nope, breaks the build :(
> Hi, I tested it with make defconfig(CONFIG_NET_FAILOVER=y), make
> vmlinux, no errors.
> Both 7.0.y and 6.18.y branches were tested.

Here's what I get:

$ make -j100
  DESCEND objtool
  CALL    scripts/checksyscalls.sh
  INSTALL libsubcmd_headers
  CC [M]  net/core/failover.o
  CC [M]  drivers/net/net_failover.o
  MODPOST Module.symvers
ERROR: modpost: "netif_open" [drivers/net/net_failover.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
make[1]: *** [/home/gregkh/linux/stable/linux-7.0.y/Makefile:2061: modpost] Error 2
make: *** [Makefile:248: __sub-make] Error 2


