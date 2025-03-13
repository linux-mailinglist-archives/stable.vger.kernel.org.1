Return-Path: <stable+bounces-124263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A348DA5F02D
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 11:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E664816C743
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74622641DE;
	Thu, 13 Mar 2025 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OvlHZTNn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B1B1FBC87;
	Thu, 13 Mar 2025 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860229; cv=none; b=s6X8Ar0eCDWPDA2sv8joCFTZOA0L4dw9RMsH09ljjDPU6wwTK4wCtPON4zY9I0KYGbk7f2e+DvtoKTMYg1s4zwC3P3hD+KfmEO7pE+nNMgF9l+DMIQLx9flDIiuY42P8VcSxNlUA38o6pIoNz3YqFu19ABcmhkNOvMB1htRwivk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860229; c=relaxed/simple;
	bh=CLLzytuL5wZjpWyJAxGxKy9CkVm8IFe+rMtUa4CBlrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9U8H9UqGmEECVGxgMzKNJPBSvEOSMDPorQmoSzsG6LPXo3xi8AGYAe8j53WrX7qM8/bFzYgMR7DwAfvwK3Fc3zoED78aDQlm/m0WOS7URI4oQrl1S/Q6LGiskcMfAGOqTD1SNuyWjN6hSoO8sp6YMaWW6HceLPv3qlCHC8h1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OvlHZTNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B47C4CEDD;
	Thu, 13 Mar 2025 10:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741860229;
	bh=CLLzytuL5wZjpWyJAxGxKy9CkVm8IFe+rMtUa4CBlrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvlHZTNnjHqRe6bIQ/w9qx8nv/I6itkqipucKtu2IBAfhTN7+E56AHzBLYIyNB6bY
	 zZ+4RSBFiXSWpfXxeDnvll+NM9N5X2s57wxOEMRAKWzq+smv8+uohZBnWP2EtdUU/B
	 xLXo62e22XsacsM4MBo5SdguWCGiNH7r0UxWxTIw=
Date: Thu, 13 Mar 2025 11:03:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH v1] remoteproc: Add device awake calls in rproc boot and
 shutdown path
Message-ID: <2025031340-crux-nectar-b62c@gregkh>
References: <20250303090852.301720-1-quic_schowdhu@quicinc.com>
 <ec46a72f-f31b-c306-e57d-9bb7f58b24a2@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec46a72f-f31b-c306-e57d-9bb7f58b24a2@quicinc.com>

On Thu, Mar 13, 2025 at 02:42:10PM +0530, Souradeep Chowdhury wrote:
> Gentle Reminder.
> 
> 
> On 3/3/2025 2:38 PM, Souradeep Chowdhury wrote:
> > Add device awake calls in case of rproc boot and rproc shutdown path.
> > Currently, device awake call is only present in the recovery path
> > of remoteproc. If a user stops and starts rproc by using the sysfs
> > interface, then on pm suspension the firmware loading fails. Keep the
> > device awake in such a case just like it is done for the recovery path.
> > 
> > Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> > ---
> >   drivers/remoteproc/remoteproc_core.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index c2cf0d277729..908a7b8f6c7e 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1916,7 +1916,8 @@ int rproc_boot(struct rproc *rproc)
> >   		pr_err("invalid rproc handle\n");
> >   		return -EINVAL;
> >   	}
> > -
> > +	
> > +	pm_stay_awake(rproc->dev.parent);
> >   	dev = &rproc->dev;
> >   	ret = mutex_lock_interruptible(&rproc->lock);
> > @@ -1961,6 +1962,7 @@ int rproc_boot(struct rproc *rproc)
> >   		atomic_dec(&rproc->power);
> >   unlock_mutex:
> >   	mutex_unlock(&rproc->lock);
> > +	pm_relax(rproc->dev.parent);
> >   	return ret;
> >   }
> >   EXPORT_SYMBOL(rproc_boot);
> > @@ -1991,6 +1993,7 @@ int rproc_shutdown(struct rproc *rproc)
> >   	struct device *dev = &rproc->dev;
> >   	int ret = 0;
> > +	pm_stay_awake(rproc->dev.parent);
> >   	ret = mutex_lock_interruptible(&rproc->lock);
> >   	if (ret) {
> >   		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
> > @@ -2027,6 +2030,7 @@ int rproc_shutdown(struct rproc *rproc)
> >   	rproc->table_ptr = NULL;
> >   out:
> >   	mutex_unlock(&rproc->lock);
> > +	pm_relax(rproc->dev.parent);
> >   	return ret;
> >   }
> >   EXPORT_SYMBOL(rproc_shutdown);
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

