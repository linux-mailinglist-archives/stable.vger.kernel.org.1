Return-Path: <stable+bounces-81192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429CC991DB8
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 12:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEAD42817B5
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DBC14C5B5;
	Sun,  6 Oct 2024 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cOmMrfQC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0F0F4F1
	for <stable@vger.kernel.org>; Sun,  6 Oct 2024 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728209511; cv=none; b=QApysSyWSrgLkP/NErqHF7LCc8LQ/7n1By+rKoVan0EVugWhL5okmZVoaMy5Oi7wQDQI8oBoshlK+1bzxBB0/YxJxgKW8DRRbAeyJlWbt9C8GNWeEfyOM+DOFCK3VLXvRM7TgOH9AAK+mGPTBdhdgRmxWmOxnsqJCDI+mvkcpcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728209511; c=relaxed/simple;
	bh=QJ2Hp1E2kJ93uyL3gDKDSb8gpjcmvbrrQjhETlzSfuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clehEKxckNCNLSbXMuWWKANT6i7EP7Kmrrj5tYaaSHR5ddSFMxWUH203fSaRpPr89WjHaj2I57GYCFc/1BiLf9Xac40fyqbB+gMi5X4JfnkY0/8s759YCQ86EqEBs0QhyaP/SxDOQq9EkkL+zsDxNkMBuuQUu8ARTnzKo3Xzang=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cOmMrfQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B11C4CECC;
	Sun,  6 Oct 2024 10:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728209511;
	bh=QJ2Hp1E2kJ93uyL3gDKDSb8gpjcmvbrrQjhETlzSfuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cOmMrfQCUj5qHyYhSvrpjyBOUDP3gkoXVqvWDcbt/MeFVa7+VpWFfPk6Rd5ScG+4T
	 FXeLkMdeMSZ4PU9DdAcwdkWUpAG3pU7uvo2bzY0RrNKPXNJ1PH8A7zUZ6KjgrPZg2v
	 0ctAkLDh9Zrw029RZLKIFr2/GlG0PrWASVm4/uBY=
Date: Sun, 6 Oct 2024 12:11:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, jiri@nvidia.com,
	stable@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, sashal@kernel.org, vkarri@nvidia.com
Subject: Re: [PATCH stable 6.1] devlink: Fix RCU stall when unregistering a
 devlink instance
Message-ID: <2024100632-overhead-entomb-0bcb@gregkh>
References: <20241001112035.973187-1-idosch@nvidia.com>
 <2024100135-siren-vocalist-0299@gregkh>
 <Zvv7X7HgcQuFIVF1@shredder.lan>
 <20241001153953.4de43308@kernel.org>
 <ZwJN-jZ82HpfF9PL@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwJN-jZ82HpfF9PL@shredder.mtl.com>

On Sun, Oct 06, 2024 at 11:44:42AM +0300, Ido Schimmel wrote:
> On Tue, Oct 01, 2024 at 03:39:53PM -0700, Jakub Kicinski wrote:
> > On Tue, 1 Oct 2024 16:38:39 +0300 Ido Schimmel wrote:
> > > > You need to document the heck out of why this is only relevant for this
> > > > one specific kernel branch IN the changelog text, so that we understand
> > > > what is going on, AND you need to get acks from the relevant maintainers
> > > > of this area of the kernel to accept something that is not in Linus's
> > > > tree.
> > > > 
> > > > But first of, why?  Why not just take the upstrema commits instead?  
> > > 
> > > There were a lot of changes as part of the 6.3 cycle to completely
> > > rework the semantics of the devlink instance reference count. As part of
> > > these changes, commit d77278196441 ("devlink: bump the instance index
> > > directly when iterating") inadvertently fixed the bug mentioned in this
> > > patch. This commit cannot be applied to 6.1.y as-is because a prior
> > > commit (also in 6.3) moved the code to a different file (leftover.c ->
> > > core.c). There might be more dependencies that I'm currently unaware of.
> > > 
> > > The alternative, proposed in this patch, is to provide a minimal and
> > > contained fix for the bug introduced in upstream commit c2368b19807a
> > > ("net: devlink: introduce "unregistering" mark and use it during
> > > devlinks iteration") as part of the 6.0 cycle.
> > > 
> > > The above explains why the patch is only relevant to 6.1.y.
> > > 
> > > Jakub / Jiri, what is your preference here? This patch or cherry picking
> > > a lot of code from 6.3?
> > 
> > No preference here. The fix as posted looks correct. The backport of
> > the upstream commit should be correct too (I don't see any
> > incompatibilities) but as you said the code has moved and got exposed
> > via a header, so the diff will look quite different.
> > 
> > I think Greg would still prefer to use the bastardized upstream commit
> > in such cases.
> 
> Greg, if I augment the commit message with the necessary information,
> would you be willing to take this patch instead of a much larger patch?

I almost always want to take whatever is in Linus's tree to ensure that
it will be easier to maintain over time due to other changes needing to
happen in the same area over the next 5+ years.  ALSO, almost always,
without fail, whenever we take code that is NOT in Linus's tree, it's
wrong, and it needs to be fixed up again as it's going outside of our
normal development and review and testing processes.

So unless there is some MAJOR reason why we can't just take what is in
Linus's tree, I strongly prefer that.  It is trivial for us to take 10's
and even 100's of patches of backports over a one-off change that is
going to end up costing us more work and effort over time.

thanks,

greg k-h

