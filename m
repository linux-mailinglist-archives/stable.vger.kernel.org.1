Return-Path: <stable+bounces-39482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CA38A507F
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F434282E82
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE387F49C;
	Mon, 15 Apr 2024 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tjMfTDs8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B167317E;
	Mon, 15 Apr 2024 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185553; cv=none; b=RZXY6tBoI3sbzmKoJR9bswZF/XxIU1LYaTSgQktmSOv1FaiehACQsFXbwLfMr5xRNSn4GCg17VbLHfSmNv8Gx5LV9I677OgwZRzgdBfPNv8KK8/f5E8KbvuA7PDncJjpZi8yTEtJ2Sxknt4CQuTVCgKQNhr7aaPzGt7dobdvd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185553; c=relaxed/simple;
	bh=j6fv941MMBXFiSEv5/RaPglaGYGM5st5RNviikpwY04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5N4gwtjtNEvcjB9bgyAQ753J6K7EHaQKNSENznpR3/cAD99LXlyutx1fVqHb43GWTigZibRm4cuYTaGytWe18dD+kda/VUNoB0aJ9T1Dn7bDanBSLnWSq6eHQikfovWmdSvB5fBpJCTaMFYo82RS9Za1Hdab1Ut4bnCDq4mKCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tjMfTDs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F2BC113CC;
	Mon, 15 Apr 2024 12:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713185553;
	bh=j6fv941MMBXFiSEv5/RaPglaGYGM5st5RNviikpwY04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tjMfTDs8vFnWv1N+QzeEfQm0ERt9FcQXPQGL9aFe9lmKRoQ2DhC334lslhdvvqyn3
	 xe3EI5V3CecVDB1QQ0sHWJo/t6NfzkMAGxqemRI6BNCA06Bl1+ZNKyS8PC+gek+bad
	 M+Pe7XUrLS/f0a8dZFmZmUJeb9x2wMIDSc5CPORo=
Date: Mon, 15 Apr 2024 14:52:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	gbayer@linux.ibm.com, Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: Patch "Revert "s390/ism: fix receive message buffer allocation""
 has been added to the 6.8-stable tree
Message-ID: <2024041506-outer-encounter-e37b@gregkh>
References: <20240415085924.3035257-1-sashal@kernel.org>
 <20240415124216.7816-B-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415124216.7816-B-hca@linux.ibm.com>

On Mon, Apr 15, 2024 at 02:42:16PM +0200, Heiko Carstens wrote:
> On Mon, Apr 15, 2024 at 04:59:24AM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     Revert "s390/ism: fix receive message buffer allocation"
> > 
> > to the 6.8-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      revert-s390-ism-fix-receive-message-buffer-allocatio.patch
> > and it can be found in the queue-6.8 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit 8568beeed3944bd4bf4c3683993a9df6ae53fbb7
> > Author: Gerd Bayer <gbayer@linux.ibm.com>
> > Date:   Tue Apr 9 13:37:53 2024 +0200
> > 
> >     Revert "s390/ism: fix receive message buffer allocation"
> >     
> >     [ Upstream commit d51dc8dd6ab6f93a894ff8b38d3b8d02c98eb9fb ]
> >     
> >     This reverts commit 58effa3476536215530c9ec4910ffc981613b413.
> >     Review was not finished on this patch. So it's not ready for
> >     upstreaming.
> >     
> >     Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> >     Link: https://lore.kernel.org/r/20240409113753.2181368-1-gbayer@linux.ibm.com
> >     Fixes: 58effa347653 ("s390/ism: fix receive message buffer allocation")
> >     Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> I'm not sure if it makes sense to add and revert a patch within a
> single stable queue (the same applies to 6.6). It might make sense to
> drop both patches.

It makes it easier for us to track that this was applied, otherwise our
scripts get confused and keeps trying to add it back :)

thanks,

greg k-h

