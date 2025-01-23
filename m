Return-Path: <stable+bounces-110259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41424A1A0FF
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 10:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB0016DE51
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3565320C028;
	Thu, 23 Jan 2025 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NW+aVDJr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D420C492;
	Thu, 23 Jan 2025 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737625330; cv=none; b=nN728u4wrz3iyDhof4mE38OD+5yHHelE7dICiRcUr8IS7LOSyb19JgPBZ9YfnQ0YJzfwRXYL8EmCUdB2RmXscw1nKevvrlT/ycSINcUR0AO3xb3trvIFZWQmFt0GExwxU6G/BcQmKlJLFpNZHrYfYVWYshk5/r5FzcS22hsbUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737625330; c=relaxed/simple;
	bh=YrG2Ji3mQLbKulNePHgsKU4kGwK8BTcBIgjmwTWQVaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lzr29t/Rb4ZCbC6yPgPNXJbFJUum5ldggY03ANNOSFQfYCti6mSBGjujFl6f66zizJGViVpw1Pkeayz9AfZTwAY1ebzCSN9UAPLg32yFF5CQzYwQB0AcC7vJPTWVsYCblf55SZXVU2n21nYkZ3LH8T+9llm9p1NbjoHIR2Dzr48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NW+aVDJr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737625329; x=1769161329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YrG2Ji3mQLbKulNePHgsKU4kGwK8BTcBIgjmwTWQVaA=;
  b=NW+aVDJrglSF4O/MmS1jBftL4f4PPcPpVsBNcTj52u8IkSxSGnOMoOXT
   e1jPHaFMpMxmpsFOAj4e5Y7o5UF/HXkQVj5z4fyE3hpmlYq8foakLg1eG
   45JABLEqLtJEONw0kHZxs8ebgBH5jdYBAVT+lcW6D+5uHn5O8uebpSmXz
   viqVw+1/2AK/NfirAE/RNmv6WOEbW/o9s2LkhVdEAexVn60S8HTApzZYa
   FQWguyJHETK1q6buv/d5YO9vHEW6tnIS3x6af10dm/1O1D3uqtVbMIS3O
   kXT5cFsTB7sYJ+zU5S8OzoYNPyZy3gWEOjqxqThGvF5TnwxRBRCiOpcqU
   w==;
X-CSE-ConnectionGUID: IDtow5M8RBmuzNV1COjfCQ==
X-CSE-MsgGUID: KDVrn5ViTLaKsPZNnngSfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55662645"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="55662645"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 01:42:08 -0800
X-CSE-ConnectionGUID: 9oxn64ksRdubNtzQclsuOQ==
X-CSE-MsgGUID: 9H5eZPi1SmWTleYC98/QGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108281813"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 01:42:05 -0800
Date: Thu, 23 Jan 2025 10:38:37 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND net] ptp: Ensure info->enable callback is always
 set
Message-ID: <Z5IOHVu9L+QpyK4Y@mev-dev.igk.intel.com>
References: <20250123-ptp-enable-v1-1-b015834d3a47@weissschuh.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123-ptp-enable-v1-1-b015834d3a47@weissschuh.net>

On Thu, Jan 23, 2025 at 08:22:40AM +0100, Thomas Weiﬂschuh wrote:
> The ioctl and sysfs handlers unconditionally call the ->enable callback.
> Not all drivers implement that callback, leading to NULL dereferences.
> Example of affected drivers: ptp_s390.c, ptp_vclock.c and ptp_mock.c.
> 
> Instead use a dummy callback if no better was specified by the driver.
> 
> Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  drivers/ptp/ptp_clock.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index b932425ddc6a3789504164a69d1b8eba47da462c..35a5994bf64f6373c08269d63aaeac3f4ab31ff0 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -217,6 +217,11 @@ static int ptp_getcycles64(struct ptp_clock_info *info, struct timespec64 *ts)
>  		return info->gettime64(info, ts);
>  }
>  
> +static int ptp_enable(struct ptp_clock_info *ptp, struct ptp_clock_request *request, int on)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static void ptp_aux_kworker(struct kthread_work *work)
>  {
>  	struct ptp_clock *ptp = container_of(work, struct ptp_clock,
> @@ -294,6 +299,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  			ptp->info->getcrosscycles = ptp->info->getcrosststamp;
>  	}
>  
> +	if (!ptp->info->enable)
> +		ptp->info->enable = ptp_enable;
> +
>  	if (ptp->info->do_aux_work) {
>  		kthread_init_delayed_work(&ptp->aux_work, ptp_aux_kworker);
>  		ptp->kworker = kthread_run_worker(0, "ptp%d", ptp->index);
> 
> ---
> base-commit: c4b9570cfb63501638db720f3bee9f6dfd044b82
> change-id: 20250122-ptp-enable-831339c62428
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

What about other ops, did you check it too? Looks like it isn't needed,
but it sometimes hard to follow.

Thanks

