Return-Path: <stable+bounces-179793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE018B7E6C7
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833DF46338C
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 08:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D69E3054D5;
	Wed, 17 Sep 2025 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lu+OHD5w"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D36305950;
	Wed, 17 Sep 2025 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096018; cv=none; b=RujAkSfiDUSnh+/A3NDVOWCiZFlBiviNb+Fa7+N9DmPmdbhtzx1+21Jkha61n1HXChyG+77u5xaArpY44f/UPbgeHBJMahT/i5NddHBxaGmbfFd3TlVPbpAUjztfwTLeIyjIxgej6oRTsCSIwaHLywFhNMv2YiSzjEe6lKWLdJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096018; c=relaxed/simple;
	bh=+lPbCwnvydXGpJMfWZxi4MK9LlwSOPbLnA6B1hvpGeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYStf2tNqhKzhzmg6uZWM+AP+iOVAVIYZ6oXn84WX95pXRFU+7r+idyj2XCX1sjfnQCzExPPv0FpVdMy4FvhavCEr9h+nBQ1T7kTxxh8aBEhiVaeluZz1PS763bdbAHptvPZGO/uYUtICoh46/FuKOCCbyWIumpewKhnQ31kVJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lu+OHD5w; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758096016; x=1789632016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+lPbCwnvydXGpJMfWZxi4MK9LlwSOPbLnA6B1hvpGeo=;
  b=Lu+OHD5wiyquaZ86CUdbTo475xTZ2JNIXAoMlqXNNFVUjAL+ocHxVKth
   fFZ58MiVA+tj+dEfJzOvrP4fkq8eo0Fc+BGww6Rb8Pv+mV8Xv3z3j+NIB
   LErcLGF5/VRV6D7LkMkcpXpkTFHJZtnSTFEKLCxwDH4Mo4n5ORkdIaCf9
   7uu8z9jyNGIUOGOv0En5ssGNrSq4eK668arhcQk++cHYbRO4q46pWeqzW
   s9chQL8mXjDw9paO7+qoMyqM0IDa8anV+02CVeHcuhmLOC9pUvDB1WJga
   LW2+kL16HOEi5RYgQhPQJPncX9MX0hvoiBrz/+AaRhUiVztM2xl1CN8JR
   A==;
X-CSE-ConnectionGUID: W7rLVIZIQuGmGOpuBgjpyA==
X-CSE-MsgGUID: OErq57ntTcOjHsNoXMj2Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="59436998"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="59436998"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 01:00:15 -0700
X-CSE-ConnectionGUID: ci7lXjY9RMqXGvxvfzsK3A==
X-CSE-MsgGUID: wI2jDybqQGCsIQxbpq2ZRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="206126852"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 01:00:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uyn5E-00000003kKW-1j4X;
	Wed, 17 Sep 2025 11:00:08 +0300
Date: Wed, 17 Sep 2025 11:00:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Eliav Farber <farbere@amazon.com>
Cc: luc.vanoostenryck@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
	akpm@linux-foundation.org, gregkh@linuxfoundation.org,
	sj@kernel.org, David.Laight@aculab.com, Jason@zx2c4.com,
	bvanassche@acm.org, keescook@chromium.org,
	linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org,
	jonnyc@amazon.com, stable@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 5/7 5.10.y] minmax: allow min()/max()/clamp() if the
 arguments have the same signedness.
Message-ID: <aMpqiHZ8tGQHpCiP@smile.fi.intel.com>
References: <20250916213125.8952-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916213125.8952-1-farbere@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 09:31:25PM +0000, Eliav Farber wrote:

Your series is split in terms of email chain. Please, fix your tools.

-- 
With Best Regards,
Andy Shevchenko



