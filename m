Return-Path: <stable+bounces-42836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9375C8B81B1
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 23:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 926E3B21A1D
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 21:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA3F199EA6;
	Tue, 30 Apr 2024 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6k7oE5g"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB328F6E;
	Tue, 30 Apr 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714510834; cv=none; b=QPLOdS/lDfqbbcHa4THKSjf0Yief875gwvyqz//WzSPM+C9g0mCn2G8K7M7W/VLr1gl7VP9Ms+8prAUZq2C3QwHaTACLJRdCKhje3tLNXFFt5VVJMK3aP4kKBRrxZhu3JtvcAdMtCZMOizG4AgWadwjfdpYvEctm45jig0hzldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714510834; c=relaxed/simple;
	bh=vdWN7QRH0YXJmkbLF+hixAQIFdQAmc9j6LgT2dm/sKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjeEBy5CFP0twHy6Uf/2rrkBwHpxbopBWLT19XAyZ2R6qC7gWBv/sFZUJEFsUgNsxghRpBgwrbWUnk3DRkgNGB6o6hDF4T8Vj4uNoUWccNQDyOsjQnbz8zGsYnq4vG0u546hjbMbdeRg4IrY7ID9GfH4AFZoqTCCZwpUYF+pTwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n6k7oE5g; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714510832; x=1746046832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vdWN7QRH0YXJmkbLF+hixAQIFdQAmc9j6LgT2dm/sKo=;
  b=n6k7oE5g2tjK2//KioIwf4yWL2OZFvI9bbWvTbm0K3jJ3QiKKLq+Xxnd
   m1tBWF0eKCIl1IAo+GZaf54kjgLS9vNy1xTxR7nbQ7Gw/pGI06czCTxYW
   qQByV8/+FrtcNsXEOn5+HhTeC/wNQA1m0xlBzd0W+ekuApu64UcIuH5ub
   OfJktWLFXwTneOqfYasfhyXmeODvpcRDIioTju/Sk1WqTJ5K5nPG6IBP0
   +ZlfdF+AgskIpK5r4yw9RqOla7IWM1e24W7JZvRn2ldGcXRUUNojPg9AB
   og8Tsmn7KdhciXwAUjHX5ZiRJ1hvaL8dYHCoXQM7ciFgbi0BY701UqM+f
   A==;
X-CSE-ConnectionGUID: bRx1AfbcSlmYqZxVeiZfRw==
X-CSE-MsgGUID: etBLuUoXTPqaUC77GrO8bA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="21390712"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="21390712"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 14:00:32 -0700
X-CSE-ConnectionGUID: tpGZ1fq7SomA55V7CuCaRg==
X-CSE-MsgGUID: x0D8q4GfSfmds34g6CSnbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="57474316"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.17.48])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 14:00:32 -0700
Date: Tue, 30 Apr 2024 14:00:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	dave@stgolabs.net, ira.weiny@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cxl/core: correct length of DPA field masks
Message-ID: <ZjFb7p4wn9bcUrzU@aschofie-mobl2>
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>

On Wed, Apr 17, 2024 at 03:50:52PM +0800, Shiyang Ruan wrote:
> The length of Physical Address in General Media Event Record/DRAM Event
> Record is 64-bit, so the field mask should be defined as such length.
> Otherwise, this causes cxl_general_media and cxl_dram tracepoints to
> mask off the upper-32-bits of DPA addresses. The cxl_poison event is
> unaffected.
> 
> If userspace was doing its own DPA-to-HPA translation this could lead to
> incorrect page retirement decisions, but there is no known consumer
> (like rasdaemon) of this event today.
> 
> Fixes: d54a531a430b ("cxl/mem: Trace General Media Event Record")
> Cc: <stable@vger.kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Hi Ruan,

This fixup is important for the Event DPA->HPA translation work, so I
grabbed it, updated it with most* of the review comments, and posted
with that set. I expect you saw that in your mailbox.

DaveJ queued it in a topic branch for 6.10 here:
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.10/dpa-to-hpa

*I did not create a common mask for events and poison because I wanted to
limit the changes. If you'd like to make that change it would be welcomed.

-- Alison

> ---
>  drivers/cxl/core/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index e5f13260fc52..cdfce932d5b1 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -253,7 +253,7 @@ TRACE_EVENT(cxl_generic_event,
>   * DRAM Event Record
>   * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
>   */
> -#define CXL_DPA_FLAGS_MASK			0x3F
> +#define CXL_DPA_FLAGS_MASK			0x3FULL
>  #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
>  
>  #define CXL_DPA_VOLATILE			BIT(0)
> -- 
> 2.34.1
> 

