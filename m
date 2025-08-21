Return-Path: <stable+bounces-172178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94007B2FEB1
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 17:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DAD06453C9
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7FA27876A;
	Thu, 21 Aug 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NCS8pazb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E68277814
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790100; cv=none; b=O+rEikV91CTg3w2/T2slEmyYpbR4P3ufghTa/hFz3yvam2AVy0bl9XjkoJFkmUP82r02ng+8I/e0NATGTs9LTIFYhZkeQVwDmrgPPymjkQ1AtORgmLcpbCkazp8vV49Oex1XLyHGlZM5zUkJmhlqHNeJ+r4EO0Mul7sdMtbtFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790100; c=relaxed/simple;
	bh=aA8zhseHSQmMzMmSITma/zwDunvdaaGfLi5Z+fx4Wts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B00XXc4eXOeF3xCaUOatMQNG9VF154Erzq8UHhnw6GHjtRyEi1X/moiyidHzm8gj6S4kJ+tB/j/WjW4JfRO5RF8a6cLi+ZJazF+3GkZIvWupkOgJt6J+eansbDIYNJEl6zt/lFPFN/VfVCLL9VmTL4TYhyg1eXXa9KehufBC3Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NCS8pazb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-323266baa22so841003a91.0
        for <stable@vger.kernel.org>; Thu, 21 Aug 2025 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755790097; x=1756394897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nd2HlIcK0+2BltYNtEvCp8FEJ4wH2rjWi5MC5TG9XRU=;
        b=NCS8pazb1+vxxDoL/gev9piRpsniiZGAMO5rlYsJvQioQKlSg2gi5jwA+lzmoj5DC8
         TvjJhl5GhZBqxCwaO100+gaZlxXgiod3gA5CQz9xVH/X4uiM0I6iPNiY4/piZUXpiG0k
         I9cER91RwU4L6SA6AX7ss73sWfYgYnW+snIgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755790097; x=1756394897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nd2HlIcK0+2BltYNtEvCp8FEJ4wH2rjWi5MC5TG9XRU=;
        b=KmXSfG2vxu77PfT/bNTYr/of55cUAL5CTKSUlf5F5d1NvhSdq/2C28cDYNsXzjkUL5
         1RS7E2bYaM9RaM18LNZ9oiYdDS7wl5i8tQ36jLQnaEma+VI5TpT4GIp9zHASP6cnv9Fj
         z5BZO1kTjgxnVec1ZfzJwaq2oBdPyNZdr6zBsBPe34mgaH/5S45PT5TvX6iLzqrq19Cm
         rLAF+VJJFGiX+8pE3L1xe/Sw/Igh8svoyz203VU/T2xHE8qNd3tTZcjwNGcpeEQaKYPn
         mGdk1MVYp7gX90ymyEcE+b7Bk0ygpBAflDhh9oHFqRvIqtQPkxnn6BZo3UmVhMdJxpkk
         FdyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJq7bWOzXHBreZm8xac1kp72gIXEVX5Qe68NMSDY+6EofyIYnHDzi1ra/efTDf7h/QnbgTGC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQc5+1rsy3sgQrNHjtCmqG/9YQ1dppeua73V79uUh+xzjnb2xH
	U1AVuRz1TmsaV+nmQo02tz5ZfNzsF5HcMwKqAriZe1gKE/bJlKL86AHwmNusdhCRcHoSRWrK2ET
	diLM=
X-Gm-Gg: ASbGncvPqplLv38n+O7p+zhD4VSP/I/YjLcSSg0jU98j5je2g13jtcTaN87tS1OpYBB
	lydgj8d8F6KPbPFtW+6G6aEFdNQnIPNZYTxPvNDZkgTGH4X/PQz88oTBpdl90Aul0YcH5zEGgg8
	U3PyTWjNh7sZ1pScZY8w8ruDCr2VRmekIA05sdx/uu1t7LbQrSH9TLvHlt0Ix1k6GoTZiKlQl3Y
	VcJJF+kspVNF7CQw0oQ6VWgTF8QaWVMYVTFJ4yigBfOnsIDCg/uu3eVM23dA14MdX1LrgUQ/hAQ
	XUJ2b8ZfXUmGsOQXmYf3n8KUBFSfdmlB1hU1iitfqBwBEtMbgLsw1kLlcduhn7CjvARqmChee1T
	0nxi1NCgo8ybqc6wrqofQp5AjBYCrQ4vmf58sOGEIODPLB6H4xQtkNjHV+Ty1
X-Google-Smtp-Source: AGHT+IHVhDdHs5f4ka0iZ1LeCPqSFllDs1FhR8dhlw5b1WPArLSHElp5qXfJNzyGqc66nfXe2M/+eA==
X-Received: by 2002:a17:90b:2744:b0:31e:e88b:ee0d with SMTP id 98e67ed59e1d1-324ed0977f0mr3779233a91.9.1755790097274;
        Thu, 21 Aug 2025 08:28:17 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2283:604f:d403:4841])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-324fb2fee00sm826075a91.9.2025.08.21.08.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 08:28:16 -0700 (PDT)
Date: Thu, 21 Aug 2025 08:28:15 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ethan Zhao <etzhao1900@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
Message-ID: <aKc7D78owL_op3Ei@google.com>
References: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
 <dfdc655e-1e06-42df-918f-7d56f26a7473@gmail.com>
 <aKaK4WS0pY0Nb2yi@google.com>
 <048bd3c4-887c-4d17-9636-354cc626afa3@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <048bd3c4-887c-4d17-9636-354cc626afa3@gmail.com>

Hi Ethan,

Note: I'm having a hard time reading your emails sometimes, because you
aren't really adding in appropriate newlines that separate your reply
from quoted text. So your own sentences just run together with parts of
my sentences at times. I've tried to resolve this as best I can.

On Thu, Aug 21, 2025 at 08:41:28PM +0800, Ethan Zhao wrote:
> 
> 
> On 8/21/2025 10:56 AM, Brian Norris wrote:
> > On Thu, Aug 21, 2025 at 08:54:52AM +0800, Ethan Zhao wrote:
> > > On 8/21/2025 1:26 AM, Brian Norris wrote:
> > > > From: Brian Norris <briannorris@google.com>
> > > > 
> > > > max_link_speed, max_link_width, current_link_speed, current_link_width,
> > > > secondary_bus_number, and subordinate_bus_number all access config
> > > > registers, but they don't check the runtime PM state. If the device is
> > > > in D3cold, we may see -EINVAL or even bogus values.
> > > My understanding, if your device is in D3cold, returning of -EINVAL is
> > > the right behavior.
> > 
> > That's not the guaranteed result though. Some hosts don't properly
> > return PCIBIOS_DEVICE_NOT_FOUND, for one. But also, it's racy -- because
> > we don't even try to hold a pm_runtime reference, the device could
> > possibly enter D3cold while we're in the middle of reading from it. If
> > you're lucky, that'll get you a completion timeout and an all-1's
> > result, and we'll return a garbage result.
> > 
> > So if we want to purposely not resume the device and retain "I can't
> > give you what you asked for" behavior, we'd at least need a
> > pm_runtime_get_noresume() or similar.
> I understand you just want the stable result of these caps,

Yes, I'd like a valid result, not EINVAL. Why would I check this file if
I didn't want the result?

> meanwhile
> you don't want the side effect either.

Personally, I think side effect is completely fine. Or, it's just as
fine as it is for the 'config' attribute or for 'resource_N_size'
attributes that already do the same.

> > > > Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
> > > > rest of the similar sysfs attributes.
> > > > 
> > > > Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Brian Norris <briannorris@google.com>
> > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > > ---
> > > > 
> > > >    drivers/pci/pci-sysfs.c | 32 +++++++++++++++++++++++++++++---
> > > >    1 file changed, 29 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > > index 5eea14c1f7f5..160df897dc5e 100644
> > > > --- a/drivers/pci/pci-sysfs.c
> > > > +++ b/drivers/pci/pci-sysfs.c
> > > > @@ -191,9 +191,16 @@ static ssize_t max_link_speed_show(struct device *dev,
> > > >    				   struct device_attribute *attr, char *buf)
> > > >    {
> > > >    	struct pci_dev *pdev = to_pci_dev(dev);
> > > > +	ssize_t ret;
> > > > +
> > > > +	pci_config_pm_runtime_get(pdev);
> > > This function would potentially change the power state of device,
> > > that would be a complex process, beyond the meaning of
> > > max_link_speed_show(), given the semantics of these functions (
> > > max_link_speed_show()/max_link_width_show()/current_link_speed_show()/
> > > ....),
> > > this cannot be done !
> > 
> > What makes this different than the 'config' attribute (i.e., "read
> > config register")? Why shouldn't that just return -EINVAL? I don't
> > really buy your reasoning -- "it's a complex process" is not a reason
> It is a reason to know there is side effect to be taken into account.

OK, agreed, there's a side effect. I don't think you've convinced me the
side effect is bad though.

> > not
> > to do something. The user asked for the link speed; why not give it?
> > If the user wanted to know if the device was powered, they could check
> > the 'power_state' attribute instead.
> > 
> > (Side note: these attributes don't show up anywhere in Documentation/,
> > so it's also a bit hard to declare "best" semantics for them.)
> > 
> > To flip this question around a bit: if I have a system that aggressively
> > suspends devices when there's no recent activity, how am I supposed to
> > check what the link speed is? Probabilistically hammer the file while
> > hoping some other activity wakes the device, so I can find the small
> > windows of time where it's RPM_ACTIVE? Disable runtime_pm for the device
> > while I check?
> Hold a PM reference by pci_config_pm_runtime_get() and then write some
> data to the PCIe config space, no objection.
> 
> To know about the linkspeed etc capabilities/not status, how about
> creating a cached version of these caps, no need to change their
> power state.

For static values like the "max" attributes, maybe that's fine.

But Linux is not always the one changing the link speed. I've seen PCI
devices that autonomously request link-speed changes, and AFAICT, the
only way we'd know in host software is to go reread the config
registers. So caching just produces cache invalidation problems.

> If there is aggressive power saving requirement, and the polling
> of these caps will make up wakeup/poweron bugs.

If you're worried about wakeup frequency, I think that's a matter of
user space / system administraction to decide -- if it doesn't want to
potentially wake up the link, it shouldn't be poking at config-based
sysfs attributes.

Brian

