Return-Path: <stable+bounces-152182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A6CAD275D
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 22:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475163A42D7
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 20:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD53C22154E;
	Mon,  9 Jun 2025 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4WrckCr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5C2206B3;
	Mon,  9 Jun 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499593; cv=none; b=J88GbueWN7mig51BVnRgPh8iOJt2IhUNs7262z1ElX1cm5qNC4p/M4JVB+rPl3/tGzyAxwiaM9aDgm0v7TR3DTmTCXPvdWxr9iHQGt3nMqxlOczZc6K8B9zMU7+sa9f9YIRUTTtextsLRzhXeNMfr5063rTa+/hWsIuZ7RB3wQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499593; c=relaxed/simple;
	bh=ys30SfhXg4+OJ3Cv1EkSHiA3x3HApyhWEfE8YPGYD4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMVawOQzSRdnxR2J/20pquhob70w01RVBGe73A5iuW6NsXlXA3FWCfzx2x+7w95YD7k34tQ5Z7Nibosju3rheztU9hZRB+lknkoEIdb+gwXGExAQIQ9dtwZkI2vhBOb2zQvj1oq0CTTegeLAdcv/iroQUU3xjXCl8t8uPHZmHoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W4WrckCr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749499582; x=1781035582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ys30SfhXg4+OJ3Cv1EkSHiA3x3HApyhWEfE8YPGYD4s=;
  b=W4WrckCrWsvDy7aY/S6OvRvJI34+MQd5rI+tH8vEErhykJxL24jKqHA1
   C0GlCvwF4Aufuj5ZwkQPTGQ8ekJL95i5jjtGeR4IURItonAMssLDhz7+U
   yt2lrpGCcRGOGuIe1oePDkRBFszAeb0Erq7NWYbciJiZpW77RvDM1EsFT
   fxW6Pynz6Xtli01KQpjFeuMztq+igXwd1Yq7eDQdsP12Q0e0u00TQg2LY
   nIEOPTatuv4Xl5Ppyp6ICJ9WPc2mt2U1YZfD/D82kbyFnFJdGYroqXzLZ
   o2DE7FoQFqVNgqd1FzmZnzjVrsg20RpytTO4L2Lz1y60MwqUh+Yuvgjfu
   Q==;
X-CSE-ConnectionGUID: in1jArkJS9u7Z9QuO5PTkg==
X-CSE-MsgGUID: IZ5KxrVeQle8668iCoBqJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51734248"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="51734248"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 13:06:21 -0700
X-CSE-ConnectionGUID: uQoT6WnpROumleVGhXl4dQ==
X-CSE-MsgGUID: W7a2AjxqQUCOpE5MWEGN0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151750928"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 13:06:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uOil3-000000059Q8-1sPV;
	Mon, 09 Jun 2025 23:06:13 +0300
Date: Mon, 9 Jun 2025 23:06:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: yunhui cui <cuiyunhui@bytedance.com>, arnd@arndb.de,
	benjamin.larsson@genexis.eu, heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org,
	jkeeping@inmusicbrands.com, john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	markus.mayer@linaro.org, matt.porter@linaro.org,
	namcao@linutronix.de, paulmck@kernel.org, pmladek@suse.com,
	schnelle@linux.ibm.com, sunilvl@ventanamicro.com,
	tim.kryger@linaro.org, stable@vger.kernel.org
Subject: Re: [External] Re: [PATCH v8 1/4] serial: 8250: fix panic due to
 PSLVERR
Message-ID: <aEc-taZPSrO520ui@smile.fi.intel.com>
References: <20250609074348.54899-1-cuiyunhui@bytedance.com>
 <2025060913-suave-riveter-66d0@gregkh>
 <CAEEQ3wmaiwd4TZfTa0YrLcKui9fSNJT0fR3j1=H1EK0T3npfyw@mail.gmail.com>
 <2025060925-curator-stubbed-bfb4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025060925-curator-stubbed-bfb4@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 09, 2025 at 03:44:19PM +0200, Greg KH wrote:
> On Mon, Jun 09, 2025 at 09:18:02PM +0800, yunhui cui wrote:
> > On Mon, Jun 9, 2025 at 6:10 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Mon, Jun 09, 2025 at 03:43:45PM +0800, Yunhui Cui wrote:

...

> > > - This looks like a new version of a previously submitted patch, but you
> > >   did not list below the --- line any changes from the previous version.
> > >   Please read the section entitled "The canonical patch format" in the
> > >   kernel file, Documentation/process/submitting-patches.rst for what
> > >   needs to be done here to properly describe this.
> > 
> > Can this issue reported by the bot be ignored?
> 
> No, why?  How do we know what changed from previous versions?  Otherwise
> we assume you just ignored previous review comments?
> 
> This series took at least 8 tries for some reason, might as well
> document it, right?  :)

+ many to what Greg said. The main problem you have is the absence of cover
letter, where it's naturally to put changelog for the series.

-- 
With Best Regards,
Andy Shevchenko



