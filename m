Return-Path: <stable+bounces-200303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CA4CABAF7
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 00:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D1463012DC6
	for <lists+stable@lfdr.de>; Sun,  7 Dec 2025 23:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C042D979B;
	Sun,  7 Dec 2025 23:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChAsC7rN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B5E56B81;
	Sun,  7 Dec 2025 23:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765151172; cv=none; b=VKV7OuZEwKDz7JabMJpF+9tWQ26V4LaD+3XENDspveU0VHdY4IQ7baCEpdNSHm2hxV4hO65hJZ4K6NHM13w5N2Lzww7TDUArQo5zVWmrAB/DPZbU7Hx86Hedy9t4IXuW1d0uml2oPWo5Qa426i91Ts7rD90TpDTWyw1JP2sjnYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765151172; c=relaxed/simple;
	bh=309EX3O2EKk2/zq+ynmjNBvVEnZf33rqQ7/FGVak/8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVQRdDvL+3zdC/50geZghfUVKBZmg/zIzBYRtLFJ3Zku+NAEjdD3itPY7l/hZaJSVilUS8NYXH3S40ORsxxOWFHQVIhAyqZvglgbWgsO6zK2tKNhjeJxNjFvPmyIdhHaKgfjwVAF7SrOWDdqagGkB18Ps0Rz3OxMVnIEdgVVWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChAsC7rN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765151171; x=1796687171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=309EX3O2EKk2/zq+ynmjNBvVEnZf33rqQ7/FGVak/8M=;
  b=ChAsC7rN9hCckzS4PpEsoO8nZuL/e59CGcc/xl4hBCF8O4qnKn8KILT4
   MnScELOV3lqVbvKKDXZ2xTnPLBwZX2OwSycV4zOB6pL0gl1Iy0FgZzrEy
   SabsnDp7JkROXrESfv5OKfdWTLla7Mm6oUH+rp54HPFU2rOPHvM71sXR4
   yf6k7NmIu8fPNATPvO/6MqyIsy8k/Vl05/Nl8B8ItPvM9ZRFsftbyHPTj
   QtpzFeOMLBtuf+9JsyvTS+/NwQsBxkQsbo5kgn71qlT8zkwxTenFP6kst
   xt0uzDc6cXppLJRow1fQd/QzcunXgkj9v4v1pFQMYPzvnPK1FPaKF7FSL
   A==;
X-CSE-ConnectionGUID: Ka63p5f2TfeCjhCyA0GZTg==
X-CSE-MsgGUID: Liis8R1iRyOqIxr4nwBmpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="70948813"
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="70948813"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 15:46:10 -0800
X-CSE-ConnectionGUID: RW+ourpFQACn2HtoOmvdhA==
X-CSE-MsgGUID: x6oyPl+/RRWDzIkJp9Qhjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="196560038"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.218])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 15:46:08 -0800
Date: Mon, 8 Dec 2025 01:46:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Magnus Damm <damm@igel.co.jp>, linux-kernel@vger.kernel.org,
	"Rob Herring (Arm)" <robh@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] resource: handle wrong resource_size value on zero
 start/end resource
Message-ID: <aTYRvnzJsIO427C8@smile.fi.intel.com>
References: <20251207215359.28895-1-ansuelsmth@gmail.com>
 <aTYJw9lNfHxQI_Ag@smile.fi.intel.com>
 <69360bb3.7b0a0220.46cd2.4675@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69360bb3.7b0a0220.46cd2.4675@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 08, 2025 at 12:20:16AM +0100, Christian Marangi wrote:
> On Mon, Dec 08, 2025 at 01:12:03AM +0200, Andy Shevchenko wrote:
> > On Sun, Dec 07, 2025 at 10:53:48PM +0100, Christian Marangi wrote:

...

> > >  static inline resource_size_t resource_size(const struct resource *res)
> > >  {
> > > +	if (!res->start && !res->end)
> > > +		return 0;
> > 
> > I think this breaks or might brake some of the drivers that rely on the proper
> > calculation. If you supply the start and end for the same (if it's not 0), you
> > will get 1 and it's _correct_ result (surprise surprise). One of the thing that
> > may be directly affected (and regress) is the amount of IRQs calculation (which
> > on some platforms may start from 0). However, in practice I think it's none
> > nowadays in the upstream kernel.
> 
> One common usage of this is with address size. So if start and end is
> the same, then it's ok to have size 1? 

First of all, resources is not _only_ about the addresses.
It may be just... a resource. Whatever it means.

So, second question here is that do we use open or closed interval? I always
have an impression that resource model (or in general model with start/end,
instead of start/size) uses closed intervals.

Third note, the resources is not only start and end, they also have flags,
and this has to be considered when retrieving the content of the resource.

So, in my world, the 1 _is_ the correct result for resource [start .. end],
where start = x, and end = x.


> > >  	return res->end - res->start + 1;
> > >  }
> > 
> > That said, unfortunately, I think, you want to fix drivers one-by-one and this
> > patch is incorrect as it brings inconsistency to the logic (1 occupied address
> > whatever unit it has may still be valid resource).
> 
> Yep but probably never aligned? I don't think there is an arch in the
> world that is aligned to 1 byte?

I believe you stick to much to the resource == address, no, this is wrong.
We have other resources that are not addresses, or we have resource where
0 is _valid_ start point (IO ports, IIRC, is the case, IRQs — of course!).

> > Also a good start is to add test cases and add/update documentation.
> 
> I hoped this was simple enough to have the condition.

I think it needs to be checked first with the actual users.

> The more articulate and safe change might be to:
> 1. rename this to __resource_size
> 2. rename every entry of resource_size to __resource_size
> 3. introduce a new resource_size commented and with the check
> 4. Use the new helper where it's actually needed?

Maybe it's simpler and just (almost) nothing should be done?
Check what is there, in the resources, before the checks and
what flags are being checked before those size checks.

> From my search there are various place where the condition is like:
> 
> if (resource_size(&res)) 
>    ...
> 
> And this condition doesn't make any sense since it's always true (I
> highly suspect these case all fall in what I described)

Not always, I already pointed out that it's not true.

> For sure this needs to be discussed and we need to gather more info.

-- 
With Best Regards,
Andy Shevchenko



