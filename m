Return-Path: <stable+bounces-53795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493BC90E6EA
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B57B2237A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13F07FBBF;
	Wed, 19 Jun 2024 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JiBXPYzh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2887EEFD
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789141; cv=none; b=G6VDnMyE2yO5032WzCyR4TAuruiUxx9rJRIBjrqENxbznLhLfS2+oXczf+3UsUff9fWAYjA056CIGorqzxxqC1LL3gga6fXAW4t6JpSpXhJBxhX+ZNWuloS2UmnwZbb4rd1Pb6cW9m8Bg9F7WlHUD4d/CHxs/CyBZK3oXo9MCN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789141; c=relaxed/simple;
	bh=+Sbk6niFPtNnof44cUq0AcZjTzv5fkSvFURy098SRtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iwiwe7sZDLlQ0cUto7nTtHz0iZRDDMKNMjY3PkMv3gUoe9OilgnFMd5qabRHGRRx2L40NQUwD5e44d+4xXwzIVKlo+V81I4HpOVF1XtHlXsCcKFmqe6cP4xDa+pIcxxSW8rTe3/pBpUtlM3n9YsnUzZXb0M1vvKeB7nMYJuH6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JiBXPYzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FD3C2BBFC;
	Wed, 19 Jun 2024 09:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718789141;
	bh=+Sbk6niFPtNnof44cUq0AcZjTzv5fkSvFURy098SRtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JiBXPYzhcfnsmyMAMXVu/85y9DegK1O+V72f3WYmJOFieTCrw8ro4JTsz2mwmaiU2
	 WzuurgAtfctbmd0fvBEH/6yfBiFRxU2dogYuktNBHdnug3cUAIjx6CpVYNk5ZP+XZH
	 ALnL2nvTaEt6jkBj2xp56nCbmjVfKFe6OJs02cOo=
Date: Wed, 19 Jun 2024 11:25:38 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"Berg, Johannes" <johannes.berg@intel.com>
Subject: Re: [PATCH 6.9 1/2] wifi: iwlwifi: mvm: support
 iwl_dev_tx_power_cmd_v8
Message-ID: <2024061955-unstuck-static-9f3c@gregkh>
References: <20240618110924.24509-1-emmanuel.grumbach@intel.com>
 <2024061917-kinswoman-nylon-c35f@gregkh>
 <832c8e0030465c6356097eb04a98f922cd152ab0.camel@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <832c8e0030465c6356097eb04a98f922cd152ab0.camel@intel.com>

On Wed, Jun 19, 2024 at 09:03:34AM +0000, Grumbach, Emmanuel wrote:
> On Wed, 2024-06-19 at 10:51 +0200, Greg KH wrote:
> > On Tue, Jun 18, 2024 at 02:09:23PM +0300, Emmanuel Grumbach wrote:
> > > commit 8f892e225f416fcf2b55a0f9161162e08e2b0cc7 upstream.
> > > 
> > > This just adds a __le32 that we (currently) don't use.
> > 
> > Why is this needed for a stable tree if this is nothing that is actually
> > used and then we need another fix for it after that?
> 
> Right, so I totally understand you're confused... I should probably have re-written the commit
> message to explain why this is needed for stable...
> 
> This patch allows to handle a new version of a specific command to the firmware. As explained in the
> commit message, we don't need the new field, but ... the command got bigger and we must align to the
> new size of course. If we don't, the firmware will get a command that is shorter than expected and
> will crash.
> We originally didn't think we'd need that on the firmware versions supported by kernel 6.9 and this
> is why we didn't queue this patch for 6.9. Now, it appears that the latest firmware version that 6.9
> supports does need the new version of the command.
> Unfortunately, we learnt that the hard way, through bugzilla :-(
> 
> Now, this patch introduced a regression that is fixed by another patch...
> Would you prefer me to squash them?
> 
> > 
> > I can't see how this commit actually does anything on it's own, what am
> > I missing?
> > 
> > What bug is this fixing?  A regression?  Is this a new feature?
> 
> So, yes, it fixes a bug as explained above.
> This is a regression because older kernels won't load the new firmware and won't hit the firmware
> crash.
> 
> > 
> > confused,
> 
> I should have re-written the commit message. Sorry.
> I hope things are now clearer..

Keeping the commit message the same is fine, and not squashing is also
fine, but a huge hint as to _why_ this is relevent for the stable trees
would have been appreciated.  That's what [0/X] email blurbs are for :)

thanks, I'll go queue these up now.

greg k-h

