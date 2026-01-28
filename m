Return-Path: <stable+bounces-211975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLRlJOYbemlS2QEAu9opvQ
	(envelope-from <stable+bounces-211975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:23:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F11A2B4E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B41EF30094EA
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E113B1DF27F;
	Wed, 28 Jan 2026 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gRKXGVnz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CBB279794
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610129; cv=none; b=smmzYAMkHCwoKX/qiGjNi17SLeibUwONuAjj2U74jTi0h0h5/w+9NvCT+aGj+yoLCU1OpAlEwYByRMRzcO0NY6SEpG4v+csWcuUBDp3iZnApYwVURg9T9dgMrZ7+jMJvL2ImORQFRjCjr83YeUOb6KaJ4Jsz3fUHTHnLz8/FLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610129; c=relaxed/simple;
	bh=FR/Fvb1i/90GdizSuMykaQQ0KQmFhPGbd+Ge4zPt5vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGdCz7ohI9SxQavGq1siur3x+bkvLaUaNB5hBeIubGRSQ8PZ9kpX0Jgrx7Myrl+PzZB8yNE4ly8dwNJsjLga7EDop8bpkVrPrucVTkf2BLtA3auznJo/X7CZ1ly2WolU9Vn4cIRcj7dpmXZajdoEMcMZf8hmMkzxzughVxv2jAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gRKXGVnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1B1C4CEF1;
	Wed, 28 Jan 2026 14:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769610128;
	bh=FR/Fvb1i/90GdizSuMykaQQ0KQmFhPGbd+Ge4zPt5vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRKXGVnzDw/OVYZoRFM7momACzw3EI8XaFQ3WNepVehtsxCoxQFq2BT33Ja/UJCi4
	 Yav1dck3+C5leWtUeSxKccJujVLTAB7M6uwCeXZ2n8P2TmNGJEdHRCAttC5Bwy0C6D
	 Rf1oBob1Gp+joc7bzGWdyo4DXnJjQmdQszJhczq8=
Date: Wed, 28 Jan 2026 15:21:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, Sasha Levin <sashal@kernel.org>,
	Thorsten Glaser <tg@mirbsd.de>, Helge Deller <deller@kernel.org>,
	Junjie Cao <junjie.cao@intel.com>,
	Gianluca Renzi <gianlucarenzi@eurek.it>,
	=?iso-8859-1?Q?Camale=F3n?= <noelamac@gmail.com>,
	William Burrow <wbkernel@gmail.com>, 1123750@bugs.debian.org,
	Salvatore Bonaccorso <carnil@debian.org>,
	stable <stable@vger.kernel.org>
Subject: Re: [5.10] regression: virtual consoles 2-12 unusable
Message-ID: <2026012823-carry-velvet-c587@gregkh>
References: <aUeSb_SicXsVpmHn@eldamar.lan>
 <176626831842.2137.9290349746475307418.reportbug@x61p.mirbsd.org>
 <Pine.BSM.4.64L.2512211617050.3154@herc.mirbsd.org>
 <aU68arLtS1_wZiMj@eldamar.lan>
 <176626831842.2137.9290349746475307418.reportbug@x61p.mirbsd.org>
 <CAN2UaigCW-BZTifuo-ADCw=uDq85A_KwOHcceyaXDnVo8OQZiQ@mail.gmail.com>
 <c5a27a57597c78553bf121d09a1b45ed86dc02a8.camel@decadent.org.uk>
 <2026010803-gem-puzzle-640d@gregkh>
 <64874115-dcc0-4f3d-9a82-2ad2abf86fbb@pobox.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64874115-dcc0-4f3d-9a82-2ad2abf86fbb@pobox.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211975-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[decadent.org.uk,kernel.org,mirbsd.de,intel.com,eurek.it,gmail.com,bugs.debian.org,debian.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 09F11A2B4E
X-Rspamd-Action: no action

On Thu, Jan 15, 2026 at 12:41:10AM -0800, Barry K. Nathan wrote:
> On 1/8/26 5:23 AM, Greg Kroah-Hartman wrote:
> > On Fri, Jan 02, 2026 at 05:26:22PM +0100, Ben Hutchings wrote:
> > > Hello stable maintainers,
> > > 
> > > Several Debian users reported a regression after updating to kernel
> > > version 5.10.247.
> > > 
> > > Commit f0982400648a ("fbdev: Add bounds checking in bit_putcs to fix
> > > vmalloc-out-of-bounds"), a backport of upstream commit 3637d34b35b2,
> > > depends on vc_data::vc_font.charcount being initialised correctly.
> > > 
> > > However, before commit a1ac250a82a5 ("fbcon: Avoid using FNTCHARCNT()
> > > and hard-coded built-in font charcount") in 5.11, this member was set
> > > to 256 for VTs initially created with a built-in font and 0 for VTs
> > > initially created with a user font.
> > > 
> > > Since Debian normally sets a user font before creating VTs 2 and up,
> > > those additional VTs became unusable.  VT 1 also doesn't work correctly
> > > if the user font has > 256 characters, and the bounds check is
> > > ineffective if it has < 256 characters.
> > > 
> > > This can be fixed by backporting the following commits from 5.11:
> > > 
> > > 7a089ec7d77f console: Delete unused con_font_copy() callback implementations
> > > 259a252c1f4e console: Delete dummy con_font_set() and con_font_default() callback implementations
> > > 4ee573086bd8 Fonts: Add charcount field to font_desc
> > > 4497364e5f61 parisc/sticore: Avoid hard-coding built-in font charcount
> > > a1ac250a82a5 fbcon: Avoid using FNTCHARCNT() and hard-coded built-in font charcount
> > > 
> > > These all apply without fuzz and builds cleanly for x86_64 and parisc64.
> > > 
> > > I tested on x86_64 that:
> > > 
> > > - VT 2 works again
> > > - bit_putcs_aligned() is setting charcnt = 256
> > > - After loading a font with 512 characters, bit_putcs_aligned() sets
> > >    charcnt = 512 and is able to display characters at positions >= 256
> > 
> > All now queued up, thanks!
> > 
> > greg k-h
> 
> For what it's worth, now that the above commits are queued up for 5.10.y:
> There are two more commits, which were previously applied to 5.15.y, that
> now apply to 5.10.y without merge conflicts (also without fuzz, if you apply
> the 5.15.y versions of the patches):
> 
> 
> a5a923038d70
> fbdev: fbcon: Properly revert changes when vc_resize() failed
> (previously applied to 5.15.64 and 5.19.6)
> 
> 3c3bfb8586f8
> fbdev: fbcon: release buffer when fbcon_do_set_font() failed
> (previously applied to 5.15.86, 6.0.16, and 6.1.2)
> 
> 
> After looking at these two commits, it seems to me that they are now
> applicable to 5.10.y, and I think they probably should be applied (unless
> I'm overlooking or missing something).

Both now applied, thanks!

greg k-h

