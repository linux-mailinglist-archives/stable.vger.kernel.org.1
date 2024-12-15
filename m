Return-Path: <stable+bounces-104292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FC59F262C
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 22:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3151E1885C21
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01731BD4F7;
	Sun, 15 Dec 2024 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4WyYlSX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A6189F20;
	Sun, 15 Dec 2024 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734296828; cv=none; b=CgLXmB1Swm5dLn+QMb5LxXXSbp3sRC6XZ2tRcctTKRgzz+y1Jx8eR4wb3USS84m/k7I+VSYP7CpcYuB6NGVrnWkbNtIfXM7BoGb/hc+/rR3/kxw+9qdZ3U3EWQKlKTKTSeu/xMJmNGSuRL3p30LeUdNB1Y32yNv4YYYYvU1M/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734296828; c=relaxed/simple;
	bh=JuAj/vluOFw1XrMxa05AfTbJpFfElNRTDiH0R867NaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBTKthJNSE+2s1gPH0Ab1YwyHLNL/T+hjA3CqvIArqHar5DR1LsInQfAMF0IbOfUuSDEX3meOdTPRHls3thCgHmaqJk4d7+KA87a6/Os7Ogc/DhpjfQzSQYKNqxN+Cf2oaMd/ErNaXfgfCSNkgTsK1FoPZIACVeI7qYUZdLQIsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4WyYlSX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734296828; x=1765832828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JuAj/vluOFw1XrMxa05AfTbJpFfElNRTDiH0R867NaQ=;
  b=E4WyYlSXOjddNdppG8z6yPlwQtx7EIb56LN5x/VKTTJhTDl4GP9SA5jN
   B9+YA44XEq0xYLdtO0h2FlQHFaDpjk/BZvWfWzzq+q8V5UCchX5Fq0oF4
   MxdtO51fEQC3IgJ5VU3FoGkqGYfLlXU3bRkTMnaxbkPcMnKHhCfp/bcvi
   A2T/BxjnM3sCMJmF6O3YmPlgxXzmQ54TFM6aE6RcY1ABDXcBscecPWblU
   wtjV/WaW4HHzhLqsMuSt7BB3mop1fQJQBf0+a/uCPvLfm4PmGAYaGWetR
   nYSSUtzqp1CDRptRHqTcwcZQ6MCkqKYQehubHE4YxeAZcheWQuBOsMJOv
   w==;
X-CSE-ConnectionGUID: mbd2XQODQS6IDquekeURAA==
X-CSE-MsgGUID: SKo6BBWDS2iJQ4PXTaWrlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34817247"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34817247"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 13:07:07 -0800
X-CSE-ConnectionGUID: Dt+rX3ZAQqqn2eSEWPPseQ==
X-CSE-MsgGUID: qcfv1rcWSRq89b8u17Yrcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="97568320"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 13:06:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tMvpH-00000008K4Y-1RVU;
	Sun, 15 Dec 2024 23:06:55 +0200
Date: Sun, 15 Dec 2024 23:06:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, masahiroy@kernel.org,
	Matthias Maennich <maennich@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Kristen Accardi <kristen.c.accardi@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	William Breathitt Gray <wbg@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Patch "module: Convert default symbol namespace to string
 literal" has been added to the 6.12-stable tree
Message-ID: <Z19E7xNsk6IMUvp3@smile.fi.intel.com>
References: <20241215165452.418957-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215165452.418957-1-sashal@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Dec 15, 2024 at 11:54:50AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     module: Convert default symbol namespace to string literal
> 
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      module-convert-default-symbol-namespace-to-string-li.patch
> and it can be found in the queue-6.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

IIUC if you take this one, you would want to take more that are fixing
documentation generation and other noticed regressions.

-- 
With Best Regards,
Andy Shevchenko



