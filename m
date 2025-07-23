Return-Path: <stable+bounces-164407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4A6B0EE98
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 11:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17BE1766A9
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 09:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FC0286D5C;
	Wed, 23 Jul 2025 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yF/nUObS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9BB248F69;
	Wed, 23 Jul 2025 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753263579; cv=none; b=s25/oZgckCLMaJ9TUKXpCCLmYvTxdCz7Rzh/Ptx5B9Fw4iKAwVzhLthxxlv7+Sk5Ga/LhAYs6YuWJSQGlEgLMx+IU0XIhJI3RJLUnaZY/RMrhXXQvie+5jPUbM+puEhPa647xSrflbrhv394beriijaLtoErNfqvADyIRNPk8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753263579; c=relaxed/simple;
	bh=N1m0/HCBgtIm3aVR+PSwcFIzVv9tfNgnA+hO9xgDiWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tD2wqGzx4N3cZ6bspZxOx76Sp5axw70KlZXoRV5pLKLp+K6pXvar6f8tQzhEna5PkNSyAC1ujqUjWOfI4pb6v0BihWsKM+ksUIfRgZUfITgGfS0RB0hbxjIGOJctSWhUQVyshSMY3WKScUfDW3L8GuaNG0kQMGjteb6nWvtdgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yF/nUObS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84040C4CEF4;
	Wed, 23 Jul 2025 09:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753263577;
	bh=N1m0/HCBgtIm3aVR+PSwcFIzVv9tfNgnA+hO9xgDiWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yF/nUObSK3ore3ie0ZB0kBYAaWTsSpZB4Kmy7uvFsb4gn4WE/JMBIbhRWO91QbQ58
	 0ocCm30kgwyu5ny7BD0/EbTSutWuTtXoPVReRVPEgMjyWzsXdKwezIzDJOUros5kRJ
	 voOjd7C+RhtG5pxhDws7tjvcRM6m2/TBEyDxB0IE=
Date: Wed, 23 Jul 2025 11:39:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ban ZuoXiang <bbaa@bbaa.fun>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] PCI =?utf-8?Q?P?=
 =?utf-8?Q?assthrough_=2F_SR-IOV_Failure_on_Stable_Kernel_?= =?utf-8?B?4oml?=
 v6.12.35
Message-ID: <2025072314-malformed-antler-2829@gregkh>
References: <721D44AF820A4FEB+722679cb-2226-4287-8835-9251ad69a1ac@bbaa.fun>
 <6294f64a-d92d-4619-aef1-a142f5e8e4a5@linux.intel.com>
 <5F974FF84FAB6BD8+4a13da11-7f32-4f58-987a-9b7e1eaeb4aa@bbaa.fun>
 <2025072222-dose-lifting-e325@gregkh>
 <82255DF0A021BC1D+513c6ded-088b-4799-8605-b7118c7713ef@bbaa.fun>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82255DF0A021BC1D+513c6ded-088b-4799-8605-b7118c7713ef@bbaa.fun>

On Wed, Jul 23, 2025 at 05:22:44PM +0800, Ban ZuoXiang wrote:
> > Nope!  We need your help as you are the one that can reproduce it :)
> >
> > Are we missing a backport?  Did we get the backport incorrect?  Should
> > we just revert it?
> >
> > thanks,
> > greg k-h
> 
> Hi, greg k-h
> 
> Original patch:
> 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index bb871674d8acba..226e174577fff1 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -4298,6 +4306,9 @@ static int identity_domain_attach_dev(struct
> > iommu_domain *domain, struct device
> >      else
> >          ret = device_setup_pass_through(dev);
> >  
> > +    if (!ret)
> > +        info->domain_attached = true;
> > +
> >      return ret;
> >  }
> Backport patch:
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 157542c07aaafa..56e9f125cda9a0 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -4406,6 +4414,9 @@ static int device_set_dirty_tracking(struct
> > list_head *devices, bool enable)
> >              break;
> >      }
> >  
> > +    if (!ret)
> > +        info->domain_attached = true;
> > +
> >      return ret;
> >  }
> 
> The last hunk of the original patch [1] was applied to the
> |identity_domain_attach_dev| function, 
> but the last hunk of the backport patch [2] appears to have been
> mistakenly applied to the |device_set_dirty_tracking| function.
> I can confirm that correctly placing the patch from
> device_set_dirty_tracking into identity_domain_attach_dev resolves the
> issue.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=320302baed05c6456164652541f23d2a96522c06
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=fb5873b779dd5858123c19bbd6959566771e2e83

Ah, nice work!

Can you send a patch that fixes this up properly please?  I'll be glad
to queue that up.

greg k-h

