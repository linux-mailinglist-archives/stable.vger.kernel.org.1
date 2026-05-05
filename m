Return-Path: <stable+bounces-244019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ2YOSyx+Wld/AIAu9opvQ
	(envelope-from <stable+bounces-244019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:58:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E58D4C9029
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F07D4302D08D
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 08:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3892C31716A;
	Tue,  5 May 2026 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hOTvelri"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E3D20E702
	for <stable@vger.kernel.org>; Tue,  5 May 2026 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971209; cv=none; b=Q9CLqpf98NgtwKVZkNFqh6yyJugI/20bXw+aCiUg5yagbbPxqsBQ4HbiWffuJP/oLfmCSykvMW3L0ZBfEBBYsfHzZHo+gv+885gSTIeKLVlw5fnZLgJfhWtMBsTYEkm2f2n40EhjydMB07YHUmP4Lc/L+J9pnwgLIGIUb/i/LWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971209; c=relaxed/simple;
	bh=sEAa6n83dPTmSHJUsCODHo6wB+/ZYCMeyMJve+9X6vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsmUVWGsJOHAx8dO2bbvbOSqK+T4WOeVRpygdbLyPS5TJLi4KPh5zHqYY4APqJGzg0+MRENWodJonyxEHWInrUGSuQBD05BoTi4dlT3V/A7648iIY3O3b6UabNMk+z1ZQomDm11BoVnfNcQqCA/0/aarbIy94X8tBKvP9PWQ2Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hOTvelri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FBAC2BCB4;
	Tue,  5 May 2026 08:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777971208;
	bh=sEAa6n83dPTmSHJUsCODHo6wB+/ZYCMeyMJve+9X6vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOTvelriqFBpdsbSZDDkDqxAWkjo3Xjx11MKrUmyTQMtYPfhcJUFCrJdJjL/bmYhT
	 4rdImBIGcDeAlYpIHNs+IsztdvHSuYdfvJWzzqNME0YbhBdu1LmT3ncTlGaYotjNAi
	 zSaVQqQIfXKkNvj1X736MkRrd1qmZryP6a6P0hl8=
Date: Tue, 5 May 2026 10:53:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: pavel@nabladev.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	stable@vger.kernel.org, cip-dev@lists.cip-project.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [cip-dev] [PATCH for 5.10.y] phy: renesas: rcar-gen3-usb2: Fix
 the use of msleep during spinlock
Message-ID: <2026050519-stencil-sequester-187b@gregkh>
References: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
 <afhkX2Ys2BG1gnqy@duo.ucw.cz>
 <31002e6e-3983-4e30-aef6-bd2cd51aec40@tuxon.dev>
 <f81033c2-3432-4275-b5a7-78c61c31502a@tuxon.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f81033c2-3432-4275-b5a7-78c61c31502a@tuxon.dev>
X-Rspamd-Queue-Id: 6E58D4C9029
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244019-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nigauri.org:email,cip-project.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 11:49:24AM +0300, Claudiu Beznea wrote:
> 
> 
> On 5/5/26 11:40, Claudiu Beznea wrote:
> > Hi, all,
> > 
> > On 5/4/26 12:18, Pavel Machek via lists.cip-project.org wrote:
> > > Hi!
> > > 
> > > > From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > > > 
> > > > This fixes an issue caused by the use of msleep during spinlock.
> > > > In the original commit, msleep was changed to mdelay, but this fix was not
> > > > carried over during the backport to 5.10.y tree.
> > > 
> > > Doing this as a quick fix is probably okay, but this should not be
> > > final version.
> > > 
> > > You are right that msleep inside spinlock will blow up immediately:
> > > 
> > > > ```
> > > > [   62.677594] BUG: scheduling while atomic: kworker/1:2/126/0x00000002
> > > > [   62.683957] Modules linked in:
> > > 
> > > But mdelay for 20 msec inside irqsave spinlock is borderline
> > > unacceptable, too.
> > > 
> > > I believe we'll need Renesas to analyze/fix this properly after the
> > > CVE emergency is done.
> > > 
> > > This fix is good for now, but better fix is needed.
> > > 
> > > Claudiu, are you right person for this, or should we cc someone else?
> > 
> > I'm going to investigate and come with a better approach for this.
> 
> On a second thought, the proper fix would have to go to upstream first. To
> fix the problem currently seen, could we integrate this patch as is?

No, please work upstream first.

