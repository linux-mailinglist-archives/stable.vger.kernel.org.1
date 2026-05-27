Return-Path: <stable+bounces-254578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL3QIW3hFmpIvAcAu9opvQ
	(envelope-from <stable+bounces-254578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:19:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5ED5E4112
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AE463011A65
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C8330C632;
	Wed, 27 May 2026 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="loD8M1Lx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251202253EB
	for <stable@vger.kernel.org>; Wed, 27 May 2026 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884302; cv=none; b=Ak4cbVJyT4w3BAKnQQdJehM4Z9kgjAQuUAPp1EwKxgkURypeIYsG2Ggv9szmGRROstIwpMcDqL8MIeP8H/EoUQZcN0CzV2XhV18iObqE+DmCrBPXh8LFTYq9YOJwV56bU3X1FS+zEjj8x0JuduTGCC5NH1f422g57TH7YC7nSzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884302; c=relaxed/simple;
	bh=tV0wYlVi1AobJpjosO8nflMAMucBDHQHLjFw0IatHXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyXCRz4OGikKkDmOGNYMVM5KgooDpV3BQ9UJT3Kd6RJlRrrf8mvbYyreADNEwhHffGg3RUiz/YDP8szO94JRsEhmlsD5o5p84+ZrfddyTc9H48Q/bOFAGYFj1JRYdYa4GVWw5MLrgs3FVXeaF6dPRV/8BcyYPGxg7ngxfq+Mryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=loD8M1Lx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181B51F000E9;
	Wed, 27 May 2026 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779884300;
	bh=HAfGq1QVonXETIMIP5pTaDxPGiy+roEBU16b+LwPzOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=loD8M1LxiBTBe8mHmgYjZ/NSHg04KHQcoEGfoIp5MLGlDaBasMU9yA7GINUV7QdrW
	 SdUq9KCrkTPJyLKUNJr4PzhfpBZ0NhI61wMnCxNdvqHTUTrS9dC4URgH/zj92cGoJN
	 cKWDIRnlAiyd3cFQX0oZkkI/E55WaNHwrijTXJlM=
Date: Wed, 27 May 2026 14:16:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: manizada <manizada@pm.me>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Please apply 3da1fdf4efbc to stable
Message-ID: <2026052725-stir-yearbook-e753@gregkh>
References: <HWDVTGhsU6ON7YOl4ipsBa-4aBO4UMs2EdpPPhEyYoOWmVqbo__aVWaSuEIqescKSIxPJalwVPc2BQax8VsPmuZUXyF14lBaCyyrnu2_40g=@pm.me>
 <2026052742-discharge-smudge-6453@gregkh>
 <ahbeRcvu5qN55gaE@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahbeRcvu5qN55gaE@eldamar.lan>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254578-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1B5ED5E4112
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 02:06:29PM +0200, Salvatore Bonaccorso wrote:
> Hi Greg,
> 
> Not Asmin here, but saw the following.
> 
> On Wed, May 27, 2026 at 10:08:03AM +0200, Greg KH wrote:
> > On Tue, May 26, 2026 at 05:08:43PM +0000, manizada wrote:
> > > Hi stable team,
> > > 
> > > Please apply the following upstream commit to the supported stable trees:
> > > 
> > >   3da1fdf4efbc490041eb4f836bf596201203f8f2
> > >   smb: client: reject userspace cifs.spnego descriptions
> > > 
> > > Reason:
> > >   cifs.spnego descriptions contain authority-bearing fields consumed by
> > >   cifs.upcall. This commit prevents userspace from creating trusted
> > >   cifs.spnego descriptions via request_key(2)/add_key(2).
> > > 
> > > Requested branches:
> > >   Please apply to all currently supported stable/LTS branches where it is
> > >   applicable, including 7.0.y, 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y, and
> > >   5.10.y.
> > 
> > This does not apply to the 5.15.y or 5.10.y tree, please provide a
> > backported version that can apply there.
> 
> There was 38c8a9a52082 ("smb: move client and server files to common
> directory fs/smb") moving the files around (and which got as well
> backported to the 6.1.y series). So the following should do the trick.

That worked, thanks!

greg k-h

