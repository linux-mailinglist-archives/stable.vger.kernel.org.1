Return-Path: <stable+bounces-121367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AA8A5663A
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 12:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61DE163EE9
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 11:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD1D2153C8;
	Fri,  7 Mar 2025 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nMnmuuPB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA05E215168
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345548; cv=none; b=ukgWq/V6MYHnrucDoru7Ujcu/krdMP6Jhmo1g5y3o2M9gMoIhWXzVkPvtSA6F5tkFAy5R+1zl5CkGQAsr31JI5JRK3tPb//4AnIu7HvbsUF1i3ddO+OKV0h9tlAsdYDkyyKYpsRMRKyMi/hCIqWfRiqI3lq9zRDOuPD/iRRxcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345548; c=relaxed/simple;
	bh=zR61lmyxH3tMIa24GMAu8Fl+eNFCIaTKFwl4+DL+Rxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRhuPtol4hhk9q7eg2SxpzMSYi9JUSf2X90Ul6PbLZF7qDKgeFdMWV3wZagHzWClz0pdMRzb/wrMUk2Rm06ZZZw3+CB5BFM0tFZ1traDqwo7tLSqgzhQiiH9Ctt4lNPhVcQtkKZeg4zSMm1g0hd8MGXuDY95JJYY9zEHpUM86MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nMnmuuPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3D1C4CED1;
	Fri,  7 Mar 2025 11:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741345547;
	bh=zR61lmyxH3tMIa24GMAu8Fl+eNFCIaTKFwl4+DL+Rxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMnmuuPBczHpIB4RYpw467jKT9rxNxe+C/tIwNQkWpSWmzwkF5WHH7Z/mEZ05xBwk
	 nh2UlWVhl8cRcSCupJJB4KlnESgVzt1d1PkxClssLoFwLZ0judA5fI+In2CTjeq0kW
	 3MyDZdDkl9+5Xl7lmEURfKa285ja4iQci2r1kats=
Date: Fri, 7 Mar 2025 12:05:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
Cc: Jared Finder <jared@finder.org>, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@hboeck.de>,
	Jiri Slaby <jirislaby@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] tty: Require CAP_SYS_ADMIN for all usages of
 TIOCL_SELMOUSEREPORT
Message-ID: <2025030708-tidal-mothproof-0deb@gregkh>
References: <491f3df9de6593df8e70dbe77614b026@finder.org>
 <20250223205449.7432-2-gnoack3000@gmail.com>
 <20250307.9339126c0c96@gnoack.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250307.9339126c0c96@gnoack.org>

On Fri, Mar 07, 2025 at 11:16:21AM +0100, Günther Noack wrote:
> On Sun, Feb 23, 2025 at 09:54:50PM +0100, Günther Noack wrote:
> > This requirement was overeagerly loosened in commit 2f83e38a095f
> > ("tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN"), but as
> > it turns out,
> > 
> >   (1) the logic I implemented there was inconsistent (apologies!),
> > 
> >   (2) TIOCL_SELMOUSEREPORT might actually be a small security risk
> >       after all, and
> > 
> >   (3) TIOCL_SELMOUSEREPORT is only meant to be used by the mouse
> >       daemon (GPM or Consolation), which runs as CAP_SYS_ADMIN
> >       already.
> 
> 
> Greg and Jared: Friendly ping on this patch.

I think my bot found a problem with the v2 version so I was waiting for
a new one to meet the issues there, right?

Other than that I don't have a problem with this change.

thanks,

greg k-h

