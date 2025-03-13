Return-Path: <stable+bounces-124240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A07AA5EEDC
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C4F3BB85F
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F53A2641FE;
	Thu, 13 Mar 2025 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGxfFEx7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C7322F163;
	Thu, 13 Mar 2025 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856556; cv=none; b=a1vnnJ3w0McFtVnga/bQGZ2TLdYUPVbmsjFATyKHX/CAEXmP2rtlZ0xHCsjbP0/3rPWwjNyNVhzKME6w2jmt1+yqd/AIigv99bTVue8GqXAIR3ckUG8R/m8mzPNVCFI/d0yKqdLf4p/JuXWeAChOlPinlHsyV4pHXLWITiiyRvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856556; c=relaxed/simple;
	bh=puRFOogVBwJjAXTpJBm30uYFBzpj1RgRfFr0WKW4VD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZsxyUuHoXJ+UmyfkAKNRdYQLU3tplt/GZU+fvFHO/JSKW5AmDrFD5WMMD0STIRk3DqP40HAPrrcjVuHYGNweY8g14RMwfsa9woGHsL7vzVKSG8uTm18bvch8wiWlMSdgV+4PtB9miyRC3GeBv5QZkOJWUogaZiLdG9F/6Bby1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGxfFEx7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741856555; x=1773392555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=puRFOogVBwJjAXTpJBm30uYFBzpj1RgRfFr0WKW4VD0=;
  b=gGxfFEx7BYRaNl9n73u0AKl0Nt9AjRpf3Tf0pNsrKRSZybNo9OfQkplk
   TfmyEl2lWh7nWIQ3QSn9Cdh+FPns5lXVB8l5cHncbUG/1EwvC0ALcCu3p
   nAqDDXmXi6Yw329YUBcOi9kmNT3UPE4NtrxzzZtUPeoR9PxEarMT5H+Xl
   xWTJVDipdtFWaZuomKTS37ggAEBKQ6ytB7yjg96gmPADoLgwaTwEGeWgG
   slguEaWeKMViCh8JVgPrOUd58MFDe9+ZMeWKMXjfjgZk9Moyw9vffPd2N
   /pZdWuktiPEbHquzuwA3CinhtNLjPE2ZDgO4YrHx+LMyyLnHWcgBRlX21
   w==;
X-CSE-ConnectionGUID: TQYW4ddyRdigpAexw978Cg==
X-CSE-MsgGUID: Xj5BcJoFR3WyMgzljEfGwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53599859"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53599859"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 02:02:34 -0700
X-CSE-ConnectionGUID: UJerJ1FESBO9PyHHKIPwuw==
X-CSE-MsgGUID: f09Ru+GjRvOR3sHk70y+Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121386670"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 02:02:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tseSS-000000027n7-1E2e;
	Thu, 13 Mar 2025 11:02:28 +0200
Date: Thu, 13 Mar 2025 11:02:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ma Ke <make24@iscas.ac.cn>, Wang Hai <wanghai26@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, jdamato@fastly.com,
	aleksander.lobakin@intel.com, quic_zijuhu@quicinc.com,
	wanghai26@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net-sysfs: fix error handling in
 netdev_register_kobject()
Message-ID: <Z9KfJBzR9ZWFBJDf@smile.fi.intel.com>
References: <20250313075528.306019-1-make24@iscas.ac.cn>
 <Z9Ke3moM5BVSsPax@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9Ke3moM5BVSsPax@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: Wang Hai

On Thu, Mar 13, 2025 at 11:01:18AM +0200, Andy Shevchenko wrote:
> On Thu, Mar 13, 2025 at 03:55:28PM +0800, Ma Ke wrote:
> > Once device_add() failed, we should call put_device() to decrement
> > reference count for cleanup. Or it could cause memory leak.
> > 
> > As comment of device_add() says, 'if device_add() succeeds, you should
> > call device_del() when you want to get rid of it. If device_add() has
> > not succeeded, use only put_device() to drop the reference count'.
> 
> Okay, have you read the history of this?
> 6b70fc94afd1 ("net-sysfs: Fix memory leak in netdev_register_kobject")
> 8ed633b9baf9 ("Revert "net-sysfs: Fix memory leak in netdev_register_kobject"")
> https://syzkaller.appspot.com/x/log.txt?x=1737671b200000
> 
> TL;DR: next time provide a better changelog and clean syzkaller report.

-- 
With Best Regards,
Andy Shevchenko



