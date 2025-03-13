Return-Path: <stable+bounces-124230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1BDA5EEC7
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED5D19C0AE5
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F3A264624;
	Thu, 13 Mar 2025 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xk6EHSFi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5761326461C;
	Thu, 13 Mar 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856487; cv=none; b=RXU2lvstivkkPf/QRKfpKO4CXPd8PXz5PQOQOZ4bXwgfTkJko569CqFxtS3QS1WALAtpoC2D213VjcNPwniJIS94mcJcp5Y1nWO0dLsgi+yMClqNJPh6WQf2gVcBQr/YyRiek2z0PTpPq0timv+6fpdY58W2TdPuTxwVqhdmXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856487; c=relaxed/simple;
	bh=pZpHIxn8X7wku+BRIf/Q8fpkyPJtfSmtiqJspDYseeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK5/hsK3/EPUOM213ehE4qgdzQdSJr0oDDBtos0GB5mK/8zihQqLDB7r7xsyT6stLCexCmuRgq3ArREQaOPT8o9kIrvyq+aSVNP8ANWk/Mx1X19pIs5+ABq8tDORrdzeM+0M+0JV2wAFzCkm40Y6tLtEEm33rLxLUeI0En4sYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xk6EHSFi; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741856486; x=1773392486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pZpHIxn8X7wku+BRIf/Q8fpkyPJtfSmtiqJspDYseeU=;
  b=Xk6EHSFid/b6GDM8AV2SqLCHZm5WTQhW+n3NiTilJ6X1t3sjQyUzX10K
   swHdBS0KIxsKbCFO/8EQDqqpUIw4I9qDrhOSu9pbaRPHl1P6sx/LJIYNt
   OtZ3KdvBd7gfcF5gVAydAlpZEhiISWZpFjg5X8+zgd0UmN4DbMLXMkion
   8MyL+efA7C1/Hf3rHOHkUDfy64yBtCUBMzjSZU/mlR9vFVtOeMGYNP2ef
   PNZfoA+Zs57x4+AreC9SGPtq1Wgc+iFZCZSe8egVz3yGewRaBao3lzNRt
   1vwAu1aeJuL0kxFkSC6UQD7sUHjYbNgbgUx5Um6r6jQnTS095RaOhrOPZ
   g==;
X-CSE-ConnectionGUID: DDNIfNFXRi+y3rFdtLgHQw==
X-CSE-MsgGUID: uuWzSgkDQY+cBBavBVGOqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53956649"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53956649"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 02:01:25 -0700
X-CSE-ConnectionGUID: gloHZR0kQASo1lI5EMvOOg==
X-CSE-MsgGUID: iv+Aim2oTf28GiUBCA8S/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="144082437"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 02:01:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tseRK-000000027la-3hv4;
	Thu, 13 Mar 2025 11:01:18 +0200
Date: Thu, 13 Mar 2025 11:01:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, jdamato@fastly.com,
	aleksander.lobakin@intel.com, quic_zijuhu@quicinc.com,
	wanghai26@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net-sysfs: fix error handling in
 netdev_register_kobject()
Message-ID: <Z9Ke3moM5BVSsPax@smile.fi.intel.com>
References: <20250313075528.306019-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313075528.306019-1-make24@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 03:55:28PM +0800, Ma Ke wrote:
> Once device_add() failed, we should call put_device() to decrement
> reference count for cleanup. Or it could cause memory leak.
> 
> As comment of device_add() says, 'if device_add() succeeds, you should
> call device_del() when you want to get rid of it. If device_add() has
> not succeeded, use only put_device() to drop the reference count'.

Okay, have you read the history of this?
6b70fc94afd1 ("net-sysfs: Fix memory leak in netdev_register_kobject")
8ed633b9baf9 ("Revert "net-sysfs: Fix memory leak in netdev_register_kobject"")
https://syzkaller.appspot.com/x/log.txt?x=1737671b200000

TL;DR: next time provide a better changelog and clean syzkaller report.

-- 
With Best Regards,
Andy Shevchenko



