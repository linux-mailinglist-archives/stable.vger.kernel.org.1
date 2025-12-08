Return-Path: <stable+bounces-200305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D450CABB0F
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 01:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D2DA3012BD1
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 00:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2082F3C3E;
	Mon,  8 Dec 2025 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYaO/hk/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052AE2F6906;
	Mon,  8 Dec 2025 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765152034; cv=none; b=OWZW/QO9b44mi63x6FWWbRQe2nu8qRsOS+/YtMI67Ys+YXJvrMrlTohDOhbQ2e6j/8ixwPO8wjHQG9j6KwypfyxHKqkfQiErpcmezfIIHBY7+QtK67acOZ0E7/Lu/EkaET1hRv9d0qko5on6J6y8Q8ClglTik1L/dnYAN3D0tug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765152034; c=relaxed/simple;
	bh=W7drUFP0TetKcnV2WgMlRIB49xKfV7b5/mcDlNWwdf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNjxUHNJJn2imGAWqbRjlSDwUhgf9QWue5gu/tNOT7TcnT3qBA3Xhi00NiZrox88t/E+3azRSMJU6PyzzAT2zypY37XDHZ19u9Woj8wL3oj/tqQFY/dC5xKwYudGxgJEOM7q1uXv2V3x4wr3SevTZrdtBqi73yva/lA4zfvfZP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYaO/hk/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765152033; x=1796688033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W7drUFP0TetKcnV2WgMlRIB49xKfV7b5/mcDlNWwdf0=;
  b=DYaO/hk/kLGzieQ6GCogj2HlHFeXbm74uEif7ngGg4lqV3O/2K78s2fZ
   LPqUCgd4GUGlZZbT9WlpQAO9fooYcxLy6ppcbdyQ3nuhdeTY2i1i6UFkC
   MLY6lziMP2wDK39XOLMtI7e+xtHJc5c7xLmMIYsi7AbDIbwp9zWYn8LWh
   kLWnmdRQOE/PGY+QEvMitDzg5K0FrWTa4HKL4wM0tK82Ni6dUnp4/SlG1
   kgQ78xu1TK109y2nWgxOxDo54DMuZn7Vdmv8JRNZoY8VEmdvtQ0JMYNCQ
   UkgXB15JKA9aLegNw0tMsBC5BhnXfdsdOCSR1/rrGpA0g6IXbyetcIkDs
   A==;
X-CSE-ConnectionGUID: +xR38rSzShOBDZ8KDoMGyg==
X-CSE-MsgGUID: IvyI7MGZS1axRhr/ryhHzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="70949678"
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="70949678"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 16:00:32 -0800
X-CSE-ConnectionGUID: GFaSfBGeQLmMC3J+XGLp9g==
X-CSE-MsgGUID: l/FEwkpiQty3Yc4fo4sK8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="196562933"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.218])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 16:00:29 -0800
Date: Mon, 8 Dec 2025 02:00:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Magnus Damm <damm@igel.co.jp>, linux-kernel@vger.kernel.org,
	"Rob Herring (Arm)" <robh@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] resource: handle wrong resource_size value on zero
 start/end resource
Message-ID: <aTYVG-1H_i6lMOcm@smile.fi.intel.com>
References: <20251207215359.28895-1-ansuelsmth@gmail.com>
 <aTYJw9lNfHxQI_Ag@smile.fi.intel.com>
 <aTYMeY1AsprPwC_9@smile.fi.intel.com>
 <69360eb2.050a0220.2b0cf3.b5a8@mx.google.com>
 <aTYUbPcpl9aVijpS@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTYUbPcpl9aVijpS@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 08, 2025 at 01:57:37AM +0200, Andy Shevchenko wrote:
> On Mon, Dec 08, 2025 at 12:33:03AM +0100, Christian Marangi wrote:

...

> I think the better choice is to check all places where resource is assigned
> and convert that to a helper when the size can be or is 0. Definitely it's
> a lot of code to be audited.
> 
> But having something like
> 
> 	resource_set_size(res, 0) // note, this API is already in upstream
> or
> 	resource_set_range(res, start, 0)
> 
> instead of direct assignment of start and end is much simpler approach.

Just run

	git grep -n -w resource_set_range

and you see that even OF uses it in once case already. And PCI core is full of
the calls, that's why I believe PCI is not affected as it does the correct
thing to begin with.

-- 
With Best Regards,
Andy Shevchenko



