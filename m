Return-Path: <stable+bounces-200300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E723CABAC1
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 00:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7063A30124D8
	for <lists+stable@lfdr.de>; Sun,  7 Dec 2025 23:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A642D46C0;
	Sun,  7 Dec 2025 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFXSCtEz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100E1F8691
	for <stable@vger.kernel.org>; Sun,  7 Dec 2025 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765149623; cv=none; b=AL4RckFUDqeBx50U8VkrYVCSVKqKirvp/njsdXlpR4lnEjljucRnnMfdt+Ewd6D8u/1AZTHl2u0VhAH4xB0uVhKi7kN+gEjo0SfxdXM08q3kJRuj7PssKggKEyPUu40/74ZyuEJNfYtOdE1xFTXlUfYoRSUmszovy9dYjHjkvZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765149623; c=relaxed/simple;
	bh=K7K8kLgktoCQJlZfSz2PNoxhKwL/tnUIrNINBUqa2Yg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AK+EsWse9mooKeL2hBAdD31e3eEbiVcInUxbMDeFCB1zoyUWepvVXZ8pzylXUzUExCkDABNo8BSgWGNkFQTIQ+SXyafujBwbowhloVTjScLmbdKE3T9oDBvjZHczxhFuu+q/p8sv7HY8ub6pFYXlN0cgtm0lHFqZnzS7+sn9sNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFXSCtEz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so30506285e9.3
        for <stable@vger.kernel.org>; Sun, 07 Dec 2025 15:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765149620; x=1765754420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5paoOuipX6CDOKZd5F9sxfZv4tczxFMvBMVeQOzwHRc=;
        b=ZFXSCtEzwwy7JvHtwZwhxhQv7AQMJdcBexksVvdp5iXBcrGi3sd15nkANjuqrVyYMt
         ztPp3L1MKeNUL/aDNJfqAQrFp3vFWM9VYx0eBzIpGmYOH8CoFCSeh8iHqpAmwYx31DXF
         kmIBvUX/cTvv0smHdiyW7KOqJIkk10FHUN0YxWSm3OUAmx62mEsHmidUNMmoHQYgV9wZ
         vYKZ/JD0AoHZbUyhPXxFAM9B2Pva9IjRCQJiQ5u95Y1SP+yvGUFCt8sf6fwoCwKdmc41
         8b/w0vxJqgLXM5MYivPQ49DDprJBZnwJ75DDHmehFc9zLykj9odyZygaVpKBGhG1wxR2
         FqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765149620; x=1765754420;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5paoOuipX6CDOKZd5F9sxfZv4tczxFMvBMVeQOzwHRc=;
        b=itYiUFbMt5t1ZlB6qQ/TfNnkFaEZdVLmQkAPjAZnAh36yQo8m+h+3ygc9/DwbqvKFU
         pLPCuiSapqTE/ekYWUS8UfG8i22fPXlC/4+LZMBT4CV2MsHZ7amPQgnZJqR1UL0Oc+Fk
         /jmR+xZP4NjMERDALagJBUzeNTM0yOh4qQD+l5J2dUeCLiKiWmFw7O9y1z7iX0likSE5
         aDMEbXN0pYrgRVQEgiR3J6sS05ZSTqcCWrrd0AzmGojV/JSZiG9XcUwYBz1LUXBN4rjE
         SbezFjwf+4BV3Re5oN437rsszAwZOVd/83k7+sdEtlRWtE69/UdbDt4y94MDJRH2W3mn
         a3eQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/qasJfL0sIp9i/uqelrxBKxk792mcQADdck0xLY/NUv85uCk4BmabdeJp6Pp2MnNl/uGGjXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQQe15nL6Jk+2JGnTP5nJ0zJ/a1czVl3P7GG7l+kR4bdk1QWN0
	z0KfO3RNqp1OiX1cxnXpqDY9PUyoqsouBaeICRRKPNCtxBgg+eCuZOQs
X-Gm-Gg: ASbGncvrjXhj65DccmL/wdIn1go1SzCLxw+RoERDivo6jcahSb+vWvSlwM7HboPLCvX
	9gcEQ581abpdln38VuDJXh7DQkH5qS3srN8XQNdDGrj9fO/cqOCwpYFFumMLWnYXQWAovi8MYce
	Lk+OffbTh1j9qabWhlZXRxbXxP1N0i0uPfKj7cmJ2cUC9GHQaw7rPyhj9VSOsVHL6derz73+83Z
	YqvUwuavb+q6qurS+sP1cWr7qggnxCMy2yRosesvR394wYLnB/MbYNfwPmBWnl2Zl/ZZvz0AAGF
	SuYd1WdbVCp+ENiV+hn6fqKvIuzR89XWoqPe/X8QQu0clSVN+VYwvLBfkcjqp90RRUrxs2kwjnc
	TT0ENzaAH7leK4hApE9SAoDSOd9zYyRHhTVWKa0F2+zfl51G/mqcnJobytZUuEKj+J5G7Vb/dH+
	Qlz0OK4v9hDLd+K7lqR2GJ8AvfUtSP50nXDVtoqIY=
X-Google-Smtp-Source: AGHT+IFOdnJiLL/JMffiuz9Ux0l8wH9PbEO+vHlBcTdWKS42c74i5DiqwI0Q7QA6ru41WJWInUN5eA==
X-Received: by 2002:a05:600c:3b9d:b0:477:7b16:5fa6 with SMTP id 5b1f17b1804b1-47939dec75bmr67002805e9.3.1765149619761;
        Sun, 07 Dec 2025 15:20:19 -0800 (PST)
Received: from Ansuel-XPS. (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b02ba67sm127870165e9.2.2025.12.07.15.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 15:20:19 -0800 (PST)
Message-ID: <69360bb3.7b0a0220.46cd2.4675@mx.google.com>
X-Google-Original-Message-ID: <aTYLsGP82GJTFVrp@Ansuel-XPS.>
Date: Mon, 8 Dec 2025 00:20:16 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Magnus Damm <damm@igel.co.jp>, linux-kernel@vger.kernel.org,
	"Rob Herring (Arm)" <robh@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] resource: handle wrong resource_size value on zero
 start/end resource
References: <20251207215359.28895-1-ansuelsmth@gmail.com>
 <aTYJw9lNfHxQI_Ag@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTYJw9lNfHxQI_Ag@smile.fi.intel.com>

On Mon, Dec 08, 2025 at 01:12:03AM +0200, Andy Shevchenko wrote:
> On Sun, Dec 07, 2025 at 10:53:48PM +0100, Christian Marangi wrote:
> > Commit 900730dc4705 ("wifi: ath: Use
> > of_reserved_mem_region_to_resource() for "memory-region"") uncovered a
> > massive problem with the usage of resource_size() helper.
> > 
> > The reported commit caused a regression with ath11k WiFi firmware
> > loading and the change was just a simple replacement of duplicate code
> > with a new helper of_reserved_mem_region_to_resource().
> > 
> > On reworking this, in the commit also a check for the presence of the
> > node was replaced with resource_size(&res). This was done following the
> > logic that if the node wasn't present then it's expected that also the
> > resource_size is zero, mimicking the same if-else logic.
> > 
> > This was also the reason the regression was mostly hard to catch at
> > first sight as the rework is correctly done given the assumption on the
> > used helpers.
> > 
> > BUT this is actually not the case. On further inspection on
> > resource_size() it was found that it NEVER actually returns 0.
> > 
> > Even if the resource value of start and end are 0, the return value of
> > resource_size() will ALWAYS be 1, resulting in the broken if-else
> > condition ALWAYS going in the first if condition.
> > 
> > This was simply confirmed by reading the resource_size() logic:
> > 
> > 	return res->end - res->start + 1;
> > 
> > Given the confusion, also other case of such usage were searched in the
> > kernel and with great suprise it seems LOTS of place assume
> > resource_size() should return zero in the context of the resource start
> > and end set to 0.
> > 
> > Quoting for example comments in drivers/vfio/pci/vfio_pci_core.c:
> > 
> > 		/*
> > 		 * The PCI core shouldn't set up a resource with a
> > 		 * type but zero size. But there may be bugs that
> > 		 * cause us to do that.
> > 		 */
> > 		if (!resource_size(res))
> > 			goto no_mmap;
> > 
> > It really seems resource_size() was tought with the assumption that
> > resource struct was always correctly initialized before calling it and
> > never set to zero.
> > 
> > But across the year this got lost and now there are lots of driver that
> > assume resource_size() returns 0 if start and end are also 0.
> > 
> > To better handle this and make resource_size() returns correct value in
> > such case, add a simple check and return 0 if both resource start and
> > resource end are zero.
> 
> Good catch!
> 
> Now, let's unveil which drivers rely on "broken" behaviour...
> 
> ...
> 
> >  static inline resource_size_t resource_size(const struct resource *res)
> >  {
> > +	if (!res->start && !res->end)
> > +		return 0;
> 
> I think this breaks or might brake some of the drivers that rely on the proper
> calculation. If you supply the start and end for the same (if it's not 0), you
> will get 1 and it's _correct_ result (surprise surprise). One of the thing that
> may be directly affected (and regress) is the amount of IRQs calculation (which
> on some platforms may start from 0). However, in practice I think it's none
> nowadays in the upstream kernel.
>

One common usage of this is with address size. So if start and end is
the same, then it's ok to have size 1? 

> >  	return res->end - res->start + 1;
> >  }
> 
> That said, unfortunately, I think, you want to fix drivers one-by-one and this
> patch is incorrect as it brings inconsistency to the logic (1 occupied address
> whatever unit it has may still be valid resource).
> 

Yep but probably never aligned? I don't think there is an arch in the
world that is aligned to 1 byte?

> Also a good start is to add test cases and add/update documentation.
> 

I hoped this was simple enough to have the condition. The more
articulate and safe change might be to:
1. rename this to __resource_size
2. rename every entry of resource_size to __resource_size
3. introduce a new resource_size commented and with the check
4. Use the new helper where it's actually needed?

From my search there are various place where the condition is like:

if (resource_size(&res)) 
   ...

And this condition doesn't make any sense since it's always true (I
highly suspect these case all fall in what I described)

For sure this needs to be discussed and we need to gather more info.

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
	Ansuel

