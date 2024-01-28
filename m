Return-Path: <stable+bounces-16232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5EC83F5A3
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 14:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBA41B21C59
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 13:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B9B23746;
	Sun, 28 Jan 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTi6GAIn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255522F1D;
	Sun, 28 Jan 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706449191; cv=none; b=BhRRgK3AxakGPmNgUq2NEyTkuKjyvM+8PLfNNyfrpH9u3EPwSRXfjEHpDruEa9kh6vkw7o+ZULNaSapiy36wg3wCwcn0ftUxBDTP7RG8adLqRBeZEpV+vDVWDiV54XPjbF/nkHHkQgkbg+Fm0jyDyYRNDZG91o1eeWlVzQdStwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706449191; c=relaxed/simple;
	bh=OwKC1I8LVVETT5/KSHq98w4lkf1ccBYhchvpRJBQ1u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=li69+W32wJQxjM/jDFK6HZw0WRaLTHMeBNjVK4sE/EwaWELGyndXhEkL6y6o2IFR6xwEmcipMOXwd4RhKqFvxZPWa6oG2djtKvdHE1T8r5oY0VTtdFeBJz1tWEw+Tc74ZobmqWzcI3twY92OSw7+TCmIEsYyCd6p0RUd8jf4LCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTi6GAIn; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706449189; x=1737985189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OwKC1I8LVVETT5/KSHq98w4lkf1ccBYhchvpRJBQ1u4=;
  b=cTi6GAInz89T0Fg9YZ2FlqL32YkuZlU01h6wFik6N8olafhowUvVnqXf
   uq+Uhcw+WDWBdEAdwdAAJcTvAKxL1mRBUe1QYGZsonxXau3MQAfKIkZqn
   abCdInNMZXugQI7D05yMvs2hMZR32A0/eHnpf/w1hTbEEiKdNvjDeUtpS
   lDXMLXiZ+DCmUS+EEiaLE2RL4zdIj7Z+PfvH8iSyd/097GsA61acfBAV+
   RlM69DyLBGvDuhMPoqicJxi+iRFx7Rn5zStXBFyzdx98Agj9x8O0uGBq0
   5wowc8Sk1h5+asGO0dmcyeqaa0qLfd507DnzWCAlgMqmLCZ0/5RTKx7Ce
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="467042805"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="467042805"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 05:39:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="787576589"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="787576589"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 05:39:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rU5Nw-0000000HSvT-3s5J;
	Sun, 28 Jan 2024 15:39:44 +0200
Date: Sun, 28 Jan 2024 15:39:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: stable-commits@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Patch "driver core: Annotate dev_err_probe() with __must_check"
 has been added to the 4.19-stable tree
Message-ID: <ZbZZIGcUSOK8pPSQ@smile.fi.intel.com>
References: <2024012619-spider-attempt-7896@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024012619-spider-attempt-7896@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Jan 26, 2024 at 05:33:20PM -0800, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     driver core: Annotate dev_err_probe() with __must_check
> 
> to the 4.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      driver-core-annotate-dev_err_probe-with-__must_check.patch
> and it can be found in the queue-4.19 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

But it got reverted, no need to have it in any stable kernels.

-- 
With Best Regards,
Andy Shevchenko



