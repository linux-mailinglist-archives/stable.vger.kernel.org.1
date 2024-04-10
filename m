Return-Path: <stable+bounces-37924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC23189EA3A
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 07:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D5A7B20D72
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 05:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CC81A291;
	Wed, 10 Apr 2024 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rTINaJM1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B271664A
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712728730; cv=none; b=T71EhuspYMd6UJm8EXoK1fqOFtG1V/p9Y9PUbmyhGmW+RYxy/dLs5aLkE9ybh12xUFrbUdS9DaXdjWDD3K55U7fkJE72lKyqFasXiBRClzTuQu0bjjP5deA11V4JVRU1EcDLeS2dLiGBkVazKPzm/wIRDFVvzlGk/m7N+jCe1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712728730; c=relaxed/simple;
	bh=SalPWVPvjqvzrwox3nf7A0+g+HLyOtaiTZQKkdni9YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcRm4QDy1t7gvaQjj0rMUZKMGZ/Zf81+NJIaal3G3Jwwg54meqALtLG0E0hcX3KcUP7zN2LcN08yNFWvypDDpoFyWr4BRZVlu7oZKiA9Zo4eXegmMoQc/iSX5jELIcOAqb9vYkJmDUgRxWVvzuRMQbSVAWDK6SWYSYFtaCHfR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rTINaJM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A06C433C7;
	Wed, 10 Apr 2024 05:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712728730;
	bh=SalPWVPvjqvzrwox3nf7A0+g+HLyOtaiTZQKkdni9YQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rTINaJM1pxjSs4Ndm44SXG0BMGcjsElI3//xRGRwta/eqNosOaEEBR2fz3cz8GMVb
	 D5C2RrAkY4EEv9a51U6bJX0hs5nZh/23uiNBG5V5F1BiY75x2ysR+SBa2TCd90axFb
	 VELBLT7XtCb26a6L0Rll98MCSO8ZEU1RbWz95ZCc=
Date: Wed, 10 Apr 2024 07:58:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Steve French <smfrench@gmail.com>
Cc: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>, stable@vger.kernel.org,
	Shyam Prasad N <nspmangalore@gmail.com>, bharathsm@microsoft.com,
	Shyam Prasad N <sprasad@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>
Subject: Re: Requesting backport for fc20c523211 (cifs: fixes for
 get_inode_info)
Message-ID: <2024041021-enactment-filter-6ad9@gregkh>
References: <CAFTVevX=yujOXoDJYRJWuPgvWfVYUL5ZmoKfy_3u5qHi741Sag@mail.gmail.com>
 <2024040512-koala-landside-7486@gregkh>
 <CAH2r5mtcvQ7Dp5Pm-0XJHdYB44rkbrRG2OpDRQV0tB53vFFdSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5mtcvQ7Dp5Pm-0XJHdYB44rkbrRG2OpDRQV0tB53vFFdSA@mail.gmail.com>

On Wed, Apr 10, 2024 at 12:51:32AM -0500, Steve French wrote:
> On Fri, Apr 5, 2024 at 1:35 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Apr 03, 2024 at 12:34:43PM +0530, Meetakshi Setiya wrote:
> > > commit fc20c523211a38b87fc850a959cb2149e4fd64b0 upstream
> > > cifs: fixes for get_inode_info
> > > requesting backport to 6.8.x, 6.6.x, 6.5.x and 6.1.x
> > >
> > > This patch fixes memory leaks, adds error checking, and performs some important
> > > code modifications to the changes introduced by patch 2 of this patch series:
> > > https://lore.kernel.org/stable/CAFTVevX6=4qFo6nwV14sCnfPRO9yb9q+YsP3XPaHMsP08E05iQ@mail.gmail.com/
> > > commit ffceb7640cbfe6ea60e7769e107451d63a2fe3d3
> > > (smb: client: do not defer close open handles to deleted files)
> > >
> > > This patch and the three patches in the mails that precede this are related and
> > > fix an important customer reported bug on the linux smb client (explained in the
> > > mail for patch 1). Patches 2, 3 and 4 are meant to fix whatever regressions were
> > > introduced/exposed by patch 1.
> > > The patches have to be applied in the mentioned order and should be backported
> > > together.
> >
> > Then PLEASE send this as a patch series, as picking patches out of
> > emails that arrive in random order in a "correct" way is tough, if not
> > impossible for us to do.
> >
> > Please send these as a backported set of patches, OR as a list of
> > "cherry-pick these git ids in this order" type of thing.  But spreading
> > it out over 4 emails just does not work, and is very very confusing.
> 
> To make it easier, I recommend we wait a few days on this as there is
> one more important fix for this series that was recently found (by Paulo)
> and I haven't sent to Linus yet - then can send the complete set
> for at least 6.8 and 6.6 stable.  Do you prefer a separate email
> for the 6.8 version of these, and another for the 6.6 rebased
> version of the series - or all as one email? AFAIK she hasn't
> rebased for 6.1LTS.

If the versions are different, yes, individual series are appreciated.
If they are identical, one is fine.

thanks,

greg k-h

