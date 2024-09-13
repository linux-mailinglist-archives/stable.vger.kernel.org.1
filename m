Return-Path: <stable+bounces-76061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86C9977FC3
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6B01F22FCF
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF001D7E5A;
	Fri, 13 Sep 2024 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e4kgR371"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE3A1C2BF;
	Fri, 13 Sep 2024 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230166; cv=none; b=g+NfoP2K3o6AW85HZMJJPjW4LJSAh43uMFFyZUcmX1OetSoDpr4hdm5wByYyEysZPbPPRStCjX6b1OtvQzLPbb/pGcZMc7CE5L8EBU0pcgMWQaDTmKzzdFtJx6382cfSH6Ko/2DItQowip9i/M86UvWnbpa/wUtYibZRaHyMzwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230166; c=relaxed/simple;
	bh=tsjyV5WmCxOKrv8UlvO79U9fnpyBSl0fDpwhIEhOQvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7NS++DIWuYmLWVfbAD+QS+sFyAxFrGaood+tjiULe46o2X7mMu1VNmMjTWzl5vzCLp01Jgxy2cQaNeATIcy2IfORxfMTF2tg1Yl0hrnguLv1ksIV9+661a35+owg+OBIMlgLgvHSYwaflE1m7gDvulXx+DgcQg+hzcCascwlnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e4kgR371; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF345C4CEC0;
	Fri, 13 Sep 2024 12:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726230165;
	bh=tsjyV5WmCxOKrv8UlvO79U9fnpyBSl0fDpwhIEhOQvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e4kgR371V65iAMzz3d+5ghuPUs3ewdc0bx2GMQgM76rwfdUFZfcK11fbj4xDjWJDK
	 OT8t5aO38BmjK1BoSdjP9T5x0ipTR8CFGBwlM35E2yq0/6yUed4oCZdgpC/rjNUC5l
	 GgyJAWHCbcfBWoILL5zFn9vINtMhWrBWl5qm+vZw=
Date: Fri, 13 Sep 2024 14:22:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Richard Narron <richard@aaazen.com>
Cc: Linux stable <stable@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux kernel <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 5.15 000/214] 5.15.167-rc1 review
Message-ID: <2024091328-excusable-lubricant-c607@gregkh>
References: <4a5321bd-b1f-1832-f0c-cea8694dc5aa@aaazen.com>
 <2024091103-revivable-dictator-a9da@gregkh>
 <a6392c39-e12f-e913-8f4f-c135b283ce@aaazen.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6392c39-e12f-e913-8f4f-c135b283ce@aaazen.com>

On Thu, Sep 12, 2024 at 02:54:18PM -0700, Richard Narron wrote:
> On Wed, 11 Sep 2024, Greg Kroah-Hartman wrote:
> 
> > On Tue, Sep 10, 2024 at 03:54:18PM -0700, Richard Narron wrote:
> > > Slackware 15.0 64-bit compiles and runs fine.
> > > Slackware 15.0 32-bit fails to build and gives the "out of memory" error:
> > >
> > > cc1: out of memory allocating 180705472 bytes after a total of 284454912
> > > bytes
> > > ...
> > > make[4]: *** [scripts/Makefile.build:289:
> > > drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.ho
> > > st.o] Error 1
> > >
> > > Patching it with help from Lorenzo Stoakes allows the build to
> > > run:
> > > https://lore.kernel.org/lkml/5882b96e-1287-4390-8174-3316d39038ef@lucifer.local/
> > >
> > > And then 32-bit runs fine too.
> >
> > Great, please help to get that commit merged into Linus's tree and then
> > I can backport it here.
> 
> Thanks to Linus and Lorenzo and Hans there is new smaller fix patch in
> Linus's tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/staging/media/atomisp/pci/sh_css_frac.h?id=7c6a3a65ace70f12b27b1a27c9a69cb791dc6e91
> 
> This works with the new 5.15.167 kernel with both 32-bit (x86) and 64-bit
> (x86_64) CPUs
> 
> Can this be backported?

Yes it will, give us a chance to catch up :)

thanks,

greg k-h

