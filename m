Return-Path: <stable+bounces-28652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E45B8887985
	for <lists+stable@lfdr.de>; Sat, 23 Mar 2024 17:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948211F219B6
	for <lists+stable@lfdr.de>; Sat, 23 Mar 2024 16:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E087847A7C;
	Sat, 23 Mar 2024 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hrNKOM16"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8810614AA3;
	Sat, 23 Mar 2024 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711212447; cv=none; b=HZ8Gu5ZHD9Yht4wSjT+UVsK95oScnkF7B4lhSWaOz2bH9EhRosrbBheDLuGl00VsC0v43uNMYOq1QbHh4+RE70+oj7JWlpgtaQqdfzqrnvRau1oHNX+mY3dBZkH1mzbb1vgIgQF8x5QNR9N4nn0awH/Fwlc/ipPOvz6dr5WRbak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711212447; c=relaxed/simple;
	bh=zO/bq1x1IWqrsulMX03pMuwnTeqq+K2YvqFRY/ApVtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHd0hkyAMlN/D7soa5FqOwSb/dbBGlV26YkpX0DOvDd0LRLQRs42JZPw1utP4938tuARcIO4/TPW7XpktpDB39ktyTBnsZzLws1WDYgx+pyRZ7qXXi73cnO2fNXFDrA3HH8mkrtwDdlZy2c2U/SVFIoVSGXVQYN1K0tNniLX6F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hrNKOM16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57317C433F1;
	Sat, 23 Mar 2024 16:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711212446;
	bh=zO/bq1x1IWqrsulMX03pMuwnTeqq+K2YvqFRY/ApVtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrNKOM1699QSYYb6T2P/hjBFVEJ5obmViDzUShOfKnbRXX0kR80YFtZs/mITwb4IY
	 j6B70CpCMv+ame/fnjlMFdVtNucWqB+3YwT1RWvBr3ItxJ3p28R7Upd00kqyOvvqXE
	 f06t4EjbJozywIAsYKqs3r8exzyPVltnUf4eKRZI=
Date: Sat, 23 Mar 2024 17:47:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Cc: Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kalle Valo <kvalo@kernel.org>, stable@vger.kernel.org
Subject: Re: Patch "wifi: wilc1000: revert reset line logic flip" has been
 added to the 6.1-stable tree
Message-ID: <2024032335-overdress-tinkling-e886@gregkh>
References: <20240322181725.114042-1-sashal@kernel.org>
 <4c87bc80-c4e4-4a7d-a1d4-c2f90ffbe791@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c87bc80-c4e4-4a7d-a1d4-c2f90ffbe791@bootlin.com>

On Sat, Mar 23, 2024 at 11:07:39AM +0100, Alexis Lothoré wrote:
> Hello,
> 
> On 3/22/24 19:17, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     wifi: wilc1000: revert reset line logic flip
> > 
> > to the 6.1-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      wifi-wilc1000-revert-reset-line-logic-flip.patch
> > and it can be found in the queue-6.1 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> This patch is expected to introduce a breakage on platforms using a wrong device
> tree description. After discussing this consequence with wireless and DT people
> (see this patch RFC in [1]), it has been decided that this is tolerable. However,
> despite the Fixes tag I have put in the patch, I am not sure it is OK to also
> introduce this breakage for people just updating their stable kernels ? My
> opinion here is that they should get this break only when updating to a new
> kernel release, not stable, so I _would_ keep this patch out of stable trees
> (currently applied to 6.1, 6.6, 6.7 and 6.8, if I have followed correctly).

No one should ever have anything "break" no matter if they update from a
normal release, or a stable release, so this is not a thing.  Either it
is ok for any release, or none, and needs to be reverted.

thanks,

greg k-h

