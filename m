Return-Path: <stable+bounces-108331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ECDA0A97B
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 14:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC3057A15F6
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 13:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4111B4258;
	Sun, 12 Jan 2025 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zgiIuc24"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176BF1B4124;
	Sun, 12 Jan 2025 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736687692; cv=none; b=AE9ucIxVHnNDTb6rJ76hmoDyQs/F5tL8wJueAEeve8xFxJAFD3FsA6Cq1NfS6EOgZ7h3Yonna946i+Hp0y62pCLWAcc/WogJOnhOxig7tPr/Ft1UmrcFldYB4NkkXjNuokDwdvZnDrf6c8T9++SEu2x6i66LdtTBIL1t6JlWVI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736687692; c=relaxed/simple;
	bh=kI/O3cVLgBjh8681nMP7WFYZyRBeeZ68L8dK6c5DHww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDkBeqOVakDBBJ4fx5ywByp2OggRV2gNXkGtIBDZZ9aKqWhYhH0qCk+hDIzqib3tvvPjHICYSoLzmaDxCSzKBNXcIr1WCPDOfj0YQjCpJ+3Sy6Ei1Ae2cy/TmAGPPZVeOqVs49x0zLK/rijTpGHPiv1Tse8OEI/pAqw44IAHb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zgiIuc24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5BEC4CEDF;
	Sun, 12 Jan 2025 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736687691;
	bh=kI/O3cVLgBjh8681nMP7WFYZyRBeeZ68L8dK6c5DHww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zgiIuc24rI8dlCpPSP0k5yA3s2zt2vr3+IUUC+Q7WlR6v6D1rx/7K3G2Z6SiMeudt
	 /mgQ3BAP7PGhVGfJa31EC50K/5XZBe9kDjuHR4yP1NeSBfxO7YnHpnCyPwr/OBw7tP
	 z9K6YohlAizj2X0SUbOJz8JaBEirXiyeddYtK3rQ=
Date: Sun, 12 Jan 2025 14:14:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: Jann Horn <jannh@google.com>,
	Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@hboeck.de>,
	Jiri Slaby <jirislaby@kernel.org>, linux-hardening@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] tty: Permit some TIOCL_SETSEL modes without
 CAP_SYS_ADMIN
Message-ID: <2025011205-spinout-rewrap-2dfa@gregkh>
References: <Z2ahOy7XaflrfCMw@google.com>
 <20250110142122.1013222-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250110142122.1013222-1-gnoack@google.com>

On Fri, Jan 10, 2025 at 02:21:22PM +0000, Günther Noack wrote:
> With this, processes without CAP_SYS_ADMIN are able to use TIOCLINUX with
> subcode TIOCL_SETSEL, in the selection modes TIOCL_SETPOINTER,
> TIOCL_SELCLEAR and TIOCL_SELMOUSEREPORT.
> 
> TIOCL_SETSEL was previously changed to require CAP_SYS_ADMIN, as this IOCTL
> let callers change the selection buffer and could be used to simulate
> keypresses.  These three TIOCL_SETSEL selection modes, however, are safe to
> use, as they do not modify the selection buffer.
> 
> This fixes a mouse support regression that affected Emacs (invisible mouse
> cursor).
> 
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/ee3ec63269b43b34e1c90dd8c9743bf8@finder.org
> Fixes: 8d1b43f6a6df ("tty: Restrict access to TIOCLINUX' copy-and-paste subcommands")
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
> Changes in V2:
> 
>  * Removed comment in vt.c (per Greg's suggestion)
> 
>  * CC'd stable@
> 
>  * I *kept* the CAP_SYS_ADMIN check *after* copy_from_user(),
>    with the reasoning that:
> 
>    1. I do not see a good alternative to reorder the code here.
>       We need the data from copy_from_user() in order to know whether
>       the CAP_SYS_ADMIN check even needs to be performed.
>    2. A previous get_user() from an adjacent memory region already worked
>       (making this a very unlikely failure)
> 
> I would still appreciate a more formal Tested-by from Hanno (hint, hint) :)

This really is v3, as you sent a v2 last year, right?

b4 got really confused, but I think I figured it out.  Whenever you
resend, bump the version number please, otherwise it causes problems.
Remember, some of use deal with thousands of patches a week...

thanks,

greg k-h

