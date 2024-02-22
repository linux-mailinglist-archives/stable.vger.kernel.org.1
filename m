Return-Path: <stable+bounces-23293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D299C85F1C3
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 08:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC551C20F61
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 07:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7613917583;
	Thu, 22 Feb 2024 07:08:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE86C7469;
	Thu, 22 Feb 2024 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708585694; cv=none; b=CDKxdixJanvm2ycXjiwvYAde2DeHf2g4WPL4Btk8/wTSJ5rqiVYIccHdx3jiHg70zI9I80NhEWJHkmu7Z19bs6Y6xZ28RVqyWGB2HnMLEs54Po0+UijzVPKXJi7kKkI53dsxTLYVhhYaz9bCH9BPpSUsS6qYTd0GHB9TQUu2Pa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708585694; c=relaxed/simple;
	bh=E5w37cV2AfWcKZkEVnT1YF4RZvFBCkYgBD97N+YjcJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4b5FDm85VvqF1b/Wi67Huo8xR+Ilh8Bw8xKlmBhf16+WxFvDY6kwfq3PidbQMnlR/hlQzF/gbn9v2N7gWPFGIa9yPhxih6Mxlt4RQ4pxgf0mJabh2/QUisN2OF8LrSI9hvfp3Zfp+2cGowmRvwnTD7JpguWjstG6jtgnG4u8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 1B1DC72C90D;
	Thu, 22 Feb 2024 10:08:03 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id 0B90536D016F;
	Thu, 22 Feb 2024 10:08:03 +0300 (MSK)
Date: Thu, 22 Feb 2024 10:08:02 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH] cifs: Convert struct fealist away from 1-element array
Message-ID: <20240222070802.pdxetqgin7cxdp7x@altlinux.org>
References: <20230215000832.never.591-kees@kernel.org>
 <qjyfz2xftsbch6aozgplxyjfyqnuhn7j44udrucls4pqa5ey35@adxvvrdtagqf>
 <202402091559.52D7C2AC@keescook>
 <20240210003314.jyrvg57z6ox3is5u@altlinux.org>
 <2024021034-populace-aerospace-03f3@gregkh>
 <20240210102145.p4diskhnevicn6am@altlinux.org>
 <20240217215016.emqr3stdm3yrh4dq@altlinux.org>
 <2024021808-coach-wired-41cb@gregkh>
 <20240221171346.iur7yuuogg2bu3lq@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20240221171346.iur7yuuogg2bu3lq@altlinux.org>

Greg,

On Wed, Feb 21, 2024 at 08:13:46PM +0300, Vitaly Chikunov wrote:
> On Sun, Feb 18, 2024 at 10:31:29AM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Feb 18, 2024 at 12:50:16AM +0300, Vitaly Chikunov wrote:
> > > 
> > > On Sat, Feb 10, 2024 at 01:21:45PM +0300, Vitaly Chikunov wrote:
> > > > On Sat, Feb 10, 2024 at 10:19:46AM +0000, Greg Kroah-Hartman wrote:
> > > > > On Sat, Feb 10, 2024 at 03:33:14AM +0300, Vitaly Chikunov wrote:
> > > > > > 
> > > > > > Can you please backport this commit (below) to a stable 6.1.y tree, it's
> > > > > > confirmed be Kees this could cause kernel panic due to false positive
> > > > > > strncpy fortify, and this is already happened for some users.
> > > > > 
> > > > > What is the git commit id?
> > > > 
> > > > 398d5843c03261a2b68730f2f00643826bcec6ba
> > > 
> > > Can you please apply this to the next 6.1.y release?
> > > 
> > > There is still non-theoretical crash as reported in
> > >   https://lore.kernel.org/all/qjyfz2xftsbch6aozgplxyjfyqnuhn7j44udrucls4pqa5ey35@adxvvrdtagqf/
> > > 
> > > If commit hash was not enough:
> > > 
> > >   commit 398d5843c03261a2b68730f2f00643826bcec6ba
> > >   Author:     Kees Cook <keescook@chromium.org>
> > >   AuthorDate: Tue Feb 14 16:08:39 2023 -0800
> > > 
> > >       cifs: Convert struct fealist away from 1-element array
> > > 
> > > The commit is in mainline and is applying well to linux-6.1.y:
> > > 
> > >   (linux-6.1.y)$ git cherry-pick 398d5843c03261a2b68730f2f00643826bcec6ba
> > >   Auto-merging fs/smb/client/cifspdu.h
> > >   Auto-merging fs/smb/client/cifssmb.c
> > >   [linux-6.1.y 4a80b516f202] cifs: Convert struct fealist away from 1-element array
> > >    Author: Kees Cook <keescook@chromium.org>
> > >    Date: Tue Feb 14 16:08:39 2023 -0800
> > >    2 files changed, 10 insertions(+), 10 deletions(-)
> > 
> > It does not apply cleanly due to renames, can you provide a backported,
> > and tested, patch please?
> 
> I sent the backported patch as you suggested[1] but I don't see it
> appearing in 6.1.79-rc1 review. Did I make some mistake while sending
> it?

Testing update - user (who had the kernel panic) tested and reported to
me that 6.1.78 with the patch applied does not cause the kernel panic
anymore in their workflow.

Thanks,

> 
> Thanks,
> 
> [1] https://lore.kernel.org/stable/20240218111538.2592901-1-vt@altlinux.org/
> 
> > 
> > thanks,
> > 
> > greg k-h

